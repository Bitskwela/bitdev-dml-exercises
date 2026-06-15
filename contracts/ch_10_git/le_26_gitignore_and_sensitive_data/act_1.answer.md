# Activity Answer — Gitignore And Sensitive Data

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 26 — .gitignore: keep secrets and build junk out of version control.
set -e
git init
printf '.env\n*.log\n__pycache__/\n' > .gitignore
echo "API_KEY=super-secret-123" > .env          # MUST NOT be committed
echo "debug output" > app.log                    # ignored build junk
echo "print('app')" > app.py                      # real source
git add .
git commit -m "chore: add app and gitignore (secrets excluded)"
git status --ignored
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
