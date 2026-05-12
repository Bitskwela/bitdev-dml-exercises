# Lesson 10 Quiz: Model Evaluation

---
# Quiz 1
## Scenario: Three Ways to Be Wrong

Ate Rina makes Dan implement MAE, MSE, RMSE, and R² by hand so he understands what each one measures.

**Question 1:** What does MAE stand for?
A. Mean Absolute Error
B. Maximum Average Error
C. Mean Algorithm Error
D. Median Absolute Error

**Answer:** A
**Explanation:** MAE = mean of |y - prediction|. Robust to outliers, in original units.

---

**Question 2:** What is RMSE in terms of MSE?
A. RMSE = MSE × 2
B. RMSE = `sqrt(MSE)` — back in original units
C. RMSE = MSE squared
D. They're unrelated

**Answer:** B
**Explanation:** Take the square root of MSE to recover original-unit interpretability.

---

**Question 3:** Which metric punishes large errors MORE than many small errors?
A. MAE (linear in error size)
B. RMSE / MSE (squared, so big errors dominate)
C. R²
D. None — all metrics treat errors equally

**Answer:** B
**Explanation:** Squaring amplifies large errors. One ₱1000 miss contributes 1M to MSE; ten ₱100 misses contribute only 10K each.

---

**Question 4:** A model achieves R² = -0.5 on test. What does that mean?
A. The model is great
B. The model is WORSE than predicting the mean
C. R² can't be negative
D. The model has 50% accuracy

**Answer:** B
**Explanation:** R² < 0 means the model is *worse than predicting the mean*. Something is broken — debug before continuing.

---

# Quiz 2
## Scenario: Reading the Gap

Dan's model has MAE = 228, RMSE = 297. Ratio ≈ 1.30.

**Question 5:** What does the MAE-to-RMSE GAP tell you?
A. Nothing useful
B. When RMSE > 1.5 × MAE, a few large errors are inflating the squared average — possible outliers
C. The model is overfit
D. The model is underfit

**Answer:** B
**Explanation:** Big RMSE/MAE ratio = outlier-driven errors. A free diagnostic.

---

**Question 6:** Which metric would you quote to Tita Malou ("how accurate is the model in plain language?")?
A. R² because it's unitless
B. MAE in pesos because she immediately understands "typically off by ₱228"
C. MSE because it's mathematically rigorous
D. None — don't bother

**Answer:** B
**Explanation:** Pick the metric that matches your audience. MAE in original units is the most readable for non-technical readers.

---

**Question 7:** Why is it best practice to ALWAYS report MULTIPLE metrics?
A. To pad the report
B. Each metric tells a different story; a single number hides outlier patterns and audience-relevant context
C. It's faster
D. Sklearn requires it

**Answer:** B
**Explanation:** MAE + RMSE + R² together give a complete picture. A single number is one perspective.

---
**Next:** Proceed to Lesson 10 exercises.
