# Three Baselines for Sinigang Sales

You will NOT train a model today. You will compute the *baselines* every future model has to beat.

---

## Task 1: Compute the Three Baselines

Open `act_1.py`. The starter has 14 days of sinigang sales in a numpy array. Implement:

1. `mean_pred` — the mean of all 14 days
2. `median_pred` — the median of all 14 days
3. `moving_avg_pred` — the mean of the LAST 7 days

Print all three predictions for "tomorrow."

---

## Task 2: Backtest on Held-Out Days

Hold out the last 3 days. Re-compute each baseline using ONLY the first 11 days. Predict each of the 3 held-out days. Use `mae(actual, predicted)` to score each baseline.

```python
def mae(actual, predicted):
    return np.abs(actual - predicted).mean()
```

---

## Sample Output

```
============================================================
  SINIGANG SALES — 14 days
============================================================
   Mean:    15.43 bowls/day
   Median:  14.00
   Moving avg (last 7d): 15.86

   MAE on last 3 days:
     mean baseline:       4.78
     median baseline:     4.67
     moving-avg baseline: 4.36

   Moving average wins by 0.4 bowls. Every future model
   we build must beat 4.36 bowls of MAE.
```

---

## Reflection Questions

1. The "moving average" baseline beats the "mean" baseline by ~0.5 bowls. What does this tell you about how the data changes over time?
2. Two of the 14 days have abnormally high sales (22 and 25 bowls — both payday rainy Fridays). How would knowing this fact help you build a better baseline?
3. Why does it matter that the test days were NOT used to compute the baseline values?

---

## Challenge: Context-Aware Baseline

Write a `predict_with_context(is_payday, weather, day_of_week)` function that returns:
- 23 (historical payday-rainy-Friday average) if `is_payday and weather=="rainy" and day_of_week=="Friday"`
- The rainy-day mean if `weather=="rainy"`
- Else the moving-average prediction

Score this against the 3-day backtest. Did it beat the moving-average baseline?

You probably beat it by 1-2 bowls. That's feature engineering — the same insight at the core of Lesson 12.

---

## What You've Learned

- Regression predicts continuous numbers
- Mean / median / moving-average are the three baseline floors
- MAE in original units is the most readable error metric
- Context-aware predictions beat blind averages — foreshadowing feature engineering
