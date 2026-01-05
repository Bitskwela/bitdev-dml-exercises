# Le 05: Undoing Changes

![Safe Undo Strategies](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-undo.png)

## Background Story

**11 PM in Manila. Maria is excited about an idea.**

A new voter privacy feature. She's been thinking about it all week. Tonight, she decides to implement it quickly. "Just one hour," she tells herself.

At 11:47 PM, she commits her code: "Add voter privacy protection."

At midnight, she pushes to GitHub.

At 12:15 AM, her phone buzzes. A message from Dev Sam in Cebu, who's just logging in: "Maria... something broke. The entire voting system is inaccessible. Administrators can't see the voter list. Did you change the permissions?"

Maria's heart stops. She reads her own code. Her eyes widen. A simple mistake—she changed `voter_list` permission from public to private for everyone, not just the privacy-protected feature. She broke the whole system at the global level.

"Marco!" she messages in panic. "I pushed bad code! Everything's down!"

Marco replies immediately, but not with panic. With calm: "This is exactly why Git is our safety net. You made a mistake. Now you'll learn how to fix it without losing anything."

He guides her: "We have multiple ways to undo. We can revert your commit, which creates a new commit that undoes your changes. Or we can reset to before your change. Both preserve history. Neither loses data. You're not in danger. This is recoverable."

**This lesson teaches that in Git, mistakes are not disasters. They're opportunities to learn version control's most powerful feature: safe recovery.**

**Time Allotment**: 45 minutes

**Topics Covered**:

- Three undo strategies: restore, reset, revert
- When to use each strategy
- Staging area safety
- Commit message do-overs
- Recovering lost commits with reflog
- Best practices for undo in team environments

---

## The Undo Safety Net

Git's philosophy: **never lose data**. Every change you've made in Git is recoverable. But there are different ways to undo depending on your situation:

1. **Changes in working directory** (not staged) → Use `git restore`
2. **Changes in staging area** → Use `git restore --staged`
3. **Changes already committed** → Use `git revert` or `git reset`
4. **Changes already pushed** → Use `git revert` (safe for teams)

Think of it like this:

- **Working directory** = Your desk (changes haven't been finalized)
- **Staging area** = Your draft folder (organized but not official)
- **Commits** = Your filing cabinet (permanent records)
- **Pushed commits** = Shared documents (everyone's seen them)

Each level requires a different approach to undo safely.

## Undo 1: Restore Working Directory Changes

You've modified code but haven't staged it yet. You realize the changes are wrong:

```bash
# Discard changes in one file
git restore voting.js

# Discard changes in all files
git restore .

# See what will be discarded first
git status
```

**Warning:** This is destructive. You'll lose the work. Use only if you're absolutely sure.

**Maria's Scenario:**

```bash
git restore voting.js  # Throws away her mistake, gets back the working version
```

This is the safest undo because she hasn't committed anything yet. The old version is still in Git.

## Undo 2: Unstage Changes

Changes are staged but not committed:

```bash
# Remove file from staging area (but keep changes in working directory)
git restore --staged voting.js

# Then either commit or discard them
git restore voting.js  # Discard completely
```

This is useful when you staged the wrong thing:

```bash
git add voting.js permission.js
git status
# Oops, I staged too much!

git restore --staged permission.js
# Now only voting.js is staged
git commit -m "Fix voting validation only"
```

## Undo 3: Revert a Committed Change

You've already committed, and everyone can see it. The safe approach for teams: `git revert`.

`git revert` creates a **new commit** that undoes the changes from an old commit. It doesn't delete history; it adds to it.

```bash
# Undo the specific commit that broke things
git revert abc1234

# This opens an editor to write a revert commit message
# Git automatically creates a message like:
# "Revert 'Add permission validation'"
```

**Example:**

```
Commit c3f5z12: "Add permission validation" - BROKEN
Commit d7g8k44: "Revert 'Add permission validation'" - FIXES IT

History shows both—transparency and safety.
```

**For Maria's Global Team:**

- Developer in Manila sees the history: "Oh, Maria reverted commit abc1234. Let me see what went wrong."
- Developer in Singapore can run `git show abc1234` to understand the issue
- No confusion; no history rewriting

## Undo 4: Reset (History Rewriting)

`git reset` is powerful but should only be used locally, never after pushing to a shared repository.

```bash
# Soft reset: undo commit, keep changes staged
git reset --soft HEAD~1

# Mixed reset: undo commit, keep changes in working directory
git reset --mixed HEAD~1

# Hard reset: completely undo, lose changes (dangerous!)
git reset --hard HEAD~1
```

**Use Cases:**

- **Soft reset:** "I committed too early, let me add more changes before re-committing"
- **Mixed reset:** "I committed the wrong files; let me reorganize"
- **Hard reset:** "Local development disaster, start over"

**CRITICAL:** Never use `git reset` on commits already pushed to a shared repository. Teammates will have conflicts.

## Undo 5: For Pushed Commits - Always Use Revert

Once you've pushed to a shared repository (especially production), `git revert` is your only safe option:

```bash
# Production is down because of commit abc1234
git revert abc1234

# Now force push to production (after testing locally first!)
git push origin main

# Teammates pull, and they get the revert commit
```

This creates clear, auditable history. Everyone knows:

- When the bug was introduced
- When it was fixed
- What the fix was

## Real-World: Maria's 2 AM Crisis

**Timeline:**

1. **11:45 PM:** Maria commits bad validation code (commit `abc1234`)
2. **11:50 PM:** She pushes to main branch (shared)
3. **11:55 PM:** Singapore developer runs morning build, everything breaks
4. **12:00 AM:** Singapore dev contacts Manila team
5. **12:05 AM:** Maria realizes the error

**Maria's Recovery (the safe way):**

```bash
# She can't use git reset (already pushed)
# She uses git revert instead

git revert abc1234  # Creates new commit that undoes the bad one

# Fix the actual bug in a new commit
git commit -m "Fix: restore permission validation properly"

# Push the fix
git push origin main

# Singapore dev pulls and production is restored
```

**The key:** History is clean. No rewrites. No confused teammates.

## When to Use What

| Situation                   | Command                | When It's Safe              |
| --------------------------- | ---------------------- | --------------------------- |
| Haven't staged yet          | `git restore`          | Always (local only)         |
| Staged wrong files          | `git restore --staged` | Always (local only)         |
| Committed locally only      | `git reset`            | Only locally                |
| Committed and pushed        | `git revert`           | Always (safe for teams)     |
| Need to recover lost commit | `git reflog`           | Always (everything's there) |

## The Git Reflog: Your Time Machine

Even if you completely botch a reset and think you've lost everything:

```bash
# See everything you've done recently
git reflog

# It shows something like:
# abc1234 HEAD@{0}: commit: Add feature X
# def5678 HEAD@{1}: reset: back to commit Y
# ghi9012 HEAD@{2}: revert: Undo bad code

# You can reset to ANY of these
git reset --hard abc1234
```

`reflog` shows the last 90 days of every reference change. It's your safety net under the safety net.

## Why This Matters for Global Deployment

**The scenario:** You deploy Barangay Blockchain to London at 9 AM Manila time. Singapore dev pulls at 6 PM their time. In the 9 hours between, you discovered a critical bug and fixed it.

**With proper undo:**

- You don't rewrite history (which would confuse Singapore dev)
- You create a revert commit (clear documentation)
- Singapore dev pulls and gets both the bad commit AND the fix
- They understand exactly what happened
- No confusion about different versions

**Without proper undo:**

- You might use `git reset` and force-push (breaking Singapore dev's local work)
- Or you might panic and manually edit files (no Git history of fixes)
- International team is now out of sync and frustrated

## Key Takeaways

✓ Git never deletes your work; it gives you time to undo
✓ Different undos for different situations (restore, reset, revert)
✓ For shared repos, always use `git revert` (safe, auditable)
✓ Local mistakes can use `git reset` (faster, cleaner history)
✓ `reflog` is your emergency backup for recovery
✓ Mistakes are learning opportunities, not disasters

**Next Lesson:** Now that Maria can confidently commit and undo, let's explore **branches**. Branches let teams work on different features simultaneously without interfering with each other—the foundation of large-team distributed development.

```bash
# Example Git commands
```

### Summary

This lesson covers Undoing Changes in detail.

---

**Ready for the activity? Let's get started!**
