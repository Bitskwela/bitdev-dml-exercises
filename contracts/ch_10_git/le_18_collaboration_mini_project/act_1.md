# Hands-On Lab — Collaboration Mini Project

## Goal

two devs ship features through origin.

> This is a **hands-on lab**, not an essay. You run real Git commands and an
> automated checker verifies your repository's final state. Work in a scratch
> folder so you can experiment freely.

## What you'll accomplish

- Dev A: payments on a feature branch, merged + pushed
- Dev B: sync, then ship reports

## Guided steps

Open a terminal in an empty folder and work through these. Try to predict each
result before you run it:

```bash
git init --bare origin.git
git clone origin.git devA
( cd devA; echo "# App" > README.md; git add README.md; git commit -m "Init"; git push -u origin main )
git clone origin.git devB
# Dev A: payments on a feature branch, merged + pushed
( cd devA
  git switch -c feature/payments
  echo "pay()" > payments.py; git add payments.py; git commit -m "Add payments"
  git switch main; git merge --no-ff -m "Merge payments" feature/payments; git push origin main )
# Dev B: sync, then ship reports
( cd devB
  git pull --no-rebase origin main
  git switch -c feature/reports
  echo "report()" > reports.py; git add reports.py; git commit -m "Add reports"
  git switch main; git merge --no-ff -m "Merge reports" feature/reports; git push origin main )
( cd devA; git pull --no-rebase origin main )    # A ends with both features
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
