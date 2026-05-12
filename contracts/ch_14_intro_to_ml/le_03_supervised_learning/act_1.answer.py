# ============================================
# FEATURE / LABEL SPLITTER — Full Solution
# Lesson 3 by Dan Santos
# ============================================

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
    X, y = [], []
    for row in rows:
        if label_col not in row:
            raise KeyError(f"Missing label column: {label_col!r}")
        y.append(row[label_col])
        feats = {k: v for k, v in row.items()
                 if k != label_col and k not in drop_cols}
        X.append(feats)
    return X, y


# Problem 1
print("=" * 60)
print("  PROBLEM 1 — Predict revenue (drop quantity = leakage)")
print("=" * 60)
X1, y1 = split_features_labels(rows, label_col="revenue", drop_cols=("quantity",))
print(f"Features per row: {sorted(X1[0].keys())}")
print(f"Labels: {y1}")
print(f"Sample X[0]: {X1[0]}")

# Problem 2
print()
print("=" * 60)
print("  PROBLEM 2 — Classify day as busy/slow")
print("=" * 60)
busy_rows = [{**r, "is_busy": r["revenue"] > 1200} for r in rows]
X2, y2 = split_features_labels(
    busy_rows, label_col="is_busy", drop_cols=("revenue", "quantity"),
)
print(f"Features per row: {sorted(X2[0].keys())}")
print(f"Labels: {y2}")

# Problem 3
print()
print("=" * 60)
print("  PROBLEM 3 — Predict quantity (sinigang only)")
print("=" * 60)
sinigang_rows = [r for r in rows if r["item"] == "Sinigang"]
X3, y3 = split_features_labels(
    sinigang_rows, label_col="quantity", drop_cols=("revenue",),
)
print(f"Features per row: {sorted(X3[0].keys())}")
print(f"Labels: {y3}")

print()
print("-- Takeaway --")
print("   Same six rows. Three different supervised problems.")
print("   The label changes; the leakage-aware drops change with it.")
print("   This is the shape every supervised model trains on.")
