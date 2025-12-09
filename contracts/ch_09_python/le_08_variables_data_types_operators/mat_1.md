## Background Story

The morning heat was already stifling when Rhea Joy arrived at the barangay hall with a problem. "Kuya Tian, the scholarship calculator is giving weird results. I entered an applicant with a grade of 95, but the output says they qualify for 951 pesos instead of the correct amount." Tian frowned and pulled up the code. After a few minutes of head-scratching, he found the culprit: he'd been treating text input as a number without converting it, so Python was concatenating strings instead of adding numbers.

"Ugh, data types," Tian groaned. "Why does Python care if it's a number or text? Can't it just figure it out?" Kuya Miguel, who was helping organize some paper files nearby, chuckled. "Would you add 'five pesos' to 'ten pesos' the same way you'd add 5 + 10? Context matters. Computers need to know if you're doing math or building sentences."

Rhea Joy pulled out her notebook, eager to understand. "So strings are for text, integers for whole numbers, floats for decimals... what else?" Miguel nodded. "Booleans for true/false, lists for collections. Each type has different operations. You can multiply numbers, but multiplying a string by 3 just repeats it three times—'ha' * 3 becomes 'hahaha'."

They spent the afternoon reviewing the entire scholarship calculation script, adding proper type conversions: `int()` for ages, `float()` for GPAs, `str()` for formatting output messages. They learned about operators—arithmetic (+, -, *, /), comparison (==, !=, <, >), and logical (and, or, not). By evening, the calculator worked flawlessly, handling all inputs correctly. The scholarship system was becoming precise, one properly typed variable at a time. 🔢⚖️

---

## Theory & Lecture Content

### 1. Variables & Assignment
Name binds to object:
```python
count = 42
barangay = "Sto. Niño"
```
Rebinding changes reference, not in-place mutation for immutables.

### 2. Core Built-in Types
| Type | Example | Mutable? | Notes |
|------|---------|----------|-------|
| int | 7 | No | Arbitrary precision |
| float | 3.14 | No | IEEE 754 |
| bool | True | No | Subclass of int |
| str | "Ana" | No | Unicode sequence |
| list | [1,2] | Yes | Dynamic array |
| tuple | (1,2) | No | Immutable sequence |
| dict | {"a":1} | Yes | Hash map |
| set | {1,2} | Yes | Unique unordered values |

### 3. Numeric Operators
```python
5 + 2   # addition
5 - 2   # subtraction
5 * 2   # multiplication
5 / 2   # float division → 2.5
5 // 2  # floor division → 2
5 % 2   # modulo → 1
5 ** 2  # exponent → 25
```

### 4. Comparison & Boolean Logic
```python
a == b
a != b
a > b; a < b; a >= b; a <= b
(age > 18) and is_active
(age < 13) or has_permission
not is_archived
```

### 5. Truthiness
Falsy: 0, 0.0, "", [], {}, set(), None. Non-empty / non-zero → truthy.
```python
if tags:  # list non-empty?
	process(tags)
```

### 6. String Operations
```python
full = first + " " + last
upper = full.upper()
parts = full.split()
f"Name: {full}"  # f-string interpolation
"Barangay".startswith("Bara")
```

### 7. Type Conversion (Casting)
```python
int("7")
str(42)
float("3.5")
list("ABC")
```
Handle errors with try/except for user input.

### 8. Identity vs Equality
```python
x = [1,2]
y = [1,2]
x == y      # True (value equality)
x is y      # False (distinct objects)
```

### 9. Operator Precedence (Snapshot)
** > unary + - > * / // % > + - > comparisons > not > and > or.
Use parentheses for clarity.

### 10. Augmented Assignment
```python
total = 0
total += 5
count *= 2
tags_list.extend(["New"])
```

### 11. Immutability Nuance
Rebinding string:
```python
name = "Ana"
name += " Cruz"  # creates new string
```
Lists mutate in place.

### 12. Story Thread
Type mismatch bug fixed by validating numeric input before arithmetic; logic becomes predictable.

---

## Closing Story

Tian stared at the error: `TypeError: unsupported operand type(s) for +: 'int' and 'str'`. The scholarship calculator was adding ages from a form, but somehow `"17" + 18` was crashing instead of equaling 35.

"Type mismatch," Kuya Miguel diagnosed immediately. "User input comes as strings. You need to convert before arithmetic."

They added validation:

```python
# Before: Crashes on string input
total_age = form_data["age"] + 18

# After: Safe conversion with fallback
try:
    age = int(form_data.get("age", 0))
    total_age = age + 18
except ValueError:
    logger.error("Invalid age format")
    age = 0
```

Rhea Joy was testing operators at her terminal:

```python
>>> residents = ["Ana", "Ben", "Carlo"]
>>> if residents:  # Truthiness!
...     print(f"Found {len(residents)} residents")
Found 3 residents
```

"Wait," she said, "I don't need `if len(residents) > 0`. I can just check if the list itself is truthy?"

"Exactly," Kuya Miguel smiled. "Empty collections are falsy. Non-empty are truthy. Same with empty strings, None, zero. Python's truthiness makes code cleaner."

Tian refactored a dozen conditionals, replacing verbose comparisons with simple truthiness checks:

```python
# Before: Verbose
if resident_name != "" and resident_name is not None:
    process(resident_name)

# After: Pythonic
if resident_name:
    process(resident_name)
```

"Understanding types and operators isn't just technical knowledge," Kuya Miguel said. "It's about thinking in Python's paradigm. Dynamic typing with strong type safety. Truthiness for clean logic. Operators that work consistently across types."

Tian ran the test suite. All passing. The scholarship calculator now handled edge cases gracefully: string inputs converted safely, empty values treated correctly, operations performed on compatible types.

_Next up: Input/Output Basics—interacting with users and files!_ 📝

**Next:** Quiz then exercises.
