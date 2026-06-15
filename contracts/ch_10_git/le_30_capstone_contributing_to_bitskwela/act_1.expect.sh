#!/usr/bin/env bash
set -e
cd bitskwela
[ -f leaderboard.py ] || { echo "FAIL: feature not merged"; exit 1; }
git show-ref --verify --quiet refs/heads/feature/leaderboard && { echo "FAIL: feature branch not deleted"; exit 1; } || true
[ "$(git cat-file -t v1.0.0)" = "tag" ] || { echo "FAIL: annotated release tag missing"; exit 1; }
parents="$(git cat-file -p HEAD | grep -c '^parent ')"; [ "$parents" = "2" ] || { echo "FAIL: no merge commit on main"; exit 1; }
git log --format='%s' | grep -Eq '^feat(\(.+\))?: ' || { echo "FAIL: missing conventional feat commit"; exit 1; }
[ "$(git rev-parse main)" = "$(git rev-parse origin/main)" ] || { echo "FAIL: main not pushed"; exit 1; }
git ls-remote --tags origin | grep -q v1.0.0 || { echo "FAIL: tag not pushed to origin"; exit 1; }
echo "PASS le_30"
