# Hands-On Lab — Forking And Contributing

## Goal

contribute to an upstream project via a fork.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- Maintainer seeds upstream:
- Your fork = a server-side copy of upstream:
- You clone YOUR fork and add 'upstream' to stay in sync:
- Maintainer reviews the fork's branch and merges it into upstream:

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init --bare upstream.git
# Maintainer seeds upstream:
git clone upstream.git maint
( cd maint; echo "# Bitskwela" > README.md; git add README.md; git commit -m "chore: init"; git push -u origin main )
# Your fork = a server-side copy of upstream:
git clone --bare upstream.git fork.git
# You clone YOUR fork and add 'upstream' to stay in sync:
git clone fork.git contrib
( cd contrib
  git remote add upstream ../upstream.git
  git switch -c feature/docs
  echo "Contributing guide" > CONTRIBUTING.md; git add CONTRIBUTING.md; git commit -m "docs: add contributing guide"
  git push origin feature/docs )
# Maintainer reviews the fork's branch and merges it into upstream:
( cd maint
  git remote add fork ../fork.git
  git fetch fork
  git merge --no-ff -m "Merge fork: docs contribution" fork/feature/docs
  git push origin main )
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
