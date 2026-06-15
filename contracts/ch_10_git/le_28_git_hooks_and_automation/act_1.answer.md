# Activity Answer — Git Hooks And Automation

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
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
```

## Step-by-step explanation

- `if git diff --cached | grep -q "TODO"; then` — Reject a commit if any staged file still contains a TODO marker.
- `echo "x = 1  # TODO finish this" > feature.py` — A file with a TODO should be BLOCKED by the hook:
- `echo "x = 1" > feature.py` — Clean it up, and the commit succeeds:

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
