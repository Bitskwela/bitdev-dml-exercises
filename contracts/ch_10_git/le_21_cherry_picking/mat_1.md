# Le 21: Cherry-Picking Commits

![Git Cherry Pick](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-cherry-pick.png)

## Background Story

Friday afternoon emergency. The Barangay Blockchain is live in production. Singapore reports a critical bug: voters can vote twice under specific conditions.

Dev Sam investigates. He finds the bug. He fixes it in his `feature/payment-refactor` branch with commit `a1b2c3d`. But that branch has 30 other commits—refactoring work that's not ready for production.

"I can't merge my entire branch," Dev Sam says. "The refactoring will break things. I just need THIS one commit in production."

Marco introduces cherry-pick: "Cherry-pick lets you copy a specific commit from one branch to another. You take just the fix, not the whole branch."

```bash
git checkout main
git cherry-pick a1b2c3d
```

Done. The fix is now on main. Production is patched. The refactoring stays in the feature branch, untouched.

Cherry-pick is surgical Git—extract exactly what you need.

**Time Allotment**: 40 minutes

**Topics Covered**:

- What cherry-pick does
- When to use cherry-pick
- Cherry-pick workflow
- Handling cherry-pick conflicts
- Cherry-pick vs merge/rebase

---

## What is Cherry-Pick?

Cherry-pick copies a specific commit from one branch to another. It doesn't merge branches—it copies one commit.

```
Before cherry-pick:
main:     A → B → C
feature:  A → B → D → E → F (you want E)

After cherry-pick:
main:     A → B → C → E' (copy of E)
feature:  A → B → D → E → F (unchanged)
```

The commit `E'` on main is a copy of `E` from feature. Same changes, new commit hash.

## Basic Cherry-Pick

```bash
# Find the commit hash you want
git log feature/payment-refactor --oneline
# a1b2c3d Fix duplicate voting bug  ← This one
# d4e5f6g Refactor payment module
# ...

# Switch to destination branch
git checkout main

# Cherry-pick the commit
git cherry-pick a1b2c3d

# Done! The fix is now on main
git log --oneline -3
# x9y8z7w Fix duplicate voting bug  ← New commit (copy)
# previous main commits...
```

## Real-World Scenario: Production Hotfix

The Barangay Blockchain team's production hotfix workflow:

```bash
# 1. Singapore reports bug at 2 PM Singapore time
# 2. Dev Sam finds and fixes it on his feature branch
# 3. The fix is commit a1b2c3d

# 4. Maria (on-call in Manila) cherry-picks to main
git checkout main
git pull origin main
git cherry-pick a1b2c3d
git push origin main

# 5. CI/CD deploys to production
# 6. Singapore confirms fix works
# 7. Dev Sam continues his feature work (unchanged)
```

Total time: 15 minutes from report to fix in production.

## Cherry-Picking Multiple Commits

```bash
# Cherry-pick a range of commits
git cherry-pick a1b2c3d^..e4f5g6h

# Cherry-pick multiple specific commits
git cherry-pick a1b2c3d c4d5e6f g7h8i9j
```

## Handling Cherry-Pick Conflicts

Sometimes the commit conflicts with the destination branch:

```bash
$ git cherry-pick a1b2c3d
error: could not apply a1b2c3d... Fix duplicate voting
hint: After resolving the conflicts, mark them with
hint: "git add <pathspec>" and run "git cherry-pick --continue".
```

Resolve like any merge conflict:

```bash
# Fix the conflict
nano voter.js

# Mark resolved
git add voter.js

# Continue cherry-pick
git cherry-pick --continue

# Or abort
git cherry-pick --abort
```

## When to Use Cherry-Pick

| Situation                                 | Use Cherry-Pick?    |
| ----------------------------------------- | ------------------- |
| Hotfix needed in production               | ✅ Yes              |
| Backport fix to release branch            | ✅ Yes              |
| Copy specific feature to another branch   | ✅ Yes              |
| Regularly moving commits between branches | ❌ Use merge/rebase |
| Entire branch ready to integrate          | ❌ Use merge        |

## Cherry-Pick vs Merge vs Rebase

| Technique   | What It Does              | When to Use                |
| ----------- | ------------------------- | -------------------------- |
| Merge       | Combines entire branches  | Normal feature integration |
| Rebase      | Moves commits to new base | Update feature with main   |
| Cherry-Pick | Copies specific commits   | Extract individual commits |

## Example: Backporting a Fix

The Barangay Blockchain has two release branches:

- `release/1.0` (production)
- `release/2.0` (upcoming)

A security fix is merged to `main`. It needs to be in both releases:

```bash
# Find the fix commit on main
git log main --oneline | grep security
# a1b2c3d Fix XSS vulnerability

# Backport to release/1.0
git checkout release/1.0
git cherry-pick a1b2c3d
git push origin release/1.0

# Backport to release/2.0
git checkout release/2.0
git cherry-pick a1b2c3d
git push origin release/2.0
```

Now the fix is in main, release/1.0, AND release/2.0.

## Why This Matters for Global Deployment

Four regions. Production is live 24/7. A bug is found.

**Without cherry-pick**: "We have to wait for the whole feature branch to be ready. The bug stays in production for days."

**With cherry-pick**: "We extract just the fix. Production is patched in minutes. Feature development continues uninterrupted."

Cherry-pick is the emergency surgery of Git—precise, fast, targeted.

## Best Practices

1. **Document cherry-picks**: Note in commit message that it was cherry-picked
2. **Communicate with team**: Let others know you cherry-picked
3. **Don't overuse**: If you're cherry-picking constantly, reconsider your branching strategy
4. **Test after cherry-pick**: The commit might behave differently in new context

```bash
# Good commit message after cherry-pick
git cherry-pick a1b2c3d
git commit --amend -m "Fix XSS vulnerability (cherry-picked from feature/security)"
```

## Key Takeaways

✓ Cherry-pick copies specific commits between branches
✓ Use for hotfixes when you can't merge entire branch
✓ Use for backporting fixes to release branches
✓ Resolve conflicts like normal merge conflicts
✓ Creates new commit with same changes, different hash
✓ Don't overuse—merge/rebase are usually better for regular integration
✓ Essential for production emergencies in global deployments

**Next Lesson:** Stashing—save your work temporarily without committing.
