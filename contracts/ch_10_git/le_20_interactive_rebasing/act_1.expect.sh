#!/usr/bin/env bash
set -e
# base + one squashed commit = 2 total
[ "$(git rev-list --count HEAD)" = "2" ] || { echo "FAIL: WIP commits not squashed into one (count=$(git rev-list --count HEAD))"; exit 1; }
# the squashed content is intact
[ "$(wc -l < f.txt)" = "3" ] || { echo "FAIL: squashed file content lost"; exit 1; }
echo "PASS le_20"
