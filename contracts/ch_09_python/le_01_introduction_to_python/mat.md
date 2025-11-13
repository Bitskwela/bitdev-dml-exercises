# Lesson 1: Introduction to Python

## Background Story

Tian had just finished learning C++ and was feeling confident about programming fundamentals. One day, while browsing through tech forums, Tian noticed everyone talking about Python and how it's used in data science, web development, automation, and even artificial intelligence.

Curious, Tian video-called Kuya Miguel. "Kuya, I keep hearing about Python everywhere. Is it really that different from C++? Should I learn it?"

Kuya Miguel grinned. "Perfect timing! Python is actually easier than C++ in many ways. It's like switching from a manual car to an automatic one. You still drive, but it's simpler and faster to get started. Python is perfect for beginners and professionals alike. Let me show you why Python is so popular!"

## What is Python?

**Python** is a high-level, interpreted programming language created by Guido van Rossum in 1991. Named after the comedy group "Monty Python," it's designed to be fun and easy to use.

**Key Philosophy:** "Beautiful is better than ugly. Simple is better than complex."

### Python vs C++ vs JavaScript

| Feature | Python | C++ | JavaScript |
|---------|--------|-----|------------|
| **Typing** | Dynamic | Static | Dynamic |
| **Execution** | Interpreted | Compiled | Interpreted |
| **Syntax** | Very simple | Complex | Moderate |
| **Speed** | Slower | Fastest | Fast (in browser) |
| **Learning Curve** | Easiest | Steep | Moderate |
| **Use Cases** | AI, Data Science, Web | Games, Systems | Web Development |

**Simple comparison:**
```python
# Python - Simple and clean
print("Hello, World!")

// C++ - More verbose
#include <iostream>
using namespace std;
int main() {
    cout << "Hello, World!" << endl;
    return 0;
}

// JavaScript - Medium complexity
console.log("Hello, World!");
```

## Why Learn Python?

### 1. Easiest to Learn

**Python reads like English:**
```python
if age >= 18:
    print("You can vote!")
else:
    print("Too young to vote")
```

Compare with C++:
```cpp
if (age >= 18) {
    cout << "You can vote!" << endl;
} else {
    cout << "Too young to vote" << endl;
}
```

### 2. Most Versatile

**Python is used for:**
- Web Development (Django, Flask)
- Data Science & AI (NumPy, Pandas, TensorFlow)
- Automation & Scripting
- Game Development (Pygame)
- Desktop Applications
- Cybersecurity
- Testing

### 3. High Demand in Job Market

**Philippine Job Market (2024-2025):**
- Python Developer: ₱35,000 - ₱80,000/month (Junior to Mid)
- Data Scientist: ₱60,000 - ₱150,000/month
- ML Engineer: ₱80,000 - ₱200,000+/month

**Global companies using Python:**
- Google (YouTube, Search)
- Netflix (Recommendations)
- Instagram (Backend)
- Spotify (Data Analysis)
- NASA (Space Data)

### 4. Huge Community

- Largest programming community
- Tons of free libraries (packages)
- Extensive documentation
- Active forums (Stack Overflow, Reddit)

## Setting Up Python

### Option 1: Online Python Compilers (Easiest)

**Recommended for beginners:**

1. **Replit** (https://replit.com/languages/python3)
   - Full IDE in browser
   - Save projects
   - Free

2. **Programiz** (https://www.programiz.com/python-programming/online-compiler/)
   - Simple interface
   - Instant run
   - Good for learning

3. **Google Colab** (https://colab.research.google.com)
   - Jupyter notebooks
   - Free GPU access
   - Great for data science

### Option 2: Local Installation (Recommended)

**For Windows:**

**Step 1:** Download Python
- Visit: https://www.python.org/downloads/
- Download latest version (3.11 or 3.12)

**Step 2:** Install
- Run the installer
- IMPORTANT: Check "Add Python to PATH"
- Click "Install Now"

**Step 3:** Verify installation
```bash
python --version
```
Should show: `Python 3.x.x`

**Step 4:** Install VS Code
- Already have it from C++ lessons!
- Install "Python" extension by Microsoft

**For Mac:**
```bash
# Using Homebrew
brew install python3
```

**For Linux:**
```bash
# Usually pre-installed
python3 --version

# If not:
sudo apt-get install python3
```

## Your First Python Program

### The Classic: Hello, World!

```python
print("Hello, World!")
```

That's it! Just one line. No imports, no main function, no curly braces.

**Run it:**
1. Save as `hello.py`
2. Open terminal in that folder
3. Type: `python hello.py`
4. Output: `Hello, World!`

### Multiple Outputs

```python
print("Kumusta, Pilipinas!")
print("Welcome to Python!")
print("Let's learn together!")
```

**Output:**
```
Kumusta, Pilipinas!
Welcome to Python!
Let's learn together!
```

### Print with Variables (Preview)

```python
name = "Tian"
age = 16
print("My name is", name)
print("I am", age, "years old")
```

**Output:**
```
My name is Tian
I am 16 years old
```

## Comments in Python

Comments are notes in your code that Python ignores.

### Single-Line Comments

```python
# This is a comment
print("This runs")  # Comment after code
```

### Multi-Line Comments

```python
"""
This is a multi-line comment.
You can write multiple lines.
Often used for documentation.
"""
print("Hello")

# Alternative:
'''
Another way to write
multi-line comments
'''
```

**Best practice:**
```python
# Good: Explains WHY
# Calculate 20% senior citizen discount
discount = total * 0.20

# Bad: States the obvious
# Print hello
print("Hello")
```

## Python Syntax Rules

### 1. Indentation Matters!

**Python uses indentation (spaces/tabs) instead of curly braces:**

```python
# Correct
if age >= 18:
    print("Adult")  # Indented
    print("Can vote")  # Same indent level

# Wrong - IndentationError
if age >= 18:
print("Adult")  # Not indented - ERROR!
```

**Standard:** Use 4 spaces (VS Code auto-converts Tab to 4 spaces)

### 2. No Semicolons Needed

```python
# Python - No semicolons
print("Line 1")
print("Line 2")

# C++ - Needs semicolons
cout << "Line 1" << endl;
cout << "Line 2" << endl;
```

**Optional but not recommended:**
```python
print("Hi"); print("There")  # Works but ugly
```

### 3. Case Sensitive

```python
name = "Tian"
Name = "Different"  # Different variable!
NAME = "Also different"

print(name)  # "Tian"
print(Name)  # "Different"
```

### 4. No Type Declaration

```python
# Python - Type is automatic
age = 16  # Python knows it's an integer
name = "Tian"  # Python knows it's a string

# C++ - Must declare type
int age = 16;
string name = "Tian";
```

## The Python Interactive Shell

Python has an interactive mode (REPL - Read-Eval-Print Loop):

```bash
# Start Python shell
python

# You'll see:
>>> 
```

**Try it:**
```python
>>> 2 + 2
4
>>> print("Hello")
Hello
>>> name = "Tian"
>>> name
'Tian'
>>> exit()  # Leave shell
```

**Great for:**
- Testing quick code
- Learning
- Calculator
- Debugging

## Real-World Python Examples

### Example 1: GCash Balance Tracker

```python
# Simple balance tracker
balance = 5000.00
print("GCash Balance: ₱", balance)

# After receiving payment
balance = balance + 1500.00
print("After deposit: ₱", balance)

# After paying bill
balance = balance - 800.00
print("After payment: ₱", balance)
```

**Output:**
```
GCash Balance: ₱ 5000.0
After deposit: ₱ 6500.0
After payment: ₱ 5700.0
```

### Example 2: Student Information

```python
# Student data
student_name = "Tian Reyes"
age = 16
grade = 10
gpa = 91.5
is_scholar = True

print("=== Student Profile ===")
print("Name:", student_name)
print("Age:", age)
print("Grade Level:", grade)
print("GPA:", gpa)
print("Scholar:", is_scholar)
```

### Example 3: Jeepney Fare Calculator

```python
# Jeepney fare computation
base_fare = 13.00
distance = 6.5  # kilometers
extra_fare_per_km = 2.00

# Calculate
if distance <= 4:
    total_fare = base_fare
else:
    extra_distance = distance - 4
    total_fare = base_fare + (extra_distance * extra_fare_per_km)

print("Distance:", distance, "km")
print("Total Fare: ₱", total_fare)
```

## Python Features You'll Love

### 1. Dynamic Typing

```python
# Variable can change type
x = 10  # Integer
x = "Hello"  # Now string - totally fine!
x = 3.14  # Now float - also fine!
```

### 2. Multiple Assignment

```python
# Assign multiple variables at once
name, age, city = "Tian", 16, "Batangas"

# Swap values easily
a, b = 5, 10
a, b = b, a  # Swapped! a=10, b=5
```

### 3. Simple Syntax

```python
# Python - Clean and readable
for i in range(5):
    print(i)

// C++ - More verbose
for (int i = 0; i < 5; i++) {
    cout << i << endl;
}
```

### 4. Powerful Standard Library

```python
# Built-in functions (no imports needed)
print()      # Output
len()        # Length
type()       # Data type
input()      # User input
range()      # Number sequences
sum()        # Add numbers
max(), min() # Find maximum/minimum
```

## Programming Exercises

### Exercise 1: Hello Philippines

**Task:** Write a program that prints "Mabuhay, Pilipinas!" three times.

**Solution:**
```python
print("Mabuhay, Pilipinas!")
print("Mabuhay, Pilipinas!")
print("Mabuhay, Pilipinas!")
```

### Exercise 2: Personal Info

**Task:** Create variables for your name, age, and school, then print them.

**Solution:**
```python
name = "Tian Reyes"
age = 16
school = "Batangas National High School"

print("Name:", name)
print("Age:", age)
print("School:", school)
```

### Exercise 3: Simple Calculator

**Task:** Calculate the sum, difference, product, and quotient of two numbers.

**Solution:**
```python
num1 = 10
num2 = 3

print("Number 1:", num1)
print("Number 2:", num2)
print("Sum:", num1 + num2)
print("Difference:", num1 - num2)
print("Product:", num1 * num2)
print("Quotient:", num1 / num2)
```

### Exercise 4: ASCII Art

**Task:** Print a simple house using ASCII characters.

**Solution:**
```python
print("   *   ")
print("  ***  ")
print(" ***** ")
print("*******")
print("  | |  ")
print("  | |  ")
```

## Common Beginner Mistakes

### Mistake 1: Forgetting Indentation

**Wrong:**
```python
if age >= 18:
print("Adult")  # ERROR: expected an indented block
```

**Correct:**
```python
if age >= 18:
    print("Adult")  # Indented correctly
```

### Mistake 2: Using Wrong Quotes

**Wrong:**
```python
print('He said, "Hello"')  # Mixed quotes can be confusing
```

**Correct:**
```python
print('He said, "Hello"')  # Single outside, double inside
# OR
print("He said, \"Hello\"")  # Escaped quotes
```

### Mistake 3: Case Sensitivity

**Wrong:**
```python
name = "Tian"
Print(name)  # ERROR: 'Print' is not defined
```

**Correct:**
```python
name = "Tian"
print(name)  # Lowercase 'print'
```

### Mistake 4: Forgetting Parentheses

**Wrong:**
```python
print "Hello"  # ERROR: Missing parentheses (Python 2 syntax)
```

**Correct:**
```python
print("Hello")  # Python 3 requires parentheses
```

## Philippine Python Community

**Local Resources:**
- Python Philippines Facebook Group
- Manila.py Meetup Group
- Django Philippines Community
- PyLadies Manila

**Events:**
- PyCon Philippines (Annual conference)
- Python workshops in universities
- Coding bootcamps (Zuitt, Avion School)

**Companies using Python in PH:**
- Accenture (Data Analytics)
- Thinking Machines (Data Science)
- Kalibrr (Backend)
- PayMongo (API Development)

## Summary

**Key Takeaways:**

1. **Python is beginner-friendly** - Simple, readable syntax
2. **Versatile language** - Web, AI, automation, games
3. **No compilation needed** - Interpreted language
4. **Dynamic typing** - No need to declare types
5. **Indentation matters** - Use 4 spaces consistently
6. **No semicolons** - Cleaner code
7. **One line is enough** - `print("Hello")` works!

**Python vs C++:**
- Python: Easier, slower, more versatile
- C++: Harder, faster, system-level control

**Next Lesson Preview:**
In Lesson 2, you'll learn about **variables and data types** in depth - how Python handles numbers, strings, booleans, and more. You'll discover Python's dynamic typing system and type conversion!

Ready to store and manipulate data like a pro? Let's continue!
