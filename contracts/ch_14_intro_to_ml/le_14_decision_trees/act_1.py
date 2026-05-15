# ============================================
# DECISION TREE FROM SCRATCH — Lesson 14
# by: <Your Name>
# ============================================
# Recursive Gini-based decision tree (binary classification).
# ============================================

import io
import numpy as np
import pandas as pd


class DecisionTreeScratch:
    def __init__(self, max_depth=3, min_samples_leaf=2):
        self.max_depth = max_depth
        self.min_samples_leaf = min_samples_leaf
        self.tree = None

    @staticmethod
    def _gini(y):
        if len(y) == 0:
            return 0.0
        p1 = y.mean()
        return float(1.0 - (p1 ** 2 + (1 - p1) ** 2))

    def _best_split(self, X, y):
        """Find feature + threshold minimizing weighted child Gini."""
        # TODO: loop over features and unique values; track best (weighted_gini, feat, thr)
        return None

    def _build(self, X, y, depth):
        """Recursively build the tree. Return a dict node."""
        if (depth >= self.max_depth
            or len(np.unique(y)) == 1
            or len(y) < 2 * self.min_samples_leaf):
            return {"leaf": True, "prediction": int(round(y.mean())), "n": len(y)}
        # TODO: find best split; if None, return leaf
        # TODO: split data, recurse left and right
        pass

    def fit(self, X, y):
        self.tree = self._build(np.asarray(X, dtype=float),
                                np.asarray(y, dtype=int), depth=0)
        return self

    def _predict_one(self, row, node):
        if node["leaf"]: return node["prediction"]
        return self._predict_one(row, node["left"] if row[node["feature"]] <= node["threshold"] else node["right"])

    def predict(self, X):
        return np.array([self._predict_one(row, self.tree) for row in X], dtype=int)


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
y = df["is_busy"].to_numpy(dtype=int)

rng = np.random.default_rng(42)
idx = rng.permutation(len(X))
n_test = max(1, int(len(X) * 0.2))
test_idx, train_idx = idx[:n_test], idx[n_test:]

# TODO: fit the tree
tree = DecisionTreeScratch(max_depth=2)
# TODO: tree.fit(X[train_idx], y[train_idx])
# TODO: accuracy = (tree.predict(X[test_idx]) == y[test_idx]).mean()
# TODO: print(f"Test accuracy: {accuracy:.3f}")
