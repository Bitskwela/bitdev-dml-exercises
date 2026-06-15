#!/usr/bin/env bash
# Lesson 13 — Remotes: create a bare 'origin' (stands in for GitHub) and push.
set -e
git init --bare origin.git              # the shared remote repository
git clone origin.git marketplace        # working clone
cd marketplace
echo "# Marketplace" > README.md
git add README.md; git commit -m "Initial commit"
git remote -v                           # 'origin' points at ../origin.git
git push -u origin main                 # publish main to the remote
