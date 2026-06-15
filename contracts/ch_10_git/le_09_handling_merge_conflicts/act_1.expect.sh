#!/usr/bin/env bash
set -e
grep -q "<<<<<<<" pricing.py && { echo "FAIL: conflict markers still present"; exit 1; } || true
grep -q "rate = 0.20" pricing.py || { echo "FAIL: conflict not resolved to promo rate"; exit 1; }
# a merge commit has two parents
parents="$(git cat-file -p HEAD | grep -c '^parent ')"
[ "$parents" = "2" ] || { echo "FAIL: HEAD is not a merge commit (got $parents parents)"; exit 1; }
echo "PASS le_09"
