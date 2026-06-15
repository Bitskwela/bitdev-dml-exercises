# Activity Answer — Advanced Workflows

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 24 — Advanced workflow: clean a feature with rebase-squash, then no-ff merge.
set -e
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

## Step-by-step explanation

- `GIT_SEQUENCE_EDITOR='sed -i -e "2,\$ s/^pick/squash/"' GIT_EDITOR=true git rebase -i HEAD~2` — squash the two WIP commits into one clean commit

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
