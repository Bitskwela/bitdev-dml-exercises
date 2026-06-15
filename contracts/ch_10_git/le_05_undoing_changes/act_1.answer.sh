#!/usr/bin/env bash
# Lesson 05 — Undoing changes: restore a working-dir edit, then revert a commit.
set -e
git init
echo "stable line" > config.py
git add config.py; git commit -m "Add stable config"

# (a) discard an unstaged edit with restore
echo "oops bad edit" >> config.py
git restore config.py                       # back to last committed version

# (b) make a bad commit, then revert it (history-safe undo)
echo "buggy feature" > bug.py
git add bug.py; git commit -m "Add buggy feature"
git revert --no-edit HEAD                    # creates a new commit undoing the bug
git log --oneline
