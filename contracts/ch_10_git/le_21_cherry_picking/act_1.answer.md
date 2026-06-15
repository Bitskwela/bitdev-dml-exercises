# Activity Answer — Cherry Picking

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 21 — Cherry-pick: grab ONE commit from another branch onto main.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
git switch -c feature/experiments
echo "keep" > urgent_fix.py; git add urgent_fix.py; git commit -m "Urgent fix"
PICK=$(git rev-parse HEAD)
echo "noise" > experiment.py; git add experiment.py; git commit -m "Experimental noise"
git switch main
git cherry-pick "$PICK"             # bring ONLY the urgent fix to main
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
