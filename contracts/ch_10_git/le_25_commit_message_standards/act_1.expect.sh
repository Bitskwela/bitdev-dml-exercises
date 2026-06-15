#!/usr/bin/env bash
set -e
git log --format='%s' | grep -Eq '^feat(\(.+\))?: ' || { echo "FAIL: no conventional feat commit"; exit 1; }
git log --format='%s' | grep -Eq '^fix(\(.+\))?: '  || { echo "FAIL: no conventional fix commit"; exit 1; }
git log --format='%s' | grep -Eq '^chore(\(.+\))?: '|| { echo "FAIL: no conventional chore commit"; exit 1; }
echo "PASS le_25"
