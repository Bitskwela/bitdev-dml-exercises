# Lesson 21 Quiz: Modules & Imports

---
# Quiz 1
## Scenario: Code Organization
Tian splits monolithic script.

**Question 1:** Module definition:
A. Any .py file
B. Only standard library
C. Binary compiled code
D. Database connection

**Answer: A**  
**Explanation:** Any .py file can be imported as module.

---

**Question 2:** Import specific function:
A. import math.sqrt
B. from math import sqrt
C. load math.sqrt
D. use sqrt from math

**Answer: B**  
**Explanation:** from module import name syntax.

---

**Question 3:** Alias purpose:
A. Slows import
B. Shortens long names
C. Prevents import
D. No benefit

**Answer: B**  
**Explanation:** Alias shortens (e.g., pd for pandas).

---

**Question 4:** from module import * issue:
A. Faster execution
B. Namespace pollution
C. More secure
D. Required practice

**Answer: B**  
**Explanation:** import * clutters namespace, unclear origin.

---

**Question 5:** Package marker file:
A. setup.py
B. __init__.py
C. main.py
D. config.py

**Answer: B**  
**Explanation:** __init__.py marks directory as package.

---
# Quiz 2
## Scenario: Module Best Practices
Rhea Joy enforces patterns.

**Question 6:** if __name__ == "__main__": purpose:
A. Always runs
B. Runs only when script executed directly
C. Prevents imports
D. Speeds execution

**Answer: B**  
**Explanation:** __main__ guard runs code only when script executed.

---

**Question 7:** Standard library includes:
A. Pandas
B. os, sys, datetime
C. Flask
D. NumPy

**Answer: B**  
**Explanation:** Standard library built-in (os, sys, datetime).

---

**Question 8:** Install third-party package:
A. import install package
B. pip install package
C. python add package
D. load package

**Answer: B**  
**Explanation:** pip install command for third-party packages.

---

**Question 9:** Relative import syntax (same package):
A. import .module
B. from . import module
C. load ./module
D. use module

**Answer: B**  
**Explanation:** from . import sibling in same package.

---

**Question 10:** Module organization benefit:
A. Slows development
B. Easier maintenance, reuse
C. More bugs
D. Harder testing

**Answer: B**  
**Explanation:** Modules improve maintainability, reusability.

---
**Next:** Proceed to Lesson 21 exercises.