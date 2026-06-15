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
