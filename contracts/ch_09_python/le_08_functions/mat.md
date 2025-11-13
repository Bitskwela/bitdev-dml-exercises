# Lesson 8: Functions

## Background Story

"Kuya, I keep writing the same code over and over," Tian complained. "Like calculating jeepney fare - I need it in multiple places!"

"Perfect! That's what **functions** are for," Kuya Miguel said. "Write code once, use it anywhere. Functions make your code organized, reusable, and easier to maintain. Let me show you!"

## What are Functions?

**Functions are reusable blocks of code that perform a specific task.**

**Benefits:**
- **Reusability:** Write once, use many times
- **Organization:** Break large programs into smaller parts
- **Maintainability:** Fix bugs in one place
- **Readability:** Give meaningful names to operations

## Built-in Functions (You've Already Used!)

```python
print("Hello")      # Output text
len([1, 2, 3])      # Get length
input("Name: ")     # Get user input
int("123")          # Convert to integer
max(1, 2, 3)        # Find maximum
sum([1, 2, 3])      # Calculate sum
```

## Creating Your Own Functions

### Basic Syntax

```python
def function_name():
    # code block
    # indented
```

**Example:**
```python
def greet():
    print("Hello!")
    print("Welcome to Python!")

# Call the function
greet()

# Output:
# Hello!
# Welcome to Python!
```

**Key points:**
- Start with `def` keyword
- Function name (follow variable naming rules)
- Parentheses `()`
- Colon `:`
- Indented code block

## Functions with Parameters

**Parameters let you pass data to functions.**

```python
def greet(name):
    print(f"Hello, {name}!")

greet("Tian")    # Hello, Tian!
greet("Miguel")  # Hello, Miguel!
```

### Multiple Parameters

```python
def introduce(name, age):
    print(f"My name is {name}")
    print(f"I am {age} years old")

introduce("Tian", 16)
# My name is Tian
# I am 16 years old
```

### Default Parameters

**Provide default value if argument not given:**

```python
def greet(name="Friend"):
    print(f"Hello, {name}!")

greet("Tian")   # Hello, Tian!
greet()         # Hello, Friend!
```

**Multiple defaults:**
```python
def calculate_fare(distance, senior=False, student=False):
    base = 13.00
    if distance > 4:
        fare = base + (distance - 4) * 2
    else:
        fare = base
    
    if senior or student:
        fare = fare * 0.8  # 20% discount
    
    return fare

calculate_fare(5)              # Regular fare
calculate_fare(5, senior=True) # With senior discount
```

## Return Values

**Functions can return results using `return`.**

### Basic Return

```python
def add(a, b):
    result = a + b
    return result

total = add(5, 3)
print(total)  # 8
```

**Shortcut:**
```python
def add(a, b):
    return a + b
```

### Return Multiple Values

```python
def calculate_stats(numbers):
    total = sum(numbers)
    average = total / len(numbers)
    return total, average  # Returns tuple

numbers = [10, 20, 30, 40]
total, avg = calculate_stats(numbers)
print(f"Total: {total}, Average: {avg}")
```

### Return vs Print

**Important difference:**

```python
# This RETURNS a value
def add(a, b):
    return a + b

result = add(5, 3)  # result = 8

# This PRINTS a value
def add(a, b):
    print(a + b)

result = add(5, 3)  # result = None, but prints 8
```

**Use `return` when you need to use the result later!**

## Function Scope

**Variables created inside functions are LOCAL (only exist inside function).**

```python
def my_function():
    x = 10  # Local variable
    print(x)

my_function()  # 10
print(x)       # NameError: x doesn't exist outside
```

### Global vs Local

```python
x = 10  # Global variable

def my_function():
    x = 5  # Different x (local)
    print(f"Inside: {x}")

my_function()  # Inside: 5
print(f"Outside: {x}")  # Outside: 10
```

### Modifying Global Variables

```python
count = 0

def increment():
    global count  # Declare using global variable
    count += 1

increment()
increment()
print(count)  # 2
```

**Note:** Use global variables sparingly - prefer parameters and return values!

## Practical Examples

### Example 1: Jeepney Fare Calculator

```python
def calculate_jeepney_fare(distance, age=None):
    """
    Calculate jeepney fare with discounts.
    
    Base fare: ₱13 for first 4km
    Additional: ₱2 per km
    Discount: 20% for students (<18) and seniors (>=60)
    """
    BASE_FARE = 13.00
    BASE_DISTANCE = 4
    EXTRA_RATE = 2.00
    DISCOUNT = 0.20
    
    # Calculate base fare
    if distance <= BASE_DISTANCE:
        fare = BASE_FARE
    else:
        extra_km = distance - BASE_DISTANCE
        fare = BASE_FARE + (extra_km * EXTRA_RATE)
    
    # Apply discount if eligible
    if age is not None:
        if age < 18 or age >= 60:
            fare = fare * (1 - DISCOUNT)
    
    return fare

# Usage
print(f"₱{calculate_jeepney_fare(5):.2f}")           # Regular
print(f"₱{calculate_jeepney_fare(5, age=16):.2f}")  # Student
print(f"₱{calculate_jeepney_fare(5, age=65):.2f}")  # Senior
```

### Example 2: Grade Calculator

```python
def calculate_grade(score):
    """Return letter grade based on score."""
    if score >= 90:
        return "A"
    elif score >= 85:
        return "B+"
    elif score >= 80:
        return "B"
    elif score >= 75:
        return "C+"
    elif score >= 70:
        return "C"
    else:
        return "F"

def get_remark(grade):
    """Return remark based on grade."""
    remarks = {
        "A": "Outstanding",
        "B+": "Very Good",
        "B": "Good",
        "C+": "Satisfactory",
        "C": "Passing",
        "F": "Failed"
    }
    return remarks.get(grade, "Unknown")

# Usage
score = 85
grade = calculate_grade(score)
remark = get_remark(grade)
print(f"Score: {score}, Grade: {grade}, Remark: {remark}")
```

### Example 3: GCash Transaction Validator

```python
def validate_transaction(balance, amount):
    """
    Validate GCash transaction.
    Returns (success, message)
    """
    if amount <= 0:
        return False, "Amount must be positive"
    elif amount > balance:
        return False, "Insufficient balance"
    elif amount > 50000:
        return False, "Maximum transfer is ₱50,000"
    else:
        return True, "Transaction valid"

def process_transaction(balance, amount, recipient):
    """Process GCash transfer."""
    success, message = validate_transaction(balance, amount)
    
    if success:
        new_balance = balance - amount
        print(f"Sent ₱{amount:,.2f} to {recipient}")
        print(f"New balance: ₱{new_balance:,.2f}")
        return new_balance
    else:
        print(f"Error: {message}")
        return balance

# Usage
balance = 5000
balance = process_transaction(balance, 1000, "Juan")
balance = process_transaction(balance, 100000, "Maria")  # Fails
```

### Example 4: BMI Calculator

```python
def calculate_bmi(weight, height):
    """Calculate BMI = weight / height^2"""
    return weight / (height ** 2)

def get_bmi_category(bmi):
    """Return BMI category."""
    if bmi < 18.5:
        return "Underweight", "Consider gaining weight healthily"
    elif bmi < 25:
        return "Normal weight", "Keep up the good work!"
    elif bmi < 30:
        return "Overweight", "Consider exercising more"
    else:
        return "Obese", "Consult a doctor"

def display_bmi_report(name, weight, height):
    """Display complete BMI report."""
    bmi = calculate_bmi(weight, height)
    category, advice = get_bmi_category(bmi)
    
    print(f"\n=== BMI Report for {name} ===")
    print(f"Weight: {weight} kg")
    print(f"Height: {height} m")
    print(f"BMI: {bmi:.2f}")
    print(f"Category: {category}")
    print(f"Advice: {advice}")

# Usage
display_bmi_report("Tian", 60, 1.7)
```

### Example 5: Sari-Sari Store Helper Functions

```python
def calculate_discount(subtotal, age):
    """Calculate senior citizen discount."""
    if age >= 60:
        return subtotal * 0.20
    return 0

def calculate_total(items, prices, customer_age):
    """Calculate total with discount."""
    subtotal = sum(prices)
    discount = calculate_discount(subtotal, customer_age)
    total = subtotal - discount
    return subtotal, discount, total

def print_receipt(items, prices, customer_age):
    """Print formatted receipt."""
    subtotal, discount, total = calculate_total(items, prices, customer_age)
    
    print("\n" + "="*30)
    print("        RECEIPT")
    print("="*30)
    
    for item, price in zip(items, prices):
        print(f"{item:<20} ₱{price:>8.2f}")
    
    print("-" * 30)
    print(f"{'Subtotal':<20} ₱{subtotal:>8.2f}")
    
    if discount > 0:
        print(f"{'Discount (20%)':<20} ₱{discount:>8.2f}")
    
    print("=" * 30)
    print(f"{'TOTAL':<20} ₱{total:>8.2f}")
    print("=" * 30)

# Usage
items = ["Coke", "Chippy", "Lucky Me"]
prices = [25, 10, 15]
age = 65

print_receipt(items, prices, age)
```

### Example 6: Temperature Converter

```python
def celsius_to_fahrenheit(celsius):
    """Convert Celsius to Fahrenheit."""
    return (celsius * 9/5) + 32

def fahrenheit_to_celsius(fahrenheit):
    """Convert Fahrenheit to Celsius."""
    return (fahrenheit - 32) * 5/9

def get_temp_category(celsius):
    """Categorize temperature."""
    if celsius < 0:
        return "Freezing"
    elif celsius < 20:
        return "Cold"
    elif celsius < 30:
        return "Comfortable"
    else:
        return "Hot"

# Usage
temp_c = 35
temp_f = celsius_to_fahrenheit(temp_c)
category = get_temp_category(temp_c)

print(f"{temp_c}°C = {temp_f}°F")
print(f"Category: {category}")
```

## Docstrings

**Document your functions with docstrings:**

```python
def calculate_fare(distance, discount=0):
    """
    Calculate transportation fare.
    
    Args:
        distance (float): Distance traveled in kilometers
        discount (float): Discount rate (0 to 1)
    
    Returns:
        float: Calculated fare
    
    Example:
        >>> calculate_fare(5)
        15.0
        >>> calculate_fare(5, 0.2)
        12.0
    """
    fare = distance * 2.5
    return fare * (1 - discount)

# Access docstring
print(calculate_fare.__doc__)
help(calculate_fare)
```

## Lambda Functions

**Small anonymous functions - one line only.**

**Syntax:** `lambda parameters: expression`

```python
# Regular function
def add(x, y):
    return x + y

# Lambda equivalent
add = lambda x, y: x + y

print(add(5, 3))  # 8
```

**Common use: with `map()`, `filter()`, `sorted()`**

```python
# Square all numbers
numbers = [1, 2, 3, 4, 5]
squared = list(map(lambda x: x**2, numbers))
print(squared)  # [1, 4, 9, 16, 25]

# Filter even numbers
evens = list(filter(lambda x: x % 2 == 0, numbers))
print(evens)  # [2, 4]

# Sort by second element
pairs = [(1, 'b'), (2, 'a'), (3, 'c')]
sorted_pairs = sorted(pairs, key=lambda x: x[1])
print(sorted_pairs)  # [(2, 'a'), (1, 'b'), (3, 'c')]
```

## Programming Exercises

### Exercise 1: Factorial Function

**Task:** Calculate n! = n × (n-1) × ... × 1

**Solution:**
```python
def factorial(n):
    """Calculate factorial of n."""
    result = 1
    for i in range(1, n + 1):
        result *= i
    return result

print(factorial(5))  # 120
```

### Exercise 2: Prime Checker

**Task:** Check if number is prime.

**Solution:**
```python
def is_prime(n):
    """Check if n is prime."""
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True

print(is_prime(17))  # True
print(is_prime(18))  # False
```

### Exercise 3: Palindrome Checker

**Task:** Check if string reads same forwards and backwards.

**Solution:**
```python
def is_palindrome(text):
    """Check if text is palindrome."""
    text = text.lower().replace(" ", "")
    return text == text[::-1]

print(is_palindrome("racecar"))     # True
print(is_palindrome("A man a plan a canal Panama"))  # True
```

### Exercise 4: Fibonacci Generator

**Task:** Generate first n Fibonacci numbers.

**Solution:**
```python
def fibonacci(n):
    """Return list of first n Fibonacci numbers."""
    if n <= 0:
        return []
    elif n == 1:
        return [1]
    
    fib = [1, 1]
    for i in range(2, n):
        fib.append(fib[-1] + fib[-2])
    return fib

print(fibonacci(10))  # [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
```

## Common Mistakes

### Mistake 1: Forgetting to Call Function

**Wrong:**
```python
def greet():
    print("Hello")

greet  # Doesn't do anything!
```

**Correct:**
```python
greet()  # Must include ()
```

### Mistake 2: Forgetting Return

**Wrong:**
```python
def add(a, b):
    a + b  # Doesn't return!

result = add(5, 3)
print(result)  # None
```

**Correct:**
```python
def add(a, b):
    return a + b
```

### Mistake 3: Wrong Number of Arguments

**Wrong:**
```python
def greet(name):
    print(f"Hello, {name}")

greet()  # TypeError: missing argument
```

**Correct:**
```python
greet("Tian")  # OR use default parameter
```

### Mistake 4: Modifying Mutable Arguments

**Careful with lists!**
```python
def add_item(item, my_list=[]):
    my_list.append(item)
    return my_list

print(add_item(1))  # [1]
print(add_item(2))  # [1, 2] - Unexpected!
```

**Better:**
```python
def add_item(item, my_list=None):
    if my_list is None:
        my_list = []
    my_list.append(item)
    return my_list
```

## Summary

**Key Takeaways:**

1. **Define:** `def function_name(parameters):`
2. **Call:** `function_name(arguments)`
3. **Return:** Use `return` to send back values
4. **Parameters:** Pass data to functions
5. **Default parameters:** Provide fallback values
6. **Scope:** Variables inside functions are local
7. **Docstrings:** Document with `""" """`

**Function template:**
```python
def function_name(param1, param2=default):
    """
    Brief description.
    
    Args:
        param1: description
        param2: description
    
    Returns:
        description
    """
    # Function body
    result = param1 + param2
    return result
```

**Next Lesson Preview:**
In Lesson 9, you'll learn about **dictionaries** - Python's key-value data structure for storing related data with meaningful keys instead of numeric indices!

Ready to learn another powerful data structure? Let's continue!
