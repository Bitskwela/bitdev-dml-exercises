# Quiz: Arrow Functions, Destructuring, and Spread

---

## Quiz 1

**1. Which is the correct arrow function syntax?**

a) `const add = (a, b) => { return a + b; }`  
b) `const add = (a, b) => a + b;`  
c) `const add = a, b => a + b;`  
d) Both a and b

**Answer: d**

Both explicit return with braces and implicit return without braces are valid arrow function syntax.

---

**2. What does `let {name, age} = person;` do?**

a) Creates an object  
b) Extracts name and age properties from person  
c) Assigns person to name and age  
d) Causes an error

**Answer: b**

This is object destructuring - it extracts the `name` and `age` properties from the `person` object into variables.

---

**3. What is the output? `const double = x => x * 2; console.log(double(5));`**

a) `5`  
b) `10`  
c) `x * 2`  
d) Error

**Answer: b**

The arrow function doubles the input: `double(5)` returns `5 * 2 = 10`.

---

**4. What does the spread operator `...` do in `[...array1, ...array2]`?**

a) Multiplies arrays  
b) Combines arrays into one  
c) Compares arrays  
d) Removes duplicates

**Answer: b**

The spread operator `...` combines (concatenates) multiple arrays into one new array.

---

**5. How do you destructure the second element of an array?**

a) `let [, second] = array;`  
b) `let [second] = array;`  
c) `let {1} = array;`  
d) `let second = array.second;`

**Answer: a**

Use a comma to skip the first element: `let [, second] = array;` gets the second element.

---

## Quiz 2

**6. What's the difference between these?**
```javascript
// A
let copy = array;
// B
let copy = [...array];
```

a) No difference  
b) A creates reference, B creates copy  
c) B is slower  
d) A is ES6, B is old syntax

**Answer: b**

A creates a reference (both variables point to same array), B creates a shallow copy (new array with same values).

---

**7. What does `const sum = (...nums) => nums.reduce((a,b) => a+b, 0);` do?**

a) Sums first two numbers  
b) Sums all arguments passed  
c) Returns an array  
d) Causes an error

**Answer: b**

The rest parameter `...nums` collects all arguments into an array, then `reduce()` sums them all.

---

**8. How do you rename a destructured property?**

a) `let {name as fullName} = person;`  
b) `let {name: fullName} = person;`  
c) `let {name.fullName} = person;`  
d) `let {name = fullName} = person;`

**Answer: b**

Use colon syntax to rename: `let {name: fullName} = person;` extracts `name` and stores it in `fullName`.

---

**9. What's the output?**
```javascript
let obj1 = {a: 1, b: 2};
let obj2 = {b: 3, c: 4};
let result = {...obj1, ...obj2};
```

a) `{a: 1, b: 2, c: 4}`  
b) `{a: 1, b: 3, c: 4}`  
c) `{a: 1, b: 2, b: 3, c: 4}`  
d) Error

**Answer: b**

Later properties override earlier ones. `obj2.b` (3) overrides `obj1.b` (2), resulting in `{a: 1, b: 3, c: 4}`.

---

**10. When should you NOT use arrow functions?**

a) Array methods (map, filter)  
b) Event listeners  
c) Methods that need `this` context  
d) Simple one-liners

**Answer: c**

Avoid arrow functions for object methods that need `this` context, as arrow functions don't have their own `this`.

---

## Detailed Explanations

### Question 1: Arrow Function Syntax

**Correct Answer: d) Both a and b**

Arrow functions can be written in multiple ways:

```javascript
// With curly braces and explicit return
const add = (a, b) => {
    return a + b;
};

// Implicit return (no curly braces)
const add = (a, b) => a + b;

// Both produce same result
console.log(add(5, 3)); // 8
```

**Barangay example:**
```javascript
// Calculate service fee with discount
const calculateFee = (baseFee, isSenior) => {
    if (isSenior) {
        return baseFee * 0.8; // 20% discount
    }
    return baseFee;
};

// Shorter version
const calculateFee = (baseFee, isSenior) => 
    isSenior ? baseFee * 0.8 : baseFee;

console.log(calculateFee(50, true));  // 40
console.log(calculateFee(50, false)); // 50
```

---

### Question 2: Object Destructuring

**Correct Answer: b) Extracts name and age properties from person**

```javascript
let person = {
    name: 'Juan Dela Cruz',
    age: 30,
    barangay: 'San Antonio'
};

// Extract specific properties
let {name, age} = person;

console.log(name); // Juan Dela Cruz
console.log(age);  // 30
// barangay is not extracted
```

**Barangay example:**
```javascript
let application = {
    id: 'APP-001',
    applicant: 'Maria Santos',
    service: 'Barangay Clearance',
    fee: 50,
    status: 'pending'
};

// Extract only needed properties
let {applicant, service, fee} = application;

console.log(`${applicant} applied for ${service} (₱${fee})`);
// Maria Santos applied for Barangay Clearance (₱50)
```

---

### Question 3: Arrow Function Output

**Correct Answer: b) 10**

```javascript
const double = x => x * 2;
console.log(double(5)); // 10
```

Arrow function with implicit return multiplies 5 by 2.

**Barangay example:**
```javascript
let fees = [50, 30, 20, 100];

// Double all fees
let doubled = fees.map(fee => fee * 2);
console.log(doubled); // [100, 60, 40, 200]

// Filter fees over 50
let expensive = fees.filter(fee => fee > 50);
console.log(expensive); // [100]

// Calculate total
let total = fees.reduce((sum, fee) => sum + fee, 0);
console.log(total); // 200
```

---

### Question 4: Spread Operator

**Correct Answer: b) Combines arrays into one**

```javascript
let morning = [1, 2, 3];
let afternoon = [4, 5, 6];

let allDay = [...morning, ...afternoon];
console.log(allDay); // [1, 2, 3, 4, 5, 6]
```

**Barangay example:**
```javascript
let morningVisitors = ['Juan', 'Maria'];
let afternoonVisitors = ['Pedro', 'Ana'];
let eveningVisitors = ['Carlos'];

// Combine all visitors
let allVisitors = [...morningVisitors, ...afternoonVisitors, ...eveningVisitors];
console.log(allVisitors);
// ['Juan', 'Maria', 'Pedro', 'Ana', 'Carlos']

// Add new visitor
let updatedVisitors = [...allVisitors, 'Rosa'];
// Original array unchanged
```

---

### Question 5: Destructuring Second Element

**Correct Answer: a) `let [, second] = array;`**

```javascript
let numbers = [10, 20, 30, 40];

// Skip first, get second
let [, second] = numbers;
console.log(second); // 20

// Get first and third
let [first, , third] = numbers;
console.log(first); // 10
console.log(third); // 30
```

**Barangay example:**
```javascript
let topServices = ['Clearance', 'Cedula', 'Business Permit', 'Certificate'];

// Get second most popular
let [, secondPlace] = topServices;
console.log(secondPlace); // Cedula

// Get top 3
let [first, second, third] = topServices;
console.log(`Top 3: ${first}, ${second}, ${third}`);
// Top 3: Clearance, Cedula, Business Permit
```

---

### Question 6: Array Copy vs Reference

**Correct Answer: b) A creates reference, B creates copy**

```javascript
let original = [1, 2, 3];

// A: Creates reference (both point to same array)
let ref = original;
ref.push(4);
console.log(original); // [1, 2, 3, 4] - CHANGED!

// B: Creates copy (independent array)
let copy = [...original];
copy.push(5);
console.log(original); // [1, 2, 3, 4] - unchanged
console.log(copy);     // [1, 2, 3, 4, 5]
```

**Barangay example:**
```javascript
let pendingApplications = ['APP-001', 'APP-002', 'APP-003'];

// WRONG: Reference
let processing = pendingApplications;
processing.pop(); // Removes from both!

// CORRECT: Copy
let processing = [...pendingApplications];
processing.pop(); // Only removes from copy
console.log(pendingApplications); // ['APP-001', 'APP-002', 'APP-003'] - safe!
```

---

### Question 7: Rest Parameters

**Correct Answer: b) Sums all arguments passed**

```javascript
const sum = (...nums) => nums.reduce((a, b) => a + b, 0);

console.log(sum(1, 2, 3));       // 6
console.log(sum(10, 20, 30, 40)); // 100
console.log(sum(5));              // 5
```

**Barangay example:**
```javascript
// Calculate total fees (any number of arguments)
const calculateTotal = (...fees) => {
    return fees.reduce((total, fee) => total + fee, 0);
};

console.log(calculateTotal(50, 30, 20));        // 100
console.log(calculateTotal(100, 50));           // 150
console.log(calculateTotal(30, 30, 30, 30, 30)); // 150

// With service names
const recordTransaction = (resident, ...services) => {
    console.log(`Resident: ${resident}`);
    console.log(`Services: ${services.join(', ')}`);
};

recordTransaction('Juan Dela Cruz', 'Clearance', 'Cedula', 'ID');
// Resident: Juan Dela Cruz
// Services: Clearance, Cedula, ID
```

---

### Question 8: Renaming Destructured Properties

**Correct Answer: b) `let {name: fullName} = person;`**

```javascript
let person = {name: 'Juan', age: 30};

// Rename during destructuring
let {name: fullName, age: years} = person;

console.log(fullName); // Juan
console.log(years);    // 30
// name and age variables don't exist
```

**Barangay example:**
```javascript
let application = {
    id: 'APP-001',
    name: 'Juan Dela Cruz',
    service: 'Clearance',
    amount: 50
};

// Rename to avoid conflicts or be more descriptive
let {
    name: applicantName,
    service: requestedService,
    amount: paymentAmount
} = application;

console.log(`${applicantName} requested ${requestedService} for ₱${paymentAmount}`);
```

---

### Question 9: Spread with Objects

**Correct Answer: b) `{a: 1, b: 3, c: 4}`**

When spreading objects, **later properties override earlier ones**:

```javascript
let obj1 = {a: 1, b: 2};
let obj2 = {b: 3, c: 4};

let result = {...obj1, ...obj2};
// {a: 1, b: 3, c: 4}
// obj2's b (3) overrides obj1's b (2)
```

**Barangay example:**
```javascript
let defaultSettings = {
    office: 'Main Hall',
    hours: '8AM-5PM',
    status: 'open'
};

let customSettings = {
    hours: '7AM-6PM', // Override
    contact: '123-4567' // Add new
};

let finalSettings = {...defaultSettings, ...customSettings};
console.log(finalSettings);
// {
//   office: 'Main Hall',
//   hours: '7AM-6PM',  ← overridden
//   status: 'open',
//   contact: '123-4567' ← added
// }
```

---

### Question 10: When NOT to Use Arrow Functions

**Correct Answer: c) Methods that need `this` context**

Arrow functions **don't have their own `this`**:

```javascript
let person = {
    name: 'Juan',
    // WRONG: Arrow function
    greet: () => {
        console.log('Hello, ' + this.name); // undefined!
    },
    // CORRECT: Regular function
    greetCorrect: function() {
        console.log('Hello, ' + this.name); // Works!
    }
};
```

**Barangay example:**
```javascript
let barangayOffice = {
    name: 'San Antonio',
    visitors: 0,
    
    // WRONG: Arrow function loses 'this'
    addVisitor: () => {
        this.visitors++; // Doesn't work!
    },
    
    // CORRECT: Regular function
    addVisitorCorrect: function() {
        this.visitors++;
        console.log(`${this.name} now has ${this.visitors} visitors`);
    },
    
    // CORRECT: Arrow function inside method is fine
    displayVisitors: function() {
        setTimeout(() => {
            console.log(`${this.name}: ${this.visitors} visitors`);
            // Arrow function inherits 'this' from displayVisitors
        }, 1000);
    }
};
```

**Use arrow functions for:**
- Array methods (map, filter, reduce)
- Event listeners (when you don't need `this`)
- Callbacks and simple functions

**Use regular functions for:**
- Object methods
- Constructor functions
- When you need `arguments` object

---
