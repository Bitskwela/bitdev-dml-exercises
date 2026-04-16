# deep_network.py
# ============================================
# A DEEP NETWORK FROM SCRATCH (numpy)
# by: <Your Name>
# ============================================
# Run: pip install numpy

import numpy as np

np.random.seed(42)

# Input: 6 customers, 3 features each (hunger, budget, proximity)
X = np.array([
    [1.0, 0.8, 0.9],
    [0.1, 0.9, 0.5],
    [0.9, 0.1, 0.7],
    [0.5, 0.7, 0.2],
    [0.7, 0.6, 1.0],
    [0.0, 0.5, 1.0],
])
y = np.array([[1], [0], [1], [0], [1], [0]])

print("=" * 55)
print("  DEEP NETWORK (2-layer) — forward pass")
print("=" * 55)

# TODO: Task 1 — define sigmoid
# def sigmoid(x): return 1 / (1 + np.exp(-x))


# TODO: Task 2 — initialize weights and biases for 2-layer net
# Layer 1: 3 inputs -> 4 hidden
# Layer 2: 4 hidden -> 1 output
# Use np.random.randn


# TODO: Task 3 — forward pass
# hidden = sigmoid(X @ w1 + b1)
# output = sigmoid(hidden @ w2 + b2)


# TODO: Task 4 — print predictions and accuracy
# threshold at 0.5: 1 if output > 0.5 else 0


# TODO: Task 5 — try different seeds and observe how outputs change
