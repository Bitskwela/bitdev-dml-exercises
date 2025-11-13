# Lesson 9: Dictionaries

## Background Story

"Kuya, lists are great, but remembering that index 0 is name, index 1 is age, index 2 is city... it's confusing!" Tian said.

"Exactly! That's why we have **dictionaries**," Kuya Miguel explained. "Instead of numeric indices, use meaningful keys like 'name', 'age', 'city'. It's like a real dictionary - you look up a word (key) to get its definition (value)!"

## What are Dictionaries?

**Dictionaries store data as key-value pairs.**

**Real-world analogy:**
- Phone book: Name → Phone number
- Student ID: ID number → Student info
- Product catalog: SKU → Product details
- GCash: Account → Balance

**Syntax:**
```python
my_dict = {
    key1: value1,
    key2: value2,
    key3: value3
}
```

## Creating Dictionaries

### Basic Creation

```python
# Student information
student = {
    "name": "Tian",
    "age": 16,
    "grade": 85,
    "city": "Iloilo"
}

print(student)
```

### Empty Dictionary

```python
# Method 1
empty_dict = {}

# Method 2
empty_dict = dict()
```

### Different Value Types

```python
person = {
    "name": "Tian",           # String
    "age": 16,                # Integer
    "grades": [85, 90, 78],   # List
    "is_student": True,       # Boolean
    "address": {              # Nested dictionary
        "city": "Iloilo",
        "barangay": "Jaro"
    }
}
```

## Accessing Values

### Using Keys

```python
student = {
    "name": "Tian",
    "age": 16,
    "city": "Iloilo"
}

print(student["name"])   # Tian
print(student["age"])    # 16
print(student["city"])   # Iloilo
```

**KeyError if key doesn't exist:**
```python
print(student["grade"])  # KeyError!
```

### Using `get()` Method (Safer)

```python
student = {
    "name": "Tian",
    "age": 16
}

print(student.get("name"))     # Tian
print(student.get("grade"))    # None (no error!)
print(student.get("grade", 0)) # 0 (custom default)
```

## Modifying Dictionaries

### Add New Key-Value Pair

```python
student = {
    "name": "Tian",
    "age": 16
}

student["grade"] = 85
print(student)  # {"name": "Tian", "age": 16, "grade": 85}
```

### Update Existing Value

```python
student = {
    "name": "Tian",
    "age": 16
}

student["age"] = 17
print(student)  # {"name": "Tian", "age": 17}
```

### Delete Key-Value Pair

**Using `del`:**
```python
student = {
    "name": "Tian",
    "age": 16,
    "grade": 85
}

del student["grade"]
print(student)  # {"name": "Tian", "age": 16}
```

**Using `pop()` (returns value):**
```python
student = {
    "name": "Tian",
    "age": 16,
    "grade": 85
}

grade = student.pop("grade")
print(grade)    # 85
print(student)  # {"name": "Tian", "age": 16}
```

## Dictionary Methods

### `keys()` - Get All Keys

```python
student = {
    "name": "Tian",
    "age": 16,
    "grade": 85
}

keys = student.keys()
print(keys)  # dict_keys(['name', 'age', 'grade'])
print(list(keys))  # ['name', 'age', 'grade']
```

### `values()` - Get All Values

```python
values = student.values()
print(values)  # dict_values(['Tian', 16, 85])
print(list(values))  # ['Tian', 16, 85]
```

### `items()` - Get Key-Value Pairs

```python
items = student.items()
print(items)  # dict_items([('name', 'Tian'), ('age', 16), ('grade', 85)])

for key, value in items:
    print(f"{key}: {value}")

# Output:
# name: Tian
# age: 16
# grade: 85
```

### `update()` - Merge Dictionaries

```python
student = {"name": "Tian", "age": 16}
grades = {"math": 85, "science": 90}

student.update(grades)
print(student)  # {"name": "Tian", "age": 16, "math": 85, "science": 90}
```

### `clear()` - Remove All Items

```python
student = {"name": "Tian", "age": 16}
student.clear()
print(student)  # {}
```

### `copy()` - Create Shallow Copy

```python
student1 = {"name": "Tian", "age": 16}
student2 = student1.copy()

student2["name"] = "Juan"
print(student1)  # {"name": "Tian", "age": 16} (unchanged)
print(student2)  # {"name": "Juan", "age": 16}
```

## Checking Membership

### Check if Key Exists

```python
student = {"name": "Tian", "age": 16}

if "name" in student:
    print("Name found!")

if "grade" not in student:
    print("Grade not found")
```

## Looping Through Dictionaries

### Loop Through Keys (Default)

```python
student = {"name": "Tian", "age": 16, "grade": 85}

for key in student:
    print(key)

# Output:
# name
# age
# grade
```

### Loop Through Values

```python
for value in student.values():
    print(value)

# Output:
# Tian
# 16
# 85
```

### Loop Through Key-Value Pairs

```python
for key, value in student.items():
    print(f"{key}: {value}")

# Output:
# name: Tian
# age: 16
# grade: 85
```

## Nested Dictionaries

**Dictionaries inside dictionaries:**

```python
students = {
    "student1": {
        "name": "Tian",
        "age": 16,
        "grades": [85, 90, 78]
    },
    "student2": {
        "name": "Juan",
        "age": 17,
        "grades": [88, 92, 85]
    }
}

# Access nested values
print(students["student1"]["name"])  # Tian
print(students["student2"]["grades"][0])  # 88
```

## Dictionary Comprehension

**Create dictionaries in one line:**

**Syntax:** `{key_expr: value_expr for item in iterable}`

```python
# Square numbers
squares = {x: x**2 for x in range(1, 6)}
print(squares)  # {1: 1, 2: 4, 3: 9, 4: 16, 5: 25}

# Create from two lists
names = ["Tian", "Juan", "Maria"]
ages = [16, 17, 16]
students = {name: age for name, age in zip(names, ages)}
print(students)  # {'Tian': 16, 'Juan': 17, 'Maria': 16}
```

**With condition:**
```python
# Only even numbers
evens = {x: x**2 for x in range(1, 11) if x % 2 == 0}
print(evens)  # {2: 4, 4: 16, 6: 36, 8: 64, 10: 100}
```

## Practical Examples

### Example 1: Student Database

```python
students = {}

# Add students
students["2024001"] = {
    "name": "Tian",
    "age": 16,
    "grades": [85, 90, 78, 92]
}

students["2024002"] = {
    "name": "Juan",
    "age": 17,
    "grades": [88, 85, 90, 87]
}

# Display all students
print("=== Student Database ===\n")

for student_id, info in students.items():
    name = info["name"]
    age = info["age"]
    grades = info["grades"]
    average = sum(grades) / len(grades)
    
    print(f"ID: {student_id}")
    print(f"Name: {name}")
    print(f"Age: {age}")
    print(f"Average: {average:.2f}")
    print()
```

### Example 2: GCash Account System

```python
accounts = {
    "0917-123-4567": {
        "name": "Tian",
        "balance": 5000.00,
        "transactions": []
    },
    "0918-234-5678": {
        "name": "Juan",
        "balance": 3000.00,
        "transactions": []
    }
}

def check_balance(phone):
    """Check account balance."""
    if phone in accounts:
        balance = accounts[phone]["balance"]
        name = accounts[phone]["name"]
        print(f"{name}'s balance: ₱{balance:,.2f}")
    else:
        print("Account not found")

def send_money(from_phone, to_phone, amount):
    """Transfer money between accounts."""
    # Validate sender
    if from_phone not in accounts:
        print("Sender account not found")
        return
    
    # Validate recipient
    if to_phone not in accounts:
        print("Recipient account not found")
        return
    
    # Check balance
    if accounts[from_phone]["balance"] < amount:
        print("Insufficient balance")
        return
    
    # Process transfer
    accounts[from_phone]["balance"] -= amount
    accounts[to_phone]["balance"] += amount
    
    # Record transactions
    accounts[from_phone]["transactions"].append(f"Sent ₱{amount:.2f} to {to_phone}")
    accounts[to_phone]["transactions"].append(f"Received ₱{amount:.2f} from {from_phone}")
    
    print(f"Successfully sent ₱{amount:,.2f}")

# Usage
check_balance("0917-123-4567")
send_money("0917-123-4567", "0918-234-5678", 1000)
check_balance("0917-123-4567")
check_balance("0918-234-5678")
```

### Example 3: Sari-Sari Store Inventory

```python
inventory = {
    "Coke": {
        "price": 25.00,
        "stock": 50,
        "category": "Beverage"
    },
    "Chippy": {
        "price": 10.00,
        "stock": 30,
        "category": "Snack"
    },
    "Lucky Me": {
        "price": 15.00,
        "stock": 40,
        "category": "Noodles"
    }
}

def display_inventory():
    """Display all products."""
    print("\n=== Inventory ===")
    print(f"{'Product':<15} {'Price':>10} {'Stock':>8} {'Category':<12}")
    print("-" * 50)
    
    for product, details in inventory.items():
        price = details["price"]
        stock = details["stock"]
        category = details["category"]
        status = "LOW" if stock < 20 else "OK"
        
        print(f"{product:<15} ₱{price:>9.2f} {stock:>8} {category:<12} [{status}]")

def sell_product(product, quantity):
    """Sell product and update stock."""
    if product not in inventory:
        print(f"{product} not found")
        return
    
    if inventory[product]["stock"] < quantity:
        print(f"Insufficient stock for {product}")
        return
    
    # Process sale
    inventory[product]["stock"] -= quantity
    price = inventory[product]["price"]
    total = price * quantity
    
    print(f"\nSold {quantity} {product}")
    print(f"Total: ₱{total:.2f}")
    print(f"Remaining stock: {inventory[product]['stock']}")

def add_stock(product, quantity):
    """Add stock for product."""
    if product in inventory:
        inventory[product]["stock"] += quantity
        print(f"Added {quantity} {product}. New stock: {inventory[product]['stock']}")
    else:
        print(f"{product} not found")

# Usage
display_inventory()
sell_product("Coke", 10)
add_stock("Chippy", 20)
display_inventory()
```

### Example 4: Word Counter

```python
def count_words(text):
    """Count word frequency in text."""
    # Convert to lowercase and split
    words = text.lower().split()
    
    # Count occurrences
    word_count = {}
    for word in words:
        # Remove punctuation
        word = word.strip('.,!?;:"\'')
        
        if word in word_count:
            word_count[word] += 1
        else:
            word_count[word] = 1
    
    return word_count

# Usage
text = "Python is great. Python is powerful. Python is easy."
counts = count_words(text)

print("Word frequencies:")
for word, count in sorted(counts.items()):
    print(f"{word}: {count}")
```

### Example 5: Contact Book

```python
contacts = {}

def add_contact(name, phone, email=""):
    """Add new contact."""
    contacts[name] = {
        "phone": phone,
        "email": email
    }
    print(f"Added {name} to contacts")

def search_contact(name):
    """Search for contact."""
    if name in contacts:
        print(f"\nName: {name}")
        print(f"Phone: {contacts[name]['phone']}")
        if contacts[name]['email']:
            print(f"Email: {contacts[name]['email']}")
    else:
        print(f"{name} not found")

def list_contacts():
    """List all contacts."""
    if not contacts:
        print("No contacts")
        return
    
    print("\n=== Contact Book ===")
    for name, info in sorted(contacts.items()):
        print(f"{name}: {info['phone']}")

def delete_contact(name):
    """Delete contact."""
    if name in contacts:
        del contacts[name]
        print(f"Deleted {name}")
    else:
        print(f"{name} not found")

# Usage
add_contact("Tian", "0917-123-4567", "tian@email.com")
add_contact("Juan", "0918-234-5678")
list_contacts()
search_contact("Tian")
delete_contact("Juan")
list_contacts()
```

### Example 6: Grade Book

```python
gradebook = {}

def add_student(name):
    """Add student to gradebook."""
    if name not in gradebook:
        gradebook[name] = []
        print(f"Added {name}")
    else:
        print(f"{name} already exists")

def add_grade(name, grade):
    """Add grade for student."""
    if name in gradebook:
        gradebook[name].append(grade)
        print(f"Added grade {grade} for {name}")
    else:
        print(f"{name} not found")

def get_average(name):
    """Calculate student average."""
    if name not in gradebook:
        print(f"{name} not found")
        return
    
    grades = gradebook[name]
    if len(grades) == 0:
        print(f"No grades for {name}")
        return
    
    average = sum(grades) / len(grades)
    print(f"{name}'s average: {average:.2f}")
    return average

def display_all():
    """Display all students and grades."""
    print("\n=== Grade Book ===")
    for name, grades in gradebook.items():
        if grades:
            avg = sum(grades) / len(grades)
            print(f"{name}: {grades} → Average: {avg:.2f}")
        else:
            print(f"{name}: No grades")

# Usage
add_student("Tian")
add_student("Juan")
add_grade("Tian", 85)
add_grade("Tian", 90)
add_grade("Tian", 78)
add_grade("Juan", 88)
add_grade("Juan", 92)
display_all()
get_average("Tian")
```

## Programming Exercises

### Exercise 1: Flip Dictionary

**Task:** Swap keys and values.

**Solution:**
```python
original = {"a": 1, "b": 2, "c": 3}
flipped = {value: key for key, value in original.items()}
print(flipped)  # {1: 'a', 2: 'b', 3: 'c'}
```

### Exercise 2: Merge Dictionaries

**Task:** Combine two dictionaries (newer values win).

**Solution:**
```python
dict1 = {"a": 1, "b": 2}
dict2 = {"b": 3, "c": 4}

merged = dict1.copy()
merged.update(dict2)
print(merged)  # {'a': 1, 'b': 3, 'c': 4}

# OR (Python 3.9+)
merged = dict1 | dict2
```

### Exercise 3: Character Counter

**Task:** Count character frequency in string.

**Solution:**
```python
def count_chars(text):
    counts = {}
    for char in text.lower():
        if char.isalpha():
            counts[char] = counts.get(char, 0) + 1
    return counts

result = count_chars("Hello World")
print(result)  # {'h': 1, 'e': 1, 'l': 3, 'o': 2, 'w': 1, 'r': 1, 'd': 1}
```

### Exercise 4: Filter Dictionary

**Task:** Keep only items where value > threshold.

**Solution:**
```python
scores = {"Tian": 85, "Juan": 60, "Maria": 90, "Pedro": 55}
passing = {name: score for name, score in scores.items() if score >= 75}
print(passing)  # {'Tian': 85, 'Maria': 90}
```

## Common Mistakes

### Mistake 1: Using Mutable Keys

**Wrong:**
```python
my_dict = {[1, 2]: "value"}  # TypeError! Lists can't be keys
```

**Correct:**
```python
my_dict = {(1, 2): "value"}  # Tuples work (immutable)
```

### Mistake 2: KeyError Without Checking

**Wrong:**
```python
student = {"name": "Tian"}
print(student["age"])  # KeyError!
```

**Correct:**
```python
print(student.get("age", 0))  # Safe with default
```

### Mistake 3: Modifying While Looping

**Wrong:**
```python
d = {"a": 1, "b": 2, "c": 3}
for key in d:
    if d[key] == 2:
        del d[key]  # RuntimeError!
```

**Correct:**
```python
d = {k: v for k, v in d.items() if v != 2}
```

## Summary

**Key Takeaways:**

1. **Create:** `my_dict = {key: value}`
2. **Access:** `my_dict[key]` or `my_dict.get(key)`
3. **Add/Update:** `my_dict[key] = value`
4. **Delete:** `del my_dict[key]` or `my_dict.pop(key)`
5. **Methods:** `keys()`, `values()`, `items()`, `update()`
6. **Loop:** `for key, value in my_dict.items()`
7. **Check:** `if key in my_dict`

**Quick reference:**
```python
# Create
student = {"name": "Tian", "age": 16}

# Access
name = student["name"]
grade = student.get("grade", 0)

# Modify
student["age"] = 17
student["grade"] = 85

# Delete
del student["grade"]

# Loop
for key, value in student.items():
    print(f"{key}: {value}")
```

**Next Lesson Preview:**
In Lesson 10, you'll learn about **file handling** - how to read from and write to files, work with CSV data, and persist your data beyond program execution!

Ready to make your programs save data? Let's continue!
