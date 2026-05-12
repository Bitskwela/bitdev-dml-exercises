# Lesson 8 Quiz: Python for ML

---
# Quiz 1
## Scenario: The Sandbox Stack

Dan smoke-tests the bitdev sandbox to make sure his ML stack works end-to-end.

**Question 1:** Which libraries are AVAILABLE in the bitdev sandbox for ch_14?
A. numpy, pandas, sklearn, tensorflow
B. numpy, pandas, plus stdlib (csv, io, pickle, math, random)
C. Only pandas
D. Only numpy

**Answer:** B
**Explanation:** Sandbox ships numpy + pandas + Python stdlib. No sklearn, no DL frameworks. We build algorithms from scratch.

---

**Question 2:** Why is sklearn NOT in the sandbox?
A. It's banned
B. The Pyodide environment doesn't ship it, so we implement every algorithm from numpy — which is the pedagogical point anyway
C. It's deprecated
D. Random choice

**Answer:** B
**Explanation:** Pyodide constraints. Bonus: implementing from scratch teaches the math, not just the API.

---

**Question 3:** What does `pd.get_dummies(df["day_of_week"], prefix="day")` produce?
A. A single integer-encoded column
B. N new 0/1 columns (one per unique value)
C. The same column unchanged
D. An error

**Answer:** B
**Explanation:** One-hot encoding: one column with N values → N new boolean columns. The model can learn a separate weight per category.

---

**Question 4:** What is a DUMMY baseline?
A. A model that's broken
B. A model that always predicts the majority class — useful as the floor your real model must beat
C. A neural network
D. The dataset

**Answer:** B
**Explanation:** "Always predict majority" is the simplest possible baseline. If your real model doesn't beat it, the real model adds nothing.

---

# Quiz 2
## Scenario: Class Imbalance and Baselines

Tita Malou's data has 31% busy days and 69% not-busy days. Dan trains a dummy that always predicts "not-busy."

**Question 5:** What accuracy would the always-predict-"not-busy" dummy achieve?
A. ~50%
B. ~31%
C. ~69%
D. 100%

**Answer:** C
**Explanation:** It correctly labels all the non-busy days (69% of rows). It misses all busy days, but they're only 31%.

---

**Question 6:** Why is reaching only 70% accuracy with a real model NOT impressive on this dataset?
A. It is impressive
B. The dummy hits 69% by predicting majority — a 1pp gain isn't meaningfully better
C. 70% is a perfect score
D. Accuracy is irrelevant

**Answer:** B
**Explanation:** Real models must beat the dummy by a meaningful margin. Otherwise, you've added complexity without value.

---

**Question 7:** Which stdlib function lets you serialize a Python object (including trained models) to bytes for storage or transfer?
A. `print()`
B. `pickle.dumps()`
C. `json.dumps()` (limited — can't handle arbitrary Python objects)
D. `str()`

**Answer:** B
**Explanation:** `pickle.dumps` serializes any Python object to bytes. We use it (instead of `joblib.dump` which writes to disk) in Lesson 22 for sandbox-safe model deployment.

---
**Next:** Proceed to Lesson 8 exercises.
