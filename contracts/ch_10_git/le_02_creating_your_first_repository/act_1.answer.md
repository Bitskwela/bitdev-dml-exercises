# Activity Answer — Creating Your First Repository

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 02 — Creating your first repository: init, explore .git, first files.
set -e
mkdir barangay-marketplace-system
cd barangay-marketplace-system
git init
echo "# Barangay Marketplace Payment System" > README.md
echo "*.pyc" > .gitignore
echo "print('Processing marketplace payments')" > payment_processor.py
git status                                  # all three are 'untracked'
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
