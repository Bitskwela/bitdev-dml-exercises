# Activity Answer — Remote Repositories

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 13 — Remotes: create a bare 'origin' (stands in for GitHub) and push.
set -e
git init --bare origin.git              # the shared remote repository
git clone origin.git marketplace        # working clone
cd marketplace
echo "# Marketplace" > README.md
git add README.md; git commit -m "Initial commit"
git remote -v                           # 'origin' points at ../origin.git
git push -u origin main                 # publish main to the remote
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
