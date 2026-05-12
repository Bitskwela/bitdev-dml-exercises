# ============================================
# AI vs ML vs DL — Lesson 24
# by: <Your Name>
# ============================================
# Three approaches on the same problem.
# ============================================

import time
import numpy as np


# ===== APPROACH 1: AI rule-based =====
def predict_rules(is_payday, is_friday, is_rainy):
    """Hand-typed rules — the Luto v1 brain."""
    # TODO: return 1 (busy) or 0 (not_busy) based on rules
    pass


# ===== APPROACH 2: ML logistic regression =====
# (use your Lesson 13 LogReg here)


# ===== APPROACH 3: DL tiny numpy net =====
def forward_net(X, W1, b1, W2, b2):
    """Two-layer neural net: ReLU hidden + sigmoid output."""
    # TODO: h1 = relu(X @ W1 + b1); out = sigmoid(h1 @ W2 + b2); return out.ravel()
    pass


# Tiny synthetic dataset
np.random.seed(0)
X = np.random.randint(0, 2, size=(30, 3)).astype(float)   # 3 boolean features
# Truth: busy if (payday AND Friday) OR (payday AND rainy)
y = ((X[:, 0] * X[:, 1]) + (X[:, 0] * X[:, 2]) > 0).astype(float)

# TODO: run each approach, score, print comparison table
