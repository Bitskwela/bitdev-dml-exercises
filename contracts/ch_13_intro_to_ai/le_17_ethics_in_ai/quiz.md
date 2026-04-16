# Lesson 17 Quiz: Ethics in AI

---
# Quiz 1
## Scenario: Dr. Reyes' Lecture
Dan learned that AI can scale unfairness fast.

**Question 1:** AI systems inherit bias from:
A. The programmer's mood
B. The training data
C. The computer brand
D. The weather

**Answer:** B
**Explanation:** Models learn patterns from data. If the data reflects historical discrimination, the model will reproduce it — often at scale.

---

**Question 2:** Which is an example of SAMPLING bias?
A. Training only on Metro Manila loan applicants, then deploying nationwide
B. A random number generator
C. Using Python instead of R
D. Overfitting

**Answer:** A
**Explanation:** When training data doesn't represent the whole population (e.g., only NCR), the model performs badly on unrepresented groups (like Mindanao).

---

**Question 3:** What is the key test for disparate impact?
A. Does the model use more memory for some groups?
B. Do groups with the SAME qualifications receive DIFFERENT outcomes?
C. How fast does the model run?
D. How many parameters does it have?

**Answer:** B
**Explanation:** Compare applicants with the same income (or same qualification). If outcomes differ by group, there's bias beyond qualifications.

---

**Question 4:** Which is NOT one of the 5 Pillars of Responsible AI?
A. Fairness
B. Transparency
C. Profitability
D. Accountability

**Answer:** C
**Explanation:** The 5 Pillars are Fairness, Transparency, Accountability, Privacy, and Safety. Profitability is a business goal, not an ethics principle.

---

**Question 5:** If a fair model has 4% lower accuracy than a biased model, you should:
A. Always use the biased one (accuracy rules)
B. Consider the tradeoff — fairness usually wins, especially for consequential decisions
C. Throw away both
D. Use whichever is shorter to code

**Answer:** B
**Explanation:** Accuracy on biased labels isn't a true quality measure. A slightly "less accurate" fair model is often actually better — it doesn't perpetuate historical harms.

---
# Quiz 2
## Scenario: Real-World Harm
AI bias has hurt real people.

**Question 6:** Which is a real-world AI bias incident?
A. Amazon hiring AI penalizing resumes with "women's" in them
B. COMPAS criminal justice tool showing higher risk scores for Black defendants
C. Facial recognition with much higher error rates for dark-skinned women
D. All of the above

**Answer:** D
**Explanation:** All three are real, documented cases where biased training data led to discriminatory AI outcomes.

---

**Question 7:** The bias feedback loop says:
A. AI improves automatically
B. Biased data → biased model → unfair decisions → new biased data → repeat, amplifying bias
C. Bias disappears over time
D. Humans always fix bias before it spreads

**Answer:** B
**Explanation:** Unchecked, AI systems can amplify bias as their decisions feed back into future training data. Humans must actively break the cycle.

---
**Next:** Proceed to Lesson 17 exercises.
