#!/usr/bin/env bash
set -e
[ -f maint/CONTRIBUTING.md ] || { echo "FAIL: contribution not merged upstream"; exit 1; }
( cd maint && git log --oneline | grep -q "docs: add contributing guide" ) || { echo "FAIL: contributor commit missing upstream"; exit 1; }
echo "PASS le_29"
