# Undoing Changes Activity

## Initial Scenario

Maria's team is moving fast, but mistakes happen. Someone just committed a breaking change. Another developer staged the wrong file for commit. A third made local changes they want to discard. Git provides three different undo strategies, and knowing when to use each one is critical for maintaining a healthy project history.

**Time Allotment: 30 minutes**

---

## Tasks for Learners

### Task 1: Undo Uncommitted Changes (git restore)

Create a scenario where you modify files but haven't committed yet:

```bash
# Start with a clean repository
echo "def process_payment(amount): return amount" > payment.py
git add payment.py
git commit -m "Add payment processor"

# Make changes you want to undo
echo "def process_payment(amount): return amount * 2 # WRONG" > payment.py
echo "def log_transaction(id): broken code" > logger.py
git add logger.py

# Check what you have
git status

# Undo the uncommitted change in payment.py (not staged)
git restore payment.py

# Unstage logger.py
git restore --staged logger.py

# Verify
git status
```

**Expected Output After restore**:

```
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   logger.py

nothing added to commit but untracked files exist
```

**What Happened**:

- `git restore payment.py` discarded changes in the working directory
- `git restore --staged logger.py` removed it from staging area
- The file still exists, but changes are gone

---

### Task 2: Undo Staged Changes (git reset)

Create scenario with staged but not committed changes:

```bash
# Create and stage changes
echo "def get_user(id): return {'id': id}" > user.py
git add user.py
echo "def get_user(id): return {'id': id, 'admin': True} # INSECURE!" >> user.py
git add user.py

# Check staging
git status

# Undo the staged change (local-only, hasn't been pushed)
git reset HEAD user.py

# Check result
git status
git diff user.py
```

**Key Understanding**:

- `git reset HEAD <file>` removes file from staging but keeps your changes in working directory
- Safe because you haven't committed yet (local only)
- Gives you chance to fix before committing

---

### Task 3: Undo a Local Commit (git reset hard)

For commits not yet pushed:

```bash
# Make a bad local commit
echo "def delete_all_votes(): return None" > voting.py
git add voting.py
git commit -m "Add dangerous function"

# Check log
git log --oneline

# Undo the commit completely (only safe if NOT pushed)
git reset --hard HEAD~1

# Verify commit is gone
git log --oneline
git diff
```

**Expected Output**:

```
The commit disappears and the file is reverted
```

**⚠️ WARNING**: `git reset --hard` is destructive. Only use if:

- The commit hasn't been pushed
- You haven't shared it with teammates
- You're absolutely sure you want to discard those changes

---

### Task 4: Undo a Pushed Commit (git revert)

For commits already pushed to shared repository:

```bash
# Simulate a pushed commit in history
echo "def process_vote(candidate): return candidate.votes += 1000" > voting.py
git add voting.py
git commit -m "Give each vote value of 1000 - WRONG!"

# Get the commit hash
git log --oneline

# REVERT (don't reset) - create new commit that undoes the change
git revert HEAD

# When prompted, accept the default message or edit it
# Git will show:
# [main abc1234] Revert "Give each vote value of 1000 - WRONG!"

# Check the history
git log --oneline
```

**Expected Output**:

```
abc1234 Revert "Give each vote value of 1000 - WRONG!"
def5678 Give each vote value of 1000 - WRONG!
...rest of history...
```

**Key Difference from reset**:

- `git reset` rewrites history (dangerous on shared branches)
- `git revert` creates a NEW commit that undoes the change
- Revert preserves the history of what happened
- Safe for pushed commits because other developers can see what you did

---

### Task 5: Recover a Lost Commit with reflog

Sometimes you realize too late that you made a mistake:

```bash
# Accidentally do a hard reset on pushed commits (this is bad!)
git reset --hard HEAD~2

# Panic! But Git keeps a log of all HEAD positions
git reflog

# Expected output shows every commit HEAD pointed to:
# abc1234 HEAD@{0}: reset: moving to HEAD~2
# def5678 HEAD@{1}: commit: Add voting feature
# ghi9012 HEAD@{2}: commit: Fix logging
# ...

# Recover by moving HEAD back to the lost commit
git reset --hard abc1234

# Your lost commits are restored!
```

**How reflog Saves You**:

- Git keeps a log of every place HEAD has pointed to
- Even if you reset hard, reflog remembers where things were
- Use `git reflog` to find lost commits
- Use `git reset --hard <hash>` to recover them

---

## Breakdown of the Activity

### The Three Undo Strategies

| Situation                      | Strategy      | Command                              | Safety                    |
| ------------------------------ | ------------- | ------------------------------------ | ------------------------- |
| Haven't staged yet             | restore       | `git restore <file>`                 | Very Safe                 |
| Staged, not committed          | restore/reset | `git restore --staged <file>`        | Very Safe                 |
| Committed locally (not pushed) | reset         | `git reset --hard HEAD~1`            | Safe if local             |
| Committed and pushed           | revert        | `git revert HEAD`                    | Safe (creates new commit) |
| Lost commits                   | reflog        | `git reflog` then `git reset --hard` | Use to recover            |

### Why the Distinction Matters

**For Local Changes Only** (`git restore`, `git reset`):

- You're the only one with these commits
- Rewriting history doesn't affect teammates
- Fast and clean

**For Shared Commits** (`git revert`):

- Other developers have your commits
- Resetting would break their copies
- Revert creates a new "undo commit" that everyone can pull
- Preserves history (important for auditing)

### Real-World Scenarios

1. **"I made a typo in my work-in-progress"**: Use `git restore`
2. **"I staged the wrong file"**: Use `git restore --staged`
3. **"I committed the wrong change locally"**: Use `git reset --hard` (only if unpushed)
4. **"My commit broke production and it's already on main"**: Use `git revert` (creates undo commit)
5. **"I hard-reset and lost my commits"**: Use `git reflog` to recover

### Key Concepts

- **Working Directory**: Your actual files on disk
- **Staging Area**: Changes ready to be committed
- **Local Commits**: Commits not yet pushed
- **Shared Commits**: Commits pushed to team repository
- **Rewriting History**: Using reset (only safe locally)
- **Preserving History**: Using revert (safe for shared branches)
- **Reflog**: Reference log of HEAD movements (recovery tool)

---

## Closing

You now know how to safely undo changes at every stage:

✓ Undo uncommitted changes with `git restore`
✓ Unstage files with `git restore --staged`
✓ Undo local commits with `git reset` (carefully!)
✓ Undo shared commits with `git revert` (the safe way)
✓ Recover lost commits with `git reflog`

This knowledge is essential for working on a team. The key rule: **Always use `git revert` for shared branches, `git reset` only for local changes.**

You've now completed the Git Foundations arc! You can create repositories, make commits, view history, and undo mistakes safely. In the next arc, you'll learn the real power of Git: **branching**, which enables your entire team to work in parallel without stepping on each other's toes.

**Next Lesson Preview**: Understanding Branches – Learn how Git's branching model lets multiple developers work simultaneously on different features without conflict.

✓ Discovered why revert is mandatory for shared repos
✓ Practiced thinking about global team impacts
✓ Learned recovery with reflog as a safety net

**Next:** Now that you can work safely with commits, it's time to explore **branches**—the feature that lets multiple teammates work on different features at the same time without stepping on each other's toes.

- [ ] You can explain the concept

---

**Check the answer file (`act_1.answer.sh`) if you get stuck!**
