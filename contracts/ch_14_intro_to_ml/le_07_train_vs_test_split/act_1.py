# ============================================
# TRAIN/TEST SPLIT — Lesson 7
# by: <Your Name>
# ============================================
# Implement an 80/20 split from scratch in numpy.
# Then implement a stratified version that preserves class ratio.
# ============================================

import numpy as np

# A tiny synthetic dataset for the demo
np.random.seed(0)
n = 30
X = np.random.rand(n, 3)               # 30 rows, 3 features
y = np.array([1]*10 + [0]*20)          # imbalanced: 10 busy, 20 not-busy


def manual_split(X, y, test_size=0.2, seed=42):
    """80/20 random split. Return (X_train, X_test, y_train, y_test)."""
    rng = np.random.default_rng(seed)
    # TODO: permute indices [0, n)
    # TODO: slice first int(n * test_size) into test, rest into train
    # TODO: return the four numpy arrays
    return None, None, None, None


def stratified_split(X, y, test_size=0.2, seed=42):
    """Stratified split — preserves class ratio in both train and test."""
    rng = np.random.default_rng(seed)
    train_idx, test_idx = [], []
    # TODO: for each unique value in y, get its row indices,
    # shuffle them, split, and collect into train_idx and test_idx
    train_idx = np.array(train_idx, dtype=int)
    test_idx  = np.array(test_idx,  dtype=int)
    return X[train_idx], X[test_idx], y[train_idx], y[test_idx]


# === Demo ===
Xtr, Xte, ytr, yte = manual_split(X, y)
print("=" * 60)
print("  RANDOM SPLIT")
print("=" * 60)
print(f"   Train: {len(ytr) if ytr is not None else 0} rows")
print(f"   Test:  {len(yte) if yte is not None else 0} rows")

Xtr_s, Xte_s, ytr_s, yte_s = stratified_split(X, y)
print()
print("=" * 60)
print("  STRATIFIED SPLIT")
print("=" * 60)
print(f"   Full ratio:  {y.mean():.3f}")
# TODO: print train and test ratio (mean of ytr_s and yte_s)
