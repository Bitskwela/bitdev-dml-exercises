# ============================================
# REAL-WORLD ML WORKFLOW — Full Solution
# Lesson 23 by Dan Santos
# ============================================
# All 22 prior lessons in ONE auditable script.
# ============================================

import io
import pickle
import numpy as np
import pandas as pd


# ===== 1. CONSTANTS =====
RANDOM_SEED   = 42
CV_FOLDS      = 5
BUSY_THRESH   = 1200
TEST_FRACTION = 0.2


# Local model implementations (from prior lessons)
class Dummy:
    def fit(self, X, y):
        self.maj = int(np.bincount(np.asarray(y, dtype=int)).argmax())
        return self
    def predict(self, X):
        return np.full(len(X), self.maj, dtype=int)
    def score(self, X, y):
        return float((self.predict(X) == np.asarray(y, dtype=int)).mean())


class LogReg:
    def __init__(self, lr=0.1, n_iter=200):
        self.lr = lr; self.n_iter = n_iter; self.w = None
    def fit(self, X, y):
        n, p = X.shape
        Xb = np.hstack([np.ones((n, 1)), X])
        w = np.zeros(p + 1)
        for _ in range(self.n_iter):
            z = np.clip(Xb @ w, -500, 500)
            ph = 1 / (1 + np.exp(-z))
            w -= self.lr * (Xb.T @ (ph - y.astype(float))) / n
        self.w = w
        return self
    def predict(self, X):
        Xb = np.hstack([np.ones((len(X), 1)), X])
        return ((1 / (1 + np.exp(-np.clip(Xb @ self.w, -500, 500)))) >= 0.5).astype(int)
    def predict_proba(self, X):
        Xb = np.hstack([np.ones((len(X), 1)), X])
        return 1 / (1 + np.exp(-np.clip(Xb @ self.w, -500, 500)))
    def score(self, X, y):
        return float((self.predict(X) == np.asarray(y, dtype=int)).mean())


def stratified_kfold_cv(X, y, model_factory, k=5, seed=42):
    rng = np.random.default_rng(seed)
    y_int = np.asarray(y, dtype=int)
    folds = [[] for _ in range(k)]
    for cls in np.unique(y_int):
        idx = rng.permutation(np.where(y_int == cls)[0])
        for i, chunk in enumerate(np.array_split(idx, k)):
            folds[i].extend(chunk.tolist())
    folds = [np.array(f, dtype=int) for f in folds]
    scores = []
    for i in range(k):
        te = folds[i]
        tr = np.concatenate([folds[j] for j in range(k) if j != i])
        m = model_factory()
        m.fit(X[tr], y[tr])
        scores.append(m.score(X[te], y[te]))
    return np.array(scores)


# ===== 2. LOAD =====
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

print("=" * 70)
print("  CARINDERIA ML — END-TO-END WORKFLOW")
print("=" * 70)

df = pd.read_csv(io.StringIO(SAMPLE_CSV))
print(f"\n   Loaded {len(df)} rows")

# ===== 3. CLEAN =====
df["is_payday"] = df["is_payday"].map({"True": True, "False": False,
                                         True: True, False: False})

# ===== 4. ENGINEER =====
df["is_payday_int"] = df["is_payday"].astype(int)
df["is_friday"]     = (df["day_of_week"] == "Friday").astype(int)
df["is_rainy"]      = (df["weather"] == "rainy").astype(int)
df["is_busy"]       = (df["revenue"] >= BUSY_THRESH).astype(int)

feature_cols = ["is_payday_int", "is_friday", "is_rainy"]
X = df[feature_cols].to_numpy(dtype=float)
y = df["is_busy"].to_numpy()
print(f"   After engineering: {len(df)} rows, {len(feature_cols)} features")
print(f"   Class balance: busy={int(y.sum())}, not_busy={int((y==0).sum())}")

# ===== 5. SPLIT =====
rng = np.random.default_rng(RANDOM_SEED)
idx = rng.permutation(len(X))
n_test = max(1, int(TEST_FRACTION * len(X)))
test_idx, trainval_idx = idx[:n_test], idx[n_test:]
X_trainval, X_test = X[trainval_idx], X[test_idx]
y_trainval, y_test = y[trainval_idx], y[test_idx]
print(f"\n   Train+val: {len(X_trainval)}  Test: {len(X_test)}")

# ===== 6. CV =====
print()
print("-" * 70)
print("  STEP A — 5-fold CV on train+val")
print("-" * 70)
print(f"\n   {'model':<22}  {'CV mean':>10}  {'CV std':>10}")
candidates = {
    "Dummy(majority)":    lambda: Dummy(),
    "LogReg":             lambda: LogReg(),
}
cv_results = {}
for name, factory in candidates.items():
    scores = stratified_kfold_cv(X_trainval, y_trainval, factory, k=CV_FOLDS,
                                   seed=RANDOM_SEED)
    cv_results[name] = (scores.mean(), scores.std())
    print(f"   {name:<22}  {scores.mean():>10.3f}  {scores.std():>10.3f}")

# ===== 7. SELECT =====
best_name = max(cv_results, key=lambda k: cv_results[k][0])
print(f"\n   Best by CV mean: {best_name}")

# ===== 8. FIT + TEST =====
print()
print("-" * 70)
print("  STEP B — fit best on full train+val, evaluate ONCE on held-out test")
print("-" * 70)
best_model = candidates[best_name]().fit(X_trainval, y_trainval)
test_acc = best_model.score(X_test, y_test)
print(f"\n   Final test accuracy: {test_acc:.3f}")

# ===== 9. SERIALIZE =====
serialized = pickle.dumps(best_model)
print()
print(f"   Model serialized: {len(serialized)} bytes")

# ===== 10. FORECAST =====
print()
print("=" * 70)
print("  WEEKLY FORECAST — Tita Malou's next 5 days")
print("=" * 70)
from datetime import datetime, timedelta
today = datetime.now()
print(f"\n   {'date':<12} {'day':<10} {'payday':<6} {'rainy?':<6}  predict     prob")
print("   " + "-" * 58)
for offset in range(1, 6):
    d = today + timedelta(days=offset)
    dow = d.strftime("%A")
    is_payday = int(d.day in (15, 30))
    is_friday = int(dow == "Friday")
    for weather_label, is_rainy in [("rainy", 1), ("sunny", 0)]:
        row = np.array([[is_payday, is_friday, is_rainy]], dtype=float)
        pred = best_model.predict(row)[0]
        if hasattr(best_model, 'predict_proba'):
            prob = float(best_model.predict_proba(row)[0])
        else:
            prob = float(pred)
        label = "BUSY    " if pred == 1 else "NOT-BUSY"
        bar = "#" * int(prob * 20)
        print(f"   {d.strftime('%Y-%m-%d'):<12} {dow:<10} {is_payday:<6} "
              f"{weather_label:<6}  {label}    {prob:.2f}  {bar}")
        break  # one weather per day for compactness

print()
print("-- DONE --")
print(f"   Best model:        {best_name}")
print(f"   Test accuracy:     {test_acc:.3f}")
print(f"   Serialized:        {len(serialized)} bytes (in memory)")
