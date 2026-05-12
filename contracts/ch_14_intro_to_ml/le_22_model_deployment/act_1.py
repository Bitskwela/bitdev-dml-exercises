# ============================================
# MODEL DEPLOYMENT — Lesson 22
# by: <Your Name>
# ============================================
# Sandbox-safe persistence via pickle + bytes.
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

# Train
model = LogReg().fit(X, y)

# TODO: serialize the model
# serialized = pickle.dumps(model)
# print(f"Serialized size: {len(serialized)} bytes")

# TODO: reload via pickle.loads
# restored = pickle.loads(serialized)

# TODO: predict on a new "tomorrow" row using both original and restored
# Show they match

new_row = np.array([[1, 1, 1]], dtype=float)  # payday + Friday + rainy
# TODO: print model.predict(new_row) and restored.predict(new_row); confirm equal
