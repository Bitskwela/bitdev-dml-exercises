# Lesson 17 Quiz: Dimensionality Reduction (PCA)

---
# Quiz 1
## Scenario: Eight Dimensions on a Napkin

Dan engineers 8 features and wants to plot them. PCA compresses to 2.

**Question 1:** What does PCA stand for?
A. Python Classification Algorithm
B. Principal Component Analysis
C. Predictive Class Aggregator
D. Probabilistic Cluster Analysis

**Answer:** B
**Explanation:** Principal Component Analysis. Find directions of maximum variance; project onto them.

---

**Question 2:** Which numpy function does the heavy lifting in PCA?
A. `np.mean`
B. `np.linalg.solve`
C. `np.linalg.svd` (Singular Value Decomposition)
D. `np.linalg.det`

**Answer:** C
**Explanation:** SVD decomposes the centered matrix; the rows of Vt are the principal components.

---

**Question 3:** Before running SVD for PCA, you must:
A. Train a classifier
B. Mean-center the data (and ideally standardize each feature)
C. Convert to integers
D. Sort the rows

**Answer:** B
**Explanation:** Mean-center is required (or you get a "first component points at the mean" artifact). Standardize for scale-sensitive PCA.

---

**Question 4:** What does the "explained variance ratio" of PC1 tell you?
A. The accuracy of the model
B. What fraction of total data variance PC1 captures — e.g., 0.42 means 42% of total spread is along PC1
C. The number of rows
D. The number of features

**Answer:** B
**Explanation:** Each PC captures some fraction of variance. Together, the first few usually cover most of the structure.

---

# Quiz 2
## Scenario: Reading the Components

PC1's largest-magnitude loadings are `is_payday`, `quantity`, `is_friday`.

**Question 5:** PC1 explains 85% of variance; PC2 explains 5%. Your tech lead says "drop PC2 to save compute." Give one reason to keep it and one reason to drop it. What would you do?
A. Always drop it — 5% is negligible regardless of what it contains
B. Reason to keep: PC2 may contain the exact signal that separates your target classes, even if it has low overall variance. Reason to drop: if PC2 is unrelated to labels, it adds noise. Run a classifier with vs without PC2 and compare CV accuracy to decide.
C. Always keep it — every PC contains important information by definition
D. The decision depends only on training time, not model performance

**Answer:** B
**Explanation:** Variance explained measures how much spread a PC captures across ALL data, not whether it correlates with your labels. A PC with 5% variance could perfectly separate classes if that 5% is where your signal lives. A PC with 50% variance could be pure noise for classification. Check empirically: CV accuracy with vs without PC2. The number decides — not the variance ratio alone.

---

**Question 6:** Why would you keep only 2 PCs out of 8 original features?
A. To save memory
B. For VISUALIZATION (you can't plot 8D) AND to remove redundant or noisy dimensions while keeping most variance
C. Random preference
D. To increase accuracy

**Answer:** B
**Explanation:** Reduce to 2D for plotting; keep the variance that matters; drop noisy dimensions.

---

**Question 7:** PCA finds LINEAR projections. For wildly non-linear structure (rings, spirals, manifolds), use:
A. More PCs
B. t-SNE or UMAP (non-linear dimensionality reduction)
C. Random Forest
D. Linear Regression

**Answer:** B
**Explanation:** PCA can only find linear axes. Non-linear data needs non-linear methods like t-SNE.

---
**Next:** Proceed to Lesson 17 exercises.
