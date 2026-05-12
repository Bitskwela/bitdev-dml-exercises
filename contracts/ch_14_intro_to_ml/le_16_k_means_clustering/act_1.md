# K-Means From Scratch

Cluster 60 synthetic customers (avg_spend, visit_count) into 3 groups using the EM loop.

---

## Task 1: The KMeans Class

```python
class KMeansScratch:
    def __init__(self, n_clusters=3, max_iter=100, seed=42):
        self.k = n_clusters
        self.max_iter = max_iter
        self.seed = seed
    
    def fit(self, X):
        rng = np.random.default_rng(self.seed)
        # 1. Pick K random rows as initial centers
        # 2. Loop:
        #    distances = np.linalg.norm(X[:, None, :] - centers[None, :, :], axis=2)
        #    labels = distances.argmin(axis=1)
        #    if labels unchanged: break
        #    centers = mean of points per cluster
        # 3. Save self.labels_ and self.centers_
```

---

## Task 2: Cluster Synthetic Customers

The starter generates 60 customers across 3 hidden types. Standardize features, fit K=3, name each cluster.

---

## Sample Output

```
   Cluster 0: avg_spend=82,  visits=27 → 'lola'
   Cluster 1: avg_spend=220, visits=14 → 'student_barkada'
   Cluster 2: avg_spend=351, visits=8  → 'payday_whale'
```

---

## Reflection Questions

1. Why must we STANDARDIZE features before K-Means?
2. K-Means cluster IDs are arbitrary — "cluster 0" in one run might be "cluster 2" in another. Why?
3. What is the elbow method, and why does inertia keep falling but with diminishing returns?

---

## What You've Learned

- K-Means as iterative E-step + M-step
- Why standardization matters for distance-based methods
- How to name unsupervised clusters from their centroids
