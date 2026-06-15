#!/usr/bin/env bash
# Lesson 12 — Branch strategies: a Git-flow style main + develop + feature.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git switch -c develop                  # long-lived integration branch
git switch -c feature/checkout develop
echo "checkout()" > checkout.py; git add checkout.py; git commit -m "Add checkout"
git switch develop
git merge --no-ff -m "Merge feature/checkout into develop" feature/checkout
git switch main
git merge --no-ff -m "Release: merge develop into main" develop
git branch
