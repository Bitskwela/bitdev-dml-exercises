# Le 23: Reflog & Recovery

![Git Reflog](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-reflog.png)

## Scene: Disaster Recovery

**Tuesday 3 PM. Maria sits in panic.**

She just ran a command she wasn't entirely sure about:

```bash
git reset --hard HEAD~5
```

Five commits vanished. Five days of analytics work. Gone.

She stares at her empty working directory. The terminal shows a clean status. No uncommitted changes. No trace of the work.

"It's gone," she whispers. "Five days of work. Lost."

She calls Dev Sam in Cebu, her voice shaking.

"Did you push those commits?" he asks calmly.

"No. They were only on my laptop."

"Then they're not lost," Dev Sam says. "Git almost never truly deletes anything. There's a safety feature called the reflog. Every time HEAD moves—every commit, checkout, reset—Git records it. Your 'deleted' commits are still there, just hidden."

He guides her:

```bash
git reflog
```

Her terminal shows a complete history of her HEAD movements:

```
a1b2c3d HEAD@{0}: reset: moving to HEAD~5
e4f5g6h HEAD@{1}: commit: Add analytics dashboard
i7j8k9l HEAD@{2}: commit: Add chart rendering
```

There it is. The commit before her mistake. All five days of work, recorded in Git's memory.

```bash
git reset --hard e4f5g6h
```

Within seconds, her work is restored. All five days. Intact. Untouched.

Maria learned something profound: in Git, very little is truly lost. The reflog is a time machine. The safety net you didn't know you needed.

**This lesson teaches resilience. Mistakes are recoverable. Git keeps a record of almost everything.**

**Time Allotment**: 45 minutes

**Topics Covered**:

- What the reflog is
- Reading reflog output
- Recovering from mistakes
- Common recovery scenarios
- Reflog expiration
- When reflog can't help

---

## What is the Reflog?

The reflog (reference log) records every time HEAD changes position. Every commit, checkout, reset, rebase, merge—it's all logged.

```bash
git reflog
# Output:
# a1b2c3d HEAD@{0}: reset: moving to HEAD~5
# e4f5g6h HEAD@{1}: commit: Add analytics dashboard
# i7j8k9l HEAD@{2}: commit: Add chart rendering
# m1n2o3p HEAD@{3}: commit: Add data processing
# q4r5s6t HEAD@{4}: commit: Add API integration
# u7v8w9x HEAD@{5}: commit: Start analytics feature
```

Even though Maria reset HEAD~5, the reflog shows where HEAD was before. Those commits still exist!

## Reflog Output Explained

```
a1b2c3d HEAD@{0}: reset: moving to HEAD~5
   │       │           └── What happened
   │       └── Reference (HEAD 0 moves ago)
   └── Commit hash
```

- `HEAD@{0}` = Current HEAD
- `HEAD@{1}` = HEAD one move ago
- `HEAD@{5}` = HEAD five moves ago

## Recovering Lost Commits

Maria's recovery:

```bash
# Step 1: Find the commit in reflog
git reflog
# e4f5g6h HEAD@{1}: commit: Add analytics dashboard
# ↑ This is her latest good commit

# Step 2: Reset to that commit
git reset --hard e4f5g6h

# Step 3: Verify recovery
git log --oneline -5
# e4f5g6h Add analytics dashboard
# i7j8k9l Add chart rendering
# m1n2o3p Add data processing
# q4r5s6t Add API integration
# u7v8w9x Start analytics feature

# All commits restored!
```

## Common Recovery Scenarios

### Scenario 1: Accidental Hard Reset

```bash
# Mistake
git reset --hard HEAD~3
# "Oh no, I didn't mean to do that!"

# Recovery
git reflog
# Find the commit before the reset
git reset --hard HEAD@{1}
# Restored!
```

### Scenario 2: Deleted Branch

```bash
# Mistake
git branch -D feature/important-work
# "Wait, that had uncommitted... I mean, unmerged work!"

# Recovery
git reflog
# e4f5g6h HEAD@{3}: commit: Important work
git checkout -b feature/important-work e4f5g6h
# Branch recreated with the work!
```

### Scenario 3: Bad Rebase

```bash
# Mistake
git rebase -i HEAD~10
# Made a mess, lost commits

# Recovery
git reflog
# Find the state before rebase
git reset --hard HEAD@{15}
# Back to before the rebase!
```

### Scenario 4: Recover After Merge Gone Wrong

```bash
# Mistake
git merge feature/broken --no-ff
# "That merge broke everything!"

# Recovery
git reflog
# a1b2c3d HEAD@{0}: merge feature/broken
# e4f5g6h HEAD@{1}: commit: Last good state
git reset --hard HEAD@{1}
# Merge undone!
```

## Reading Reflog Like a Timeline

```bash
git reflog --date=relative
# a1b2c3d HEAD@{5 minutes ago}: reset: moving to HEAD~5
# e4f5g6h HEAD@{10 minutes ago}: commit: Add dashboard
# i7j8k9l HEAD@{2 hours ago}: commit: Add charts
```

Now you can see when things happened, making it easier to find the right recovery point.

## Creating Recovery Branches

Instead of resetting, create a branch for investigation:

```bash
# Find lost commit
git reflog
# e4f5g6h HEAD@{5}: commit: Lost work

# Create branch pointing to it
git branch recovery-branch e4f5g6h

# Check it out safely
git checkout recovery-branch

# Verify it's what you need, then merge if correct
```

## Why This Matters for Global Deployment

Dev Sam in Cebu makes a mistake at 11 PM. He's tired. He force pushed to the wrong branch. Panic.

**Without reflog knowledge**: "I need to tell everyone. Reconstruct from memory. Work is lost."

**With reflog knowledge**:

```bash
git reflog
git reset --hard HEAD@{1}
git push --force-with-lease origin feature/payment
# Fixed in 2 minutes. Nobody noticed.
```

The reflog is the "undo history" that Git doesn't advertise but always keeps.

## Reflog Expiration

Reflog entries don't last forever:

- **Reachable commits**: 90 days by default
- **Unreachable commits**: 30 days by default

After expiration, Git garbage collection may remove unreferenced commits.

```bash
# Check reflog expiry settings
git config gc.reflogExpire
git config gc.reflogExpireUnreachable

# View full reflog with expiry info
git reflog show --all
```

## When Reflog Can't Help

The reflog has limits:

1. **Never committed changes**: If you never committed, reflog can't help. The changes only existed in your working directory.

2. **Expired entries**: After 30-90 days (depending on settings), old entries are pruned.

3. **After `git gc --prune=now`**: Aggressive garbage collection removes unreferenced objects.

4. **Remote repositories**: Reflog is local. It doesn't exist on GitHub.

## Pro Tips

```bash
# Before risky operations, note your current HEAD
git rev-parse HEAD
# a1b2c3d
# (Write this down or copy to clipboard)

# If something goes wrong
git reset --hard a1b2c3d
# Instant recovery, no reflog hunting needed
```

## Key Takeaways

✓ Reflog records every HEAD movement
✓ Commits are rarely truly deleted—just hidden
✓ `git reflog` shows recent HEAD positions
✓ `git reset --hard <hash>` recovers to any reflog entry
✓ Create branches from reflog entries for safe investigation
✓ Reflog entries expire (30-90 days by default)
✓ Reflog is local—doesn't exist on remote
✓ Before risky operations, note your current HEAD hash

**Next Lesson:** Advanced workflow strategies—putting all your Git skills together.
