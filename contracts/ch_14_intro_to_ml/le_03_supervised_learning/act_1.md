# Split Features and Labels

Build a function that takes a list-of-dicts (one dict per row) and splits each row into features (X) and a label (y). Pure stdlib — no pandas yet.

---

## Task 1: Implement `split_features_labels`

Open `act_1.py`. Implement:

```python
def split_features_labels(rows, label_col, drop_cols=()):
    """Return (X, y). X is list of dicts (features); y is list of values."""
```

The function should:
1. Pull the value of `label_col` out of each row → that becomes `y`.
2. Build a new dict for each row containing every key EXCEPT `label_col` AND the keys in `drop_cols`. That dict becomes a row of `X`.

---

## Task 2: Run Three Different Problems

The starter has 6 carinderia rows. Use your function to set up THREE supervised problems:

1. **Predict revenue** — `label_col="revenue"`, `drop_cols=("quantity",)` (quantity leaks!)
2. **Classify busy days** — derive a new column `is_busy = revenue > 1200`, then `label_col="is_busy"`, `drop_cols=("revenue", "quantity")`
3. **Predict quantity (sinigang only)** — filter rows where `item == "Sinigang"`, then `label_col="quantity"`, `drop_cols=("revenue",)`

Print the features list and labels for each problem.

---

## Sample Output

```
============================================================
  PROBLEM 1 — Predict revenue
============================================================
Features per row: ['date', 'day_of_week', 'is_payday', 'item', 'weather']
Labels: [910, 944, 1050, 1575, 1652, 1540]
```

---

## Reflection Questions

1. Why must `quantity` be dropped from features when predicting revenue?
2. For Problem 2, why must BOTH `revenue` and `quantity` be dropped?
3. Could you re-use this same data to predict `weather`? Why or why not?

---

## What You've Learned

- Every supervised row decomposes into (features, label)
- The same dataset supports many problems — depending on which column you pick as label
- Always drop columns that would leak the answer
