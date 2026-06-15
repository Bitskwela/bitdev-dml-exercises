#!/usr/bin/env bash
set -e
git show-ref --verify --quiet refs/heads/develop || { echo "FAIL: develop missing"; exit 1; }
[ -f checkout.py ] || { echo "FAIL: checkout feature not released to main"; exit 1; }
[ "$(git rev-parse --abbrev-ref HEAD)" = "main" ] || { echo "FAIL: not on main"; exit 1; }
echo "PASS le_12"
