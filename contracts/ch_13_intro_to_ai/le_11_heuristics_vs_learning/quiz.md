# Lesson 11 Quiz: Heuristics vs Learning

---
# Quiz 1
## Scenario: Jeepney vs Waze
Dan compared Mang Tonyo's experience-based shortcuts to Waze's data-driven rerouting.

**Question 1:** A heuristic is:
A. A machine learning algorithm
B. A rule of thumb written by humans from experience
C. A type of neural network
D. A sorting method

**Answer:** B
**Explanation:** Heuristics are hand-coded rules based on human expertise. Fast to deploy but don't improve without human intervention.

---

**Question 2:** A learning system differs from a heuristic because:
A. It runs faster
B. It discovers rules from data instead of humans writing them
C. It doesn't need a computer
D. It uses Python

**Answer:** B
**Explanation:** The key difference: who creates the rules. Heuristic = human. Learning = machine, from data.

---

**Question 3:** Which is TRUE about learning systems?
A. They work without any data
B. They improve as more data becomes available
C. They are always more accurate than heuristics
D. They never make mistakes

**Answer:** B
**Explanation:** Learning systems get better with more data. But they can be less accurate than good heuristics if data is scarce or noisy.

---

**Question 4:** Dan's ulam recommender from Lesson 1 is:
A. A learning system
B. A heuristic
C. A neural network
D. A random generator

**Answer:** B
**Explanation:** The ulam recommender uses hand-coded if-else rules — pure heuristic. No learning from data.

---

**Question 5:** When should you prefer a heuristic over a learning system?
A. When you have millions of data points
B. When you need maximum accuracy
C. When you have no data, need explainability, or are building an MVP
D. Never

**Answer:** C
**Explanation:** Heuristics shine when you're data-poor, need explainability, or need to deploy fast. Upgrade to learning when you have data and accuracy matters.

---
# Quiz 2
## Scenario: The Showdown
Dan pitted heuristic vs learning on carinderia sales data.

**Question 6:** Why did the learning system outperform the heuristic?
A. It used more CPU power
B. It discovered subtle patterns from 200 days of data that Mama never noticed
C. It used random guessing
D. It cheated by looking at test data

**Answer:** B
**Explanation:** With enough data, learning systems find micro-patterns (like "rainy Fridays specifically" vs all rainy days) that humans miss.

---

**Question 7:** What's the practical workflow Kuya JM suggests?
A. Always use learning
B. Always use heuristics
C. Start with heuristics (no data needed), upgrade to learning when data arrives
D. Flip a coin

**Answer:** C
**Explanation:** Pragmatic engineering: heuristics get you live fast with zero data. Once you've collected data, retrain with a learning system for better accuracy.

---
**Next:** Proceed to Lesson 11 exercises.
