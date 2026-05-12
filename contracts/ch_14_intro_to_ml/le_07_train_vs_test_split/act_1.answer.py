# ============================================
# TRAIN/TEST SPLIT — Full Solution
# Lesson 7 by Dan Santos
# ============================================

import numpy as np

np.random.seed(0)
n = 30
X = np.random.rand(n, 3)
y = np.array([1]*10 + [0]*20)


def manual_split(X, y, test_size=0.2, seed=42):
    rng = np.random.default_rng(seed)
    n = len(X)
    indices = rng.permutation(n)
    n_test = int(n * test_size)
    test_idx, train_idx = indices[:n_test], indices[n_test:]
    return X[train_idx], X[test_idx], y[train_idx], y[test_idx]


def stratified_split(X, y, test_size=0.2, seed=42):
    rng = np.random.default_rng(seed)
    train_idx, test_idx = [], []
    for cls in np.unique(y):
        cls_indices = np.where(y == cls)[0]
        cls_indices = rng.permutation(cls_indices)
        n_test_cls = int(len(cls_indices) * test_size)
        test_idx.extend(cls_indices[:n_test_cls].tolist())
        train_idx.extend(cls_indices[n_test_cls:].tolist())
    train_idx = np.array(train_idx, dtype=int)
    test_idx  = np.array(test_idx,  dtype=int)
    return X[train_idx], X[test_idx], y[train_idx], y[test_idx]


# Random split
Xtr, Xte, ytr, yte = manual_split(X, y)
print("=" * 60)
print("  RANDOM SPLIT")
print("=" * 60)
print(f"   Train: {len(ytr)} rows, busy={ytr.sum()}, not_busy={(ytr==0).sum()}")
print(f"   Test:  {len(yte)} rows, busy={yte.sum()}, not_busy={(yte==0).sum()}")

# Stratified split
Xtr_s, Xte_s, ytr_s, yte_s = stratified_split(X, y)
print()
print("=" * 60)
print("  STRATIFIED SPLIT")
print("=" * 60)
print(f"   Full ratio:  {y.mean():.3f}")
print(f"   Train ratio: {ytr_s.mean():.3f}")
print(f"   Test ratio:  {yte_s.mean():.3f}")

print()
print("=" * 60)
print("  THE THREE RULES OF TEST DATA")
print("=" * 60)
print("   1. Never train on test rows.")
print("   2. Never tune hyperparameters against test.")
print("   3. Never even peek. First read of y_test = LAST line of script.")

print()
print("-- Takeaway --")
print("   Splits with the same seed give the same split — reproducible.")
print("   Stratified splits preserve class ratios — essential for imbalanced data.")
