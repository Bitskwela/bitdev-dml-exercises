# Python Syntax and Style Activity

Now that you understand Python syntax, indentation, and comments, let's practice writing clean, readable code.

## Code Clarity Challenge

Clean code isn't just functional - it's readable and maintainable.

### Task 1: Reformat Messy Code

Reformat a **one-line multi-statement script** into readable blocks.

**Before (BAD):**
```python
x=5;y=10;z=x+y;print(z);print("Done")
```

**After (GOOD):**
```python
# Your refactored code here:
# - One statement per line
# - Proper spacing
# - Clear variable names
# - Appropriate comments where needed




```

**What makes the refactored version better?**

1. _[Reason 1]_
2. _[Reason 2]_
3. _[Reason 3]_

---

### Task 2: Comments vs Docstrings

Replace a **redundant inline comment** with a proper docstring.

**Before (Redundant Comments):**
```python
def add(a, b):
    # add a and b
    result = a + b  # store sum
    return result   # return result
```

**After (Clean Docstring):**
```python
def add(a, b):
    # Your docstring here
    
    
    
    return a + b
```

**When should you use comments vs docstrings?**

- **Comments:** _[When to use]_
- **Docstrings:** _[When to use]_

---

### Task 3: IndentationError Demo

Demonstrate an **IndentationError**, then correct it.

**Broken Code:**
```python
def check_age(age):
if age >= 18:
    print("Adult")
   else:
  print("Minor")
```

**Problems identified:**
1. _[Problem 1]_
2. _[Problem 2]_
3. _[Problem 3]_

**Corrected Code:**
```python
# Your fixed code here with proper indentation:





```

**Python indentation rules:**
- Use _[spaces/tabs?]_ (choose one and be consistent)
- Standard indent is _[how many spaces?]_
- Mixing tabs and spaces causes _[what error?]_

---

### Task 4: Line Continuation

Show **line continuation** using parentheses for long statements.

**Ugly Long Line:**
```python
message = "Approved scholarship applicant: " + applicant_name + " from Barangay " + barangay + " with amount: " + str(amount)
```

**Better (Using Parentheses):**
```python
# Your refactored code here:
# Use parentheses for implicit line continuation
# Make it readable and maintainable





```

**Alternative (Using f-strings):**
```python
# Even better with f-strings:



```

---

## Reflection Questions

**Why does indentation over braces aid quick scanning? Give two reasons:**

1. _[Reason 1: e.g., visual hierarchy is immediately clear]_

2. _[Reason 2: e.g., no noise from extra characters]_

**Additional reflections:**

3. **What's the main benefit of PEP 8 style guide?**
   _[Your answer]_

4. **When are comments helpful vs harmful?**
   _[Your answer]_

5. **Why does Python enforce indentation?**
   _[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Reformatting messy code for readability
- Writing meaningful docstrings
- Understanding Python indentation rules
- Using line continuation properly
- Applying PEP 8 style guidelines
Next, you'll learn about variables, data types, and operators!

<details>
<summary><strong>Answer Key</strong></summary>
### Task 1: Reformat Code
```python
def calculate_scholarship_amount(gpa, age, barangay):
    """Calculate scholarship amount based on criteria."""
    base_amount = 5000
    
    if gpa >= 3.5:
        base_amount += 2000
    
    if age < 20:
        base_amount += 1000
    
    if barangay in ["San Roque", "Sto. Niño"]:
        base_amount += 500
    
    return base_amount

result = calculate_scholarship_amount(3.7, 18, "San Roque")
print(f"Scholarship amount: ₱{result}")
```

### Task 2: Add Docstring
```python
def filter_eligible_applicants(applicants, min_gpa=3.0, max_age=25):
    """
    Filter applicants by GPA and age criteria.
    
    Args:
        applicants (list): List of applicant dictionaries
        min_gpa (float): Minimum GPA requirement (default: 3.0)
        max_age (int): Maximum age allowed (default: 25)
    
    Returns:
        list: Filtered list of eligible applicants
    
    Example:
        >>> applicants = [{"name": "Ana", "gpa": 3.5, "age": 20}]
        >>> filter_eligible_applicants(applicants, min_gpa=3.2)
        [{"name": "Ana", "gpa": 3.5, "age": 20}]
    """
    return [
        a for a in applicants
        if a["gpa"] >= min_gpa and a["age"] <= max_age
    ]
```

### Task 3: Fix IndentationError
```python
def process_application(applicant):
    if applicant["age"] >= 18:  # Proper indent
        print(f"Processing {applicant['name']}")
        
        if applicant["gpa"] >= 3.0:  # Nested indent
            print("Eligible!")
            return True
        else:
            print("GPA too low")
            return False
    else:
        print("Too young")
        return False
```

**Python indentation:**
- Use **4 spaces** (not tabs)
- Mixing tabs/spaces causes **IndentationError**
- Consistency is enforced by Python

### Task 4: Line Continuation
```python
# Using parentheses (implicit continuation)
message = (
    "Approved scholarship applicant: " + applicant_name +
    " from Barangay " + barangay +
    " with amount: " + str(amount)
)

# Better with f-strings
message = (
    f"Approved scholarship applicant: {applicant_name} "
    f"from Barangay {barangay} "
    f"with amount: ₱{amount:,}"
)
```

### Reflection
1. **Indentation aids scanning:** Visual hierarchy clear, no brace noise
2. **Indentation aids scanning:** Blocks obvious at a glance
3. **PEP 8 benefit:** Consistent style across Python projects, easier collaboration
4. **Comments helpful when:** Explain "why" not "what"; harmful when outdated/obvious
5. **Python enforces indentation:** Ensures readability, prevents ambiguity

</details>
