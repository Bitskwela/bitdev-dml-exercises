#!/usr/bin/env bash
set -e
[ -f work2.py ] || { echo "FAIL: did not recover the dropped commit"; exit 1; }
[ "$(git rev-list --count HEAD)" = "3" ] || { echo "FAIL: expected 3 commits after recovery"; exit 1; }
git log --oneline | grep -q "Important work 2" || { echo "FAIL: recovered commit missing"; exit 1; }
echo "PASS le_23"
