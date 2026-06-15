#!/usr/bin/env bash
# Lesson 22 — Stashing: shelve unfinished work, handle an urgent task, restore.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
echo "half-done feature" > wip.py        # unstaged work in progress
git add wip.py
git stash push -m "WIP feature"           # shelve it; working tree is clean again
echo "urgent" > hotfix.py; git add hotfix.py; git commit -m "Urgent hotfix"
git stash pop                             # bring the WIP back
