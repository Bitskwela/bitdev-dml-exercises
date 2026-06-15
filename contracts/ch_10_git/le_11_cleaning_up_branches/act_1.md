# Hands-On Lab — Cleaning Up Branches

## Goal

delete merged branches; force-delete an unmerged one.

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
git switch -c feature/done
echo "x" > done.py; git add done.py; git commit -m "Finish feature"
git switch main
git merge --no-ff -m "Merge feature/done" feature/done
git branch -d feature/done            # safe delete (merged)

git switch -c feature/abandoned
echo "y" > scratch.py; git add scratch.py; git commit -m "Abandoned WIP"
git switch main
git branch -D feature/abandoned       # force delete (not merged)
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
