# Lesson 8 Quiz: Variables, Types, Operators

---
# Quiz 1
## Scenario: Data Normalization
Tian cleans mixed-type fields from CSV import.

**Question 1:** `a is b` checks:
A. Value equality
B. Type compatibility
C. Object identity (same reference)
D. Numeric ordering

**Answer:** C  
**Explanation:** is checks same object reference.

---

**Question 2:** Falsy value example:
A. "0"
B. []
C. [0]
D. "Ana"

**Answer:** B  
**Explanation:** Empty list evaluates False.

---

**Question 3:** Result of `7 // 3`:
A. 2
B. 2.333...
C. 2.0
D. 3

**Answer:** A  
**Explanation:** Floor division truncates toward negative infinity (positive → 2).

---

**Question 4:** Expression precedence highest:
A. and
B. **
C. +
D. or

**Answer:** B  
**Explanation:** Exponentiation highest among listed.

---

**Question 5:** Safe numeric conversion pattern:
A. int(x) blindly
B. try: val=int(x) except ValueError: val=0
C. val = x or 0 always works
D. float(int(x)) always safe

**Answer:** B  
**Explanation:** Try/except handles invalid strings.

---
# Quiz 2
## Scenario: Logic Audit
Rhea Joy reviews boolean expressions for clarity.

**Question 6:** Good reason to use parentheses:
A. Decorate code visually
B. Clarify grouping overriding default precedence
C. Force evaluation left-to-right
D. Increase performance

**Answer:** B  
**Explanation:** Parentheses improve readability for complex logic.

---

**Question 7:** `total += 5` is:
A. Syntax error
B. Augmented assignment
C. Identity test
D. Type cast

**Answer:** B  
**Explanation:** Augmented assignment updates existing variable.

---

**Question 8:** `tags and is_active` returns what if `tags` is empty list?
A. True
B. False
C. []
D. is_active value

**Answer:** C  
**Explanation:** Empty list is falsy, so returns [] (first operand).

---

**Question 9:** Efficient even check:
A. n / 2 == 0
B. n % 2 == 0
C. n // 2 == 0
D. n ** 2 % 2 == 0

**Answer:** B  
**Explanation:** Modulo tests remainder for parity.

---

**Question 10:** Proper immutable example:
A. list
B. dict
C. tuple
D. set

**Answer:** C  
**Explanation:** Tuple immutable sequence.  

---
**Next:** Proceed to Lesson 8 exercises.
