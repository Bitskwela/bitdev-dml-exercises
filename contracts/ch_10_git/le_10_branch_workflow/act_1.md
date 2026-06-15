# Hands-On Lab — Branch Workflow

## Goal

branch, build, merge with --no-ff, delete.

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
git switch -c feature/search
echo "search()" > search.py; git add search.py; git commit -m "Add search"
git switch main
git merge --no-ff -m "Merge feature/search" feature/search   # keep a merge commit
git branch -d feature/search                                  # tidy up
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
