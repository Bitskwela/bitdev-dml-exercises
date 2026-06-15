#!/usr/bin/env bash
# Lesson 06 — Understanding branches: create parallel lines of work, list them.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base app"
git branch feature/payments        # create (do not switch)
git branch feature/audit-logging
git branch                          # list all branches; * marks current
