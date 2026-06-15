# Activity Answer — Pushing And Pulling

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 14 — Push & pull: two clones share work through 'origin'.
set -e
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "v1" > app.py; git add app.py; git commit -m "A: add app"; git push -u origin main )
git clone origin.git devB               # second developer clones
( cd devB; echo "feature" > feature.py; git add feature.py; git commit -m "B: add feature"; git push origin main )
( cd devA; git pull origin main )       # A pulls B's work
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
