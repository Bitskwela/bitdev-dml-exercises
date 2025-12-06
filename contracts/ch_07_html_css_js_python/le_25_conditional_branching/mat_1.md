## Background Story

Tian stared at their JavaScript code, feeling both proud and limited. They'd successfully created variables, performed calculations, concatenated strings, and logged results to the console. The barangay clearance application form could now calculate fees based on document type:

```javascript
let documentType = "clearance";
let baseFee = 50;
let processingFee = 20;
let totalFee = baseFee + processingFee;
console.log("Total fee: ₱" + totalFee);
```

It worked. But it was rigid. The fee was always 70 pesos because the values were hardcoded. In reality, different documents had different fees. Clearance: ₱50. Barangay ID: ₱30. Indigency Certificate: ₱20. Certificate of Residency: ₱40.

How could they make the code adapt based on which document the user selected?

Rhea Joy, working on the same project, ran into a different problem. She was validating user age for voting registration:

```javascript
let userAge = 17;
console.log("Registration submitted");
```

It always submitted the registration, even though 17-year-olds weren't eligible to vote. The code needed to *check* the age first and respond differently based on whether the user was 18 or older.

They were both hitting the same wall: their code was **sequential**—it executed line by line, top to bottom, with no ability to make decisions, branch into different paths, or adapt to different situations.

It was Wednesday evening, and they were at Tian's house working on their joint project. The frustration was palpable.

"Our code is like a robot following instructions blindly," Tian said. "It doesn't think. It doesn't adapt. It just does exactly what we tell it, even when it should do something different."

"How do we make it smart?" Rhea Joy asked. "Like, how do we tell JavaScript: 'If the age is under 18, show an error. If it's 18 or above, proceed.' That's such a simple concept in real life, but I don't know how to write it in code."

Tian pulled out their phone and called Kuya Miguel.

"Kuya, we're stuck. Our code can calculate things and store values, but it can't make decisions. We need it to do different things based on conditions. Like checking if someone is old enough, or calculating different fees based on document type. How do we add logic to our code?"

Miguel's response was immediate. "You need conditional statements. Specifically, `if-else` logic. This is where programming goes from simple calculations to actual intelligence. You're giving your code the ability to make decisions—to branch into different paths based on whether conditions are true or false."

"Like... the code can decide?"

"Exactly. Think about how you make decisions in real life. IF it's raining, THEN bring an umbrella, ELSE wear sunglasses. IF you have enough money, THEN buy the item, ELSE save up more. IF age is 18 or above, THEN allow voting, ELSE show error. That's conditional logic, and it's one of the most fundamental concepts in all of programming."

Miguel continued, "JavaScript has several ways to write conditionals: `if` statements, `if-else`, `else if` chains, `switch` statements, and even ternary operators. Today, I'm teaching you all of them. By the end of this lesson, your barangay form will check eligibility, calculate fees dynamically, validate input, and respond intelligently to different scenarios."

Tian and Rhea Joy exchanged excited glances.

"So our code will actually think?" Rhea Joy asked.

"It'll make decisions based on logic you define," Miguel clarified. "That's not artificial intelligence, but it's the foundation of it. Every complex program—Facebook's algorithm, GCash's transaction system, Shopee's checkout process—is built on conditional logic. You're about to learn the building blocks of real programming."

Tian opened VS Code, creating a new file: `conditionals.js`. Rhea Joy pulled her chair closer. They were ready to make their code smart.

---

## Theory & Lecture Content

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