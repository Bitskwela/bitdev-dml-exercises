# Lesson 25 Quiz: Mini ML Project

---
# Quiz 1
## Scenario: Shipping Luto v2

Dan's final project: predict top-3 ulam given tomorrow's date + weather + payday.

**Question 1:** What's the INPUT to Luto v2's forecaster?
A. The full 977-row dataset
B. A single tuple: (date, weather, is_payday)
C. Just the date
D. Just the weather

**Answer:** B
**Explanation:** Tita Malou doesn't have tomorrow's data — she has tomorrow's *features*. The forecaster takes those.

---

**Question 2:** What's the OUTPUT?
A. A single ulam prediction
B. Top 3 ulam ranked by EXPECTED REVENUE
C. Yes/no
D. A confusion matrix

**Answer:** B
**Explanation:** Top 3 ranked = a list of three menu recommendations. The actionable deliverable.

---

**Question 3:** Tita Malou wants to know which 3 ulam to prepare tomorrow. Design choice: (a) binary classifier — will each ulam sell ≥15 portions? (b) regressor — what is the expected revenue? Which gives her a more useful ranked list, and why?
A. (a) the classifier — yes/no is simpler and easier to explain to a non-technical user
B. (b) the regressor — it produces a number per ulam you can sort to get a ranked top-3; the classifier only says good/bad with no way to rank ties
C. Both are equivalent — just run whichever is faster
D. Neither — clustering would produce natural ulam groups for this problem

**Answer:** B
**Explanation:** The business need is a ranked list: push ulam 1 first, ulam 2 second, ulam 3 third. A binary classifier can only say yes or no per ulam — if 5 ulam all pass the threshold, you have no ranking. A regressor predicts expected revenue for each ulam; sort descending and take the top 3. The output shape of your model must match the decision your stakeholder needs to make.

---

**Question 4:** Why are the acceptance criteria more important than the choice of algorithm?
A. They're not
B. Acceptance criteria are the CONTRACT (what the deliverable must do). The algorithm is the implementation choice; many algorithms can satisfy the same contract.
C. Algorithms are useless
D. Random

**Answer:** B
**Explanation:** This is engineering vs research. Engineers contract on outputs; implementation is taste. Models can be swapped.

---

# Quiz 2
## Scenario: The Whole Course in One Project

The mini project reuses everything from Lessons 6 to 22.

**Question 5:** Which Lesson 9 numpy idiom does the project's `LinRegScratch.fit` use?
A. Gradient descent
B. The normal equation: `np.linalg.solve(X.T @ X, X.T @ y)`
C. Random sampling
D. Pickle

**Answer:** B
**Explanation:** Closed-form linear regression. One numpy line. Lesson 9's main insight.

---

**Question 6:** Which Lesson 22 idiom packages the trained model for deployment?
A. print()
B. `pickle.dumps(model)` — serialize to bytes
C. Email
D. There's no packaging

**Answer:** B
**Explanation:** Sandbox-safe serialization. Same idea as `joblib.dump` for non-sandbox environments.

---

**Question 7:** What's the final message of the course?
A. "Use sklearn for everything"
B. "This is the end of Dan's ML story — but the beginning of yours" — you have the foundation; go build for your community
C. "ML is impossible"
D. "Only PhDs can do ML"

**Answer:** B
**Explanation:** The course's purpose was to build the foundation. The Filipino dev community in 2026 needs more people who can build, not just talk about it.

---
**Next:** Proceed to Lesson 25 exercises. (End of course — congratulations.)
