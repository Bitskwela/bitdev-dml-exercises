# Activity Answer — Handling Merge Conflicts

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 09 — Merge conflicts: two branches edit the same line; resolve by hand.
set -e
git init
echo "rate = 0.10" > pricing.py; git add pricing.py; git commit -m "Base pricing"

git switch -c feature/promo
echo "rate = 0.20" > pricing.py; git add pricing.py; git commit -m "Promo rate 20%"

git switch main
echo "rate = 0.12" > pricing.py; git add pricing.py; git commit -m "Standard rate 12%"

# This merge conflicts on the 'rate' line:
git merge feature/promo || true
# Resolve: keep the promo rate, then complete the merge.
echo "rate = 0.20" > pricing.py
git add pricing.py
git commit --no-edit                 # records the merge commit
```

## Step-by-step explanation

- `git merge feature/promo || true` — This merge conflicts on the 'rate' line:
- `echo "rate = 0.20" > pricing.py` — Resolve: keep the promo rate, then complete the merge.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
