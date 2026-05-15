# Lesson 19 Quiz: Cross Validation

---
# Quiz 1
## Scenario: The Lucky Split

Dan brags about 88% accuracy. Ate Rina makes him run 5 different splits.

**Question 1:** Why is "88% on one train/test split" misleading?
A. It's not — it's perfectly fine
B. A different random split could have given 83% or 86%; one number is one sample without context
C. 88% is always lying
D. Random

**Answer:** B
**Explanation:** Single splits have noise. Different seeds = different numbers. CV averages that out.

---

**Question 2:** What is K-fold cross validation?
A. Running the model K times in production
B. Shuffle, divide into K folds, train on K-1 folds + test on 1, repeat K times, average the scores
C. Random sampling
D. A bug

**Answer:** B
**Explanation:** Each row appears in test exactly once. You get K scores, not one. Mean and std together.

---

**Question 3:** What's the industry-default value of K?
A. 1
B. 2
C. 5 (or sometimes 10)
D. The number of rows

**Answer:** C
**Explanation:** K=5 is the workhorse. Reasonable variance reduction at 5× compute.

---

**Question 4:** STRATIFIED K-fold differs from regular K-fold how?
A. It's slower
B. It preserves the class ratio in every fold — essential for imbalanced classification problems
C. It uses more memory
D. No difference

**Answer:** B
**Explanation:** Stratified splits each class separately so both halves of every fold have the right ratio.

---

# Quiz 2
## Scenario: Reporting Honestly

After CV: mean=0.856, std=0.020.

**Question 5:** What's the approximate 95% confidence interval for the model's real-world accuracy?
A. [0.856, 0.856] — point estimate
B. mean ± 2·std ≈ [0.816, 0.896]
C. The training accuracy
D. 0.5

**Answer:** B
**Explanation:** Rough normal-distribution rule. Real performance is likely between 0.82 and 0.90.

---

**Question 6:** Model A's 5 CV fold scores: [0.85, 0.87, 0.84, 0.88, 0.86]. Model B's: [0.89, 0.82, 0.88, 0.85, 0.91]. Estimate mean and std for each. Which would you ship and why?
A. Model B — it has a higher peak score (0.91) and a higher mean
B. Model A — mean ≈ 0.860, std ≈ 0.015; vs Model B mean ≈ 0.870, std ≈ 0.033. The 0.01 mean gap is within noise; Model A's lower std makes its production performance predictable
C. Model B — higher mean always wins regardless of std
D. Either — the means are close enough to be interchangeable without checking std

**Answer:** B
**Explanation:** Model A: mean ≈ 0.860, std ≈ 0.015 (range ~0.845–0.875). Model B: mean ≈ 0.870, std ≈ 0.033 (range ~0.837–0.903). Model B's 0.01 higher mean is dwarfed by its 2× larger std. You can reliably predict Model A will score around 0.86; Model B might give you 0.82 or 0.91 on the next unseen dataset. For a production carinderia tool, consistency beats a lucky 0.91.

---

**Question 7:** Does CV replace the held-out test set?
A. Yes, no test set needed
B. NO — CV is for model selection and tuning; you STILL evaluate ONCE on a held-out test for the final report
C. Sometimes
D. Test sets are obsolete

**Answer:** B
**Explanation:** CV gives mean ± std during model selection. The final test set is touched once, after picking the model, for the reported score.

---
**Next:** Proceed to Lesson 19 exercises.
