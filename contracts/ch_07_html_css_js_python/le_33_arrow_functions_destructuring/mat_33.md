# Lesson 33: Arrow Functions, Destructuring, and Spread - Modern JavaScript Syntax

---

## Cleaner, More Concise Code

"Kuya Miguel, some JavaScript code looks different in tutorials—shorter functions with `=>` arrows. What's that?" Tian asked.

Rhea Joy added, "And I've seen `{name, age}` instead of `person.name, person.age`. Is that a shortcut?"

Kuya Miguel nodded. "Those are **modern ES6+ features**—arrow functions, destructuring, and spread operators. They make code cleaner and more expressive. Let's master them!"

---

## Arrow Functions

**Traditional function:**
```javascript
function greet(name) {
    return 'Hello, ' + name;
}
```

**Arrow function:**
```javascript
const greet = (name) => {
    return 'Hello, ' + name;
};
```

**Even shorter (implicit return):**
```javascript
const greet = (name) => 'Hello, ' + name;
```

**Arrow function syntax rules:**
```javascript
// No parameters
const sayHello = () => 'Hello!';

// One parameter (parentheses optional)
const double = x => x * 2;
const greet = name => 'Hi, ' + name;

// Multiple parameters (parentheses required)
const add = (a, b) => a + b;

// Multiple statements (curly braces + return)
const calculate = (a, b) => {
    let sum = a + b;
    return sum * 2;
};
```

---

## Arrow Functions with Arrays

**Perfect for array methods:**
```javascript
let residents = ['Juan', 'Maria', 'Pedro'];

// Traditional
residents.forEach(function(name) {
    console.log(name);
});

// Arrow function
residents.forEach(name => console.log(name));

// Map example
let ages = [25, 30, 35];
let doubled = ages.map(age => age * 2);
console.log(doubled); // [50, 60, 70]

// Filter example
let numbers = [5, 12, 8, 20, 3];
let filtered = numbers.filter(num => num >= 10);
console.log(filtered); // [12, 20]
```

---

## Arrow Functions in Event Listeners

```javascript
// Traditional
button.addEventListener('click', function() {
    console.log('Clicked!');
});

// Arrow function
button.addEventListener('click', () => {
    console.log('Clicked!');
});

// Barangay example
document.querySelector('#submitBtn').addEventListener('click', () => {
    let name = document.querySelector('#name').value;
    let age = document.querySelector('#age').value;
    console.log(`Applicant: ${name}, Age: ${age}`);
});
```

---

## Object Destructuring

**Extract properties from objects:**

**Without destructuring:**
```javascript
let person = {
    name: 'Juan Dela Cruz',
    age: 30,
    barangay: 'San Antonio'
};

let name = person.name;
let age = person.age;
let barangay = person.barangay;
```

**With destructuring:**
```javascript
let person = {
    name: 'Juan Dela Cruz',
    age: 30,
    barangay: 'San Antonio'
};

let {name, age, barangay} = person;

console.log(name);     // Juan Dela Cruz
console.log(age);      // 30
console.log(barangay); // San Antonio
```

**Rename variables:**
```javascript
let person = {name: 'Juan', age: 30};

let {name: fullName, age: years} = person;

console.log(fullName); // Juan
console.log(years);    // 30
```

**Default values:**
```javascript
let person = {name: 'Juan'};

let {name, age = 25, city = 'Manila'} = person;

console.log(age);  // 25 (default)
console.log(city); // Manila (default)
```

---

## Array Destructuring

**Extract values from arrays:**

**Without destructuring:**
```javascript
let colors = ['red', 'green', 'blue'];
let first = colors[0];
let second = colors[1];
let third = colors[2];
```

**With destructuring:**
```javascript
let colors = ['red', 'green', 'blue'];
let [first, second, third] = colors;

console.log(first);  // red
console.log(second); // green
console.log(third);  // blue
```

**Skip elements:**
```javascript
let numbers = [10, 20, 30, 40];
let [first, , third] = numbers; // Skip second

console.log(first); // 10
console.log(third); // 30
```

**Rest of elements:**
```javascript
let numbers = [1, 2, 3, 4, 5];
let [first, second, ...rest] = numbers;

console.log(first);  // 1
console.log(second); // 2
console.log(rest);   // [3, 4, 5]
```

---

## Spread Operator (...)

**Expand arrays and objects:**

**Combine arrays:**
```javascript
let morning = ['Juan', 'Maria'];
let afternoon = ['Pedro', 'Ana'];

let allVisitors = [...morning, ...afternoon];
console.log(allVisitors); // ['Juan', 'Maria', 'Pedro', 'Ana']
```

**Copy array:**
```javascript
let original = [1, 2, 3];
let copy = [...original];

console.log(copy); // [1, 2, 3]
copy.push(4);
console.log(original); // [1, 2, 3] (unchanged)
console.log(copy);     // [1, 2, 3, 4]
```

**Spread in function calls:**
```javascript
let numbers = [5, 12, 8, 20];
let max = Math.max(...numbers);

console.log(max); // 20
```

**Combine objects:**
```javascript
let person = {name: 'Juan', age: 30};
let address = {city: 'Manila', barangay: 'San Antonio'};

let complete = {...person, ...address};
console.log(complete);
// {name: 'Juan', age: 30, city: 'Manila', barangay: 'San Antonio'}
```

**Copy and override:**
```javascript
let original = {name: 'Juan', age: 30, city: 'Manila'};
let updated = {...original, age: 31};

console.log(updated);
// {name: 'Juan', age: 31, city: 'Manila'}
```

---

## Complete Barangay Example

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Modern JavaScript - Barangay System</title>
</head>
<body>
    <h1>Barangay Resident Management</h1>
    
    <input type="text" id="name" placeholder="Name">
    <input type="number" id="age" placeholder="Age">
    <input type="text" id="address" placeholder="Address">
    <button id="addBtn">Add Resident</button>
    <br><br>
    
    <button id="showAdults">Show Adults (18+)</button>
    <button id="showAll">Show All</button>
    <br><br>
    
    <div id="output"></div>
    
    <script>
        // Resident database
        let residents = [
            {name: 'Juan Dela Cruz', age: 30, address: 'Block 1'},
            {name: 'Maria Santos', age: 25, address: 'Block 2'},
            {name: 'Pedro Reyes', age: 17, address: 'Block 3'}
        ];
        
        // Add resident with destructuring
        document.querySelector('#addBtn').addEventListener('click', () => {
            let name = document.querySelector('#name').value;
            let age = parseInt(document.querySelector('#age').value);
            let address = document.querySelector('#address').value;
            
            if (!name || !age || !address) {
                alert('Please fill all fields');
                return;
            }
            
            // Create new resident object
            let newResident = {name, age, address}; // Shorthand property names
            
            // Add to array using spread
            residents = [...residents, newResident];
            
            // Clear inputs
            document.querySelector('#name').value = '';
            document.querySelector('#age').value = '';
            document.querySelector('#address').value = '';
            
            alert('Resident added!');
            displayResidents(residents);
        });
        
        // Show adults only
        document.querySelector('#showAdults').addEventListener('click', () => {
            let adults = residents.filter(({age}) => age >= 18);
            displayResidents(adults);
        });
        
        // Show all residents
        document.querySelector('#showAll').addEventListener('click', () => {
            displayResidents(residents);
        });
        
        // Display function with destructuring
        const displayResidents = (list) => {
            let output = document.querySelector('#output');
            
            if (list.length === 0) {
                output.innerHTML = '<p>No residents found.</p>';
                return;
            }
            
            let html = '<h3>Residents:</h3>';
            
            // Use destructuring in map
            html += list.map(({name, age, address}, index) => `
                <div style="padding: 10px; background: #f0f0f0; margin: 5px 0; border-radius: 5px;">
                    <strong>${index + 1}. ${name}</strong><br>
                    Age: ${age} | Address: ${address}
                </div>
            `).join('');
            
            output.innerHTML = html;
        };
        
        // Initial display
        displayResidents(residents);
    </script>
</body>
</html>
```

---

## Practical Examples

### 1. Filtering with Arrow Functions
```javascript
let services = [
    {name: 'Clearance', fee: 50, available: true},
    {name: 'Cedula', fee: 30, available: true},
    {name: 'Business Permit', fee: 200, available: false}
];

// Get available services
let available = services.filter(s => s.available);

// Get affordable services (< 100)
let affordable = services.filter(s => s.fee < 100);

// Get service names only
let names = services.map(s => s.name);
```

### 2. Destructuring in Functions
```javascript
// Function parameter destructuring
const displayResident = ({name, age, address}) => {
    console.log(`Name: ${name}`);
    console.log(`Age: ${age}`);
    console.log(`Address: ${address}`);
};

let person = {name: 'Juan', age: 30, address: 'Block 1'};
displayResident(person);
```

### 3. Rest Parameters
```javascript
// Collect all arguments into array
const calculateTotal = (...fees) => {
    return fees.reduce((sum, fee) => sum + fee, 0);
};

console.log(calculateTotal(50, 30, 20)); // 100
console.log(calculateTotal(10, 20));     // 30
```

---

## Best Practices

**1. Use arrow functions for callbacks:**
```javascript
// Good
array.map(x => x * 2);
button.addEventListener('click', () => doSomething());
```

**2. Use destructuring to simplify:**
```javascript
// Good
const {name, age} = person;

// Avoid
const name = person.name;
const age = person.age;
```

**3. Use spread for immutability:**
```javascript
// Good - creates new array
let newArray = [...oldArray, newItem];

// Avoid mutating original
oldArray.push(newItem);
```

---

## Summary

**Arrow functions:**
```javascript
const func = (param) => result;
const add = (a, b) => a + b;
```

**Object destructuring:**
```javascript
let {name, age} = person;
```

**Array destructuring:**
```javascript
let [first, second] = array;
```

**Spread operator:**
```javascript
let combined = [...array1, ...array2];
let copy = {...original, newProp: value};
```

---

## What's Next?

In the next lesson, you'll learn **Modular JavaScript**—how to organize code into separate files using `import` and `export`!

---

---

## Closing Story

Tian refactored all functions using arrow syntax: `const greet = (name) => Hello, ;`. The code was cleaner. More concise. More modern.

"ES6 changed JavaScript," Kuya Miguel explained. "Arrow functions, destructuring, spread operatorsthese are industry standards now."

Tian used destructuring to extract object properties, spread operators to merge arrays. The code felt elegant. Professional. This was how modern developers wrote JavaScript.

_Next up: Modular JavaScriptorganizing large codebases!_