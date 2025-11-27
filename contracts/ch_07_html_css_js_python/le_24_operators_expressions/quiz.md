# Quiz 1

**Scenario:** Tian is calculating barangay service fees using JavaScript operators.

1. What is the output of `console.log(15 % 4);`?
   - A. `3`
   - B. `3.75`
   - C. `4`
   - D. `11`

2. What does `count += 5;` mean?
   - A. `count = 5`
   - B. `count = count + 5`
   - C. `count = count * 5`
   - D. `5 = count + 5`

3. What is the output of `console.log(10 > 5 && 3 < 2);`?
   - A. `true`
   - B. `false`
   - C. `10`
   - D. Error

4. Which operator should Rhea Joy use for strict equality?
   - A. `=`
   - B. `==`
   - C. `===`
   - D. `!=`

5. What is the output of `console.log(!true);`?
   - A. `true`
   - B. `false`
   - C. `undefined`
   - D. `1`

---

# Quiz 2

**Scenario:** Tian is checking barangay service eligibility using logical operators.

6. What is the output of `console.log("10" + 5);`?
   - A. `15`
   - B. `"15"`
   - C. `"105"`
   - D. Error

7. What does `age >= 18 ? "Adult" : "Minor"` return when `age = 17`?
   - A. `"Adult"`
   - B. `"Minor"`
   - C. `true`
   - D. `false`

8. What is the output of `console.log(true || false);`?
   - A. `true`
   - B. `false`
   - C. `undefined`
   - D. `1`

9. What is `5 === "5"`?
   - A. `true`
   - B. `false`
   - C. `5`
   - D. Error

10. What is the output of `console.log(2 ** 3);`?
    - A. `5`
    - B. `6`
    - C. `8`
    - D. `9`

---

# Answers

1. **A** - `3`
2. **B** - `count = count + 5`
3. **B** - `false`
4. **C** - `===`
5. **B** - `false`
6. **C** - `"105"`
7. **B** - `"Minor"`
8. **A** - `true`
9. **B** - `false`
10. **C** - `8`

---

# Explanations

**Question 1:** The modulo operator `%` returns the **remainder** after division.

```javascript
console.log(15 % 4);  // 3
// 15 ÷ 4 = 3 remainder 3
// 4 × 3 = 12, 15 - 12 = 3

console.log(20 % 5);  // 0 (20 ÷ 5 = 4 remainder 0)
console.log(17 % 5);  // 2 (17 ÷ 5 = 3 remainder 2)
console.log(10 % 3);  // 1 (10 ÷ 3 = 3 remainder 1)
```

**Barangay queue system:**
```javascript
// Check if queue number is divisible by 5
let queueNumber = 15;

if (queueNumber % 5 === 0) {
    console.log("Every 5th person gets priority!");
}

// Check even/odd for alternating colors
let rowNumber = 7;
if (rowNumber % 2 === 0) {
    console.log("Even row");
} else {
    console.log("Odd row");  // This runs (7 % 2 = 1)
}
```

---

**Question 2:** `count += 5` is shorthand for `count = count + 5`.

```javascript
let count = 10;
count += 5;  // Same as: count = count + 5
console.log(count);  // 15
```

**All assignment operators:**
```javascript
let x = 10;

x += 5;   // x = x + 5  → 15
x -= 3;   // x = x - 3  → 12
x *= 2;   // x = x * 2  → 24
x /= 4;   // x = x / 4  → 6
x %= 4;   // x = x % 4  → 2
```

**Barangay visitor tracking:**
```javascript
let todayVisitors = 50;

// New visitor arrives
todayVisitors += 1;
console.log(todayVisitors);  // 51

// Group of 5 arrives
todayVisitors += 5;
console.log(todayVisitors);  // 56

// Someone leaves
todayVisitors -= 1;
console.log(todayVisitors);  // 55
```

---

**Question 3:** `&&` (AND) requires **both conditions to be true**.

```javascript
console.log(10 > 5 && 3 < 2);
//          true  &&  false  = false
```

**How AND works:**
```javascript
console.log(true && true);    // true (both true)
console.log(true && false);   // false (one false)
console.log(false && true);   // false (one false)
console.log(false && false);  // false (both false)
```

**Barangay clearance eligibility:**
```javascript
let age = 25;
let hasValidID = true;
let isResident = true;

// All conditions must be met
let canApply = age >= 18 && hasValidID && isResident;
console.log(canApply);  // true (all are true)

// If one is false
let hasPayment = false;
let canProcess = age >= 18 && hasValidID && hasPayment;
console.log(canProcess);  // false (hasPayment is false)
```

---

**Question 4:** Use `===` for **strict equality** (checks value AND type).

```javascript
// === (strict) - Recommended
console.log(5 === 5);      // true
console.log(5 === "5");    // false (different types)
console.log(true === 1);   // false (different types)

// == (loose) - Avoid
console.log(5 == "5");     // true (converts types)
console.log(true == 1);    // true (converts types)
```

**Why use ===:**
```javascript
let userInput = "18";  // From form (string)
let minimumAge = 18;    // Number

// Bad: Loose equality
if (userInput == minimumAge) {  
    console.log("OK");  // Runs! (type conversion)
}

// Good: Strict equality
if (userInput === minimumAge) {
    console.log("OK");  // Doesn't run (different types)
}

// Best: Explicit conversion
if (Number(userInput) === minimumAge) {
    console.log("OK");  // Runs correctly
}
```

---

**Question 5:** `!` (NOT) operator **inverts** boolean values.

```javascript
console.log(!true);   // false
console.log(!false);  // true

let isOpen = true;
let isClosed = !isOpen;
console.log(isClosed);  // false
```

**Barangay office status:**
```javascript
let isWeekend = false;
let isHoliday = false;

// Office open if NOT weekend AND NOT holiday
let isOpen = !isWeekend && !isHoliday;
console.log(isOpen);  // true

// Closed if weekend OR holiday
let isClosed = isWeekend || isHoliday;
console.log(isClosed);  // false
```

---

**Question 6:** String + Number = **String concatenation** (not addition).

```javascript
console.log("10" + 5);   // "105" (concatenation)
console.log(10 + 5);     // 15 (addition)
```

**Why?** When one operand is a string, JavaScript converts the other to string and concatenates.

```javascript
console.log("Age: " + 25);    // "Age: 25"
console.log("Total: " + 100); // "Total: 100"
console.log("50" + 30);       // "5030"
```

**Fix: Convert to number first:**
```javascript
let input = "100";
let fee = 50;

// Wrong
let wrong = input + fee;
console.log(wrong);  // "10050" ❌

// Correct
let correct = Number(input) + fee;
console.log(correct);  // 150 ✅
```

---

**Question 7:** Ternary operator returns value based on condition.

```javascript
let age = 17;
let status = age >= 18 ? "Adult" : "Minor";
//           17 >= 18  ? "Adult" : "Minor"
//           false     ? "Adult" : "Minor"
//           returns "Minor"

console.log(status);  // "Minor"
```

**Syntax:**
```javascript
condition ? valueIfTrue : valueIfFalse
```

**Barangay examples:**
```javascript
let age = 65;
let discount = age >= 60 ? 0.2 : 0;  // 20% for seniors
console.log(discount);  // 0.2

let queueNumber = 5;
let priority = queueNumber % 5 === 0 ? "High" : "Normal";
console.log(priority);  // "High"

let hasID = true;
let message = hasID ? "Approved" : "Need ID";
console.log(message);  // "Approved"
```

---

**Question 8:** `||` (OR) returns **true if at least one condition is true**.

```javascript
console.log(true || false);   // true
console.log(false || true);   // true
console.log(true || true);    // true
console.log(false || false);  // false
```

**Barangay discount eligibility:**
```javascript
let age = 55;
let isPWD = true;

let hasDiscount = age >= 60 || isPWD;
//               55 >= 60  || true
//               false     || true = true

console.log(hasDiscount);  // true (at least one is true)
```

---

**Question 9:** `===` checks both **value AND type**.

```javascript
console.log(5 === "5");  // false
//          ↓     ↓
//         number string (different types)

console.log(5 === 5);    // true (same value, same type)
console.log("5" === "5");  // true (same value, same type)
```

**Always use ===:**
```javascript
let age = 18;
let input = "18";

console.log(age === input);  // false (different types)
console.log(age === Number(input));  // true (both numbers)
```

---

**Question 10:** `**` is the **exponentiation** operator (power).

```javascript
console.log(2 ** 3);  // 8 (2 × 2 × 2)
console.log(3 ** 2);  // 9 (3 × 3)
console.log(5 ** 2);  // 25 (5 × 5)
console.log(10 ** 3); // 1000 (10 × 10 × 10)
```

**Barangay land area:**
```javascript
let side = 10;  // meters
let area = side ** 2;
console.log("Area:", area, "square meters");  // 100

let length = 20;
let width = 15;
let rectangleArea = length * width;  // Not exponentiation
console.log("Area:", rectangleArea);  // 300
```

---