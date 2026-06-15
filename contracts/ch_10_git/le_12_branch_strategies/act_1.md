# Hands-On Lab — Branch Strategies

## Goal

a Git-flow style main + develop + feature.

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
echo "base" > app.py; git add app.py; git commit -m "Base app"
git switch -c develop                  # long-lived integration branch
git switch -c feature/checkout develop
echo "checkout()" > checkout.py; git add checkout.py; git commit -m "Add checkout"
git switch develop
git merge --no-ff -m "Merge feature/checkout into develop" feature/checkout
git switch main
git merge --no-ff -m "Release: merge develop into main" develop
git branch
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
