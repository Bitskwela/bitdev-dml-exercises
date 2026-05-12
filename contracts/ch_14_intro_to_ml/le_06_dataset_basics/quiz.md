# Lesson 6 Quiz: Dataset Basics

---
# Quiz 1
## Scenario: First Eyeball of Tita Malou's Data

Dan loads 977 rows into pandas for the first time. Ate Rina makes him run the four exploration functions before any modeling.

**Question 1:** Which pandas function shows row count, dtypes, and null counts at a glance?
A. `df.head()`
B. `df.info()`
C. `df.describe()`
D. `df.tail()`

**Answer:** B
**Explanation:** `.info()` is the structural summary — row count, dtypes, null counts per column.

---

**Question 2:** Which function shows min, max, mean, median for numeric columns?
A. `df.head()`
B. `df.info()`
C. `df.describe()`
D. `df.shape`

**Answer:** C
**Explanation:** `.describe()` is the statistical summary for numeric columns.

---

**Question 3:** After loading the CSV, `df["is_payday"]` is stored as strings `"True"`/`"False"`. Why is this a problem?
A. It's not — pandas handles it fine
B. Numeric operations like `.sum()` on these strings will concatenate text, not count booleans
C. The file is corrupted
D. Pandas can't read CSVs at all

**Answer:** B
**Explanation:** dtypes matter. String `"True"` does not behave like Python `True`. Convert before modeling.

---

**Question 4:** Which function tells you how many of each category appear in a column?
A. `df["col"].value_counts()`
B. `df["col"].sum()`
C. `df["col"].head()`
D. `df["col"].dtype`

**Answer:** A
**Explanation:** `.value_counts()` is the categorical column inspector.

---

# Quiz 2
## Scenario: Patterns Before Models

Dan uses `groupby` to confirm patterns Tita Malou already knows.

**Question 5:** Why is it useful to find patterns via `groupby` BEFORE training a model?
A. It's not useful
B. So you know what patterns the model should at minimum recover — if it misses them, the model is broken
C. To save memory
D. Because pandas requires it

**Answer:** B
**Explanation:** `groupby` patterns are the "sanity check" baseline. Any model that fails to recover obvious patterns is broken.

---

**Question 6:** In the sandbox, why do we load data via `pd.read_csv(StringIO(SAMPLE_CSV))` instead of `pd.read_csv("data.csv")`?
A. It's faster
B. The Pyodide sandbox has no writable filesystem; files would need to ship inside the lesson — StringIO lets us embed data as a Python string instead
C. It's a pandas requirement
D. Random preference

**Answer:** B
**Explanation:** Sandbox-safe data loading. The same pattern appears throughout the chapter.

---

**Question 7:** What's the safest first step on ANY new dataset?
A. Train a Random Forest immediately
B. Run head / info / describe / value_counts and fix any dtype surprises
C. Delete columns with weird names
D. Convert everything to strings

**Answer:** B
**Explanation:** Eyeball first. Skip the five minutes — lose a week debugging.

---
**Next:** Proceed to Lesson 6 exercises.
