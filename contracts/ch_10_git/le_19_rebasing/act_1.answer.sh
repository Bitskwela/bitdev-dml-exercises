#!/usr/bin/env bash
# Lesson 19 — Rebasing: replay a feature on top of updated main for linear history.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
git switch -c feature/api
echo "api()" > api.py; git add api.py; git commit -m "Add API"
git switch main
echo "hotfix" > hotfix.py; git add hotfix.py; git commit -m "Main hotfix"
git switch feature/api
git rebase main                     # move feature's commits to sit after the hotfix
