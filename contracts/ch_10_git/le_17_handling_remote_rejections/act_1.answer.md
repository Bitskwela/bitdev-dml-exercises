# Activity Answer — Handling Remote Rejections

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 17 — Remote rejections: a non-fast-forward push is refused; pull, then push.
set -e
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "base" > app.py; git add app.py; git commit -m "base"; git push -u origin main )
git clone origin.git devB
# A pushes first...
( cd devA; echo "A change" > a.py; git add a.py; git commit -m "A work"; git push origin main )
# B committed on the old base and is now behind -> push is REJECTED
cd devB
echo "B change" > b.py; git add b.py; git commit -m "B work"
git push origin main || echo ">> push rejected (non-fast-forward), as expected"
git pull --no-rebase origin main        # integrate A's work first
git push origin main                     # now it succeeds
```

## Step-by-step explanation

- `( cd devA; echo "A change" > a.py; git add a.py; git commit -m "A work"; git push origin main )` — A pushes first...
- `cd devB` — B committed on the old base and is now behind -> push is REJECTED

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
