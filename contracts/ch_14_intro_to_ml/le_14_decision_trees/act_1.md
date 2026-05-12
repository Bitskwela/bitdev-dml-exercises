# Decision Tree From Scratch (max_depth=2)

Implement a binary-classification decision tree using recursive Gini-based splits.

---

## Task 1: Gini Helper

```python
def gini(y):
    if len(y) == 0: return 0.0
    p1 = y.mean()
    return float(1.0 - (p1 ** 2 + (1 - p1) ** 2))
```

---

## Task 2: Best-Split Finder

For each feature, for each unique value, try splitting `X[:, f] <= value`. Compute weighted Gini. Track the best.

---

## Task 3: Recursive Build

`_build(X, y, depth)` returns a dict node. Stop conditions: depth ≥ max_depth, pure (one class), or too few samples. Otherwise find best split and recurse.

---

## Task 4: Fit on Carinderia

Use the inline CSV with `is_busy` label and 4 boolean features. Train, predict, print accuracy and the rules.

---

## Sample Output

```
if is_payday_int <= 0.5:
  if is_friday <= 0.5:
    -> predict not_busy
  else:
    -> predict busy
else:
  if is_friday <= 0.5:
    -> predict busy
  else:
    -> predict busy

   Test accuracy: 0.806
   First split: is_payday (just like Tita Malou).
```

---

## Reflection Questions

1. The first split is on `is_payday`. Why is that what the algorithm chose, and does it match Tita Malou's gut?
2. Each leaf predicts a single class. Could a tree predict probabilities instead?
3. As you increase `max_depth`, accuracy first goes up then down. Why?

---

## What You've Learned

- Decision trees as flowcharts with feature-based splits
- Gini impurity as the splitting criterion
- Recursive build with depth and purity stops
- Why trees are deeply interpretable (rules readable in plain English)
