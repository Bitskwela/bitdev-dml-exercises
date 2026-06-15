#!/usr/bin/env bash
# Lesson 27 — Tags & releases: mark a version with an annotated tag.
set -e
git init
echo "v1 code" > app.py; git add app.py; git commit -m "feat: first release-ready build"
git tag v1.0.0-beta                                  # lightweight tag
git tag -a v1.0.0 -m "Barangay Marketplace 1.0.0"    # annotated release tag
git tag
git show v1.0.0 --quiet
