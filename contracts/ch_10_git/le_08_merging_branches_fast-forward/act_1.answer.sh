#!/usr/bin/env bash
# Lesson 08 — Fast-forward merge: main hasn't moved, so the merge is linear.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git switch -c feature/receipts
echo "receipt()" > receipt.py; git add receipt.py; git commit -m "Add receipts"
git switch main
git merge feature/receipts          # fast-forward: no merge commit needed
