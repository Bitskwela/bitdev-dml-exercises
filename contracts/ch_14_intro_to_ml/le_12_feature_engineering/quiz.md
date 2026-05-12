# Lesson 12 Quiz: Feature Engineering

---
# Quiz 1
## Scenario: The Notebook Margin

Tita Malou tells Dan: *"Anak, alam ko 'yan — payday yan, rainy yan."* Dan codes the same intuitions as features.

**Question 1:** Roughly what proportion of a real ML practitioner's time goes into FEATURES vs. ALGORITHM tuning?
A. 50/50
B. 80% algorithm, 20% features
C. 80% features (cleaning, engineering, labeling), 20% modeling
D. 100% algorithms

**Answer:** C
**Explanation:** The 80/20 rule. Most gains come from data and features, not from switching algorithms.

---

**Question 2:** Why does adding `is_payday_int`, `is_rainy`, `is_friday` help linear regression even with no algorithm change?
A. It doesn't help
B. The model can now weigh each Filipino-context flag separately — patterns that were buried in raw columns become explicit
C. It speeds up training
D. It increases the dataset size

**Answer:** B
**Explanation:** Linear regression weights features. Better features = stronger signal.

---

**Question 3:** What kind of feature is `payday_rainy = is_payday × is_rainy`?
A. A one-hot
B. An INTERACTION feature — captures the multiplicative effect that linear models can't find on their own
C. A scalar
D. A bug

**Answer:** B
**Explanation:** Linear regression is additive in its features. To capture "A AND B is special, not just A + B," you build the interaction column.

---

**Question 4:** What's a "lag" feature?
A. A bug
B. A feature derived from a PAST value (e.g., yesterday's revenue) for time-series prediction
C. A slow feature
D. A categorical encoding

**Answer:** B
**Explanation:** Lag features are the foundation of time-series forecasting. They give the model history without needing a special model.

---

# Quiz 2
## Scenario: Domain Knowledge Is Gold

Tita Malou knows 15 years of carinderia patterns. Dan turns each insight into a model column.

**Question 5:** Why is domain knowledge such a powerful source of features?
A. It's not — features should come from automated tools
B. People who understand the problem know which columns matter — the model can only weigh features that exist
C. Random
D. Pure tradition

**Answer:** B
**Explanation:** A model can only learn what's in the data. Engineering the right columns is half the battle.

---

**Question 6:** A model with no `is_payday` feature cannot learn that paydays matter — EVEN IF the underlying truth is obvious. What does this teach us?
A. ML is broken
B. Features ARE the model's vocabulary. If a pattern isn't representable in features, the model can't capture it. Engineering matters.
C. Use more data
D. Use a deeper algorithm

**Answer:** B
**Explanation:** This is the fundamental insight that motivates feature engineering. The model only sees what you let it see.

---

**Question 7:** A 30% MAE reduction from feature engineering vs. 5% from switching to a fancier algorithm — which would you prioritize learning?
A. The fancier algorithm
B. Feature engineering — bigger ROI, more transferable across problems
C. Both equally
D. Neither

**Answer:** B
**Explanation:** Algorithm changes often give marginal gains. Better features routinely give double-digit MAE improvements. Engineer first; tune later.

---
**Next:** Proceed to Lesson 12 exercises.
