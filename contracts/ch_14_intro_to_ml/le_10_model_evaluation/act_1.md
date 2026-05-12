# Implement MAE, MSE, RMSE, R²

Build the four regression metrics from scratch in numpy. Then compare three predictors on a held-out test set.

---

## Task 1: Four One-Line Metrics

Open `act_1.py`. Implement:

```python
def mae(y, p):  return float(np.mean(np.abs(y - p)))
def mse(y, p):  return float(np.mean((y - p) ** 2))
def rmse(y, p): return float(np.sqrt(mse(y, p)))
def r2(y, p):
    ss_res = np.sum((y - p) ** 2)
    ss_tot = np.sum((y - np.mean(y)) ** 2)
    return float(1 - ss_res / ss_tot)
```

Sanity-check against three synthetic predictions:

1. Perfect — predictions equal labels
2. Off by 50 everywhere
3. One single prediction off by 500 (others perfect)

Note how MAE for cases (2) and (3) differ from RMSE.

---

## Task 2: Three Carinderia Predictors

Using the inline CSV, compute MAE / MSE / RMSE / R² for three predictors on the held-out test:

1. **Mean baseline** — predict `y_train.mean()` for every test row
2. **Median baseline** — predict `np.median(y_train)` for every test row
3. **Linear regression** — your `LinearRegressionScratch` from Lesson 9

Print a comparison table.

---

## Sample Output

```
==============================================================
  CARINDERIA — three predictors compared
==============================================================
   predictor             MAE       MSE        RMSE      R²
   mean baseline       273.12   126305      355.40    0.000
   median baseline     268.95   128974      359.13   -0.021
   linear regression   221.34    78920      280.93    0.375
```

---

## Reflection Questions

1. Why does the median baseline have a NEGATIVE R² here?
2. What does the MAE/RMSE ratio (228 / 280 ≈ 0.81) tell you about how errors are distributed in the linear regression?
3. If Tita Malou asked "how accurate is the model?" — which metric would you quote, and why?

---

## What You've Learned

- The four regression metrics and what each tells you
- The MAE-vs-RMSE distinction (mean error vs outlier-sensitive)
- How baselines anchor every model evaluation
