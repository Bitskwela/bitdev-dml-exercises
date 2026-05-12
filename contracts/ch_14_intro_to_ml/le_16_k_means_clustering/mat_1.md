## Dan's Story: Customers Tita Malou Almost Has Names For

Saturday afternoon. Carinderia between lunch and merienda. Tita Malou pointed at her receipt book.

> **Tita Malou:** Ito si Lola Pacing — every Sunday, halo-halo lang, mura. Ito si Mang Lito — payday, kare-kare, big spender. Ito si yung mga estudyante — sometimes lang, dami nila per visit.
>
> **Dan:** So there are three kinds of customers — regulars, payday whales, students?
>
> **Dan (DM to Ate Rina):** I want the computer to FIND those groups itself. No labels. Just data.
>
> **Ate Rina:** K-Means bata. Classic. Pick K = 3. Random init. EM loop. ~30 lines of numpy.

He typed it. The clusters matched Tita Malou's descriptions almost exactly. She nodded slowly. *Tama lahat, anak.*

---

## The Concept: K-Means

### The Four-Sentence Algorithm

1. Pick K (number of clusters).
2. Initialize K cluster centers randomly.
3. **E-step:** assign each point to its nearest center.
4. **M-step:** move each center to the mean of its assigned points.

Repeat E and M until labels stop changing. That's the whole algorithm.

### Why It Works

Each iteration reduces the *within-cluster sum of squared distances* (inertia). Both steps can only decrease total distance, so the algorithm converges. It may converge to a local minimum — the fix is `n_init=10` (run with 10 random inits, keep best).

### Standardize Before Clustering

K-Means uses Euclidean distance, which is sensitive to feature scale. Always:

```python
X_scaled = (X - X.mean(axis=0)) / X.std(axis=0)
```

A feature with range 0-1000 will dominate a feature with range 0-1 otherwise.

### Picking K (The Elbow Method)

Run K-Means for K = 1, 2, 3, ..., 8. Plot inertia. Look for an elbow — where adding more clusters stops dropping inertia much. For 3 clear groups, the elbow lands at K=3.

### Naming the Clusters Is YOUR Job

The algorithm gives you groups; you give them business labels. *"Cluster 0 has avg_spend=82, visits=27 — that's the lola group."* Always interpret.

---

## Key Takeaways

- **K-Means is unsupervised** — finds K natural groups in feature space, no labels needed.
- **Algorithm = assign + recenter, repeat.** ~30 lines of numpy.
- **Standardize first** — K-Means is scale-sensitive.
- **Elbow method** helps pick K.
- **You name the clusters** based on their centroids. The algorithm gives groups; you give meaning.

---

## What's Next?

Customers in 2D — easy to plot. But carinderia data has 8 features. You can't draw 8D. Tomorrow: PCA — compress 8 features into 2 for plotting.

**Next Lesson: Dimensionality Reduction (PCA)** — np.linalg.svd in 15 lines.
