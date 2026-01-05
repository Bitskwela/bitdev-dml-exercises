# Le 13: Remote Repositories – The Code Takes Flight

![Remote Repositories](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-remote.png)

## Scene: A Laptop Walks Into a Barangay

**Early morning. Manila. The day after the team's Gitflow decision.**

Maria looks at her laptop. On it sits the Barangay Blockchain—three months of work, multiple developers' contributions, thousands of lines of carefully crafted code.

The code lives in a `.git` folder on her machine.

"There's a problem," she says to Marco, who arrives with coffee. "The code is here." She taps her laptop. "But Sam is in Cebu. Alexis is in Mexico City. How do they get the code?"

Marco smiles. "You upload it."

"Upload? Where?"

"To GitHub. Then everyone can download it."

Maria's eyes widen. "So the same code... runs on four laptops in three countries?"

"Not just laptops," Marco says. "Eventually, on servers in Cebu, Mexico City, and Singapore. When people anywhere in the world access Barangay Blockchain, the code that runs it started here—on your machine—and was shared through GitHub."

This is the moment Git transforms from a personal tool to a _team tool_. From "version control on my laptop" to "code coordination across the globe."

**Time Allotment**: 35 minutes

**Topics Covered**:

- What remotes are and why they matter
- Setting up GitHub as your remote
- Cloning repositories (downloading others' code)
- Understanding origin and upstream
- The remote-tracking branches concept
- Why centralized GitHub enables distributed teams

---

## The Problem It Solves

Three realities collide:

**Reality 1**: Sam in Cebu needs Maria's latest voting code to build payment integration on top of it. Maria's laptop isn't there.

**Reality 2**: Alexis in Mexico City needs to fix a bug that affects both Sam's and Maria's work. They can't email files back and forth.

**Reality 3**: In two weeks, Neri wants to deploy Version 1.0 to all 7 barangays. Developers in 3 countries need to download the exact same code, exactly once, and know it's the same version.

_How can code move from one person's machine to four others' machines across three continents?_---

## Understanding Remotes

**What is a remote?** A remote is not actually a "remote repository." It's a _connection_ to another repository.

Think of it like contact information:

```
Your local repository (on your laptop):
├─ main branch
├─ develop branch
├─ feature/voting branch
└─ connection to GitHub (called "origin")

GitHub repository:
├─ main branch
├─ develop branch
├─ feature/voting branch
└─ connections from Maria, Sam, and Alexis's machines
```

Your machine knows where GitHub is because you have a "remote" named `origin` that points there.

```bash
# See what remotes you have
git remote -v
# Output (if you have a remote):
# origin    https://github.com/bitskwela/barangay-blockchain.git (fetch)
# origin    https://github.com/bitskwela/barangay-blockchain.git (push)
```

Each line is a remote. `origin` is the name. The URL is GitHub. `fetch` and `push` mean you can download from and upload to that URL.

---

## The GitHub Moment: Maria Creates the Central Hub

**Monday morning. Maria creates a repository on GitHub.**

She goes to github.com, signs in, clicks "New Repository," names it `barangay-blockchain`, and marks it public.

GitHub creates an empty repository waiting for code.

Now Maria connects her local repository to GitHub:

```bash
# Add GitHub as the remote "origin"
git remote add origin https://github.com/bitskwela/barangay-blockchain.git

# Verify the connection
git remote -v
# origin    https://github.com/bitskwela/barangay-blockchain.git (fetch)
# origin    https://github.com/bitskwela/barangay-blockchain.git (push)
```

Now her local machine knows where to send code. GitHub URL is stored. No more manual uploading.

She pushes her local main branch to GitHub:

```bash
# Send main branch to GitHub (origin)
git push origin main

# Git uploads:
# - All commits on main
# - Full history
# - All associated blobs and trees
```

GitHub now mirrors Maria's main branch. The code is no longer just on her laptop. It's on GitHub's servers (backed up, redundant, accessible).

---

## Cloning: Sam's Perspective (Cebu)

**Tuesday morning. Sam needs to start work on voting integration.**

Rather than asking Maria to email a file, he runs:

```bash
# Clone the repository
git clone https://github.com/bitskwela/barangay-blockchain.git

# Sam's computer now has:
# ✓ Full repository (all history, all commits)
# ✓ All branches (main, develop, feature branches)
# ✓ Remote connection to GitHub (automatically named "origin")
# ✓ Remote-tracking branches (references to GitHub's branches)

cd barangay-blockchain

# Verify remotes
git remote -v
# origin    https://github.com/bitskwela/barangay-blockchain.git (fetch)
# origin    https://github.com/bitskwela/barangay-blockchain.git (push)

# See all branches
git branch -a
# *main
#  remotes/origin/main
#  remotes/origin/develop
#  remotes/origin/feature/voting
#  remotes/origin/feature/payment
```

Sam now has a complete, independent copy of the repository. He can commit locally, create branches, work offline. When he's ready, he can push his work back to GitHub.

---

## The Flow Across Three Regions

**Wednesday. The team is distributed across three countries working in parallel.**

**Maria (Manila)**:

```bash
# Create feature branch from develop
git switch -c feature/voting-audit develop

# Make commits
git commit -m "Add vote tally verification"

# Push to GitHub
git push origin feature/voting-audit

# The feature branch is now accessible to the entire team on GitHub
```

**Sam (Cebu)**:

```bash
# Pull latest from GitHub
git fetch origin develop

# Create his own feature branch
git switch -c feature/sms-alerts develop

# Works in parallel with Maria
git commit -m "Add SMS notifications for election results"

# Push when ready
git push origin feature/sms-alerts

# Both branches exist on GitHub, neither blocks the other
```

**Alexis (Mexico City)**:

```bash
# Pull latest
git fetch origin develop

# Create feature branch
git switch -c feature/payment-audit develop

# Work independently
git commit -m "Add payment reconciliation"

# Push
git push origin feature/payment-audit

# Three features, three branches, one GitHub, parallel development
```

Later, they integrate at GitHub:

```bash
# Pull requests merge features to develop for testing
# No conflicts because each worked on different code
# Integration testing happens once
# Code deploys as one release
```

---

## Remote-Tracking Branches: Understanding the Mirrors

When Sam clones, he doesn't just get branches. He gets _mirrors_ of GitHub's branches called remote-tracking branches.

```bash
git branch -a
# Local branches (you work on these):
#   main
#   develop

# Remote-tracking branches (mirrors of GitHub):
#   remotes/origin/main        ← reflects GitHub's main
#   remotes/origin/develop     ← reflects GitHub's develop
#   remotes/origin/feature/voting  ← reflects feature branch
#   remotes/origin/feature/payment
```

When Sam runs `git fetch origin`, Git updates these mirrors. It doesn't merge anything into his branches—just updates what he knows about GitHub's branches.

```bash
# Monday: Sam runs fetch
git fetch origin
# Updates remotes/origin/main from GitHub
# Updates remotes/origin/develop from GitHub
# Updates remotes/origin/feature/voting from GitHub

# These mirrors tell Sam: "GitHub's main has 5 commits ahead of my local main"
```

This is how Sam knows what happened on GitHub without merging changes automatically.

---

## Multiple Remotes: Beyond Origin

Some teams use multiple remotes. For example, teams working with upstream open source projects:

```bash
# Your fork on GitHub (your origin)
git remote add origin https://github.com/yourname/barangay-blockchain.git

# Original project on GitHub (upstream)
git remote add upstream https://github.com/bitskwela/barangay-blockchain.git

# Corporate GitLab (internal)
git remote add internal https://gitlab.company.com/barangay-blockchain.git

# Multiple sources, multiple targets
```

For Barangay Blockchain, the team uses just `origin` (GitHub) for now.

---

## Why This Matters for "Beyond the Islands"

Without remotes, this scenario is impossible:

- Maria writes voting system (Manila)
- Sam integrates payments (Cebu)
- Alexis adds international payment support (Mexico City)
- Neri deploys to 7 barangays (nationwide)

With remotes (GitHub), this is routine:

1. **Code is shared**: GitHub is the single source of truth
2. **Code is backed up**: If Maria's laptop dies, GitHub has full history
3. **Code is distributed**: Sam and Alexis work offline, push when ready
4. **Code is integrated**: Pull requests merge 3 features that no one blocked
5. **Code is deployed**: Version 1.0 goes to all 7 barangays from GitHub

This is collaboration. This is scale. This is "Beyond the Islands" becoming real.

---

## What the Code Does

When you `git clone` a repository, Git:

1. **Connects** to GitHub using the URL you provide
2. **Downloads** the entire repository's history and all branches
3. **Extracts** the latest commits into your working directory
4. **Sets up** the "origin" remote automatically
5. **Creates** remote-tracking branches so you know what's on GitHub

When you `git fetch origin`, Git:

1. **Connects** to GitHub via the "origin" remote
2. **Compares** your remote-tracking branches with GitHub's current state
3. **Downloads** any new commits from GitHub
4. **Updates** your remote-tracking branches locally
5. **Does NOT merge** anything—just updates what you know about GitHub

When you `git push origin main`, Git:

1. **Connects** to GitHub
2. **Compares** your local main with origin/main
3. **Uploads** any commits your machine has that GitHub doesn't
4. **Updates** GitHub's main to match your local main
5. **Updates** your local origin/main to match (confirms successful push)

---

## Key Takeaways

✅ **Remote**: A named connection to another repository (usually GitHub)  
✅ **Origin**: The default remote name (URL of your primary GitHub repo)  
✅ **Clone**: Download a full copy with remote connection intact  
✅ **Remote-tracking branches**: Local mirrors of GitHub's branches  
✅ **Fetch**: Download updates from GitHub without merging  
✅ **Push**: Upload your commits to GitHub  
✅ **Global collaboration**: Multiple developers, one GitHub, parallel work

---

## What's Next?

You understand the infrastructure. GitHub is set up. Remotes are configured.

But code doesn't move magically. Next, you'll learn the two commands that move code between your machine and GitHub: **push** (your code goes up) and **pull** (their code comes down). The team coordination happens in these moments.
