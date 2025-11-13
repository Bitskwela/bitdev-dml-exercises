# Lesson 10: File Handling

## Background Story

"Kuya, everything I've created disappears when my program closes!" Tian complained. "How do I save data like grades, contact lists, or inventory?"

"That's where **file handling** comes in!" Kuya Miguel explained. "Python lets you read from and write to files - saving data permanently. You can store lists, records, even entire databases in files!"

## Why File Handling?

**Benefits:**
- **Persistence:** Data survives after program ends
- **Data sharing:** Exchange data between programs
- **Storage:** Keep records, logs, configurations
- **Backup:** Save important information

**Common uses:**
- Save game progress
- Store user data
- Log events
- Export reports
- Import data

## Opening Files

### The `open()` Function

**Syntax:** `file = open(filename, mode)`

**Modes:**
- `'r'` - Read (default) - file must exist
- `'w'` - Write - creates new file or overwrites
- `'a'` - Append - adds to end of file
- `'x'` - Exclusive creation - fails if file exists
- `'r+'` - Read and write
- `'b'` - Binary mode (e.g., `'rb'`, `'wb'`)

**Examples:**
```python
# Read mode
file = open("data.txt", "r")

# Write mode
file = open("output.txt", "w")

# Append mode
file = open("log.txt", "a")
```

**Important:** Always close files after use!
```python
file = open("data.txt", "r")
# ... do something ...
file.close()  # Don't forget!
```

## The `with` Statement (Best Practice)

**Automatically closes file, even if error occurs:**

```python
with open("data.txt", "r") as file:
    content = file.read()
    # File automatically closed after this block
```

**Why better:**
- Automatic cleanup
- Handles errors gracefully
- Cleaner code

## Reading Files

### `read()` - Read Entire File

```python
with open("story.txt", "r") as file:
    content = file.read()
    print(content)
```

**Specify number of characters:**
```python
with open("story.txt", "r") as file:
    first_10 = file.read(10)  # Read first 10 characters
    print(first_10)
```

### `readline()` - Read One Line

```python
with open("data.txt", "r") as file:
    line1 = file.readline()
    line2 = file.readline()
    print(line1)
    print(line2)
```

### `readlines()` - Read All Lines as List

```python
with open("data.txt", "r") as file:
    lines = file.readlines()
    for line in lines:
        print(line.strip())  # strip() removes newline
```

### Loop Through Lines (Memory Efficient)

```python
with open("data.txt", "r") as file:
    for line in file:
        print(line.strip())
```

**Best for large files - reads one line at a time.**

## Writing Files

### `write()` - Write String

```python
with open("output.txt", "w") as file:
    file.write("Hello, World!\n")
    file.write("This is a new line.\n")
```

**Note:** `write()` doesn't add newlines automatically - use `\n`!

### `writelines()` - Write List of Strings

```python
lines = [
    "First line\n",
    "Second line\n",
    "Third line\n"
]

with open("output.txt", "w") as file:
    file.writelines(lines)
```

### Append Mode

```python
# This adds to existing file
with open("log.txt", "a") as file:
    file.write("New log entry\n")
```

## Checking File Existence

```python
import os

if os.path.exists("data.txt"):
    print("File exists")
else:
    print("File not found")
```

## File Paths

### Absolute Path
```python
# Windows
file = open("C:\\Users\\Tian\\Documents\\data.txt", "r")

# Mac/Linux
file = open("/home/tian/documents/data.txt", "r")
```

### Relative Path
```python
# Same directory
file = open("data.txt", "r")

# Subdirectory
file = open("data/students.txt", "r")

# Parent directory
file = open("../config.txt", "r")
```

**Use raw strings for Windows paths:**
```python
file = open(r"C:\Users\Tian\data.txt", "r")
```

## Working with CSV Files

**CSV = Comma-Separated Values - common data format**

### Reading CSV (Manual)

**data.csv:**
```
Name,Age,Grade
Tian,16,85
Juan,17,90
Maria,16,88
```

```python
with open("data.csv", "r") as file:
    lines = file.readlines()
    
    # Skip header
    for line in lines[1:]:
        parts = line.strip().split(",")
        name, age, grade = parts
        print(f"{name}: {age} years old, grade {grade}")
```

### Writing CSV (Manual)

```python
students = [
    ["Name", "Age", "Grade"],
    ["Tian", "16", "85"],
    ["Juan", "17", "90"],
    ["Maria", "16", "88"]
]

with open("output.csv", "w") as file:
    for row in students:
        line = ",".join(row) + "\n"
        file.write(line)
```

### Using `csv` Module (Better)

**Reading:**
```python
import csv

with open("data.csv", "r") as file:
    reader = csv.reader(file)
    next(reader)  # Skip header
    
    for row in reader:
        name, age, grade = row
        print(f"{name}: {age} years old, grade {grade}")
```

**Writing:**
```python
import csv

students = [
    ["Name", "Age", "Grade"],
    ["Tian", 16, 85],
    ["Juan", 17, 90],
    ["Maria", 16, 88]
]

with open("output.csv", "w", newline="") as file:
    writer = csv.writer(file)
    writer.writerows(students)
```

**DictReader and DictWriter:**
```python
import csv

# Reading as dictionaries
with open("data.csv", "r") as file:
    reader = csv.DictReader(file)
    for row in reader:
        print(f"{row['Name']}: {row['Age']} years old")

# Writing dictionaries
students = [
    {"Name": "Tian", "Age": 16, "Grade": 85},
    {"Name": "Juan", "Age": 17, "Grade": 90}
]

with open("output.csv", "w", newline="") as file:
    fieldnames = ["Name", "Age", "Grade"]
    writer = csv.DictWriter(file, fieldnames=fieldnames)
    
    writer.writeheader()
    writer.writerows(students)
```

## Practical Examples

### Example 1: Student Grade Manager

```python
import os

FILENAME = "grades.txt"

def load_grades():
    """Load grades from file."""
    grades = {}
    
    if os.path.exists(FILENAME):
        with open(FILENAME, "r") as file:
            for line in file:
                parts = line.strip().split(",")
                if len(parts) == 2:
                    name, grade = parts
                    grades[name] = float(grade)
    
    return grades

def save_grades(grades):
    """Save grades to file."""
    with open(FILENAME, "w") as file:
        for name, grade in grades.items():
            file.write(f"{name},{grade}\n")

def add_grade(grades):
    """Add student grade."""
    name = input("Student name: ")
    grade = float(input("Grade: "))
    grades[name] = grade
    print(f"Added {name} with grade {grade}")

def view_grades(grades):
    """Display all grades."""
    if not grades:
        print("No grades recorded")
        return
    
    print("\n=== Student Grades ===")
    for name, grade in sorted(grades.items()):
        print(f"{name}: {grade:.2f}")
    
    average = sum(grades.values()) / len(grades)
    print(f"\nClass average: {average:.2f}")

# Main program
grades = load_grades()

while True:
    print("\n1. Add grade")
    print("2. View grades")
    print("3. Save and exit")
    
    choice = input("\nChoice: ")
    
    if choice == "1":
        add_grade(grades)
    elif choice == "2":
        view_grades(grades)
    elif choice == "3":
        save_grades(grades)
        print("Grades saved!")
        break
```

### Example 2: Contact Book with File Storage

```python
import csv

FILENAME = "contacts.csv"

def load_contacts():
    """Load contacts from CSV."""
    contacts = {}
    
    try:
        with open(FILENAME, "r") as file:
            reader = csv.DictReader(file)
            for row in reader:
                contacts[row["Name"]] = {
                    "phone": row["Phone"],
                    "email": row["Email"]
                }
    except FileNotFoundError:
        pass
    
    return contacts

def save_contacts(contacts):
    """Save contacts to CSV."""
    with open(FILENAME, "w", newline="") as file:
        fieldnames = ["Name", "Phone", "Email"]
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        
        writer.writeheader()
        for name, info in contacts.items():
            writer.writerow({
                "Name": name,
                "Phone": info["phone"],
                "Email": info["email"]
            })

def add_contact(contacts):
    """Add new contact."""
    name = input("Name: ")
    phone = input("Phone: ")
    email = input("Email (optional): ")
    
    contacts[name] = {"phone": phone, "email": email}
    print(f"Added {name}")

def list_contacts(contacts):
    """Display all contacts."""
    if not contacts:
        print("No contacts")
        return
    
    print("\n=== Contact Book ===")
    for name, info in sorted(contacts.items()):
        print(f"{name}: {info['phone']}")
        if info['email']:
            print(f"  Email: {info['email']}")

# Main program
contacts = load_contacts()

while True:
    print("\n1. Add contact")
    print("2. List contacts")
    print("3. Save and exit")
    
    choice = input("\nChoice: ")
    
    if choice == "1":
        add_contact(contacts)
    elif choice == "2":
        list_contacts(contacts)
    elif choice == "3":
        save_contacts(contacts)
        print("Contacts saved!")
        break
```

### Example 3: Sari-Sari Store Inventory System

```python
import csv
import os

FILENAME = "inventory.csv"

def load_inventory():
    """Load inventory from CSV."""
    inventory = {}
    
    if os.path.exists(FILENAME):
        with open(FILENAME, "r") as file:
            reader = csv.DictReader(file)
            for row in reader:
                inventory[row["Product"]] = {
                    "price": float(row["Price"]),
                    "stock": int(row["Stock"])
                }
    
    return inventory

def save_inventory(inventory):
    """Save inventory to CSV."""
    with open(FILENAME, "w", newline="") as file:
        fieldnames = ["Product", "Price", "Stock"]
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        
        writer.writeheader()
        for product, details in inventory.items():
            writer.writerow({
                "Product": product,
                "Price": details["price"],
                "Stock": details["stock"]
            })

def display_inventory(inventory):
    """Display inventory."""
    print("\n=== Inventory ===")
    print(f"{'Product':<15} {'Price':>10} {'Stock':>8}")
    print("-" * 40)
    
    for product, details in sorted(inventory.items()):
        price = details["price"]
        stock = details["stock"]
        status = "LOW" if stock < 10 else "OK"
        print(f"{product:<15} ₱{price:>9.2f} {stock:>8} [{status}]")

def sell_product(inventory):
    """Process sale."""
    product = input("Product: ")
    
    if product not in inventory:
        print("Product not found")
        return
    
    quantity = int(input("Quantity: "))
    
    if inventory[product]["stock"] < quantity:
        print("Insufficient stock")
        return
    
    inventory[product]["stock"] -= quantity
    total = inventory[product]["price"] * quantity
    
    print(f"Total: ₱{total:.2f}")
    
    # Log sale
    with open("sales.log", "a") as file:
        file.write(f"{product},{quantity},{total:.2f}\n")

# Main program
inventory = load_inventory()

while True:
    print("\n1. Display inventory")
    print("2. Sell product")
    print("3. Save and exit")
    
    choice = input("\nChoice: ")
    
    if choice == "1":
        display_inventory(inventory)
    elif choice == "2":
        sell_product(inventory)
    elif choice == "3":
        save_inventory(inventory)
        print("Inventory saved!")
        break
```

### Example 4: Daily Journal

```python
from datetime import datetime

FILENAME = "journal.txt"

def add_entry():
    """Add journal entry."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    entry = input("\nJournal entry: ")
    
    with open(FILENAME, "a") as file:
        file.write(f"[{timestamp}]\n")
        file.write(f"{entry}\n")
        file.write("-" * 50 + "\n\n")
    
    print("Entry saved!")

def view_entries():
    """View all entries."""
    try:
        with open(FILENAME, "r") as file:
            content = file.read()
            if content:
                print("\n=== Journal Entries ===\n")
                print(content)
            else:
                print("No entries yet")
    except FileNotFoundError:
        print("No entries yet")

def search_entries():
    """Search entries by keyword."""
    keyword = input("Search keyword: ").lower()
    
    try:
        with open(FILENAME, "r") as file:
            content = file.read()
            entries = content.split("-" * 50)
            
            found = False
            for entry in entries:
                if keyword in entry.lower():
                    print(entry)
                    found = True
            
            if not found:
                print("No matches found")
    except FileNotFoundError:
        print("No entries yet")

# Main program
while True:
    print("\n=== Daily Journal ===")
    print("1. Add entry")
    print("2. View all entries")
    print("3. Search entries")
    print("4. Exit")
    
    choice = input("\nChoice: ")
    
    if choice == "1":
        add_entry()
    elif choice == "2":
        view_entries()
    elif choice == "3":
        search_entries()
    elif choice == "4":
        break
```

### Example 5: Configuration Manager

```python
def load_config(filename="config.txt"):
    """Load configuration from file."""
    config = {}
    
    try:
        with open(filename, "r") as file:
            for line in file:
                if "=" in line:
                    key, value = line.strip().split("=", 1)
                    config[key.strip()] = value.strip()
    except FileNotFoundError:
        pass
    
    return config

def save_config(config, filename="config.txt"):
    """Save configuration to file."""
    with open(filename, "w") as file:
        for key, value in config.items():
            file.write(f"{key} = {value}\n")

# Usage
config = load_config()

# Set defaults if not exists
if "username" not in config:
    config["username"] = "admin"
if "theme" not in config:
    config["theme"] = "light"
if "language" not in config:
    config["language"] = "English"

print("Current settings:")
for key, value in config.items():
    print(f"{key}: {value}")

# Update setting
key = input("\nSetting to change: ")
value = input("New value: ")
config[key] = value

save_config(config)
print("Settings saved!")
```

## Error Handling with Files

```python
def safe_read_file(filename):
    """Safely read file with error handling."""
    try:
        with open(filename, "r") as file:
            return file.read()
    except FileNotFoundError:
        print(f"Error: {filename} not found")
        return None
    except PermissionError:
        print(f"Error: No permission to read {filename}")
        return None
    except Exception as e:
        print(f"Error: {e}")
        return None

# Usage
content = safe_read_file("data.txt")
if content:
    print(content)
```

## JSON Files (Bonus)

**JSON = JavaScript Object Notation - great for storing structured data**

```python
import json

# Python data
student = {
    "name": "Tian",
    "age": 16,
    "grades": [85, 90, 78],
    "subjects": {"Math": 85, "Science": 90}
}

# Write to JSON
with open("student.json", "w") as file:
    json.dump(student, file, indent=4)

# Read from JSON
with open("student.json", "r") as file:
    loaded_student = json.load(file)
    print(loaded_student)
```

**JSON is perfect for:**
- Configuration files
- Data exchange
- API responses
- Complex data structures

## Programming Exercises

### Exercise 1: Line Counter

**Task:** Count lines, words, and characters in file.

**Solution:**
```python
def count_file(filename):
    with open(filename, "r") as file:
        lines = file.readlines()
        
        line_count = len(lines)
        word_count = sum(len(line.split()) for line in lines)
        char_count = sum(len(line) for line in lines)
        
        print(f"Lines: {line_count}")
        print(f"Words: {word_count}")
        print(f"Characters: {char_count}")

count_file("story.txt")
```

### Exercise 2: File Copy

**Task:** Copy contents from one file to another.

**Solution:**
```python
def copy_file(source, destination):
    with open(source, "r") as src:
        content = src.read()
    
    with open(destination, "w") as dest:
        dest.write(content)
    
    print(f"Copied {source} to {destination}")

copy_file("input.txt", "output.txt")
```

### Exercise 3: Remove Duplicates

**Task:** Remove duplicate lines from file.

**Solution:**
```python
def remove_duplicates(filename):
    with open(filename, "r") as file:
        lines = file.readlines()
    
    unique_lines = []
    seen = set()
    
    for line in lines:
        if line not in seen:
            unique_lines.append(line)
            seen.add(line)
    
    with open(filename, "w") as file:
        file.writelines(unique_lines)
    
    print(f"Removed {len(lines) - len(unique_lines)} duplicates")

remove_duplicates("data.txt")
```

### Exercise 4: Top Words

**Task:** Find most common words in file.

**Solution:**
```python
def top_words(filename, n=10):
    with open(filename, "r") as file:
        content = file.read().lower()
        words = content.split()
    
    word_count = {}
    for word in words:
        word = word.strip('.,!?;:"\'')
        word_count[word] = word_count.get(word, 0) + 1
    
    sorted_words = sorted(word_count.items(), key=lambda x: x[1], reverse=True)
    
    print(f"Top {n} words:")
    for word, count in sorted_words[:n]:
        print(f"{word}: {count}")

top_words("book.txt", 10)
```

## Common Mistakes

### Mistake 1: Forgetting to Close File

**Wrong:**
```python
file = open("data.txt", "r")
content = file.read()
# Forgot file.close()!
```

**Correct:**
```python
with open("data.txt", "r") as file:
    content = file.read()
# Automatically closed
```

### Mistake 2: Wrong Mode

**Wrong:**
```python
file = open("data.txt", "r")
file.write("text")  # Error! File opened in read mode
```

**Correct:**
```python
with open("data.txt", "w") as file:
    file.write("text")
```

### Mistake 3: Overwriting Important Files

**Dangerous:**
```python
# This deletes all content!
with open("important.txt", "w") as file:
    file.write("new content")
```

**Safer:**
```python
# Use append mode or check first
with open("important.txt", "a") as file:
    file.write("new content")
```

## Summary

**Key Takeaways:**

1. **Open:** `open(filename, mode)`
2. **Modes:** `'r'` read, `'w'` write, `'a'` append
3. **with statement:** Automatic file closing
4. **Read:** `read()`, `readline()`, `readlines()`
5. **Write:** `write()`, `writelines()`
6. **CSV:** Use `csv` module for structured data
7. **JSON:** Use `json` module for complex data
8. **Error handling:** Use try-except for file operations

**Quick reference:**
```python
# Read
with open("file.txt", "r") as file:
    content = file.read()

# Write
with open("file.txt", "w") as file:
    file.write("Hello\n")

# Append
with open("file.txt", "a") as file:
    file.write("More text\n")

# CSV
import csv
with open("data.csv", "r") as file:
    reader = csv.reader(file)
    for row in reader:
        print(row)
```

**Congratulations!**
You've completed the Python fundamentals! You now know:
- Variables, data types, operators
- Control flow (if, loops)
- Data structures (lists, dictionaries)
- Functions
- File handling

**Next Steps:**
- Build projects combining these concepts
- Learn about classes and OOP
- Explore libraries (requests, pandas, flask)
- Practice, practice, practice!

Keep coding, and good luck with your Python journey!
