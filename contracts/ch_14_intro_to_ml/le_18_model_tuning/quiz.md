# Lesson 18 Quiz: Model Tuning

---
# Quiz 1
## Scenario: The 100% Training Accuracy Trap

Dan picks the model with the lowest training error. Ate Rina catches him.

**Question 1:** What's the difference between a PARAMETER and a HYPERPARAMETER?
A. They're the same
B. Parameters are LEARNED from data (weights, tree splits); hyperparameters are SET before training (max_depth, learning_rate)
C. Hyperparameters are bigger
D. Random

**Answer:** B
**Explanation:** `fit()` learns parameters. You set hyperparameters before calling fit.

---

**Question 2:** Tuning hyperparameters should be done on:
A. The training set
B. A separate VALIDATION set (or via cross-validation)
C. The test set
D. The entire dataset

**Answer:** B
**Explanation:** Train fits the model. Validation tunes hyperparameters. Test gives the final score (once).

---

**Question 3:** Why do you NEVER tune hyperparameters against the test set?
A. Speed
B. Doing so leaks test information into your modeling decisions — your final test accuracy becomes optimistically biased
C. It's slow
D. Random

**Answer:** B
**Explanation:** Tuning on test = peeking at test = biased final score. Always use validation or CV.

---

**Question 4:** What is a "grid search"?
A. A search engine
B. Try every COMBINATION of multiple hyperparameter values (max_depth × min_samples_leaf × ...); pick the best on validation
C. A type of model
D. A bug

**Answer:** B
**Explanation:** Multi-dimensional sweep. Standard production pattern (`GridSearchCV` in sklearn).

---

# Quiz 2
## Scenario: Sweeping max_depth

Dan sweeps `max_depth ∈ [1..15]` and watches the curves.

**Question 5:** As `max_depth` rises, what does TRAIN accuracy do?
A. Goes down
B. Monotonically rises (more flexibility = better training fit)
C. U-shape
D. Constant

**Answer:** B
**Explanation:** More flexibility can only fit training better — never worse. Train accuracy is always monotonically improving with complexity.

---

**Question 6:** As `max_depth` rises, what does VALIDATION accuracy do?
A. Monotonically rises
B. U-shape (rises, peaks at sweet spot, then falls as overfitting kicks in)
C. Constant
D. Random

**Answer:** B
**Explanation:** Validation reflects generalization. Initially improves with complexity, then degrades as the model memorizes noise.

---

**Question 7:** What is the BIG distinction between manual sweep and `GridSearchCV`?
A. Nothing
B. GridSearchCV uses CROSS-VALIDATION (multiple folds) for each hyperparameter combo — more reliable than a single validation split. Plus it parallelizes.
C. Manual is faster
D. Grid search is wrong

**Answer:** B
**Explanation:** CV inside the sweep reduces variance in the validation estimate. Standard production tooling.

---
**Next:** Proceed to Lesson 18 exercises.
