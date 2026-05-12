# ============================================
# OVERFITTING DEMO — Full Solution
# Lesson 11 by Dan Santos
# ============================================

import numpy as np


def polynomial_features(x, degree):
    return np.column_stack([x ** d for d in range(1, degree + 1)])


def fit_normal_eq(X, y):
    X_bias = np.hstack([np.ones((len(X), 1)), X])
    return np.linalg.solve(X_bias.T @ X_bias, X_bias.T @ y)


def predict(X, w):
    X_bias = np.hstack([np.ones((len(X), 1)), X])
    return X_bias @ w


def mae(y, p):
    return float(np.mean(np.abs(y - p)))


# Synthetic 1D data: revenue vs day_of_month
np.random.seed(42)
x_all = np.array([1, 2, 3, 5, 8, 10, 12, 14, 15, 15, 17, 19, 22, 25, 28, 30],
                  dtype=float)
y_all = 800 + 30 * x_all
y_all[8:10] += 500
y_all[12] += 200
y_all += np.random.normal(0, 80, size=len(x_all))

X_train_1d = x_all[:12]; y_train = y_all[:12]
X_test_1d  = x_all[12:]; y_test  = y_all[12:]

print("=" * 55)
print(f"  Train: {len(X_train_1d)}  Test: {len(X_test_1d)}")
print("=" * 55)

results = []
for degree in [1, 2, 3, 4, 5, 6, 7, 8, 9]:
    Xtr = polynomial_features(X_train_1d, degree)
    Xte = polynomial_features(X_test_1d,  degree)

    w = fit_normal_eq(Xtr, y_train)
    train_pred = predict(Xtr, w)
    test_pred  = predict(Xte, w)

    results.append({
        "degree":    degree,
        "train_MAE": mae(y_train, train_pred),
        "test_MAE":  mae(y_test,  test_pred),
    })

print()
print(f"   {'degree':>6}  {'train_MAE':>12}  {'test_MAE':>12}  {'gap':>10}")
print("   " + "-" * 50)
for r in results:
    gap = r["test_MAE"] - r["train_MAE"]
    print(f"   {r['degree']:>6}  {r['train_MAE']:>12.1f}  "
          f"{r['test_MAE']:>12.1f}  {gap:>10.1f}")

best = min(results, key=lambda r: r["test_MAE"])
print()
print(f"-- Best degree by test MAE: {best['degree']}")
print(f"   Train and test errors close, both low — Goldilocks zone.")

print()
print("-- Takeaway --")
print("   Train MAE keeps falling as degree grows (the model memorizes).")
print("   Test MAE has a U-shape — finds the right complexity then explodes.")
print("   The gap is the overfitting signal. Pick the trough.")
