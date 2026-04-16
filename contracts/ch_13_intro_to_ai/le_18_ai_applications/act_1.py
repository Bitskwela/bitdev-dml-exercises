# luto_ai.py
# ============================================
# LUTO AI — Carinderia Inventory Prototype
# by: <Your Name>
# ============================================

import random
from collections import defaultdict

random.seed(42)

DAYS_OF_WEEK = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
MENU = ["Adobo", "Sinigang", "Bistek", "Tinola", "Kare-Kare"]

# Generate 30 days of sales
# Weekdays: low-med demand, Weekends: high
DEMAND_PROFILE = {
    "Monday": 15, "Tuesday": 18, "Wednesday": 20, "Thursday": 22,
    "Friday": 30, "Saturday": 35, "Sunday": 32,
}

history = []
for day_idx in range(30):
    dow = DAYS_OF_WEEK[day_idx % 7]
    base = DEMAND_PROFILE[dow]
    for dish in MENU:
        sold = max(1, int(base + random.gauss(0, 4)))
        history.append({"day": day_idx + 1, "day_of_week": dow, "dish": dish, "sold": sold})

print("=" * 55)
print("  LUTO AI — Carinderia Demand Predictor")
print("=" * 55)
print(f"  History loaded: {len(history)} records across 30 days")

# TODO: Task 2 — Compute day-of-week average demand per dish


# TODO: Task 3 — Demand prediction function (weighted moving average)
# def predict_demand(dish, dow): ...


# TODO: Task 4 — Prep recommendations for tomorrow
# For each dish, predict + 15% buffer


# TODO: Task 5 — Low stock alerts
# stock = {"rice_kg": 5, "sinigang_mix": 2, "pork_kg": 0.5, "coconut_milk": 3}
# thresholds = {"rice_kg": 10, "sinigang_mix": 3, "pork_kg": 2, "coconut_milk": 2}
