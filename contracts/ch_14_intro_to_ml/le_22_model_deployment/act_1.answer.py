# ============================================
# MODEL DEPLOYMENT — Full Solution
# Lesson 22 by Dan Santos
# ============================================

import io
import pickle
import numpy as np
import pandas as pd


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
            w -= self.lr * (Xb.T @ (ph - y)) / n
        self.w = w
        return self
    def predict(self, X):
        Xb = np.hstack([np.ones((len(X), 1)), X])
        return ((1 / (1 + np.exp(-np.clip(Xb @ self.w, -500, 500)))) >= 0.5).astype(int)
    def predict_proba(self, X):
        Xb = np.hstack([np.ones((len(X), 1)), X])
        return 1 / (1 + np.exp(-np.clip(Xb @ self.w, -500, 500)))


SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2025-08-01,Bistek,7,665,Friday,False,cloudy
2025-08-15,Sinigang,21,1575,Friday,True,rainy
2025-08-15,Kare-Kare,14,1652,Friday,True,rainy
2025-08-22,Sinigang,11,715,Friday,False,cloudy
2025-08-30,Lechon Kawali,15,2100,Saturday,True,sunny
2025-09-15,Kare-Kare,18,2124,Monday,True,sunny
2025-09-30,Adobo,16,1280,Tuesday,True,sunny
2025-10-15,Kare-Kare,17,2006,Wednesday,True,rainy
2025-11-08,Bistek,11,1045,Saturday,False,sunny
2025-11-15,Adobo,15,1200,Saturday,True,sunny
"""
df = pd.read_csv(io.StringIO(SAMPLE_CSV))
df["is_payday"] = df["is_payday"].map({"True": True, "False": False,
                                         True: True, False: False})
df["is_payday_int"] = df["is_payday"].astype(int)
df["is_friday"]     = (df["day_of_week"] == "Friday").astype(int)
df["is_rainy"]      = (df["weather"] == "rainy").astype(int)
df["is_busy"]       = (df["revenue"] >= 1200).astype(int)

X = df[["is_payday_int", "is_friday", "is_rainy"]].to_numpy(dtype=float)
y = df["is_busy"].to_numpy(dtype=float)

# ===== TRAIN =====
model = LogReg().fit(X, y)
print("=" * 60)
print("  TRAIN")
print("=" * 60)
print(f"   Trained model: LogReg")
print(f"   Weights: {model.w.tolist()}")

# ===== SERIALIZE =====
serialized = pickle.dumps(model)
print()
print("=" * 60)
print("  SERIALIZE — pickle.dumps -> bytes")
print("=" * 60)
print(f"   Serialized size: {len(serialized)} bytes")

# ===== RELOAD =====
restored = pickle.loads(serialized)
print()
print("=" * 60)
print("  RELOAD — pickle.loads -> back to LogReg object")
print("=" * 60)
print(f"   Restored: {type(restored).__name__}")
print(f"   Same weights: {np.allclose(model.w, restored.w)}")

# ===== PREDICT WITH BOTH =====
test_rows = np.array([
    [1, 1, 1],  # payday + Friday + rainy
    [0, 0, 0],  # nothing special
    [1, 0, 1],  # payday + rainy + not Friday
], dtype=float)

orig_pred = model.predict(test_rows)
rest_pred = restored.predict(test_rows)

print()
print("=" * 60)
print("  PREDICT — original vs reloaded")
print("=" * 60)
print(f"   Original predictions: {orig_pred.tolist()}")
print(f"   Reloaded predictions: {rest_pred.tolist()}")
print(f"   Match: {bool((orig_pred == rest_pred).all())}")

print()
print("   Probabilities (reloaded):")
for row, prob in zip(test_rows, restored.predict_proba(test_rows)):
    print(f"     row {row.tolist()}: prob_busy = {prob:.3f}")

print()
print("-- Takeaway --")
print("   `pickle.dumps(model)` serializes any Python object to bytes.")
print("   `pickle.loads(bytes)` restores it. The reloaded model is identical.")
print("   This is the sandbox-safe equivalent of `joblib.dump('model.pkl')`.")
print("   In production, you'd write the bytes to disk or a database.")
