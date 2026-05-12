# ============================================
# K-MEANS FROM SCRATCH — Lesson 16
# by: <Your Name>
# ============================================
# EM loop: assign points to nearest center, then move centers.
# ============================================

import numpy as np


class KMeansScratch:
    def __init__(self, n_clusters=3, max_iter=100, seed=42):
        self.k = n_clusters
        self.max_iter = max_iter
        self.seed = seed
        self.labels_ = None
        self.centers_ = None
        self.n_iter_ = 0

    def fit(self, X):
        rng = np.random.default_rng(self.seed)
        n_samples = len(X)
        # TODO: init: pick k random rows as centers
        init_idx = rng.choice(n_samples, size=self.k, replace=False)
        centers = X[init_idx].copy()
        labels = np.zeros(n_samples, dtype=int)

        for iteration in range(self.max_iter):
            # TODO: E-step — compute distances and assign labels
            # distances shape: (n_samples, k)
            # new_labels = distances.argmin(axis=1)

            # TODO: check for convergence
            # if iteration > 0 and (new_labels == labels).all(): break
            # labels = new_labels

            # TODO: M-step — move centers to cluster means
            # for each k, centers[k] = X[labels == k].mean(axis=0)
            pass

        self.labels_ = labels
        self.centers_ = centers
        self.n_iter_ = iteration + 1
        return self


# Synthetic 60 customers across 3 types
rng = np.random.default_rng(42)
def make_group(profile, n):
    if profile == "lola":
        return np.column_stack([rng.normal(80,  15, n),  rng.normal(28, 5, n)])
    if profile == "whale":
        return np.column_stack([rng.normal(350, 60, n),  rng.normal(8,  3, n)])
    if profile == "students":
        return np.column_stack([rng.normal(220, 40, n),  rng.normal(14, 4, n)])

customers = np.vstack([make_group("lola", 20),
                        make_group("whale", 18),
                        make_group("students", 22)])

# Standardize
X = (customers - customers.mean(axis=0)) / customers.std(axis=0)

# TODO: fit K-Means
model = KMeansScratch(n_clusters=3).fit(X)

# TODO: print cluster sizes, centroids (un-standardized), and cluster labels
