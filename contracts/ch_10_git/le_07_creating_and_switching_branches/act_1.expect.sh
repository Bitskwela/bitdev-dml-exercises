#!/usr/bin/env bash
set -e
[ "$(git rev-parse --abbrev-ref HEAD)" = "main" ] || { echo "FAIL: not on main"; exit 1; }
[ -f voting.py ] && { echo "FAIL: voting.py should not exist on main"; exit 1; } || true
git switch feature/voting 2>/dev/null
[ -f voting.py ] || { echo "FAIL: voting.py should exist on feature/voting"; exit 1; }
git log --oneline | grep -q "Add voting feature" || { echo "FAIL: feature commit missing"; exit 1; }
echo "PASS le_07"
