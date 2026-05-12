# 5-Fold Cross Validation From Scratch

Implement manual stratified 5-fold CV in ~30 lines.

---

## Task: The CV Function

```python
def stratified_kfold_cv(X, y, k=5, seed=42):
    """Return array of fold scores."""
    rng = np.random.default_rng(seed)
    # 1. Build stratified fold indices: for each class, shuffle its rows
    #    and split into k chunks; combine across classes
    # 2. For each fold i (i = 0..k-1):
    #    - test = fold i
    #    - train = all other folds combined
    #    - fit a model
    #    - score on test
    #    - append to scores
    # 3. Return np.array(scores)
```

Pass a `model_factory` (a function returning a fresh model) so each fold trains from scratch.

---

## Task 2: Compare Two Models

Run CV on:

1. A `LogisticRegressionScratch` (Lesson 13)
2. A `RandomForestScratch` (Lesson 15, n_estimators=10, max_depth=4)

Print mean and std for each. The forest should win — by how much?

---

## Sample Output

```
   LogisticRegression:  mean=0.799  std=0.018
   RandomForest:        mean=0.856  std=0.020
   Forest advantage:    +0.057 (5.7pp)
```

---

## Reflection Questions

1. Why is "0.88 from a single test split" misleading without a std?
2. If your model has mean=0.86 ± 0.02 and a competitor's is 0.87 ± 0.05 — are they meaningfully different?
3. Why does CV preserve class ratios per fold for classification (stratified)?

---

## What You've Learned

- Manual stratified 5-fold CV in numpy
- Mean ± std as the honest evaluation report
- Why a confidence interval beats a point estimate
