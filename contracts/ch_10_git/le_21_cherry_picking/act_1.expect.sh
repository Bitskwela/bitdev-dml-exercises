#!/usr/bin/env bash
set -e
[ -f urgent_fix.py ] || { echo "FAIL: cherry-picked commit not applied"; exit 1; }
[ -f experiment.py ] && { echo "FAIL: should NOT have brought the experimental commit"; exit 1; } || true
git log --oneline | grep -q "Urgent fix" || { echo "FAIL: urgent fix not in main history"; exit 1; }
echo "PASS le_21"
