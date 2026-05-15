# Lesson 15 Quiz: Random Forest

---
# Quiz 1
## Scenario: Ten Trees, One Vote

Dan's single decision tree plateaus at 81%. The forest hits 86% — same data, just averaging.

**Question 1:** A Random Forest is composed of:
A. One very deep decision tree
B. Many shallow decision trees that VOTE on each prediction
C. A neural network
D. Linear regressions

**Answer:** B
**Explanation:** Many shallow trees, each trained on a bootstrap sample, majority-vote per prediction.

---

**Question 2:** What does BOOTSTRAP SAMPLING mean?
A. Sampling without replacement
B. Drawing N samples WITH replacement from N training rows — each tree sees a slightly different subset
C. Sampling from the test set
D. Random sampling for the entire forest

**Answer:** B
**Explanation:** With replacement. About 63% of unique rows appear in each tree's training data on average.

---

**Question 3:** What does RANDOM SUBSPACE mean in Random Forest?
A. The training data is random
B. At each split, the tree considers only a RANDOM SUBSET of features (e.g., sqrt(p) features) — this decorrelates trees
C. The model is random
D. Random predictions

**Answer:** B
**Explanation:** Decorrelating trees by limiting their feature view is the "random" in Random Forest.

---

**Question 4:** Model A (single tree, depth=10): CV accuracy 0.87 ± 0.12. Model B (forest of 10 trees, depth=4): CV accuracy 0.86 ± 0.03. Same dataset. Which would you deploy and why?
A. Model A — higher mean accuracy always wins
B. Model B — a std of 0.03 means consistent ~0.86; Model A's 0.12 std means real-world accuracy could be anywhere from 0.75 to 0.99
C. Model A — deeper trees generalize better
D. Neither — the means are too close to matter

**Answer:** B
**Explanation:** Mean alone doesn't tell the story. Model A's 0.12 std means its performance is unreliable — a lucky split could explain the 0.87. Model B's 0.03 std means you can count on consistent ~0.86. Forests trade peak accuracy for stability; that stability is what you deploy.

---

# Quiz 2
## Scenario: When and Why to Use Forests

Dan reaches for a Random Forest as his default.

**Question 5:** What is OOB (Out-of-Bag) score?
A. A bug
B. For each row, predict using only trees that didn't see it during training — gives a free validation estimate without a separate test set
C. The model's accuracy on the bootstrap
D. The test set

**Answer:** B
**Explanation:** ~37% of trees don't see any given row. Use them to score that row. Free, no-cost validation metric.

---

**Question 6:** Adding more trees to a Random Forest:
A. Hurts test accuracy
B. Helps a lot up to ~100 trees, then plateaus — more trees beyond that buy stability, not accuracy
C. Has no effect
D. Always helps

**Answer:** B
**Explanation:** Diminishing returns after ~100 trees. Beyond that, you're paying compute for marginal stability.

---

**Question 7:** Random Forest is BEST suited for which kind of data?
A. Images
B. Long text documents
C. Tabular structured data with mixed feature types — its natural habitat
D. Audio

**Answer:** C
**Explanation:** Forests dominate tabular ML in 2026. For images, text, audio, deep learning wins.

---
**Next:** Proceed to Lesson 15 exercises.
