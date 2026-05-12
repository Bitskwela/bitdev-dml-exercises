# ============================================
# FEATURE ENGINEERING — Lesson 12
# by: <Your Name>
# ============================================
# Same algorithm. Same train/test split. Different features.
# Watch MAE drop without touching the model.
# ============================================

import io
import numpy as np
import pandas as pd


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


def fit_predict_mae(X_train, X_test, y_train, y_test):
    """Fit linear regression via normal equation and return test MAE."""
    Xb_tr = np.hstack([np.ones((len(X_train), 1)), X_train])
    Xb_te = np.hstack([np.ones((len(X_test),  1)), X_test])
    w = np.linalg.solve(Xb_tr.T @ Xb_tr, Xb_tr.T @ y_train)
    pred = Xb_te @ w
    return float(np.mean(np.abs(y_test - pred))), w


y = df["revenue"].to_numpy(dtype=float)
rng = np.random.default_rng(42)
idx = rng.permutation(len(df))
n_test = max(1, int(len(df) * 0.2))
test_idx, train_idx = idx[:n_test], idx[n_test:]

# === BASELINE: quantity only ===
X_base = df[["quantity"]].to_numpy(dtype=float)
mae_base, _ = fit_predict_mae(X_base[train_idx], X_base[test_idx],
                                y[train_idx], y[test_idx])
print(f"   Baseline (quantity only): MAE = P{mae_base:.2f}")


# === TODO: engineer 5 features + item one-hots ===
# df["day_of_month"]  = df["date"].dt.day
# df["is_payday_int"] = ...
# df["is_friday"]     = ...
# df["is_rainy"]      = ...
# df["payday_rainy"]  = ...
# item_dummies = pd.get_dummies(df["item"], prefix="item", drop_first=True)

# TODO: combine into feature matrix, refit, print MAE, compute improvement
