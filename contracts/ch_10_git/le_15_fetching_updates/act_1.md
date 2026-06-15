# Hands-On Lab — Fetching Updates

## Goal

fetch updates remote-tracking refs only.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- Work through each command and observe what Git does.

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "v1" > app.py; git add app.py; git commit -m "A: base"; git push -u origin main )
git clone origin.git devB
( cd devB; echo "more" >> app.py; git add app.py; git commit -m "B: update"; git push origin main )
cd devA
git fetch origin                        # downloads commits, does NOT touch working tree
# After fetch: origin/main is ahead of local main (we have not merged yet).
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
