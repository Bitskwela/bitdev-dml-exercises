#!/usr/bin/env bash
# Lesson 21 — Cherry-pick: grab ONE commit from another branch onto main.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
git switch -c feature/experiments
echo "keep" > urgent_fix.py; git add urgent_fix.py; git commit -m "Urgent fix"
PICK=$(git rev-parse HEAD)
echo "noise" > experiment.py; git add experiment.py; git commit -m "Experimental noise"
git switch main
git cherry-pick "$PICK"             # bring ONLY the urgent fix to main
