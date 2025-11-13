# Lesson 4: Input and Output

## Background Story

"Kuya, all my programs so far just show fixed values," Tian observed. "How do I make programs that actually interact with users? Like asking for their name or age?"

Kuya Miguel smiled. "Perfect timing! That's where `input()` and better output formatting come in. Python makes user interaction super easy. Let me show you how to get input from users and display beautiful, formatted output!"

## Output with `print()`

### Basic Print (Review)

```python
print("Hello, World!")
print("My name is Tian")
```

### Print Multiple Items

```python
name = "Tian"
age = 16
print("Name:", name, "Age:", age)
# Output: Name: Tian Age: 16
```

**Default separator is space:**
```python
print("A", "B", "C")  # A B C
```

### Custom Separator

```python
print("A", "B", "C", sep="-")  # A-B-C
print("2025", "11", "13", sep="/")  # 2025/11/13
```

### End Parameter

**Default end is newline:**
```python
print("Line 1")
print("Line 2")
# Output:
# Line 1
# Line 2
```

**Custom end:**
```python
print("Hello", end=" ")
print("World")
# Output: Hello World
```

## Getting User Input

### The `input()` Function

**Syntax:** `variable = input(prompt)`

```python
name = input("Enter your name: ")
print("Hello,", name)
```

**How it works:**
1. Displays the prompt
2. Waits for user to type and press Enter
3. Returns what user typed as a **string**

### Important: Input Always Returns String!

```python
age = input("Enter your age: ")
print(type(age))  # <class 'str'> even if you type numbers!
```

**Must convert to use as number:**
```python
age = input("Enter your age: ")  # Returns string "16"
age = int(age)  # Convert to integer 16
next_year = age + 1  # Now can do math
print("Next year:", next_year)
```

### Type Conversion from Input

**Integer input:**
```python
age = int(input("Enter your age: "))
# Shortcut: convert immediately
```

**Float input:**
```python
price = float(input("Enter price: "))
```

**Be careful with invalid input:**
```python
age = int(input("Enter age: "))
# If user types "hello" → ValueError!
```

## String Formatting

### Method 1: Concatenation (Old Way)

```python
name = "Tian"
age = 16
message = "My name is " + name + " and I am " + str(age) + " years old"
print(message)
```

**Problem:** Must convert numbers to strings, messy with many variables

### Method 2: Format Method

```python
name = "Tian"
age = 16
message = "My name is {} and I am {} years old".format(name, age)
print(message)
```

**Named placeholders:**
```python
message = "My name is {n} and I am {a} years old".format(n=name, a=age)
```

### Method 3: F-Strings (Best Way - Python 3.6+)

**Syntax:** `f"text {variable} more text"`

```python
name = "Tian"
age = 16
print(f"My name is {name} and I am {age} years old")
```

**Why f-strings are best:**
- Clean and readable
- Can use expressions inside `{}`
- Fast execution

**Expressions in f-strings:**
```python
x = 10
y = 3
print(f"{x} + {y} = {x + y}")
# Output: 10 + 3 = 13

price = 99.99
print(f"Price with tax: ₱{price * 1.12:.2f}")
# Output: Price with tax: ₱111.99
```

## Number Formatting

### Decimal Places

```python
pi = 3.14159265359

# 2 decimal places
print(f"{pi:.2f}")  # 3.14

# 4 decimal places
print(f"{pi:.4f}")  # 3.1416

# No decimals (rounds)
print(f"{pi:.0f}")  # 3
```

### Thousands Separator

```python
big_number = 1000000
print(f"{big_number:,}")  # 1,000,000

price = 1500000.50
print(f"₱{price:,.2f}")  # ₱1,500,000.50
```

### Width and Alignment

```python
# Right align (default for numbers)
print(f"{42:5}")  # "   42" (width 5)

# Left align
print(f"{42:<5}")  # "42   "

# Center align
print(f"{42:^5}")  # " 42  "

# With text
name = "Tian"
print(f"{name:>10}")  # "      Tian"
```

### Percentage

```python
score = 0.856
print(f"{score:.1%}")  # 85.6%

success_rate = 0.95
print(f"Success: {success_rate:.0%}")  # Success: 95%
```

## Practical Examples

### Example 1: Personal Info Collector

```python
# Get user input
name = input("Enter your name: ")
age = int(input("Enter your age: "))
city = input("Enter your city: ")

# Display formatted
print("\n=== Your Profile ===")
print(f"Name: {name}")
print(f"Age: {age} years old")
print(f"City: {city}")
print(f"Next year you'll be {age + 1}")
```

### Example 2: GCash Transaction

```python
# Get transaction details
account = input("Account name: ")
balance = float(input("Current balance: "))
amount = float(input("Amount to send: "))

# Process
new_balance = balance - amount

# Display receipt
print("\n=== GCash Receipt ===")
print(f"From: {account}")
print(f"Amount Sent: ₱{amount:,.2f}")
print(f"Previous Balance: ₱{balance:,.2f}")
print(f"New Balance: ₱{new_balance:,.2f}")

# Check warning
if new_balance < 100:
    print("Warning: Low balance!")
```

### Example 3: Grade Calculator

```python
# Get scores
print("Enter your scores:")
quiz1 = float(input("Quiz 1: "))
quiz2 = float(input("Quiz 2: "))
exam = float(input("Exam: "))

# Calculate
average = (quiz1 + quiz2 + exam) / 3
passed = average >= 75

# Display results
print("\n=== Grade Report ===")
print(f"Quiz 1: {quiz1:.2f}")
print(f"Quiz 2: {quiz2:.2f}")
print(f"Exam: {exam:.2f}")
print(f"Average: {average:.2f}")
print(f"Status: {'PASSED' if passed else 'FAILED'}")
print(f"Percentage: {average/100:.1%}")
```

### Example 4: Sari-Sari Store Calculator

```python
# Welcome
print("=== Sari-Sari Store Calculator ===\n")

# Get items
item1 = input("Item 1: ")
price1 = float(input(f"Price of {item1}: "))

item2 = input("Item 2: ")
price2 = float(input(f"Price of {item2}: "))

item3 = input("Item 3: ")
price3 = float(input(f"Price of {item3}: "))

# Calculate
subtotal = price1 + price2 + price3

# Senior discount?
age = int(input("\nCustomer age: "))
is_senior = age >= 60
discount_rate = 0.20 if is_senior else 0.00
discount = subtotal * discount_rate
total = subtotal - discount

# Print receipt
print("\n" + "="*30)
print("        RECEIPT")
print("="*30)
print(f"{item1:<20} ₱{price1:>8.2f}")
print(f"{item2:<20} ₱{price2:>8.2f}")
print(f"{item3:<20} ₱{price3:>8.2f}")
print("-" * 30)
print(f"{'Subtotal':<20} ₱{subtotal:>8.2f}")
if is_senior:
    print(f"{'Discount (20%)':<20} ₱{discount:>8.2f}")
print("=" * 30)
print(f"{'TOTAL':<20} ₱{total:>8.2f}")
print("=" * 30)
```

## Multiple Inputs on One Line

**Method 1: Split by space**
```python
# User types: 10 20 30
numbers = input("Enter 3 numbers: ").split()
a, b, c = int(numbers[0]), int(numbers[1]), int(numbers[2])
```

**Method 2: Split and map**
```python
# More elegant
a, b, c = map(int, input("Enter 3 numbers: ").split())
# User types: 10 20 30
# a=10, b=20, c=30
```

## Input Validation (Preview)

```python
# Check if input is valid
age_input = input("Enter age: ")

if age_input.isdigit():
    age = int(age_input)
    print(f"Valid age: {age}")
else:
    print("Invalid input! Please enter a number.")
```

## Programming Exercises

### Exercise 1: Name Tag Generator

**Task:** Ask for name and create a formatted name tag.

**Solution:**
```python
name = input("Enter your name: ")
company = input("Enter company: ")

print("\n" + "="*30)
print(f"   HELLO, MY NAME IS")
print(f"      {name.upper()}")
print(f"")
print(f"   {company}")
print("="*30)
```

### Exercise 2: Simple Calculator

**Task:** Get two numbers and show all arithmetic operations.

**Solution:**
```python
a = float(input("Enter first number: "))
b = float(input("Enter second number: "))

print(f"\n{a} + {b} = {a + b}")
print(f"{a} - {b} = {a - b}")
print(f"{a} * {b} = {a * b}")
print(f"{a} / {b} = {a / b:.2f}")
print(f"{a} ** {b} = {a ** b}")
```

### Exercise 3: BMI Calculator

**Task:** Calculate BMI = weight / (height^2)

**Solution:**
```python
name = input("Enter your name: ")
weight = float(input("Weight (kg): "))
height = float(input("Height (m): "))

bmi = weight / (height ** 2)

print(f"\n=== BMI Result for {name} ===")
print(f"Weight: {weight} kg")
print(f"Height: {height} m")
print(f"BMI: {bmi:.2f}")

if bmi < 18.5:
    category = "Underweight"
elif bmi < 25:
    category = "Normal"
elif bmi < 30:
    category = "Overweight"
else:
    category = "Obese"

print(f"Category: {category}")
```

### Exercise 4: Jeepney Fare Calculator

**Task:** Interactive jeepney fare calculator.

**Solution:**
```python
print("=== Jeepney Fare Calculator ===\n")

distance = float(input("Distance traveled (km): "))

BASE_FARE = 13.00
BASE_DISTANCE = 4
EXTRA_RATE = 2.00

if distance <= BASE_DISTANCE:
    fare = BASE_FARE
else:
    extra = distance - BASE_DISTANCE
    fare = BASE_FARE + (extra * EXTRA_RATE)

print(f"\nDistance: {distance} km")
print(f"Fare: ₱{fare:.2f}")
```

## Common Mistakes

### Mistake 1: Forgetting Type Conversion

**Wrong:**
```python
age = input("Age: ")  # Returns string "16"
next_year = age + 1  # TypeError!
```

**Correct:**
```python
age = int(input("Age: "))  # Convert to int
next_year = age + 1  # Works!
```

### Mistake 2: F-String Without 'f'

**Wrong:**
```python
name = "Tian"
print("Hello {name}")  # Prints: Hello {name}
```

**Correct:**
```python
print(f"Hello {name}")  # Prints: Hello Tian
```

### Mistake 3: Invalid Input Type

**Wrong:**
```python
age = int(input("Age: "))
# User types "hello" → ValueError!
```

**Better:**
```python
try:
    age = int(input("Age: "))
except ValueError:
    print("Please enter a number!")
```

### Mistake 4: Print Concatenation

**Wrong:**
```python
age = 16
print("Age: " + age)  # TypeError!
```

**Correct:**
```python
print("Age:", age)  # Use comma
# OR
print(f"Age: {age}")  # Use f-string
```

## Summary

**Key Takeaways:**

1. **Input:** `input()` always returns string
2. **Convert:** Use `int()`, `float()` for numbers
3. **F-strings:** Best way to format: `f"text {variable}"`
4. **Formatting:**
   - Decimals: `{value:.2f}`
   - Thousands: `{value:,}`
   - Percentage: `{value:.1%}`
   - Width: `{value:10}`

5. **Print:**
   - Separator: `print(a, b, sep="-")`
   - End: `print(a, end=" ")`

**Quick reference:**
```python
name = input("Name: ")  # Get string
age = int(input("Age: "))  # Get number
print(f"{name} is {age}")  # F-string output
```

**Next Lesson Preview:**
In Lesson 5, you'll learn about **control flow with conditionals** - making decisions in your programs using if, elif, and else statements. You'll build programs that respond differently based on conditions!

Ready to make your programs smarter? Let's continue!
