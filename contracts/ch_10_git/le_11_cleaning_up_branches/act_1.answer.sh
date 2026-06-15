#!/usr/bin/env bash
# Lesson 11 — Cleaning up: delete merged branches; force-delete an unmerged one.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git switch -c feature/done
echo "x" > done.py; git add done.py; git commit -m "Finish feature"
git switch main
git merge --no-ff -m "Merge feature/done" feature/done
git branch -d feature/done            # safe delete (merged)

git switch -c feature/abandoned
echo "y" > scratch.py; git add scratch.py; git commit -m "Abandoned WIP"
git switch main
git branch -D feature/abandoned       # force delete (not merged)
git branch
