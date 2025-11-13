# Lesson 5: Control Flow - Conditionals

## Background Story

"Kuya Miguel, my programs just run from top to bottom," Tian said. "How do I make them smarter - like doing different things based on conditions?"

"Ah, you need **conditionals**!" Kuya Miguel explained. "Think of it like traffic lights: if red, stop; if yellow, slow down; if green, go. That's exactly how `if`, `elif`, and `else` work in Python!"

## The `if` Statement

### Basic Syntax

```python
if condition:
    # code runs if condition is True
    # Must be indented!
```

**Example:**
```python
age = 18

if age >= 18:
    print("You can vote!")
```

**How it works:**
1. Evaluate condition (age >= 18)
2. If True, run indented code
3. If False, skip indented code

### Indentation is CRITICAL!

**Python uses indentation to define code blocks.**

**Wrong:**
```python
if age >= 18:
print("Can vote")  # IndentationError!
```

**Correct:**
```python
if age >= 18:
    print("Can vote")  # Must be indented (4 spaces or 1 tab)
```

**Multiple statements:**
```python
if age >= 18:
    print("You can vote!")
    print("You are an adult.")
    print("Welcome!")
# All three print statements run if True
```

## The `else` Statement

**Syntax:**
```python
if condition:
    # runs if True
else:
    # runs if False
```

**Example:**
```python
age = 15

if age >= 18:
    print("You can vote!")
else:
    print("You cannot vote yet.")
```

**Only ONE block runs:**
- If condition is True → if block runs
- If condition is False → else block runs
- Never both!

## The `elif` Statement

**Use when you have multiple conditions to check.**

**Syntax:**
```python
if condition1:
    # runs if condition1 is True
elif condition2:
    # runs if condition1 is False AND condition2 is True
elif condition3:
    # runs if condition1 and condition2 are False AND condition3 is True
else:
    # runs if all conditions are False
```

**Example:**
```python
score = 85

if score >= 90:
    print("Grade: A")
elif score >= 80:
    print("Grade: B")
elif score >= 70:
    print("Grade: C")
elif score >= 60:
    print("Grade: D")
else:
    print("Grade: F")
```

**How it works:**
1. Check first condition (score >= 90) → False
2. Check second condition (score >= 80) → True
3. Run that block, **skip all others**
4. Never check remaining elif or else

**Order matters!**

**Wrong order:**
```python
score = 85

if score >= 60:  # This is True!
    print("D")  # Prints D, never checks others
elif score >= 80:  # Never reached!
    print("B")
```

**Correct order (highest to lowest):**
```python
if score >= 90:
    print("A")
elif score >= 80:
    print("B")
# etc.
```

## Comparison Operators (Review)

```python
==  # Equal to
!=  # Not equal to
>   # Greater than
<   # Less than
>=  # Greater than or equal to
<=  # Less than or equal to
```

**Examples:**
```python
x = 10

if x == 10:  # True
if x != 5:   # True
if x > 8:    # True
if x < 20:   # True
if x >= 10:  # True
if x <= 10:  # True
```

## Logical Operators

### `and` - Both must be True

```python
age = 20
has_id = True

if age >= 18 and has_id:
    print("Can enter bar")
```

**Truth table:**
```
True and True   → True
True and False  → False
False and True  → False
False and False → False
```

### `or` - At least one must be True

```python
day = "Saturday"

if day == "Saturday" or day == "Sunday":
    print("It's the weekend!")
```

**Truth table:**
```
True or True   → True
True or False  → True
False or True  → True
False or False → False
```

### `not` - Reverses True/False

```python
is_raining = False

if not is_raining:
    print("Let's go outside!")
```

**Truth table:**
```
not True  → False
not False → True
```

### Combining Operators

```python
age = 25
student = True
employed = False

if (age >= 18 and student) or employed:
    print("Eligible for discount")
```

**Use parentheses for clarity!**

## Nested Conditionals

**Conditionals inside conditionals:**

```python
age = 20
has_license = True

if age >= 18:
    print("Old enough to drive")
    if has_license:
        print("Can drive legally")
    else:
        print("Need to get a license")
else:
    print("Too young to drive")
```

**Watch your indentation:**
- First level: 4 spaces
- Second level: 8 spaces
- Third level: 12 spaces

## Practical Examples

### Example 1: Jeepney Fare with Discounts

```python
distance = float(input("Distance (km): "))
age = int(input("Age: "))

BASE_FARE = 13.00
BASE_DISTANCE = 4
EXTRA_RATE = 2.00

# Calculate base fare
if distance <= BASE_DISTANCE:
    fare = BASE_FARE
else:
    extra = distance - BASE_DISTANCE
    fare = BASE_FARE + (extra * EXTRA_RATE)

# Apply discounts
if age < 18:
    discount = 0.20  # 20% student discount
    print("Student discount applied!")
elif age >= 60:
    discount = 0.20  # 20% senior discount
    print("Senior discount applied!")
else:
    discount = 0.00
    
final_fare = fare * (1 - discount)

print(f"Base fare: ₱{fare:.2f}")
print(f"Final fare: ₱{final_fare:.2f}")
```

### Example 2: GCash Transfer Validator

```python
balance = float(input("Current balance: "))
amount = float(input("Amount to send: "))
recipient = input("Recipient name: ")

print("\n=== Validating Transaction ===")

if amount <= 0:
    print("Error: Amount must be positive")
elif amount > balance:
    print("Error: Insufficient balance")
elif amount > 50000:
    print("Error: Maximum transfer is ₱50,000")
else:
    new_balance = balance - amount
    print("Success!")
    print(f"Sent ₱{amount:,.2f} to {recipient}")
    print(f"New balance: ₱{new_balance:,.2f}")
```

### Example 3: Grade Calculator with Remarks

```python
score = float(input("Enter score (0-100): "))

if score < 0 or score > 100:
    print("Invalid score!")
elif score >= 90:
    grade = "A"
    remark = "Outstanding"
elif score >= 85:
    grade = "B+"
    remark = "Very Good"
elif score >= 80:
    grade = "B"
    remark = "Good"
elif score >= 75:
    grade = "C+"
    remark = "Satisfactory"
elif score >= 70:
    grade = "C"
    remark = "Passing"
else:
    grade = "F"
    remark = "Failed"

print(f"\nScore: {score}")
print(f"Grade: {grade}")
print(f"Remark: {remark}")

# Pass/Fail
if score >= 70:
    print("Status: PASSED")
else:
    print("Status: FAILED")
```

### Example 4: Sari-Sari Store Inventory Alert

```python
item = input("Item name: ")
stock = int(input("Current stock: "))
reorder_level = int(input("Reorder level: "))

print(f"\n=== {item} Status ===")

if stock == 0:
    print("OUT OF STOCK! Order immediately!")
elif stock < reorder_level:
    needed = reorder_level - stock
    print(f"LOW STOCK! Reorder {needed} units")
elif stock == reorder_level:
    print("At reorder level - consider ordering")
else:
    print("Stock level OK")
    
# Additional check for overstocking
if stock > reorder_level * 3:
    print("Warning: Possible overstock")
```

### Example 5: Login System

```python
USERNAME = "tian"
PASSWORD = "python123"

print("=== Login System ===")
user = input("Username: ")
pwd = input("Password: ")

if user == USERNAME and pwd == PASSWORD:
    print("\nLogin successful!")
    print(f"Welcome back, {user}!")
elif user == USERNAME:
    print("\nIncorrect password!")
elif pwd == PASSWORD:
    print("\nIncorrect username!")
else:
    print("\nBoth username and password are incorrect!")
```

### Example 6: BMI with Categories

```python
weight = float(input("Weight (kg): "))
height = float(input("Height (m): "))

bmi = weight / (height ** 2)

print(f"\nBMI: {bmi:.2f}")

if bmi < 18.5:
    category = "Underweight"
    advice = "Consider gaining weight healthily"
elif bmi < 25:
    category = "Normal weight"
    advice = "Keep up the good work!"
elif bmi < 30:
    category = "Overweight"
    advice = "Consider exercising more"
else:
    category = "Obese"
    advice = "Consult a doctor"

print(f"Category: {category}")
print(f"Advice: {advice}")
```

## Ternary Operator (Conditional Expression)

**Shortcut for simple if-else:**

**Syntax:** `value_if_true if condition else value_if_false`

**Example:**
```python
age = 20
status = "Adult" if age >= 18 else "Minor"
print(status)  # Adult
```

**Equivalent to:**
```python
if age >= 18:
    status = "Adult"
else:
    status = "Minor"
```

**More examples:**
```python
score = 85
grade = "Pass" if score >= 75 else "Fail"

balance = 500
can_buy = "Yes" if balance >= 100 else "No"

temp = 35
weather = "Hot" if temp > 30 else "Cool"
```

**Use for simple cases only! Use full if-else for complex logic.**

## Programming Exercises

### Exercise 1: Voting Eligibility

**Task:** Check if someone can vote (age >= 18) and registered.

**Solution:**
```python
age = int(input("Age: "))
registered = input("Registered? (yes/no): ").lower()

if age >= 18:
    if registered == "yes":
        print("You can vote!")
    else:
        print("Please register first")
else:
    years_left = 18 - age
    print(f"Too young. Wait {years_left} more years")
```

### Exercise 2: Triangle Type Classifier

**Task:** Classify triangle by sides (equilateral, isosceles, scalene).

**Solution:**
```python
a = float(input("Side 1: "))
b = float(input("Side 2: "))
c = float(input("Side 3: "))

# Check valid triangle
if a + b > c and b + c > a and a + c > b:
    if a == b == c:
        print("Equilateral triangle")
    elif a == b or b == c or a == c:
        print("Isosceles triangle")
    else:
        print("Scalene triangle")
else:
    print("Not a valid triangle")
```

### Exercise 3: Electricity Bill Calculator

**Task:** 
- First 100 kWh: ₱10/kWh
- Next 100 kWh: ₱12/kWh
- Above 200 kWh: ₱15/kWh

**Solution:**
```python
usage = float(input("kWh used: "))

if usage <= 100:
    bill = usage * 10
elif usage <= 200:
    bill = (100 * 10) + ((usage - 100) * 12)
else:
    bill = (100 * 10) + (100 * 12) + ((usage - 200) * 15)

print(f"Total bill: ₱{bill:,.2f}")
```

### Exercise 4: Rock-Paper-Scissors

**Task:** Determine winner.

**Solution:**
```python
p1 = input("Player 1 (rock/paper/scissors): ").lower()
p2 = input("Player 2 (rock/paper/scissors): ").lower()

if p1 == p2:
    print("It's a tie!")
elif (p1 == "rock" and p2 == "scissors") or \
     (p1 == "paper" and p2 == "rock") or \
     (p1 == "scissors" and p2 == "paper"):
    print("Player 1 wins!")
else:
    print("Player 2 wins!")
```

## Common Mistakes

### Mistake 1: Using = Instead of ==

**Wrong:**
```python
if x = 10:  # SyntaxError!
```

**Correct:**
```python
if x == 10:  # Comparison
```

### Mistake 2: Missing Colon

**Wrong:**
```python
if age >= 18
    print("Adult")  # SyntaxError!
```

**Correct:**
```python
if age >= 18:
    print("Adult")
```

### Mistake 3: Wrong Indentation

**Wrong:**
```python
if age >= 18:
print("Adult")  # IndentationError!
```

**Correct:**
```python
if age >= 18:
    print("Adult")
```

### Mistake 4: elif Without if

**Wrong:**
```python
elif score >= 80:  # SyntaxError!
    print("B")
```

**Correct:**
```python
if score >= 90:
    print("A")
elif score >= 80:
    print("B")
```

### Mistake 5: else with Condition

**Wrong:**
```python
else age < 18:  # SyntaxError!
    print("Minor")
```

**Correct:**
```python
else:
    print("Minor")
```

## Summary

**Key Takeaways:**

1. **if:** Run code if condition is True
2. **else:** Run code if condition is False
3. **elif:** Check multiple conditions
4. **Indentation:** Use 4 spaces (critical!)
5. **Comparison:** ==, !=, >, <, >=, <=
6. **Logical:** and, or, not
7. **Order:** Check most specific conditions first

**Quick reference:**
```python
if condition1:
    # code
elif condition2:
    # code
else:
    # code
```

**Ternary:**
```python
result = value1 if condition else value2
```

**Next Lesson Preview:**
In Lesson 6, you'll learn about **loops** - how to repeat code multiple times using `for` and `while` loops. You'll automate repetitive tasks and process collections of data!

Ready to make your programs even more powerful? Let's continue!
