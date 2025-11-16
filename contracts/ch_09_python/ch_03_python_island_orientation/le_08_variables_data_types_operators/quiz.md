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

**Question 2:** Falsy value example:
A. "0"
B. []
C. [0]
D. "Ana"

**Question 3:** Result of `7 // 3`:
A. 2
B. 2.333...
C. 2.0
D. 3

**Question 4:** Expression precedence highest:
A. and
B. **
C. +
D. or

**Question 5:** Safe numeric conversion pattern:
A. int(x) blindly
B. try: val=int(x) except ValueError: val=0
C. val = x or 0 always works
D. float(int(x)) always safe

---
# Quiz 2
## Scenario: Logic Audit
Rhea Joy reviews boolean expressions for clarity.

**Question 6:** Good reason to use parentheses:
A. Decorate code visually
B. Clarify grouping overriding default precedence
C. Force evaluation left-to-right
D. Increase performance

**Question 7:** `total += 5` is:
A. Syntax error
B. Augmented assignment
C. Identity test
D. Type cast

**Question 8:** `tags and is_active` returns what if `tags` is empty list?
A. True
B. False
C. []
D. is_active value

**Question 9:** Efficient even check:
A. n / 2 == 0
B. n % 2 == 0
C. n // 2 == 0
D. n ** 2 % 2 == 0

**Question 10:** Proper immutable example:
A. list
B. dict
C. tuple
D. set

---
## Answers
1: C  
2: B  
3: A  
4: B  
5: B  
6: B  
7: B  
8: C  
9: B  
10: C  

---
## Detailed Explanations
Q1 is checks same object reference.  
Q2 Empty list evaluates False.  
Q3 Floor division truncates toward negative infinity (positive → 2).  
Q4 Exponentiation highest among listed.  
Q5 Try/except handles invalid strings.  
Q6 Parentheses improve readability for complex logic.  
Q7 Augmented assignment updates existing variable.  
Q8 Empty list is falsy, so returns [] (first operand).  
Q9 Modulo tests remainder for parity.  
Q10 Tuple immutable sequence.  

---
**Next:** Proceed to Lesson 8 exercises.
