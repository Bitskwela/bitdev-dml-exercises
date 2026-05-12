# Lesson 16 Quiz: K-Means Clustering

---
# Quiz 1
## Scenario: Customers Tita Malou Almost Has Names For

Dan clusters 60 customers and recovers Tita Malou's intuitive types — without ever being told them.

**Question 1:** What kind of learning is K-Means?
A. Supervised regression
B. Supervised classification
C. UNSUPERVISED — no labels needed; finds structure from features alone
D. Reinforcement learning

**Answer:** C
**Explanation:** K-Means is the canonical unsupervised algorithm. No labels go in.

---

**Question 2:** The K-Means algorithm in 2 steps:
A. Train and predict
B. E-step (assign each point to nearest center) + M-step (move centers to cluster means); repeat
C. Forward pass + backward pass
D. Sort and pick

**Answer:** B
**Explanation:** Iterative EM loop. Each iteration reduces inertia.

---

**Question 3:** Why MUST you standardize features before K-Means?
A. You don't
B. K-Means uses Euclidean distance; without standardization, large-range features dominate over small-range ones
C. Pandas requires it
D. Speed

**Answer:** B
**Explanation:** Distance metrics are scale-sensitive. Subtract mean, divide by std before clustering.

---

**Question 4:** What is the ELBOW METHOD?
A. Stretching while you wait for training
B. Plot inertia vs K; find the K where adding more clusters stops reducing inertia meaningfully — that "elbow" suggests the natural K
C. A bug
D. An accuracy metric

**Answer:** B
**Explanation:** Inertia always falls with more clusters. The elbow point is where extra clusters add little — natural K.

---

# Quiz 2
## Scenario: Naming and Limitations

The algorithm returns clusters. You name them.

**Question 5:** Why do K-Means cluster IDs (0, 1, 2) MEAN NOTHING by themselves?
A. They're random
B. They're arbitrary labels — what matters is the CENTROIDS and which points fell into each cluster. You inspect those and give business names.
C. The algorithm is broken
D. They should be alphabetical

**Answer:** B
**Explanation:** "Cluster 0" in one run = "cluster 2" in another. The labels are arbitrary; interpret by inspecting the centroids.

---

**Question 6:** K-Means can converge to a LOCAL MINIMUM (not globally best). What's the standard fix?
A. Ignore the problem
B. Run K-Means multiple times with different random initializations; keep the result with the lowest inertia
C. Increase K
D. Use a different algorithm

**Answer:** B
**Explanation:** `n_init=10` runs 10 separate K-Means with different starts and picks the best. Standard practice.

---

**Question 7:** K-Means assumes clusters are roughly spherical and similar-sized. For long thin clusters or rings, it will:
A. Work perfectly
B. Struggle — distance-to-center isn't the right notion of similarity for non-spherical shapes (use DBSCAN or hierarchical clustering instead)
C. Be twice as fast
D. Crash

**Answer:** B
**Explanation:** Algorithm assumptions matter. K-Means is great for spherical blobs; other shapes need different tools.

---
**Next:** Proceed to Lesson 16 exercises.
