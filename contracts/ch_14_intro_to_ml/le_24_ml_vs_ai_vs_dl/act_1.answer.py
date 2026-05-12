# ============================================
# AI vs ML vs DL — Full Solution
# Lesson 24 by Dan Santos
# ============================================

import time
import numpy as np


# ===== APPROACH 1: AI rule-based =====
def predict_rules_one(is_payday, is_friday, is_rainy):
    if is_payday and (is_friday or is_rainy):
        return 1
    if is_friday and is_rainy:
        return 1
    return 0

def predict_rules(X):
    return np.array([predict_rules_one(*row) for row in X], dtype=int)


# ===== APPROACH 2: ML logistic regression =====
def sigmoid(z):
    return 1 / (1 + np.exp(-np.clip(z, -500, 500)))

class LogReg:
    def __init__(self, lr=0.2, n_iter=500):
        self.lr = lr; self.n_iter = n_iter; self.w = None
    def fit(self, X, y):
        n, p = X.shape
        Xb = np.hstack([np.ones((n, 1)), X])
        w = np.zeros(p + 1)
        for _ in range(self.n_iter):
            ph = sigmoid(Xb @ w)
            w -= self.lr * (Xb.T @ (ph - y)) / n
        self.w = w
        return self
    def predict(self, X):
        Xb = np.hstack([np.ones((len(X), 1)), X])
        return (sigmoid(Xb @ self.w) >= 0.5).astype(int)


# ===== APPROACH 3: DL tiny numpy net =====
def relu(z):
    return np.maximum(0, z)

def train_tiny_net(X, y, n_hidden=8, n_iter=300, lr=0.05, seed=42):
    rng = np.random.default_rng(seed)
    n, p = X.shape
    W1 = rng.normal(scale=0.3, size=(p, n_hidden))
    b1 = np.zeros(n_hidden)
    W2 = rng.normal(scale=0.3, size=(n_hidden, 1))
    b2 = np.zeros(1)
    y_col = y.reshape(-1, 1)
    for _ in range(n_iter):
        # Forward
        h1 = relu(X @ W1 + b1)
        out = sigmoid(h1 @ W2 + b2)
        # Backward (vanilla SGD)
        d_out = (out - y_col) / n
        dW2 = h1.T @ d_out
        db2 = d_out.sum(axis=0)
        d_h1 = (d_out @ W2.T) * (h1 > 0)
        dW1 = X.T @ d_h1
        db1 = d_h1.sum(axis=0)
        W1 -= lr * dW1; b1 -= lr * db1
        W2 -= lr * dW2; b2 -= lr * db2
    return W1, b1, W2, b2

def predict_net(X, W1, b1, W2, b2):
    h1 = relu(X @ W1 + b1)
    out = sigmoid(h1 @ W2 + b2).ravel()
    return (out >= 0.5).astype(int)


# Synthetic dataset
np.random.seed(0)
X = np.random.randint(0, 2, size=(30, 3)).astype(float)
y = ((X[:, 0] * X[:, 1]) + (X[:, 0] * X[:, 2]) > 0).astype(float)

print("=" * 65)
print("  AI vs ML vs DL — same problem, three approaches")
print("=" * 65)

# AI (rules)
t0 = time.time()
preds_rules = predict_rules(X)
t_rules = time.time() - t0
acc_rules = float((preds_rules == y).mean())
print(f"\n   AI (rules):     accuracy={acc_rules:.3f}  train_time=0 sec  "
      f"interp=10/10")

# ML (LogReg)
t0 = time.time()
ml = LogReg().fit(X, y)
t_ml = time.time() - t0
preds_ml = ml.predict(X)
acc_ml = float((preds_ml == y).mean())
print(f"   ML (LogReg):    accuracy={acc_ml:.3f}  train_time={t_ml:.3f} sec  "
      f"interp=8/10")

# DL (tiny net)
t0 = time.time()
W1, b1, W2, b2 = train_tiny_net(X, y)
t_dl = time.time() - t0
preds_dl = predict_net(X, W1, b1, W2, b2)
acc_dl = float((preds_dl == y).mean())
print(f"   DL (tiny net):  accuracy={acc_dl:.3f}  train_time={t_dl:.3f} sec  "
      f"interp=2/10")

print()
print("-- Read the table --")
print("   For 30 rows of tabular data, simple ML beats or matches a tiny DL net.")
print("   DL would dominate on 977M rows of pixels — but we don't have pixels.")
print("   The right algorithm depends on the DATA SHAPE, not on what's trendy.")
