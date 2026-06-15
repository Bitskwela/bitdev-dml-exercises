#!/usr/bin/env bash
set -e
# restore worked: config.py has no 'oops' line
grep -q "oops" config.py && { echo "FAIL: restore did not discard the bad edit"; exit 1; } || true
# revert worked: bug.py removed by the revert commit, and 3 commits exist (add, bug, revert)
[ -f bug.py ] && { echo "FAIL: revert should have removed bug.py"; exit 1; } || true
[ "$(git rev-list --count HEAD)" = "3" ] || { echo "FAIL: expected 3 commits (add, bug, revert)"; exit 1; }
git log --oneline | grep -qi "revert" || { echo "FAIL: no revert commit found"; exit 1; }
echo "PASS le_05"
