# Activity Answer — Stashing

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 22 — Stashing: shelve unfinished work, handle an urgent task, restore.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
echo "half-done feature" > wip.py        # unstaged work in progress
git add wip.py
git stash push -m "WIP feature"           # shelve it; working tree is clean again
echo "urgent" > hotfix.py; git add hotfix.py; git commit -m "Urgent hotfix"
git stash pop                             # bring the WIP back
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
