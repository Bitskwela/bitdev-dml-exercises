# Activity Answer — Staging And Committing

This is the canonical, **runnable** solution. The automated grader executes
`act_1.answer.sh` in a throwaway repository and then checks the resulting
repository state with `act_1.expect.sh` (see `TESTING.md`).

## Solution (`act_1.answer.sh`)

```bash
#!/usr/bin/env bash
# Lesson 03 — Staging & committing: stage only ready files, leave WIP untracked.
set -e
git init
printf 'def calculate_discount(amount):\n    return amount * 0.1\n' > discount.py
printf 'import logging\nlogging.basicConfig(level=logging.INFO)\n' > logger.py
echo "# Email placeholder - incomplete" > email.py
printf 'def process_payment(amount):\n    pass\n' > payment.py
git add discount.py logger.py               # stage ONLY the finished work
git commit -m "Fix discount calculation and add transaction logging"
git status
```

## Step-by-step explanation

- Run the commands above in order.

## Verify

Run the lesson's checker (or `bash scripts/check-git.sh`) — it replays this
solution in a clean repo and asserts the end state. A green check means your
own commands produced the same result.
