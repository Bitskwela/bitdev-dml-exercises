# Lesson 6: Loops

## Background Story

"Kuya, I have to print numbers 1 to 100," Tian complained. "Do I really need to write 100 print statements?"

Kuya Miguel laughed. "Absolutely not! That's where **loops** come in. Write the code once, repeat it many times. Let me show you Python's `for` and `while` loops - they'll save you tons of time!"

## The `for` Loop

**Use for loops when you know HOW MANY times to repeat.**

### Basic Syntax

```python
for variable in sequence:
    # code to repeat
    # variable changes each iteration
```

### Loop Through a Range

**`range(stop)`** - 0 to stop-1
```python
for i in range(5):
    print(i)

# Output:
# 0
# 1
# 2
# 3
# 4
```

**Note:** range(5) gives 0, 1, 2, 3, 4 (5 numbers, starting at 0)

**`range(start, stop)`** - start to stop-1
```python
for i in range(1, 6):
    print(i)

# Output:
# 1
# 2
# 3
# 4
# 5
```

**`range(start, stop, step)`** - with custom increment
```python
# Count by 2s
for i in range(0, 10, 2):
    print(i)
# Output: 0, 2, 4, 6, 8

# Count backwards
for i in range(10, 0, -1):
    print(i)
# Output: 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
```

### Loop Through Strings

```python
name = "Tian"

for letter in name:
    print(letter)

# Output:
# T
# i
# a
# n
```

### Loop Through Lists (Preview)

```python
fruits = ["apple", "banana", "mango"]

for fruit in fruits:
    print(fruit)

# Output:
# apple
# banana
# mango
```

## The `while` Loop

**Use while loops when you DON'T KNOW how many times to repeat (based on condition).**

### Basic Syntax

```python
while condition:
    # code to repeat
    # must eventually make condition False!
```

### Example

```python
count = 0

while count < 5:
    print(count)
    count = count + 1  # IMPORTANT: update the variable!

# Output: 0, 1, 2, 3, 4
```

**How it works:**
1. Check condition (count < 5)
2. If True, run code block
3. Go back to step 1
4. If False, exit loop

**Warning:** Must update the variable, or infinite loop!

**Infinite loop (BAD):**
```python
count = 0
while count < 5:
    print(count)
    # Forgot to update count!
    # This runs forever!
```

## `break` Statement

**Exit the loop immediately, regardless of condition.**

```python
for i in range(10):
    print(i)
    if i == 5:
        break  # Exit loop when i is 5

# Output: 0, 1, 2, 3, 4, 5
```

**Use case: Search**
```python
numbers = [10, 20, 30, 40, 50]
target = 30

for num in numbers:
    if num == target:
        print(f"Found {target}!")
        break  # No need to continue
```

**With while:**
```python
balance = 1000

while True:  # Infinite loop
    withdraw = float(input("Withdraw (0 to exit): "))
    
    if withdraw == 0:
        break  # Exit loop
        
    if withdraw > balance:
        print("Insufficient funds")
    else:
        balance -= withdraw
        print(f"New balance: ₱{balance:.2f}")

print("Thank you!")
```

## `continue` Statement

**Skip the rest of current iteration, go to next iteration.**

```python
for i in range(10):
    if i % 2 == 0:  # If even
        continue  # Skip to next iteration
    print(i)

# Output: 1, 3, 5, 7, 9 (only odd numbers)
```

**Use case: Skip invalid data**
```python
for i in range(1, 6):
    if i == 3:
        continue  # Skip when i is 3
    print(i)

# Output: 1, 2, 4, 5 (3 is skipped)
```

## Nested Loops

**Loops inside loops:**

```python
for i in range(1, 4):  # Outer loop
    for j in range(1, 4):  # Inner loop
        print(f"i={i}, j={j}")

# Output:
# i=1, j=1
# i=1, j=2
# i=1, j=3
# i=2, j=1
# i=2, j=2
# i=2, j=3
# i=3, j=1
# i=3, j=2
# i=3, j=3
```

**Multiplication table:**
```python
for i in range(1, 6):
    for j in range(1, 6):
        product = i * j
        print(f"{i} x {j} = {product}")
    print()  # Blank line after each group
```

## `else` with Loops

**Loop's else runs if loop completes normally (no break).**

```python
for i in range(5):
    print(i)
else:
    print("Loop completed!")

# Output: 0, 1, 2, 3, 4, Loop completed!
```

**With break (else doesn't run):**
```python
for i in range(5):
    if i == 3:
        break
    print(i)
else:
    print("Loop completed!")  # Doesn't print!

# Output: 0, 1, 2
```

**Use case: Search**
```python
numbers = [10, 20, 30, 40]
target = 25

for num in numbers:
    if num == target:
        print("Found!")
        break
else:
    print("Not found!")  # Runs if break never happens
```

## Practical Examples

### Example 1: Sum of Numbers

```python
# Sum 1 to 100
total = 0

for i in range(1, 101):
    total = total + i

print(f"Sum: {total}")  # 5050
```

### Example 2: Countdown Timer

```python
import time  # For sleep function

seconds = int(input("Countdown seconds: "))

while seconds > 0:
    print(f"{seconds}...")
    time.sleep(1)  # Wait 1 second
    seconds -= 1

print("Time's up!")
```

### Example 3: GCash PIN Validator

```python
CORRECT_PIN = "1234"
attempts = 3

while attempts > 0:
    pin = input("Enter PIN: ")
    
    if pin == CORRECT_PIN:
        print("Access granted!")
        break
    else:
        attempts -= 1
        if attempts > 0:
            print(f"Wrong PIN! {attempts} attempts left")
        else:
            print("Account locked!")
```

### Example 4: Grade Averager

```python
print("Enter grades (type 'done' to finish):")

total = 0
count = 0

while True:
    grade_input = input("Grade: ")
    
    if grade_input.lower() == "done":
        break
        
    grade = float(grade_input)
    total += grade
    count += 1

if count > 0:
    average = total / count
    print(f"\nGrades entered: {count}")
    print(f"Average: {average:.2f}")
else:
    print("No grades entered")
```

### Example 5: Multiplication Table

```python
num = int(input("Enter number: "))

print(f"\nMultiplication table for {num}:")
print("="*25)

for i in range(1, 11):
    result = num * i
    print(f"{num} x {i:2} = {result:3}")
```

### Example 6: Jeepney Passenger Counter

```python
capacity = 16
passengers = 0

print("=== Jeepney Passenger Counter ===")
print("Commands: board [n], exit [n], stop")

while True:
    command = input("\nCommand: ").lower().split()
    
    if command[0] == "stop":
        print(f"Final passengers: {passengers}")
        break
    
    action = command[0]
    count = int(command[1]) if len(command) > 1 else 1
    
    if action == "board":
        if passengers + count <= capacity:
            passengers += count
            print(f"{count} boarded. Total: {passengers}/{capacity}")
        else:
            print("Not enough space!")
    
    elif action == "exit":
        if count <= passengers:
            passengers -= count
            print(f"{count} exited. Total: {passengers}/{capacity}")
        else:
            print("Invalid number!")
```

### Example 7: Sari-Sari Store Daily Sales

```python
print("=== Daily Sales Tracker ===")
print("Enter sales (0 to finish):\n")

total_sales = 0
transaction_count = 0

while True:
    sale = float(input(f"Transaction {transaction_count + 1}: ₱"))
    
    if sale == 0:
        break
    
    if sale < 0:
        print("Invalid amount!")
        continue
    
    total_sales += sale
    transaction_count += 1
    print(f"Running total: ₱{total_sales:.2f}\n")

print("\n=== End of Day Summary ===")
print(f"Total transactions: {transaction_count}")
print(f"Total sales: ₱{total_sales:,.2f}")

if transaction_count > 0:
    average = total_sales / transaction_count
    print(f"Average sale: ₱{average:.2f}")
```

### Example 8: Pattern Printing

```python
# Right triangle
n = 5
for i in range(1, n + 1):
    print("* " * i)

# Output:
# *
# * *
# * * *
# * * * *
# * * * * *
```

```python
# Number pyramid
n = 5
for i in range(1, n + 1):
    # Print spaces
    print(" " * (n - i), end="")
    # Print numbers
    for j in range(1, i + 1):
        print(j, end=" ")
    print()

# Output:
#     1
#    1 2
#   1 2 3
#  1 2 3 4
# 1 2 3 4 5
```

## Loop Control Summary

| Statement | Effect |
|-----------|--------|
| `break` | Exit loop immediately |
| `continue` | Skip to next iteration |
| `pass` | Do nothing (placeholder) |

**`pass` example:**
```python
for i in range(5):
    if i == 2:
        pass  # TODO: add logic later
    else:
        print(i)
```

## Programming Exercises

### Exercise 1: Factorial Calculator

**Task:** Calculate n! = n × (n-1) × (n-2) × ... × 1

**Solution:**
```python
n = int(input("Enter number: "))
factorial = 1

for i in range(1, n + 1):
    factorial *= i

print(f"{n}! = {factorial}")
```

### Exercise 2: Fibonacci Sequence

**Task:** Print first n Fibonacci numbers (1, 1, 2, 3, 5, 8...)

**Solution:**
```python
n = int(input("How many Fibonacci numbers? "))

a, b = 1, 1

for i in range(n):
    print(a, end=" ")
    a, b = b, a + b

print()
```

### Exercise 3: Prime Number Checker

**Task:** Check if number is prime.

**Solution:**
```python
num = int(input("Enter number: "))

if num < 2:
    print("Not prime")
else:
    is_prime = True
    
    for i in range(2, int(num ** 0.5) + 1):
        if num % i == 0:
            is_prime = False
            break
    
    if is_prime:
        print(f"{num} is prime")
    else:
        print(f"{num} is not prime")
```

### Exercise 4: Reverse a Number

**Task:** Reverse digits of a number (123 → 321)

**Solution:**
```python
num = int(input("Enter number: "))
reversed_num = 0

while num > 0:
    digit = num % 10
    reversed_num = reversed_num * 10 + digit
    num = num // 10

print(f"Reversed: {reversed_num}")
```

### Exercise 5: Guess the Number Game

**Task:** Computer picks random number, user guesses.

**Solution:**
```python
import random

secret = random.randint(1, 100)
attempts = 0

print("I'm thinking of a number between 1 and 100")

while True:
    guess = int(input("Your guess: "))
    attempts += 1
    
    if guess < secret:
        print("Too low!")
    elif guess > secret:
        print("Too high!")
    else:
        print(f"Correct! You got it in {attempts} attempts!")
        break
```

## Common Mistakes

### Mistake 1: Off-by-One Error

**Wrong:**
```python
# Want 1 to 10
for i in range(1, 10):  # Only goes to 9!
    print(i)
```

**Correct:**
```python
for i in range(1, 11):  # Goes to 10
    print(i)
```

### Mistake 2: Modifying Loop Variable

**Dangerous:**
```python
for i in range(5):
    print(i)
    i = i + 1  # Doesn't affect loop!
```

### Mistake 3: Forgetting to Update while Variable

**Wrong:**
```python
count = 0
while count < 5:
    print(count)
    # Forgot count += 1 → infinite loop!
```

### Mistake 4: Wrong Indentation

**Wrong:**
```python
for i in range(5):
print(i)  # IndentationError!
```

**Correct:**
```python
for i in range(5):
    print(i)
```

## Summary

**Key Takeaways:**

1. **for loop:** Use when you know iteration count
   - `range(stop)` → 0 to stop-1
   - `range(start, stop)` → start to stop-1
   - `range(start, stop, step)` → with increment

2. **while loop:** Use when based on condition
   - Must update condition variable!
   - Risk of infinite loop

3. **break:** Exit loop immediately
4. **continue:** Skip to next iteration
5. **else:** Runs if loop completes (no break)

**Quick reference:**
```python
# For loop
for i in range(5):
    print(i)

# While loop
count = 0
while count < 5:
    print(count)
    count += 1

# Break and continue
for i in range(10):
    if i == 5:
        break  # Exit
    if i % 2 == 0:
        continue  # Skip
    print(i)
```

**Next Lesson Preview:**
In Lesson 7, you'll learn about **lists** - Python's most versatile data structure for storing collections of items. You'll learn how to create, modify, and manipulate lists!

Ready to level up your Python skills? Let's continue!
