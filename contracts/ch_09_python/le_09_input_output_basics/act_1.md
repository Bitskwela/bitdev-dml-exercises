# Input/Output Basics Activity

Now that you understand I/O operations, let's practice reading user input and working with files.

## Interactive Program Challenge

Real programs interact with users and persist data to files.

### Task 1: Collect Multiple Inputs

Prompt for **three tags** and store them in a list.

**Your Code:**
```python
def collect_tags():
    """
    Prompt user for three tags and return as list.
    
    Returns:
        List of three tag strings
    """
    tags = []
    
    # Your code here:
    # Prompt user three times
    # Store each tag in the list
    # Strip whitespace
    # Handle empty inputs
    
    
    
    
    
    return tags

# Test it
if __name__ == "__main__":
    resident_tags = collect_tags()
    print(f"\nYou entered: {resident_tags}")
```

**Sample Run:**
```
Enter tag 1: PWD
Enter tag 2: Scholar
Enter tag 3: Athlete

You entered: ['PWD', 'Scholar', 'Athlete']
```

---

### Task 2: Validate and Write to File

Write **validated ages** to a file.

**Your Code:**
```python
def save_ages_to_file(ages, filename="ages.txt"):
    """
    Write validated ages to file.
    
    Args:
        ages: List of age values (might need validation)
        filename: Output file name
    """
    validated_ages = []
    
    # Your code here:
    # Validate each age (must be positive integer, 0-120)
    # Write valid ages to file (one per line)
    # Use 'with' statement
    # Handle errors
    
    
    
    
    

# Test it
test_ages = [18, 21, -5, 150, 19, "invalid", 25, 0]
save_ages_to_file(test_ages)
print("Ages saved to ages.txt")

# Check the file:
with open("ages.txt") as f:
    print(f"\nFile contents:\n{f.read()}")
```

**Expected Output File:**
```
18
21
19
25
```

---

### Task 3: Read File Lines

Read **file lines into a list**, stripping whitespace.

**Your Code:**
```python
def read_names_from_file(filename):
    """
    Read names from file, one per line.
    
    Args:
        filename: Path to file
    
    Returns:
        List of names (whitespace stripped)
    """
    names = []
    
    # Your code here:
    # Open file with 'with' statement
    # Read all lines
    # Strip whitespace from each line
    # Skip empty lines
    
    
    
    
    
    return names

# Create test file first
with open("names.txt", "w") as f:
    f.write("  Ana Cruz  \n")
    f.write("Ben Reyes\n")
    f.write("  \n")  # Empty line
    f.write("Carla Santos  \n")

# Test your function
names = read_names_from_file("names.txt")
print(f"Names read: {names}")
# Expected: ['Ana Cruz', 'Ben Reyes', 'Carla Santos']
```

---

### Task 4: Formatted Table Output

Show **formatted column output** for 3 residents.

**Your Code:**
```python
def display_residents(residents):
    """
    Display residents in formatted table.
    
    Args:
        residents: List of (name, age, barangay) tuples
    """
    # Your code here:
    # Print header with column names
    # Print separator line
    # Print each resident with proper alignment
    # Use f-string formatting for columns
    
    
    
    
    

# Test data
residents = [
    ("Ana Cruz", 18, "San Roque"),
    ("Ben Reyes", 21, "Sto. Niño"),
    ("Carla Santos", 19, "San Jose")
]

display_residents(residents)
```

**Expected Output:**
```
Name                 Age  Barangay
----------------------------------------
Ana Cruz              18  San Roque
Ben Reyes             21  Sto. Niño
Carla Santos          19  San Jose
```

**Hint:** Use format specifiers:
- `{:<20}` for left-aligned, width 20
- `{:>3}` for right-aligned, width 3

---

## Reflection Questions

**Two reasons to use `with` for file operations:**

1. _[Reason 1: e.g., automatic file closing even if exception occurs]_

2. _[Reason 2: e.g., cleaner, more readable code]_

**Additional reflections:**

3. **What happens if you forget to close a file?**
   _[Your answer]_

4. **Why validate user input before using it?**
   _[Your answer]_

5. **When should you use encoding="utf-8" when opening files?**
   _[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Collecting and validating user input
- Writing data to files safely
- Reading files and processing lines
- Formatting output for readability
- Using context managers (with statement)
Next, you'll learn about conditionals and control flow!

<details>
<summary><strong>Answer Key</strong></summary>
### Task 1: Collect and Validate Input
```python
def collect_applicant_info():
    name = input("Enter name: ").strip()
    
    while True:
        try:
            age = int(input("Enter age (16-25): "))
            if 16 <= age <= 25:
                break
            print("Age must be between 16 and 25")
        except ValueError:
            print("Please enter a valid number")
    
    barangay = input("Enter barangay: ").strip()
    
    return {"name": name, "age": age, "barangay": barangay}

applicant = collect_applicant_info()
print(f"Collected: {applicant}")
```

### Task 2: Write to File
```python
def save_ages_to_file(applicants, filename="ages.txt"):
    with open(filename, "w") as f:
        for applicant in applicants:
            f.write(str(applicant["age"]) + "\n")

applicants = [
    {"name": "Ana", "age": 18},
    {"name": "Ben", "age": 21},
    {"name": "Carla", "age": 19}
]

save_ages_to_file(applicants)
```

### Task 3: Read File Lines
```python
def read_names_from_file(filename):
    names = []
    
    with open(filename, "r") as f:
        for line in f:
            line = line.strip()
            if line:  # Skip empty lines
                names.append(line)
    
    return names

with open("names.txt", "w") as f:
    f.write("  Ana Cruz  \n")
    f.write("Ben Reyes\n")
    f.write("  \n")
    f.write("Carla Santos  \n")

names = read_names_from_file("names.txt")
print(f"Names: {names}")  # ['Ana Cruz', 'Ben Reyes', 'Carla Santos']
```

### Task 4: Formatted Table Output
```python
def display_residents(residents):
    print(f"{'Name':<20} {'Age':>3}  {'Barangay':<15}")
    print("-" * 45)
    
    for name, age, barangay in residents:
        print(f"{name:<20} {age:>3}  {barangay:<15}")

residents = [
    ("Ana Cruz", 18, "San Roque"),
    ("Ben Reyes", 21, "Sto. Niño"),
    ("Carla Santos", 19, "San Jose")
]

display_residents(residents)
```

### Reflection
1. **Use `with`:** Auto-closes file, even on exception; cleaner code
2. **Use `with`:** No manual close() needed
3. **Forget to close:** Resource leak, file locked, data may not flush
4. **Validate input:** Prevent errors, ensure data quality, security
5. **Use utf-8:** Support international characters (ñ, é, Chinese, etc.)

</details>
