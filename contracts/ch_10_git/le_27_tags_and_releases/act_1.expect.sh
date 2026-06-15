#!/usr/bin/env bash
set -e
git tag | grep -qx v1.0.0 || { echo "FAIL: v1.0.0 tag missing"; exit 1; }
git tag | grep -qx v1.0.0-beta || { echo "FAIL: v1.0.0-beta tag missing"; exit 1; }
# annotated tags are 'tag' objects; lightweight ones are 'commit'
[ "$(git cat-file -t v1.0.0)" = "tag" ] || { echo "FAIL: v1.0.0 should be annotated"; exit 1; }
echo "PASS le_27"
