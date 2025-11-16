## Lesson 8 Exercises: Variables & Operators

---
### 1. Identity vs Equality (6 minutes)
Create two lists with same contents; compare == and is. Repeat with two identical small integers (may be cached). Record results.

---
### 2. Truthiness Filter (6 minutes)
Given mixed list: [0, 1, "", "hi", [], [1], None, "0"] build new list of truthy values only via comprehension.

---
### 3. Safe Parse Function (7 minutes)
Implement parse_int(s) using try/except returning 0 on failure. Test with '42', 'x7', ''.

---
### 4. Boolean Expression Simplification (8 minutes)
Original: if (active == True) and (len(tags) > 0) and (not archived == False):
Simplify using truthiness & direct comparisons.

---
### 5. Operator Practice (7 minutes)
Compute for n=13: square, modulo 5, floor divide by 4, exponent 2**n. Summarize in dict.

---
### 6. Precedence Clarifier (7 minutes)
Rewrite expression: a + b * c ** d with parentheses to show evaluation order explicitly.

---
### 7. Even/Odd Tagging (8 minutes)
Generate list [0..15] classify each number into dict: number → 'even'/'odd'.

---
### 8. Stretch: Type Registry (Optional)
Function describe(obj) returns dict: {'type': <name>, 'mutable': bool, 'length': maybe}; test on list, tuple, int, string.

---
### 9. Reflection (3 minutes)
Two subtle operator or truthiness insights gained.

---
**Next:** Lesson 9 (Input & Output Basics).
