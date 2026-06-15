#!/usr/bin/env bash
set -e
cd barangay-marketplace
[ -d .git ] || { echo "FAIL: .git not created"; exit 1; }
[ "$(git rev-parse --abbrev-ref HEAD)" = "main" ] || { echo "FAIL: default branch is not main"; exit 1; }
[ "$(git config user.name)" = "Maria Santos" ] || { echo "FAIL: user.name not set"; exit 1; }
[ "$(git rev-list --count HEAD)" = "1" ] || { echo "FAIL: expected exactly 1 commit"; exit 1; }
git ls-files | grep -qx "README.md" || { echo "FAIL: README.md not tracked"; exit 1; }
echo "PASS le_01"
