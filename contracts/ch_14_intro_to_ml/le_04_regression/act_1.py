# ============================================
# REGRESSION BASELINES — Lesson 4
# by: <Your Name>
# ============================================
# Predict next-week sinigang sales with three baselines:
# mean, median, moving-average. No model — just arithmetic.
# ============================================

import numpy as np

# 14 days of sinigang sales (bowls per day)
sinigang_per_day = np.array([
    12, 15, 11, 14, 13, 22, 18,    # Week 1 (22 = payday Friday)
    14, 17, 12, 13, 11, 25, 19,    # Week 2 (25 = payday rainy Friday)
])

print("=" * 60)
print("  SINIGANG SALES — 14 days")
print("=" * 60)
print(f"   Daily counts: {sinigang_per_day.tolist()}")

# TODO: compute the three predictions
mean_pred = ...        # mean of all 14 days
median_pred = ...      # median of all 14 days
moving_avg_pred = ...  # mean of last 7 days

print(f"   Mean:                  {mean_pred:.2f}")
print(f"   Median:                {median_pred:.2f}")
print(f"   Moving avg (last 7d):  {moving_avg_pred:.2f}")


# === Backtest ===
print()
print("=" * 60)
print("  BACKTEST — last 3 days")
print("=" * 60)

train = sinigang_per_day[:-3]
test  = sinigang_per_day[-3:]
print(f"   Train: {train.tolist()}")
print(f"   Test:  {test.tolist()}")

def mae(actual, predicted):
    return np.abs(actual - predicted).mean()

# TODO: re-compute baselines from TRAIN ONLY
# TODO: predict each of the 3 test days (use np.full_like)
# TODO: print MAE of each baseline against test
