# Lesson 9 Quiz: Linear Regression

---
# Quiz 1
## Scenario: One Line of Linear Algebra

Dan implements linear regression from scratch and finds the math is simpler than he expected.

**Question 1:** What is the closed-form solution for linear-regression weights?
A. Gradient descent
B. `w = (X^T · X)^(-1) · X^T · y` — the normal equation
C. Random initialization
D. A neural network

**Answer:** B
**Explanation:** The normal equation is the closed-form solution. No iteration needed.

---

**Question 2:** Which numpy call is the entire training step?
A. `np.mean(X)`
B. `np.linalg.solve(X.T @ X, X.T @ y)`
C. `np.random.randn(...)`
D. `np.sort(X)`

**Answer:** B
**Explanation:** Solves the normal equation. Faster and more numerically stable than computing the inverse directly.

---

**Question 3:** Why do we prepend a column of 1s to X before training?
A. Padding
B. So the intercept (b) can be absorbed into the weight vector — the formula `y = X·w` then handles both slope and intercept
C. To increase dimension count
D. It's not necessary

**Answer:** B
**Explanation:** The all-1s column lets `X·w` represent both `m·x + b` in one matrix multiply.

---

**Question 4:** Linear regression cannot capture which kind of relationship without explicit feature engineering?
A. Additive effects of features
B. Multiplicative INTERACTIONS between features (e.g., "payday AND Friday is special, not just the sum of payday + Friday")
C. Monotonic trends
D. Constant effects

**Answer:** B
**Explanation:** Linear regression is additive in its features. To capture interactions you must create interaction columns (e.g., `payday × friday`). Decision trees (Lesson 14) capture interactions natively.

---

# Quiz 2
## Scenario: Reading the Weights

Dan's fitted model says: `revenue ≈ 795 + 0.65·day_of_month + 288·is_payday + 65·is_friday`.

**Question 5:** What does the weight `288` on `is_payday` mean in plain English?
A. Payday days have 288 customers
B. On payday rows, the model adds ₱288 to the predicted revenue (compared to non-payday rows with the same other features)
C. The payday flag costs ₱288
D. Nothing — coefficients are not interpretable

**Answer:** B
**Explanation:** Linear regression weights are *interpretable*. Each weight is the additive contribution of that feature, holding others constant.

---

**Question 6:** Why does the model's weight on `is_payday` end up being the largest?
A. Random
B. Because payday days really do have significantly higher revenue in the training data — the model learned what Tita Malou already knew
C. Because of feature ordering
D. Because of numerical precision

**Answer:** B
**Explanation:** The algorithm finds the weights that minimize squared error. Payday's strong effect on revenue makes its weight dominant. Tita Malou and the model agree.

---

**Question 7:** Why is `np.linalg.solve(A, b)` preferred over `np.linalg.inv(A) @ b`?
A. They give different answers
B. `solve` is more numerically stable and slightly faster — it doesn't actually compute the inverse, just the solution
C. `inv` doesn't exist
D. No reason

**Answer:** B
**Explanation:** Direct solvers avoid the numerical instability of explicit matrix inversion. Industry-standard practice.

---
**Next:** Proceed to Lesson 9 exercises.
