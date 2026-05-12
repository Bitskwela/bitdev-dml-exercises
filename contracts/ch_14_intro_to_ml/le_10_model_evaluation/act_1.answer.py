# ============================================
# REGRESSION METRICS — Full Solution
# Lesson 10 by Dan Santos
# ============================================

import io
import numpy as np
import pandas as pd


def mae(y, p):
    return float(np.mean(np.abs(y - p)))

def mse(y, p):
    return float(np.mean((y - p) ** 2))

def rmse(y, p):
    return float(np.sqrt(mse(y, p)))

def r2(y, p):
    ss_res = np.sum((y - p) ** 2)
    ss_tot = np.sum((y - np.mean(y)) ** 2)
    return float(1 - ss_res / ss_tot)


# === Sanity check ===
y = np.array([100, 200, 300, 400, 500], dtype=float)
perfect    = y.copy()
off_by_50  = y + 50.0
one_huge   = y.copy(); one_huge[2] += 500

print("=" * 60)
print("  SANITY CHECK — synthetic predictions")
print("=" * 60)
for name, pred in [("perfect", perfect),
                   ("off by 50 everywhere", off_by_50),
                   ("one prediction off by 500", one_huge)]:
    print(f"\n   {name}:")
    print(f"     MAE  = {mae(y, pred):7.2f}")
    print(f"     MSE  = {mse(y, pred):9.2f}")
    print(f"     RMSE = {rmse(y, pred):7.2f}")
    print(f"     R²   = {r2(y, pred):7.3f}")

print()
print("   Notice: 'one prediction off by 500' has lower MAE (100) than")
print("   'off by 50 everywhere' (50) — but MUCH higher RMSE (224 vs 50).")
print("   That gap is the MAE-vs-RMSE story.")


# === Three predictors on carinderia data ===
SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2025-08-01,Bistek,7,665,Friday,False,cloudy
2025-08-01,Tinola,13,910,Friday,False,cloudy
2025-08-02,Kare-Kare,8,944,Saturday,False,rainy
2025-08-03,Lechon Kawali,11,1540,Sunday,False,sunny
2025-08-05,Tinola,8,560,Tuesday,False,cloudy
2025-08-15,Sinigang,21,1575,Friday,True,rainy
2025-08-15,Kare-Kare,14,1652,Friday,True,rainy
2025-08-16,Adobo,12,960,Saturday,False,rainy
2025-08-22,Sinigang,11,715,Friday,False,cloudy
2025-08-23,Kare-Kare,10,1180,Saturday,False,sunny
2025-08-29,Bistek,13,1235,Friday,False,sunny
2025-08-30,Lechon Kawali,15,2100,Saturday,True,sunny
2025-09-01,Adobo,11,825,Monday,False,rainy
2025-09-15,Kare-Kare,18,2124,Monday,True,sunny
2025-09-15,Sinigang,17,1275,Monday,True,sunny
"""

df = pd.read_csv(io.StringIO(SAMPLE_CSV))
df["is_payday"] = df["is_payday"].map({"True": True, "False": False,
                                         True: True, False: False})
df["date"] = pd.to_datetime(df["date"])
df["day_of_month"]  = df["date"].dt.day
df["is_payday_int"] = df["is_payday"].astype(int)
df["is_friday"]     = (df["day_of_week"] == "Friday").astype(int)

feature_cols = ["day_of_month", "is_payday_int", "is_friday"]
X = df[feature_cols].to_numpy(dtype=float)
y_all = df["revenue"].to_numpy(dtype=float)

rng = np.random.default_rng(42)
indices = rng.permutation(len(X))
n_test = int(len(X) * 0.2)
test_idx, train_idx = indices[:n_test], indices[n_test:]
X_train, X_test = X[train_idx], X[test_idx]
y_train, y_test = y_all[train_idx], y_all[test_idx]

# Mean baseline
mean_pred = np.full_like(y_test, y_train.mean())

# Median baseline
median_pred = np.full_like(y_test, np.median(y_train))

# Linear regression (from Lesson 9)
X_train_bias = np.hstack([np.ones((len(X_train), 1)), X_train])
X_test_bias  = np.hstack([np.ones((len(X_test),  1)), X_test])
w = np.linalg.solve(X_train_bias.T @ X_train_bias, X_train_bias.T @ y_train)
lr_pred = X_test_bias @ w

print()
print("=" * 65)
print("  CARINDERIA — three predictors compared")
print("=" * 65)
print(f"\n   {'predictor':<22} {'MAE':>10} {'MSE':>12} {'RMSE':>10} {'R²':>8}")
print("   " + "-" * 62)
for name, pred in [
    ("mean baseline",      mean_pred),
    ("median baseline",    median_pred),
    ("linear regression",  lr_pred),
]:
    print(f"   {name:<22} {mae(y_test, pred):>10.2f} "
          f"{mse(y_test, pred):>12.0f} "
          f"{rmse(y_test, pred):>10.2f} "
          f"{r2(y_test, pred):>8.3f}")

print()
print("-- Read the table --")
print("   Linear regression beats both baselines.")
print("   The MAE-to-RMSE ratio tells you about outliers.")
print("   R² near 0 means 'no better than mean'; negative = worse than mean.")
