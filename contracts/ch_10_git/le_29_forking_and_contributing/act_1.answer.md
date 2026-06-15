# Activity Answer — Forking And Contributing

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 29 — Fork & contribute: contribute to an upstream project via a fork.
set -e
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

## Step-by-step explanation

- `git clone upstream.git maint` — Maintainer seeds upstream:
- `git clone --bare upstream.git fork.git` — Your fork = a server-side copy of upstream:
- `git clone fork.git contrib` — You clone YOUR fork and add 'upstream' to stay in sync:
- `( cd maint` — Maintainer reviews the fork's branch and merges it into upstream:

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
