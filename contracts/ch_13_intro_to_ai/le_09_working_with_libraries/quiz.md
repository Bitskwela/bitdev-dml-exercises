# Lesson 9 Quiz: Working with Libraries

---
# Quiz 1
## Scenario: Standing on the Shoulders of Giants
Dan discovered that pandas can do in 3 lines what takes 50 in raw Python.

**Question 1:** What is the standard import convention for pandas?
A. `import pandas`
B. `import pandas as pd`
C. `from pandas import *`
D. `import pd from pandas`

**Answer:** B
**Explanation:** `import pandas as pd` is the near-universal convention. Using `pd` keeps code concise and matches what you see everywhere online.

---

**Question 2:** What does `df.head()` return?
A. Only the header/column names
B. The first 5 rows by default
C. A single row
D. Nothing — it just prints

**Answer:** B
**Explanation:** `df.head()` returns the first 5 rows. Pass a number to get more: `df.head(10)`.

---

**Question 3:** Which pandas method gives you summary statistics (count, mean, std, min, max)?
A. `df.summarize()`
B. `df.describe()`
C. `df.stats()`
D. `df.info()`

**Answer:** B
**Explanation:** `df.describe()` gives count, mean, std, min, quartiles, and max for numeric columns. `df.info()` shows types and null counts instead.

---

**Question 4:** How do you filter a DataFrame to rows where revenue > 500?
A. `df.filter(revenue > 500)`
B. `df[df["revenue"] > 500]`
C. `df.where(revenue, 500)`
D. `df.select(revenue > 500)`

**Answer:** B
**Explanation:** Boolean indexing: `df["revenue"] > 500` creates a mask of True/False, and `df[mask]` returns only the True rows.

---

**Question 5:** What does `df.groupby("item")["revenue"].sum()` compute?
A. The grand total revenue
B. Revenue for the first item only
C. Total revenue per item
D. An error

**Answer:** C
**Explanation:** Group by item, then sum revenue within each group. The result is one row per unique item with its total revenue.

---
# Quiz 2
## Scenario: Why Libraries
Dan saw a 50-line task shrink to 3 lines.

**Question 6:** Why is numpy faster than a pure Python for loop for math operations?
A. Numpy is written in C and uses vectorized operations
B. Numpy uses magic
C. Numpy only works on small data
D. Numpy uses more memory

**Answer:** A
**Explanation:** Numpy's operations are implemented in C (and SIMD-optimized). Vectorized ops like `arr1 * arr2` are 10-100x faster than a Python for loop doing the same work.

---

**Question 7:** What's the difference between `pip install pandas` and `import pandas`?
A. They're the same
B. `pip install` downloads and installs the library once; `import` makes it available in your program
C. `pip install` is for Python 2, `import` is for Python 3
D. `pip install` is optional

**Answer:** B
**Explanation:** `pip install` is a one-time download. After that, every Python program can `import` pandas to use it.

---
**Next:** Proceed to Lesson 9 exercises.
