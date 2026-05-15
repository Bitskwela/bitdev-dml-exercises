# ============================================
# RANDOM FOREST FROM SCRATCH — Lesson 15
# by: <Your Name>
# ============================================
# Bag 10 shallow trees, majority-vote on each prediction.
# Reuses Lesson 14's DecisionTreeScratch.
# ============================================

import io
import numpy as np
import pandas as pd

# DecisionTreeScratch: provided from Lesson 14 — do not modify
class DecisionTreeScratch:
    def __init__(self, max_depth=3, min_samples_leaf=2):
        self.max_depth = max_depth; self.min_samples_leaf = min_samples_leaf; self.tree = None
    @staticmethod
    def _gini(y):
        p1 = y.mean(); return float(1.0 - (p1**2 + (1-p1)**2)) if len(y) else 0.0
    def _best_split(self, X, y):
        best, res = float("inf"), None
        for f in range(X.shape[1]):
            for thr in np.unique(X[:, f]):
                l = X[:, f] <= thr
                if l.sum() < self.min_samples_leaf or (~l).sum() < self.min_samples_leaf: continue
                w = (l.sum()*self._gini(y[l]) + (~l).sum()*self._gini(y[~l])) / len(y)
                if w < best: best, res = w, (f, thr)
        return res
    def _build(self, X, y, d):
        if d >= self.max_depth or len(np.unique(y)) == 1 or len(y) < 2*self.min_samples_leaf:
            return {"leaf": True, "prediction": int(round(y.mean()))}
        s = self._best_split(X, y)
        if s is None: return {"leaf": True, "prediction": int(round(y.mean()))}
        f, thr = s; mask = X[:, f] <= thr
        return {"leaf": False, "feature": f, "threshold": thr,
                "left": self._build(X[mask], y[mask], d+1), "right": self._build(X[~mask], y[~mask], d+1)}
    def fit(self, X, y):
        self.tree = self._build(np.asarray(X, float), np.asarray(y, int), 0); return self
    def _predict_one(self, row, node):
        return node["prediction"] if node["leaf"] else self._predict_one(row, node["left" if row[node["feature"]] <= node["threshold"] else "right"])
    def predict(self, X):
        return np.array([self._predict_one(r, self.tree) for r in X], dtype=int)


class RandomForestScratch:
    def __init__(self, n_estimators=10, max_depth=4, random_state=42):
        self.n_estimators = n_estimators
        self.max_depth = max_depth
        self.random_state = random_state
        self.trees = []

    def fit(self, X, y):
        rng = np.random.default_rng(self.random_state)
        n = len(X)
        self.trees = []
        # TODO: for i in range(self.n_estimators):
        #   bootstrap sample indices with replacement: rng.integers(0, n, size=n)
        #   train a DecisionTreeScratch on X[sample], y[sample]
        #   append to self.trees
        return self

    def predict(self, X):
        # TODO: collect predictions from each tree (rows = trees, cols = test rows)
        # TODO: majority vote per row: (votes.mean(axis=0) > 0.5).astype(int)
        pass


# Load + prep data (same as Lesson 14)
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

X = df[["is_payday_int", "is_friday", "is_saturday", "is_rainy"]].to_numpy(dtype=float)
y = df["is_busy"].to_numpy(dtype=int)

rng = np.random.default_rng(42)
idx = rng.permutation(len(X))
n_test = max(1, int(len(X) * 0.2))
test_idx, train_idx = idx[:n_test], idx[n_test:]

# TODO: train single tree, train forest, compare accuracies
