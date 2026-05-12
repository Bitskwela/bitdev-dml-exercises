# Lesson 3 Quiz: Supervised Learning

---
# Quiz 1
## Scenario: Decomposing the Notebook

Dan and Ate Rina walk through Tita Malou's notebook columns to pick features and label for tomorrow's revenue prediction.

**Question 1:** In supervised learning, what does `X` typically represent?
A. The label vector
B. A matrix of features (one row per training example, one column per feature)
C. The prediction
D. The Python variable for "test"

**Answer:** B
**Explanation:** Capital X is a feature matrix; lowercase y is the label vector. Universal convention.

---

**Question 2:** Dan wants to predict `revenue` from the notebook. Which column would cause data leakage if included in features?
A. `weather`
B. `is_payday`
C. `quantity`
D. `day_of_week`

**Answer:** C
**Explanation:** `revenue = quantity × price`. Quantity is computed alongside revenue at the row level — including it lets the model effectively copy the answer.

---

**Question 3:** The "Golden Rule" of supervised features says:
A. Always include every column
B. Features must be knowable BEFORE the label exists
C. Features must be numeric
D. The label must come first in the CSV

**Answer:** B
**Explanation:** Tomorrow's weather forecast is allowed (you can know it the morning before). Today's actual revenue is not allowed for tomorrow's revenue prediction.

---

**Question 4:** What is the technical term for "accidentally using a feature that contains information about the label"?
A. Overfitting
B. Underfitting
C. Data leakage
D. Bias

**Answer:** C
**Explanation:** Data leakage. The model looks great during training and embarrassing in production.

---

# Quiz 2
## Scenario: Multiple Problems, Same Data

Tita Malou's 6-row notebook can serve as the input to many different supervised problems.

**Question 5:** If the LABEL is `is_busy = revenue > 1200`, which columns must be DROPPED from features?
A. Only `revenue`
B. Both `revenue` and `quantity` (because revenue is derived from quantity, and is_busy is derived from revenue)
C. Only `quantity`
D. None — they're allowed

**Answer:** B
**Explanation:** `is_busy` is computed from `revenue`. `revenue` is computed from `quantity`. Both leak the answer.

---

**Question 6:** Dan wants to predict the quantity of sinigang sold. What's the right pre-processing step?
A. Use all 977 rows with `quantity` as label
B. Filter to rows where `item == "Sinigang"`, then use `quantity` as label and drop `revenue` (leakage)
C. Drop the `item` column entirely
D. Predict for every item at once with one model

**Answer:** B
**Explanation:** Predicting quantity per item works best as item-specific subsets. Revenue still leaks (revenue ≈ quantity × price) so it must be dropped.

---

**Question 7:** What convention does the ML community use for feature/label variable names?
A. `data` and `target`
B. `X` (capital, matrix) and `y` (lowercase, vector)
C. `inputs` and `outputs`
D. `features` and `targets`

**Answer:** B
**Explanation:** Capital X for matrices, lowercase y for vectors. Older than both you and Dan.

---
**Next:** Proceed to Lesson 3 exercises.
