# ============================================
# LOGISTIC REGRESSION FROM SCRATCH — Lesson 13
# by: <Your Name>
# ============================================
# Sigmoid + gradient descent on cross-entropy loss.
# ============================================

import io
import numpy as np
import pandas as pd


def sigmoid(z):
    z = np.clip(z, -500, 500)
    return 1.0 / (1.0 + np.exp(-z))


class LogisticRegressionScratch:
    def __init__(self, lr=0.1, n_iter=200):
        self.lr = lr
        self.n_iter = n_iter
        self.weights_ = None

    def fit(self, X, y):
        n, p = X.shape
        # TODO: prepend all-1s column
        # TODO: initialize w = np.zeros(p + 1)
        # TODO: gradient descent loop:
        #   probs = sigmoid(X_bias @ w)
        #   grad  = (1/n) * X_bias.T @ (probs - y)
        #   w    -= self.lr * grad
        return self

    def predict_proba(self, X):
        # TODO: prepend 1s, return sigmoid(X_bias @ self.weights_)
        pass

    def predict(self, X, threshold=0.5):
        return (self.predict_proba(X) >= threshold).astype(int)


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
df["is_friday"]     = (df["day_of_week"] == "Friday").astype(int)
df["is_saturday"]   = (df["day_of_week"] == "Saturday").astype(int)
df["is_rainy"]      = (df["weather"] == "rainy").astype(int)
df["is_busy"]       = (df["revenue"] >= 1200).astype(int)

feature_cols = ["is_payday_int", "is_friday", "is_saturday", "is_rainy"]
X = df[feature_cols].to_numpy(dtype=float)
y = df["is_busy"].to_numpy(dtype=float)

# 80/20 split
rng = np.random.default_rng(42)
idx = rng.permutation(len(X))
n_test = max(1, int(len(X) * 0.2))
test_idx, train_idx = idx[:n_test], idx[n_test:]

# TODO: fit, predict, compute accuracy
# TODO: build confusion matrix and compute precision + recall
