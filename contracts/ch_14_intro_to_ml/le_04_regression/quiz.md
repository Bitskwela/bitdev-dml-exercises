# Lesson 4 Quiz: Regression

---
# Quiz 1
## Scenario: The Marikina Jeepney

Dan rides a jeepney home and notices regression running silently in every signboard he passes.

**Question 1:** Which of these is a regression problem (not classification)?
A. "Is this email spam?"
B. "Predict how many bowls of sinigang will sell tomorrow."
C. "Which menu item will be most popular?"
D. "Is the customer a barkada or a lola?"

**Answer:** B
**Explanation:** Quantity of bowls is a number. Regression. The others are classification.

---

**Question 2:** What is a "baseline" in ML?
A. The final, deployed model
B. A simple prediction (mean / median / moving average) your real model must beat
C. The training data
D. The test set

**Answer:** B
**Explanation:** A floor for your real model. If your fancy model can't beat the baseline, the fancy model is useless.

---

**Question 3:** Which baseline is usually the best of the three for time-series data with a trend?
A. Mean baseline
B. Median baseline
C. Moving-average baseline (e.g., average of last 7 days)
D. Always-predict-zero baseline

**Answer:** C
**Explanation:** Moving average tracks recent shifts the mean can't.

---

**Question 4:** What does MAE stand for, and what are its units?
A. Mean Absolute Error — same units as the label (e.g., pesos)
B. Maximum Average Error — squared units
C. Mathematical Algorithm Estimation — unitless
D. Median Absolute Estimation — squared units

**Answer:** A
**Explanation:** MAE = average of `|predicted - actual|`. Same units as the label. Most readable for non-technical audiences.

---

# Quiz 2
## Scenario: Beating the Floor

Dan's moving-average baseline gets MAE 4.36 on the held-out test. He wants to know if a smarter approach can beat it.

**Question 5:** Why does a "rainy payday Friday" lookup beat the moving-average baseline by 1-2 bowls?
A. Because Tita Malou typed faster
B. Because context (payday + rainy + Friday) carries more signal than a blind moving average
C. Because of randomness
D. Because moving averages are always wrong

**Answer:** B
**Explanation:** Context-aware predictions beat blind averages. This is the core insight that motivates feature engineering in Lesson 12.

---

**Question 6:** What's the relationship between MSE and RMSE?
A. RMSE = MSE
B. RMSE = MSE / 2
C. RMSE = `sqrt(MSE)` — back in original units
D. RMSE = MSE squared

**Answer:** C
**Explanation:** Take the square root of MSE to get back to readable original units (e.g., pesos).

---

**Question 7:** When backtesting a baseline, why is it important to compute the baseline value from TRAIN data only?
A. It's not — both sets are fine
B. So the baseline doesn't "cheat" by averaging over rows it's about to be tested on (data leakage)
C. To save memory
D. Because test data is smaller

**Answer:** B
**Explanation:** Including test rows in the baseline's mean would give it information it wouldn't have at prediction time. Even baselines must follow the no-leakage rule.

---
**Next:** Proceed to Lesson 4 exercises.
