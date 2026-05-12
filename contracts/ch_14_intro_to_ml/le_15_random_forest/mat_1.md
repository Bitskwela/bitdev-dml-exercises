## Dan's Story: Ten Trees Beat One

Friday afternoon. Dan's single decision tree maxed out at 81% accuracy. Deeper trees overfit. He needed something different.

> **Ate Rina:** Ever heard of a random forest?
>
> **Dan:** Forest like, multiple trees?
>
> **Ate Rina:** Tama. Train 10 shallow trees, each on a slightly different random sample of the data. Each tree votes on every prediction. Majority wins.
>
> **Dan:** Why would 10 weak models beat 1 strong one?
>
> **Ate Rina:** Because each tree's errors are different. Together they cancel each other out. *Ensemble learning.* Five lines of code on top of your decision tree.

Five lines on top of Lesson 14's tree. Test accuracy: 86%. Up 5 points. Same data. Same features. *Just averaging.*

He wrote in his notebook: **Ten weak votes beat one strong opinion.**

---

## The Concept: Bagging

### Bootstrap Sampling

For each tree, draw N samples *with replacement* from the original N-row training set. About 63% of unique rows appear in each bootstrap; some appear multiple times. Each tree sees a slightly different "version of reality."

### Majority Vote

For classification, each tree votes on every test row. Take the majority. For regression, average.

### Why It Works

A single deep tree has high *variance* — small data changes shift the tree dramatically. The variance of 10 trees AVERAGED is much smaller — that's the whole gain.

### Random Subspace (the Other "Random")

At each split, consider only a random subset of features (e.g., `sqrt(p)` features). This decorrelates the trees — different trees lead with different features. Diversity is the secret sauce.

### When to Use Random Forest

- ✅ Tabular data with mixed types
- ✅ Datasets up to ~1 million rows
- ✅ Quick first-cut models — strong default
- ❌ Massive image / text data (use deep learning)

For most tabular business problems in 2026, Random Forest is still a strong default.

---

## Key Takeaways

- **Random Forest = bagging + random subspace.** Many trees on bootstrap samples with random feature subsets.
- **Each tree is weak. The forest is strong.** Variance averages out across votes.
- **Out-of-bag (OOB) score** is a free validation metric — score each row using only the trees that didn't see it.
- **10 trees beat 1 tree by ~5pp.** Beyond ~100 trees, gains plateau.

---

## What's Next?

We've done supervised classification all along. Customers in Tita Malou's records don't have type labels though. Tomorrow: **unsupervised learning** — find barkada / lola / one-off groups without labels.

**Next Lesson: K-Means Clustering** — random init + EM loop in 30 lines.
