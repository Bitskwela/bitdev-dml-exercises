# Lesson 13 Quiz: Logistic Regression

---
# Quiz 1
## Scenario: Yes or No

Tita Malou wants a yes/no answer for tomorrow's prep. Dan builds his first classifier.

**Question 1:** What does the sigmoid function do?
A. Adds two numbers
B. Squashes any real number into the range (0, 1) — interpreted as a probability
C. Subtracts
D. Multiplies

**Answer:** B
**Explanation:** Sigmoid(z) = 1/(1 + e^-z). Maps the real line to (0, 1). Output is treated as P(y=1).

---

**Question 2:** What is the gradient of binary cross-entropy in matrix form?
A. `X.T @ X`
B. `(1/n) · X.T · (sigmoid(X·w) - y)` — one numpy line
C. `np.linalg.solve(X, y)`
D. There is no closed form

**Answer:** B
**Explanation:** Beautifully simple gradient. Update weights with `w -= lr * gradient`. That's the entire training step.

---

**Question 3:** Why does logistic regression use GRADIENT DESCENT instead of the normal equation?
A. Tradition
B. There's no closed-form solution because the sigmoid breaks linearity — we iterate to find the minimum
C. It's faster
D. The math doesn't exist

**Answer:** B
**Explanation:** Sigmoid is non-linear. No closed form. Gradient descent is the standard solution.

---

**Question 4:** What does PRECISION measure?
A. Of all rows labeled "busy" by the model, what fraction were ACTUALLY busy
B. Of all actually-busy rows, what fraction the model caught
C. The overall accuracy
D. The training time

**Answer:** A
**Explanation:** Precision = TP / (TP + FP). Penalizes false positives.

---

# Quiz 2
## Scenario: Choosing the Right Threshold

Default threshold is 0.5. Tita Malou cares more about not running out of food than about over-prepping.

**Question 5:** What does RECALL measure?
A. Of all "busy" predictions, what fraction were correct
B. Of all actually-busy rows, what fraction the model caught — penalizes false negatives
C. Speed
D. Memory

**Answer:** B
**Explanation:** Recall = TP / (TP + FN). High recall = few missed positives. Important when missing a positive is costly.

---

**Question 6:** Tita Malou hates running out of food. Should she LOWER or RAISE the decision threshold from 0.5?
A. Raise to 0.7 — fewer "busy" predictions
B. Lower to 0.3 — more "busy" predictions, catches more real busy days (higher recall) at the cost of more over-preps (lower precision)
C. Keep at 0.5
D. Doesn't matter

**Answer:** B
**Explanation:** Lower threshold → more "busy" predictions → higher recall. She'd rather over-prep occasionally than run out.

---

**Question 7:** What does the WEIGHT on a feature mean in logistic regression?
A. Nothing interpretable
B. The change in log-odds of class 1 per unit increase in that feature (holding others constant)
C. The accuracy
D. The number of training rows

**Answer:** B
**Explanation:** Like linear regression, logistic regression weights are interpretable — they act on log-odds rather than directly on probability.

---
**Next:** Proceed to Lesson 13 exercises.
