# ============================================
# CROSS VALIDATION — Lesson 19
# by: <Your Name>
# ============================================
# Manual stratified 5-fold CV from scratch in numpy.
# ============================================

import io
import numpy as np
import pandas as pd


def stratified_kfold_cv(X, y, model_factory, k=5, seed=42):
    """
    Return numpy array of k fold-scores.
    model_factory is a zero-arg callable that returns a fresh model.
    """
    rng = np.random.default_rng(seed)
    # TODO: build stratified fold indices
    # For each unique class, shuffle its row indices and split into k chunks.
    # fold_indices[i] = all rows in fold i (across both classes).

    # TODO: for each fold i:
    #   test_idx  = fold_indices[i]
    #   train_idx = concatenate(fold_indices[j] for j != i)
    #   fit a fresh model on train, score on test
    #   append to scores

    scores = []
    return np.array(scores)


# Toy logistic regression for testing
class LogReg:
    def __init__(self, lr=0.1, n_iter=200):
        self.lr = lr; self.n_iter = n_iter; self.w = None
    def fit(self, X, y):
        n, p = X.shape
        Xb = np.hstack([np.ones((n, 1)), X])
        w = np.zeros(p + 1)
        for _ in range(self.n_iter):
            z = np.clip(Xb @ w, -500, 500)
            ph = 1 / (1 + np.exp(-z))
            w -= self.lr * (Xb.T @ (ph - y)) / n
        self.w = w
        return self
    def predict(self, X):
        Xb = np.hstack([np.ones((len(X), 1)), X])
        return ((1 / (1 + np.exp(-np.clip(Xb @ self.w, -500, 500)))) >= 0.5).astype(int)
    def score(self, X, y):
        return float((self.predict(X) == y).mean())


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
2025-09-30,Adobo,16,1280,Tuesday,True,sunny
2025-10-15,Kare-Kare,17,2006,Wednesday,True,rainy
2025-10-30,Sinigang,19,1425,Thursday,True,cloudy
2025-11-08,Bistek,11,1045,Saturday,False,sunny
2025-11-15,Adobo,15,1200,Saturday,True,sunny
"""
df = pd.read_csv(io.StringIO(SAMPLE_CSV))
df["is_payday"] = df["is_payday"].map({"True": True, "False": False,
                                         True: True, False: False})
df["is_payday_int"] = df["is_payday"].astype(int)
df["is_friday"]     = (df["day_of_week"] == "Friday").astype(int)
df["is_rainy"]      = (df["weather"] == "rainy").astype(int)
df["is_busy"]       = (df["revenue"] >= 1200).astype(int)

X = df[["is_payday_int", "is_friday", "is_rainy"]].to_numpy(dtype=float)
y = df["is_busy"].to_numpy(dtype=float)

# TODO: run stratified_kfold_cv with LogReg factory
# scores = stratified_kfold_cv(X, y, lambda: LogReg(), k=5)
# print(scores)
# print(f"Mean: {scores.mean():.3f}  Std: {scores.std():.3f}")
