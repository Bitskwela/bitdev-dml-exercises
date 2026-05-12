# ============================================
# REGRESSION METRICS — Lesson 10
# by: <Your Name>
# ============================================
# MAE, MSE, RMSE, R² — all from scratch in numpy.
# ============================================

import io
import numpy as np
import pandas as pd


def mae(y, p):
    # TODO: return mean of |y - p|
    pass


def mse(y, p):
    # TODO: return mean of (y - p)^2
    pass


def rmse(y, p):
    # TODO: return sqrt(mse(y, p))
    pass


def r2(y, p):
    # TODO: 1 - sum((y - p)^2) / sum((y - mean(y))^2)
    pass


# === Sanity check ===
y = np.array([100, 200, 300, 400, 500], dtype=float)
perfect    = y.copy()
off_by_50  = y + 50.0
one_huge   = y.copy(); one_huge[2] += 500

print("=" * 60)
print("  SANITY CHECK")
print("=" * 60)
for name, pred in [("perfect", perfect),
                   ("off by 50 everywhere", off_by_50),
                   ("one prediction off by 500", one_huge)]:
    print(f"\n   {name}:")
    print(f"     MAE  = {mae(y, pred)}")
    print(f"     MSE  = {mse(y, pred)}")
    print(f"     RMSE = {rmse(y, pred)}")
    print(f"     R²   = {r2(y, pred)}")


# === Three predictors on carinderia ===
# TODO: load the inline carinderia CSV (reuse from previous lessons)
# TODO: split 80/20
# TODO: compute mean baseline, median baseline, and linear regression predictions
# TODO: print a comparison table of MAE / MSE / RMSE / R²
