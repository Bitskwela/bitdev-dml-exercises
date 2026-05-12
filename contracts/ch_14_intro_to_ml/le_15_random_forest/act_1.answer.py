# ============================================
# RANDOM FOREST FROM SCRATCH — Full Solution
# Lesson 15 by Dan Santos
# ============================================

import io
import numpy as np
import pandas as pd


class DecisionTreeScratch:
    """Reuse from Lesson 14."""
    def __init__(self, max_depth=3, min_samples_leaf=2):
        self.max_depth = max_depth
        self.min_samples_leaf = min_samples_leaf
        self.tree = None

    @staticmethod
    def _gini(y):
        if len(y) == 0: return 0.0
        p1 = y.mean()
        return float(1.0 - (p1 ** 2 + (1 - p1) ** 2))

    def _best_split(self, X, y):
        best_score = float("inf")
        best_split = None
        for feat_idx in range(X.shape[1]):
            for thr in np.unique(X[:, feat_idx]):
                left  = X[:, feat_idx] <= thr
                right = ~left
                if left.sum() < self.min_samples_leaf or right.sum() < self.min_samples_leaf:
                    continue
                g_left  = self._gini(y[left])
                g_right = self._gini(y[right])
                weighted = (left.sum() * g_left + right.sum() * g_right) / len(y)
                if weighted < best_score:
                    best_score = weighted
                    best_split = (feat_idx, thr)
        return best_split

    def _build(self, X, y, depth):
        if (depth >= self.max_depth or len(np.unique(y)) == 1
            or len(y) < 2 * self.min_samples_leaf):
            return {"leaf": True, "prediction": int(round(y.mean()))}
        split = self._best_split(X, y)
        if split is None:
            return {"leaf": True, "prediction": int(round(y.mean()))}
        feat_idx, thr = split
        mask = X[:, feat_idx] <= thr
        return {"leaf": False, "feature": feat_idx, "threshold": thr,
                "left":  self._build(X[mask],  y[mask],  depth + 1),
                "right": self._build(X[~mask], y[~mask], depth + 1)}

    def fit(self, X, y):
        self.tree = self._build(np.asarray(X, dtype=float),
                                np.asarray(y, dtype=int), depth=0)
        return self

    def _predict_one(self, row, node):
        if node["leaf"]: return node["prediction"]
        if row[node["feature"]] <= node["threshold"]:
            return self._predict_one(row, node["left"])
        return self._predict_one(row, node["right"])

    def predict(self, X):
        return np.array([self._predict_one(row, self.tree) for row in X], dtype=int)


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
        for _ in range(self.n_estimators):
            sample_idx = rng.integers(0, n, size=n)  # bootstrap WITH replacement
            tree = DecisionTreeScratch(max_depth=self.max_depth)
            tree.fit(X[sample_idx], y[sample_idx])
            self.trees.append(tree)
        return self

    def predict(self, X):
        votes = np.array([t.predict(X) for t in self.trees])  # shape: (n_trees, n_rows)
        return (votes.mean(axis=0) > 0.5).astype(int)


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

# Single tree baseline
single = DecisionTreeScratch(max_depth=4).fit(X[train_idx], y[train_idx])
acc_single = float((single.predict(X[test_idx]) == y[test_idx]).mean())

# Forest
forest = RandomForestScratch(n_estimators=10, max_depth=4, random_state=42)
forest.fit(X[train_idx], y[train_idx])
acc_forest = float((forest.predict(X[test_idx]) == y[test_idx]).mean())

print("=" * 60)
print("  SINGLE TREE vs RANDOM FOREST")
print("=" * 60)
print(f"   Single tree (max_depth=4):     test_acc = {acc_single:.3f}")
print(f"   Forest (10 trees, depth=4):    test_acc = {acc_forest:.3f}")
print(f"   Forest advantage:               {(acc_forest - acc_single)*100:+.1f} pp")

# Scale up
print()
print("=" * 60)
print("  Scale-up")
print("=" * 60)
for n_trees in [5, 10, 20, 50]:
    rf = RandomForestScratch(n_estimators=n_trees, max_depth=4, random_state=42)
    rf.fit(X[train_idx], y[train_idx])
    acc = float((rf.predict(X[test_idx]) == y[test_idx]).mean())
    print(f"   n_estimators={n_trees:<4}  test_acc = {acc:.3f}")

print()
print("-- Takeaway --")
print("   Same training data. Same algorithm shape per tree.")
print("   Ensemble averaging is the entire gain.")
print("   Ten weak votes beat one strong opinion.")
