# Activity Answer — Pull Requests

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 16 — Pull requests: push a feature branch, then integrate it like a PR.
set -e
git init --bare origin.git
git clone origin.git marketplace
cd marketplace
echo "base" > app.py; git add app.py; git commit -m "Base"; git push -u origin main
git switch -c feature/login
echo "login()" > login.py; git add login.py; git commit -m "Add login"
git push -u origin feature/login        # this is what opening a PR pushes
# Reviewer approves -> integrate the PR into main with a merge commit:
git switch main
git merge --no-ff -m "Merge pull request: feature/login" feature/login
git push origin main
```

## Step-by-step explanation

- `git switch main` — Reviewer approves -> integrate the PR into main with a merge commit:

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
