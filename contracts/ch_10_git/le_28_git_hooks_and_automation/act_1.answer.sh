#!/usr/bin/env bash
# Lesson 28 — Git hooks: a pre-commit hook that blocks leftover TODO markers.
set -e
git init
cat > .git/hooks/pre-commit <<'HOOK'
#!/usr/bin/env bash
# Reject a commit if any staged file still contains a TODO marker.
if git diff --cached | grep -q "TODO"; then
  echo "pre-commit: remove TODO markers before committing." >&2
  exit 1
fi
exit 0
HOOK
chmod +x .git/hooks/pre-commit

# A file with a TODO should be BLOCKED by the hook:
echo "x = 1  # TODO finish this" > feature.py
git add feature.py
git commit -m "feat: add feature" || echo ">> commit blocked by hook (expected)"

# Clean it up, and the commit succeeds:
echo "x = 1" > feature.py
git add feature.py
git commit -m "feat: add feature"
