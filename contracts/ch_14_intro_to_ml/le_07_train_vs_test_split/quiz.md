# Lesson 7 Quiz: Train vs Test Split

---
# Quiz 1
## Scenario: The 99% Trap

Dan brags about 99% accuracy. Ate Rina asks one question that exposes the trap.

**Question 1:** Why is training on all your data and testing on the same data a bad idea?
A. It's not — it's the most accurate evaluation
B. The model already saw every answer during training, so test accuracy is meaningless
C. It uses too much memory
D. It's slow

**Answer:** B
**Explanation:** A model evaluated on its training data is guaranteed to look good. The number reflects memorization, not generalization.

---

**Question 2:** What is the standard train/test split ratio?
A. 50/50
B. 60/40
C. 80/20 (or sometimes 70/30, 75/25)
D. 99/1

**Answer:** C
**Explanation:** 80% train, 20% test is the industry default — enough training signal, enough test rows for honest evaluation.

---

**Question 3:** Why do we set `random_state=42` (or any fixed seed) when splitting?
A. Tradition
B. So the split is reproducible — re-running the code gives the same split every time
C. It speeds up training
D. It makes the model more accurate

**Answer:** B
**Explanation:** Reproducibility is a core ML discipline. Comparable results require identical splits.

---

**Question 4:** Which of these is NOT one of the Three Rules of Test Data?
A. Never train on test rows
B. Never tune hyperparameters against test
C. Never peek at test labels before final evaluation
D. Always shuffle test rows before predicting

**Answer:** D
**Explanation:** Shuffling test rows doesn't help or hurt. The three real rules are: don't train on it, don't tune on it, don't peek at it.

---

# Quiz 2
## Scenario: Stratified Splits

Dan's busy/not_busy data is imbalanced — only 31% of days are busy. He wants the test set to look like the full data.

**Question 5:** What does a STRATIFIED split do that a random split doesn't?
A. Nothing useful
B. Preserves the class ratio in both train and test — important for imbalanced data
C. Sorts the data
D. Splits chronologically

**Answer:** B
**Explanation:** Stratified split = split each class separately so both halves have the same class ratio as the full dataset.

---

**Question 6:** Why should you NEVER tune hyperparameters against the held-out test set?
A. It's slow
B. Doing so leaks test information into your modeling decisions — your final test score becomes optimistically biased
C. The test set is too small
D. It causes memory errors

**Answer:** B
**Explanation:** Tuning on test = peeking at test = biased final estimate. Use a validation set or cross-validation (Lesson 19) instead.

---

**Question 7:** A single train/test split gives a single accuracy number. Is that a reliable estimate of real-world performance?
A. Yes — one number is enough
B. No — a different random split could give a meaningfully different number; you need multiple splits (cross-validation) for a reliable estimate
C. It depends on the model
D. Only for classification

**Answer:** B
**Explanation:** One number is one sample. Different splits give different numbers. Cross-validation (Lesson 19) averages over multiple splits for a reliable estimate.

---
**Next:** Proceed to Lesson 7 exercises.
