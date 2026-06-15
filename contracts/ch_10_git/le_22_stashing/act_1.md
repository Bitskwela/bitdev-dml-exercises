# Hands-On Lab — Stashing

## Goal

shelve unfinished work, handle an urgent task, restore.

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
echo "base" > app.py; git add app.py; git commit -m "Base"
echo "half-done feature" > wip.py        # unstaged work in progress
git add wip.py
git stash push -m "WIP feature"           # shelve it; working tree is clean again
echo "urgent" > hotfix.py; git add hotfix.py; git commit -m "Urgent hotfix"
git stash pop                             # bring the WIP back
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
