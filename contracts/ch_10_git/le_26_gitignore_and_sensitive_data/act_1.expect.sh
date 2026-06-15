#!/usr/bin/env bash
set -e
tracked="$(git ls-files)"
echo "$tracked" | grep -qx .gitignore || { echo "FAIL: .gitignore not tracked"; exit 1; }
echo "$tracked" | grep -qx app.py     || { echo "FAIL: app.py not tracked"; exit 1; }
echo "$tracked" | grep -qx .env  && { echo "FAIL: .env was committed (secret leak!)"; exit 1; } || true
echo "$tracked" | grep -qx app.log && { echo "FAIL: app.log should be ignored"; exit 1; } || true
git check-ignore .env >/dev/null || { echo "FAIL: .env not actually ignored"; exit 1; }
echo "PASS le_26"
