# Hands-On Lab — Capstone Contributing To Bitskwela

## Goal

full real-world flow against a shared remote.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- Feature branch -> conventional commits -> integrate with a merge commit

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init --bare origin.git
git clone origin.git bitskwela
cd bitskwela
echo "# Bitskwela Platform" > README.md
git add README.md; git commit -m "chore: initialize platform"; git push -u origin main
# Feature branch -> conventional commits -> integrate with a merge commit
git switch -c feature/leaderboard
echo "leaderboard()" > leaderboard.py; git add leaderboard.py; git commit -m "feat(game): add leaderboard"
echo "leaderboard() # tuned" > leaderboard.py; git add leaderboard.py; git commit -m "fix(game): tune scoring"
git switch main
git merge --no-ff -m "Merge feature/leaderboard" feature/leaderboard
git tag -a v1.0.0 -m "First public release"
git branch -d feature/leaderboard
git push origin main
git push origin v1.0.0
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
