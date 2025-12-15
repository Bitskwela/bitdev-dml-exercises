# Le 22: Stashing Work

![Git Stash](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-stash.png)

## Background Story

Maria is deep in her voter analytics feature. Files are modified. New code is half-written. Nothing is ready to commit yet.

Her phone rings. It's Marco: "Emergency. Production bug. Need you to review the hotfix now."

Maria panics. "I can't switch branches! I have uncommitted changes. If I switch, I'll lose my work. But if I commit now, I'll commit broken code."

Marco teaches her the stash: "Stash temporarily saves your uncommitted work. You can switch branches, do the review, then come back and restore your work exactly as it was."

```bash
git stash
# Work disappears (safely stored)

git checkout main
# Review the hotfix
git checkout feature/voter-analytics

git stash pop
# Work reappears exactly as before
```

Maria's half-written code is back. The review is done. No broken commits. Stash is the "pause button" for Git.

**Time Allotment**: 35 minutes

**Topics Covered**:

- What stash does
- Basic stash workflow
- Stash with messages
- Multiple stashes
- Stash apply vs stash pop
- When to use stash

---

## What is Stash?

Stash temporarily saves uncommitted changes (both staged and unstaged) and gives you a clean working directory.

```bash
# You have uncommitted changes
git status
# modified: voter.js
# modified: analytics.js

# Stash them
git stash

# Now your working directory is clean
git status
# nothing to commit, working tree clean

# Your changes are safely stored
git stash list
# stash@{0}: WIP on feature/analytics: a1b2c3d Last commit message
```

## Basic Stash Workflow

```bash
# Step 1: Stash your work
git stash

# Step 2: Do whatever you need (switch branches, pull, etc.)
git checkout main
git pull
# Review something
# Fix something

# Step 3: Go back to your branch
git checkout feature/voter-analytics

# Step 4: Restore your stashed work
git stash pop
```

## Stash with a Message

Give your stash a description:

```bash
git stash push -m "WIP: voter chart halfway done"

git stash list
# stash@{0}: On feature/analytics: WIP: voter chart halfway done
```

Much clearer than the default message!

## Multiple Stashes

You can have multiple stashes:

```bash
# First stash
git stash push -m "Analytics work"

# Later, another stash
git stash push -m "Different unfinished work"

# List all stashes
git stash list
# stash@{0}: On feature/B: Different unfinished work
# stash@{1}: On feature/A: Analytics work

# Apply specific stash
git stash apply stash@{1}
```

## Stash Apply vs Stash Pop

| Command           | What It Does     | Keeps Stash?            |
| ----------------- | ---------------- | ----------------------- |
| `git stash apply` | Restores changes | ✅ Yes, stash remains   |
| `git stash pop`   | Restores changes | ❌ No, stash is deleted |

```bash
# Apply keeps the stash (can reuse)
git stash apply
git stash list
# stash@{0} still there

# Pop removes the stash
git stash pop
git stash list
# (empty)
```

## Stashing Specific Files

```bash
# Stash only specific files
git stash push -m "Just voter.js" voter.js analytics.js

# Stash only staged changes
git stash push --staged -m "Only staged files"

# Stash including untracked files
git stash push -u -m "Including new files"
```

## Viewing Stash Contents

```bash
# See what's in a stash
git stash show
# voter.js | 15 ++++++++
# analytics.js | 8 ++++

# See the actual diff
git stash show -p
# (shows full diff)
```

## Real-World Scenario: Maria's Emergency Review

```bash
# 2:00 PM - Maria is coding analytics
git status
# modified: src/analytics.js (halfway done)
# modified: src/voter.js (experimental changes)

# 2:05 PM - Marco calls: "Review needed urgently!"

# Maria stashes her work
git stash push -m "Analytics WIP - chart rendering"
# Working directory clean

# Switches to review the hotfix
git checkout main
git pull origin main
git checkout hotfix/security-patch
# Reviews code, approves

# 2:30 PM - Review done, back to work
git checkout feature/voter-analytics
git stash pop
# Her analytics code is back exactly as she left it

git status
# modified: src/analytics.js (still halfway done)
# modified: src/voter.js (experimental changes still there)
```

## Dropping Stashes

```bash
# Drop specific stash
git stash drop stash@{0}

# Clear all stashes
git stash clear
# WARNING: This deletes all stashes permanently
```

## When to Use Stash

| Situation                                     | Use Stash?        |
| --------------------------------------------- | ----------------- |
| Need to switch branches with uncommitted work | ✅ Yes            |
| Work not ready to commit                      | ✅ Yes            |
| Quick context switch, will return soon        | ✅ Yes            |
| Work is complete and should be saved          | ❌ Commit instead |
| Storing work for days/weeks                   | ❌ Branch instead |

## Stash vs Commit vs Branch

| Need                                 | Solution |
| ------------------------------------ | -------- |
| Quick pause, return in minutes/hours | Stash    |
| Checkpoint with clear message        | Commit   |
| Long-term work storage               | Branch   |
| Experimental work                    | Branch   |

## Why This Matters for Global Deployment

Global teams have constant interruptions:

- Singapore reports bug during Manila's feature work
- London needs review during Cebu's development
- Production issues don't wait for convenient times

Stash lets developers:

1. Pause current work instantly
2. Handle the interruption
3. Return exactly where they were
4. Never commit broken/incomplete code

```bash
# The professional's emergency response
git stash push -m "WIP: will return after emergency"
# Handle emergency
git stash pop
# Continue like nothing happened
```

## Common Stash Mistakes

### Mistake 1: Forgetting about stashes

```bash
git stash list
# stash@{0}: Old stash from 3 months ago
# (Clean up old stashes regularly)
```

### Mistake 2: Stashing instead of committing

```bash
# If work is complete, commit it!
git commit -m "Complete feature"
# Don't stash finished work
```

### Mistake 3: Losing track of which stash is which

```bash
# Always use descriptive messages
git stash push -m "Payment form validation WIP"
# Not just: git stash
```

## Key Takeaways

✓ Stash temporarily saves uncommitted changes
✓ Use when you need to switch context quickly
✓ `git stash push -m "message"` for clear descriptions
✓ `git stash pop` restores and removes stash
✓ `git stash apply` restores but keeps stash
✓ Multiple stashes are possible—keep them organized
✓ Stash is for short-term pauses; branch for long-term work
✓ Essential for handling interruptions in global teams

**Next Lesson:** Reflog—your safety net for recovering lost commits.
