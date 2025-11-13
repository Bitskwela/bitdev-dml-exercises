# Quiz: Functions

---

# Quiz 1

## Scenario

Tian is organizing his code into reusable functions for a jeepney fare calculator and grade management system. Kuya Miguel tests his understanding of function concepts.

---

## Question 1

What's the output?

```python
def greet():
    print("Hello!")

greet()
```

**Choices:**
- A) Hello!
- B) greet()
- C) None
- D) Error

**Correct Answer:** A

**Explanation:**
The function is defined with `def greet():` and called with `greet()`. When called, it executes the print statement, outputting "Hello!".

---

## Question 2

What's wrong with this code?

```python
def greet()
    print("Hello")
```

**Choices:**
- A) Nothing, it's correct
- B) Missing colon after parentheses
- C) Function name is invalid
- D) Missing return statement

**Correct Answer:** B

**Explanation:**
Function definitions require a colon `:` after the parameters:
```python
def greet():
    print("Hello")
```

---

## Question 3

What's the output?

```python
def add(a, b):
    return a + b

result = add(5, 3)
print(result)
```

**Choices:**
- A) 5 3
- B) 8
- C) None
- D) add(5, 3)

**Correct Answer:** B

**Explanation:**
The function `add()` takes two parameters, adds them, and returns the result. `add(5, 3)` returns `5 + 3 = 8`, which is stored in `result` and printed.

---

## Question 4

What's the difference?

```python
# Function A
def calculate(x):
    return x * 2

# Function B
def calculate(x):
    print(x * 2)
```

**Choices:**
- A) They're the same
- B) Function A returns a value, Function B just prints
- C) Function B is better
- D) Function A has an error

**Correct Answer:** B

**Explanation:**
- Function A: `return x * 2` - returns the value, can be used in expressions
- Function B: `print(x * 2)` - only prints, returns None

Example:
```python
result = calculate(5)  # With A: result=10, with B: result=None
```

Use `return` when you need to use the result later!

---

## Question 5

What's the output?

```python
def greet(name="Friend"):
    print(f"Hello, {name}!")

greet("Tian")
greet()
```

**Choices:**
- A) Hello, Tian! and Hello, Friend!
- B) Hello, Tian! only
- C) Error: missing argument
- D) Hello, Friend! twice

**Correct Answer:** A

**Explanation:**
`name="Friend"` is a default parameter. If no argument is provided, it uses the default:
- `greet("Tian")` → "Hello, Tian!"
- `greet()` → "Hello, Friend!" (uses default)

---

## Question 6

What happens with this function?

```python
def calculate():
    x = 10
    return x * 2

result = calculate()
print(x)
```

**Choices:**
- A) Prints 10
- B) Prints 20
- C) NameError: x is not defined
- D) Prints None

**Correct Answer:** C

**Explanation:**
Variables created inside functions are LOCAL - they only exist inside the function. `x` is not accessible outside `calculate()`, so trying to print it causes a NameError.

---

## Question 7

What's the output?

```python
def get_info():
    name = "Tian"
    age = 16
    return name, age

result = get_info()
print(result)
```

**Choices:**
- A) Tian 16
- B) ('Tian', 16)
- C) ['Tian', 16]
- D) Error: can't return multiple values

**Correct Answer:** B

**Explanation:**
Functions can return multiple values as a tuple: `('Tian', 16)`. To unpack:
```python
name, age = get_info()  # name="Tian", age=16
```

---

## Question 8

What's the output?

```python
count = 0

def increment():
    global count
    count += 1

increment()
increment()
print(count)
```

**Choices:**
- A) 0
- B) 1
- C) 2
- D) Error

**Correct Answer:** C

**Explanation:**
The `global` keyword allows the function to modify the global variable `count`. Each call increments it:
1. First call: count = 1
2. Second call: count = 2

Without `global`, you'd get an UnboundLocalError.

---

# Quiz 2

## Scenario

Tian continues learning functions with more complex scenarios. Kuya Miguel tests his advanced understanding.

---

## Question 1

Tian creates a fare calculator. What's the output?

```python
def calculate_fare(distance, discount=0):
    fare = 13 + max(0, distance - 4) * 2
    return fare * (1 - discount)

print(calculate_fare(5))
print(calculate_fare(5, 0.2))
```

**Choices:**
- A) 15.0 and 12.0
- B) 15 and 15
- C) 13.0 and 10.4
- D) Error: missing argument

**Correct Answer:** A

**Explanation:**
- First call: `distance=5, discount=0 (default)` → fare = 13 + (5-4)*2 = 15, with 0% discount = 15.0
- Second call: `distance=5, discount=0.2` → fare = 15, with 20% discount = 15 * 0.8 = 12.0

---

## Question 10

What's the output?

```python
def mystery(x):
    if x > 0:
        return "Positive"
    elif x < 0:
        return "Negative"

result = mystery(0)
print(result)
```

**Choices:**
- A) Positive
- B) Negative
- C) None
- D) 0

**Correct Answer:** C

**Explanation:**
When `x=0`, neither condition is True, so no return statement executes. Functions without an explicit return statement return `None` by default.

To fix, add:
```python
else:
    return "Zero"
```

---

## Question 11

What's the output?

```python
def double(n):
    return n * 2

numbers = [1, 2, 3, 4]
doubled = [double(n) for n in numbers]
print(doubled)
```

**Choices:**
- A) [1, 2, 3, 4]
- B) [2, 4, 6, 8]
- C) [11, 22, 33, 44]
- D) Error

**Correct Answer:** B

**Explanation:**
The list comprehension calls `double()` for each number:
- double(1) = 2
- double(2) = 4
- double(3) = 6
- double(4) = 8

Result: `[2, 4, 6, 8]`

---

## Question 12

What's a lambda function equivalent to?

```python
add = lambda x, y: x + y
```

**Choices:**
- A) 
```python
def add(x, y):
    return x + y
```
- B)
```python
def add(x, y):
    print(x + y)
```
- C)
```python
add = x + y
```
- D) Invalid syntax

**Correct Answer:** A

**Explanation:**
Lambda functions are anonymous one-line functions. `lambda x, y: x + y` is equivalent to a regular function that returns `x + y`. Lambdas always return the expression (no explicit return needed).

---

## Question 13

What happens when calling this function?

```python
def greet(name):
    print(f"Hello, {name}!")

greet()
```

**Choices:**
- A) Hello, !
- B) Hello, None!
- C) TypeError: missing required positional argument
- D) Hello, name!

**Correct Answer:** C

**Explanation:**
The function requires one argument (`name`), but none was provided. This raises a TypeError. To make it optional, use a default parameter: `def greet(name="Friend"):`

---

## Question 14

What's the output?

```python
def calculate(x, y):
    """Calculate sum and product."""
    return x + y, x * y

total, product = calculate(5, 3)
print(total)
```

**Choices:**
- A) 8
- B) 15
- C) (8, 15)
- D) 8 15

**Correct Answer:** A

**Explanation:**
The function returns two values as a tuple: `(8, 15)`. Tuple unpacking assigns:
- `total = 8` (sum)
- `product = 15` (product)

Printing `total` outputs `8`.

---

## Question 15

What's wrong with this code?

```python
def add(a, b):
    result = a + b

total = add(5, 3)
print(total)
```

**Choices:**
- A) Nothing, prints 8
- B) Prints None (forgot return)
- C) Error: invalid function
- D) Prints "result"

**Correct Answer:** B

**Explanation:**
The function calculates `result` but never returns it. Without a `return` statement, functions return `None` by default. The output is `None`.

Fix:
```python
def add(a, b):
    result = a + b
    return result  # Or: return a + b
```

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- Function definition: `def name(parameters):`
- Function calls require parentheses: `function()`
- `return` sends back values, `print()` just displays
- Default parameters: `def func(x=default):`
- Local scope: variables inside functions are local
- `global` keyword to modify global variables
- Functions can return multiple values (as tuple)
- Colon `:` required after function definition

**Quiz 2:**
- Default parameters with calculations
- Functions without return return `None`
- Using functions in list comprehensions
- Lambda functions: `lambda args: expression`
- Missing arguments cause TypeError
- Tuple unpacking for multiple return values
- Docstrings document functions (triple quotes)
- Always use `return` to send values back

Excellent work! Functions are essential for organizing code. Ready to learn about dictionaries next?
