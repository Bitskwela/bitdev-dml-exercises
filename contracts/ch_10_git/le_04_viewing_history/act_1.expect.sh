#!/usr/bin/env bash
set -e
[ "$(git rev-list --count HEAD)" = "3" ] || { echo "FAIL: expected 3 commits"; exit 1; }
git log --oneline | grep -q "Add receipt printing" || { echo "FAIL: latest commit message missing"; exit 1; }
git log --oneline | grep -q "Add payment skeleton" || { echo "FAIL: first commit message missing"; exit 1; }
echo "PASS le_04"
