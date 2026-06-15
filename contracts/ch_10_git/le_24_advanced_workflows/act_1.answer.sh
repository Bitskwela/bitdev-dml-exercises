#!/usr/bin/env bash
# Lesson 24 — Advanced workflow: clean a feature with rebase-squash, then no-ff merge.
set -e
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
git switch -c feature/wallet
echo "a" > wallet.py; git add wallet.py; git commit -m "WIP wallet a"
echo "b" >> wallet.py; git add wallet.py; git commit -m "WIP wallet b"
# squash the two WIP commits into one clean commit
GIT_SEQUENCE_EDITOR='sed -i -e "2,\$ s/^pick/squash/"' GIT_EDITOR=true git rebase -i HEAD~2
git switch main
git merge --no-ff -m "Merge feature/wallet" feature/wallet
git branch -d feature/wallet
