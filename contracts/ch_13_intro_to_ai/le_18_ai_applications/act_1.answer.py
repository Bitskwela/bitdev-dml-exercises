# luto_ai.py
# ============================================
# LUTO AI — Full Solution
# by Dan Santos
# ============================================

import random
from collections import defaultdict
from statistics import mean

random.seed(42)

DAYS_OF_WEEK = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
MENU = ["Adobo", "Sinigang", "Bistek", "Tinola", "Kare-Kare"]

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

# Task 2: Day-of-week averages
print("\n-- Average demand per dish per day (last 30 days) --")
by_day_dish = defaultdict(list)
for r in history:
    by_day_dish[(r["day_of_week"], r["dish"])].append(r["sold"])

for dow in DAYS_OF_WEEK:
    row = f"   {dow:10}"
    for dish in MENU:
        avg = mean(by_day_dish[(dow, dish)])
        row += f" {dish[:8]:>8}:{avg:>5.1f}"
    print(row)

# Task 3: Prediction
def predict_demand(dish, dow):
    recent = [r["sold"] for r in history[-28:] if r["day_of_week"] == dow and r["dish"] == dish]
    overall = [r["sold"] for r in history if r["dish"] == dish]
    if recent and overall:
        return 0.7 * mean(recent) + 0.3 * mean(overall)
    if overall:
        return mean(overall)
    return 10

# Task 4: Tomorrow's prep recommendations
tomorrow = DAYS_OF_WEEK[30 % 7]
print(f"\n-- Tomorrow is {tomorrow} — recommended prep --")
total = 0
for dish in MENU:
    predicted = predict_demand(dish, tomorrow)
    recommended = int(predicted * 1.15)
    total += recommended
    print(f"   {dish:12} predicted {predicted:>5.1f}, prep {recommended:>3d} servings")
print(f"   Total servings to prep: {total}")

# Task 5: Low stock alerts
print("\n-- Stock Levels vs Thresholds --")
stock = {"rice_kg": 5, "sinigang_mix": 2, "pork_kg": 0.5, "coconut_milk": 3}
thresholds = {"rice_kg": 10, "sinigang_mix": 3, "pork_kg": 2, "coconut_milk": 2}

for ingredient in stock:
    qty = stock[ingredient]
    threshold = thresholds[ingredient]
    status = ""
    if qty < threshold * 0.5:
        status = "  🚨 CRITICAL — order ASAP"
    elif qty < threshold:
        status = "  ⚠️  LOW — order soon"
    else:
        status = "  ✅ OK"
    print(f"   {ingredient:15} {qty:>5} / threshold {threshold:>5}{status}")

# Monthly savings projection
waste_rate = 0.15   # 15% current waste
new_waste = 0.07    # predicted waste with Luto
monthly_revenue = 30000
savings = (waste_rate - new_waste) * monthly_revenue
print(f"\n-- Monthly Savings Projection --")
print(f"   Current waste: {waste_rate*100:.0f}% = P{waste_rate*monthly_revenue:.0f}/mo lost")
print(f"   With Luto:     {new_waste*100:.0f}% = P{new_waste*monthly_revenue:.0f}/mo lost")
print(f"   💰 Monthly savings: P{savings:.0f}")
print(f"   💰 Annual savings:  P{savings*12:.0f}")
