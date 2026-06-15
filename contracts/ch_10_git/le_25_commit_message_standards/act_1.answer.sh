#!/usr/bin/env bash
# Lesson 25 — Conventional Commits: type(scope): summary.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "chore: initialize project"
echo "pay()" > payments.py; git add payments.py; git commit -m "feat(payments): add GCash payment option"
sed -i 's/pay()/pay() # fixed/' payments.py; git add payments.py; git commit -m "fix(payments): correct rounding of centavos"
git log --oneline
