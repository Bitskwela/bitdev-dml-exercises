# Hands-On Lab — Git Hooks And Automation

## Goal

a pre-commit hook that blocks leftover TODO markers.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- Reject a commit if any staged file still contains a TODO marker.
- A file with a TODO should be BLOCKED by the hook:
- Clean it up, and the commit succeeds:

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init
cat > .git/hooks/pre-commit <<'HOOK'
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

## Verify your work

Your repository should satisfy every assertion in `act_1.expect.sh`. Self-check
the whole chapter with:

```bash
bash scripts/check-git.sh contracts/ch_10_git
```

The full worked solution lives in **`act_1.answer.sh`** (explained in
`act_1.answer.md`). Try it yourself first — the commands stick when you struggle
a little before peeking.
