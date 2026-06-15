#!/usr/bin/env bash
# Lesson 18 — Collaboration mini-project: two devs ship features through origin.
set -e
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "# App" > README.md; git add README.md; git commit -m "Init"; git push -u origin main )
git clone origin.git devB
# Dev A: payments on a feature branch, merged + pushed
( cd devA
  git switch -c feature/payments
  echo "pay()" > payments.py; git add payments.py; git commit -m "Add payments"
  git switch main; git merge --no-ff -m "Merge payments" feature/payments; git push origin main )
# Dev B: sync, then ship reports
( cd devB
  git pull --no-rebase origin main
  git switch -c feature/reports
  echo "report()" > reports.py; git add reports.py; git commit -m "Add reports"
  git switch main; git merge --no-ff -m "Merge reports" feature/reports; git push origin main )
( cd devA; git pull --no-rebase origin main )    # A ends with both features
