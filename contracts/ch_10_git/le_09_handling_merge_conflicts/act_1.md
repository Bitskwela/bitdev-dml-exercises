# Hands-On Lab — Handling Merge Conflicts

## Goal

two branches edit the same line; resolve by hand.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- This merge conflicts on the 'rate' line:
- Resolve: keep the promo rate, then complete the merge.

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init
echo "rate = 0.10" > pricing.py; git add pricing.py; git commit -m "Base pricing"

git switch -c feature/promo
echo "rate = 0.20" > pricing.py; git add pricing.py; git commit -m "Promo rate 20%"

git switch main
echo "rate = 0.12" > pricing.py; git add pricing.py; git commit -m "Standard rate 12%"

# This merge conflicts on the 'rate' line:
git merge feature/promo || true
# Resolve: keep the promo rate, then complete the merge.
echo "rate = 0.20" > pricing.py
git add pricing.py
git commit --no-edit                 # records the merge commit
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
