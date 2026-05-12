# Lesson 2 Quiz: Types of ML

---
# Quiz 1
## Scenario: The Paper Napkin

Dan and Ate Rina are sorting 8 carinderia problems on a paper napkin. Help him classify each one correctly.

**Question 1:** "Predict tomorrow's total revenue in pesos." Which ML type?
A. Supervised classification
B. Supervised regression
C. Unsupervised
D. Reinforcement

**Answer:** B
**Explanation:** Predicting a NUMBER (pesos) with past labeled data → supervised regression.

---

**Question 2:** "Group customers into similar buying patterns — no labels exist yet." Which ML type?
A. Supervised classification
B. Supervised regression
C. Unsupervised
D. Reinforcement

**Answer:** C
**Explanation:** No labels + find structure = unsupervised clustering.

---

**Question 3:** "Classify each day as busy, normal, or slow." Which ML type?
A. Supervised regression
B. Supervised classification
C. Unsupervised
D. Reinforcement

**Answer:** B
**Explanation:** Predicting a CATEGORY (busy/normal/slow) with labeled training rows → supervised classification.

---

**Question 4:** "Make Luto adjust its jokes based on Tita Malou's reactions over a week." Which ML type?
A. Supervised regression
B. Supervised classification
C. Unsupervised
D. Reinforcement

**Answer:** D
**Explanation:** No static dataset; agent acts, receives feedback, adjusts → reinforcement learning.

---

# Quiz 2
## Scenario: Naming the Sub-Types

Supervised learning has two sub-flavors. Make sure Dan can tell them apart.

**Question 5:** Which of these is REGRESSION (not classification)?
A. "Is this email spam or not?"
B. "What is the expected delivery time in minutes for this order?"
C. "Which of the 5 menu items will this customer buy?"
D. "Is this day a holiday?"

**Answer:** B
**Explanation:** A continuous number (minutes) → regression. The other three predict categories.

---

**Question 6:** Which of these is CLASSIFICATION (not regression)?
A. "Predict tomorrow's revenue in pesos."
B. "Forecast next month's flour expense."
C. "Will this customer come back next week — yes or no?"
D. "What temperature will Manila reach tomorrow?"

**Answer:** C
**Explanation:** Yes/no is a 2-class categorical label → binary classification. The other three predict numbers.

---

**Question 7:** Why is *"recommend tomorrow's ulam"* an ambiguous problem statement?
A. It's never useful
B. It could be supervised (predict the top revenue-generating ulam — regression on revenue per item) OR unsupervised (cluster similar past days and pick that cluster's top ulam) — the answer depends on what data you have
C. It's always classification
D. It's always reinforcement

**Answer:** B
**Explanation:** Real-world ML problems often fit multiple types. Picking the right framing is part of the engineer's job — and depends on what data is available.

---
**Next:** Proceed to Lesson 2 exercises.
