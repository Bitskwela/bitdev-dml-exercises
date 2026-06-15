#!/usr/bin/env bash
set -e
[ -f receipt.py ] || { echo "FAIL: receipt.py not merged into main"; exit 1; }
# fast-forward => HEAD has exactly one parent (linear, no merge commit)
parents="$(git cat-file -p HEAD | grep -c '^parent ')"
[ "$parents" -le 1 ] || { echo "FAIL: expected fast-forward (no merge commit)"; exit 1; }
[ "$(git rev-list --count HEAD)" = "2" ] || { echo "FAIL: expected 2 commits on main"; exit 1; }
echo "PASS le_08"
