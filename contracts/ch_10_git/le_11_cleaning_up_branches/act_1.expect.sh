#!/usr/bin/env bash
set -e
git show-ref --verify --quiet refs/heads/feature/done && { echo "FAIL: feature/done not deleted"; exit 1; } || true
git show-ref --verify --quiet refs/heads/feature/abandoned && { echo "FAIL: feature/abandoned not deleted"; exit 1; } || true
[ "$(git branch | wc -l)" = "1" ] || { echo "FAIL: only main should remain"; exit 1; }
echo "PASS le_11"
