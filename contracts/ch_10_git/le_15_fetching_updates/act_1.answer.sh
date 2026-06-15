#!/usr/bin/env bash
# Lesson 15 — Fetch vs pull: fetch updates remote-tracking refs only.
set -e
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "v1" > app.py; git add app.py; git commit -m "A: base"; git push -u origin main )
git clone origin.git devB
( cd devB; echo "more" >> app.py; git add app.py; git commit -m "B: update"; git push origin main )
cd devA
git fetch origin                        # downloads commits, does NOT touch working tree
# After fetch: origin/main is ahead of local main (we have not merged yet).
