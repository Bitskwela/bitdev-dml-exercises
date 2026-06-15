# Hands-On Lab — Interactive Rebasing

## Goal

squash three messy WIP commits into one.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- and auto-accept the combined commit message.

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
echo "1" > f.txt; git add f.txt; git commit -m "WIP: start search"
echo "2" >> f.txt; git add f.txt; git commit -m "WIP: typo"
echo "3" >> f.txt; git add f.txt; git commit -m "WIP: finish search"
# Non-interactive drive of `rebase -i`: turn the 2nd and 3rd picks into squashes,
# and auto-accept the combined commit message.
GIT_SEQUENCE_EDITOR='sed -i -e "2,\$ s/^pick/squash/"' GIT_EDITOR=true \
  git rebase -i HEAD~3
git log --oneline
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
