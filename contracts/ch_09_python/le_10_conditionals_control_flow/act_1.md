# Conditionals and Control Flow Activity

Now that you understand control flow, let's practice writing clean conditional logic.

## Decision-Making Challenge

Good control flow makes programs intelligent and maintainable.

### Task 1: Grading System

Write a **3-branch grading if-elif-else** system.

**Your Code:**
```python
def assign_grade(score):
    """
    Assign letter grade based on numeric score.
    
    Args:
        score: Numeric score (0-100)
    
    Returns:
        Letter grade string
    """
    # Your code here:
    # 90-100: "A"
    # 80-89:  "B"
    # 70-79:  "C"
    # 60-69:  "D"
    # Below 60: "F"
    if score >= 90:
        return "A"
    elif score >= 80:
        return "B"
    elif score >= 70:
        return "C"
    elif score >= 60:
        return "D"
    else:
        return "F"

# Test cases
test_scores = [95, 85, 75, 65, 55, 100, 0]
for score in test_scores:
    grade = assign_grade(score)
    print(f"Score {score:3d} = Grade {grade}")
```

---

### Task 2: Combined Conditions

Combine **two conditions with `and`** for eligibility check.

**Your Code:**
```python
def check_scholarship_eligibility(age, is_resident):
    """
    Check if applicant meets basic eligibility.
    
    Args:
        age: Applicant age
        is_resident: Boolean residency status
    
    Returns:
        Boolean: True if eligible
    """
    # Your code here:
    # Must be 17 or older AND must be resident
    return age >= 17 and is_resident

# Test all combinations
test_cases = [
    (18, True),
    (16, True),
    (20, False),
    (16, False),
]

for age, is_resident in test_cases:
    result = check_scholarship_eligibility(age, is_resident)
    print(f"Age {age}, Resident={is_resident}: {result}")
```

**Bonus:** Add a third condition (GPA >= 3.0) using `and`:
```python
def full_eligibility_check(age, is_resident, gpa):
    # Your code with three conditions:
    
    
```

---

### Task 3: Membership Testing

Use **`in`** to check tag membership.

**Your Code:**
```python
def has_special_status(tags):
    """
    Check if resident has any special status tags.
    
    Args:
        tags: List of tag strings
    
    Returns:
        Boolean: True if has PWD, Senior, or Scholar tag
    """
    special_tags = ["PWD", "Senior", "Scholar"]
    
    # Your code here:
    # Check if any special tag is in the tags list
    for tag in tags:
        if tag in special_tags:
            return True
    return False

# Test cases
test_cases = [
    ["PWD", "Resident"],
    ["Scholar", "Athlete"],
    ["Resident", "Athlete"],
    ["PWD", "Scholar", "Senior"],
    [],
]

for tags in test_cases:
    result = has_special_status(tags)
    print(f"{tags} -> Special status: {result}")
```

---

### Task 4: Ternary Operator

Demonstrate **ternary expression** for even/odd check.

**Your Code:**
```python
# Regular if-else
def classify_regular(number):
    if number % 2 == 0:
        return "even"
    else:
        return "odd"

# Ternary (conditional expression)
def classify_ternary(number):
    # Your one-line ternary expression here:
    return "even" if number % 2 == 0 else "odd" 

# Test both
for num in [0, 1, 2, 7, 10, 15]:
    regular = classify_regular(num)
    ternary = classify_ternary(num)
    print(f"{num}: regular={regular}, ternary={ternary}")
```

**More ternary examples:**
```python
# Approval status
status = "Approved" if score >= 75 else "Rejected"

# Age category
category = "Adult" if age >= 18 else "Minor"

# Your example:
result = 
```

---

## Reflection Questions

**Two benefits of guard clauses over deeply nested if:**

1. _[Benefit 1: e.g., early returns make code flatter and easier to read]_

2. _[Benefit 2: e.g., each condition is independent and testable]_

**Example transformation:**
```python
# Nested (BAD)
def process(data):
    if data is not None:
        if len(data) > 0:
            if validate(data):
                return do_work(data)
    return None

# Guard clauses (GOOD)
def process(data):
    if data is None:
        return None
    if len(data) == 0:
        return None
    if not validate(data):
        return None
    return do_work(data)
```

**Additional reflections:**

3. **When should you use if-elif-else vs multiple if statements?**
   _[Your answer]_

4. **What's the danger of deeply nested conditionals?**
   _[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Multi-branch conditionals with if-elif-else
- Combining conditions with logical operators
- Using `in` for membership testing
- Writing ternary expressions
- Using guard clauses for cleaner code
Next, you'll learn about loops!

<details>
<summary><strong>Answer Key</strong></summary>
### Task 1: Grade Classification
```python
def classify_grade(gpa):
    if gpa >= 3.75:
        return "Honors"
    elif gpa >= 3.0:
        return "Good Standing"
    elif gpa >= 2.0:
        return "Passing"
    else:
        return "Probation"

for gpa in [4.0, 3.5, 2.5, 1.8]:
    print(f"GPA {gpa}: {classify_grade(gpa)}")
```

### Task 2: Combined Conditions
```python
def is_priority_applicant(age, gpa, is_indigenous):
    age_ok = 18 <= age <= 22
    gpa_ok = gpa >= 3.2
    
    return (age_ok and gpa_ok) or is_indigenous

print(is_priority_applicant(20, 3.5, False))  # True (age+GPA)
print(is_priority_applicant(17, 2.8, False))  # False
print(is_priority_applicant(30, 2.0, True))   # True (indigenous)
```

### Task 3: Membership Testing
```python
def has_special_status(tags):
    special_tags = ["PWD", "Senior", "Scholar"]
    
    for tag in tags:
        if tag in special_tags:
            return True
    return False

# Or simpler:
def has_special_status(tags):
    special_tags = {"PWD", "Senior", "Scholar"}
    return bool(set(tags) & special_tags)  # Set intersection

test_cases = [
    ["PWD", "Resident"],
    ["Scholar", "Athlete"],
    ["Resident", "Athlete"],
    ["PWD", "Scholar", "Senior"],
    []
]

for tags in test_cases:
    print(f"{tags} -> {has_special_status(tags)}")
```

### Task 4: Ternary Operator
```python
def classify_ternary(number):
    return "even" if number % 2 == 0 else "odd"

for num in [0, 1, 2, 7, 10, 15]:
    print(f"{num}: {classify_ternary(num)}")

# More examples
status = "Approved" if score >= 75 else "Rejected"
category = "Adult" if age >= 18 else "Minor"
discount = 0.20 if is_senior else 0.0
```

### Reflection
1. **Guard clauses benefits:** Flat code structure, early exits clear
2. **Guard clauses benefits:** Each condition independent, easier to test
3. **if-elif-else vs multiple if:** Use if-elif when conditions are mutually exclusive
4. **Danger of nesting:** Hard to read, understand, and test; "arrow anti-pattern"

</details>
