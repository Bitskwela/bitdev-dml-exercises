#!/usr/bin/env bash
set -e
[ -f hotfix.py ] || { echo "FAIL: hotfix commit missing"; exit 1; }
[ -f wip.py ] || { echo "FAIL: stashed WIP not restored after pop"; exit 1; }
[ -z "$(git stash list)" ] || { echo "FAIL: stash should be empty after pop"; exit 1; }
echo "PASS le_22"
