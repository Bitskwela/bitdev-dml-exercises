# Lesson 8 Quiz: Python Basics — Lists, Loops, Decisions

---
# Quiz 1
## Scenario: Building the Ordering System
Dan needed loops to handle 20+ menu items.

**Question 1:** What is the correct way to access the first item in a list `menu`?
A. `menu(0)`
B. `menu[0]`
C. `menu.first()`
D. `menu{0}`

**Answer:** B
**Explanation:** Python lists use square brackets and zero-based indexing. `menu[0]` is the first item.

---

**Question 2:** Which loop is best when you don't know in advance how many times to repeat?
A. for loop
B. while loop
C. range loop
D. enumerate loop

**Answer:** B
**Explanation:** `while True:` loops are perfect for "keep going until condition X." For loops are for iterating over a known collection.

---

**Question 3:** What does `break` do inside a loop?
A. Pauses the loop
B. Skips to the next iteration
C. Exits the loop immediately
D. Restarts the loop

**Answer:** C
**Explanation:** `break` exits the loop completely. `continue` skips to the next iteration.

---

**Question 4:** What is a dictionary in Python?
A. A book of word definitions
B. A collection of key-value pairs
C. A type of list
D. A spell checker

**Answer:** B
**Explanation:** A dict stores data as key-value pairs: `{"name": "Adobo", "price": 60}`. Access values by key: `dish["name"]`.

---

**Question 5:** Which operator means "AND" in Python?
A. `&`
B. `&&`
C. `and`
D. `+`

**Answer:** C
**Explanation:** Python uses keywords `and`, `or`, `not` for logical operations (not symbols like `&&` or `||` from other languages).

---
# Quiz 2
## Scenario: Code Decisions
Dan added a senior discount.

**Question 6:** Which condition correctly checks if total is more than 500 AND it's payday?
A. `if total > 500 & is_payday:`
B. `if total > 500 and is_payday:`
C. `if total > 500, is_payday:`
D. `if total > 500 + is_payday:`

**Answer:** B
**Explanation:** Use `and` keyword to combine conditions. `&` is bitwise AND (different operation).

---

**Question 7:** What does `for i, item in enumerate(menu, 1):` do?
A. Loops through menu but only the first item
B. Loops through menu with a counter starting at 1
C. Loops 1 time through menu
D. Causes a syntax error

**Answer:** B
**Explanation:** `enumerate(menu, 1)` returns pairs of (index, item) starting from 1 — useful for numbered displays.

---
**Next:** Proceed to Lesson 8 exercises.
