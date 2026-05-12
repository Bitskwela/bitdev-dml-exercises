# Engineer Five Features, Watch MAE Drop

Measure the impact of feature engineering by running the SAME linear regression before and after engineering.

---

## Task 1: Baseline (Raw Features)

Open `act_1.py`. Use only `quantity` as feature. Predict `revenue`. Fit your `LinearRegressionScratch` from Lesson 9. Print test MAE.

(Yes, `quantity` leaks for `revenue` prediction. We use it as a deliberately weak baseline to compare against.)

---

## Task 2: Engineered Features

Engineer five features from the raw columns:

```python
df["day_of_month"]   = df["date"].dt.day
df["is_payday_int"]  = df["is_payday"].astype(int)
df["is_friday"]      = (df["day_of_week"] == "Friday").astype(int)
df["is_rainy"]       = (df["weather"] == "rainy").astype(int)
df["payday_rainy"]   = df["is_payday_int"] * df["is_rainy"]  # interaction!
```

Add one-hot dummies for `item` (`pd.get_dummies(df["item"], prefix="item", drop_first=True)`).

Refit. Print test MAE.

---

## Task 3: Compare

```
   Baseline (quantity only):   MAE = P162
   Engineered (5 + dummies):   MAE = P109
   Improvement:                33%
```

---

## Reflection Questions

1. Why does adding `payday_rainy` (interaction feature) help? Could linear regression find this without you creating the column?
2. Look at the LARGEST weight in the engineered model. Is it a feature Tita Malou could have predicted would matter?
3. If you doubled the dataset size, would the improvement from engineering shrink or stay the same? Why?

---

## What You've Learned

- Better features beat fancier models, almost always
- One-hot encoding turns categories into model-readable columns
- Interaction features (`a × b`) capture multiplicative effects linear models can't find on their own
