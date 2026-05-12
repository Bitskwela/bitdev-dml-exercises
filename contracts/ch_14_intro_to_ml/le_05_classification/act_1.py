# ============================================
# CLASSIFICATION BASICS — Lesson 5
# by: <Your Name>
# ============================================
# label_day(revenue) + a toy classifier + 3x3 confusion matrix.
# No real model yet — that comes in Lesson 13.
# ============================================

import numpy as np

# 20 days Dan hand-labeled at the kitchen table.
# (date, revenue, is_payday, day_of_week, weather, dan_label)
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


def label_day(revenue):
    """Map revenue (pesos) to one of: busy, normal, slow."""
    # TODO: implement using thresholds 5000 and 2000
    pass


def predict_toy(is_payday, day_of_week, weather):
    """Predict busy/normal/slow from features alone (no revenue)."""
    # TODO: implement the rules:
    #   if is_payday: return "busy"
    #   elif weather == "rainy" and day_of_week in ("Saturday", "Sunday"): "busy"
    #   elif weather == "rainy": "slow"
    #   else: "normal"
    pass


# === Sanity check: label_day vs Dan's hand labels ===
print("=" * 70)
print("  SANITY CHECK — label_day vs Dan's hand labels")
print("=" * 70)
# TODO: loop and count matches


# === Build confusion matrix ===
print()
print("=" * 70)
print("  CONFUSION MATRIX — predict_toy vs Dan's hand labels")
print("=" * 70)
classes = ["busy", "normal", "slow"]
matrix = np.zeros((3, 3), dtype=int)
# TODO: for each row, get the true label and the toy prediction,
# increment matrix[true_idx, pred_idx]

# TODO: print the matrix in a readable form
# TODO: compute accuracy = matrix.trace() / matrix.sum()
