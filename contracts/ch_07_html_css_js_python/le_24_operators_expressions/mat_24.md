## Background Story

Tian had learned variables and data types. They could store information—names, ages, fees, quantities. Their JavaScript could remember things. But it couldn't *do* anything with that data yet.

The barangay clearance application needed to calculate fees dynamically:
- Clearance: ₱50
- Rush processing: additional ₱30
- Senior citizen discount: 20% off
- Multiple documents: ₱10 discount per additional document

Tian created variables for each component:

```javascript
let baseFee = 50;
let rushFee = 30;
let seniorDiscount = 0.20;
let multiDocDiscount = 10;
```

But how do you calculate the total? If someone requests a clearance with rush processing, the total should be ₱80. If they're a senior citizen, apply the 20% discount. If they're ordering multiple documents, subtract ₱10 per additional document.

Tian stared at the variables, unsure how to combine them.

```javascript
// How do I add baseFee and rushFee?
// How do I calculate 20% of a total?
// How do I check if someone IS a senior citizen?
```

Meanwhile, Rhea Joy was building the voter registration form. It needed to validate user age:
- Under 18: "You are not eligible to vote"
- 18 or older: "You are eligible to vote"

She had the user's age stored in a variable:

```javascript
let userAge = 17;
```

But how do you check if that number is greater than or equal to 18? How do you compare values in JavaScript?

Both of them had data stored in variables but lacked the tools to manipulate that data—to perform calculations, make comparisons, or combine conditions.

It was Saturday morning at Tian's house. They'd invited Rhea Joy over to work on their projects together. Both were stuck at the same conceptual bottleneck.

"We can store data, but we can't work with it," Tian said. "I need to add numbers, subtract discounts, calculate percentages. Basic math. But I don't know the JavaScript syntax."

"I need to compare numbers," Rhea Joy added. "Check if age is greater than or equal to 18. Check if two values are equal. Check if something is true or false. But I don't know how to write these comparisons in code."

They started googling "JavaScript math" and "JavaScript comparisons." The search results kept mentioning **operators**: arithmetic operators, comparison operators, logical operators, assignment operators.

Tian found an example:

```javascript
let total = price + tax;
```

The `+` symbol adds two values! That was the missing piece.

Rhea Joy found:

```javascript
if (age >= 18) {
    console.log("Eligible to vote");
}
```

The `>=` symbol checks if a value is greater than or equal to another.

They experimented in the browser console:

```javascript
let a = 50;
let b = 30;
let sum = a + b;
console.log(sum);  // Output: 80

let age = 20;
let isAdult = age >= 18;
console.log(isAdult);  // Output: true
```

It worked! They'd discovered operators—the symbols that perform operations on values.

That evening, they called Kuya Miguel to learn properly.

"Kuya, we've been storing data in variables but we couldn't work with it. We just discovered operators—symbols like `+` for addition and `>=` for comparison. But we're just guessing. Can you teach us all the operators in JavaScript and how to use them?"

Miguel smiled. "You've discovered one of the fundamental building blocks of programming. Operators are how you transform data. Arithmetic operators for math—addition, subtraction, multiplication, division, modulo. Comparison operators for checking relationships—greater than, less than, equal to. Logical operators for combining conditions—AND, OR, NOT. Assignment operators for updating variables. String operators for text manipulation. JavaScript has dozens of operators, each with specific purposes. Today, we're learning them all."

---

## Theory & Lecture Content

## What are Operators?

**Operators** are symbols that perform operations on values (operands).

**Expression:** Combination of values, variables, and operators that produces a result.

```javascript
let result = 5 + 3;  // + is operator, 5 and 3 are operands
//          expression
```

---

## Arithmetic Operators

**Perform mathematical calculations:**

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `+` | Addition | `5 + 3` | `8` |
| `-` | Subtraction | `5 - 3` | `2` |
| `*` | Multiplication | `5 * 3` | `15` |
| `/` | Division | `15 / 3` | `5` |
| `%` | Modulo (Remainder) | `17 % 5` | `2` |
| `**` | Exponentiation | `2 ** 3` | `8` |

---

### Addition (+)

```javascript
let a = 10;
let b = 5;
let sum = a + b;

console.log(sum);  // Output: 15

// Barangay fees
let clearanceFee = 50;
let certificateFee = 30;
let totalFee = clearanceFee + certificateFee;
console.log(totalFee);  // Output: 80
```

---

### Subtraction (-)

```javascript
let budget = 10000;
let expenses = 3500;
let remaining = budget - expenses;

console.log(remaining);  // Output: 6500
```

---

### Multiplication (*)

```javascript
let pricePerItem = 25;
let quantity = 4;
let total = pricePerItem * quantity;

console.log(total);  // Output: 100
```

---

### Division (/)

```javascript
let totalAmount = 1000;
let numberOfPeople = 4;
let sharePerPerson = totalAmount / numberOfPeople;

console.log(sharePerPerson);  // Output: 250

// Division by zero
console.log(10 / 0);  // Output: Infinity
```

---

### Modulo (%) - Remainder

**Returns remainder after division:**

```javascript
console.log(17 % 5);   // 2 (17 ÷ 5 = 3 remainder 2)
console.log(20 % 4);   // 0 (20 ÷ 4 = 5 remainder 0)
console.log(15 % 7);   // 1 (15 ÷ 7 = 2 remainder 1)

// Check if even or odd
let number = 7;
let isEven = number % 2 === 0;
console.log(isEven);  // false (7 % 2 = 1, not 0)
```

**Use cases:**
```javascript
// Check if divisible by 5
let queueNumber = 25;
if (queueNumber % 5 === 0) {
    console.log("Every 5th visitor gets a prize!");
}

// Alternate row colors (even/odd)
let rowNumber = 3;
if (rowNumber % 2 === 0) {
    console.log("Even row - gray background");
} else {
    console.log("Odd row - white background");
}
```

---

### Exponentiation (**)

**Raises number to power:**

```javascript
console.log(2 ** 3);   // 8 (2 × 2 × 2)
console.log(5 ** 2);   // 25 (5 × 5)
console.log(10 ** 3);  // 1000 (10 × 10 × 10)

// Calculate area
let side = 5;
let area = side ** 2;
console.log(area);  // 25 square units
```

---

## Assignment Operators

**Assign and update values:**

| Operator | Example | Equivalent |
|----------|---------|------------|
| `=` | `x = 5` | `x = 5` |
| `+=` | `x += 3` | `x = x + 3` |
| `-=` | `x -= 3` | `x = x - 3` |
| `*=` | `x *= 3` | `x = x * 3` |
| `/=` | `x /= 3` | `x = x / 3` |
| `%=` | `x %= 3` | `x = x % 3` |

---

### Examples

```javascript
let count = 10;

// Addition assignment
count += 5;  // Same as: count = count + 5
console.log(count);  // 15

// Subtraction assignment
count -= 3;  // Same as: count = count - 3
console.log(count);  // 12

// Multiplication assignment
count *= 2;  // Same as: count = count * 2
console.log(count);  // 24

// Division assignment
count /= 4;  // Same as: count = count / 4
console.log(count);  // 6
```

**Barangay budget tracking:**
```javascript
let budget = 50000;

// Spend on supplies
budget -= 5000;
console.log("After supplies:", budget);  // 45000

// Spend on salaries
budget -= 20000;
console.log("After salaries:", budget);  // 25000

// Receive additional funding
budget += 10000;
console.log("After funding:", budget);  // 35000
```

---

## Increment and Decrement

**Increase or decrease by 1:**

```javascript
let count = 5;

// Increment (add 1)
count++;  // Same as: count = count + 1
console.log(count);  // 6

// Decrement (subtract 1)
count--;  // Same as: count = count - 1
console.log(count);  // 5
```

**Prefix vs Postfix:**

```javascript
let x = 5;

// Postfix: Use then increment
let a = x++;  // a = 5, then x becomes 6
console.log(a);  // 5
console.log(x);  // 6

// Prefix: Increment then use
let y = 5;
let b = ++y;  // y becomes 6, then b = 6
console.log(b);  // 6
console.log(y);  // 6
```

**Queue counter:**
```javascript
let queueNumber = 1;

console.log("Serving number:", queueNumber);
queueNumber++;  // Next

console.log("Serving number:", queueNumber);
queueNumber++;  // Next

console.log("Serving number:", queueNumber);
// Output: 1, 2, 3
```

---

## Comparison Operators

**Compare two values, return boolean (true/false):**

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `==` | Equal (loose) | `5 == "5"` | `true` |
| `===` | Equal (strict) | `5 === "5"` | `false` |
| `!=` | Not equal (loose) | `5 != "5"` | `false` |
| `!==` | Not equal (strict) | `5 !== "5"` | `true` |
| `>` | Greater than | `10 > 5` | `true` |
| `<` | Less than | `10 < 5` | `false` |
| `>=` | Greater or equal | `10 >= 10` | `true` |
| `<=` | Less or equal | `5 <= 10` | `true` |

---

### Equality: == vs ===

**== (Loose Equality) - Converts types:**
```javascript
console.log(5 == "5");     // true (converts "5" to number)
console.log(true == 1);    // true (converts true to 1)
console.log(false == 0);   // true (converts false to 0)
console.log(null == undefined);  // true
```

**=== (Strict Equality) - No conversion:**
```javascript
console.log(5 === "5");    // false (different types)
console.log(true === 1);   // false (different types)
console.log(false === 0);  // false (different types)
console.log(null === undefined);  // false
```

**Always use === (recommended):**
```javascript
let age = 18;
let input = "18";

// Bad: Unexpected results
if (age == input) {  // true (type conversion)
    console.log("Match");
}

// Good: Predictable
if (age === Number(input)) {  // Explicit conversion
    console.log("Match");
}
```

---

### Comparison Examples

```javascript
let age = 17;
let votingAge = 18;

console.log(age > votingAge);   // false (17 > 18)
console.log(age < votingAge);   // true (17 < 18)
console.log(age >= votingAge);  // false (17 >= 18)
console.log(age === votingAge); // false (17 === 18)
```

**Barangay eligibility check:**
```javascript
let applicantAge = 25;
let minimumAge = 18;
let hasID = true;

let isEligible = applicantAge >= minimumAge;
console.log("Age eligible:", isEligible);  // true

let canApply = isEligible && hasID;
console.log("Can apply:", canApply);  // true
```

---

## Logical Operators

**Combine boolean values:**

| Operator | Name | Description |
|----------|------|-------------|
| `&&` | AND | True if BOTH are true |
| `||` | OR | True if AT LEAST ONE is true |
| `!` | NOT | Inverts boolean value |

---

### AND (&&)

**Both conditions must be true:**

```javascript
console.log(true && true);    // true
console.log(true && false);   // false
console.log(false && true);   // false
console.log(false && false);  // false

let hasID = true;
let isResident = true;
let canGetClearance = hasID && isResident;
console.log(canGetClearance);  // true
```

**Multiple conditions:**
```javascript
let age = 25;
let hasValidID = true;
let isResident = true;
let hasPayment = true;

let canProcess = age >= 18 && hasValidID && isResident && hasPayment;
console.log(canProcess);  // true (all conditions met)
```

---

### OR (||)

**At least one condition must be true:**

```javascript
console.log(true || true);    // true
console.log(true || false);   // true
console.log(false || true);   // true
console.log(false || false);  // false

let isSenior = false;
let isPWD = true;
let hasDiscount = isSenior || isPWD;
console.log(hasDiscount);  // true (at least one is true)
```

**Barangay discount eligibility:**
```javascript
let age = 65;
let isPWD = false;

let isSenior = age >= 60;
let qualifiesForDiscount = isSenior || isPWD;

console.log("Senior:", isSenior);  // true
console.log("Qualifies for discount:", qualifiesForDiscount);  // true
```

---

### NOT (!)

**Inverts boolean value:**

```javascript
console.log(!true);   // false
console.log(!false);  // true

let isOpen = false;
let isClosed = !isOpen;
console.log(isClosed);  // true

// Double negation
console.log(!!true);   // true
console.log(!!false);  // false
```

**Office hours check:**
```javascript
let isWeekend = false;
let isHoliday = false;

let isWorkday = !isWeekend && !isHoliday;
console.log("Office open:", isWorkday);  // true
```

---

## Operator Precedence

**Order of operations (like PEMDAS in math):**

1. Parentheses `()`
2. Exponentiation `**`
3. Multiplication/Division/Modulo `*`, `/`, `%`
4. Addition/Subtraction `+`, `-`
5. Comparison `>`, `<`, `>=`, `<=`
6. Equality `==`, `===`
7. Logical AND `&&`
8. Logical OR `||`

**Examples:**
```javascript
let result = 5 + 3 * 2;
console.log(result);  // 11 (not 16, because * before +)

let withParens = (5 + 3) * 2;
console.log(withParens);  // 16 (parentheses first)

let complex = 10 + 5 * 2 ** 2;
console.log(complex);  // 30 (2**2=4, 5*4=20, 10+20=30)
```

**Use parentheses for clarity:**
```javascript
// Unclear
let total = price + tax * quantity;

// Clear
let total = price + (tax * quantity);  // Better
let total = (price + tax) * quantity;  // Or this, depending on intent
```

---

## Barangay Fee Calculator

```javascript
// Service fees
const baseFee = 50;
const urgentFee = 100;
const deliveryFee = 20;

// Applicant details
let isUrgent = true;
let needsDelivery = true;
let isSenior = false;

// Calculate total
let serviceFee = isUrgent ? urgentFee : baseFee;
let total = serviceFee;

if (needsDelivery) {
    total += deliveryFee;
}

// Senior discount (20%)
if (isSenior) {
    total = total * 0.8;  // 20% discount
}

console.log("=== Barangay Fee Calculation ===");
console.log("Service fee:", serviceFee);
console.log("Delivery fee:", needsDelivery ? deliveryFee : 0);
console.log("Senior discount:", isSenior ? "Yes (20%)" : "No");
console.log("Total:", "₱" + total);

// Output:
// Service fee: 100
// Delivery fee: 20
// Senior discount: No
// Total: ₱120
```

---

## String Operators

### Concatenation (+)

```javascript
let firstName = "Juan";
let lastName = "Dela Cruz";
let fullName = firstName + " " + lastName;

console.log(fullName);  // "Juan Dela Cruz"

// With numbers
let age = 25;
let message = "Age: " + age;
console.log(message);  // "Age: 25"

// Multiple concatenation
let address = "Barangay " + "San Miguel" + ", " + "Batangas";
console.log(address);  // "Barangay San Miguel, Batangas"
```

**Template literals (better):**
```javascript
let fullName = `${firstName} ${lastName}`;
let message = `Age: ${age}`;
let address = `Barangay San Miguel, Batangas`;
```

---

## Ternary Operator

**Shorthand for if-else:**

**Syntax:**
```javascript
condition ? valueIfTrue : valueIfFalse
```

**Examples:**
```javascript
let age = 17;
let status = age >= 18 ? "Adult" : "Minor";
console.log(status);  // "Minor"

let score = 85;
let grade = score >= 75 ? "Passed" : "Failed";
console.log(grade);  // "Passed"

let isMember = true;
let discount = isMember ? 0.1 : 0;  // 10% or 0%
console.log(discount);  // 0.1
```

**Barangay priority queue:**
```javascript
let age = 70;
let isPWD = false;

let priority = (age >= 60 || isPWD) ? "High" : "Normal";
console.log("Queue priority:", priority);  // "High"

let queueLetter = (age >= 60 || isPWD) ? "A" : "B";
console.log("Queue at counter:", queueLetter);  // "A"
```

---

## Type Coercion in Operations

**JavaScript automatically converts types:**

```javascript
// String + Number = String concatenation
console.log("10" + 5);     // "105"
console.log("Age: " + 25); // "Age: 25"

// Other operators convert to number
console.log("10" - 5);     // 5
console.log("10" * 2);     // 20
console.log("10" / 2);     // 5

// Boolean to number
console.log(true + 1);     // 2 (true = 1)
console.log(false + 1);    // 1 (false = 0)
```

**Be explicit to avoid bugs:**
```javascript
let input = "100";
let fee = 50;

// Bad: String concatenation
let wrong = input + fee;
console.log(wrong);  // "10050" ❌

// Good: Explicit conversion
let correct = Number(input) + fee;
console.log(correct);  // 150 ✅
```

---

## Summary

Tian summarized:

**Arithmetic Operators:**
- `+`, `-`, `*`, `/`, `%`, `**`

**Comparison Operators:**
- `===` (strict), `!==`, `>`, `<`, `>=`, `<=`
- Always use `===` instead of `==`

**Logical Operators:**
- `&&` (AND): Both must be true
- `||` (OR): At least one true
- `!` (NOT): Invert boolean

**Assignment Operators:**
- `=`, `+=`, `-=`, `*=`, `/=`
- `++`, `--`

**Ternary Operator:**
- `condition ? valueIfTrue : valueIfFalse`

Rhea Joy smiled. "Now we can calculate fees, check eligibility, and make decisions in our code!"

---

## What's Next?

In the next lesson, you'll learn about **Conditional Branching** (if/else statements)—how to make your code choose different paths based on conditions.

---

---

## Closing Story

Tian wrote expressions: addition, subtraction, comparison, logical AND/OR. The console showed results instantly. Every operator, every operationtestable, debuggable, understandable.

"Programming is just math and logic," Kuya Miguel said. "Master operators, and you can solve any problem."

Tian calculated barangay statistics in JavaScript: population growth rate, budget allocation percentages, tax computations. Real-world math, real-world applications.

_Next up: Conditional Branchingmaking decisions!_