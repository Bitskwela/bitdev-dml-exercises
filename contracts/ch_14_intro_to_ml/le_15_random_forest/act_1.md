# Random Forest From Scratch

Reuse Lesson 14's `DecisionTreeScratch`. Wrap it in a `RandomForestScratch` that bootstraps + majority-votes.

---

## Task 1: Bootstrap Sample

For N rows, draw N indices with replacement:

```python
sample_idx = rng.integers(0, n, size=n)
```

---

## Task 2: Random Forest Class

```python
class RandomForestScratch:
    def __init__(self, n_estimators=10, max_depth=4, random_state=42):
        self.n_estimators = n_estimators
        self.max_depth = max_depth
        self.random_state = random_state
        self.trees = []
    
    def fit(self, X, y):
        rng = np.random.default_rng(self.random_state)
        for i in range(self.n_estimators):
            sample_idx = rng.integers(0, len(X), size=len(X))
            tree = DecisionTreeScratch(max_depth=self.max_depth)
            tree.fit(X[sample_idx], y[sample_idx])
            self.trees.append(tree)
    
    def predict(self, X):
        votes = np.array([tree.predict(X) for tree in self.trees])
        # Majority vote per row
        return (votes.mean(axis=0) > 0.5).astype(int)
```

---

## Task 3: Compare to Single Tree

Train a single tree (`max_depth=4`) and a forest (10 trees, `max_depth=4`). Compare test accuracies on the same train/test split. Forest should beat single tree by 3-8 percentage points.

---

## Sample Output

```
   Single tree:    test_acc = 0.81
   Forest (10):    test_acc = 0.86  (+5pp)
```

---

## Reflection Questions

1. Why does each tree see only ~63% of unique training rows on average?
2. If you ran the forest with `n_estimators=1`, would it match the single tree exactly? Why or why not?
3. The forest beats the single tree by ~5pp. Where does that gain come from mathematically?

---

## What You've Learned

- Bagging: bootstrap samples + majority vote
- Random subspace: random feature subsets per tree (diversity)
- Why ensembles cancel out individual-tree variance
- Forests as a strong default for tabular data
