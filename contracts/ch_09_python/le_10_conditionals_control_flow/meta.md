## Lesson 10 Exercises: Conditionals Mastery

---
### 1. Grade Calculator (7 minutes)
Write function grade(score) returning A/B/C/D/F using if-elif-else.

---
### 2. Eligibility Check (8 minutes)
Function eligible(age, resident, income): return True if age>=18 AND resident AND income<threshold.

---
### 3. Ternary Practice (5 minutes)
Convert: if n%2==0: label="even" else: label="odd" to ternary.

---
### 4. Membership Filter (7 minutes)
Given residents list of dicts, filter those with "PWD" in tags using list comprehension + in.

---
### 5. Guard Clause Refactor (8 minutes)
Original nested:
```python
def validate(data):
    if data:
        if len(data)>0:
            if data[0]:
                return True
    return False
```
Rewrite with guard clauses.

---
### 6. Chained Comparison (5 minutes)
Show age range check 13 <= age < 18 in single expression.

---
### 7. Logical Combination (7 minutes)
Write condition: approve if (senior OR pwd) AND income_below_limit.

---
### 8. Stretch: Multi-Rule Engine (Optional)
Function classify(resident): apply 4 rules returning category string.

---
### 9. Reflection (3 minutes)
Two scenarios where guard clauses improve readability.

---
**Next:** Lesson 11 (Loops).