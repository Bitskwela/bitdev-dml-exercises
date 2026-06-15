#!/usr/bin/env bash
set -e
[ -f hotfix.py ] || { echo "FAIL: rebase did not bring main's hotfix under feature"; exit 1; }
[ -f api.py ] || { echo "FAIL: api.py missing after rebase"; exit 1; }
# linear: every commit reachable from HEAD has <=1 parent (no merge commits)
git rev-list --merges HEAD | grep -q . && { echo "FAIL: history is not linear"; exit 1; } || true
git merge-base --is-ancestor main HEAD || { echo "FAIL: feature not rebased onto main"; exit 1; }
echo "PASS le_19"
