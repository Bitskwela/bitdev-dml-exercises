# Lesson 5 Quiz: Data in AI

---
# Quiz 1
## Scenario: The Barangay Goldmine
Dan realized he's been working with data for months at the barangay office. Test your understanding.

**Question 1:** What does "GIGO" stand for in the context of AI?
A. Great In, Great Out
B. Garbage In, Garbage Out
C. Good Information, Good Output
D. General Input, General Output

**Answer:** B
**Explanation:** GIGO means bad data produces bad predictions, no matter how sophisticated the model.

---

**Question 2:** Data used to TEACH the model is called:
A. Test Data
B. Validation Data
C. Training Data
D. Production Data

**Answer:** C
**Explanation:** Training data is what the model learns from. Test data is held back to verify the model learned correctly.

---

**Question 3:** Why do we split data into training/test/validation sets?
A. To save disk space
B. To make sure the model truly learned patterns instead of memorizing answers
C. To make training faster
D. Because the CSV file is too big

**Answer:** B
**Explanation:** Testing on unseen data reveals whether the model can generalize. Testing on training data is like getting the exam questions in advance.

---

**Question 4:** Which is NOT a characteristic of good data?
A. Complete (no missing values)
B. Accurate (correct values)
C. Duplicated (the same row repeated many times)
D. Consistent (same format throughout)

**Answer:** C
**Explanation:** Duplicates inflate the importance of certain records and distort analysis. Good data should be deduplicated.

---

**Question 5:** What does `csv.DictReader` return for each row?
A. A list of values
B. A tuple of values
C. A dictionary where keys are column names
D. A single string

**Answer:** C
**Explanation:** `csv.DictReader` turns each row into a dict keyed by the header row, making it easy to access columns by name (e.g., `row["revenue"]`).

---
# Quiz 2
## Scenario: Finding Data
Dan explores public data sources for his hackathon.

**Question 6:** Which of these is a Philippine-specific source for open government data?
A. Kaggle
B. data.gov.ph
C. UCI ML Repository
D. World Bank

**Answer:** B
**Explanation:** data.gov.ph is the Philippine Open Data portal. Kaggle, UCI, and World Bank are also great, but data.gov.ph is PH-specific.

---

**Question 7:** Dan's mom tracks sales in her handwritten notebook. What is the biggest problem with this approach?
A. It's too fast
B. The data can't be easily analyzed, shared, or fed into an AI model
C. Notebooks are expensive
D. There's nothing wrong with it

**Answer:** B
**Explanation:** Handwritten data can't be processed by computers without expensive OCR. To use data for AI, it needs to be in a structured digital format like CSV.

---
**Next:** Proceed to Lesson 5 exercises.
