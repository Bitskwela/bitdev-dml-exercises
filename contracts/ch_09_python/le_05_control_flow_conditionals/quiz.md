# Quiz: Control Flow - Conditionals

---

# Quiz 1

## Scenario

Tian is building a grading system and jeepney fare calculator. Kuya Miguel tests his understanding of if, elif, and else statements.

---

## Question 1

What's wrong with this code?

```python
age = 18
if age >= 18
    print("Can vote")
```

**Choices:**
- A) Nothing, it's correct
- B) Missing colon after condition
- C) Missing parentheses around condition
- D) Wrong comparison operator

**Correct Answer:** B

**Explanation:**
Python requires a colon `:` after the if condition. The correct code is:
```python
if age >= 18:
    print("Can vote")
```
Unlike C++ or JavaScript, Python doesn't use parentheses around conditions (though they're allowed).

---

## Question 2

What's the output?

```python
score = 85

if score >= 90:
    print("A")
elif score >= 80:
    print("B")
elif score >= 70:
    print("C")
```

**Choices:**
- A) A
- B) B
- C) C
- D) All three print

**Correct Answer:** B

**Explanation:**
The score is 85, so:
1. `score >= 90` → False
2. `score >= 80` → True → prints "B" and exits

Once a condition is True, the rest are skipped. Only ONE block executes in an if-elif-else chain.

---

## Question 3

Tian writes this code. What happens?

```python
age = 16
has_id = True

if age >= 18 and has_id:
    print("Can enter")
else:
    print("Cannot enter")
```

**Choices:**
- A) Can enter
- B) Cannot enter
- C) Both print
- D) Error

**Correct Answer:** B

**Explanation:**
The condition uses `and`, so BOTH must be True:
- `age >= 18` → `16 >= 18` → False
- `has_id` → True
- `False and True` → False

Since the condition is False, the else block executes: "Cannot enter".

---

## Question 4

What's the output?

```python
day = "Saturday"

if day == "Saturday" or day == "Sunday":
    print("Weekend!")
else:
    print("Weekday")
```

**Choices:**
- A) Weekend!
- B) Weekday
- C) Both print
- D) Error

**Correct Answer:** A

**Explanation:**
The condition uses `or`, so at least ONE must be True:
- `day == "Saturday"` → True

Since the first condition is True, we don't even need to check the second. The result is True, so "Weekend!" prints.

---

## Question 5

Tian calculates jeepney fare. What's the output?

```python
distance = 3
age = 65

if distance <= 4:
    fare = 13
else:
    fare = 13 + (distance - 4) * 2

if age >= 60:
    fare = fare * 0.8

print(f"₱{fare:.2f}")
```

**Choices:**
- A) ₱13.00
- B) ₱10.40
- C) ₱15.00
- D) ₱12.00

**Correct Answer:** B

**Explanation:**
Step by step:
1. Distance is 3 (≤ 4), so `fare = 13`
2. Age is 65 (≥ 60), so apply 20% discount: `fare = 13 * 0.8 = 10.4`
3. Output: ₱10.40

---

## Question 6

What's wrong with this order?

```python
score = 85

if score >= 60:
    print("D")
elif score >= 80:
    print("B")
elif score >= 90:
    print("A")
```

**Choices:**
- A) Nothing, it's correct
- B) Will never check 80 or 90 (wrong order)
- C) Missing else statement
- D) Should use if, not elif

**Correct Answer:** B

**Explanation:**
Since 85 >= 60 is True, it prints "D" and exits - never checking the other conditions! The correct order is highest to lowest:
```python
if score >= 90:
    print("A")
elif score >= 80:
    print("B")
elif score >= 60:
    print("D")
```

---

# Quiz 2

## Scenario

Tian continues building conditional logic with more complex scenarios. Kuya Miguel tests his advanced understanding.

---

## Question 1

What's the output?

```python
x = 10

if x > 5:
    if x > 15:
        print("Very large")
    else:
        print("Medium")
else:
    print("Small")
```

**Choices:**
- A) Very large
- B) Medium
- C) Small
- D) No output

**Correct Answer:** B

**Explanation:**
This is a nested conditional:
1. `x > 5` → `10 > 5` → True (enter first if)
2. `x > 15` → `10 > 15` → False (go to inner else)
3. Prints "Medium"

---

## Question 8

Tian uses a ternary operator:

```python
age = 20
status = "Adult" if age >= 18 else "Minor"
print(status)
```

**What's the output?**

**Choices:**
- A) Adult
- B) Minor
- C) True
- D) Error: invalid syntax

**Correct Answer:** A

**Explanation:**
The ternary operator (conditional expression) has syntax:
`value_if_true if condition else value_if_false`

Since age (20) >= 18 is True, `status = "Adult"`.

---

## Question 9

What's the output?

```python
x = 5
y = 10

if not (x > y):
    print("X is not greater")
```

**Choices:**
- A) X is not greater
- B) No output
- C) X is greater
- D) Error

**Correct Answer:** A

**Explanation:**
Breaking it down:
1. `x > y` → `5 > 10` → False
2. `not False` → True
3. Condition is True, so print executes

The `not` operator reverses the boolean value.

---

## Question 10

Tian validates a transaction. What's the output?

```python
balance = 1000
amount = 1500

if amount <= 0:
    print("Invalid amount")
elif amount > balance:
    print("Insufficient funds")
elif amount > 50000:
    print("Exceeds limit")
else:
    print("Success")
```

**Choices:**
- A) Invalid amount
- B) Insufficient funds
- C) Exceeds limit
- D) Success

**Correct Answer:** B

**Explanation:**
Checking conditions in order:
1. `amount <= 0` → `1500 <= 0` → False
2. `amount > balance` → `1500 > 1000` → True → prints "Insufficient funds" and exits

Even though 1500 < 50000, the third condition is never checked because we already found a True condition.

---

## Question 11

What does this code do?

```python
score = 75

if score >= 70:
    print("PASSED")
    
if score < 70:
    print("FAILED")
```

**Choices:**
- A) Error: can't have two if statements
- B) Prints only PASSED
- C) Prints both PASSED and FAILED
- D) Prints nothing

**Correct Answer:** B

**Explanation:**
These are TWO SEPARATE if statements (not if-else). Both conditions are checked:
1. First if: `75 >= 70` → True → prints "PASSED"
2. Second if: `75 < 70` → False → doesn't print

Using `if-else` would be better here to avoid checking twice.

---

## Question 12

What's the output?

```python
age = 16
student = True

if age < 18 and student:
    discount = 0.20
else:
    discount = 0

print(f"Discount: {discount:.0%}")
```

**Choices:**
- A) Discount: 0%
- B) Discount: 20%
- C) Discount: 0.20%
- D) Discount: 0.2%

**Correct Answer:** B

**Explanation:**
1. `age < 18 and student` → `True and True` → True
2. `discount = 0.20`
3. Format `.0%` converts 0.20 to percentage with 0 decimals: 20%

The `%` formatter multiplies by 100 and adds the percent sign.

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- `if` statement requires colon `:`
- `elif` for multiple conditions (only ONE block executes)
- `else` for default case
- Logical operators: `and` (both true), `or` (at least one true)
- Condition order matters (check most specific first)
- Sequential vs chained if statements

**Quiz 2:**
- Nested conditionals (if inside if)
- Ternary operator: `value_if_true if condition else value_if_false`
- `not` operator reverses boolean
- Multiple independent `if` statements vs `if-elif-else` chain
- Percentage formatting with `.0%`
- Condition evaluation order in elif chains

Great work! Understanding conditionals is essential for program logic. Ready to learn about loops next?
