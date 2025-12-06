# Quiz: Lesson 8 - Logical Operators and Compound Conditions

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
What is the result of this expression?
```cpp
bool result = (5 > 3) && (10 < 20);
```

A) `true`  
B) `false`  
C) Compilation error  
D) Undefined

**Answer: A) `true`**

**Explanation:**
Both conditions are true:
- `5 > 3` is true
- `10 < 20` is true
- `true && true` = **true**

---

### Question 2
What does this code output?
```cpp
int age = 65;
bool isPWD = false;

if (age >= 60 || isPWD) {
    cout << "Discount applied";
} else {
    cout << "No discount";
}
```

A) `Discount applied`  
B) `No discount`  
C) Compilation error  
D) Nothing

**Answer: A) `Discount applied`**

**Explanation:**
The OR operator (`||`) returns true if **at least one** condition is true:
- `age >= 60` is true (65 >= 60)
- Since the first condition is true, the entire expression is true
- Due to short-circuit evaluation, `isPWD` is not even checked

---

### Question 3
What is the output?
```cpp
bool hasID = true;
bool hasPaid = false;

if (hasID && hasPaid) {
    cout << "Approved";
} else {
    cout << "Denied";
}
```

A) `Approved`  
B) `Denied`  
C) Both print  
D) Nothing prints

**Answer: B) `Denied`**

**Explanation:**
The AND operator (`&&`) requires **both** conditions to be true:
- `hasID` is true
- `hasPaid` is false
- `true && false` = **false**
- Therefore, the else block executes

---

### Question 4
What does the `!` operator do?

A) Checks if values are not equal  
B) Reverses a boolean value  
C) Performs division  
D) Concatenates strings

**Answer: B) Reverses a boolean value**

**Explanation:**
The NOT operator (`!`) flips the boolean value:
- `!true` becomes `false`
- `!false` becomes `true`

Example:
```cpp
bool isLoggedIn = false;
if (!isLoggedIn) {  // If NOT logged in
    cout << "Please log in";
}
```

---

### Question 5
Which expression is equivalent to `!(x > 10 && y < 5)` using DeMorgan's Law?

A) `x <= 10 && y >= 5`  
B) `x <= 10 || y >= 5`  
C) `x > 10 || y < 5`  
D) `!(x <= 10 || y >= 5)`

**Answer: B) `x <= 10 || y >= 5`**

**Explanation:**
DeMorgan's Law states: `!(A && B)` = `!A || !B`

Breaking it down:
- Original: `!(x > 10 && y < 5)`
- Apply DeMorgan: `!(x > 10) || !(y < 5)`
- Simplify negations: `x <= 10 || y >= 5`

---


# Quiz 2

### Question 6
What happens with short-circuit evaluation in this code?
```cpp
int x = 5;
if (x < 3 && x > 0) {
    cout << "True";
}
```

A) Both conditions are checked  
B) Only the first condition is checked  
C) Only the second condition is checked  
D) Neither condition is checked

**Answer: B) Only the first condition is checked**

**Explanation:**
Short-circuit evaluation for AND (`&&`):
- First condition: `x < 3` is **false** (5 is not less than 3)
- Since AND requires both to be true, and the first is already false, the result is determined
- The second condition `x > 0` is never evaluated
- This saves computation time

---




### Question 7
What is the output?
```cpp
bool a = true;
bool b = false;
bool c = true;

if (a && b || c) {
    cout << "Pass";
} else {
    cout << "Fail";
}
```

A) `Pass`  
B) `Fail`  
C) Compilation error  
D) Undefined behavior

**Answer: A) `Pass`**

**Explanation:**
Operator precedence: `&&` has higher precedence than `||`
- Evaluated as: `(a && b) || c`
- Step 1: `a && b` = `true && false` = `false`
- Step 2: `false || c` = `false || true` = `true`
- Result: "Pass" is printed

---

### Question 8
Which condition correctly checks if age is between 18 and 65 (inclusive)?

A) `age >= 18 || age <= 65`  
B) `age >= 18 && age <= 65`  
C) `age > 18 && age < 65`  
D) `!(age < 18 || age > 65)`

**Answer: B) `age >= 18 && age <= 65`**

**Explanation:**
To check if a value is within a range, use AND:
- Must be **at least** 18: `age >= 18`
- Must be **at most** 65: `age <= 65`
- Both must be true: use `&&`

Option A is wrong because it uses OR, which would be true for almost all ages.
Option C excludes 18 and 65.
Option D is correct logically (DeMorgan's Law) but option B is clearer.

---

### Question 9
What is wrong with this code?
```cpp
int age = 20;
if (age = 18) {
    cout << "Adult";
}
```

A) Nothing, it's correct  
B) Using `=` instead of `==`  
C) Missing parentheses  
D) Wrong variable type

**Answer: B) Using `=` instead of `==`**

**Explanation:**
- `=` is the **assignment** operator (sets a value)
- `==` is the **comparison** operator (checks equality)

This code assigns 18 to age (age becomes 18), then checks if 18 is true (non-zero is true), so "Adult" always prints.

**Fix:**
```cpp
if (age == 18) {  // Use == for comparison
    cout << "Adult";
}
```

---


# Quiz 1

### Question 10
A barangay clearance requires: valid ID AND (paid dues OR has waiver). Which code is correct?

```cpp
// Option A
if (hasID && hasPaid || hasWaiver) {
    cout << "Approved";
}

// Option B
if (hasID && (hasPaid || hasWaiver)) {
    cout << "Approved";
}

// Option C
if (hasID || hasPaid && hasWaiver) {
    cout << "Approved";
}
```

A) Option A  
B) Option B  
C) Option C  
D) All are correct

**Answer: B) Option B**

**Explanation:**
The requirement is: `ID AND (payment OR waiver)`

- **Option A**: Without parentheses, evaluated as `(hasID && hasPaid) || hasWaiver`
  - This would approve if there's a waiver even without ID! Wrong.

- **Option B**: Correctly uses parentheses: `hasID && (hasPaid || hasWaiver)`
  - Requires ID, and either payment or waiver. Correct! ✓

- **Option C**: Evaluated as `hasID || (hasPaid && hasWaiver)`
  - Would approve with just ID, even without payment or waiver. Wrong.

**Key lesson:** Use parentheses to make your intent clear!

```cpp
bool hasID = true, hasPaid = false, hasWaiver = true;

// Option B correctly evaluates:
if (hasID && (hasPaid || hasWaiver)) {
    // true && (false || true)
    // true && true
    // = true ✓ Approved
}
```

---

**Score yourself:**
- 10/10: Logic Master! 🏆
- 8-9: Excellent grasp of operators!
- 6-7: Good, review operator precedence
- Below 6: Practice more compound conditions

**Key Concepts to Remember:**
1. `&&` requires ALL conditions true
2. `||` requires AT LEAST ONE condition true
3. `!` reverses the boolean value
4. Short-circuit: AND stops at first false, OR stops at first true
5. Use `==` for comparison, not `=`
6. Use parentheses for clarity in complex conditions
7. `&&` has higher precedence than `||`
