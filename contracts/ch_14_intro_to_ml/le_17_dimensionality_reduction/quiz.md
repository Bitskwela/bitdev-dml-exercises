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

**Question 5:** What does that combination of loadings tell you PC1 "represents"?
A. Nothing — PCs are uninterpretable
B. PC1 acts as a "busy-payday axis" — points with high values on PC1 are payday days with high quantities, often Fridays
C. PC1 represents weather
D. PC1 represents customer ID

**Answer:** B
**Explanation:** PCs are interpretable via their loadings. Identifying the axis tells you what variation it captures.

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
