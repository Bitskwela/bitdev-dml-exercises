# Hands-On Lab — Gitignore And Sensitive Data

## Goal

keep secrets and build junk out of version control.

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
printf '.env\n*.log\n__pycache__/\n' > .gitignore
echo "API_KEY=super-secret-123" > .env          # MUST NOT be committed
echo "debug output" > app.log                    # ignored build junk
echo "print('app')" > app.py                      # real source
git add .
git commit -m "chore: add app and gitignore (secrets excluded)"
git status --ignored
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
