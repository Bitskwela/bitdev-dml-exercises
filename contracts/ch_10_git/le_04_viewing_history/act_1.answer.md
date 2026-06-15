# Activity Answer — Viewing History

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 04 — Viewing history: build a 3-commit history and inspect it.
set -e
git init
echo "v1" > app.py;  git add app.py; git commit -m "Add payment skeleton"
echo "v2" >> app.py; git add app.py; git commit -m "Add discount logic"
echo "v3" >> app.py; git add app.py; git commit -m "Add receipt printing"
git log --oneline
git show --stat HEAD
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
