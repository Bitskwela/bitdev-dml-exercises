# Loops Activity

Now that you understand loops, let's practice iterating efficiently with `for` and `while`.

## Iteration Mastery Challenge

Loops let computers do repetitive work that would be tedious for humans.

### Task 1: Sum with for/range

Sum numbers **1-100** using for loop and range.

**Your Code:**
```python
def sum_to_hundred():
    """
    Calculate sum of numbers from 1 to 100.
    
    Returns:
        Integer sum
    """
    total = 0
    
    # Your for loop here:
    for i in range(1, 101):
        total += i
    
    return total

result = sum_to_hundred()
print(f"Sum of 1-100: {result}")
```

**Verify:** The formula is n*(n+1)/2, so 100*101/2 = 5050

**Bonus:** Make it work for any number:
```python
def sum_to_n(n):
    # Your code:
    
    
    

print(sum_to_n(10))   # 55
print(sum_to_n(1000)) # 500500
```

---

### Task 2: while Loop with break

Find **first even number > 50** using while loop and break.

**Your Code:**
```python
def find_first_even_after(threshold):
    """
    Find first even number greater than threshold.
    
    Args:
        threshold: Starting number
    
    Returns:
        First even number after threshold
    """
    number = threshold + 1
    
    # Your while loop here:
    # Keep checking numbers
    # Break when you find an even one
    while True:
        if number % 2 == 0:
            break
        number += 1
    
    return number

result = find_first_even_after(50)
print(f"First even number after 50: {result}")

# Test with odd and even thresholds
print(find_first_even_after(51))  # 52
print(find_first_even_after(52))  # 54
```

---

### Task 3: enumerate for Line Numbers

Use **enumerate()** to add line numbers to text.

**Your Code:**
```python
def number_lines(text_lines):
    """
    Add line numbers to each line.
    
    Args:
        text_lines: List of strings
    
    Returns:
        List of numbered lines
    """
    numbered = []
    
    # Your code using enumerate:
    # Start numbering from 1
    # Format as "1. First line"
    for index, line in enumerate(text_lines, start=1):
        numbered.append(f"{index}. {line}")
    
    return numbered

# Test it
poem = [
    "Roses are red",
    "Violets are blue",
    "Python is awesome",
    "And so are you"
]

for line in number_lines(poem):
    print(line)
```

---

### Task 4: zip Two Lists into Dict

**Zip two lists** and build a dictionary.

**Your Code:**
```python
def create_resident_dict(ids, names):
    """
    Create dictionary mapping IDs to names.
    
    Args:
        ids: List of resident IDs
        names: List of resident names
    
    Returns:
        Dictionary {id: name}
    """
    # Your code using zip:
    return dict(zip(ids, names))

# Test data
ids = [101, 102, 103, 104]
names = ["Ana Cruz", "Ben Reyes", "Carla Santos", "Dan Lim"]

resident_dict = create_resident_dict(ids, names)
print(resident_dict)

# Lookup example
print(f"Resident 102: {resident_dict[102]}")
```

**Bonus:** Zip three lists:
```python
def create_full_records(ids, names, ages):
    """
    Create list of (id, name, age) tuples.
    """
    # Your code:
    return list(zip(ids, names, ages))

ids = [101, 102, 103]
names = ["Ana", "Ben", "Carla"]
ages = [18, 21, 19]

records = create_full_records(ids, names, ages)
print(records)
```

---

## Reflection Questions

**When to choose `for` vs `while`? Give two criteria:**

**Use `for` when:**
1. _[Criterion 1: e.g., you know how many iterations]_
2. _[Criterion 2: e.g., iterating over a collection]_

**Use `while` when:**
1. _[Criterion 1: e.g., waiting for a condition]_
2. _[Criterion 2: e.g., unknown number of iterations]_

**Additional reflections:**

3. **What's the danger of forgetting to update the loop variable in a while loop?**
   _[Your answer: infinite loop]_

4. **When should you use `break` vs just ending the loop normally?**
   _[Your answer]_

5. **What's the benefit of `enumerate()` over manual counter?**
   _[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Using for loops with range()
- Using while loops with break
- Using enumerate() for indexed iteration
- Using zip() to combine lists
- Choosing the right loop type
Next, you'll learn string formatting and manipulation!

<details>
<summary><strong>Answer Key</strong></summary>
### Task 1: for loop with range
```python
def sum_ages(ages):
    total = 0
    for i in range(len(ages)):
        total += ages[i]
    return total

ages = [18, 21, 19, 22, 20]
print(f"Total: {sum_ages(ages)}")  # 100
print(f"Average: {sum_ages(ages) / len(ages):.1f}")  # 20.0

# Better (Pythonic):
def sum_ages_pythonic(ages):
    return sum(ages)
```

### Task 2: while loop with break
```python
def collect_applications():
    applications = []
    
    while True:
        name = input("Enter applicant name (or 'done' to finish): ").strip()
        
        if name.lower() == 'done':
            break
        
        if not name:
            print("Name cannot be empty")
            continue
        
        applications.append(name)
        print(f"Added {name}. Total: {len(applications)}")
    
    return applications

apps = collect_applications()
print(f"\nCollected {len(apps)} applications: {apps}")
```

### Task 3: enumerate
```python
def number_lines(text_lines):
    numbered = []
    
    for index, line in enumerate(text_lines, start=1):
        numbered.append(f"{index}. {line}")
    
    return numbered

poem = [
    "Roses are red",
    "Violets are blue",
    "Python is awesome",
    "And so are you"
]

for line in number_lines(poem):
    print(line)
```

### Task 4: zip
```python
def create_resident_dict(ids, names):
    return dict(zip(ids, names))

ids = [101, 102, 103, 104]
names = ["Ana Cruz", "Ben Reyes", "Carla Santos", "Dan Lim"]

resident_dict = create_resident_dict(ids, names)
print(resident_dict)
print(f"Resident 102: {resident_dict[102]}")

# Bonus: Three lists
def create_full_records(ids, names, ages):
    return list(zip(ids, names, ages))

ids = [101, 102, 103]
names = ["Ana", "Ben", "Carla"]
ages = [18, 21, 19]

records = create_full_records(ids, names, ages)
print(records)  # [(101, 'Ana', 18), ...]
```

### Reflection
**Use `for` when:** Know iteration count, iterating collection
**Use `while` when:** Waiting for condition, unknown iterations (user input)
**Danger:** Infinite loop if condition never becomes false
**Use `break`:** Exit early based on condition (search, validation)
**`enumerate()` benefit:** Cleaner than manual counter, Pythonic

</details>
