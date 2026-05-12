# Linear Regression From Scratch

Build a `LinearRegressionScratch` class in ~15 lines of numpy.

---

## Task 1: Implement the Class

Open `act_1.py`. Implement:

```python
class LinearRegressionScratch:
    def fit(self, X, y):
        # 1. Add an all-1s column to X for the intercept
        # 2. Solve w = (X.T @ X)^-1 @ X.T @ y   via np.linalg.solve
        # 3. Save self.intercept_ = w[0] and self.coef_ = w[1:]
        ...

    def predict(self, X):
        # 1. Add an all-1s column
        # 2. Return X_bias @ self.weights_
        ...
```

---

## Task 2: Fit on Carinderia Revenue

Use the inline 30-row CSV. Build features: `day_of_month`, `is_payday_int`, `is_friday`. Predict `revenue`.

Split 80/20. Fit on train. Predict on test. Print MAE.

Also print the weights with their feature names — verify that `is_payday` has the largest positive coefficient.

---

## Sample Output

```
=================================================================
  LINEAR REGRESSION — FROM SCRATCH
=================================================================
   Intercept (b):      795.4
   weight day_of_month   0.65
   weight is_payday    288.1     <-- largest
   weight is_friday     65.5

   Test MAE: P228.45

-- Read the weights --
   revenue ≈ 795
           + 0.65 × day_of_month
           + 288.1 × is_payday
           + 65.5 × is_friday
```

---

## Reflection Questions

1. The weight on `is_payday` is the largest. What does that tell you about the carinderia?
2. The model is linear and ADDITIVE. Why can't it capture "payday AND Friday is *extra* special"?
3. Why is `np.linalg.solve(X.T @ X, X.T @ y)` better than `np.linalg.inv(X.T @ X) @ X.T @ y`?

---

## Challenge: Add More Features

Add one-hot encoded weather columns (`is_rainy`, `is_sunny`). Refit. Does MAE drop?

You should see ~10-15% MAE reduction without changing the algorithm. That's a preview of Lesson 12 — feature engineering.

---

## What You've Learned

- Linear regression's closed-form normal equation as one numpy line
- How to read learned weights as plain-English insights
- How `LinearRegressionScratch` mirrors the sklearn API (fit / predict)
