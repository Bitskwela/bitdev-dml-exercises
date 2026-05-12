## Dan's Story: Three Ways to Be Wrong

Sunday afternoon. Discord screenshare with Ate Rina.

> **Dan:** Test MAE was 228 pesos. RMSE was 297. Both decent.
>
> **Ate Rina:** Bata, do you actually know what those mean? Or did you just print whatever numpy told you?

Dan pulled up his keyboard. He typed three functions in two lines each:

```python
def mae(y, p):  return np.mean(np.abs(y - p))
def mse(y, p):  return np.mean((y - p) ** 2)
def rmse(y, p): return np.sqrt(mse(y, p))
```

> **Ate Rina:** Naks. Now: MAE treats all errors equally — being off by ₱100 ten times equals one big ₱1000 miss. MSE doesn't — it *squares* errors, so big misses hurt much more. RMSE is MSE put back in pesos so you can read it. Three metrics, three different stories.

---

## The Concept: Four Regression Metrics

### MAE — Mean Absolute Error

```
MAE = mean of |y_true - y_pred|
```

The *typical* error in original units (pesos). Robust to outliers. Easy to explain to Tita Malou.

### MSE — Mean Squared Error

```
MSE = mean of (y_true - y_pred)²
```

Squaring amplifies large errors. One ₱1000 miss contributes 1,000,000; one hundred ₱100 misses contribute only 10,000 each. **Big misses dominate.**

### RMSE — Root MSE

```
RMSE = sqrt(MSE)
```

Same units as labels. Inherits MSE's outlier sensitivity. **The most-reported metric in industry.**

### R² (R-squared) — Variance Explained

```
R² = 1 - (SS_residual / SS_total_around_mean)
```

Proportion of variance the model explains. R²=1 perfect, R²=0 mean-baseline-tier, R²<0 actively bad. Unitless — good for comparing models, bad for reporting to Tita Malou.

### Reading the MAE/RMSE Gap

If RMSE ≈ 1.2 × MAE, errors are evenly distributed. If RMSE > 1.5 × MAE, a few big misses inflate the squared average. The ratio is a free outlier-diagnostic.

---

## Key Takeaways

- **MAE** = typical error in original units. Best for non-technical audiences.
- **MSE/RMSE** punish big errors more. RMSE stays in original units.
- **R²** is unitless and useful for comparing models — not for plain-language reports.
- **Always report multiple metrics.** A single number hides information.

---

## What's Next?

Dan can name his errors now. The next question: *what happens if we make the model more complex?* The naive answer is "predict better." The real answer is the most important concept in ML — **overfitting**.

**Next Lesson: Overfitting vs Underfitting** — fit polynomial degrees 1, 3, 9. Watch the test error explode.
