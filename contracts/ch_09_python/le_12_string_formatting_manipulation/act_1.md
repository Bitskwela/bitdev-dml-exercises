# String Formatting and Manipulation Activity

Now that you understand string operations, let's practice formatting and manipulating text data.

## String Mastery Challenge

Professional applications require clean, well-formatted text output.

### Task 1: Float Formatting

Format a **float to 3 decimal places**.

**Your Code:**
```python
def format_gpa(gpa):
    """
    Format GPA to exactly 3 decimal places.
    
    Args:
        gpa: Float GPA value
    
    Returns:
        Formatted string
    """
    # Your f-string with formatting:
    return f"{gpa:.3f}"

# Test cases
test_gpas = [3.5, 3.14159, 4.0, 2.7777777]
for gpa in test_gpas:
    formatted = format_gpa(gpa)
    print(f"GPA {gpa} -> {formatted}")
```

**Bonus:** Format as percentage:
```python
def format_percentage(value):
    # Format as percentage with 1 decimal: 0.856 -> "85.6%"
    return

print(format_percentage(0.856))  # "85.6%"
print(format_percentage(0.5))    # "50.0%"
```

---

### Task 2: Zero-Padding IDs

**Pad resident ID** to 6 digits with leading zeros.

**Your Code:**
```python
def format_resident_id(id_number):
    """
    Format resident ID with zero-padding.
    
    Args:
        id_number: Integer or string ID
    
    Returns:
        6-digit zero-padded string
    """
    # Your code using zfill() or format specifier:
    return str(id_number).zfill(6)

# Test cases
test_ids = [42, 1, 9999, 123, 100000]
for id_num in test_ids:
    formatted = format_resident_id(id_num)
    print(f"ID {id_num} -> {formatted}")
```

---

### Task 3: Title Case Names

**Title-case** a mixed-case name properly.

**Your Code:**
```python
def normalize_name(name):
    """
    Normalize name to title case.
    
    Args:
        name: Name string (any case)
    
    Returns:
        Title-cased name
    """
    # Your code using .title() or .capitalize():
    return name.title()

# Test cases
test_names = [
    "JUAN DELA CRUZ",
    "maria santos",
    "Ana REYES",
    "beN lIM"
]

for name in test_names:
    normalized = normalize_name(name)
    print(f"{name:20s} -> {normalized}")
```

---

### Task 4: CSV Parsing

**Split CSV line** and strip spaces from each field.

**Your Code:**
```python
def parse_csv_line(line):
    """
    Parse CSV line into clean fields.
    
    Args:
        line: CSV string with comma-separated values
    
    Returns:
        List of stripped field values
    """
    # Your code:
    # Split by comma
    # Strip whitespace from each field
    fields = line.split(',')
    return [field.strip() for field in fields]

# Test cases
test_lines = [
    "Ana Cruz,  18,  San Roque",
    "Ben Reyes  ,21,Sto. Niño  ",
    "  Carla Santos  ,  19  ,  San Jose  "
]

for line in test_lines:
    fields = parse_csv_line(line)
    print(f"Parsed: {fields}")
```

**Bonus:** Build dict from headers and values:
```python
def csv_to_dict(headers, values):
    """
    Convert CSV headers and values to dictionary.
    """
    # Your code using zip:
    headers = [h.strip() for h in headers]
    return dict(zip(headers, values))

headers = "name,age,barangay"
values = "Ana Cruz, 18, San Roque"

result = csv_to_dict(headers.split(','), parse_csv_line(values))
print(result)
```

---

## Reflection Questions

**Two advantages of f-strings over concatenation:**

1. _[Advantage 1: e.g., more readable, expressions inline]_

2. _[Advantage 2: e.g., automatic type conversion, formatting options]_

**Example comparison:**
```python
# Concatenation (ugly)
msg = "Resident " + name + " (ID: " + str(id) + ") is " + str(age) + " years old"

# F-string (clean)
msg = f"Resident {name} (ID: {id}) is {age} years old"
```

**Additional reflections:**

3. **When should you use .strip() vs .rstrip() vs .lstrip()?**
   _[Your answer]_

4. **What's the difference between .split() and .split(',')?**
   _[Your answer]_

5. **Why is string formatting important for professional applications?**
   _[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Formatting floats with specific precision
- Formatting numbers with zero-padding for consistent IDs
- Normalizing names with title case
- Parsing and cleaning CSV data
- Using f-strings for readable formatting

Next, you'll learn introduction to quantitative methods!

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: Float Formatting
```python
def format_gpa(gpa):
    return f"{gpa:.2f}"

gpas = [3.5, 3.14159, 2.9, 4.0]
for gpa in gpas:
    print(f"GPA: {format_gpa(gpa)}")

# With currency
def format_amount(amount):
    return f"₱{amount:,.2f}"

amounts = [5000, 10000.5, 15750.75]
for amt in amounts:
    print(format_amount(amt))
# Output: ₱5,000.00, ₱10,000.50, ₱15,750.75
```

### Task 2: Zero-Padding
```python
def format_id(resident_id):
    return f"BR-{resident_id:05d}"

for rid in [1, 42, 999, 12345]:
    print(format_id(rid))
# Output: BR-00001, BR-00042, BR-00999, BR-12345
```

### Task 3: Title Case
```python
def normalize_name(name):
    return name.title()

test_names = [
    "JUAN DELA CRUZ",
    "maria santos",
    "Ana REYES",
    "beN lIM"
]

for name in test_names:
    print(f"{name:20s} -> {normalize_name(name)}")
```

### Task 4: CSV Parsing
```python
def parse_csv_line(line):
    return [field.strip() for field in line.split(',')]

test_lines = [
    "Ana Cruz,  18,  San Roque",
    "Ben Reyes  ,21,Sto. Niño  ",
    "  Carla Santos  ,  19  ,  San Jose  "
]

for line in test_lines:
    fields = parse_csv_line(line)
    print(f"Parsed: {fields}")

# Bonus: CSV to dict
def csv_to_dict(headers, values):
    return dict(zip(headers, values))

headers = "name,age,barangay".split(',')
values = parse_csv_line("Ana Cruz, 18, San Roque")

result = csv_to_dict(headers, values)
print(result)  # {'name': 'Ana Cruz', 'age': '18', 'barangay': 'San Roque'}
```

### Reflection
1. **F-strings advantages:** Readable, inline expressions, auto-conversion
2. **F-strings advantages:** Built-in formatting options
3. **strip() vs rstrip() vs lstrip():** Both ends, right end only, left end only
4. **.split() vs .split(','):** Whitespace (any) vs specific delimiter
5. **Formatting important:** Professional appearance, consistency, user trust

</details>
