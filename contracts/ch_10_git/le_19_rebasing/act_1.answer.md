# Activity Answer — Rebasing

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 19 — Rebasing: replay a feature on top of updated main for linear history.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
git switch -c feature/api
echo "api()" > api.py; git add api.py; git commit -m "Add API"
git switch main
echo "hotfix" > hotfix.py; git add hotfix.py; git commit -m "Main hotfix"
git switch feature/api
git rebase main                     # move feature's commits to sit after the hotfix
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
