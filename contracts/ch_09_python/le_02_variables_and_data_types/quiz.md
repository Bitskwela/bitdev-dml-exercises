# Quiz: Variables and Data Types

---

# Quiz 1

## Scenario

Tian is building a simple student information system. Kuya Miguel tests his understanding of variables and data types through various code challenges.

---

## Question 1

Tian wants to store his age. Which variable name is INVALID in Python?

**Choices:**
- A) age
- B) student_age
- C) 2024_age
- D) age2024

**Correct Answer:** C

**Explanation:**
Variable names cannot start with a number. `2024_age` is invalid. Valid variable names must start with a letter or underscore, followed by letters, numbers, or underscores. Options A, B, and D are all valid.

---

## Question 2

Tian writes this code. What is the data type of `x`?

```python
x = 10
print(type(x))
```

**Choices:**
- A) `<class 'str'>`
- B) `<class 'int'>`
- C) `<class 'float'>`
- D) `<class 'number'>`

**Correct Answer:** B

**Explanation:**
The value `10` is an integer, so `type(x)` returns `<class 'int'>`. Python has specific type names: `int` for integers, `float` for decimals, `str` for strings, etc. There is no generic `number` type.

---

## Question 3

Kuya Miguel asks Tian to store the price ₱99.99. What's the correct data type?

```python
price = 99.99
```

**What type is `price`?**

**Choices:**
- A) int
- B) float
- C) str
- D) decimal

**Correct Answer:** B

**Explanation:**
`99.99` is a decimal number, so Python stores it as a `float` (floating-point number). Integers are whole numbers without decimal points. While Python has a `decimal` module for precise decimal arithmetic, the basic type for decimals is `float`.

---

## Question 4

Tian writes this code. What will be printed?

```python
name = "Tian"
age = 16
print(name + age)
```

**Choices:**
- A) Tian16
- B) TypeError: can only concatenate str (not "int") to str
- C) 16Tian
- D) name + age

**Correct Answer:** B

**Explanation:**
You cannot concatenate a string with an integer directly using `+`. Python will raise a TypeError. To fix this, convert age to string: `print(name + str(age))` or use f-string: `print(f"{name}{age}")` or comma: `print(name, age)`.

---

## Question 5

Tian needs to convert a string to an integer:

```python
score = "85"
```

**Which code correctly converts it?**

**Choices:**
- A) score = int(score)
- B) score = str(score)
- C) score = float(score)
- D) score = number(score)

**Correct Answer:** A

**Explanation:**
`int()` converts strings to integers. Option B (`str()`) would keep it as a string. Option C (`float()`) would convert to `85.0` (floating-point). Option D is invalid - there's no `number()` function in Python.

---

## Question 6

What's the value and type after this code?

```python
x = 10
x = "Hello"
print(x)
print(type(x))
```

**Choices:**
- A) 10, `<class 'int'>`
- B) Hello, `<class 'str'>`
- C) Error: cannot change variable type
- D) HelloHello, `<class 'str'>`

**Correct Answer:** B

**Explanation:**
Python uses dynamic typing - variables can be reassigned to different types. The second assignment (`x = "Hello"`) replaces the integer value with a string. So `x` is now `"Hello"` with type `str`. Unlike C++ or Java, Python doesn't require type declarations and allows type changes.

---

# Quiz 2

## Scenario

Tian continues building his student information system. Kuya Miguel gives him more advanced challenges with data types.

---

## Question 1

Tian writes this code. What's the output?

```python
is_student = True
print(type(is_student))
```

**Choices:**
- A) `<class 'boolean'>`
- B) `<class 'bool'>`
- C) `<class 'true'>`
- D) `<class 'str'>`

**Correct Answer:** B

**Explanation:**
`True` and `False` are boolean values in Python, and their type is `bool` (not `boolean`). Booleans are used for conditions and logic. Note the capital T in `True` and F in `False` - Python is case-sensitive.

---

## Question 8

Kuya Miguel shows Tian this code:

```python
x = y = z = 100
print(x, y, z)
```

**What does this demonstrate?**

**Choices:**
- A) Error: cannot assign multiple variables at once
- B) Multiple assignment - all three variables get value 100
- C) Only z gets 100, others are undefined
- D) Chain assignment - x=y, y=z, z=100

**Correct Answer:** B

**Explanation:**
Python supports multiple assignment (also called chained assignment). `x = y = z = 100` assigns 100 to all three variables simultaneously. This is a shorthand way to initialize multiple variables to the same value.

---

## Question 9

Tian needs to swap two variables. Which code works correctly?

```python
a = 5
b = 10

# Swap them
```

**Choices:**
- A) `a = b` and `b = a`
- B) `a, b = b, a`
- C) `temp = a; a = b; b = a`
- D) `swap(a, b)`

**Correct Answer:** B

**Explanation:**
Option B uses Python's tuple unpacking to swap values elegantly: `a, b = b, a`. Option A just makes both equal to 10. Option C has a bug (should be `b = temp`). Option D - there's no built-in `swap()` function. The traditional way requires a temporary variable:
```python
temp = a
a = b
b = temp
```

---

## Question 10

Tian writes this. What's the result?

```python
price = "100"
tax = 0.12
total = price * (1 + tax)
print(total)
```

**Choices:**
- A) 112.0
- B) TypeError: can't multiply sequence by non-int
- C) 100100100100...
- D) "100" * 1.12

**Correct Answer:** B

**Explanation:**
`price` is a string (`"100"`), not a number. You cannot multiply a string by a float like `1.12`. To fix this, convert price to a number first: `price = int("100")` or `price = float("100")`. Then the calculation would work correctly.

---

## Question 11

What's stored in `result`?

```python
result = None
print(type(result))
```

**Choices:**
- A) `<class 'NoneType'>`
- B) `<class 'null'>`
- C) `<class 'undefined'>`
- D) `<class 'empty'>`

**Correct Answer:** A

**Explanation:**
`None` is Python's way of representing "no value" or "null". Its type is `NoneType`. This is different from JavaScript's `null` or `undefined`, or C++'s `NULL`. `None` is commonly used as a default value or to indicate the absence of a value.

---

## Question 12

Tian needs to check if a variable is a string. Which is correct?

```python
name = "Tian"
```

**Choices:**
- A) `if type(name) == str:`
- B) `if type(name) == "str":`
- C) `if isinstance(name, str):`
- D) Both A and C

**Correct Answer:** D

**Explanation:**
Both Option A and C work correctly. `type(name) == str` compares the type directly. `isinstance(name, str)` is the more Pythonic way and also works with inheritance. Option B is wrong because `str` is a type, not a string `"str"`.

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- Valid variable naming rules (no numbers at start)
- Data types: int, float, str
- `type()` function to check types
- TypeError when mixing string and integer with `+`
- Type conversion: `int()`, `float()`, `str()`
- Dynamic typing - variables can change types

**Quiz 2:**
- Boolean data type: `bool` (True/False)
- Multiple assignment (`x = y = z = 100`)
- Tuple unpacking for swapping (`a, b = b, a`)
- TypeError when mixing string and numeric operations
- `None` represents absence of value (NoneType)
- Type checking with `isinstance()` and `type()`

Excellent work! Understanding data types is fundamental to Python programming. Ready to tackle operators next?
