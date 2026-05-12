# Lesson 1 Quiz: What is Machine Learning?

---
# Quiz 1
## Scenario: Dan's First DM to Ate Rina

Two weeks after the hackathon, Dan messages Ate Rina about Tita Malou's notebook. He wants Luto to learn from data instead of from typed rules. Help him check his understanding.

**Question 1:** Which statement BEST describes Machine Learning?
A. A way to write better if-elif chains
B. A way for a computer to discover rules from examples instead of being given them
C. A specific Python library
D. Any program that uses random numbers

**Answer:** B
**Explanation:** ML is exactly the inversion of traditional programming. Instead of you writing rules, you give the computer examples and let it learn the rules.

---

**Question 2:** Tita Malou knows that rainy Fridays sell more sinigang. Ate Rina says she is "already a model." What does she mean?
A. Tita Malou is literally a computer
B. Tita Malou has been "trained" by 15 years of carinderia data — she infers rules from experience the same way ML does
C. Tita Malou wrote the rules down somewhere
D. Tita Malou's intuition is random

**Answer:** B
**Explanation:** Tita Malou's gut feeling is the human version of an ML model — patterns extracted from years of observations.

---

**Question 3:** Which of these is NOT one of the three steps every ML project has?
A. Get data
B. Train a model
C. Use the model
D. Re-write the rules every Monday

**Answer:** D
**Explanation:** The three steps are: get data, train a model, use the model. Re-writing rules is the *opposite* of ML.

---

**Question 4:** Lazada's search bar interprets "pang work na sapatos" as a query for office shoes. How did it learn that mapping?
A. A Lazada engineer typed every Filipino-English phrase by hand
B. From billions of past clicks: people who searched that way ended up clicking on office shoes
C. It's a coincidence
D. From a Tagalog-English dictionary lookup

**Answer:** B
**Explanation:** Search models learn from user behavior. The mapping from query to product comes from data, not hand-coded translations.

---

# Quiz 2
## Scenario: Scaling Up Luto

Dan considers what it would take to scale Luto's logic to 12 dishes, 4 weather types, 7 days of the week, and a payday flag. He has to decide between the rules approach and the examples approach.

**Question 5:** Roughly how many if-elif cases would Dan need to cover every combination?
A. 12
B. About 70
C. About 670
D. Just one — `if anything: return "Adobo"`

**Answer:** C
**Explanation:** 4 × 7 × 2 × 12 = 672 combinations. Writing each one as a rule is impractical — exactly the scaling problem ML solves.

---

**Question 6:** Which approach is easier when Tita Malou adds a brand-new dish, "Pansit Palabok"?
A. Rule-based — Dan just adds a new if-statement
B. Example-based — Dan adds a few rows of `(features, "Pansit Palabok")` to the training data
C. They're equally hard
D. Neither — Dan has to start from scratch

**Answer:** B
**Explanation:** With examples, you simply add new rows; the model retrains. With rules, you'd have to carefully insert if-statements in the right places to avoid breaking other paths.

---

**Question 7:** In the rule-based approach, where do the rules come from? In the ML approach, where do they come from?
A. Both come from the data
B. Both come from the programmer
C. Rule-based: from the programmer. ML: from the data.
D. Rule-based: from the data. ML: from the programmer.

**Answer:** C
**Explanation:** That's the central inversion. Traditional programming = humans encode rules. ML = the computer extracts rules from data.

---
**Next:** Proceed to Lesson 1 exercises.
