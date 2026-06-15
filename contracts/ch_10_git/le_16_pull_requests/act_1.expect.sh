#!/usr/bin/env bash
set -e
cd marketplace
[ -f login.py ] || { echo "FAIL: PR feature not merged"; exit 1; }
git ls-remote origin | grep -q "refs/heads/feature/login" || { echo "FAIL: feature branch not pushed"; exit 1; }
git log --oneline | grep -qi "Merge pull request" || { echo "FAIL: no PR merge commit"; exit 1; }
[ "$(git rev-parse main)" = "$(git rev-parse origin/main)" ] || { echo "FAIL: main not pushed"; exit 1; }
echo "PASS le_16"
