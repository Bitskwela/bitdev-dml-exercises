# Lesson 11 Quiz: Overfitting vs Underfitting

---
# Quiz 1
## Scenario: The Three Polynomials

Dan fits polynomial degrees 1, 3, and 9 to the same 12 data points.

**Question 1:** A model with TRAIN MAE = 18 and TEST MAE = 614. What's wrong?
A. The model is underfit
B. The model is overfit — it memorized training points
C. The data is noise
D. Nothing — those numbers look fine

**Answer:** B
**Explanation:** Tiny train error + huge test error = classic overfitting. The model can't generalize.

---

**Question 2:** What is the technical name for "model too simple to capture the pattern"?
A. Overfitting
B. Underfitting
C. Just-right fitting
D. Random fitting

**Answer:** B
**Explanation:** Underfitting (high bias). Both train and test errors are high and similar.

---

**Question 3:** As polynomial degree increases, what happens to TRAIN MAE?
A. Goes up
B. Goes down monotonically (more flexibility = better training fit)
C. Stays the same
D. Random

**Answer:** B
**Explanation:** More flexibility can only fit training data tighter — never worse.

---

**Question 4:** As polynomial degree increases, what happens to TEST MAE?
A. Goes down monotonically
B. U-shape: decreases, bottoms out at the sweet spot, then increases as overfitting kicks in
C. Stays the same
D. Always increases

**Answer:** B
**Explanation:** Classic bias-variance see-saw. The trough of the U is your target complexity.

---

# Quiz 2
## Scenario: Diagnosing a Model

Dan reads a model report: TRAIN MAE = 240, TEST MAE = 250 (gap = 10). Another report: TRAIN MAE = 50, TEST MAE = 280 (gap = 230).

**Question 5:** Which report shows healthier fitting?
A. First (small gap)
B. Second (low train MAE)
C. Both are equivalent
D. Neither

**Answer:** A
**Explanation:** A small gap means the model generalizes well. The second model overfit — low train error, big gap.

---

**Question 6:** What does "more data tolerates more complexity" mean?
A. Always train on as much data as possible
B. With small datasets, overfitting kicks in at low complexity. With big datasets, you can use more complex models without overfitting as easily
C. Data quantity doesn't matter
D. Big data needs deep learning

**Answer:** B
**Explanation:** Sample size buys you complexity room. 100 rows + degree-3 polynomial = OK. 30 rows + degree-9 = overfit.

---

**Question 7:** What is regularization (e.g., Ridge)?
A. A way to make training faster
B. Adding a penalty on weight magnitude to constrain models from chasing noise — common production fix for overfitting
C. A type of decision tree
D. A library

**Answer:** B
**Explanation:** Regularization penalizes large weights. Keeps complex models from memorizing. Production-standard technique.

---
**Next:** Proceed to Lesson 11 exercises.
