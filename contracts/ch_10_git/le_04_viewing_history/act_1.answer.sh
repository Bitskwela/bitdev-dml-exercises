#!/usr/bin/env bash
# Lesson 04 — Viewing history: build a 3-commit history and inspect it.
set -e
git init
echo "v1" > app.py;  git add app.py; git commit -m "Add payment skeleton"
echo "v2" >> app.py; git add app.py; git commit -m "Add discount logic"
echo "v3" >> app.py; git add app.py; git commit -m "Add receipt printing"
git log --oneline
git show --stat HEAD
