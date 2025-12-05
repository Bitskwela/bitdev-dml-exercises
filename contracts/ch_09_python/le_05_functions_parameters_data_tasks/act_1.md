# Functions and Parameters Activity

Now that you understand functions, let's practice writing clean, reusable, and maintainable code.

## Function Design Challenge

Good functions are the building blocks of maintainable code. Let's practice writing them properly.

### Task 1: Pure Function - Median Calculator

Write a **pure function** that computes the median of a list of numbers.

**Requirements:**
- No side effects (don't modify the input list)
- Return the median value
- Handle both odd and even length lists
- Handle empty lists gracefully

**Your Code:**
```python
def calculate_median(numbers):
    """
    Calculate median of a list of numbers.
    
    Args:
        numbers: List of numeric values
    
    Returns:
        The median value, or None if list is empty
    """
    # Your code here:
    if not numbers:
        return None
    sorted_nums = sorted(numbers)
    n = len(sorted_nums)
    mid = n // 2
    if n % 2 == 0:
        return (sorted_nums[mid - 1] + sorted_nums[mid]) / 2
    else:
        return sorted_nums[mid]

# Test cases
print(calculate_median([1, 2, 3, 4, 5]))
print(calculate_median([1, 2, 3, 4]))
print(calculate_median([]))
print(calculate_median([42]))
```

**Why is this a "pure" function?**
_[Explain: same input always gives same output, no side effects]_

---

### Task 2: Refactor Global-Modifying Function

Convert a **global-modifying function** to return a new value instead.

**Before (Impure - BAD):**
```python
total_applicants = 0

def add_applicant():
    global total_applicants
    total_applicants += 1
    # Problems: hard to test, hidden dependencies, not thread-safe
```

**After (Pure - GOOD):**
```python
def add_applicant(current_count):
    # Your refactored code here:
    return current_count + 1

# Usage:
total = 0
total = add_applicant(total)
total = add_applicant(total)
```

**Why is this better?**

1. _[Benefit 1]_
2. _[Benefit 2]_
3. _[Benefit 3]_

---

### Task 3: Variable Arguments (*args)

Show an example using `*args` to collect resident IDs.

**Your Code:**
```python
def log_resident_access(*resident_ids):
    """
    Log access to multiple resident records.
    
    Args:
        *resident_ids: Variable number of resident ID integers
    """
    # Your code here - print a log message for each ID
    print(f"Accessing {len(resident_ids)} resident records:")
    for rid in resident_ids:
        print(f"  - Resident {rid}")

# Test it - should accept any number of arguments
log_resident_access(101)
log_resident_access(101, 102, 103)
log_resident_access(101, 102, 103, 104, 105)
```

**When would you use *args?**
_[Explain scenarios where you don't know how many arguments ahead of time]_

---

### Task 4: Keyword Arguments (**kwargs)

Use `**kwargs` for flexible metadata logging.

**Your Code:**
```python
def log_event(event_type, **metadata):
    """
    Log an event with flexible metadata.
    
    Args:
        event_type: Type of event (string)
        **metadata: Any additional key-value pairs
    """
    # Your code here - print event type and all metadata
    print(f"Event: {event_type}")
    for key, value in metadata.items():
        print(f"  {key}: {value}")

# Test with different metadata
log_event("application_submitted", 
          applicant_id=101, 
          barangay="San Roque",
          timestamp="2025-01-15")

log_event("approval_granted",
          applicant_id=102,
          amount=5000,
          program="College Scholarship")
```

**When would you use **kwargs?**
_[Explain flexibility for optional parameters]_

---

## Reflection Questions

1. **List two benefits of pure function design in collaborative projects:**
   
   Benefit 1: _[e.g., easier to test in isolation]_
   
   Benefit 2: _[e.g., no hidden dependencies]_

2. **Why are functions with many parameters hard to use?**
   
   _[Your answer]_

3. **What makes a function "reusable"?**
   
   _[Your answer]_

4. **When should you split a large function into smaller ones?**
   
   _[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Writing pure functions without side effects
- Refactoring global state to return values
- Using *args for variable positional arguments
- Using **kwargs for flexible keyword arguments
- Understanding function design principles
Next, you'll learn error handling and debugging techniques!

<details>
<summary><strong>Answer Key</strong></summary>
### Task 1: Pure Function

**Impure (bad):**
```python
total = 0
def count_applicant():
    global total  # Side effect
    total += 1
```

**Pure (good):**
```python
def is_eligible(applicant, min_age=18, max_age=25, min_gpa=3.0):
    """Pure: same input → same output, no side effects"""
    age_ok = min_age <= applicant["age"] <= max_age
    gpa_ok = applicant["gpa"] >= min_gpa
    return age_ok and gpa_ok

applicant = {"age": 20, "gpa": 3.5}
print(is_eligible(applicant))  # True (predictable!)
```

### Task 2: Refactor Global

**Before (bad):**
```python
count = 0
def submit():
    global count
    count += 1
```

**After (good):**
```python
class ApplicationTracker:
    def __init__(self):
        self.applications = []
    
    def submit(self, app):
        self.applications.append(app)
        return len(self.applications)
    
    def get_count(self):
        return len(self.applications)

tracker = ApplicationTracker()
tracker.submit({"name": "Ana"})
print(tracker.get_count())  # 1
```

### Task 3: *args
```python
def log_resident_access(*resident_ids):
    """Log access for any number of residents"""
    print(f"Accessing {len(resident_ids)} resident records:")
    for rid in resident_ids:
        print(f"  - Resident {rid}")

log_resident_access(101)
log_resident_access(101, 102, 103)
log_resident_access(101, 102, 103, 104, 105)
```
**Use *args when:** You don't know how many arguments will be passed

### Task 4: **kwargs
```python
def log_event(event_type, **metadata):
    """Log event with flexible metadata"""
    print(f"Event: {event_type}")
    for key, value in metadata.items():
        print(f"  {key}: {value}")

log_event("application_submitted",
          applicant_id=101,
          barangay="San Roque",
          timestamp="2025-01-15")

log_event("approval_granted",
          applicant_id=102,
          amount=5000)
```
**Use **kwargs when:** You want flexible optional parameters

### Reflection Answers
1. **Pure function benefits:**
   - Easier to test (no setup needed)
   - No hidden dependencies (explicit inputs)
2. **Many parameters hard:** Difficult to remember order, easy to make mistakes
3. **Reusable function:** No hardcoded values, accepts parameters, single responsibility
4. **Split when:** Function does multiple things, hard to name, or > 20 lines

</details>
