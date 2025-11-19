## Lesson 8: Variables, Data Types, and Operators

Story: Barangay analytics script mislabels a resident count as a string. “Numbers should behave like numbers,” Rhea Joy reminds Tian. They classify types, assignments, and operators powering calculations and logic.

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

### 13. Practice Prompts
1. Show difference of == vs is on two identical small ints vs lists.
2. Build a Boolean expression combining 3 conditions.
3. Convert a numeric string safely; fallback to 0.
4. Demonstrate modulo for even/odd classification.

### 14. Reflection
List 2 benefits of understanding truthiness when simplifying conditionals.

**Next:** Quiz then exercises.
