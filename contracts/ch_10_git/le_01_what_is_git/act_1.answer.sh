#!/usr/bin/env bash
# Lesson 01 — What is Git: initialize the marketplace repo and set identity.
set -e
mkdir barangay-marketplace
cd barangay-marketplace
git init                                   # create the .git repository
git config user.name "Maria Santos"        # who is making commits
git config user.email "maria@barangaymarket.ph"
echo "# Barangay Marketplace" > README.md
git add README.md
git commit -m "Initial commit: project README"
git log --oneline
