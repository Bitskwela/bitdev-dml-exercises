# Sweep max_depth on a Validation Set

Three-way split. Sweep `max_depth`. Pick the validation winner. Score on test ONCE.

---

## Task 1: Three-Way Split

Split 60% train / 20% validation / 20% test.

```python
X_temp, X_test = split 80/20
X_train, X_val = split X_temp 75/25  →  60/20 of original
```

---

## Task 2: Sweep max_depth

For each `depth in [1, 2, 3, 4, 5, 6, 8, 10, 12, 15]`:

1. Train `DecisionTreeScratch(max_depth=depth)` on train
2. Compute train accuracy AND validation accuracy
3. Record both + the gap

Pick the depth with highest VALIDATION accuracy.

---

## Task 3: Final Test (Touched Once)

Retrain the chosen model on train + validation combined. Predict on test. Print final accuracy.

---

## Sample Output

```
   depth   train_acc   val_acc   gap
       1       0.755     0.749  0.006
       3       0.831     0.815  0.016
       4       0.851     0.836  0.015     <-- best by val
       8       0.945     0.785  0.160     <-- overfit
      15       1.000     0.755  0.245     <-- max overfit

   Best by validation: max_depth = 4 (val_acc = 0.836)
   Final test accuracy: 0.823
```

---

## Reflection Questions

1. As `max_depth` rises, train accuracy keeps climbing. Why does validation accuracy NOT?
2. The "gap" between train and val accuracy is the overfitting signal. Why?
3. What would go wrong if you picked the depth by TEST accuracy instead of validation?

---

## What You've Learned

- Hyperparameter tuning via a manual sweep
- Three-way data splits and why each set has its own job
- The "U-shape" relationship between complexity and validation accuracy
