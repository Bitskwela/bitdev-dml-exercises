#!/usr/bin/env bash
# Lesson 02 — Creating your first repository: init, explore .git, first files.
set -e
mkdir barangay-marketplace-system
cd barangay-marketplace-system
git init
echo "# Barangay Marketplace Payment System" > README.md
echo "*.pyc" > .gitignore
echo "print('Processing marketplace payments')" > payment_processor.py
git status                                  # all three are 'untracked'
