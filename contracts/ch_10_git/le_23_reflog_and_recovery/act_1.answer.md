# Activity Answer — Reflog And Recovery

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 23 — Reflog recovery: undo a destructive reset --hard.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
echo "v1" > work.py; git add work.py; git commit -m "Important work 1"
echo "v2" > work2.py; git add work2.py; git commit -m "Important work 2"
git reset --hard HEAD~1            # OOPS: "Important work 2" looks lost
git reflog                          # the reflog still remembers it
git reset --hard HEAD@{1}          # travel back to where we were -> recovered!
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
