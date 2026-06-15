# Activity Answer — What Is Git

The canonical, runnable solution. The grader runs `act_1.answer.sh` in a clean
repo and verifies state with `act_1.expect.sh`.

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 01 — What is Git: initialize the marketplace repo and set identity.
set -e
mkdir barangay-marketplace
cd barangay-marketplace
git init                                   # create the .git repository
git config user.name "Maria Santos"        # who is making commits
git config user.email "maria@barangaymarket.ph"
echo "# Barangay Marketplace" > README.md
git add README.md
git commit -m "Initial commit: project README"
git log --oneline
```

## Verify

`bash scripts/check-git.sh contracts/ch_10_git` replays this in a throwaway repo
and asserts: a `.git` repo exists, the default branch is `main`, identity is set,
and there is exactly one tracked commit containing `README.md`.
