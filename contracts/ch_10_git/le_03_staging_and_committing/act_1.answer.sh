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
