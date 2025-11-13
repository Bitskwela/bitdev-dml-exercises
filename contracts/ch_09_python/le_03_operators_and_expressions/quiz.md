# Quiz: Operators and Expressions

---

# Quiz 1

## Scenario

Tian is building a jeepney fare calculator and needs to use various Python operators. Kuya Miguel tests his understanding through practical coding challenges.

---

## Question 1

Tian calculates the base fare:

```python
distance = 5
fare = 13 + (distance - 4) * 2
print(fare)
```

**What's the output?**

**Choices:**
- A) 15
- B) 17
- C) 19
- D) 21

**Correct Answer:** A

**Explanation:**
Following operator precedence: 
1. Parentheses first: `(5 - 4) = 1`
2. Multiplication: `1 * 2 = 2`
3. Addition: `13 + 2 = 15`

The fare is ₱15.

---

## Question 2

Tian needs to divide 17 by 4. What's the result of each operator?

```python
print(17 / 4)   # Regular division
print(17 // 4)  # Floor division
print(17 % 4)   # Modulus
```

**Choices:**
- A) 4.25, 4, 1
- B) 4, 4, 1
- C) 4.25, 4.0, 1.0
- D) 4, 4.25, 1

**Correct Answer:** A

**Explanation:**
- `/` performs regular division: `17 / 4 = 4.25` (float)
- `//` performs floor division (rounds down): `17 // 4 = 4` (int)
- `%` returns remainder: `17 % 4 = 1` (17 = 4×4 + 1)

---

## Question 3

What's the result of this code?

```python
x = 10
result = x ** 2
print(result)
```

**Choices:**
- A) 20
- B) 100
- C) 1010
- D) Error: invalid syntax

**Correct Answer:** B

**Explanation:**
`**` is the exponentiation (power) operator in Python. `x ** 2` means x², which is 10² = 100. This is different from `^` which is the XOR operator in Python, not exponentiation.

---

## Question 4

Tian checks if a student passes:

```python
score = 85
passing = score >= 75
print(passing)
```

**What's the output and type?**

**Choices:**
- A) 1, int
- B) True, bool
- C) "True", str
- D) 85, int

**Correct Answer:** B

**Explanation:**
`score >= 75` is a comparison that returns a boolean value. Since 85 is greater than or equal to 75, the result is `True` (type `bool`). Comparison operators (`>`, `<`, `>=`, `<=`, `==`, `!=`) always return True or False.

---

## Question 5

What's the output?

```python
x = 5
y = 5
z = 10
result = x == y and y != z
print(result)
```

**Choices:**
- A) True
- B) False
- C) 5
- D) 10

**Correct Answer:** A

**Explanation:**
Breaking it down:
- `x == y` → `5 == 5` → `True`
- `y != z` → `5 != 10` → `True`
- `True and True` → `True`

The `and` operator returns True only when both conditions are True.

---

## Question 6

Tian writes this code. What's the output?

```python
age = 16
eligible = age >= 18 or age >= 60
print(eligible)
```

**Choices:**
- A) True
- B) False
- C) 16
- D) Error

**Correct Answer:** B

**Explanation:**
Breaking it down:
- `age >= 18` → `16 >= 18` → `False`
- `age >= 60` → `16 >= 60` → `False`
- `False or False` → `False`

The `or` operator returns True if at least one condition is True. Here, both are False, so the result is False.

---

# Quiz 2

## Scenario

Tian continues building his jeepney fare calculator with more complex operator challenges. Kuya Miguel tests his advanced understanding.

---

## Question 1

What's the result?

```python
is_raining = False
result = not is_raining
print(result)
```

**Choices:**
- A) True
- B) False
- C) not False
- D) Error

**Correct Answer:** A

**Explanation:**
The `not` operator reverses a boolean value. `not False` becomes `True`, and `not True` becomes `False`. This is useful for reversing conditions.

---

## Question 8

Tian checks if a number is in a list:

```python
number = 5
numbers = [1, 2, 3, 4, 5]
result = number in numbers
print(result)
```

**What's the output?**

**Choices:**
- A) 5
- B) True
- C) 4 (the index)
- D) False

**Correct Answer:** B

**Explanation:**
The `in` operator checks if a value exists in a sequence (list, string, tuple, etc.). Since 5 is in the list, it returns `True`. To get the index instead, you'd use `numbers.index(5)` which returns `4`.

---

## Question 9

What's the output?

```python
x = 10
y = 10
result = x is y
print(result)
```

**Choices:**
- A) True (they're equal)
- B) False (they're different variables)
- C) 10
- D) Error: invalid operator

**Correct Answer:** A

**Explanation:**
The `is` operator checks if two variables point to the same object in memory. For small integers (-5 to 256), Python reuses the same object for efficiency, so `x is y` returns `True`. Note: `is` checks identity, while `==` checks equality. For most cases, use `==` for value comparison.

---

## Question 10

Tian calculates a discount:

```python
price = 100
discount = 0.20
final_price = price * (1 - discount)
print(final_price)
```

**What's the output?**

**Choices:**
- A) 80.0
- B) 20.0
- C) 80
- D) 120.0

**Correct Answer:** A

**Explanation:**
Step by step:
1. `1 - discount` → `1 - 0.20` → `0.80`
2. `price * 0.80` → `100 * 0.80` → `80.0`

The result is `80.0` (float) because one of the operands is a float (0.20).

---

## Question 11

What's the result of this expression?

```python
result = 10 + 5 * 2
print(result)
```

**Choices:**
- A) 30
- B) 20
- C) 15
- D) 25

**Correct Answer:** B

**Explanation:**
Operator precedence: Multiplication happens before addition.
1. `5 * 2 = 10`
2. `10 + 10 = 20`

To get 30, you'd need parentheses: `(10 + 5) * 2 = 30`

---

## Question 12

Tian checks eligibility for discount:

```python
age = 17
is_student = True
gets_discount = (age < 18 or age >= 60) and is_student
print(gets_discount)
```

**What's the output?**

**Choices:**
- A) True
- B) False
- C) 17
- D) Error

**Correct Answer:** A

**Explanation:**
Breaking it down:
1. `age < 18` → `17 < 18` → `True`
2. `age >= 60` → `17 >= 60` → `False`
3. `True or False` → `True`
4. `True and is_student` → `True and True` → `True`

The student is under 18, so eligible for discount.

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- Arithmetic operators: `+`, `-`, `*`, `/`, `//`, `%`, `**`
- Operator precedence (PEMDAS)
- Division types: regular `/` vs floor `//` vs modulus `%`
- Comparison operators: `>=`, `<=`, `==`, `!=`
- Logical operators: `and`, `or`
- Boolean results from comparisons

**Quiz 2:**
- Logical `not` operator for reversing booleans
- Membership operator `in` for checking if value exists in sequence
- Identity operator `is` for checking object identity
- Complex expressions with parentheses
- Operator precedence with multiple operators
- Combining logical operators (and, or) with comparisons

Great work! Understanding operators is crucial for building logic in your programs. Ready to learn about input and output next?
