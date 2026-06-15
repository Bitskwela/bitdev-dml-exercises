#!/usr/bin/env bash
set -e
[ -f devA/feature.py ] || { echo "FAIL: devA did not pull B's feature.py"; exit 1; }
( cd devA && git log --oneline | grep -q "B: add feature" ) || { echo "FAIL: B's commit not in A's history"; exit 1; }
echo "PASS le_14"
