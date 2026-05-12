# Lesson 14 Quiz: Decision Trees

---
# Quiz 1
## Scenario: The Jeepney Flowchart

Dan realizes Tita Malou's gut isn't a sum — it's a flowchart. Decision trees encode flowcharts directly.

**Question 1:** A decision tree's structure is closest to what?
A. A neural network
B. A flowchart of yes/no questions ending in leaf predictions
C. A linear equation
D. A random forest

**Answer:** B
**Explanation:** Internal nodes ask feature/threshold questions; leaves predict the class. Walk root-to-leaf for any new row.

---

**Question 2:** What does GINI IMPURITY measure?
A. The dataset size
B. How "mixed" the classes are in a node — 0 means pure, 0.5 means 50/50 for binary
C. The depth of the tree
D. The accuracy

**Answer:** B
**Explanation:** Gini = 1 - (p1² + p2² + ...). Used to score candidate splits — we minimize the weighted child Gini.

---

**Question 3:** Without depth limits, what tends to happen to a decision tree's training error?
A. It stays high
B. It approaches zero — the tree memorizes every training row (overfitting)
C. It oscillates
D. It increases with depth

**Answer:** B
**Explanation:** Unrestricted trees can fit any training data perfectly. That's why `max_depth` matters.

---

**Question 4:** Why do decision trees find FEATURE INTERACTIONS automatically without explicit interaction columns?
A. They don't
B. After splitting on feature A, the left and right branches can each split on B differently — this captures A × B
C. They use neural networks internally
D. Magic

**Answer:** B
**Explanation:** Hierarchical structure naturally encodes interactions. Linear models can't — they need explicit `A × B` columns.

---

# Quiz 2
## Scenario: Reading the Tree

The tree's root split is `is_payday`. Tita Malou nods because she'd do the same.

**Question 5:** The algorithm chose `is_payday` as the root split because:
A. It was alphabetically first
B. It produces the lowest weighted Gini among all candidate splits — it's the most informative feature
C. Random choice
D. The user told it to

**Answer:** B
**Explanation:** The algorithm tries every feature/threshold and picks the one that minimizes weighted child Gini. Payday's strong signal makes it win.

---

**Question 6:** What is the MOST IMPORTANT hyperparameter to set on a decision tree?
A. The number of features
B. `max_depth` — controls overfitting; shallow = simple + interpretable
C. The dataset size
D. The seed

**Answer:** B
**Explanation:** `max_depth` is THE knob. Unset = overfits. Too low = underfits. Tune on validation (Lesson 18).

---

**Question 7:** What is one BIG advantage of decision trees over linear models for non-technical audiences?
A. Faster training
B. The fitted tree can be PRINTED as plain-English if-else rules — Tita Malou can read it
C. Higher accuracy always
D. They never overfit

**Answer:** B
**Explanation:** Interpretability is decision trees' superpower for business problems.

---
**Next:** Proceed to Lesson 14 exercises.
