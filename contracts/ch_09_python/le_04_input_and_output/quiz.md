# Quiz: Input and Output

---

# Quiz 1

## Scenario

Tian is building interactive programs that need user input and formatted output. Kuya Miguel tests his understanding of input/output operations.

---

## Question 1

Tian wants to get user's name. What's the correct code?

**Choices:**
- A) `name = input("Enter name: ")`
- B) `name = input(Enter name: )`
- C) `name = get("Enter name: ")`
- D) `name = read("Enter name: ")`

**Correct Answer:** A

**Explanation:**
`input()` is the correct function to get user input in Python. The prompt text must be a string (in quotes). There are no `get()` or `read()` functions for standard input in Python.

---

## Question 2

Tian writes this code. What's the data type of `age`?

```python
age = input("Enter your age: ")
print(type(age))
```

**User types: 16**

**Choices:**
- A) `<class 'int'>`
- B) `<class 'float'>`
- C) `<class 'str'>`
- D) `<class 'number'>`

**Correct Answer:** C

**Explanation:**
`input()` ALWAYS returns a string, regardless of what the user types. Even if the user types numbers, it's stored as a string `"16"`, not integer `16`. To use it as a number, you must convert it: `age = int(input("Enter your age: "))`

---

## Question 3

What happens with this code?

```python
age = int(input("Enter age: "))
next_year = age + 1
print(next_year)
```

**User types: 16**

**Choices:**
- A) Prints: 161
- B) Prints: 17
- C) TypeError
- D) ValueError

**Correct Answer:** B

**Explanation:**
Since `age` is converted to int immediately with `int()`, it becomes the integer `16`. Then `age + 1` correctly calculates `16 + 1 = 17`. Without the conversion, it would be string concatenation resulting in "161".

---

## Question 4

Tian wants to display name and age on one line. Which is BEST?

```python
name = "Tian"
age = 16
```

**Choices:**
- A) `print("Name: " + name + " Age: " + str(age))`
- B) `print("Name:", name, "Age:", age)`
- C) `print(f"Name: {name} Age: {age}")`
- D) All work, but C is best (f-strings)

**Correct Answer:** D

**Explanation:**
All three options work correctly:
- Option A requires manual string conversion and concatenation (verbose)
- Option B uses comma separation (simple)
- Option C uses f-strings (most readable and Pythonic)

F-strings (Option C) are generally preferred for their clarity and ability to include expressions inside `{}`.

---

## Question 5

What's the output?

```python
price = 99.99
print(f"Price: ₱{price:.1f}")
```

**Choices:**
- A) Price: ₱99.99
- B) Price: ₱100.0
- C) Price: ₱99.9
- D) Price: ₱100

**Correct Answer:** C

**Explanation:**
The format specifier `.1f` means:
- `.1` = one decimal place
- `f` = floating-point format

So `99.99` rounded to 1 decimal place is `99.9`. For 2 decimals, use `.2f` → `99.99`.

---

## Question 6

Tian displays a large number:

```python
amount = 1500000
print(f"₱{amount:,}")
```

**What's the output?**

**Choices:**
- A) ₱1500000
- B) ₱1,500,000
- C) ₱1 500 000
- D) ₱1.500.000

**Correct Answer:** B

**Explanation:**
The comma `,` in the format specifier `{amount:,}` adds thousands separators. Python uses commas by default (US format). This makes large numbers much more readable.

---

# Quiz 2

## Scenario

Tian continues learning about input and output with more advanced formatting. Kuya Miguel gives him challenging tasks.

---

## Question 1

What's the output?

```python
print("Hello", end=" ")
print("World")
```

**Choices:**
- A) Hello World (on one line)
- B) Hello<br>World (two lines)
- C) HelloWorld (no space)
- D) Error: invalid parameter

**Correct Answer:** A

**Explanation:**
The `end=" "` parameter changes what's printed at the end of the line. By default, `print()` ends with a newline (`\n`), but here it's changed to a space. So both prints appear on the same line: "Hello World".

---

## Question 8

Tian creates a receipt. What's the output?

```python
item = "Coke"
price = 25.00
print(f"{item:<10} ₱{price:>8.2f}")
```

**Choices:**
- A) Coke       ₱   25.00
- B) Coke ₱25.00
- C) Coke                 ₱   25.00
- D) Error: invalid format

**Correct Answer:** A

**Explanation:**
Format specifiers:
- `{item:<10}` = left-align in 10 characters: "Coke      "
- `{price:>8.2f}` = right-align in 8 characters with 2 decimals: "   25.00"

This creates a nicely aligned receipt format.

---

## Question 9

What happens with this code?

```python
score = float(input("Enter score: "))
percentage = score / 100
print(f"Percentage: {percentage:.1%}")
```

**User types: 85**

**Choices:**
- A) Percentage: 0.85
- B) Percentage: 85.0%
- C) Percentage: 0.9%
- D) Percentage: 85%

**Correct Answer:** B

**Explanation:**
Step by step:
1. `score = 85.0` (converted to float)
2. `percentage = 85.0 / 100 = 0.85`
3. `.1%` format multiplies by 100 and adds %, with 1 decimal: `85.0%`

The `%` formatter is useful for displaying percentages.

---

## Question 10

Tian wants to display multiple values:

```python
a, b, c = 10, 20, 30
print(a, b, c, sep="-")
```

**What's the output?**

**Choices:**
- A) 10 20 30
- B) 10-20-30
- C) 102030
- D) abc

**Correct Answer:** B

**Explanation:**
The `sep="-"` parameter changes the separator between values from the default space to a hyphen. So `print(a, b, c, sep="-")` outputs `10-20-30`.

---

## Question 11

What error occurs?

```python
age = int(input("Enter age: "))
```

**User types: hello**

**Choices:**
- A) No error, age = 0
- B) TypeError
- C) ValueError: invalid literal for int()
- D) SyntaxError

**Correct Answer:** C

**Explanation:**
`int()` can only convert strings that represent valid integers (like "16", "100"). When the user types "hello", Python raises a `ValueError` because "hello" cannot be converted to an integer. In production code, you'd want to handle this with try-except.

---

## Question 12

Tian creates a centered title:

```python
title = "MENU"
print(f"{title:^20}")
```

**What's the output?**

**Choices:**
- A) MENU________________ (left-aligned)
- B) ________MENU________ (centered)
- C) ________________MENU (right-aligned)
- D) MENU (no padding)

**Correct Answer:** B

**Explanation:**
The `^20` format specifier centers the text in a field of 20 characters. "MENU" (4 chars) is centered with 8 spaces on each side. Use `<` for left-align, `>` for right-align, and `^` for center-align.

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- `input()` function always returns string
- Type conversion needed: `int(input())`, `float(input())`
- F-strings are best for formatted output: `f"text {variable}"`
- Format specifiers for decimals: `.1f`, `.2f`
- Thousands separator: `,`
- Multiple ways to display variables

**Quiz 2:**
- `print()` parameters: `sep` and `end`
- Advanced formatting:
  - Width & alignment: `<` (left), `>` (right), `^` (center)
  - Percentage format: `.1%`
- ValueError when converting invalid strings with `int()`
- Creating formatted receipts and displays
- Separator control between printed values

Excellent! You now know how to make your programs interactive. Ready to learn about control flow with conditionals?
