#!/usr/bin/env bash
set -e
cd devB
git log --oneline | grep -q "A work" || { echo "FAIL: did not integrate A's work"; exit 1; }
git log --oneline | grep -q "B work" || { echo "FAIL: B's work missing"; exit 1; }
[ "$(git rev-parse main)" = "$(git rev-parse origin/main)" ] || { echo "FAIL: final push did not sync"; exit 1; }
echo "PASS le_17"
