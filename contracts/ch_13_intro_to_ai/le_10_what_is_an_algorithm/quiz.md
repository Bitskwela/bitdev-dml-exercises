# Lesson 10 Quiz: What is an Algorithm?

---
# Quiz 1
## Scenario: Dan vs Jasper's Jargon
Dan learned that algorithms are just recipes.

**Question 1:** An algorithm is best described as:
A. A type of AI
B. A finite, well-defined sequence of instructions to solve a problem
C. A Python function
D. A sorting method

**Answer:** B
**Explanation:** Algorithms are step-by-step recipes. They have inputs, outputs, and a finite number of definite steps.

---

**Question 2:** Which of these is NOT a property of an algorithm?
A. Finite (must terminate)
B. Definite (each step unambiguous)
C. Infinite (runs forever)
D. Has input and produces output

**Answer:** C
**Explanation:** Algorithms MUST terminate in a finite number of steps. An infinite loop isn't an algorithm.

---

**Question 3:** Big O notation measures:
A. How much memory an algorithm uses
B. How the runtime grows as input size grows
C. How many bugs an algorithm has
D. The age of the algorithm

**Answer:** B
**Explanation:** Big O describes the algorithm's runtime complexity as n (input size) grows. O(n²) means quadratic growth — doubling n quadruples the time.

---

**Question 4:** Bubble sort has complexity:
A. O(1)
B. O(log n)
C. O(n)
D. O(n²)

**Answer:** D
**Explanation:** Bubble sort has nested loops — each item compared to every other. Quadratic. Slow on big data.

---

**Question 5:** Which Python function uses Timsort (O(n log n)) under the hood?
A. `sort(list)`
B. `sorted(list)`
C. `list.order()`
D. `organize(list)`

**Answer:** B
**Explanation:** Python's built-in `sorted()` and `.sort()` both use Timsort — a hybrid of merge sort and insertion sort — running in O(n log n).

---
# Quiz 2
## Scenario: Searching and Combos
Dan built search and combo algorithms.

**Question 6:** Binary search requires that the data is:
A. Large
B. Sorted
C. Numeric
D. In a dictionary

**Answer:** B
**Explanation:** Binary search cuts the range in half each step by comparing to the middle. If data isn't sorted, "middle" is meaningless — you'd miss the target.

---

**Question 7:** On a list of 1,000,000 items, roughly how many comparisons does binary search need (worst case)?
A. 1,000,000
B. 500,000
C. About 20
D. 1

**Answer:** C
**Explanation:** log₂(1,000,000) ≈ 20. Binary search is dramatically faster than linear search on large sorted data.

---
**Next:** Proceed to Lesson 10 exercises.
