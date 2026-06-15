#!/usr/bin/env bash
set -e
git show-ref --verify --quiet refs/heads/feature/payments || { echo "FAIL: feature/payments missing"; exit 1; }
git show-ref --verify --quiet refs/heads/feature/audit-logging || { echo "FAIL: feature/audit-logging missing"; exit 1; }
[ "$(git rev-parse --abbrev-ref HEAD)" = "main" ] || { echo "FAIL: should still be on main"; exit 1; }
echo "PASS le_06"
