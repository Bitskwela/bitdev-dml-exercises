# ============================================
# SMOKE TEST — Full Solution
# Lesson 8 by Dan Santos
# ============================================

import io
import pickle

import numpy as np
import pandas as pd

print("=" * 60)
print("  ENVIRONMENT CHECK")
print("=" * 60)
print(f"   numpy:  {np.__version__}")
print(f"   pandas: {pd.__version__}")
print(f"   pickle: stdlib (no version)")
print(f"   io:     stdlib")

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
df["is_payday_int"] = df["is_payday"].astype(int)
df["is_busy"] = (df["revenue"] >= 1200).astype(int)

# One-hot encoding
day_dummies     = pd.get_dummies(df["day_of_week"], prefix="day")
weather_dummies = pd.get_dummies(df["weather"], prefix="weather")
item_dummies    = pd.get_dummies(df["item"], prefix="item")
df_enc = pd.concat([df, day_dummies, weather_dummies, item_dummies], axis=1)

feature_cols = ["is_payday_int"] + \
               list(day_dummies.columns) + \
               list(weather_dummies.columns) + \
               list(item_dummies.columns)
print(f"\n   After encoding: {len(df_enc)} rows, {len(feature_cols)} features")
print(f"   Class balance: busy={df_enc['is_busy'].sum()}, "
      f"not_busy={(df_enc['is_busy'] == 0).sum()}")


def dummy_predict_majority(y_train, y_test):
    majority = int(np.bincount(y_train).argmax())
    return np.full_like(y_test, majority)


# 80/20 split
X = df_enc[feature_cols].to_numpy(dtype=float)
y = df_enc["is_busy"].to_numpy(dtype=int)
rng = np.random.default_rng(42)
indices = rng.permutation(len(X))
n_test = int(len(X) * 0.2)
test_idx, train_idx = indices[:n_test], indices[n_test:]
X_train, X_test = X[train_idx], X[test_idx]
y_train, y_test = y[train_idx], y[test_idx]

y_pred = dummy_predict_majority(y_train, y_test)
accuracy = (y_pred == y_test).mean()
print()
print("=" * 60)
print("  DUMMY BASELINE — predict the majority class")
print("=" * 60)
print(f"   Majority class: {int(np.bincount(y_train).argmax())}")
print(f"   Test accuracy:  {accuracy:.3f}")
print(f"\n   This is the FLOOR every real model has to beat.")

# Demo pickle round-trip — proves the serialization story for Lesson 22
serialized = pickle.dumps({"majority": int(np.bincount(y_train).argmax())})
restored = pickle.loads(serialized)
print(f"\n   Pickle round-trip: {len(serialized)} bytes, restored = {restored}")
print(f"   This same pattern saves trained models — Lesson 22.")
