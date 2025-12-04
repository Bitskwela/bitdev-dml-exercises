# Variables, Data Types, and Operators Activity

Now that you understand Python's type system and operators, let's practice working with different data types effectively.

## Type System Mastery

Understanding types and operators prevents bugs and makes code more robust.

### Task 1: == vs is (Equality vs Identity)

Show the **difference between == and is** on integers and lists.

**Your Code:**
```python
# Test with small integers
a = 256
b = 256
print(f"a == b: {a == b}")  # Value equality
print(f"a is b: {a is b}")  # Identity (same object?)

# Test with lists
list1 = [1, 2, 3]
list2 = [1, 2, 3]
list3 = list1

print(f"\nlist1 == list2: {list1 == list2}")  # ?
print(f"list1 is list2: {list1 is list2}")  # ?
print(f"list1 is list3: {list1 is list3}")  # ?

# Your explanation:
# Why is small int behavior different from list behavior?
```

**Explanation:**

**==** checks: _[value equality or identity?]_

**is** checks: _[value equality or identity?]_

**When should you use `is`?**
_[e.g., checking for None, checking identity]_

**When should you use `==`?**
_[e.g., comparing values]_

---

### Task 2: Complex Boolean Expression

Build a **Boolean expression combining 3 conditions** for scholarship eligibility.

**Requirements:**
- Age must be between 17 and 25 (inclusive)
- GPA must be at least 3.0
- Must be a resident (boolean flag)

**Your Code:**
```python
def is_eligible(age, gpa, is_resident):
    """
    Check if applicant is eligible for scholarship.
    
    Args:
        age: Integer age of applicant
        gpa: Float GPA (0.0 - 4.0)
        is_resident: Boolean residency status
    
    Returns:
        Boolean indicating eligibility
    """
    # Your complex boolean expression here:
    return (
        # Condition 1:
        
        # Condition 2:
        
        # Condition 3:
        
    )

# Test cases
print(is_eligible(18, 3.5, True))   # Should be True
print(is_eligible(16, 3.5, True))   # Should be False (too young)
print(is_eligible(20, 2.5, True))   # Should be False (GPA too low)
print(is_eligible(20, 3.5, False))  # Should be False (not resident)
```

---

### Task 3: Safe String to Number Conversion

Convert a **numeric string safely** with fallback to 0 for invalid input.

**Your Code:**
```python
def safe_int(value, default=0):
    """
    Safely convert value to integer.
    
    Args:
        value: Input value (might be string, int, or invalid)
        default: Fallback value if conversion fails
    
    Returns:
        Integer value or default
    """
    # Your code here with try/except:
    
    
    
    

# Test cases
print(safe_int("42"))          # 42
print(safe_int("abc"))         # 0 (fallback)
print(safe_int("3.14"))        # 0 (not valid int)
print(safe_int(42))             # 42 (already int)
print(safe_int("", default=1)) # 1 (custom fallback)
```

**Why not just use int(value) directly?**
_[Explain error handling and robustness]_

---

### Task 4: Modulo for Even/Odd Classification

Demonstrate **modulo operator** for even/odd classification.

**Your Code:**
```python
def classify_number(n):
    """
    Classify number as even or odd.
    
    Args:
        n: Integer to classify
    
    Returns:
        String: "even" or "odd"
    """
    # Your code using modulo operator:
    
    

# Test it
for num in [0, 1, 2, 7, 10, 15, 100, 999]:
    print(f"{num} is {classify_number(num)}")
```

**Bonus:** Use modulo to check divisibility by 3:
```python
def divisible_by_three(n):
    # Your code:
    
    

print(divisible_by_three(9))   # True
print(divisible_by_three(10))  # False
```

---

## Reflection Questions

**List 2 benefits of understanding truthiness when simplifying conditionals:**

1. _[Benefit 1: e.g., shorter, more readable code]_

2. _[Benefit 2: e.g., avoiding unnecessary comparisons]_

**Example transformation:**
```python
# Verbose
if len(items) > 0:
    process(items)

# Pythonic (using truthiness)
if items:
    process(items)
```

**Additional reflections:**

3. **What values are "falsy" in Python?**
   _[List them]_

4. **Why does Python have both / and // operators?**
   _[Explain the difference]_

5. **When should you use `is None` instead of `== None`?**
   _[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Understanding == vs is for equality
- Building complex boolean expressions
- Safe type conversions with error handling
- Using modulo for mathematical operations
- Leveraging Python's truthiness
Next, you'll learn about input/output basics!

<details>
<summary><strong>Answer Key</strong></summary>
### Task 1: == vs is
```python
a = [1, 2, 3]
b = [1, 2, 3]
c = a

print(a == b)  # True (same values)
print(a is b)  # False (different objects)
print(a is c)  # True (same object)

x = None
print(x is None)  # True (correct way)
print(x == None)  # True but not Pythonic
```

### Task 2: Boolean Expression
```python
def is_eligible(age, gpa, barangay):
    age_ok = 18 <= age <= 25
    gpa_ok = gpa >= 3.0
    barangay_ok = barangay in ["San Roque", "Sto. Niño", "San Jose"]
    
    return age_ok and gpa_ok and barangay_ok

print(is_eligible(20, 3.5, "San Roque"))  # True
print(is_eligible(17, 3.5, "San Roque"))  # False (age)
print(is_eligible(20, 2.8, "San Roque"))  # False (GPA)
print(is_eligible(20, 3.5, "Maligaya"))   # False (barangay)
```

### Task 3: Safe Conversion
```python
def safe_int(value, default=0):
    try:
        return int(value)
    except (ValueError, TypeError):
        return default

print(safe_int("42"))          # 42
print(safe_int("abc"))         # 0
print(safe_int("3.14"))        # 0 (not valid int)
print(safe_int(42))            # 42
print(safe_int("", default=1)) # 1
```
**Why not direct int():** Prevents crashes on invalid input, provides fallback

### Task 4: Modulo Operator
```python
def classify_number(n):
    return "even" if n % 2 == 0 else "odd"

for num in [0, 1, 2, 7, 10, 15, 100, 999]:
    print(f"{num} is {classify_number(num)}")

def divisible_by_three(n):
    return n % 3 == 0

print(divisible_by_three(9))   # True
print(divisible_by_three(10))  # False
```

### Reflection
1. **Truthiness benefits:** Shorter code, more readable
2. **Truthiness benefits:** Avoids unnecessary comparisons
3. **Falsy values:** `False`, `None`, `0`, `""`, `[]`, `{}`, `()`
4. **/ vs //:** `/` is float division (5/2=2.5), `//` is integer division (5//2=2)
5. **Use `is None`:** Checks identity, not equality; prevents overridden `__eq__` issues

</details>
