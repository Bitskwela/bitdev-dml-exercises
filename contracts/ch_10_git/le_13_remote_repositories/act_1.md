# Hands-On Lab — Remote Repositories

## Goal

create a bare 'origin' (stands in for GitHub) and push.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- Work through each command and observe what Git does.

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init --bare origin.git              # the shared remote repository
git clone origin.git marketplace        # working clone
cd marketplace
echo "# Marketplace" > README.md
git add README.md; git commit -m "Initial commit"
git remote -v                           # 'origin' points at ../origin.git
git push -u origin main                 # publish main to the remote
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
