# Lesson 5 Quiz: Functions & Parameters

---
# Quiz 1
## Scenario: Refactoring Drive
Tian converts repeated code blocks into functions. Evaluate his designs.

**Question 1:** BEST reason to create a function rather than duplicate code?
A. Slows execution
B. Increases coupling
C. Centralizes logic for reuse
D. Obfuscates intent

**Question 2:** `def f(x, y=2): return x + y` call `f(5)` returns?
A. Error
B. 7
C. (5, 2)
D. None

**Question 3:** Which captures arbitrary positional args?
A. `*args`
B. `**kwargs`
C. `default=`
D. `yield`

**Question 4:** Mutable default parameter risk?
A. Creates new list each call
B. Shares same list across calls
C. Prevents appending
D. Forces type conversion

**Question 5:** Pure function characteristic?
A. Prints results
B. Relies on global counters
C. Deterministic output from inputs
D. Opens files

---
# Quiz 2
## Scenario: Parameter Design Review
Rhea Joy inspects complexity of parameter usage.

**Question 6:** Given `def log(event, *ids, **extra): pass`, `ids` type is:
A. Dictionary
B. List
C. Tuple
D. Set

**Question 7:** Correct unpack when calling `combine(a,b,c)` using list `vals=[1,2,3]`:
A. `combine(vals)`
B. `combine(*vals)`
C. `combine(**vals)`
D. `combine[*vals]`

**Question 8:** Benefit of docstrings?
A. Slows interpreter
B. Auto input validation
C. Communicates intent & usage
D. Prevents exceptions

**Question 9:** `global` keyword effect?
A. Declares local variable
B. Accesses & mutates module-level variable
C. Freezes variable immutably
D. Deletes variable

**Question 10:** Best refactor for side-effect heavy logic?
A. Increase parameter count
B. Wrap everything in one giant function
C. Separate pure computation from I/O boundaries
D. Remove return statements

---
## Answers
1: C  
2: B  
3: A  
4: B  
5: C  
6: C  
7: B  
8: C  
9: B  
10: C  

---
## Detailed Explanations
**Q1:** Centralizing reduces duplication.  
**Q2:** Default y=2 → 5+2=7.  
**Q3:** `*args` packs positional arguments.  
**Q4:** Same object reused → unintended accumulation.  
**Q5:** Pure relies only on inputs.  
**Q6:** Collected into a tuple.  
**Q7:** `*` unpacks sequence.  
**Q8:** Docstrings explain behavior; tools read them.  
**Q9:** Enables modifying global state.  
**Q10:** Splitting isolates complexity & eases testing.  

---
**Next:** Proceed to Lesson 5 exercises.
