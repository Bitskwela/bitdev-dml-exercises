# ============================================
# FEATURE / LABEL SPLITTER — Lesson 3
# by: <Your Name>
# ============================================
# Split a list-of-dicts into (X, y) for any chosen label.
# Pure stdlib. No pandas yet.
# ============================================

# Six rows from Tita Malou's August notebook
rows = [
    {"date": "2025-08-01", "item": "Sinigang",  "quantity": 13,
     "revenue": 910, "day_of_week": "Friday",    "is_payday": False, "weather": "cloudy"},
    {"date": "2025-08-02", "item": "Kare-Kare", "quantity": 8,
     "revenue": 944, "day_of_week": "Saturday",  "is_payday": False, "weather": "rainy"},
    {"date": "2025-08-03", "item": "Adobo",     "quantity": 14,
     "revenue": 1050,"day_of_week": "Sunday",    "is_payday": False, "weather": "sunny"},
    {"date": "2025-08-15", "item": "Sinigang",  "quantity": 21,
     "revenue": 1575,"day_of_week": "Friday",    "is_payday": True,  "weather": "rainy"},
    {"date": "2025-08-15", "item": "Kare-Kare", "quantity": 14,
     "revenue": 1652,"day_of_week": "Friday",    "is_payday": True,  "weather": "rainy"},
    {"date": "2025-08-30", "item": "Lechon Kawali","quantity": 11,
     "revenue": 1540,"day_of_week": "Saturday",  "is_payday": True,  "weather": "sunny"},
]


def split_features_labels(rows, label_col, drop_cols=()):
    """
    Return (X, y).
      X: list of feature-only dicts (one per row)
      y: list of label values
    drop_cols are columns excluded from features (use to prevent leakage).
    """
    # TODO: build X and y by looping over rows.
    # For each row:
    #   - append row[label_col] to y
    #   - build a dict with every key EXCEPT label_col and the drop_cols, append to X
    X, y = [], []
    return X, y


# === Problem 1: predict revenue (drop quantity = leakage) ===
print("=" * 60)
print("  PROBLEM 1 — Predict revenue")
print("=" * 60)
# TODO: call split_features_labels with label_col="revenue", drop_cols=("quantity",)
# Then print features list and labels.


# === Problem 2: classify busy days (revenue > 1200) ===
print()
print("=" * 60)
print("  PROBLEM 2 — Classify day as busy/slow")
print("=" * 60)
# TODO: derive a new column is_busy = (revenue > 1200) for each row.
# Then split with label_col="is_busy", drop_cols=("revenue", "quantity").


# === Problem 3: predict sinigang quantity ===
print()
print("=" * 60)
print("  PROBLEM 3 — Predict quantity (sinigang rows only)")
print("=" * 60)
# TODO: filter rows to only those with item == "Sinigang".
# Then split with label_col="quantity", drop_cols=("revenue",).
