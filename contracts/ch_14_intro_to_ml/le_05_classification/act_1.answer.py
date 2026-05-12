# ============================================
# CLASSIFICATION BASICS — Full Solution
# Lesson 5 by Dan Santos
# ============================================

import numpy as np

labeled_days = [
    ("2025-08-01", 2840, False, "Friday",    "sunny",  "normal"),
    ("2025-08-02", 4100, False, "Saturday",  "sunny",  "normal"),
    ("2025-08-05", 1160, False, "Tuesday",   "cloudy", "slow"),
    ("2025-08-06", 1340, False, "Wednesday", "cloudy", "slow"),
    ("2025-08-08", 2980, False, "Friday",    "sunny",  "normal"),
    ("2025-08-15", 8920, True,  "Friday",    "rainy",  "busy"),
    ("2025-08-15", 7100, True,  "Friday",    "rainy",  "busy"),
    ("2025-08-16", 5200, False, "Saturday",  "rainy",  "busy"),
    ("2025-08-18", 1080, False, "Monday",    "rainy",  "slow"),
    ("2025-08-19", 2240, False, "Tuesday",   "sunny",  "normal"),
    ("2025-08-22", 4380, False, "Friday",    "cloudy", "normal"),
    ("2025-08-23", 4720, False, "Saturday",  "sunny",  "normal"),
    ("2025-08-25", 1410, False, "Monday",    "rainy",  "slow"),
    ("2025-08-26",  990, False, "Tuesday",   "rainy",  "slow"),
    ("2025-08-29", 5180, False, "Friday",    "sunny",  "busy"),
    ("2025-08-30", 9450, True,  "Saturday",  "sunny",  "busy"),
    ("2025-08-30", 6800, True,  "Saturday",  "sunny",  "busy"),
    ("2025-09-01", 2010, False, "Monday",    "rainy",  "normal"),
    ("2025-09-02", 1180, False, "Tuesday",   "rainy",  "slow"),
    ("2025-09-05", 4500, False, "Friday",    "sunny",  "normal"),
]


def label_day(revenue: int) -> str:
    if revenue >= 5000: return "busy"
    if revenue >= 2000: return "normal"
    return "slow"


def predict_toy(is_payday: bool, day_of_week: str, weather: str) -> str:
    if is_payday:
        return "busy"
    if weather == "rainy" and day_of_week in ("Saturday", "Sunday"):
        return "busy"
    if weather == "rainy":
        return "slow"
    return "normal"


# Sanity check
print("=" * 70)
print("  SANITY CHECK — label_day vs Dan's hand labels")
print("=" * 70)
n_correct = 0
for date, rev, payday, dow, weather, dan in labeled_days:
    auto = label_day(rev)
    if auto == dan:
        n_correct += 1
print(f"   Matches: {n_correct}/{len(labeled_days)} = {n_correct/len(labeled_days):.1%}")


# Confusion matrix
print()
print("=" * 70)
print("  CONFUSION MATRIX — predict_toy vs Dan's hand labels")
print("=" * 70)
classes = ["busy", "normal", "slow"]
class_to_idx = {c: i for i, c in enumerate(classes)}
matrix = np.zeros((3, 3), dtype=int)
for _, rev, payday, dow, weather, true_label in labeled_days:
    pred = predict_toy(payday, dow, weather)
    matrix[class_to_idx[true_label], class_to_idx[pred]] += 1

print(f"   {'':<10}" + "".join(f"  pred:{c:<6}" for c in classes))
for i, c in enumerate(classes):
    row_str = f"   true:{c:<5}"
    for j in range(3):
        row_str += f"  {matrix[i, j]:>10d}"
    print(row_str)

correct = matrix.trace()
total = matrix.sum()
print(f"\n   Correct (diagonal): {correct}")
print(f"   Total:              {total}")
print(f"   Accuracy:           {correct/total:.1%}")

print()
print("-- Takeaway --")
print("   The toy classifier is just a few if-statements — same as Luto v1.")
print("   In Lesson 13 we replace those rules with a model that LEARNS")
print("   the weights for these features from data, not from typing.")
