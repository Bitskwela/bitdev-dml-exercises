# Le 15: Fetching Updates

![Git Fetch](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-fetch.png)

## Background Story

Monday morning. Maria arrives at the Manila office with coffee in hand. She's been working on `feature/voter-registration` all weekend on her laptop—offline mode at her grandmother's house in Bulacan where WiFi is spotty.

She opens her laptop, ready to push her changes. But wait.

"Before you push, fetch first," Marco messages from Cebu. "Dev Sam merged a critical security update to main on Saturday. If you push without knowing about his changes, you might overwrite something important."

Maria hesitates. "What's the difference between fetch and pull? I usually just pull."

Marco explains: "Pull is aggressive—it downloads AND merges immediately. Fetch is careful—it downloads changes so you can SEE them first, without automatically merging. Think of fetch as 'show me what's new' and pull as 'download and apply everything now.'"

Maria runs `git fetch`. She sees Dev Sam's security commits. She reviews them. She realizes her voter registration code touches the same files. Now she can plan her merge carefully instead of being surprised by conflicts.

"Fetch before you push," becomes Maria's new habit. It's saved her countless merge headaches.

**Time Allotment**: 35 minutes

**Topics Covered**:

- Understanding git fetch vs git pull
- Viewing remote changes before merging
- Remote-tracking branches
- Safe synchronization workflow
- When to fetch vs when to pull

---

## What is Git Fetch?

Fetch downloads changes from the remote repository **without** merging them into your current branch.

```bash
# Fetch all updates from origin
git fetch origin

# What happens:
# 1. Git contacts GitHub
# 2. Downloads new commits, branches, tags
# 3. Updates your remote-tracking branches (origin/main, origin/feature/*, etc.)
# 4. Does NOT change your working files
# 5. Does NOT merge anything
```

After fetching, your local branches are unchanged. But you can now SEE what's on the remote.

## Fetch vs Pull: The Critical Difference

| Command     | Downloads Changes | Merges Automatically | Safe?                  |
| ----------- | ----------------- | -------------------- | ---------------------- |
| `git fetch` | ✅ Yes            | ❌ No                | ✅ Very safe           |
| `git pull`  | ✅ Yes            | ✅ Yes               | ⚠️ Can cause conflicts |

**Pull = Fetch + Merge**

When you run `git pull origin main`, Git actually does:

1. `git fetch origin main` (download)
2. `git merge origin/main` (merge immediately)

This means pull can surprise you with merge conflicts. Fetch lets you inspect first.

## The Safe Workflow

```bash
# Step 1: Fetch to see what's new
git fetch origin

# Step 2: Check what changed
git log main..origin/main --oneline
# Shows commits on origin/main that aren't in your local main

# Step 3: Review the changes
git diff main origin/main
# Shows file differences

# Step 4: Now merge when you're ready
git merge origin/main
# Or: git pull (if you're confident)
```

## Remote-Tracking Branches

After fetching, you have "remote-tracking branches":

```bash
# List all branches including remote-tracking
git branch -a

# Output:
# * main
#   feature/voter-registration
#   remotes/origin/main                    ← Remote-tracking
#   remotes/origin/feature/security-fix    ← Remote-tracking
#   remotes/origin/feature/payment         ← Remote-tracking
```

These `remotes/origin/*` branches show the state of the remote repository **as of your last fetch**.

## Real-World Scenario: Maria's Monday

```bash
# Maria's workflow after the weekend:

# 1. Fetch to see what happened while she was away
git fetch origin
# Downloading... done.

# 2. Check if main has new commits
git log main..origin/main --oneline
# a1b2c3d Security: Add input validation (Dev Sam)
# e4f5g6h Security: Fix XSS vulnerability (Dev Sam)

# 3. Maria sees Dev Sam's security work
git diff main origin/main
# Shows security changes to voting.js

# 4. Maria realizes she needs to rebase her work on top of Dev Sam's
git checkout feature/voter-registration
git rebase origin/main
# Now her feature includes the security fixes

# 5. Push her updated feature
git push origin feature/voter-registration
```

Without fetch, Maria might have pushed code that conflicts with security fixes—or worse, accidentally reverted them.

## Fetching Specific Branches

```bash
# Fetch only main branch
git fetch origin main

# Fetch a specific feature branch
git fetch origin feature/payment

# Fetch all branches (default)
git fetch origin
# or just: git fetch
```

## Why This Matters for Global Deployment

The Barangay Blockchain team spans four time zones. While Manila sleeps, Singapore and London are coding. While London sleeps, Manila and Cebu are coding.

**Without fetch**: You blindly pull and get surprised by conflicts at the worst time.

**With fetch**: You see what changed overnight. You plan your merge. You avoid surprises.

Dev Sam (Cebu) fetches every morning before starting work:

```bash
# Dev Sam's morning routine
git fetch origin
git log --oneline --all --graph | head -20
# "Ah, London pushed a refactor. Let me review before I start."
```

London developer fetches before every push:

```bash
# London's pre-push habit
git fetch origin
git status
# "Your branch is behind 'origin/main' by 3 commits"
# "Better pull and test before pushing my changes"
```

Fetch is the professional's safety net.

## Automatic Fetching

Many Git GUIs fetch automatically in the background. But understanding manual fetch matters because:

1. You control when synchronization happens
2. You can fetch on slow/expensive connections strategically
3. You understand what your tools are doing
4. In emergencies, you know the underlying commands

## Key Takeaways

✓ Fetch downloads without merging—safe to run anytime
✓ Pull = Fetch + Merge (more aggressive)
✓ Remote-tracking branches show the remote's state
✓ Fetch before pushing to avoid surprises
✓ Use `git log main..origin/main` to see incoming changes
✓ Global teams fetch regularly to stay synchronized
✓ "Fetch first" is a professional habit

**Next Lesson:** Pull Requests—the formal code review process that makes team collaboration safe and organized.
