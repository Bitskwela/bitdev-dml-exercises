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

**Question 3:** Why does the model predict EXPECTED REVENUE per ulam (not just "this ulam will sell")?
A. It doesn't
B. Because Tita Malou cares about peso revenue when deciding what to push — the regression target matches the business goal
C. Random
D. Convention

**Answer:** B
**Explanation:** Frame the ML target to match the business question. "Top revenue" is what she optimizes.

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
