# Activity Answer — Undoing Changes

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 05 — Undoing changes: restore a working-dir edit, then revert a commit.
set -e
git init
echo "stable line" > config.py
git add config.py; git commit -m "Add stable config"

# (a) discard an unstaged edit with restore
echo "oops bad edit" >> config.py
git restore config.py                       # back to last committed version

# (b) make a bad commit, then revert it (history-safe undo)
echo "buggy feature" > bug.py
git add bug.py; git commit -m "Add buggy feature"
git revert --no-edit HEAD                    # creates a new commit undoing the bug
git log --oneline
```

## Step-by-step explanation

- `echo "oops bad edit" >> config.py` — (a) discard an unstaged edit with restore
- `echo "buggy feature" > bug.py` — (b) make a bad commit, then revert it (history-safe undo)

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
