#!/usr/bin/env bash
# Lesson 14 — Push & pull: two clones share work through 'origin'.
set -e
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "v1" > app.py; git add app.py; git commit -m "A: add app"; git push -u origin main )
git clone origin.git devB               # second developer clones
( cd devB; echo "feature" > feature.py; git add feature.py; git commit -m "B: add feature"; git push origin main )
( cd devA; git pull origin main )       # A pulls B's work
