# Hands-On Lab — Handling Remote Rejections

## Goal

a non-fast-forward push is refused; pull, then push.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- A pushes first...
- B committed on the old base and is now behind -> push is REJECTED

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "base" > app.py; git add app.py; git commit -m "base"; git push -u origin main )
git clone origin.git devB
# A pushes first...
( cd devA; echo "A change" > a.py; git add a.py; git commit -m "A work"; git push origin main )
# B committed on the old base and is now behind -> push is REJECTED
cd devB
echo "B change" > b.py; git add b.py; git commit -m "B work"
git push origin main || echo ">> push rejected (non-fast-forward), as expected"
git pull --no-rebase origin main        # integrate A's work first
git push origin main                     # now it succeeds
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
