# Lesson 20 Quiz: Pipeline Building

---
# Quiz 1
## Scenario: Eight Scripts Become One Function

Dan's project folder is a mess. Ate Rina makes him refactor.

**Question 1:** What is the main purpose of an ML "pipeline" in code?
A. To make code longer
B. To wire clean → engineer → split → fit → evaluate into ONE function for consistency, leak prevention, and deployment
C. A type of model
D. A database concept

**Answer:** B
**Explanation:** Pipelines collapse repetitive workflow into one reproducible function. Standard production pattern.

---

**Question 2:** Without a pipeline, what's a common LEAKAGE mistake?
A. Forgetting to save the model
B. `StandardScaler().fit_transform(X)` on ALL data BEFORE splitting — leaks test info into the scaler
C. Using too many features
D. Random initialization

**Answer:** B
**Explanation:** Preprocessing must be fit on train ONLY. Pipelines enforce this automatically.

---

**Question 3:** How do pipelines prevent leakage?
A. They're stricter
B. Each preprocessing step is FIT on train only; the same step then TRANSFORMS both train and test (using train-fit params)
C. They check your code
D. They add randomness

**Answer:** B
**Explanation:** Fit on train, transform both. The pipeline structure makes this the natural pattern.

---

**Question 4:** What's the apples-to-apples benefit of a pipeline?
A. Speed
B. Same data + same engineering + same split — swap only the model, and you get directly comparable scores
C. Lower memory
D. Compactness

**Answer:** B
**Explanation:** Without a pipeline, models compete with different preprocessing. With a pipeline, only the model varies.

---

# Quiz 2
## Scenario: Deployment as a Pipeline

After fitting, Dan wants to deploy. A pipeline makes that one artifact.

**Question 5:** Why do production ML teams save the entire pipeline (preprocessing + model) as one object?
A. Aesthetics
B. So when a new row comes in at predict time, the SAME preprocessing applies — no risk of training/serving skew
C. To save memory
D. Random

**Answer:** B
**Explanation:** Training/serving skew (preprocessing differs between train and inference) is a common production bug. One-artifact deployment prevents it.

---

**Question 6:** A pipeline function has signature `def run(df, model_factory, cv=5)`. Why `model_factory` (a callable) and not `model` (an instance)?
A. Cosmetic
B. So each CV fold creates a FRESH model — without sharing parameters across folds (which would be leakage)
C. Faster
D. Random

**Answer:** B
**Explanation:** Each fold needs independent training. Passing a factory ensures freshness.

---

**Question 7:** What's the typical SIZE of a well-written `def run(df, model)` pipeline function?
A. 500+ lines
B. ~40-60 lines for a complete workflow (clean + engineer + CV + return)
C. 1 line
D. 5,000 lines

**Answer:** B
**Explanation:** Tight, focused. The whole pipeline reads top-to-bottom. Most of the lines are helpers.

---
**Next:** Proceed to Lesson 20 exercises.
