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

**Question 4:** Why do "deliverable" scripts prefer ONE file vs. multiple notebooks?
A. Notebooks are slow
B. One auditable script can be read top to bottom; multiple notebooks risk silent drift between cells across runs
C. Notebooks are obsolete
D. Random

**Answer:** B
**Explanation:** For deliverables and production, one auditable script wins. Notebooks are great for exploration but harder to review.

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
