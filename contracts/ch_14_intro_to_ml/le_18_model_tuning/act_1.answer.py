# ============================================
# MODEL TUNING — Full Solution
# Lesson 18 by Dan Santos
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
        if len(y) == 0: return 0.0
        p1 = y.mean()
        return float(1.0 - (p1 ** 2 + (1 - p1) ** 2))

    def _best_split(self, X, y):
        best_score = float("inf"); best_split = None
        for f in range(X.shape[1]):
            for thr in np.unique(X[:, f]):
                left  = X[:, f] <= thr
                right = ~left
                if left.sum() < self.min_samples_leaf or right.sum() < self.min_samples_leaf:
                    continue
                w = (left.sum() * self._gini(y[left]) + right.sum() * self._gini(y[right])) / len(y)
                if w < best_score:
                    best_score, best_split = w, (f, thr)
        return best_split

    def _build(self, X, y, depth):
        if (depth >= self.max_depth or len(np.unique(y)) == 1
            or len(y) < 2 * self.min_samples_leaf):
            return {"leaf": True, "prediction": int(round(y.mean()))}
        s = self._best_split(X, y)
        if s is None: return {"leaf": True, "prediction": int(round(y.mean()))}
        f, thr = s
        mask = X[:, f] <= thr
        return {"leaf": False, "feature": f, "threshold": thr,
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

# Three-way split
rng = np.random.default_rng(42)
idx = rng.permutation(len(X))
n_test = max(1, int(0.2 * len(X)))
test_idx, rest = idx[:n_test], idx[n_test:]
n_val = max(1, int(0.25 * len(rest)))
val_idx, train_idx = rest[:n_val], rest[n_val:]

print("=" * 60)
print(f"  Train: {len(train_idx)}  Val: {len(val_idx)}  Test: {len(test_idx)}")
print("=" * 60)

# Sweep
results = []
for d in [1, 2, 3, 4, 5, 6, 8, 10, 12, 15]:
    tree = DecisionTreeScratch(max_depth=d).fit(X[train_idx], y[train_idx])
    train_acc = float((tree.predict(X[train_idx]) == y[train_idx]).mean())
    val_acc   = float((tree.predict(X[val_idx])   == y[val_idx]).mean())
    results.append({"depth": d, "train": train_acc, "val": val_acc})

print(f"\n   {'depth':>6}  {'train_acc':>10}  {'val_acc':>10}  {'gap':>10}")
print("   " + "-" * 42)
for r in results:
    print(f"   {r['depth']:>6}  {r['train']:>10.3f}  {r['val']:>10.3f}  "
          f"{r['train']-r['val']:>+10.3f}")

best = max(results, key=lambda r: r["val"])
print(f"\n   Best by validation: max_depth = {best['depth']} "
      f"(val_acc = {best['val']:.3f})")

# Final test (touched once)
combined_X = np.vstack([X[train_idx], X[val_idx]])
combined_y = np.concatenate([y[train_idx], y[val_idx]])
final_tree = DecisionTreeScratch(max_depth=best["depth"]).fit(combined_X, combined_y)
test_acc = float((final_tree.predict(X[test_idx]) == y[test_idx]).mean())

print(f"\n   Retrained on train+val ({len(combined_X)} rows).")
print(f"   FINAL test accuracy: {test_acc:.3f}")

print()
print("-- Takeaway --")
print("   Validation chooses hyperparameters. Test reports ONE honest score.")
print("   The most honest number is the lowest one to find.")
