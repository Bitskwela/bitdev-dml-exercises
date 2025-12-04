# Lists, Tuples, and Dictionaries Activity

Now that you understand Python's core data structures, let's practice choosing and using the right structure for different scenarios.

## Data Structure Mastery

Each data structure has its purpose - let's practice using them effectively.

### Task 1: Tuples to Dictionary Conversion

Convert a **list of (id, name) tuples** to a dictionary for fast lookups.

**Given Data:**
```python
residents = [
    (101, "Ana Cruz"),
    (102, "Ben Reyes"),
    (103, "Carla Santos")
]
```

**Your Code:**
```python
# Convert to dictionary where ID is key, name is value
resident_dict = {}

# Your code here:



print(resident_dict)
# Expected: {101: "Ana Cruz", 102: "Ben Reyes", 103: "Carla Santos"}
```

**Why is dictionary better for lookups?**
_[Explain O(1) vs O(n) access]_

---

### Task 2: Mutable Default Argument Bug

Show code that **mistakenly mutates a shared default list** and fix it.

**Buggy Code:**
```python
def add_applicant(name, applicants=[]):
    applicants.append(name)
    return applicants

# Test it
list1 = add_applicant("Ana")
list2 = add_applicant("Ben")  # Oops! This will have both Ana and Ben
print(list1)  # What gets printed?
print(list2)  # What gets printed?
```

**What's the problem?**
_[Explain why the default list is shared]_

**Fixed Code:**
```python
def add_applicant(name, applicants=None):
    # Your fix here:
    
    
    return applicants

# Test it
list1 = add_applicant("Ana")
list2 = add_applicant("Ben")
print(list1)  # ["Ana"]
print(list2)  # ["Ben"]
```

---

### Task 3: Frequency Dictionary

Build a **frequency dict of tag counts** from a list of resident dictionaries.

**Given Data:**
```python
residents = [
    {"name": "Ana", "tags": ["PWD", "Scholar"]},
    {"name": "Ben", "tags": ["Scholar", "Athlete"]},
    {"name": "Carla", "tags": ["PWD", "Senior"]},
    {"name": "Dan", "tags": ["Scholar"]}
]
```

**Your Code:**
```python
# Build frequency dictionary: tag -> count
tag_counts = {}

# Your code here:



print(tag_counts)
# Expected: {"PWD": 2, "Scholar": 3, "Athlete": 1, "Senior": 1}
```

**Bonus:** Sort by count (most common first)

---

### Task 4: List-of-Lists to List-of-Dicts

Replace **nested list-of-lists** with **list-of-dicts** and explain the clarity gain.

**Before (Unclear):**
```python
applicants = [
    ["Ana Cruz", 18, "San Roque", "Approved"],
    ["Ben Reyes", 21, "Sto. Niño", "Pending"],
    ["Carla Santos", 19, "San Jose", "Approved"]
]

# Accessing data - what does index 2 mean?
print(applicants[0][2])  # Confusing!
```

**After (Clear):**
```python
applicants = [
    # Your dict format here:
    
    
    
]

# Accessing data - much clearer!
print(applicants[0]["barangay"])  # Self-documenting!
```

**Why is this better?**

1. _[Reason 1]_
2. _[Reason 2]_
3. _[Reason 3]_

---

## Reflection Questions

1. **When will you deliberately choose a tuple over a list? List two reasons:**
   
   Reason 1: _[e.g., data shouldn't change]_
   
   Reason 2: _[e.g., use as dictionary key]_

2. **When would you use a dictionary instead of a list?**
   
   _[Your answer]_

3. **What's the main advantage of dictionaries for large datasets?**
   
   _[Hint: think about lookup speed]_

---

## What You've Learned

Through this activity, you've practiced:
- Converting between data structures
- Understanding mutable default arguments
- Building frequency dictionaries
- Choosing clear, self-documenting structures
- Recognizing when to use tuples vs lists vs dicts
Next, you'll learn about functions and how to organize your code!

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: List-of-Tuples to Dictionary
```python
applicants = [
    (1, "Ana Cruz", 20),
    (2, "Ben Reyes", 22),
    (3, "Carla Santos", 19)
]

applicants_dict = {
    id: {"name": name, "age": age}
    for id, name, age in applicants
}

print(applicants_dict[2])  # {'name': 'Ben Reyes', 'age': 22}
```

### Task 2: Mutable Default Bug

**Buggy:**
```python
def add_tag(resident_id, tag, tags=[]):  # ❌ Shared list!
    tags.append(tag)
    return tags

r1_tags = add_tag(101, "PWD")
r2_tags = add_tag(102, "Senior")
print(r1_tags)  # ['PWD', 'Senior'] ← WRONG!
```

**Fixed:**
```python
def add_tag(resident_id, tag, tags=None):
    if tags is None:
        tags = []  # New list each call
    tags.append(tag)
    return tags

r1_tags = add_tag(101, "PWD")
r2_tags = add_tag(102, "Senior")
print(r1_tags)  # ['PWD'] ✓
print(r2_tags)  # ['Senior'] ✓
```

### Task 3: Frequency Dictionary
```python
tags = ["PWD", "Scholar", "Athlete", "Scholar", "Senior", "PWD", "Scholar"]

tag_counts = {}
for tag in tags:
    tag_counts[tag] = tag_counts.get(tag, 0) + 1

print(tag_counts)
# {'PWD': 2, 'Scholar': 3, 'Athlete': 1, 'Senior': 1}

# Sorted by count
sorted_tags = sorted(tag_counts.items(), key=lambda x: x[1], reverse=True)
print(sorted_tags)  # [('Scholar', 3), ('PWD', 2), ...]

# Using Counter
from collections import Counter
tag_counts = Counter(tags)
print(tag_counts.most_common(2))  # [('Scholar', 3), ('PWD', 2)]
```

### Task 4: List-of-Dicts
```python
applicants = [
    {"name": "Ana Cruz", "age": 18, "barangay": "San Roque", "status": "Approved"},
    {"name": "Ben Reyes", "age": 21, "barangay": "Sto. Niño", "status": "Pending"},
    {"name": "Carla Santos", "age": 19, "barangay": "San Jose", "status": "Approved"}
]

print(applicants[0]["barangay"])  # "San Roque" - Clear!
```

**Why better:**
1. Self-documenting (keys explain meaning)
2. Order-independent (can add/remove fields)
3. Prevents index errors (KeyError more helpful than IndexError)

### Reflection Answers
1. **Choose tuple when:**
   - Data shouldn't change (immutable protection)
   - Use as dictionary key (tuples hashable, lists not)
2. **Use dict when:** Need fast lookups by key (O(1) instead of O(n) for list search)
3. **Dict advantage:** Constant-time lookups regardless of size

</details>
