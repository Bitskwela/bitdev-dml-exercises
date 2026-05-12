# PCA From Scratch

Project an 8-feature carinderia matrix into 2D using `np.linalg.svd`.

---

## Task 1: Three-Line PCA

Open `act_1.py`. Standardize features, then:

```python
X_centered = X_scaled - X_scaled.mean(axis=0)
U, S, Vt = np.linalg.svd(X_centered, full_matrices=False)
X_2d = X_centered @ Vt[:2].T
```

---

## Task 2: Explained Variance

```python
explained_variance = S**2 / (S**2).sum()
print(f"PC1: {explained_variance[0]:.1%}")
print(f"PC2: {explained_variance[1]:.1%}")
```

---

## Task 3: Read PC1's Loadings

`Vt[0]` is PC1 — print each original feature's contribution. The largest-magnitude loadings tell you what PC1 "represents."

---

## Sample Output

```
   Explained variance:
     PC1: 24.7%
     PC2: 18.1%
     PC1+PC2: 42.8%

   PC1 loadings:
     is_payday_int   +0.612
     quantity_z      +0.501
     is_friday       +0.402
     is_rainy        +0.225
     ...

   PC1 reads as: "the busy-payday axis"
```

---

## Reflection Questions

1. Why must features be STANDARDIZED before PCA?
2. PC1 captures 24.7% of variance. If you keep only PC1, what fraction of information do you discard?
3. Look at the top 3 features in PC1's loadings. Together, what do they represent?

---

## What You've Learned

- Three-line PCA via `np.linalg.svd`
- Explained variance ratio as the "how much information kept" metric
- Reading principal components as weighted combinations of original features
