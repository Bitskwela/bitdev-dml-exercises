#!/usr/bin/env bash
set -e
[ -f search.py ] || { echo "FAIL: search.py not merged"; exit 1; }
git show-ref --verify --quiet refs/heads/feature/search && { echo "FAIL: branch should be deleted"; exit 1; } || true
parents="$(git cat-file -p HEAD | grep -c '^parent ')"
[ "$parents" = "2" ] || { echo "FAIL: expected a --no-ff merge commit"; exit 1; }
echo "PASS le_10"
