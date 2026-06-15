#!/usr/bin/env bash
# Lesson 23 — Reflog recovery: undo a destructive reset --hard.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
echo "v1" > work.py; git add work.py; git commit -m "Important work 1"
echo "v2" > work2.py; git add work2.py; git commit -m "Important work 2"
git reset --hard HEAD~1            # OOPS: "Important work 2" looks lost
git reflog                          # the reflog still remembers it
git reset --hard HEAD@{1}          # travel back to where we were -> recovered!
