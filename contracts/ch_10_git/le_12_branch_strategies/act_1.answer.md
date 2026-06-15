# Activity Answer — Branch Strategies

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 12 — Branch strategies: a Git-flow style main + develop + feature.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git switch -c develop                  # long-lived integration branch
git switch -c feature/checkout develop
echo "checkout()" > checkout.py; git add checkout.py; git commit -m "Add checkout"
git switch develop
git merge --no-ff -m "Merge feature/checkout into develop" feature/checkout
git switch main
git merge --no-ff -m "Release: merge develop into main" develop
git branch
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
