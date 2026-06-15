#!/usr/bin/env bash
# Lesson 09 — Merge conflicts: two branches edit the same line; resolve by hand.
set -e
git init
echo "rate = 0.10" > pricing.py; git add pricing.py; git commit -m "Base pricing"

git switch -c feature/promo
echo "rate = 0.20" > pricing.py; git add pricing.py; git commit -m "Promo rate 20%"

git switch main
echo "rate = 0.12" > pricing.py; git add pricing.py; git commit -m "Standard rate 12%"

# This merge conflicts on the 'rate' line:
git merge feature/promo || true
# Resolve: keep the promo rate, then complete the merge.
echo "rate = 0.20" > pricing.py
git add pricing.py
git commit --no-edit                 # records the merge commit
