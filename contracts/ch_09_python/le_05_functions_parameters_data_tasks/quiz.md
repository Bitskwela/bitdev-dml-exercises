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

**Answer:** C  
**Explanation:** Centralizing reduces duplication.

---

**Question 2:** `def f(x, y=2): return x + y` call `f(5)` returns?
A. Error
B. 7
C. (5, 2)
D. None

**Answer:** B  
**Explanation:** Default y=2 → 5+2=7.

---

**Question 3:** Which captures arbitrary positional args?
A. `*args`
B. `**kwargs`
C. `default=`
D. `yield`

**Answer:** A  
**Explanation:** `*args` packs positional arguments.

---

**Question 4:** Mutable default parameter risk?
A. Creates new list each call
B. Shares same list across calls
C. Prevents appending
D. Forces type conversion

**Answer:** B  
**Explanation:** Same object reused → unintended accumulation.

---

**Question 5:** Pure function characteristic?
A. Prints results
B. Relies on global counters
C. Deterministic output from inputs
D. Opens files

**Answer:** C  
**Explanation:** Pure relies only on inputs.

---
# Quiz 2
## Scenario: Parameter Design Review
Rhea Joy inspects complexity of parameter usage.

**Question 6:** Given `def log(event, *ids, **extra): pass`, `ids` type is:
A. Dictionary
B. List
C. Tuple
D. Set

**Answer:** C  
**Explanation:** Collected into a tuple.

---

**Question 7:** Correct unpack when calling `combine(a,b,c)` using list `vals=[1,2,3]`:
A. `combine(vals)`
B. `combine(*vals)`
C. `combine(**vals)`
D. `combine[*vals]`

**Answer:** B  
**Explanation:** `*` unpacks sequence.

---

**Question 8:** Benefit of docstrings?
A. Slows interpreter
B. Auto input validation
C. Communicates intent & usage
D. Prevents exceptions

**Answer:** C  
**Explanation:** Docstrings explain behavior; tools read them.

---

**Question 9:** `global` keyword effect?
A. Declares local variable
B. Accesses & mutates module-level variable
C. Freezes variable immutably
D. Deletes variable

**Answer:** B  
**Explanation:** Enables modifying global state.

---

**Question 10:** Best refactor for side-effect heavy logic?
A. Increase parameter count
B. Wrap everything in one giant function
C. Separate pure computation from I/O boundaries
D. Remove return statements

**Answer:** C  
**Explanation:** Splitting isolates complexity & eases testing.  

---
**Next:** Proceed to Lesson 5 exercises.
