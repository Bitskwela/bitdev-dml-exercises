## Background Story

Tian's JavaScript file had grown to over 300 lines. The barangay fee calculation appeared in five different places:

```javascript
// In clearance application section
let clearanceFee = 50;
if (isRush) clearanceFee += 30;
if (isSenior) clearanceFee *= 0.80;

// In ID application section
let idFee = 30;
if (isRush) idFee += 30;
if (isSenior) idFee *= 0.80;

// In indigency certificate section
let indigencyFee = 20;
if (isRush) indigencyFee += 30;
if (isSenior) indigencyFee *= 0.80;

// ...and so on
```

The same calculation logic—rush processing, senior discount—was copied and pasted throughout the file with minor variations. It worked, but there were serious problems:

1. **Code duplication**: The same 3-4 lines repeated everywhere
2. **Maintenance nightmare**: If the senior discount changed from 20% to 25%, Tian would have to update it in five places
3. **Error-prone**: One section had a typo (`clearanceFee *= 0.08` instead of `0.80`), creating a bug that took an hour to find
4. **Unorganized**: The file was a mess of intermingled logic with no clear structure

Worse, when the barangay office requested a new feature—PWD (persons with disabilities) discount of 15%—Tian would have to add another `if` statement in five different locations. The code was becoming unmaintainable.

Rhea Joy faced a similar problem with form validation. She had three forms—clearance application, ID application, and complaint submission. Each form needed to validate:
- Required fields aren't empty
- Email format is correct
- Phone number has 11 digits
- Age is a valid number

She'd written the validation logic separately for each form, resulting in 150 lines of duplicated code. When she discovered a bug in the email validation regex, she had to fix it in three places—and she forgot to update one, leaving that form with broken validation.

"This is insane," Rhea Joy said during their Sunday morning work session. "I'm copying the same code over and over. There must be a way to write validation logic once and reuse it everywhere."

"Same problem here," Tian replied, showing the duplicated fee calculation code. "If we're professional developers, we can't keep doing this. It's inefficient, error-prone, and unmaintainable."

They googled "how to reuse code in JavaScript" and found a universal answer: **functions**. Functions are reusable blocks of code that perform specific tasks. Write the logic once, call it whenever needed.

Tian experimented:

```javascript
function calculateFee(baseFee, isRush, isSenior) {
    let total = baseFee;
    if (isRush) total += 30;
    if (isSenior) total *= 0.80;
    return total;
}

let clearanceFee = calculateFee(50, true, false);
let idFee = calculateFee(30, false, true);
let indigencyFee = calculateFee(20, true, true);
```

Three lines replaced 15 lines of duplicated code! And if the senior discount needed to change, they'd update one place—inside the function—and all calculations would automatically use the new logic.

Rhea Joy tried the same with validation:

```javascript
function isValidEmail(email) {
    return email.includes('@') && email.includes('.');
}

if (!isValidEmail(userEmail)) {
    alert('Invalid email');
}
```

Now email validation was a single reusable function instead of duplicated regex checks scattered everywhere.

But they'd stumbled upon functions by trial and error. They didn't understand function syntax properly, parameters, return values, or scope. They'd created functions that worked, but they weren't sure why or how to write more complex ones.

That evening, they called Kuya Miguel.

"Kuya, our code was full of duplication. Same calculations and validations repeated everywhere. We discovered functions let us write logic once and reuse it, but we're just guessing at the syntax. Can you teach us functions properly—how to write them, how to pass data in and out, and how to organize code with reusable functions?"

Miguel pulled up his screen. "Functions are one of the most important concepts in programming. They're how professionals write maintainable, organized, DRY code—Don't Repeat Yourself. Today we're learning function declarations, parameters, arguments, return values, function scope, arrow functions, and best practices for organizing code with functions. By the end of this lesson, your 300-line file will probably shrink to 150 lines of clean, reusable functions."

---

## Theory & Lecture Content

## What are Functions?

**Functions** are reusable blocks of code that perform a specific task.

**Real-life analogy:**
- A coffee machine: Input (beans, water) → Process (brew) → Output (coffee)
- A calculator button: Input (numbers) → Process (calculate) → Output (result)

**Why use functions?**
- Avoid code repetition (DRY: Don't Repeat Yourself)
- Organize code into logical pieces
- Make code easier to test and debug
- Change logic in one place

---

## Function Declaration

**Basic syntax:**
```javascript
function functionName() {
    // Code to execute
}

// Call the function
functionName();
```

**Example:**
```javascript
function greet() {
    console.log("Hello, Barangay!");
}

greet();  // Output: Hello, Barangay!
greet();  // Output: Hello, Barangay!
```

**Barangay announcement:**
```javascript
function showOfficeHours() {
    console.log("=== Barangay Office Hours ===");
    console.log("Monday to Friday: 8 AM - 5 PM");
    console.log("Saturday: 8 AM - 12 PM");
    console.log("Sunday: CLOSED");
}

showOfficeHours();
```

---

## Functions with Parameters

**Pass data to functions:**

```javascript
function functionName(parameter1, parameter2) {
    // Use parameters in code
}

functionName(value1, value2);
```

**Example:**
```javascript
function greetPerson(name) {
    console.log("Hello, " + name + "!");
}

greetPerson("Juan");   // Output: Hello, Juan!
greetPerson("Maria");  // Output: Hello, Maria!
```

**Multiple parameters:**
```javascript
function calculateSum(num1, num2) {
    let sum = num1 + num2;
    console.log("Sum: " + sum);
}

calculateSum(5, 3);   // Output: Sum: 8
calculateSum(10, 20); // Output: Sum: 30
```

**Barangay fee calculator:**
```javascript
function calculateFee(age, baseFee) {
    console.log("=== Fee Calculation ===");
    console.log("Age: " + age);
    console.log("Base Fee: ₱" + baseFee);
    
    if (age >= 60) {
        let discount = baseFee * 0.2;
        let finalFee = baseFee - discount;
        console.log("Senior Discount: -₱" + discount);
        console.log("Final Fee: ₱" + finalFee);
    } else {
        console.log("Final Fee: ₱" + baseFee);
    }
}

calculateFee(25, 50);  // Regular fee
calculateFee(65, 50);  // Senior discount
```

---

## Return Values

**Send data back from functions:**

```javascript
function functionName(parameters) {
    // Process
    return result;
}

let value = functionName(arguments);
```

**Example:**
```javascript
function add(a, b) {
    return a + b;
}

let result = add(5, 3);
console.log(result);  // Output: 8

let total = add(10, 20) + add(5, 15);
console.log(total);  // Output: 50
```

**Barangay fee with return:**
```javascript
function calculateFinalFee(age, baseFee) {
    if (age >= 60) {
        return baseFee * 0.8;  // 20% discount
    }
    return baseFee;
}

let fee1 = calculateFinalFee(25, 50);
let fee2 = calculateFinalFee(65, 50);
let totalRevenue = fee1 + fee2;

console.log("Visitor 1: ₱" + fee1);  // ₱50
console.log("Visitor 2: ₱" + fee2);  // ₱40
console.log("Total: ₱" + totalRevenue);  // ₱90
```

---

## Function Expressions

**Store function in a variable:**

```javascript
const functionName = function(parameters) {
    // Code
};

functionName();
```

**Example:**
```javascript
const multiply = function(a, b) {
    return a * b;
};

console.log(multiply(5, 3));  // Output: 15
```

**Difference from function declaration:**
```javascript
// Function Declaration - can be called before definition
greet();  // Works!

function greet() {
    console.log("Hello");
}

// Function Expression - cannot be called before definition
sayHi();  // Error!

const sayHi = function() {
    console.log("Hi");
};
```

---

## Default Parameters

**Provide default values:**

```javascript
function greet(name = "Guest") {
    console.log("Hello, " + name);
}

greet("Juan");    // Output: Hello, Juan
greet();          // Output: Hello, Guest
```

**Barangay service with defaults:**
```javascript
function processService(serviceName = "Clearance", fee = 50) {
    console.log("Service: " + serviceName);
    console.log("Fee: ₱" + fee);
}

processService("Residency", 30);  // Custom values
processService();                  // Default values
```

---

## Variable Scope

**Where variables can be accessed:**

### Global Scope
```javascript
let globalVar = "Accessible everywhere";

function showGlobal() {
    console.log(globalVar);  // Can access
}

showGlobal();
console.log(globalVar);  // Can access
```

### Local Scope (Function Scope)
```javascript
function myFunction() {
    let localVar = "Only in function";
    console.log(localVar);  // Can access
}

myFunction();
console.log(localVar);  // Error! Not defined here
```

### Block Scope (let/const)
```javascript
if (true) {
    let blockVar = "Only in block";
    console.log(blockVar);  // Can access
}

console.log(blockVar);  // Error! Not defined here
```

**Barangay system scope:**
```javascript
const officeName = "Barangay Health Center";  // Global

function processVisitor() {
    const visitorNumber = 42;  // Local to function
    
    console.log(officeName);      // Can access global
    console.log(visitorNumber);   // Can access local
}

processVisitor();
console.log(officeName);      // Can access global
console.log(visitorNumber);   // Error! Local to function
```

---

## Scope Chain

**Inner functions can access outer variables:**

```javascript
const barangayName = "San Juan";  // Global

function processApplication() {
    const applicantName = "Juan Dela Cruz";  // Function scope
    
    function checkEligibility() {
        const age = 25;  // Inner function scope
        
        // Can access all outer variables
        console.log("Barangay: " + barangayName);
        console.log("Applicant: " + applicantName);
        console.log("Age: " + age);
    }
    
    checkEligibility();
    // console.log(age);  // Error! age is in inner function
}

processApplication();
```

---

## Complete Barangay Service System

```javascript
// Global configuration
const BARANGAY_NAME = "San Juan";
const OFFICE_FEE = 50;
const SENIOR_DISCOUNT = 0.20;
const PWD_DISCOUNT = 0.20;

// Function: Display header
function displayHeader() {
    console.log("=================================");
    console.log("   " + BARANGAY_NAME + " SERVICE CENTER");
    console.log("=================================\n");
}

// Function: Calculate discount
function calculateDiscount(age, isPWD, baseFee) {
    let discount = 0;
    let reason = "";
    
    if (age >= 60) {
        discount = baseFee * SENIOR_DISCOUNT;
        reason = "Senior Citizen";
    } else if (isPWD) {
        discount = baseFee * PWD_DISCOUNT;
        reason = "PWD";
    }
    
    return {
        amount: discount,
        reason: reason
    };
}

// Function: Calculate final fee
function calculateFinalFee(age, isPWD, baseFee) {
    let discountInfo = calculateDiscount(age, isPWD, baseFee);
    let finalFee = baseFee - discountInfo.amount;
    
    return {
        baseFee: baseFee,
        discount: discountInfo.amount,
        discountReason: discountInfo.reason,
        finalFee: finalFee
    };
}

// Function: Process single visitor
function processVisitor(name, age, isPWD, service) {
    console.log("--- Processing Visitor ---");
    console.log("Name: " + name);
    console.log("Age: " + age);
    console.log("Service: " + service);
    
    let feeInfo = calculateFinalFee(age, isPWD, OFFICE_FEE);
    
    console.log("\nFee Breakdown:");
    console.log("Base Fee: ₱" + feeInfo.baseFee);
    
    if (feeInfo.discount > 0) {
        console.log("Discount (" + feeInfo.discountReason + "): -₱" + feeInfo.discount);
    }
    
    console.log("Final Fee: ₱" + feeInfo.finalFee);
    console.log();
    
    return feeInfo.finalFee;
}

// Function: Process multiple visitors
function processDailyVisitors(visitors) {
    displayHeader();
    
    let totalRevenue = 0;
    let visitorCount = visitors.length;
    
    for (let i = 0; i < visitors.length; i++) {
        let v = visitors[i];
        let fee = processVisitor(v.name, v.age, v.isPWD, v.service);
        totalRevenue += fee;
    }
    
    console.log("=================================");
    console.log("DAILY SUMMARY");
    console.log("=================================");
    console.log("Total Visitors: " + visitorCount);
    console.log("Total Revenue: ₱" + totalRevenue);
    console.log("Average Fee: ₱" + (totalRevenue / visitorCount).toFixed(2));
}

// Main execution
const dailyVisitors = [
    { name: "Juan Dela Cruz", age: 25, isPWD: false, service: "Clearance" },
    { name: "Maria Santos", age: 65, isPWD: false, service: "Residency" },
    { name: "Pedro Reyes", age: 30, isPWD: true, service: "Indigency" },
    { name: "Rosa Garcia", age: 45, isPWD: false, service: "Clearance" }
];

processDailyVisitors(dailyVisitors);
```

---

## Best Practices

### 1. Use descriptive function names
```javascript
// Bad
function calc(x, y) {
    return x + y;
}

// Good
function calculateTotalFee(baseFee, additionalFee) {
    return baseFee + additionalFee;
}
```

### 2. Keep functions small and focused
```javascript
// Bad - does too much
function processEverything(data) {
    // Validate
    // Calculate
    // Display
    // Save to database
}

// Good - separate concerns
function validateData(data) { /* ... */ }
function calculateFee(data) { /* ... */ }
function displayResult(data) { /* ... */ }
function saveToDatabase(data) { /* ... */ }
```

### 3. Use return instead of console.log
```javascript
// Bad - hard to test and reuse
function add(a, b) {
    console.log(a + b);
}

// Good - returns value for flexibility
function add(a, b) {
    return a + b;
}

let result = add(5, 3);
console.log("Result: " + result);
```

### 4. Avoid modifying global variables
```javascript
// Bad
let total = 0;

function addToTotal(amount) {
    total += amount;  // Modifies global
}

// Good
function calculateTotal(currentTotal, amount) {
    return currentTotal + amount;  // Returns new value
}

let total = 0;
total = calculateTotal(total, 50);
```

---

## Summary

Tian summarized functions:

**Function Declaration:**
```javascript
function name(parameters) {
    // Code
    return value;
}
```

**Function Expression:**
```javascript
const name = function(parameters) {
    // Code
};
```

**Calling Functions:**
```javascript
let result = functionName(arguments);
```

**Scope:**
- **Global:** Accessible everywhere
- **Local:** Only in function
- **Block:** Only in block (let/const)

**Key Points:**
- Functions make code reusable
- Use parameters for input, return for output
- Keep functions small and focused
- Use descriptive names

Rhea Joy smiled. "Now our code is organized and reusable!"

---

## What's Next?

In the next lesson, you'll learn about **Arrays and Objects**—how to store and manage complex data structures.

---

---

## Closing Story

Tian wrote the first reusable function: `calculateTax(income)`. Called it ten times with different values. Same logic, different results. This was abstraction. This was engineering.

"Functions are the building blocks of software," Kuya Miguel noted. "Write once, use everywhere. That's the DRY principleDon't Repeat Yourself."

Tian refactored the barangay portalextracted repeated code into functions. The codebase shrank by 40%. The logic became clearer. The architecture improved.

_Next up: Arrays and Objectsstructuring data!_