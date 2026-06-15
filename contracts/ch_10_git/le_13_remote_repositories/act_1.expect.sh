#!/usr/bin/env bash
set -e
cd marketplace
git remote | grep -qx origin || { echo "FAIL: no origin remote"; exit 1; }
git ls-remote origin | grep -q "refs/heads/main" || { echo "FAIL: main not pushed to origin"; exit 1; }
[ "$(git rev-parse main)" = "$(git rev-parse origin/main)" ] || { echo "FAIL: origin/main not in sync"; exit 1; }
echo "PASS le_13"
