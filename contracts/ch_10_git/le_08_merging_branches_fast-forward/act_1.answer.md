# Activity Answer — Merging Branches Fast-Forward

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 08 — Fast-forward merge: main hasn't moved, so the merge is linear.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git switch -c feature/receipts
echo "receipt()" > receipt.py; git add receipt.py; git commit -m "Add receipts"
git switch main
git merge feature/receipts          # fast-forward: no merge commit needed
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
