# Lesson 7 Quiz: Intro to Python for AI

---
# Quiz 1
## Scenario: Why Python?
Dan spent the afternoon learning Python. Test his understanding.

**Question 1:** Why does Python dominate AI and data science?
A. It is the fastest programming language
B. Readability, powerful libraries, community, and being free
C. It's the only language that supports math
D. It was invented for AI

**Answer:** B
**Explanation:** Python isn't the fastest — but its readability, massive library ecosystem (numpy, pandas, tensorflow), community, and open-source nature make it perfect for AI.

---

**Question 2:** Which Python library is most commonly used for data analysis with DataFrames?
A. tensorflow
B. matplotlib
C. pandas
D. pytorch

**Answer:** C
**Explanation:** pandas is the go-to library for loading, cleaning, and analyzing structured data (CSV, Excel). tensorflow/pytorch are for deep learning.

---

**Question 3:** What does `type(60)` return?
A. `'number'`
B. `<class 'int'>`
C. `'integer'`
D. An error

**Answer:** B
**Explanation:** `type()` returns the class of the value. For 60, that's `<class 'int'>`. Use `.__name__` to get just `'int'`.

---

**Question 4:** What does the `%` operator do?
A. Calculates a percentage
B. Returns the remainder after division
C. Multiplies by 100
D. Divides by 100

**Answer:** B
**Explanation:** `%` is the modulo operator. `5 % 3 = 2` because 5 divided by 3 leaves a remainder of 2. Useful for checking even/odd, cycles, etc.

---

**Question 5:** What's the correct way to format a float with 2 decimal places in an f-string?
A. `f"P{price, 2}"`
B. `f"P{price:.2f}"`
C. `f"P{price%.2}"`
D. `f"P{round(price)}"`

**Answer:** B
**Explanation:** `:.2f` inside f-strings formats a float with exactly 2 decimal places. `.1f` for 1 decimal, etc.

---
# Quiz 2
## Scenario: Python Syntax
Help Dan navigate Python basics.

**Question 6:** What does `int("60")` return?
A. "60" (still a string)
B. 60 (as an integer)
C. An error
D. 60.0 (as a float)

**Answer:** B
**Explanation:** `int()` converts a numeric string to an integer. `int("60")` → 60. Use `float()` for decimal conversion.

---

**Question 7:** What's the main advantage of f-strings over concatenation?
A. They run faster
B. They make code more readable by embedding variables directly in the string
C. They are required in Python 3
D. They are the only way to print

**Answer:** B
**Explanation:** `f"Price: {price}"` is much cleaner than `"Price: " + str(price)`. f-strings make code readable and concise — a core Python value.

---
**Next:** Proceed to Lesson 7 exercises.
