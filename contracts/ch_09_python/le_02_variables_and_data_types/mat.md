# Lesson 2: Variables and Data Types

## Background Story

After learning the basics of Python, Tian was excited but had questions. "Kuya, in C++ I had to declare types like `int age = 16;`, but in Python I just write `age = 16`. How does Python know what type it is? And what types does Python have?"

Kuya Miguel smiled. "Great observation! That's one of Python's superpowers - **dynamic typing**. Python figures out the type automatically based on the value you assign. But understanding types is still super important. Let me show you Python's data types and how they work!"

## What are Variables in Python?

A **variable** is a named container that stores a value. Think of it as a labeled box where you can put different things.

**Key difference from C++:**
```python
# Python - No type declaration needed
age = 16  # Python automatically knows it's an integer
name = "Tian"  # Python knows it's a string

# C++ - Must declare type
int age = 16;
string name = "Tian";
```

### Variable Naming Rules

**Must follow:**
1. Start with letter or underscore: `name`, `_temp`, `myVar`
2. Can contain letters, numbers, underscores: `age2`, `total_score`
3. Case-sensitive: `age` and `Age` are different
4. No keywords: Can't use `if`, `for`, `print`, etc.

**Valid names:**
```python
student_name = "Tian"
age = 16
_private = 100
score2 = 95
```

**Invalid names:**
```python
2fast = 10  # Can't start with number
my-name = "Tian"  # Can't use hyphen
for = 5  # Can't use keyword
student name = "Tian"  # No spaces
```

### Naming Conventions

**snake_case (Recommended for Python):**
```python
student_name = "Tian Reyes"
total_score = 450
is_passed = True
```

**camelCase (Less common in Python):**
```python
studentName = "Tian Reyes"
totalScore = 450
isPassed = True
```

**UPPERCASE (For constants):**
```python
MAX_STUDENTS = 50
PI = 3.14159
TAX_RATE = 0.12
```

## Python Data Types

Python has several built-in data types. Let's explore them!

### 1. Integer (`int`)

**Purpose:** Whole numbers (positive, negative, or zero)

```python
age = 16
score = 100
temperature = -5
big_number = 1000000
```

**No size limit!** Unlike C++ (4 bytes), Python integers can be as large as memory allows:
```python
huge = 99999999999999999999999999999999999999
print(huge)  # Works fine!
```

**Operations:**
```python
a = 10
b = 3

print(a + b)  # 13
print(a - b)  # 7
print(a * b)  # 30
print(a / b)  # 3.3333... (float division)
print(a // b)  # 3 (integer division)
print(a % b)  # 1 (remainder)
print(a ** b)  # 1000 (power: 10^3)
```

### 2. Float (`float`)

**Purpose:** Numbers with decimals

```python
price = 99.99
pi = 3.14159
gpa = 91.5
temperature = -2.5
```

**Scientific notation:**
```python
speed_of_light = 3.0e8  # 300,000,000
tiny = 1.5e-5  # 0.000015
```

**Float operations:**
```python
a = 10.5
b = 2.0

print(a + b)  # 12.5
print(a - b)  # 8.5
print(a * b)  # 21.0
print(a / b)  # 5.25
```

**Precision warning:**
```python
print(0.1 + 0.2)  # 0.30000000000000004 (float precision issue)
```

### 3. String (`str`)

**Purpose:** Text data

```python
name = "Tian Reyes"
city = 'Batangas'  # Single or double quotes work
message = """This is a
multi-line
string"""
```

**String operations:**
```python
first_name = "Tian"
last_name = "Reyes"

# Concatenation
full_name = first_name + " " + last_name  # "Tian Reyes"

# Repetition
stars = "*" * 5  # "*****"

# Length
length = len(full_name)  # 10

# Indexing (starts at 0)
first_letter = name[0]  # "T"
last_letter = name[-1]  # "s"

# Slicing
first_three = name[0:3]  # "Tia"
```

**String methods:**
```python
text = "Hello, World!"

print(text.upper())  # "HELLO, WORLD!"
print(text.lower())  # "hello, world!"
print(text.replace("World", "Python"))  # "Hello, Python!"
print(text.split(","))  # ['Hello', ' World!']
print(text.startswith("Hello"))  # True
print(text.endswith("!"))  # True
```

**Escape characters:**
```python
quote = "He said, \"Hello!\""  # He said, "Hello!"
path = "C:\\Users\\Tian"  # C:\Users\Tian
newline = "Line 1\nLine 2"  # Two lines
tab = "Name:\tTian"  # Name:    Tian
```

### 4. Boolean (`bool`)

**Purpose:** True or False values

```python
is_student = True
has_internet = False
is_adult = age >= 18
```

**Boolean values:**
- `True` (capital T)
- `False` (capital F)

**Truthy and Falsy values:**
```python
# Falsy values (evaluate to False)
bool(0)  # False
bool(0.0)  # False
bool("")  # False (empty string)
bool([])  # False (empty list)
bool(None)  # False

# Truthy values (evaluate to True)
bool(1)  # True
bool(-5)  # True
bool("Hello")  # True
bool([1, 2])  # True
```

**Boolean operations:**
```python
a = True
b = False

print(a and b)  # False
print(a or b)  # True
print(not a)  # False
```

### 5. NoneType (`None`)

**Purpose:** Represents absence of value

```python
result = None  # Similar to null in other languages
phone_number = None  # Not yet assigned
```

**Common use:**
```python
def find_student(name):
    # ... search logic ...
    if not_found:
        return None  # Indicate not found
    return student_data
```

## The `type()` Function

**Check the type of any value:**

```python
age = 16
name = "Tian"
gpa = 91.5
is_student = True

print(type(age))  # <class 'int'>
print(type(name))  # <class 'str'>
print(type(gpa))  # <class 'float'>
print(type(is_student))  # <class 'bool'>
```

**Useful for debugging:**
```python
value = "123"
print(type(value))  # <class 'str'> (not int!)
```

## Type Conversion (Type Casting)

**Convert between types:**

### To Integer

```python
# String to int
age = int("16")  # 16
score = int("100")  # 100

# Float to int (truncates decimal)
rounded = int(3.9)  # 3 (not 4!)
price = int(99.99)  # 99

# Boolean to int
x = int(True)  # 1
y = int(False)  # 0
```

**Error if invalid:**
```python
invalid = int("hello")  # ValueError: invalid literal
decimal = int("3.14")  # ValueError: invalid literal
```

### To Float

```python
# String to float
price = float("99.99")  # 99.99
pi = float("3.14")  # 3.14

# Int to float
value = float(10)  # 10.0

# Boolean to float
x = float(True)  # 1.0
```

### To String

```python
# Int to string
age_text = str(16)  # "16"
score_text = str(100)  # "100"

# Float to string
price_text = str(99.99)  # "99.99"

# Boolean to string
status = str(True)  # "True"

# Useful for concatenation
age = 16
message = "I am " + str(age) + " years old"
print(message)  # "I am 16 years old"
```

### To Boolean

```python
# Any value to boolean
print(bool(1))  # True
print(bool(0))  # False
print(bool(""))  # False
print(bool("Hello"))  # True
print(bool([]))  # False
```

## Dynamic Typing

**Python variables can change type:**

```python
x = 10  # x is int
print(type(x))  # <class 'int'>

x = "Hello"  # Now x is str
print(type(x))  # <class 'str'>

x = 3.14  # Now x is float
print(type(x))  # <class 'float'>
```

**This is flexible but can cause bugs:**
```python
age = 16  # int
age = "sixteen"  # Now string - might break calculations!
```

## Multiple Assignment

**Assign multiple variables at once:**

```python
# Multiple assignment
name, age, city = "Tian", 16, "Batangas"

# Same value to multiple variables
x = y = z = 0

# Swap values (no temp variable needed!)
a, b = 5, 10
a, b = b, a  # Now a=10, b=5
```

## Practical Examples

### Example 1: Student Profile

```python
# Student information
student_name = "Tian Reyes"
age = 16
grade_level = 10
gpa = 91.5
is_scholar = True
scholarship_amount = None  # Not yet determined

print("=== Student Profile ===")
print("Name:", student_name)
print("Age:", age, "years old")
print("Grade:", grade_level)
print("GPA:", gpa)
print("Scholar:", is_scholar)
print("Type of GPA:", type(gpa))
```

### Example 2: GCash Transaction

```python
# GCash account
account_name = "Tian Reyes"
balance = 5000.00
phone = "09171234567"
is_verified = True

# Transaction
amount = 500.00
balance = balance - amount

print("Account:", account_name)
print("Remaining Balance: ₱", balance)
print("Verified:", is_verified)
```

### Example 3: Type Conversion in Action

```python
# User input comes as string
age_input = "16"  # Imagine this came from user
score_input = "92.5"

# Convert to appropriate types
age = int(age_input)
score = float(score_input)

# Now can do math
next_year_age = age + 1
bonus_score = score * 1.1

print("Next year:", next_year_age)
print("With bonus:", bonus_score)
```

### Example 4: Jeepney Fare Calculator

```python
# Fare computation
base_fare = 13.00  # float
distance = 6  # int (kilometers)
extra_rate = 2.00  # float per km

# Calculate (int and float work together!)
if distance <= 4:
    total_fare = base_fare
else:
    extra_distance = distance - 4
    total_fare = base_fare + (extra_distance * extra_rate)

print("Distance:", distance, "km")
print("Total Fare: ₱", total_fare)
```

## Programming Exercises

### Exercise 1: Variable Practice

**Task:** Create variables for personal information and print them.

**Solution:**
```python
name = "Tian Reyes"
age = 16
height = 165.5  # cm
is_student = True
favorite_subject = "Computer Science"

print("Name:", name)
print("Age:", age)
print("Height:", height, "cm")
print("Student:", is_student)
print("Favorite Subject:", favorite_subject)
```

### Exercise 2: Type Conversion

**Task:** Convert string inputs to numbers and calculate.

**Solution:**
```python
# String inputs (pretend from user)
num1_str = "10"
num2_str = "3.5"

# Convert
num1 = int(num1_str)
num2 = float(num2_str)

# Calculate
total = num1 + num2
product = num1 * num2

print("Sum:", total)
print("Product:", product)
```

### Exercise 3: Sari-Sari Store

**Task:** Calculate total cost of items.

**Solution:**
```python
# Items and prices
item1 = "Lucky Me"
price1 = 15.00

item2 = "C2"
price2 = 20.00

item3 = "Bread"
price3 = 12.50

# Calculate total
total = price1 + price2 + price3

# Apply discount for senior citizen
is_senior = True
discount_rate = 0.20  # 20%

if is_senior:
    discount = total * discount_rate
    final_total = total - discount
else:
    final_total = total

print("Subtotal: ₱", total)
print("Discount: ₱", discount if is_senior else 0)
print("Total: ₱", final_total)
```

### Exercise 4: Type Checking

**Task:** Check types of different values.

**Solution:**
```python
values = [42, 3.14, "Hello", True, None]

for value in values:
    print(f"Value: {value}, Type: {type(value)}")
```

## Common Mistakes

### Mistake 1: Wrong Type in Operations

**Wrong:**
```python
age = "16"
next_year = age + 1  # TypeError: can't add string and int
```

**Correct:**
```python
age = "16"
next_year = int(age) + 1  # Convert first
```

### Mistake 2: Float vs Int Division

```python
# Division always returns float
result = 10 / 2  # 5.0 (not 5)

# Use // for integer division
result = 10 // 2  # 5
```

### Mistake 3: Boolean Capitalization

**Wrong:**
```python
is_active = true  # NameError: name 'true' is not defined
```

**Correct:**
```python
is_active = True  # Capital T
```

### Mistake 4: Quotes Mismatch

**Wrong:**
```python
name = "Tian'  # SyntaxError: unterminated string
```

**Correct:**
```python
name = "Tian"  # Matching quotes
```

## Summary

**Key Takeaways:**

1. **Python is dynamically typed** - No need to declare types
2. **Basic types:** `int`, `float`, `str`, `bool`, `None`
3. **Check type:** Use `type()` function
4. **Convert types:** `int()`, `float()`, `str()`, `bool()`
5. **Naming:** Use snake_case for variables
6. **Integers:** No size limit in Python
7. **Strings:** Single or double quotes work
8. **Booleans:** Must be capitalized `True`/`False`

**Type Conversion Remember:**
- String to number: `int("16")` or `float("3.14")`
- Number to string: `str(16)` or `str(3.14)`
- Always convert before operations!

**Next Lesson Preview:**
In Lesson 3, you'll learn about **operators and expressions** - how to perform arithmetic, comparisons, and logical operations in Python. You'll see how Python handles division differently from C++!

Ready to calculate like a pro? Let's continue!
