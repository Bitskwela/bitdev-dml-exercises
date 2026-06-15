#!/usr/bin/env bash
# Lesson 07 — Creating & switching: branch off, commit there, main stays clean.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git switch -c feature/voting        # create AND switch in one step
echo "vote()" > voting.py; git add voting.py; git commit -m "Add voting feature"
git switch main                     # back to main — voting.py is NOT here
