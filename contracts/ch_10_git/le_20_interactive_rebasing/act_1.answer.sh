#!/usr/bin/env bash
# Lesson 20 — Interactive rebase: squash three messy WIP commits into one.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
echo "1" > f.txt; git add f.txt; git commit -m "WIP: start search"
echo "2" >> f.txt; git add f.txt; git commit -m "WIP: typo"
echo "3" >> f.txt; git add f.txt; git commit -m "WIP: finish search"
# Non-interactive drive of `rebase -i`: turn the 2nd and 3rd picks into squashes,
# and auto-accept the combined commit message.
GIT_SEQUENCE_EDITOR='sed -i -e "2,\$ s/^pick/squash/"' GIT_EDITOR=true \
  git rebase -i HEAD~3
git log --oneline
