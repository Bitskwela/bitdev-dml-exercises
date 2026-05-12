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

**Question 5:** For 30 rows of tabular carinderia data, what's the RIGHT first algorithm?
A. A deep neural network
B. Random Forest or Logistic Regression — tabular + small → ML wins
C. GPT-4
D. K-Means

**Answer:** B
**Explanation:** DL is overkill for small tabular data. ML is the right tool.

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
