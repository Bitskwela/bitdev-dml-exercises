# Quiz 27: Functions and Scoping

Test your understanding of functions, parameters, return values, and scope!

---

## Quiz 1

### Question 1
What is the output?
```javascript
function greet() {
    console.log("Hello!");
}

greet();
```

A) `function greet()`  
B) `Hello!`  
C) `greet()`  
D) Nothing

---

### Question 2
What is the output?
```javascript
function add(a, b) {
    return a + b;
}

let result = add(5, 3);
console.log(result);
```

A) `5`  
B) `3`  
C) `8`  
D) `53`

---

### Question 3
What happens if you don't use `return` in a function?
```javascript
function multiply(x, y) {
    let result = x * y;
}

console.log(multiply(3, 4));
```

A) `12`  
B) `undefined`  
C) `0`  
D) Error

---

### Question 4
What is the output?
```javascript
function calculate(a, b = 5) {
    return a + b;
}

console.log(calculate(10));
```

A) `10`  
B) `5`  
C) `15`  
D) Error

---

### Question 5
What is the scope of `x`?
```javascript
function myFunction() {
    let x = 10;
}

myFunction();
console.log(x);
```

A) Global scope  
B) Function scope (error when accessing outside)  
C) Block scope  
D) No scope

---

## Quiz 2

### Question 6
What is the output?
```javascript
const greeting = function(name) {
    return "Hello, " + name;
};

console.log(greeting("Juan"));
```

A) `function greeting`  
B) `Hello, name`  
C) `Hello, Juan`  
D) Error

---

### Question 7
Can this function access `globalVar`?
```javascript
let globalVar = "Accessible";

function testScope() {
    console.log(globalVar);
}

testScope();
```

A) Yes, prints `"Accessible"`  
B) No, error  
C) Prints `undefined`  
D) Prints `null`

---

### Question 8
What is the output?
```javascript
function calculateFee(age, baseFee) {
    if (age >= 60) {
        return baseFee * 0.8;
    }
    return baseFee;
}

let fee = calculateFee(65, 100);
console.log(fee);
```

A) `100`  
B) `80`  
C) `20`  
D) `120`

---

### Question 9
What happens when calling this function?
```javascript
function divide(a, b) {
    return a / b;
}

console.log(divide(10));
```

A) `10`  
B) `NaN`  
C) `undefined`  
D) Error

---

### Question 10
Can the inner function access `outerVar`?
```javascript
function outer() {
    let outerVar = "Hello";
    
    function inner() {
        console.log(outerVar);
    }
    
    inner();
}

outer();
```

A) Yes, prints `"Hello"`  
B) No, error  
C) Prints `undefined`  
D) Prints `null`

---

## Answers

1. **B** - `Hello!`
2. **C** - `8`
3. **B** - `undefined`
4. **C** - `15`
5. **B** - Function scope (error when accessing outside)
6. **C** - `Hello, Juan`
7. **A** - Yes, prints `"Accessible"`
8. **B** - `80`
9. **B** - `NaN`
10. **A** - Yes, prints `"Hello"`

---

## Detailed Explanations

### Question 1: Basic function call
```javascript
function greet() {
    console.log("Hello!");
}

greet();
```

**Answer: B - `Hello!`**

**Explanation:**
1. Define function `greet`
2. Call function with `greet()`
3. Code inside function executes
4. Prints: `"Hello!"`

**Barangay example:**
```javascript
function announceOfficeHours() {
    console.log("Office hours: 8 AM - 5 PM");
}

announceOfficeHours();  // Call the function
// Output: Office hours: 8 AM - 5 PM
```

---

### Question 2: Return values
```javascript
function add(a, b) {
    return a + b;
}

let result = add(5, 3);
console.log(result);
```

**Answer: C - `8`**

**Explanation:**
1. Call `add(5, 3)`
2. `a = 5`, `b = 3`
3. Return `5 + 3 = 8`
4. Store in `result`
5. Print: `8`

**Key:** `return` sends value back to caller.

**Barangay fee calculator:**
```javascript
function calculateFee(baseFee, discount) {
    return baseFee - discount;
}

let finalFee = calculateFee(100, 20);
console.log("Fee: ₱" + finalFee);
// Output: Fee: ₱80
```

---

### Question 3: Missing return statement
```javascript
function multiply(x, y) {
    let result = x * y;
}

console.log(multiply(3, 4));
```

**Answer: B - `undefined`**

**Explanation:**
- Function calculates `3 * 4 = 12`
- Stores in local variable `result`
- **No return statement**
- Functions without return automatically return `undefined`

**Fix:**
```javascript
function multiply(x, y) {
    let result = x * y;
    return result;  // Add return
}

console.log(multiply(3, 4));  // Output: 12
```

**Barangay example:**
```javascript
// Bad - no return
function calculateDiscount(fee) {
    let discount = fee * 0.2;
}

console.log(calculateDiscount(100));  // undefined

// Good - with return
function calculateDiscount(fee) {
    let discount = fee * 0.2;
    return discount;
}

console.log(calculateDiscount(100));  // 20
```

---

### Question 4: Default parameters
```javascript
function calculate(a, b = 5) {
    return a + b;
}

console.log(calculate(10));
```

**Answer: C - `15`**

**Explanation:**
- Call: `calculate(10)`
- `a = 10` (provided)
- `b = 5` (default, not provided)
- Return: `10 + 5 = 15`

**Default parameters kick in when argument is missing:**
```javascript
calculate(10, 3);   // a=10, b=3 → Result: 13
calculate(10);      // a=10, b=5 (default) → Result: 15
```

**Barangay service with defaults:**
```javascript
function processService(name = "Guest", fee = 50) {
    console.log("Name: " + name);
    console.log("Fee: ₱" + fee);
}

processService("Juan", 100);
// Output: Name: Juan, Fee: ₱100

processService();
// Output: Name: Guest, Fee: ₱50
```

---

### Question 5: Function scope
```javascript
function myFunction() {
    let x = 10;
}

myFunction();
console.log(x);
```

**Answer: B - Function scope (error when accessing outside)**

**Explanation:**
- `x` is declared inside function with `let`
- `let` creates **function/block scoped** variable
- `x` only exists inside `myFunction`
- Trying to access outside: **Error!**

**Error message:**
```
ReferenceError: x is not defined
```

**Scope visibility:**
```javascript
let globalVar = "I'm global";

function myFunction() {
    let localVar = "I'm local";
    
    console.log(globalVar);  // ✓ Can access
    console.log(localVar);   // ✓ Can access
}

myFunction();
console.log(globalVar);  // ✓ Can access
console.log(localVar);   // ✗ Error!
```

**Barangay example:**
```javascript
const officeName = "Barangay Hall";  // Global

function processVisitor() {
    const visitorName = "Juan";  // Local
    
    console.log(officeName);   // ✓ Works
    console.log(visitorName);  // ✓ Works
}

processVisitor();
console.log(officeName);   // ✓ Works
console.log(visitorName);  // ✗ Error!
```

---

### Question 6: Function expressions
```javascript
const greeting = function(name) {
    return "Hello, " + name;
};

console.log(greeting("Juan"));
```

**Answer: C - `Hello, Juan`**

**Explanation:**
1. Store anonymous function in `greeting` constant
2. Call: `greeting("Juan")`
3. `name = "Juan"`
4. Return: `"Hello, " + "Juan"` = `"Hello, Juan"`
5. Print: `Hello, Juan`

**Function Declaration vs Expression:**
```javascript
// Declaration
function greet1(name) {
    return "Hi, " + name;
}

// Expression
const greet2 = function(name) {
    return "Hi, " + name;
};

// Both work the same when called
console.log(greet1("Maria"));  // Hi, Maria
console.log(greet2("Maria"));  // Hi, Maria
```

---

### Question 7: Accessing global variables
```javascript
let globalVar = "Accessible";

function testScope() {
    console.log(globalVar);
}

testScope();
```

**Answer: A - Yes, prints `"Accessible"`**

**Explanation:**
- `globalVar` is declared outside function (global scope)
- Functions can access variables from outer scopes
- Prints: `"Accessible"`

**Scope chain:**
```javascript
const level1 = "Global";

function outer() {
    const level2 = "Outer function";
    
    function inner() {
        const level3 = "Inner function";
        
        console.log(level1);  // ✓ Can access
        console.log(level2);  // ✓ Can access
        console.log(level3);  // ✓ Can access
    }
    
    inner();
}

outer();
```

**Barangay example:**
```javascript
const OFFICE_FEE = 50;  // Global constant

function calculateFee(age) {
    // Can access global OFFICE_FEE
    if (age >= 60) {
        return OFFICE_FEE * 0.8;
    }
    return OFFICE_FEE;
}

console.log(calculateFee(25));  // 50
console.log(calculateFee(65));  // 40
```

---

### Question 8: Conditional return
```javascript
function calculateFee(age, baseFee) {
    if (age >= 60) {
        return baseFee * 0.8;
    }
    return baseFee;
}

let fee = calculateFee(65, 100);
console.log(fee);
```

**Answer: B - `80`**

**Explanation:**
- `age = 65`, `baseFee = 100`
- Condition: `65 >= 60` is `true`
- Return: `100 * 0.8 = 80`
- Second return never executes (already returned)

**Multiple returns:**
```javascript
function getDiscount(age, isPWD) {
    if (age >= 60) {
        return 0.20;  // 20% senior
    }
    if (isPWD) {
        return 0.20;  // 20% PWD
    }
    return 0;  // No discount
}

console.log(getDiscount(65, false));  // 0.20
console.log(getDiscount(30, true));   // 0.20
console.log(getDiscount(30, false));  // 0
```

---

### Question 9: Missing parameter
```javascript
function divide(a, b) {
    return a / b;
}

console.log(divide(10));
```

**Answer: B - `NaN`**

**Explanation:**
- Call: `divide(10)`
- `a = 10` (provided)
- `b = undefined` (not provided)
- Calculate: `10 / undefined = NaN`
- `NaN` means "Not a Number"

**Better: Use default parameter:**
```javascript
function divide(a, b = 1) {
    return a / b;
}

console.log(divide(10));     // 10 / 1 = 10
console.log(divide(10, 2));  // 10 / 2 = 5
```

**Barangay example with validation:**
```javascript
function calculateFee(visitors, baseFee) {
    if (visitors === undefined || baseFee === undefined) {
        console.log("Error: Missing parameters");
        return 0;
    }
    return visitors * baseFee;
}

console.log(calculateFee(5, 50));  // 250
console.log(calculateFee(5));      // Error: Missing parameters, 0
```

---

### Question 10: Nested function scope
```javascript
function outer() {
    let outerVar = "Hello";
    
    function inner() {
        console.log(outerVar);
    }
    
    inner();
}

outer();
```

**Answer: A - Yes, prints `"Hello"`**

**Explanation:**
- Inner functions can access outer function variables
- `inner()` can see `outerVar` from `outer()`
- This is called **closure**

**Scope chain:**
```javascript
const global = "Global";

function outer() {
    const outerVar = "Outer";
    
    function inner() {
        const innerVar = "Inner";
        
        console.log(global);     // ✓ Can access
        console.log(outerVar);   // ✓ Can access
        console.log(innerVar);   // ✓ Can access
    }
    
    inner();
    // console.log(innerVar);  // ✗ Error!
}

outer();
```

**Barangay nested example:**
```javascript
function processDailyVisitors() {
    const date = "2024-01-15";
    let totalFee = 0;
    
    function processVisitor(name, fee) {
        // Can access outer variables
        console.log("Date: " + date);
        console.log("Visitor: " + name);
        console.log("Fee: ₱" + fee);
        
        totalFee += fee;  // Modify outer variable
    }
    
    processVisitor("Juan", 50);
    processVisitor("Maria", 40);
    
    console.log("Total: ₱" + totalFee);
}

processDailyVisitors();
```

---

**Great job!** You now understand how to organize code with functions and manage variable scope!

---
