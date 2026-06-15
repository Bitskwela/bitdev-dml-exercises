#!/usr/bin/env bash
set -e
[ -x .git/hooks/pre-commit ] || { echo "FAIL: pre-commit hook not installed/executable"; exit 1; }
[ "$(git rev-list --count HEAD)" = "1" ] || { echo "FAIL: expected exactly 1 commit (TODO one blocked)"; exit 1; }
grep -q "TODO" feature.py && { echo "FAIL: committed file still has TODO"; exit 1; } || true
echo "PASS le_28"
