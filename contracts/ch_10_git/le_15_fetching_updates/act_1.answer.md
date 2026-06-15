# Activity Answer — Fetching Updates

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 15 — Fetch vs pull: fetch updates remote-tracking refs only.
set -e
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "v1" > app.py; git add app.py; git commit -m "A: base"; git push -u origin main )
git clone origin.git devB
( cd devB; echo "more" >> app.py; git add app.py; git commit -m "B: update"; git push origin main )
cd devA
git fetch origin                        # downloads commits, does NOT touch working tree
# After fetch: origin/main is ahead of local main (we have not merged yet).
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
