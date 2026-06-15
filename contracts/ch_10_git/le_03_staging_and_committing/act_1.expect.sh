#!/usr/bin/env bash
set -e
[ "$(git rev-list --count HEAD)" = "1" ] || { echo "FAIL: expected 1 commit"; exit 1; }
tracked="$(git ls-files)"
echo "$tracked" | grep -qx discount.py || { echo "FAIL: discount.py not committed"; exit 1; }
echo "$tracked" | grep -qx logger.py   || { echo "FAIL: logger.py not committed"; exit 1; }
echo "$tracked" | grep -qx email.py    && { echo "FAIL: email.py should NOT be committed"; exit 1; } || true
git status --porcelain | grep -q '^?? email.py'   || { echo "FAIL: email.py should be untracked"; exit 1; }
git status --porcelain | grep -q '^?? payment.py' || { echo "FAIL: payment.py should be untracked"; exit 1; }
echo "PASS le_03"
