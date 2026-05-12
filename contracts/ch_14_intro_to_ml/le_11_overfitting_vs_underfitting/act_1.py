# ============================================
# OVERFITTING DEMO — Lesson 11
# by: <Your Name>
# ============================================
# Fit polynomial degree 1..9 on synthetic data; watch the U-shape.
# ============================================

import numpy as np


def polynomial_features(x, degree):
    """Given 1D array x, return matrix [x, x^2, ..., x^degree]."""
    # TODO: column_stack of x ** d for d in 1..degree
    pass


def fit_normal_eq(X, y):
    """Fit linear regression weights via normal equation (no class)."""
    X_bias = np.hstack([np.ones((len(X), 1)), X])
    return np.linalg.solve(X_bias.T @ X_bias, X_bias.T @ y)


def predict(X, w):
    X_bias = np.hstack([np.ones((len(X), 1)), X])
    return X_bias @ w


def mae(y, p):
    return float(np.mean(np.abs(y - p)))


# Synthetic 1D data: revenue as a function of day_of_month
np.random.seed(42)
x_all = np.array([1, 2, 3, 5, 8, 10, 12, 14, 15, 15, 17, 19, 22, 25, 28, 30],
                  dtype=float)
y_all = 800 + 30 * x_all                       # underlying linear trend
y_all[8:10] += 500                              # payday spike on day 15
y_all[12] += 200                                # payday spike on day 30
y_all += np.random.normal(0, 80, size=len(x_all))  # noise

# Split: first 12 train, last 4 test (small data — overfitting shows easily)
X_train_1d = x_all[:12]; y_train = y_all[:12]
X_test_1d  = x_all[12:]; y_test  = y_all[12:]

print("=" * 55)
print(f"  Train: {len(X_train_1d)}  Test: {len(X_test_1d)}")
print("=" * 55)

results = []
for degree in [1, 2, 3, 4, 5, 6, 7, 8, 9]:
    # TODO: build polynomial features for train and test
    # TODO: fit, predict, compute train and test MAE
    # TODO: append result dict
    pass

# TODO: print table
# TODO: find best degree by test MAE
