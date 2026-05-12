# ============================================
# DECISION TREE FROM SCRATCH — Full Solution
# Lesson 14 by Dan Santos
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
        if (depth >= self.max_depth
            or len(np.unique(y)) == 1
            or len(y) < 2 * self.min_samples_leaf):
            return {"leaf": True, "prediction": int(round(y.mean())), "n": len(y)}

        split = self._best_split(X, y)
        if split is None:
            return {"leaf": True, "prediction": int(round(y.mean())), "n": len(y)}

        feat_idx, thr = split
        mask = X[:, feat_idx] <= thr
        return {
            "leaf": False, "feature": feat_idx, "threshold": thr,
            "left":  self._build(X[mask],  y[mask],  depth + 1),
            "right": self._build(X[~mask], y[~mask], depth + 1),
            "n": len(y),
        }

    def fit(self, X, y):
        self.tree = self._build(np.asarray(X, dtype=float),
                                np.asarray(y, dtype=int), depth=0)
        return self

    def _predict_one(self, row, node):
        if node["leaf"]:
            return node["prediction"]
        if row[node["feature"]] <= node["threshold"]:
            return self._predict_one(row, node["left"])
        return self._predict_one(row, node["right"])

    def predict(self, X):
        return np.array([self._predict_one(row, self.tree) for row in X], dtype=int)

    def print_tree(self, feature_names, node=None, depth=0):
        if node is None:
            node = self.tree
        indent = "  " * depth
        if node["leaf"]:
            label = "busy" if node["prediction"] == 1 else "not_busy"
            print(f"{indent}-> predict {label}  (n={node['n']})")
            return
        fname = feature_names[node["feature"]]
        print(f"{indent}if {fname} <= {node['threshold']:.1f}:")
        self.print_tree(feature_names, node["left"],  depth + 1)
        print(f"{indent}else:")
        self.print_tree(feature_names, node["right"], depth + 1)


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

tree = DecisionTreeScratch(max_depth=2, min_samples_leaf=2)
tree.fit(X[train_idx], y[train_idx])

print("=" * 60)
print("  DECISION TREE (max_depth=2)")
print("=" * 60)
tree.print_tree(feature_cols)

accuracy = float((tree.predict(X[test_idx]) == y[test_idx]).mean())
print(f"\n   Test accuracy: {accuracy:.3f}")

# Complexity sweep
print()
print("=" * 60)
print("  COMPLEXITY SWEEP")
print("=" * 60)
for d in [1, 2, 3, 5, 8]:
    t = DecisionTreeScratch(max_depth=d).fit(X[train_idx], y[train_idx])
    train_acc = float((t.predict(X[train_idx]) == y[train_idx]).mean())
    test_acc  = float((t.predict(X[test_idx])  == y[test_idx]).mean())
    print(f"   max_depth={d}  train={train_acc:.3f}  test={test_acc:.3f}  "
          f"gap={train_acc-test_acc:+.3f}")

print()
print("-- Read the tree --")
print("   The first split is is_payday — exactly what Tita Malou would do.")
print("   No one taught the algorithm that payday matters. It found it from data.")
