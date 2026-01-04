# Le 17: Handling Remote Rejections

![Git Push Rejected](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-rejected.png)

## Scene: Divergence in Distributed Development

**Friday afternoon. Manila. Maria has been coding all morning.**

Five commits on her local `main` branch. Good commits. Code review approved. Tests passing. Ready to deploy.

Time to push to production.

```bash
$ git push origin main
```

Her terminal turns red:

```
! [rejected]        main -> main (non-fast-forward)
error: failed to push some refs to 'github.com/bitskwela/barangay-blockchain.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
```

Maria stares at the screen in disbelief. "Rejected? But my code is correct!"

She messages the team Slack. Seconds later, Dev Sam responds from Cebu: "I merged a hotfix this morning—production bug in the vote counting. Your local main doesn't have my changes. Git is protecting you—if you pushed now, you'd overwrite my hotfix."

Maria's mind races. The timeline:

- **This morning**: She started with main (commit B)
- **This morning (later)**: Dev Sam pushed a hotfix (commits B → X, Y)
- **She has now**: Commits B → C, D, E (her own path)

The branches diverged. Git sees this and refuses. "Push rejected" doesn't mean error. It means protection.

"This is normal," Marco reassures from Cebu. "Every distributed team hits this. It's actually a good sign—Git is working."

Maria runs:
```bash
git pull origin main
```

Her commits are integrated with Dev Sam's. A small conflict appears—both touched the same validation file. They resolve it together on Slack. Maria makes the fix. Commits again. Then:

```bash
git push origin main
```

Success. The main branch now contains everyone's work. Dev Sam's hotfix. Maria's new features. The divergence is resolved.

**This lesson teaches that in distributed development, divergence is inevitable. Rejections aren't failures—they're Git protecting the team from data loss. The solution is simple: pull before push. Integrate before deploying.**

**Time Allotment**: 40 minutes

**Topics Covered**:

- Understanding non-fast-forward rejections
- Why pushes get rejected
- Strategies for resolving divergence
- Pull before push workflow
- Rebase vs merge when integrating
- Force push dangers

---

## Why Pushes Get Rejected

Git rejects your push when the remote has commits you don't have locally.

```
Your local main:    A → B → C → D → E
Remote main:        A → B → X → Y
                           ↑
                     Dev Sam's hotfix
```

If Git let you push, commits X and Y would be lost. That's data loss. Git refuses.

## The Non-Fast-Forward Error

```bash
$ git push origin main
! [rejected]        main -> main (non-fast-forward)
```

"Non-fast-forward" means: your branch can't simply be "fast-forwarded" onto the remote. There's divergence that must be resolved.

## Solution 1: Pull Then Push (Most Common)

```bash
# Step 1: Pull to get remote changes
git pull origin main
# This merges remote changes into your local branch

# Step 2: Resolve any conflicts if needed
# (Git will tell you if there are conflicts)

# Step 3: Push your combined work
git push origin main
# Now includes both your commits AND Dev Sam's
```

After pull:

```
Your main: A → B → C → D → E
                          \
                           → M (merge commit)
                          /
Remote:    A → B → X → Y →
```

## Solution 2: Pull with Rebase (Cleaner History)

```bash
# Pull but replay your commits on top of remote
git pull --rebase origin main

# Your commits are re-applied on top of remote's commits
git push origin main
```

After rebase:

```
Result: A → B → X → Y → C' → D' → E'
        (remote's)   (yours, rebased)
```

This creates a linear history—no merge commit. Many teams prefer this for cleaner logs.

## When to Use Each Approach

| Approach            | Use When                  | Result                            |
| ------------------- | ------------------------- | --------------------------------- |
| `git pull`          | Simple cases, quick fix   | Merge commit created              |
| `git pull --rebase` | Want clean linear history | Commits replayed, no merge commit |

## The Danger: Force Push

You _can_ force Git to overwrite the remote:

```bash
# DANGEROUS! Don't do this on shared branches!
git push --force origin main
```

This overwrites remote with your version, **deleting other people's work**.

**When force push is acceptable**:

- On your own feature branch that no one else uses
- After rebasing a branch you've already pushed (coordinate with team)
- Never on main, develop, or shared branches

**Force push gone wrong**:

```
Dev Sam: "Where's my hotfix?!"
Maria: "I force pushed... is it gone?"
Marco: "You overwrote it. Check reflog. Next time, never force push to main."
```

## Real-World Scenario: The Friday Afternoon Push

```bash
# Maria's situation
$ git log --oneline -3
e4f5g6h (HEAD -> main) Add voter analytics
c3d4e5f Add registration endpoint
b2c3d4e Fix validation bug

$ git push origin main
# [rejected] non-fast-forward

# What happened? Dev Sam pushed while she was coding.

# Solution: Pull and integrate
$ git pull origin main
# Auto-merging voter.js
# CONFLICT in voter.js

# Maria resolves the conflict
$ nano voter.js  # Fix the conflict markers

$ git add voter.js
$ git commit -m "Merge remote main, resolve voter.js conflict"

$ git push origin main
# Success!
```

## Preventing Rejections

The best way to handle rejections is to prevent them:

```bash
# Habit: Fetch before you start working
git fetch origin
git status
# "Your branch is behind origin/main by 2 commits"

# Pull before you start
git pull origin main

# Now your local is current. Less chance of rejection later.
```

## Why This Matters for Global Deployment

Four developers. Four time zones. All pushing to the same repository.

While Manila sleeps (10 PM - 6 AM Manila):

- London is coding (2 PM - 10 PM London)
- Singapore wraps up (10 PM - 6 AM Singapore)

When Maria arrives in the morning, the remote has changed. Her local copy is behind.

**Professional workflow**:

```bash
# Morning routine
git fetch origin
git status
# "Behind by 4 commits"

git pull origin main
# Now current

# Work all day...

# Before pushing
git fetch origin
git status
# If behind, pull again

git push origin main
# Clean push, no rejection
```

Rejections become rare when everyone follows the "fetch-pull-work-push" rhythm.

## Handling Conflicts During Pull

Sometimes pulling reveals conflicts:

```bash
$ git pull origin main
Auto-merging voter.js
CONFLICT (content): Merge conflict in voter.js
Automatic merge failed; fix conflicts and commit.
```

This is the same conflict resolution you learned in Lesson 9:

```bash
# Open the file, find conflict markers
nano voter.js

# Remove markers, keep correct code
git add voter.js
git commit -m "Merge remote main, resolve conflict"

git push origin main
# Success!
```

## Key Takeaways

✓ Push rejection means remote has commits you don't have
✓ Non-fast-forward = your branch has diverged from remote
✓ Solution: `git pull` to integrate, then push
✓ Use `--rebase` for cleaner history
✓ Never force push to shared branches
✓ Fetch regularly to stay synchronized
✓ Rejections are Git protecting the team, not errors

**Next Lesson:** Time for hands-on practice! We'll simulate a full team collaboration project using everything you've learned.
