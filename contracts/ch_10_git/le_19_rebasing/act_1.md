# Hands-On Lab — Rebasing

## Goal

replay a feature on top of updated main for linear history.

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
git switch -c feature/api
echo "api()" > api.py; git add api.py; git commit -m "Add API"
git switch main
echo "hotfix" > hotfix.py; git add hotfix.py; git commit -m "Main hotfix"
git switch feature/api
git rebase main                     # move feature's commits to sit after the hotfix
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
