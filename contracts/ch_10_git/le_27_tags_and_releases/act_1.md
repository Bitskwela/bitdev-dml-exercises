# Hands-On Lab — Tags And Releases

## Goal

mark a version with an annotated tag.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- Work through each command and observe what Git does.

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init
echo "v1 code" > app.py; git add app.py; git commit -m "feat: first release-ready build"
git tag v1.0.0-beta                                  # lightweight tag
git tag -a v1.0.0 -m "Barangay Marketplace 1.0.0"    # annotated release tag
git tag
git show v1.0.0 --quiet
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
