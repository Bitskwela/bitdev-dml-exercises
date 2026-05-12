# ============================================
# LUTO v2 — Full Reference Solution
# Lesson 25 by Dan Santos
# ============================================
# Predict top-3 ulam for tomorrow given (date, weather, is_payday).
# ============================================

import io
import pickle
import numpy as np
import pandas as pd
from datetime import datetime, timedelta


ITEMS = ["Adobo", "Sinigang", "Kare-Kare", "Bistek",
         "Tinola", "Pinakbet", "Lechon Kawali"]
RANDOM_SEED = 42


class LinRegScratch:
    """Linear regression via normal equation (from Lesson 9)."""
    def __init__(self):
        self.w = None
    def fit(self, X, y):
        Xb = np.hstack([np.ones((len(X), 1)), X])
        self.w = np.linalg.solve(Xb.T @ Xb, Xb.T @ y)
        return self
    def predict(self, X):
        Xb = np.hstack([np.ones((len(X), 1)), X])
        return Xb @ self.w


SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2025-08-01,Bistek,7,665,Friday,False,cloudy
2025-08-02,Kare-Kare,8,944,Saturday,False,rainy
2025-08-15,Sinigang,21,1575,Friday,True,rainy
2025-08-15,Kare-Kare,14,1652,Friday,True,rainy
2025-08-22,Sinigang,11,715,Friday,False,cloudy
2025-08-30,Lechon Kawali,15,2100,Saturday,True,sunny
2025-09-01,Adobo,11,825,Monday,False,rainy
2025-09-15,Kare-Kare,18,2124,Monday,True,sunny
2025-09-15,Sinigang,17,1275,Monday,True,sunny
2025-09-30,Adobo,16,1280,Tuesday,True,sunny
2025-10-15,Kare-Kare,17,2006,Wednesday,True,rainy
2025-10-30,Sinigang,19,1425,Thursday,True,cloudy
2025-11-08,Bistek,11,1045,Saturday,False,sunny
2025-11-15,Adobo,15,1200,Saturday,True,sunny
2025-12-01,Tinola,8,640,Monday,False,sunny
2025-12-15,Kare-Kare,19,2233,Monday,True,rainy
2025-12-30,Sinigang,22,1650,Tuesday,True,rainy
2026-01-08,Bistek,12,1140,Thursday,False,sunny
2026-01-15,Adobo,17,1360,Friday,True,sunny
2026-01-30,Kare-Kare,18,2124,Friday,True,sunny
"""

print("=" * 65)
print("  LUTO v2 — MINI ML PROJECT")
print("=" * 65)

# 1. Load
df = pd.read_csv(io.StringIO(SAMPLE_CSV))
df["is_payday"] = df["is_payday"].map({"True": True, "False": False,
                                         True: True, False: False})
df["date"] = pd.to_datetime(df["date"])
print(f"\n   Loaded {len(df)} rows")

# 2. Engineer features
df["day_of_month"]   = df["date"].dt.day
df["is_payday_int"]  = df["is_payday"].astype(int)
df["is_friday"]      = (df["day_of_week"] == "Friday").astype(int)
df["is_rainy"]       = (df["weather"] == "rainy").astype(int)

# Item one-hots (drop_first to avoid collinearity)
item_dummies = pd.get_dummies(df["item"], prefix="item", drop_first=True)
df_eng = pd.concat([df, item_dummies], axis=1)

feature_cols = (["day_of_month", "is_payday_int", "is_friday", "is_rainy"]
                + list(item_dummies.columns))
X = df_eng[feature_cols].to_numpy(dtype=float)
y = df_eng["revenue"].to_numpy(dtype=float)
print(f"   Features: {len(feature_cols)}")

# 3. Split 80/20
rng = np.random.default_rng(RANDOM_SEED)
idx = rng.permutation(len(X))
n_test = max(1, int(0.2 * len(X)))
test_idx, train_idx = idx[:n_test], idx[n_test:]

# 4. Train
model = LinRegScratch().fit(X[train_idx], y[train_idx])

# 5. Test MAE
y_pred = model.predict(X[test_idx])
test_mae = float(np.mean(np.abs(y[test_idx] - y_pred)))
print(f"\n   Test MAE: P{test_mae:.0f}")
print(f"   Test mean revenue: P{y[test_idx].mean():.0f}")
print(f"   Relative error: {test_mae / y[test_idx].mean():.1%}")

# 6. Serialize
serialized = pickle.dumps(model)
print(f"   Model serialized: {len(serialized)} bytes")

# 7. Forecast tomorrow
tomorrow = datetime.now() + timedelta(days=1)
sample_date_str = tomorrow.strftime("%A %Y-%m-%d")
target_weather = "rainy"
target_is_payday = int(tomorrow.day in (15, 30))
target_is_friday = int(tomorrow.strftime("%A") == "Friday")
target_is_rainy = int(target_weather == "rainy")

print()
print("=" * 65)
print(f"  FORECAST — {sample_date_str}")
print(f"  Weather: {target_weather}    Payday: {'yes' if target_is_payday else 'no'}")
print("=" * 65)

# Build one feature row per ulam
predictions = []
for ulam in ITEMS:
    row = {col: 0 for col in feature_cols}
    row["day_of_month"]  = tomorrow.day
    row["is_payday_int"] = target_is_payday
    row["is_friday"]     = target_is_friday
    row["is_rainy"]      = target_is_rainy
    # Item one-hot: only items in item_dummies.columns count.
    # "Adobo" was dropped (drop_first), so default 0s = Adobo.
    for col in item_dummies.columns:
        if col == f"item_{ulam}":
            row[col] = 1
    feature_row = np.array([[row[c] for c in feature_cols]], dtype=float)
    pred = float(model.predict(feature_row)[0])
    predictions.append({"ulam": ulam, "expected_revenue": pred})

# Sort descending
predictions.sort(key=lambda r: -r["expected_revenue"])

print(f"\n   {'rank':<6} {'ulam':<16} {'expected revenue':>18}")
print("   " + "-" * 42)
for i, p in enumerate(predictions, 1):
    marker = " ★" if i <= 3 else "  "
    print(f"   {i:<6} {p['ulam']:<16} P{int(p['expected_revenue']):>15,} {marker}")

top3 = predictions[:3]
print(f"\n   ★ Tita Malou, push these tomorrow:")
for r in top3:
    print(f"     - {r['ulam']:<14} (expected P{int(r['expected_revenue']):,})")

print()
print("-- Done. Luto v2 deployed. --")
print(f"   Test MAE: P{test_mae:.0f}")
print(f"   Top recommendation: {top3[0]['ulam']}")
print()
print("**This is the end of Dan's ML story — but the beginning of yours.**")
