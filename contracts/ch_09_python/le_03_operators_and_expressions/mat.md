# Lesson 3: Operators and Expressions

## Background Story

"Kuya, I can store data in variables now," said Tian. "But how do I actually DO things with them? Like in C++, I used operators for math and comparisons. Does Python work the same way?"

Kuya Miguel nodded. "Great question! Python has all the same operators as C++, but with some neat additions. Python's operators are actually more powerful and intuitive. Let me show you how to perform calculations, compare values, and build complex expressions in Python!"

## What are Operators?

**Operators** are special symbols that perform operations on values and variables (operands).

**Simple example:**
```python
result = 5 + 3  # + is the operator, 5 and 3 are operands
```

## Arithmetic Operators

### Basic Math Operations

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `+` | Addition | `10 + 3` | `13` |
| `-` | Subtraction | `10 - 3` | `7` |
| `*` | Multiplication | `10 * 3` | `30` |
| `/` | Division | `10 / 3` | `3.333...` |
| `//` | Floor Division | `10 // 3` | `3` |
| `%` | Modulo | `10 % 3` | `1` |
| `**` | Exponent | `2 ** 3` | `8` |

### Division: Python vs C++

**Key difference:**
```python
# Python - Always returns float
print(10 / 3)  # 3.3333333333333335

# Python - Floor division returns int
print(10 // 3)  # 3

# C++ - Integer division (if both are int)
// 10 / 3 = 3 (loses decimal)
```

### Floor Division (`//`)

```python
# Regular division
print(10 / 3)  # 3.3333...

# Floor division (rounds down)
print(10 // 3)  # 3
print(15 // 4)  # 3
print(-10 // 3)  # -4 (rounds down, not towards zero!)

# Useful for splitting items
candies = 17
children = 5
per_child = candies // children  # 3
print(f"Each child gets {per_child} candies")
```

### Modulo (`%`)

**Get the remainder:**
```python
print(10 % 3)  # 1
print(15 % 4)  # 3
print(20 % 5)  # 0 (perfectly divisible)
```

**Common uses:**

**Check even/odd:**
```python
number = 7
if number % 2 == 0:
    print("Even")
else:
    print("Odd")  # This prints
```

**Cycle through values:**
```python
# Hour wraps after 24
hour = 25
valid_hour = hour % 24  # 1
```

**Distribute items:**
```python
total_students = 23
groups = 4
per_group = total_students // groups  # 5
leftover = total_students % groups  # 3
print(f"{per_group} students per group, {leftover} left over")
```

### Exponent (`**`)

**Power operation:**
```python
print(2 ** 3)  # 8 (2^3)
print(10 ** 2)  # 100 (10^2)
print(5 ** 0)  # 1 (anything^0 = 1)

# Square root
print(9 ** 0.5)  # 3.0 (square root of 9)
print(16 ** 0.5)  # 4.0
```

**Compare with C++:**
```cpp
// C++ needs pow() function
#include <cmath>
result = pow(2, 3);  // 8

# Python - Built-in operator
result = 2 ** 3  # 8
```

## Comparison Operators

**Compare values, returns True or False:**

| Operator | Meaning | Example | Result |
|----------|---------|---------|--------|
| `==` | Equal | `5 == 5` | `True` |
| `!=` | Not equal | `5 != 3` | `True` |
| `>` | Greater than | `10 > 5` | `True` |
| `<` | Less than | `3 < 8` | `True` |
| `>=` | Greater or equal | `5 >= 5` | `True` |
| `<=` | Less or equal | `4 <= 3` | `False` |

**Examples:**
```python
age = 18
print(age >= 18)  # True
print(age < 18)  # False

score = 85
passing = 75
print(score >= passing)  # True

# String comparison (alphabetical)
print("apple" < "banana")  # True
print("Tian" == "tian")  # False (case-sensitive)
```

## Logical Operators

**Combine conditions:**

| Operator | Meaning | Example | Result |
|----------|---------|---------|--------|
| `and` | Both must be True | `True and True` | `True` |
| `or` | At least one True | `True or False` | `True` |
| `not` | Reverses boolean | `not True` | `False` |

**Python uses words (and, or, not), C++ uses symbols (&&, ||, !)**

### AND Operator

```python
age = 20
has_id = True

# Both conditions must be true
can_enter = age >= 18 and has_id
print(can_enter)  # True

# Scholarship eligibility
gpa = 90
income = 25000
qualifies = gpa >= 85 and income <= 30000
print(qualifies)  # True
```

### OR Operator

```python
has_wifi = False
has_data = True

# At least one must be true
can_connect = has_wifi or has_data
print(can_connect)  # True

# Discount eligibility
age = 65
is_pwd = False
gets_discount = age >= 60 or is_pwd
print(gets_discount)  # True (senior citizen)
```

### NOT Operator

```python
is_raining = False
is_sunny = not is_raining
print(is_sunny)  # True

is_logged_in = False
if not is_logged_in:
    print("Please log in")  # This prints
```

### Chaining Comparisons

**Python feature not in C++:**
```python
# Python - Natural way
age = 25
is_adult = 18 <= age <= 65
print(is_adult)  # True

# C++ equivalent
// (age >= 18) && (age <= 65)

# Multiple comparisons
x = 5
print(1 < x < 10)  # True (x is between 1 and 10)
```

## Assignment Operators

### Basic Assignment

```python
x = 10  # Assign 10 to x
```

### Compound Assignment

**Shortcuts for common operations:**

| Operator | Example | Equivalent |
|----------|---------|------------|
| `+=` | `x += 5` | `x = x + 5` |
| `-=` | `x -= 3` | `x = x - 3` |
| `*=` | `x *= 2` | `x = x * 2` |
| `/=` | `x /= 4` | `x = x / 4` |
| `//=` | `x //= 3` | `x = x // 3` |
| `%=` | `x %= 3` | `x = x % 3` |
| `**=` | `x **= 2` | `x = x ** 2` |

**Examples:**
```python
balance = 5000
balance += 1500  # Deposit: 6500
balance -= 800  # Withdrawal: 5700
print(balance)

score = 100
score *= 1.1  # 10% bonus: 110.0
print(score)
```

## Membership Operators

**Check if value exists in sequence:**

```python
# in operator
fruits = ["apple", "banana", "mango"]
print("apple" in fruits)  # True
print("grape" in fruits)  # False

# not in operator
print("grape" not in fruits)  # True

# String membership
text = "Hello, World!"
print("World" in text)  # True
print("Python" in text)  # False
```

## Identity Operators

**Check if variables point to same object:**

```python
# is operator
x = [1, 2, 3]
y = [1, 2, 3]
z = x

print(x == y)  # True (same values)
print(x is y)  # False (different objects)
print(x is z)  # True (same object)

# is not operator
print(x is not y)  # True
```

**Note:** Use `==` for value comparison, `is` for identity comparison.

## Operator Precedence

**Order of operations (highest to lowest):**

1. `**` (Exponent)
2. `*`, `/`, `//`, `%` (Multiplication, Division)
3. `+`, `-` (Addition, Subtraction)
4. `<`, `<=`, `>`, `>=`, `==`, `!=` (Comparison)
5. `not` (Logical NOT)
6. `and` (Logical AND)
7. `or` (Logical OR)

**Examples:**
```python
result = 5 + 3 * 2  # 11 (not 16)
result = (5 + 3) * 2  # 16 (parentheses first)

result = 10 > 5 and 20 < 30  # True
result = not False or True and False  # True

# Use parentheses for clarity!
result = (10 > 5) and (20 < 30)  # Much clearer
```

## Practical Examples

### Example 1: GCash Calculator

```python
# GCash transaction
balance = 5000.00
print(f"Initial Balance: ₱{balance}")

# Send money
balance -= 500.00
print(f"After sending: ₱{balance}")

# Receive payment
balance += 1200.00
print(f"After receiving: ₱{balance}")

# Check if sufficient for withdrawal
withdrawal = 300.00
has_enough = balance >= withdrawal
print(f"Can withdraw ₱{withdrawal}: {has_enough}")
```

### Example 2: Discount Calculator

```python
# Product price
price = 1500.00
age = 65
is_pwd = False

# Senior (60+) or PWD gets 20% discount
qualifies = age >= 60 or is_pwd
discount_rate = 0.20 if qualifies else 0.00

discount = price * discount_rate
final_price = price - discount

print(f"Original: ₱{price}")
print(f"Discount: ₱{discount}")
print(f"Final: ₱{final_price}")
```

### Example 3: Grade Calculator

```python
# Student scores
quiz1 = 85
quiz2 = 92
exam = 88

# Calculate average
total = quiz1 + quiz2 + exam
average = total / 3

# Check if passed
passing_grade = 75
passed = average >= passing_grade

print(f"Average: {average:.2f}")
print(f"Status: {'PASSED' if passed else 'FAILED'}")

# With honors?
honors_grade = 90
with_honors = average >= honors_grade and passed
print(f"With Honors: {with_honors}")
```

### Example 4: Jeepney Fare

```python
# Jeepney fare calculator
base_fare = 13.00
base_distance = 4  # km
extra_rate = 2.00  # per km

distance = 7.5  # km traveled

# Calculate fare
if distance <= base_distance:
    fare = base_fare
else:
    extra_distance = distance - base_distance
    fare = base_fare + (extra_distance * extra_rate)

print(f"Distance: {distance} km")
print(f"Fare: ₱{fare:.2f}")
```

## Programming Exercises

### Exercise 1: Calculator

**Task:** Create a simple calculator with all arithmetic operations.

**Solution:**
```python
a = 10
b = 3

print(f"Numbers: {a} and {b}")
print(f"Addition: {a + b}")
print(f"Subtraction: {a - b}")
print(f"Multiplication: {a * b}")
print(f"Division: {a / b:.2f}")
print(f"Floor Division: {a // b}")
print(f"Modulo: {a % b}")
print(f"Exponent: {a ** b}")
```

### Exercise 2: Temperature Converter

**Task:** Convert Celsius to Fahrenheit: F = (C * 9/5) + 32

**Solution:**
```python
celsius = 30
fahrenheit = (celsius * 9/5) + 32
print(f"{celsius}°C = {fahrenheit}°F")
```

### Exercise 3: Even or Odd

**Task:** Check if number is even or odd.

**Solution:**
```python
number = 17
is_even = number % 2 == 0
result = "Even" if is_even else "Odd"
print(f"{number} is {result}")
```

### Exercise 4: Scholarship Checker

**Task:** Check eligibility: GPA >= 85 AND income <= 30000

**Solution:**
```python
gpa = 90
income = 25000

qualifies = gpa >= 85 and income <= 30000
print(f"GPA: {gpa}")
print(f"Income: ₱{income}")
print(f"Qualified: {qualifies}")
```

## Common Mistakes

### Mistake 1: Division Types

**Wrong assumption:**
```python
result = 10 / 2  # Expecting 5 (int)
print(result)  # 5.0 (float)
```

**Correct:**
```python
result = 10 // 2  # Use // for integer result
print(result)  # 5
```

### Mistake 2: Boolean Capitalization

**Wrong:**
```python
is_active = true  # NameError
```

**Correct:**
```python
is_active = True  # Capital T
```

### Mistake 3: Comparison vs Assignment

**Wrong:**
```python
if x = 5:  # SyntaxError
    print("Five")
```

**Correct:**
```python
if x == 5:  # Use == for comparison
    print("Five")
```

### Mistake 4: String and Number

**Wrong:**
```python
age = 16
message = "Age: " + age  # TypeError
```

**Correct:**
```python
age = 16
message = "Age: " + str(age)  # Convert to string
# Or use f-string
message = f"Age: {age}"
```

## Summary

**Key Takeaways:**

1. **Arithmetic operators:** `+`, `-`, `*`, `/`, `//`, `%`, `**`
2. **Division:** `/` always returns float, `//` returns integer
3. **Comparison:** `==`, `!=`, `>`, `<`, `>=`, `<=`
4. **Logical:** `and`, `or`, `not` (words, not symbols!)
5. **Membership:** `in`, `not in`
6. **Assignment:** `=`, `+=`, `-=`, `*=`, `/=`, etc.
7. **Precedence:** Use parentheses for clarity
8. **Chaining:** Python allows `18 <= age <= 65`

**Python vs C++:**
- Python: `and`, `or`, `not`
- C++: `&&`, `||`, `!`

**Next Lesson Preview:**
In Lesson 4, you'll learn about **input and output** - how to get user input with `input()`, format output beautifully with f-strings, and handle type conversions for user data!

Ready to interact with users? Let's continue!
