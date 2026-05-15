# Lesson 24 Quiz: ML vs AI vs DL

---
# Quiz 1
## Scenario: The Napkin Venn Diagram

Dan explains the nested circles to Tita Malou.

**Question 1:** Which is the relationship between AI, ML, DL?
A. They're synonyms
B. AI > ML > DL (nested circles — DL is inside ML is inside AI)
C. They're unrelated
D. ML > AI > DL

**Answer:** B
**Explanation:** AI is the broadest; ML is the subset that learns from data; DL is the subset that uses deep neural networks.

---

**Question 2:** Luto v1 (rules) is an example of what?
A. ML
B. AI (rule-based system) — not ML, because no learning is happening
C. DL
D. None

**Answer:** B
**Explanation:** All ML is AI, but not all AI is ML. Rule-based systems are AI without learning.

---

**Question 3:** Luto v2 (Random Forest on carinderia data) is an example of what?
A. ML (specifically supervised learning on tabular data)
B. DL
C. Pure AI (rules)
D. Random number generation

**Answer:** A
**Explanation:** ML uses Random Forest, KMeans, etc. — algorithms that learn from data. Not deep learning.

---

**Question 4:** A hypothetical Luto v3 that classifies leftover-dish PHOTOS would be:
A. AI only
B. ML only
C. ALL THREE: it's AI, it's ML, and it's DL (image recognition typically needs CNNs)
D. None of the above

**Answer:** C
**Explanation:** Nested circles. Image recognition = DL → which is ML → which is AI.

---

# Quiz 2
## Scenario: Picking the Right Tool

Different data shapes need different algorithms.

**Question 5:** Your Random Forest hits 100% accuracy on a 30-row carinderia test set. Your manager says "perfect — now let's try a neural net to push it even higher." What would you tell them, and which metric should you actually focus on?
A. Agree — neural nets are always worth trying for any potential improvement
B. Disagree — 100% on 30 rows signals overfitting risk, not a lower bound to beat. The metric that matters is CV mean ± std. On 30 rows, a neural net adds far more parameters than data, guaranteeing worse generalization.
C. Agree — more model capacity always helps when the current accuracy is already high
D. Disagree — neural nets cannot run on tabular data at any scale

**Answer:** B
**Explanation:** 100% test accuracy on a 6-row test set (80/20 split of 30) is suspicious — a model can hit 100% by chance. The metric that tells you whether performance is real is CV mean ± std across multiple folds. Adding a neural net to 30 rows gives the model 10–100× more parameters than data points: it will fit training perfectly and generalize worse. Tabular + small = classical ML wins every time.

---

**Question 6:** Where does DL UNAMBIGUOUSLY beat ML?
A. Tabular data with 100 rows
B. Image recognition, speech, large-scale language — wherever the data is unstructured and abundant
C. Database queries
D. Everywhere

**Answer:** B
**Explanation:** DL's strength is unstructured data at scale. Images, audio, text. Tabular is ML's home turf.

---

**Question 7:** "Most production ML in 2026 is NOT deep learning." Is that true or false?
A. False — DL is everything
B. TRUE — Tabular ML (Random Forest, XGBoost, logistic regression) dominates day-to-day business problems
C. Half true
D. Cannot tell

**Answer:** B
**Explanation:** Headlines are about DL; production is mostly classical ML. Both matter; pick by data shape.

---
**Next:** Proceed to Lesson 24 exercises.
