# Split From Scratch

Implement an 80/20 split in pure numpy. Then a stratified version.

---

## Task 1: Random 80/20 Split

Open `act_1.py`. Implement:

```python
def manual_split(X, y, test_size=0.2, seed=42):
    """Return (X_train, X_test, y_train, y_test)."""
```

Use `np.random.default_rng(seed)` and `.permutation` to shuffle indices, then slice.

---

## Task 2: Stratified Split

Implement `stratified_split(X, y, test_size=0.2, seed=42)`. For each unique class in `y`:

1. Get the indices of rows belonging to that class
2. Shuffle them
3. Split that class's indices 80/20
4. Combine across classes

The result: both train and test have the same class ratio as the full dataset.

---

## Sample Output

```
============================================================
  RANDOM SPLIT
============================================================
   Train: 24 rows, class balance: busy=8, not_busy=16
   Test:  6 rows, class balance:  busy=2, not_busy=4

============================================================
  STRATIFIED SPLIT (preserves class ratio)
============================================================
   Full ratio:  0.333 busy
   Train ratio: 0.333 busy
   Test ratio:  0.333 busy
```

---

## Reflection Questions

1. Why does the stratified split give cleaner class ratios?
2. If you re-run with `seed=7` instead of `seed=42`, the test accuracy of a real model would change. What does that drift tell you?
3. Why is `random_state` for *reproducibility* — and why is reproducibility important in ML?

---

## What You've Learned

- How to split 80/20 from scratch with numpy
- How to stratify by class for imbalanced data
- Why the three rules of test data matter
