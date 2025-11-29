# Lesson 25: Conditional Branching (if/else)

---

## Making Decisions

"Kuya Miguel, how do we make our website smart? Like showing different messages based on user age?" Tian asked.

Rhea Joy added, "Or checking if someone qualifies for a barangay service before processing?"

Kuya Miguel smiled. "That's **conditional branching**—making your code choose different paths based on conditions. It's like decision-making in real life: 'IF this is true, THEN do that.'"

---

## What is Conditional Branching?

**Conditional statements** let your code execute different blocks based on whether conditions are true or false.

**Real-life example:**
```
IF it's raining THEN bring umbrella
ELSE wear sunglasses
```

**JavaScript:**
```javascript
if (condition) {
    // Code runs if condition is true
} else {
    // Code runs if condition is false
}
```

---

## if Statement

**Basic syntax:**
```javascript
if (condition) {
    // Code executes if condition is true
}
```

**Examples:**
```javascript
let age = 20;

if (age >= 18) {
    console.log("You can vote!");
}
// Output: You can vote!

let hasID = true;

if (hasID) {
    console.log("ID verified");
}
// Output: ID verified
```

**Barangay eligibility:**
```javascript
let applicantAge = 25;
let minimumAge = 18;

if (applicantAge >= minimumAge) {
    console.log("Eligible for barangay clearance");
}
// Output: Eligible for barangay clearance
```

---

## if...else Statement

**Execute different code based on condition:**

```javascript
if (condition) {
    // Code if condition is true
} else {
    // Code if condition is false
}
```

**Examples:**
```javascript
let age = 16;

if (age >= 18) {
    console.log("Adult");
} else {
    console.log("Minor");
}
// Output: Minor

let score = 85;

if (score >= 75) {
    console.log("Passed");
} else {
    console.log("Failed");
}
// Output: Passed
```

**Barangay office hours:**
```javascript
let currentHour = 14;  // 2 PM
let openingHour = 8;   // 8 AM
let closingHour = 17;  // 5 PM

if (currentHour >= openingHour && currentHour < closingHour) {
    console.log("Office is OPEN");
} else {
    console.log("Office is CLOSED");
}
// Output: Office is OPEN
```

---

## if...else if...else Statement

**Multiple conditions:**

```javascript
if (condition1) {
    // Code if condition1 is true
} else if (condition2) {
    // Code if condition2 is true
} else if (condition3) {
    // Code if condition3 is true
} else {
    // Code if all conditions are false
}
```

**Grade classification:**
```javascript
let score = 85;

if (score >= 90) {
    console.log("Excellent");
} else if (score >= 80) {
    console.log("Very Good");
} else if (score >= 75) {
    console.log("Passed");
} else {
    console.log("Failed");
}
// Output: Very Good
```

**Barangay service fee:**
```javascript
let age = 65;
let isPWD = false;

if (age >= 60) {
    console.log("Senior citizen discount: 20%");
} else if (isPWD) {
    console.log("PWD discount: 20%");
} else {
    console.log("Regular fee");
}
// Output: Senior citizen discount: 20%
```

---

## Nested if Statements

**if inside if:**

```javascript
let hasID = true;
let age = 25;

if (hasID) {
    if (age >= 18) {
        console.log("Application approved");
    } else {
        console.log("Too young (need parent consent)");
    }
} else {
    console.log("Please provide valid ID");
}
// Output: Application approved
```

**Better: Use logical operators:**
```javascript
if (hasID && age >= 18) {
    console.log("Application approved");
} else if (hasID && age < 18) {
    console.log("Too young (need parent consent)");
} else {
    console.log("Please provide valid ID");
}
```

---

## Switch Statement

**For multiple specific values:**

```javascript
switch (expression) {
    case value1:
        // Code for value1
        break;
    case value2:
        // Code for value2
        break;
    default:
        // Code if no case matches
}
```

**Day of week example:**
```javascript
let day = 3;

switch (day) {
    case 1:
        console.log("Monday");
        break;
    case 2:
        console.log("Tuesday");
        break;
    case 3:
        console.log("Wednesday");
        break;
    default:
        console.log("Other day");
}
// Output: Wednesday
```

**Barangay service selector:**
```javascript
let serviceCode = "CL";

switch (serviceCode) {
    case "CL":
        console.log("Barangay Clearance - ₱50");
        break;
    case "RC":
        console.log("Residency Certificate - ₱30");
        break;
    case "IC":
        console.log("Indigency Certificate - ₱20");
        break;
    case "BP":
        console.log("Business Permit - ₱100");
        break;
    default:
        console.log("Invalid service code");
}
// Output: Barangay Clearance - ₱50
```

---

## Complete Barangay Application System

```javascript
// Applicant information
const applicantName = "Juan Dela Cruz";
const applicantAge = 25;
const hasValidID = true;
const isResident = true;
const serviceType = "clearance";
const hasPayment = true;

console.log("=== Barangay Service Application ===");
console.log("Applicant:", applicantName);
console.log("Age:", applicantAge);

// Age verification
if (applicantAge < 18) {
    console.log("❌ DENIED: Must be 18 years or older");
    console.log("Please bring parent/guardian");
} else if (!hasValidID) {
    console.log("❌ DENIED: Valid ID required");
} else if (!isResident) {
    console.log("❌ DENIED: Must be barangay resident");
} else if (!hasPayment) {
    console.log("❌ DENIED: Payment required");
} else {
    console.log("✅ All requirements met");
    
    // Determine service and fee
    let serviceFee = 0;
    let serviceName = "";
    
    switch (serviceType) {
        case "clearance":
            serviceName = "Barangay Clearance";
            serviceFee = 50;
            break;
        case "residency":
            serviceName = "Residency Certificate";
            serviceFee = 30;
            break;
        case "indigency":
            serviceName = "Indigency Certificate";
            serviceFee = 20;
            break;
        default:
            serviceName = "Unknown Service";
            serviceFee = 0;
    }
    
    // Apply discount
    let discount = 0;
    if (applicantAge >= 60) {
        discount = 0.20;  // 20% senior discount
        console.log("🎉 Senior citizen discount applied: 20%");
    }
    
    let finalFee = serviceFee * (1 - discount);
    
    console.log("\n--- Service Details ---");
    console.log("Service:", serviceName);
    console.log("Base Fee: ₱" + serviceFee);
    console.log("Discount:", (discount * 100) + "%");
    console.log("Final Fee: ₱" + finalFee);
    console.log("\n✅ APPLICATION APPROVED");
}
```

---

## Truthyand Falsy Values

**JavaScript treats certain values as true/false in conditions:**

**Falsy values (treated as false):**
- `false`
- `0`
- `""` (empty string)
- `null`
- `undefined`
- `NaN`

**Truthy values (treated as true):**
- Everything else!
- `true`
- Non-zero numbers
- Non-empty strings
- Objects, arrays

**Examples:**
```javascript
if (0) {
    console.log("Won't run");  // 0 is falsy
}

if (1) {
    console.log("Will run");  // 1 is truthy
}

if ("") {
    console.log("Won't run");  // Empty string is falsy
}

if ("Hello") {
    console.log("Will run");  // Non-empty string is truthy
}

let name = "";
if (name) {
    console.log("Name provided");
} else {
    console.log("Name missing");  // This runs
}
```

---

## Common Patterns

### Range checking
```javascript
let age = 25;

if (age >= 18 && age <= 60) {
    console.log("Working age");
}

// Alternative
if (age < 18) {
    console.log("Minor");
} else if (age <= 60) {
    console.log("Working age");
} else {
    console.log("Senior");
}
```

### Multiple conditions
```javascript
let hasID = true;
let isResident = true;
let hasPayment = true;

if (hasID && isResident && hasPayment) {
    console.log("All requirements met");
} else {
    if (!hasID) console.log("Missing: ID");
    if (!isResident) console.log("Missing: Residency proof");
    if (!hasPayment) console.log("Missing: Payment");
}
```

### Default values
```javascript
let userAge = null;
let displayAge = userAge || "Not provided";
console.log(displayAge);  // "Not provided"
```

---

## Best Practices

### 1. Use strict equality (===)
```javascript
// Bad
if (age == "18") {  // Loose equality
    console.log("Adult");
}

// Good
if (age === 18) {  // Strict equality
    console.log("Adult");
}
```

### 2. Keep conditions simple
```javascript
// Bad - Complex nested conditions
if (condition1) {
    if (condition2) {
        if (condition3) {
            // Hard to read
        }
    }
}

// Good - Combine with &&
if (condition1 && condition2 && condition3) {
    // Easy to read
}
```

### 3. Handle edge cases
```javascript
let age = prompt("Enter age:");

if (age === null || age === "") {
    console.log("Please enter age");
} else if (isNaN(age)) {
    console.log("Please enter a valid number");
} else if (age < 0) {
    console.log("Age cannot be negative");
} else {
    // Process valid age
}
```

---

## Summary

Tian summarized:

**if Statement:**
```javascript
if (condition) {
    // Code if true
}
```

**if...else:**
```javascript
if (condition) {
    // Code if true
} else {
    // Code if false
}
```

**if...else if...else:**
```javascript
if (condition1) {
    // Code
} else if (condition2) {
    // Code
} else {
    // Code
}
```

**switch:**
```javascript
switch (value) {
    case option1:
        // Code
        break;
    default:
        // Code
}
```

**Key Points:**
- Use `===` for comparisons
- Combine conditions with `&&`, `||`
- Keep conditions simple
- Handle edge cases

Rhea Joy smiled. "Now our website can make smart decisions!"

---

## What's Next?

In the next lesson, you'll learn about **Loops**—how to repeat code multiple times efficiently.

---

---

## Closing Story

Tian wrote the first `if` statement. If resident age is below 18, show "Minor". Else, "Adult". The program made decisions. It was thinking.

"Conditionals are the heart of programming," Kuya Miguel emphasized. "Every app, every game, every websitefull of if-else logic."

Tian added validation to the barangay form: if name is empty, show error. If email is invalid, reject submission. The form was smart now. Defensive. User-friendly.

_Next up: Loopingrepeating tasks efficiently!_