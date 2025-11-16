## Lesson 10: Conditionals and Control Flow

Story: Scholarship eligibility script applies different rules for different ages and barangays. Tian hardcodes everything; Rhea Joy says: "Branch the logic." They unlock if/elif/else and nested conditions.

### 1. Basic if Statement
```python
if age >= 18:
    print("Eligible to vote")
```

### 2. if-else
```python
if approved:
    send_notification()
else:
    log_rejection()
```

### 3. if-elif-else Chain
```python
if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
else:
    grade = "F"
```

### 4. Truthiness in Conditions
```python
if tags:  # non-empty list?
    process(tags)
```

### 5. Comparison Operators Review
==, !=, <, >, <=, >=

### 6. Logical Operators
```python
if age > 18 and is_resident:
    approve()
if emergency or supervisor_override:
    grant_access()
if not archived:
    display()
```

### 7. Membership Tests
```python
if "PWD" in tags:
    apply_discount()
if user_id not in blacklist:
    allow()
```

### 8. Nested Conditionals
```python
if is_resident:
    if age >= 18:
        register_voter()
    else:
        register_minor()
```
Keep nesting shallow for readability.

### 9. Ternary (Conditional Expression)
```python
status = "Adult" if age >= 18 else "Minor"
```

### 10. Common Pitfalls
- Using = (assignment) instead of == (comparison).
- Forgetting colon after condition.
- Misaligned indentation.
- Empty blocks (use pass if needed).

### 11. Guard Clauses
Early return pattern:
```python
def process(data):
    if not data:
        return None
    # main logic
```

### 12. Story Thread
Refactored eligibility checks: clear branches for age, residency, income thresholds—easier debugging.

### 13. Practice Prompts
1. Write 3-branch grading if-elif-else.
2. Combine two conditions with and.
3. Use in to check tag membership.
4. Demonstrate ternary for even/odd.

### 14. Reflection
Two benefits of guard clauses over deeply nested if.

**Next:** Quiz then exercises.