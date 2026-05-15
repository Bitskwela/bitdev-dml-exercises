# ============================================
# MODEL TUNING — Lesson 18
# by: <Your Name>
# ============================================
# Sweep max_depth on validation set. Pick best. Score on test once.
# ============================================

import io
import numpy as np
import pandas as pd

# Provided: DecisionTreeScratch — same as Lessons 14/15
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
df["is_saturday"]   = (df["day_of_week"] == "Saturday").astype(int)
df["is_rainy"]      = (df["weather"] == "rainy").astype(int)
df["is_busy"]       = (df["revenue"] >= 1200).astype(int)

X = df[["is_payday_int", "is_friday", "is_saturday", "is_rainy"]].to_numpy(dtype=float)
y = df["is_busy"].to_numpy(dtype=int)

# TODO: three-way split (60/20/20)
rng = np.random.default_rng(42)
idx = rng.permutation(len(X))
# n_test = int(0.2 * len(X))
# test_idx = idx[:n_test]; rest = idx[n_test:]
# n_val = int(0.25 * len(rest))   # 0.25 * 80% = 20% of total
# val_idx = rest[:n_val]; train_idx = rest[n_val:]

# TODO: sweep max_depth in [1,2,3,4,5,6,8,10,12,15]
# For each: train, score on train and val, record

# TODO: pick best by val_acc

# TODO: retrain on train + val combined; score on test ONCE
