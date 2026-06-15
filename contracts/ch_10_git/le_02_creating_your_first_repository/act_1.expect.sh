#!/usr/bin/env bash
set -e
cd barangay-marketplace-system
[ -d .git ] || { echo "FAIL: repo not initialized"; exit 1; }
for f in README.md .gitignore payment_processor.py; do
  [ -f "$f" ] || { echo "FAIL: $f missing"; exit 1; }
done
# brand-new repo: no commits yet, files are untracked
git rev-parse HEAD 2>/dev/null && { echo "FAIL: unexpected commit"; exit 1; } || true
git status --porcelain | grep -q '^?? README.md' || { echo "FAIL: README.md should be untracked"; exit 1; }
echo "PASS le_02"
