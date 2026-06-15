#!/usr/bin/env bash
# Lesson 10 — Feature branch workflow: branch, build, merge with --no-ff, delete.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git switch -c feature/search
echo "search()" > search.py; git add search.py; git commit -m "Add search"
git switch main
git merge --no-ff -m "Merge feature/search" feature/search   # keep a merge commit
git branch -d feature/search                                  # tidy up
