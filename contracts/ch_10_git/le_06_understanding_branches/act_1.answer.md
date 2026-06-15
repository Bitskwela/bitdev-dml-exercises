# Activity Answer — Understanding Branches

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 06 — Understanding branches: create parallel lines of work, list them.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git branch feature/payments        # create (do not switch)
git branch feature/audit-logging
git branch                          # list all branches; * marks current
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
