# ============================================
# K-MEANS FROM SCRATCH — Full Solution
# Lesson 16 by Dan Santos
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
        self.inertia_ = None

    def fit(self, X):
        rng = np.random.default_rng(self.seed)
        n_samples = len(X)

        init_idx = rng.choice(n_samples, size=self.k, replace=False)
        centers = X[init_idx].copy()
        labels = np.zeros(n_samples, dtype=int)

        for iteration in range(self.max_iter):
            # E-step
            distances = np.linalg.norm(X[:, None, :] - centers[None, :, :], axis=2)
            new_labels = distances.argmin(axis=1)

            if iteration > 0 and (new_labels == labels).all():
                break
            labels = new_labels

            # M-step
            for k in range(self.k):
                pts = X[labels == k]
                if len(pts) > 0:
                    centers[k] = pts.mean(axis=0)

        # Final inertia
        distances = np.linalg.norm(X[:, None, :] - centers[None, :, :], axis=2)
        self.inertia_ = float((distances.min(axis=1) ** 2).sum())
        self.labels_ = labels
        self.centers_ = centers
        self.n_iter_ = iteration + 1
        return self


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

mean = customers.mean(axis=0)
std  = customers.std(axis=0)
X = (customers - mean) / std

model = KMeansScratch(n_clusters=3).fit(X)
centers_orig = model.centers_ * std + mean

print("=" * 60)
print(f"  K-MEANS — converged in {model.n_iter_} iterations")
print("=" * 60)
print(f"   Inertia: {model.inertia_:.2f}")
print()
for k in range(3):
    n_k = (model.labels_ == k).sum()
    avg_spend, visits = centers_orig[k]
    if avg_spend > 250:
        name = "payday_whale"
    elif visits > 20:
        name = "lola"
    else:
        name = "student_barkada"
    print(f"   Cluster {k}: avg_spend=P{avg_spend:.0f}, visits={visits:.1f}, "
          f"n={n_k} → '{name}'")

# Elbow
print()
print("=" * 60)
print("  ELBOW METHOD")
print("=" * 60)
for k in range(1, 8):
    m = KMeansScratch(n_clusters=k).fit(X)
    bar = "#" * int(m.inertia_ * 0.3)
    print(f"   K={k}: inertia={m.inertia_:6.2f}  {bar}")

print()
print("-- Takeaway --")
print("   K-Means found 3 groups WITHOUT being told they existed.")
print("   The algorithm gives clusters; you give them business names.")
