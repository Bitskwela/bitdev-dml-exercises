## Dan's Story: Drawing 8 Dimensions on a Napkin

Sunday evening. Dan had engineered 8 features per carinderia row. He wanted to *see* whether they clustered cleanly.

> **Dan:** Ate, I have 8 features. How do I plot 8 dimensions?
>
> **Ate Rina:** You can't. But you can PROJECT 8 dimensions down to 2 in a way that preserves the most "spread." That's PCA. The math is `np.linalg.svd`. One numpy call. Mean-center first.

He typed three lines:

```python
X_centered = X - X.mean(axis=0)
U, S, Vt = np.linalg.svd(X_centered, full_matrices=False)
X_2d = X_centered @ Vt[:2].T
```

He plotted it, colored by `is_payday`. Two clean clouds. *Visible to the eye.*

---

## The Concept: PCA

### What PCA Does

Finds a new coordinate system where:
- **PC1** points in the direction of maximum variance
- **PC2** is perpendicular to PC1 and captures next-most variance
- ...

Keep only the top K axes (usually 2 or 3 for visualization). You've compressed N dimensions into K while preserving the most-varying structure.

### Three Numpy Lines

```python
X_centered = X - X.mean(axis=0)            # mean-center
U, S, Vt   = np.linalg.svd(X_centered, full_matrices=False)
X_2d       = X_centered @ Vt[:2].T          # project to 2D
```

Rows of `Vt` are the principal components. Singular values `S` tell you how much variance each component captures.

### Explained Variance Ratio

```python
explained_variance = S**2 / (S**2).sum()
# e.g., [0.42, 0.18, 0.12, ...]
```

PC1 captures 42% of total variance. PC1 + PC2 together cover 60%. For 2D visualization you want the first 2 components to cover at least ~50%.

### Standardize First (Like K-Means)

PCA is scale-sensitive. Always standardize before SVD:

```python
X_scaled = (X - X.mean(axis=0)) / X.std(axis=0)
```

### Reading PC1's Loadings

The first row of `Vt` is PC1 — a weighted combination of original features:

```
PC1 = +0.61 · is_payday + 0.50 · quantity + 0.40 · is_friday + ...
```

You can read PC1 as "the busy-payday axis" because those features have the highest absolute loadings. PCs are interpretable if you look at the loadings.

---

## Key Takeaways

- **PCA = SVD on mean-centered data.** One numpy line. Compresses N dims to K.
- **Always standardize** before PCA — scale-sensitive like K-Means.
- **Explained variance ratio** tells you how much information each PC captures.
- **PC1 loadings are interpretable** as a weighted combination of original features.
- **For non-linear structure**, use t-SNE or UMAP instead of PCA.

---

## What's Next?

Every algorithm has hyperparameters (max_depth, learning_rate, n_estimators). How do you pick them? Tomorrow: a manual sweep with proper train/validation/test splits.

**Next Lesson: Model Tuning** — sweep `max_depth` and pick the validation winner.
