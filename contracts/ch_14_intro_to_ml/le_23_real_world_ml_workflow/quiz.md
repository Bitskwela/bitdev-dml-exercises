# Lesson 23 Quiz: Real-world ML Workflow

---
# Quiz 1
## Scenario: The Capstone Notebook

Dan collapses 22 lessons into one auditable script.

**Question 1:** How many sections does a typical end-to-end ML script have?
A. 1
B. 100
C. ~9-11: imports, constants, load, clean, engineer, split, CV, select, fit, test, serialize
D. As many as possible

**Answer:** C
**Explanation:** Standard production workflow has ~9-11 distinct sections in a specific order.

---

**Question 2:** What should the test set be used for?
A. Tuning hyperparameters
B. ONE final evaluation at the very end, after model selection and tuning are complete
C. Training
D. Cross-validation

**Answer:** B
**Explanation:** Touch test ONCE. Tuning and selection happen on train+val with CV.

---

**Question 3:** Why is EVERY section's output printed in the script?
A. To make it longer
B. Output IS the audit trail — a reviewer can read top to bottom and verify each step ran correctly
C. Required by Python
D. Random

**Answer:** B
**Explanation:** A reviewable script has visible output at every step. No "did that work?" silently.

---

**Question 4:** A teammate's pipeline spans 4 notebooks: `01_load.ipynb`, `02_engineer.ipynb`, `03_cv.ipynb`, `04_fit.ipynb`. On a deadline they re-run only `03_cv.ipynb` and `04_fit.ipynb`. What could go wrong, and how would a single-file script prevent it?
A. Nothing — each notebook is independent so partial re-runs are always safe
B. `03_cv.ipynb` ran using stale `X_train` left in memory from the previous full run of `02_engineer.ipynb` — possibly with old features or stale data. CV score reflects old data; the model fits on current data. A single script always runs every step in order, guaranteeing consistent inputs throughout.
C. The CV accuracy would improve because cached data is already preprocessed
D. Only a problem if the CSV source file changed between runs

**Answer:** B
**Explanation:** Notebooks store kernel state. Re-running `03_cv.ipynb` reuses whatever `X_train` happened to exist in memory — which could be from a different data version or feature set. You end up with a CV score that doesn't match what the final model was trained on. `python workflow.py` has no persistent state: every run is end-to-end, every step uses the same inputs, every output is trustworthy.

---

# Quiz 2
## Scenario: The Forecast at the Bottom

The final section of the script prints a forecast — for Tita Malou, not for the engineer.

**Question 5:** What's the difference between CV scores (top of script) and the forecast (bottom)?
A. They're the same
B. CV scores are for the engineer's confidence; the forecast is the BUSINESS deliverable (what the model says about tomorrow) — stakeholders read this
C. CV is wrong
D. Forecast is wrong

**Answer:** B
**Explanation:** Different audiences. CV is for engineers; forecast is for Tita Malou and her menu decisions.

---

**Question 6:** Why is `random_state` (or fixed seed) set as a CONSTANT at the top?
A. Tradition
B. Reproducibility — running the script twice gives the same output, makes review possible
C. It's slower without
D. Mandatory

**Answer:** B
**Explanation:** Fixed seed = reproducible run = trustworthy results.

---

**Question 7:** In the capstone workflow, where does the test set get touched?
A. Multiple times throughout
B. ONCE at the end, after model selection via CV
C. In every fold
D. Never

**Answer:** B
**Explanation:** The Three Rules of Test Data. Touch test exactly once.

---
**Next:** Proceed to Lesson 23 exercises.
