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
