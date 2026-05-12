# One Function from CSV to CV Score

Build `def run(df, model, cv=5)` that does the whole workflow.

---

## Task: The Pipeline Function

```python
def run(df, model_factory, cv=5):
    """
    Returns (cv_mean, cv_std).
    model_factory is a zero-arg callable that builds a fresh model.
    """
    df = clean(df)              # fix dtypes
    X, y = engineer(df)         # feature engineering
    scores = stratified_cv(X, y, model_factory, k=cv)
    return float(scores.mean()), float(scores.std())
```

Reuse `stratified_kfold_cv` from Lesson 19.

---

## Task 2: Compare Three Models

Call `run(df, LogReg)`, `run(df, lambda: DecisionTreeScratch(max_depth=4))`, `run(df, lambda: RandomForestScratch(n_estimators=10))` — print mean ± std for each.

---

## Sample Output

```
   model                       CV mean        CV std
   ----------------------------------------------------
   LogisticRegression          0.799          0.018
   DecisionTree(depth=4)       0.821          0.022
   RandomForest(10 trees)      0.853          0.020
```

---

## Reflection Questions

1. What does `run(df, model)` save compared with eight separate scripts?
2. Why is the pipeline a key DEPLOYMENT pattern, not just a code-cleanup pattern?
3. How would adding scaling INSIDE the pipeline (vs. outside) prevent data leakage?

---

## What You've Learned

- The `def run(df, model)` pattern for end-to-end pipelines
- Why pipelines prevent leakage and ensure consistency
- How to compare models apples-to-apples
