# Hands-On Lab — Pull Requests

## Goal

push a feature branch, then integrate it like a PR.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- Reviewer approves -> integrate the PR into main with a merge commit:

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init --bare origin.git
git clone origin.git marketplace
cd marketplace
echo "base" > app.py; git add app.py; git commit -m "Base"; git push -u origin main
git switch -c feature/login
echo "login()" > login.py; git add login.py; git commit -m "Add login"
git push -u origin feature/login        # this is what opening a PR pushes
# Reviewer approves -> integrate the PR into main with a merge commit:
git switch main
git merge --no-ff -m "Merge pull request: feature/login" feature/login
git push origin main
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
