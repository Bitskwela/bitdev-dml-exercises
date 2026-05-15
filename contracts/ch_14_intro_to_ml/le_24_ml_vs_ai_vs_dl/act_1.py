# ============================================
# AI vs ML vs DL — Lesson 24
# by: <Your Name>
# ============================================
# Three approaches on the same carinderia problem.
# ============================================

import time
import numpy as np


# ===== APPROACH 1: AI rule-based =====
def predict_rules(X):
    """Hand-typed rules. X rows: [is_payday, is_friday, is_rainy]."""
    out = []
    for row in X:
        is_payday, is_friday, is_rainy = int(row[0]), int(row[1]), int(row[2])
        # TODO: return 1 if (is_payday and (is_friday or is_rainy)) else ...
        out.append(0)  # replace this line
    return np.array(out, dtype=int)


# ===== APPROACH 2: ML logistic regression =====
def sigmoid(z):
    return 1 / (1 + np.exp(-np.clip(z, -500, 500)))

class LogReg:
    def __init__(self, lr=0.2, n_iter=500):
        self.lr = lr; self.n_iter = n_iter; self.w = None
    def fit(self, X, y):
        # TODO: add bias column → Xb shape (n, p+1)
        # TODO: gradient descent loop (Lesson 13 pattern):
        #       w -= lr * (Xb.T @ (sigmoid(Xb @ w) - y)) / n
        pass
    def predict(self, X):
        # TODO: sigmoid(Xb @ self.w) >= 0.5 → return int array
        pass


# ===== APPROACH 3: DL tiny numpy net =====
rng = np.random.default_rng(42)
W1 = rng.normal(scale=0.3, size=(3, 8))   # (features=3, hidden=8)
b1 = np.zeros(8)
W2 = rng.normal(scale=0.3, size=(8, 1))   # (hidden=8, output=1)
b2 = np.zeros(1)

def forward_net(X, W1, b1, W2, b2):
    """Two-layer net: ReLU hidden + sigmoid output."""
    # TODO: h1 = np.maximum(0, X @ W1 + b1)    # (30,3)@(3,8)+b1 → (30,8)
    # TODO: out = sigmoid(h1 @ W2 + b2)         # (30,8)@(8,1)+b2 → (30,1)
    # TODO: return out.ravel()                   # → (30,)
    pass


# Tiny synthetic dataset (30 rows, 3 boolean features)
np.random.seed(0)
X = np.random.randint(0, 2, size=(30, 3)).astype(float)
# Truth: busy if (payday AND Friday) OR (payday AND rainy)
y = ((X[:, 0] * X[:, 1]) + (X[:, 0] * X[:, 2]) > 0).astype(float)

# TODO: run each approach, score accuracy, print comparison table
# preds_rules = predict_rules(X)
# ml = LogReg().fit(X, y); preds_ml = ml.predict(X)
# preds_dl = forward_net(X, W1, b1, W2, b2)   # untrained; train first (see answer)
# print(f"   AI (rules):  accuracy={...:.3f}")
# print(f"   ML (LogReg): accuracy={...:.3f}")
# print(f"   DL (net):    accuracy={...:.3f}")
