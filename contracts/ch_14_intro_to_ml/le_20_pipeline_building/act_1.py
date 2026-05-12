# ============================================
# PIPELINE BUILDING — Lesson 20
# by: <Your Name>
# ============================================
# def run(df, model, cv=5) — the whole workflow in one function.
# ============================================

import io
import numpy as np
import pandas as pd


def clean(df):
    """Fix dtypes, drop nulls."""
    df = df.copy()
    df["is_payday"] = df["is_payday"].map({"True": True, "False": False,
                                             True: True, False: False})
    return df.dropna()


def engineer(df):
    """Return (X numpy array, y numpy array, feature_names list)."""
    df = df.copy()
    df["is_payday_int"] = df["is_payday"].astype(int)
    df["is_friday"]     = (df["day_of_week"] == "Friday").astype(int)
    df["is_saturday"]   = (df["day_of_week"] == "Saturday").astype(int)
    df["is_rainy"]      = (df["weather"] == "rainy").astype(int)
    df["is_busy"]       = (df["revenue"] >= 1200).astype(int)
    feat = ["is_payday_int", "is_friday", "is_saturday", "is_rainy"]
    return df[feat].to_numpy(dtype=float), df["is_busy"].to_numpy(dtype=float), feat


def stratified_kfold_cv(X, y, model_factory, k=5, seed=42):
    """Reuse from Lesson 19."""
    rng = np.random.default_rng(seed)
    y_int = np.asarray(y, dtype=int)
    fold_indices = [[] for _ in range(k)]
    for cls in np.unique(y_int):
        cls_idx = np.where(y_int == cls)[0]
        cls_idx = rng.permutation(cls_idx)
        for i, chunk in enumerate(np.array_split(cls_idx, k)):
            fold_indices[i].extend(chunk.tolist())
    fold_indices = [np.array(f, dtype=int) for f in fold_indices]

    scores = []
    for i in range(k):
        te = fold_indices[i]
        tr = np.concatenate([fold_indices[j] for j in range(k) if j != i])
        m = model_factory()
        m.fit(X[tr], y[tr])
        scores.append(m.score(X[te], y[te]))
    return np.array(scores)


def run(df, model_factory, cv=5):
    """End-to-end: clean -> engineer -> CV. Return (mean, std)."""
    # TODO: clean, engineer, run CV, return mean and std
    pass


# Simple LogReg for demo
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
        return float((self.predict(X) == y.astype(int)).mean())


SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2025-08-01,Bistek,7,665,Friday,False,cloudy
2025-08-02,Kare-Kare,8,944,Saturday,False,rainy
2025-08-15,Sinigang,21,1575,Friday,True,rainy
2025-08-15,Kare-Kare,14,1652,Friday,True,rainy
2025-08-22,Sinigang,11,715,Friday,False,cloudy
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

# TODO: call run(df, lambda: LogReg(), cv=5) and print the result
