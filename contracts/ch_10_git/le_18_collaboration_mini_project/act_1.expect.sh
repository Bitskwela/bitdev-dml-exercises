#!/usr/bin/env bash
set -e
[ -f devA/payments.py ] || { echo "FAIL: payments missing in devA"; exit 1; }
[ -f devA/reports.py ]  || { echo "FAIL: reports not pulled into devA"; exit 1; }
( cd devA && git log --oneline | grep -q "Add payments" && git log --oneline | grep -q "Add reports" ) \
  || { echo "FAIL: combined history incomplete"; exit 1; }
echo "PASS le_18"
