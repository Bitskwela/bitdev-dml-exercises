# ============================================
# REGRESSION BASELINES — Full Solution
# Lesson 4 by Dan Santos
# ============================================

import numpy as np

sinigang_per_day = np.array([
    12, 15, 11, 14, 13, 22, 18,
    14, 17, 12, 13, 11, 25, 19,
])

print("=" * 60)
print("  SINIGANG SALES — 14 days")
print("=" * 60)
print(f"   Daily counts: {sinigang_per_day.tolist()}")

mean_pred       = sinigang_per_day.mean()
median_pred     = float(np.median(sinigang_per_day))
moving_avg_pred = sinigang_per_day[-7:].mean()

print(f"   Mean:                  {mean_pred:.2f}")
print(f"   Median:                {median_pred:.2f}")
print(f"   Moving avg (last 7d):  {moving_avg_pred:.2f}")

# A historical context-aware baseline
historical_payday_rainy = sinigang_per_day[[5, 12]]  # the two big spikes
print(f"   Historical payday-rainy-Friday avg: {historical_payday_rainy.mean():.2f}")


# === Backtest ===
print()
print("=" * 60)
print("  BACKTEST — predict last 3 days using only earlier history")
print("=" * 60)

train = sinigang_per_day[:-3]
test  = sinigang_per_day[-3:]
print(f"   Train (first 11): {train.tolist()}")
print(f"   Test  (last 3):   {test.tolist()}")

def mae(actual, predicted):
    return float(np.abs(actual - predicted).mean())

mean_pred_train     = train.mean()
median_pred_train   = float(np.median(train))
moving_pred_train   = train[-7:].mean()

mean_preds   = np.full_like(test, mean_pred_train,   dtype=float)
median_preds = np.full_like(test, median_pred_train, dtype=float)
moving_preds = np.full_like(test, moving_pred_train, dtype=float)

print()
print(f"   MAE (mean baseline):       {mae(test, mean_preds):.2f}")
print(f"   MAE (median baseline):     {mae(test, median_preds):.2f}")
print(f"   MAE (moving-avg baseline): {mae(test, moving_preds):.2f}")

print()
print("-- Takeaway --")
print("   Every model we build from Lesson 9 onward has to beat")
print(f"   {mae(test, moving_preds):.2f} bowls of MAE — the moving-average floor.")
