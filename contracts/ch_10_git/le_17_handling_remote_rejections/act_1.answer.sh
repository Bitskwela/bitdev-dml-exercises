#!/usr/bin/env bash
# Lesson 17 — Remote rejections: a non-fast-forward push is refused; pull, then push.
set -e
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "base" > app.py; git add app.py; git commit -m "base"; git push -u origin main )
git clone origin.git devB
# A pushes first...
( cd devA; echo "A change" > a.py; git add a.py; git commit -m "A work"; git push origin main )
# B committed on the old base and is now behind -> push is REJECTED
cd devB
echo "B change" > b.py; git add b.py; git commit -m "B work"
git push origin main || echo ">> push rejected (non-fast-forward), as expected"
git pull --no-rebase origin main        # integrate A's work first
git push origin main                     # now it succeeds
