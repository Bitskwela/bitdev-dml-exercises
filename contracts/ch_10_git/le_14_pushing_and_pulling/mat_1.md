````markdown
# Le 14: Pushing and Pulling

![Push Pull Workflow](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-push-pull.png)

## Scene: Code Becomes Shared Across Oceans

**6 PM Manila. Maria stares at the clock.**

She's been coding all day on her `feature/voter-registration` branch. Voter validation done. Duplicate detection done. Registration events complete. Five solid commits that represent hours of careful thinking.

Her fingers hover over the laptop keyboard.

"The code is on my machine," she mutters. "If I shut this down and go home, and my apartment catches fire, or my laptop gets stolen, or I spill coffee on it—three weeks of work for the team burns."

She thinks of Dev Sam waking up in Cebu in eight hours. He's supposed to build payment integration on top of her voter registration. How? Will she email him the code? A zip file? Will he copy-paste from a share link?

"No," she says quietly. "There's a better way."

`git push origin feature/voter-registration`

Within seconds, GitHub receives her commits. Her code is now on servers in multiple data centers. It's backed up. It's safe. It's accessible.

**The next morning in Cebu. Dev Sam wakes up.**

His first action: check his messages. Marco wrote: "Maria finished voter registration yesterday. Your vote-casting branch should build on top of it."

Dev Sam pulls:
`git pull origin feature/voter-registration`

Maria's five commits appear on his machine instantly. No email. No USB drive. No file sharing service. Just Git, connecting two developers across the ocean as if they were sitting at the same desk.

**This lesson teaches the second superpower: how Git makes continuous collaboration possible across time zones and continents.**

**Time Allotment**: 35 minutes

**Topics Covered**:

- What git push does and how it works
- What git pull does and how it works
- Setting up tracking branches
- The push-pull synchronization cycle
- Common push/pull scenarios and errors

---

## What is Git Push?

Push sends your local commits to a remote repository (like GitHub).

```bash
# Basic push syntax
git push <remote> <branch>

# Example: push feature branch to GitHub
git push origin feature/voter-registration
```

**What happens when you push:**

1. Git connects to the remote (GitHub)
2. Sends all commits on your branch that the remote doesn't have
3. Updates the remote branch to match your local branch
4. Other developers can now see and pull your work

```
Before push:
Local:   A → B → C → D → E (your commits)
Remote:  A → B → C (behind by 2 commits)

After push:
Local:   A → B → C → D → E
Remote:  A → B → C → D → E (now in sync)
```

## What is Git Pull?

Pull downloads commits from a remote repository and merges them into your current branch.

```bash
# Basic pull syntax
git pull <remote> <branch>

# Example: get latest main branch
git pull origin main
```

**What happens when you pull:**

1. Git connects to the remote (GitHub)
2. Downloads all new commits from the remote branch
3. Merges those commits into your current local branch
4. Your working files update to reflect the merged state

```
Before pull:
Remote:  A → B → C → D → E (has new commits)
Local:   A → B → C (behind by 2 commits)

After pull:
Remote:  A → B → C → D → E
Local:   A → B → C → D → E (now in sync)
```

## First Push: Setting Up Tracking

The first time you push a new branch, set up tracking:

```bash
# Create and switch to new branch
git checkout -b feature/voter-analytics

# Make some commits
git commit -m "feat: add analytics module"

# First push: use -u to set upstream tracking
git push -u origin feature/voter-analytics

# Now "origin/feature/voter-analytics" is tracked
```

The `-u` (or `--set-upstream`) flag creates a link between your local branch and the remote branch. After this, you can simply run:

```bash
git push    # Git knows where to push
git pull    # Git knows where to pull from
```

## The Daily Push-Pull Cycle

This is Maria's typical day:

```bash
# 8:00 AM - Start of day: get latest code
git checkout main
git pull origin main
# "Already up to date" or downloads overnight changes

# 8:15 AM - Create feature branch from updated main
git checkout -b feature/voter-improvements

# 8:30 AM - 5:30 PM - Work all day
git commit -m "feat: add voter age validation"
git commit -m "feat: add voter ID format check"
git commit -m "test: add validation tests"

# 5:30 PM - End of day: push your work
git push origin feature/voter-improvements
# Work is now safe on GitHub

# 6:00 PM - Maria goes home. Laptop could explode.
# Her code is safe.
```

The next morning in Cebu, Dev Sam:

```bash
# 8:00 AM Cebu time
git fetch origin
git checkout feature/voter-improvements
git pull origin feature/voter-improvements
# Dev Sam now has all of Maria's commits
```

## Understanding Origin

`origin` is just a name—it's the default name for your remote repository.

```bash
# See your remotes
git remote -v

# Output:
# origin    https://github.com/bitskwela/barangay-blockchain.git (fetch)
# origin    https://github.com/bitskwela/barangay-blockchain.git (push)
```

When you run `git push origin main`, you're saying: "Push to the remote named 'origin', specifically the 'main' branch."

## Push and Pull Variations

### Push All Branches (Rarely Needed)

```bash
# Push all local branches to remote
git push origin --all
```

### Pull with Rebase (Cleaner History)

```bash
# Pull but rebase instead of merge
git pull --rebase origin main
```

### Push to Different Remote Branch

```bash
# Push local branch to differently-named remote branch
git push origin feature/local-name:feature/remote-name
```

## Common Push Errors

### Error: "rejected - non-fast-forward"

```bash
$ git push origin main
! [rejected]        main -> main (non-fast-forward)
```

**Meaning:** The remote has commits you don't have locally.

**Solution:** Pull first, then push.

```bash
git pull origin main
# Resolve any conflicts
git push origin main
```

### Error: "no upstream branch"

```bash
$ git push
fatal: The current branch feature/new has no upstream branch.
```

**Meaning:** Git doesn't know where to push this branch.

**Solution:** Use `-u` to set upstream:

```bash
git push -u origin feature/new
```

## Real-World Scenario: The Timezone Relay

The Barangay Blockchain team works across four time zones. Here's how push/pull creates seamless collaboration:

**5 PM Manila (Maria ends her day):**

```bash
git push origin feature/voting-module
# "I've finished the voter validation. Pushing now."
```

**6 PM Singapore (continues where Maria left off):**

```bash
git pull origin feature/voting-module
# Gets Maria's 5 commits instantly
git commit -m "feat: add Singapore region support"
git push origin feature/voting-module
```

**9 AM London (next morning, reviews the work):**

```bash
git pull origin feature/voting-module
# Gets both Maria's and Singapore's commits
# Reviews code, suggests changes
```

**8 AM Manila (Maria's next day):**

```bash
git pull origin feature/voting-module
# Gets Singapore's additions and London's suggestions
# Continues development
```

No meetings required. No waiting. Code flows around the world like water.

## Push/Pull Best Practices

### Before Starting Work

```bash
git checkout main
git pull origin main
# Always start from latest code
```

### Before Pushing

```bash
git status
# Make sure you've committed everything you want to share
```

### At End of Day

```bash
git push origin your-feature-branch
# Never leave uncommitted work only on your laptop
```

### Communication

```bash
# After pushing significant changes, let the team know:
# "Pushed voter validation to feature/voting-module"
```

## Why This Matters for Global Deployment

Without push/pull:

- Code lives on individual laptops
- Sharing means email, USB, or "can you send me that file?"
- No backup if laptop fails
- No way to collaborate asynchronously

With push/pull:

- Code lives on GitHub (backed up, accessible)
- Sharing is instant: push and tell the team
- Laptop failure? Clone and continue
- Developers in different time zones collaborate seamlessly

The Barangay Blockchain serves communities across the Philippines. Push and pull are how Manila, Cebu, and Singapore all work on the same codebase without ever being online at the same time.

## Key Takeaways

✓ Push sends your local commits to the remote repository
✓ Pull downloads remote commits and merges them locally
✓ Use `-u` on first push to set up tracking
✓ Always pull before starting work to get latest changes
✓ Always push before ending work to backup your code
✓ Push/pull enables asynchronous collaboration across time zones
✓ "origin" is the default name for your remote

**Next Lesson:** Fetch—see what changed on the remote without automatically merging.
````
