#!/usr/bin/env bash
# Lesson 26 — .gitignore: keep secrets and build junk out of version control.
set -e
git init
printf '.env\n*.log\n__pycache__/\n' > .gitignore
echo "API_KEY=super-secret-123" > .env          # MUST NOT be committed
echo "debug output" > app.log                    # ignored build junk
echo "print('app')" > app.py                      # real source
git add .
git commit -m "chore: add app and gitignore (secrets excluded)"
git status --ignored
