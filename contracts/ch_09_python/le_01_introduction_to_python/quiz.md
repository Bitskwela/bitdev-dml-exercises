# Quiz: Introduction to Python

---

# Quiz 1

## Scenario

Tian just finished installing Python and is excited to write his first programs. Kuya Miguel gives him some code snippets to test his understanding.

---

## Question 1

Tian wants to display a welcome message. Which code will work correctly?

```python
# Option A
Print("Welcome to Python!")

# Option B
print("Welcome to Python!")

# Option C
PRINT("Welcome to Python!")

# Option D
print "Welcome to Python!"
```

**Choices:**
- A) Option A
- B) Option B
- C) Option C
- D) Option D

**Correct Answer:** B

**Explanation:**
Python is case-sensitive, so the correct function name is `print()` with lowercase 'p'. Option A and C use incorrect capitalization. Option D is missing parentheses - that's Python 2 syntax, not Python 3.

---

## Question 2

Tian writes this code. What will happen?

```python
print("Hello")
  print("World")
```

**Choices:**
- A) It prints both lines correctly
- B) IndentationError occurs
- C) Only "Hello" is printed
- D) SyntaxError: invalid syntax

**Correct Answer:** B

**Explanation:**
The second `print` statement has unnecessary indentation. Python uses indentation to define code blocks, so unexpected indentation causes an IndentationError. The correct code should have both print statements at the same indentation level (no spaces before either).

---

## Question 3

Kuya Miguel asks Tian: "What's different about Python compared to C++ or JavaScript?" Tian writes this code:

```python
x = 10
print(x)
y = "Hello"
print(y)
```

**What Python feature is demonstrated here?**

**Choices:**
- A) Static typing - must declare types
- B) Dynamic typing - no need to declare types
- C) Weak typing - any type can be mixed
- D) Strong typing - types cannot change

**Correct Answer:** B

**Explanation:**
Python uses dynamic typing. You don't need to declare variable types like `int x = 10` (C++) or `let x = 10` (JavaScript). Python automatically determines the type based on the value assigned. The same variable can even be reassigned to different types later (though not recommended for clarity).

---

## Question 4

Tian wants to write a multi-line comment. Which is correct?

```python
# Option A
/* This is a comment
   spanning multiple lines */

# Option B
// This is a comment
// spanning multiple lines

# Option C
"""This is a comment
spanning multiple lines"""

# Option D
<!-- This is a comment
     spanning multiple lines -->
```

**Choices:**
- A) Option A (C-style)
- B) Option B (JavaScript-style)
- C) Option C (triple quotes)
- D) Option D (HTML-style)

**Correct Answer:** C

**Explanation:**
Python uses triple quotes (`"""` or `'''`) for multi-line strings, which are often used as multi-line comments. Option A is C/JavaScript syntax, Option B is single-line comments repeated, and Option D is HTML syntax. While technically a string literal, triple-quoted strings at the start of functions serve as docstrings.

---

## Question 5

Tian writes this code to calculate the sum of two numbers:

```python
result = 5 + 10
print("The sum is " + result)
```

**What will happen?**

**Choices:**
- A) Prints: The sum is 15
- B) TypeError: can only concatenate str to str
- C) Prints: The sum is 510
- D) SyntaxError: invalid syntax

**Correct Answer:** B

**Explanation:**
You cannot concatenate a string with an integer using `+` in Python. The correct solutions are:
```python
print("The sum is " + str(result))  # Convert to string
print("The sum is", result)          # Use comma
print(f"The sum is {result}")        # Use f-string (best)
```

---

## Question 6

Kuya Miguel shows Tian this code:

```python
x = 5
y = 10
print(x + y)
```

**Tian needs to write this in C++ style. Which is the equivalent?**

```cpp
// Option A
int x = 5;
int y = 10;
cout << x + y << endl;

// Option B
x = 5
y = 10
console.log(x + y)

// Option C
let x = 5;
let y = 10;
console.log(x + y);

// Option D
var x = 5;
var y = 10;
System.out.println(x + y);
```

**Choices:**
- A) Option A (C++)
- B) Option B (Mixed)
- C) Option C (JavaScript)
- D) Option D (Java)

**Correct Answer:** A

**Explanation:**
Option A is correct C++ syntax with type declarations (`int`), semicolons, and `cout` for output. The question asks for C++ equivalent. Option B mixes Python and JavaScript syntax, Option C is JavaScript, and Option D is Java.

---

## Question 7

Tian runs this code. What's the output?

```python
print("Hello, World!")
print("My name is Tian")
print("I am learning Python")
```

**Choices:**
- A) All three lines on one line: Hello, World!My name is TianI am learning Python
- B) Each print on separate lines (3 lines total)
- C) Error: too many print statements
- D) Only the first line prints

**Correct Answer:** B

**Explanation:**
Each `print()` statement automatically adds a newline at the end, so each message appears on its own line. To print on the same line, you would use `print("text", end=" ")` or concatenate before printing.

---

## Question 8

Tian wants to check his Python version. Which command should he use in the terminal?

**Choices:**
- A) python --version
- B) python -v
- C) py --version
- D) Both A and C

**Correct Answer:** D

**Explanation:**
Both `python --version` and `py --version` work to check Python version. On Windows, `py` is the Python launcher that helps manage multiple Python versions. On Mac/Linux, `python3 --version` is common. The `-v` flag (Option B) is for verbose mode, not version checking.

---

## Question 9

Kuya Miguel asks: "What file extension do Python files use?" Tian sees these options:

**Choices:**
- A) .python
- B) .py
- C) .pyt
- D) .txt

**Correct Answer:** B

**Explanation:**
Python files use the `.py` extension. For example: `hello.py`, `calculator.py`, `game.py`. While you could technically save Python code in a `.txt` file, `.py` is the standard extension that lets the system know it's a Python script and enables syntax highlighting in editors.

---

## Question 10

Tian writes his first program:

```python
print("Hello, Python!")
# This is my first program
print("Let's learn together!")
```

**What happens to the line starting with `#`?**

**Choices:**
- A) It prints "This is my first program"
- B) It causes a syntax error
- C) It is ignored by Python (it's a comment)
- D) It prints but in a different color

**Correct Answer:** C

**Explanation:**
Lines starting with `#` are comments in Python. They are completely ignored by the Python interpreter and are used to explain code to human readers. Comments don't affect program execution at all. They're essential for documenting your code and making it easier to understand.

---

# Quiz 2

## Scenario

Tian continues practicing Python basics. Kuya Miguel gives him more code challenges to solidify his understanding.

---

## Question 1

Kuya Miguel shows Tian this code:

```python
x = 5
y = 10
print(x + y)
```

**Tian needs to write this in C++ style. Which is the equivalent?**

```cpp
// Option A
int x = 5;
int y = 10;
cout << x + y << endl;

// Option B
x = 5
y = 10
console.log(x + y)

// Option C
let x = 5;
let y = 10;
console.log(x + y);

// Option D
var x = 5;
var y = 10;
System.out.println(x + y);
```

**Choices:**
- A) Option A (C++)
- B) Option B (Mixed)
- C) Option C (JavaScript)
- D) Option D (Java)

**Correct Answer:** A

**Explanation:**
Option A is correct C++ syntax with type declarations (`int`), semicolons, and `cout` for output. The question asks for C++ equivalent. Option B mixes Python and JavaScript syntax, Option C is JavaScript, and Option D is Java.

---

## Question 2

Tian runs this code. What's the output?

```python
print("Hello, World!")
print("My name is Tian")
print("I am learning Python")
```

**Choices:**
- A) All three lines on one line: Hello, World!My name is TianI am learning Python
- B) Each print on separate lines (3 lines total)
- C) Error: too many print statements
- D) Only the first line prints

**Correct Answer:** B

**Explanation:**
Each `print()` statement automatically adds a newline at the end, so each message appears on its own line. To print on the same line, you would use `print("text", end=" ")` or concatenate before printing.

---

## Question 3

Tian wants to check his Python version. Which command should he use in the terminal?

**Choices:**
- A) python --version
- B) python -v
- C) py --version
- D) Both A and C

**Correct Answer:** D

**Explanation:**
Both `python --version` and `py --version` work to check Python version. On Windows, `py` is the Python launcher that helps manage multiple Python versions. On Mac/Linux, `python3 --version` is common. The `-v` flag (Option B) is for verbose mode, not version checking.

---

## Question 4

Kuya Miguel asks: "What file extension do Python files use?" Tian sees these options:

**Choices:**
- A) .python
- B) .py
- C) .pyt
- D) .txt

**Correct Answer:** B

**Explanation:**
Python files use the `.py` extension. For example: `hello.py`, `calculator.py`, `game.py`. While you could technically save Python code in a `.txt` file, `.py` is the standard extension that lets the system know it's a Python script and enables syntax highlighting in editors.

---

## Question 5

Tian writes his first program:

```python
print("Hello, Python!")
# This is my first program
print("Let's learn together!")
```

**What happens to the line starting with `#`?**

**Choices:**
- A) It prints "This is my first program"
- B) It causes a syntax error
- C) It is ignored by Python (it's a comment)
- D) It prints but in a different color

**Correct Answer:** C

**Explanation:**
Lines starting with `#` are comments in Python. They are completely ignored by the Python interpreter and are used to explain code to human readers. Comments don't affect program execution at all. They're essential for documenting your code and making it easier to understand.

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- `print()` function syntax (lowercase, with parentheses)
- Indentation rules in Python
- Dynamic typing
- Comments (single-line `#` and multi-line `"""`)
- Type errors when mixing strings and numbers

**Quiz 2:**
- Comparison with other languages (C++, JavaScript)
- Multiple print statements and newlines
- Python version checking commands
- File extensions (.py)
- Comments in Python

Great job completing both quizzes! Understanding these basics is crucial for your Python journey. Ready for variables and data types next? Let's continue!
