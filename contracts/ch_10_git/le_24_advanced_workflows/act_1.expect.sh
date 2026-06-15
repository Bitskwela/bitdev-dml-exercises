#!/usr/bin/env bash
set -e
[ -f wallet.py ] || { echo "FAIL: wallet feature not merged"; exit 1; }
git show-ref --verify --quiet refs/heads/feature/wallet && { echo "FAIL: feature branch not cleaned up"; exit 1; } || true
parents="$(git cat-file -p HEAD | grep -c '^parent ')"
[ "$parents" = "2" ] || { echo "FAIL: expected a --no-ff merge commit"; exit 1; }
echo "PASS le_24"
