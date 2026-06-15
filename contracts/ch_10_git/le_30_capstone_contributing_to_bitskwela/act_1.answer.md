# Activity Answer — Capstone Contributing To Bitskwela

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 30 — Capstone: full real-world flow against a shared remote.
set -e
git init --bare origin.git
git clone origin.git bitskwela
cd bitskwela
echo "# Bitskwela Platform" > README.md
git add README.md; git commit -m "chore: initialize platform"; git push -u origin main
# Feature branch -> conventional commits -> integrate with a merge commit
git switch -c feature/leaderboard
echo "leaderboard()" > leaderboard.py; git add leaderboard.py; git commit -m "feat(game): add leaderboard"
echo "leaderboard() # tuned" > leaderboard.py; git add leaderboard.py; git commit -m "fix(game): tune scoring"
git switch main
git merge --no-ff -m "Merge feature/leaderboard" feature/leaderboard
git tag -a v1.0.0 -m "First public release"
git branch -d feature/leaderboard
git push origin main
git push origin v1.0.0
```

## Step-by-step explanation

- `git switch -c feature/leaderboard` — Feature branch -> conventional commits -> integrate with a merge commit

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
