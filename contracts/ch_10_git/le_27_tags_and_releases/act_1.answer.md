# Activity Answer — Tags And Releases

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 27 — Tags & releases: mark a version with an annotated tag.
set -e
git init
echo "v1 code" > app.py; git add app.py; git commit -m "feat: first release-ready build"
git tag v1.0.0-beta                                  # lightweight tag
git tag -a v1.0.0 -m "Barangay Marketplace 1.0.0"    # annotated release tag
git tag
git show v1.0.0 --quiet
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
