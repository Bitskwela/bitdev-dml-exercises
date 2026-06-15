#!/usr/bin/env bash
set -e
cd devA
# fetch should NOT have changed the working file yet
[ "$(wc -l < app.py)" = "1" ] || { echo "FAIL: working tree changed before merge"; exit 1; }
# origin/main must be ahead of local main
[ "$(git rev-parse main)" != "$(git rev-parse origin/main)" ] || { echo "FAIL: origin/main not fetched"; exit 1; }
git merge origin/main
[ "$(git rev-parse main)" = "$(git rev-parse origin/main)" ] || { echo "FAIL: merge did not sync"; exit 1; }
echo "PASS le_15"
