# Hands-On Lab — Advanced Workflows

## Goal

clean a feature with rebase-squash, then no-ff merge.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- squash the two WIP commits into one clean commit

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init
echo "base" > app.py; git add app.py; git commit -m "Base"
git switch -c feature/wallet
echo "a" > wallet.py; git add wallet.py; git commit -m "WIP wallet a"
echo "b" >> wallet.py; git add wallet.py; git commit -m "WIP wallet b"
# squash the two WIP commits into one clean commit
GIT_SEQUENCE_EDITOR='sed -i -e "2,\$ s/^pick/squash/"' GIT_EDITOR=true git rebase -i HEAD~2
git switch main
git merge --no-ff -m "Merge feature/wallet" feature/wallet
git branch -d feature/wallet
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
