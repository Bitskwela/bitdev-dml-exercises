# Activity Answer — Commit Message Standards

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 25 — Conventional Commits: type(scope): summary.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "chore: initialize project"
echo "pay()" > payments.py; git add payments.py; git commit -m "feat(payments): add GCash payment option"
sed -i 's/pay()/pay() # fixed/' payments.py; git add payments.py; git commit -m "fix(payments): correct rounding of centavos"
git log --oneline
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
