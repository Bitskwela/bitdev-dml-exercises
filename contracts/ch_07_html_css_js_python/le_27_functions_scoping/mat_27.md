# Lesson 27: Functions and Scoping

---

## Organizing Code with Functions

"Kuya Miguel, we keep calculating barangay fees in different places. How do we avoid repeating the same code?" Tian asked.

Rhea Joy added, "And what if we need to change the calculation formula later?"

Kuya Miguel smiled. "That's why we use **functions**—reusable blocks of code that perform specific tasks. Write once, use anywhere!"

---

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