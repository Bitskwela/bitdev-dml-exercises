# ============================================
# LOGISTIC REGRESSION FROM SCRATCH — Full Solution
# Lesson 13 by Dan Santos
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
        self.intercept_ = None
        self.coef_ = None
        self.loss_history_ = []

    def fit(self, X, y):
        n, p = X.shape
        X_bias = np.hstack([np.ones((n, 1)), X])
        w = np.zeros(p + 1)
        for _ in range(self.n_iter):
            probs = sigmoid(X_bias @ w)
            grad  = (1.0 / n) * X_bias.T @ (probs - y)
            w -= self.lr * grad
            eps = 1e-12
            loss = -np.mean(y * np.log(probs + eps) +
                            (1 - y) * np.log(1 - probs + eps))
            self.loss_history_.append(float(loss))
        self.weights_ = w
        self.intercept_ = w[0]
        self.coef_ = w[1:]
        return self

    def predict_proba(self, X):
        X_bias = np.hstack([np.ones((len(X), 1)), X])
        return sigmoid(X_bias @ self.weights_)

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

rng = np.random.default_rng(42)
idx = rng.permutation(len(X))
n_test = max(1, int(len(X) * 0.2))
test_idx, train_idx = idx[:n_test], idx[n_test:]
X_train, X_test = X[train_idx], X[test_idx]
y_train, y_test = y[train_idx], y[test_idx]

model = LogisticRegressionScratch(lr=0.1, n_iter=300).fit(X_train, y_train)
y_pred = model.predict(X_test)
accuracy = float((y_pred == y_test).mean())

print("=" * 65)
print("  LOGISTIC REGRESSION — FROM SCRATCH")
print("=" * 65)
print(f"   Intercept:        {model.intercept_:>+8.3f}")
for col, w in zip(feature_cols, model.coef_):
    print(f"   {col:<20} {w:>+8.3f}")
print(f"\n   Loss: {model.loss_history_[0]:.4f} -> {model.loss_history_[-1]:.4f}")
print(f"   Test accuracy:    {accuracy:.3f}")

# Confusion matrix
cm = np.zeros((2, 2), dtype=int)
for tr, pr in zip(y_test.astype(int), y_pred):
    cm[tr, pr] += 1
tn, fp, fn, tp = cm[0,0], cm[0,1], cm[1,0], cm[1,1]
prec = tp / (tp + fp) if (tp + fp) > 0 else 0.0
rec  = tp / (tp + fn) if (tp + fn) > 0 else 0.0

print(f"\n   Confusion:  TN={tn}  FP={fp}  FN={fn}  TP={tp}")
print(f"   Precision:  {prec:.3f}  (of all 'busy' predictions, % correct)")
print(f"   Recall:     {rec:.3f}  (of all true busy days, % caught)")

print()
print("-- Tita Malou's intuition, quantified --")
for col, w in zip(feature_cols, model.coef_):
    direction = "more likely busy" if w > 0 else "less likely busy"
    print(f"   {col:<20}: {w:>+.2f}  ({direction})")
