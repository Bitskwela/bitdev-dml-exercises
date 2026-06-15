# Activity Answer — Cleaning Up Branches

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 11 — Cleaning up: delete merged branches; force-delete an unmerged one.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git switch -c feature/done
echo "x" > done.py; git add done.py; git commit -m "Finish feature"
git switch main
git merge --no-ff -m "Merge feature/done" feature/done
git branch -d feature/done            # safe delete (merged)

git switch -c feature/abandoned
echo "y" > scratch.py; git add scratch.py; git commit -m "Abandoned WIP"
git switch main
git branch -D feature/abandoned       # force delete (not merged)
git branch
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
