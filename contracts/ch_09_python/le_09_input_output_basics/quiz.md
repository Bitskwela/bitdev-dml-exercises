# Lesson 9 Quiz: Input & Output Basics

---
# Quiz 1
## Scenario: Simple CLI Tool
Tian builds a data entry script.

**Question 1:** input() returns:
A. int
B. str
C. any inferred type
D. list

**Answer:** B
**Explanation:** input() returns raw string.

---

**Question 2:** Safe file reading pattern:
A. f = open('x.txt'); data = f.read() without close
B. with open('x.txt') as f: data = f.read()
C. open('x.txt').close() before reading
D. Manual GC call

**Answer:** B
**Explanation:** with ensures closure even on errors.

---

**Question 3:** Write mode "w" does what if file exists?
A. Appends
B. Raises error always
C. Truncates file
D. Renames file

**Answer:** C
**Explanation:** Mode w truncates existing content.

---

**Question 4:** Add text at end without losing existing content:
A. Mode "a"
B. Mode "w"
C. Mode "r"
D. Mode "x"

**Answer:** A
**Explanation:** Mode a appends to end.

---

**Question 5:** Formatting columns with alignment uses:
A. format or f-string alignment specifiers
B. Random spaces manual
C. Only tabs
D. Unsupported in Python

**Answer:** A
**Explanation:** Alignment supported via format specs.

---

# Quiz 2
## Scenario: Validation Review
Rhea Joy checks user input safety.

**Question 6:** Converting raw input to int should use:
A. Blind int(raw) regardless
B. Try/except handling ValueError
C. float(raw) then cast to int silently
D. Ignore invalid values

**Answer:** B
**Explanation:** try/except prevents crash on invalid input.

---

**Question 7:** Proper resource guarantee:
A. Rely on garbage collector timing
B. Open file, never close
C. Use context manager with
D. Keep global file handle

**Answer:** C
**Explanation:** Context manager deterministically closes file.

---

**Question 8:** .strip() removes:
A. Only spaces at left
B. Leading & trailing whitespace/newlines
C. All internal spaces
D. Nothing

**Answer:** B
**Explanation:** Strips outer whitespace/newlines.

---

**Question 9:** Splitting CSV line manually:
A. line.split(',')
B. line.partition(',') always yields list
C. line.divide(',')
D. Not possible without library

**Answer:** A
**Explanation:** split(',') separates fields.

---

**Question 10:** Encoding specified to:
A. Slow performance
B. Guarantee correct character decoding
C. Remove blank lines
D. Reorder columns

**Answer:** B
**Explanation:** Encoding ensures proper character handling (UTF-8 typical).

---

**Next:** Proceed to Lesson 9 exercises.
