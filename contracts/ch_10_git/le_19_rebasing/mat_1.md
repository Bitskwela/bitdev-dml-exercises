# Le 19: Rebasing Commits

![Git Rebase](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-rebase.png)

## Scene: History Matters

**One week into the `feature/voter-analytics` project. Maria has been coding for three days.**

She has seven commits on her feature branch. But something is bothering her.

She runs `git log --oneline`:

```
a1b2c3d WIP
c4d5e6f Fix typo
g7h8i9j More analytics work
k1l2m3n Started analytics
```

"This is messy," she mutters. Meanwhile, on main, the team has been productive:

```
x9y8z7w (main) Performance fix (London)
q6r5s4t Security update (Dev Sam)
```

Now Maria's analytics branch is _behind_ main. When she merges, her seven commits will be tangled with main's commits. The git log will look chaotic.

Marco arrives with advice: "You need rebasing. Two reasons: (1) move your commits on top of latest main, (2) clean up your commit history before merging."

He shows her the power: rebase takes her seven messy commits and replays them on top of main's latest work. Her commits stay the same code changes, but they're now based on current main. And if she cleans them up first, she can have one professional commit instead of seven "WIP" and "Fix typo" messages.

"After rebasing," Marco says, "your history tells a clear story. Not 'I made a mess and fixed typos'—but 'I implemented voter analytics cleanly.'"

Maria realizes: **In distributed teams, clear history matters as much as clean code.**

**Time Allotment**: 50 minutes

**Topics Covered**:

- What rebasing is and how it differs from merging
- Basic rebase workflow
- Rebasing onto updated main
- When to rebase vs when to merge
- Rebase safety rules

---

## Rebase vs Merge: The Key Difference

Both rebase and merge integrate changes. They do it differently.

### Merge: Preserves History

```
Before merge:
main:     A → B → C
feature:  A → B → D → E

After merge:
main:     A → B → C → M (merge commit)
               ↘   ↗
feature:        D → E
```

Merge creates a merge commit. The branching history is visible forever.

### Rebase: Rewrites History

```
Before rebase:
main:     A → B → C
feature:  A → B → D → E

After rebase:
main:     A → B → C
feature:  A → B → C → D' → E'
                      (D and E replayed on top of C)
```

Rebase _moves_ your commits to a new base. It's like saying "pretend I started from the latest main."

## Basic Rebase Workflow

```bash
# You're on feature branch, main has new commits
git checkout feature/voter-analytics

# Rebase onto latest main
git rebase main

# Your commits are replayed on top of main
# Now your branch includes all of main's changes
```

## Rebasing Onto Updated Main

Common scenario: main has moved while you were working.

```bash
# Step 1: Make sure you have latest main
git fetch origin
git checkout main
git pull origin main

# Step 2: Switch to your feature branch
git checkout feature/voter-analytics

# Step 3: Rebase onto main
git rebase main

# Step 4: If conflicts, resolve them
# (Git will pause and ask you to fix conflicts)
# Fix the file, then:
git add conflicted-file.js
git rebase --continue

# Step 5: Force push (because you rewrote history)
git push --force-with-lease origin feature/voter-analytics
```

## Handling Rebase Conflicts

During rebase, you might hit conflicts:

```bash
$ git rebase main
Applying: Started analytics
CONFLICT (content): Merge conflict in voter.js
error: could not apply k1l2m3n... Started analytics
```

Git is replaying your commits one by one. When a commit conflicts:

```bash
# Fix the conflict
nano voter.js

# Mark as resolved
git add voter.js

# Continue rebasing
git rebase --continue

# Git applies remaining commits
# Repeat if more conflicts
```

To abort and go back to before the rebase:

```bash
git rebase --abort
```

## When to Rebase vs Merge

| Situation                         | Use Rebase    | Use Merge |
| --------------------------------- | ------------- | --------- |
| Updating feature branch with main | ✅ Yes        | ⚠️ Okay   |
| Cleaning up messy commits         | ✅ Yes        | ❌ No     |
| After push to shared branch       | ❌ No         | ✅ Yes    |
| Main branch integration           | ❌ Usually no | ✅ Yes    |

**The Golden Rule**: Never rebase commits that others have based work on. Rebasing rewrites history—if someone else has your commits, you'll cause chaos.

## Safe Rebasing: The Rule

```bash
# SAFE: Rebase your own unpushed commits
git rebase main  # Fine if you haven't pushed

# SAFE: Rebase your own feature branch (coordinate with team)
git rebase main
git push --force-with-lease origin feature/my-branch

# DANGEROUS: Rebase shared branch like main
git checkout main
git rebase feature/something  # NEVER DO THIS
```

## Why This Matters for Global Deployment

Clean history helps global teams understand changes.

**Without rebase**:

```
$ git log --oneline
* Merge branch 'feature/analytics'
|\
| * WIP
| * fix typo
| * more work
|/
* Merge branch 'feature/security'
...
(Messy, hard to understand)
```

**With rebase**:

```
$ git log --oneline
* Add voter analytics with real-time dashboard
* Security: Add input validation (Dev Sam)
* Performance: Optimize query (London)
...
(Clean, each commit tells a clear story)
```

When Singapore investigates a production issue at 2 AM, they need clear history.

## Key Takeaways

✓ Rebase moves commits to a new base point
✓ Unlike merge, rebase rewrites history (no merge commit)
✓ Use rebase to update feature branches with latest main
✓ Never rebase commits others have based work on
✓ `git rebase --continue` after fixing conflicts
✓ `git push --force-with-lease` after rebasing pushed branches
✓ Clean history helps global teams understand changes

**Next Lesson:** Interactive rebase—even more control over your commit history.
