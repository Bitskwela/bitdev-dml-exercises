# Activity 1: Arrow Functions and Destructuring

In this activity, you'll learn modern JavaScript syntax that makes your code cleaner and more concise: **arrow functions** and **destructuring**. These ES6+ features are widely used in modern JavaScript development.

---

## Activity 1: Understanding Arrow Functions

Arrow functions are a shorter syntax for writing functions. They use the `=>` syntax (looks like an arrow!).

### Traditional Function vs Arrow Function:

```javascript
// Traditional function
function greet(name) {
    return `Hello, ${name}!`;
}

// Arrow function
const greet = (name) => {
    return `Hello, ${name}!`;
};

// Arrow function (shorter - implicit return)
const greet = (name) => `Hello, ${name}!`;

console.log(greet("Juan"));  // "Hello, Juan!"
```

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Clearance Calculator</title>
</head>
<body>
    <h1>Clearance Fee Calculator</h1>
    
    <label>Age:</label>
    <input type="number" id="age" value="25">
    <br><br>
    
    <label>Clearance Type:</label>
    <select id="type">
        <option value="50">Barangay Clearance (₱50)</option>
        <option value="100">Police Clearance (₱100)</option>
        <option value="150">Business Permit (₱150)</option>
    </select>
    <br><br>
    
    <button id="calculateBtn">Calculate Fee</button>
    <p id="result"></p>

    <script src="arrow.js"></script>
</body>
</html>
```

### JavaScript (arrow.js):
```javascript
// Traditional function
function calculateFeeOld(age, baseFee) {
    if (age >= 60) {
        return baseFee * 0.8; // 20% discount for seniors
    }
    return baseFee;
}

// Arrow function (equivalent)
const calculateFee = (age, baseFee) => {
    if (age >= 60) {
        return baseFee * 0.8;
    }
    return baseFee;
};

// Even shorter with ternary operator
const calculateFeeShort = (age, baseFee) => 
    age >= 60 ? baseFee * 0.8 : baseFee;

const calculateBtn = document.getElementById('calculateBtn');
const result = document.getElementById('result');

calculateBtn.addEventListener('click', () => {
    const age = parseInt(document.getElementById('age').value);
    const baseFee = parseInt(document.getElementById('type').value);
    
    const totalFee = calculateFee(age, baseFee);
    const discount = age >= 60 ? '(20% senior discount applied)' : '';
    
    result.textContent = `Total Fee: ₱${totalFee} ${discount}`;
});
```

**Arrow Function Syntax Rules:**

```javascript
// No parameters
const sayHello = () => "Hello!";

// One parameter (parentheses optional)
const double = x => x * 2;
const double = (x) => x * 2;  // Also valid

// Multiple parameters (parentheses required)
const add = (a, b) => a + b;

// Multiple lines (need curly braces and return)
const calculate = (a, b) => {
    const sum = a + b;
    const average = sum / 2;
    return average;
};

// Implicit return (no return keyword needed)
const multiply = (a, b) => a * b;

// Object literal return (wrap in parentheses!)
const createPerson = (name, age) => ({ name: name, age: age });
```

---

## Activity 2: Arrow Functions with Array Methods

Arrow functions are perfect for array methods like `map`, `filter`, and `reduce`.

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resident Management</title>
    <style>
        .resident { padding: 10px; margin: 5px 0; background: #f5f5f5; border-radius: 5px; }
    </style>
</head>
<body>
    <h1>Barangay Resident List</h1>
    <button id="showAll">Show All</button>
    <button id="showSeniors">Show Seniors Only</button>
    <button id="showWithDiscount">Show Names with Discount</button>
    
    <div id="residentList"></div>

    <script src="residents.js"></script>
</body>
</html>
```

### JavaScript (residents.js):
```javascript
const residents = [
    { name: "Juan Dela Cruz", age: 65, clearanceFee: 50 },
    { name: "Maria Santos", age: 45, clearanceFee: 50 },
    { name: "Pedro Reyes", age: 72, clearanceFee: 50 },
    { name: "Ana Garcia", age: 30, clearanceFee: 50 },
    { name: "Jose Rizal", age: 68, clearanceFee: 50 }
];

const residentList = document.getElementById('residentList');

// Traditional function approach
document.getElementById('showAll').addEventListener('click', function() {
    const html = residents.map(function(resident) {
        return `<div class="resident">${resident.name} - ${resident.age} years old</div>`;
    }).join('');
    residentList.innerHTML = html;
});

// Arrow function approach (cleaner!)
document.getElementById('showSeniors').addEventListener('click', () => {
    // Filter seniors (60+) using arrow function
    const seniors = residents.filter(resident => resident.age >= 60);
    
    const html = seniors.map(resident => 
        `<div class="resident">${resident.name} - ${resident.age} years old (Senior)</div>`
    ).join('');
    
    residentList.innerHTML = html;
});

document.getElementById('showWithDiscount').addEventListener('click', () => {
    // Map to create new array with discounted fees
    const withDiscount = residents.map(resident => {
        const discount = resident.age >= 60 ? resident.clearanceFee * 0.2 : 0;
        const finalFee = resident.clearanceFee - discount;
        
        return {
            ...resident,  // Spread operator (we'll learn this soon!)
            discount: discount,
            finalFee: finalFee
        };
    });
    
    const html = withDiscount.map(resident => 
        `<div class="resident">
            ${resident.name} - ₱${resident.finalFee} 
            ${resident.discount > 0 ? `(₱${resident.discount} discount)` : ''}
        </div>`
    ).join('');
    
    residentList.innerHTML = html;
});
```

**Benefits of Arrow Functions in Array Methods:**
- More concise and readable
- Less boilerplate code
- Easier to chain methods
- Modern JavaScript standard

---

## Activity 3: Array Destructuring

Destructuring lets you extract values from arrays into separate variables.

### Basic Array Destructuring:
```javascript
// Without destructuring
const services = ["Clearance", "Permit", "ID"];
const first = services[0];
const second = services[1];
const third = services[2];

// With destructuring (cleaner!)
const [first, second, third] = services;
console.log(first);   // "Clearance"
console.log(second);  // "Permit"
console.log(third);   // "ID"

// Skip values
const [firstService, , thirdService] = services;
console.log(firstService);  // "Clearance"
console.log(thirdService);  // "ID"

// Rest operator (get remaining items)
const [firstItem, ...remainingItems] = services;
console.log(firstItem);        // "Clearance"
console.log(remainingItems);   // ["Permit", "ID"]
```

### Practical Example:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Service Manager</title>
</head>
<body>
    <h1>Barangay Services</h1>
    <p id="mostPopular"></p>
    <p id="others"></p>

    <script>
        const services = ["Barangay Clearance", "Police Clearance", "Business Permit", "Barangay ID"];
        
        // Destructure: first is most popular, rest are others
        const [mostPopular, ...otherServices] = services;
        
        document.getElementById('mostPopular').textContent = 
            `Most Popular: ${mostPopular}`;
        
        document.getElementById('others').textContent = 
            `Other Services: ${otherServices.join(', ')}`;
    </script>
</body>
</html>
```

---

## Activity 4: Object Destructuring

Object destructuring extracts properties from objects into variables.

### Basic Object Destructuring:
```javascript
// Without destructuring
const resident = {
    name: "Juan Dela Cruz",
    age: 65,
    address: "123 Main St",
    barangay: "San Jose"
};

const name = resident.name;
const age = resident.age;
const address = resident.address;

// With destructuring (cleaner!)
const { name, age, address } = resident;
console.log(name);     // "Juan Dela Cruz"
console.log(age);      // 65
console.log(address);  // "123 Main St"

// Rename variables
const { name: fullName, age: yearsOld } = resident;
console.log(fullName);   // "Juan Dela Cruz"
console.log(yearsOld);   // 65

// Default values
const { name, phone = "Not provided" } = resident;
console.log(phone);  // "Not provided" (doesn't exist in object)

// Nested destructuring
const person = {
    name: "Maria Santos",
    address: {
        street: "456 Oak Ave",
        barangay: "San Jose",
        city: "Manila"
    }
};

const { address: { barangay, city } } = person;
console.log(barangay);  // "San Jose"
console.log(city);      // "Manila"
```

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resident Card</title>
    <style>
        .card {
            padding: 20px;
            background: #f5f5f5;
            border-radius: 10px;
            max-width: 400px;
            margin: 20px auto;
        }
        .card h2 { margin: 0 0 10px 0; color: #2c3e50; }
        .card p { margin: 5px 0; }
    </style>
</head>
<body>
    <div id="cardContainer"></div>

    <script src="card.js"></script>
</body>
</html>
```

### JavaScript (card.js):
```javascript
const resident = {
    name: "Juan Dela Cruz",
    age: 65,
    address: "123 Main St, Brgy San Jose",
    clearanceType: "Barangay Clearance",
    fee: 50,
    applicationDate: "2024-01-15"
};

// Destructure the object
const { name, age, address, clearanceType, fee, applicationDate } = resident;

// Calculate discount
const discount = age >= 60 ? fee * 0.2 : 0;
const totalFee = fee - discount;

// Display card
document.getElementById('cardContainer').innerHTML = `
    <div class="card">
        <h2>${name}</h2>
        <p><strong>Age:</strong> ${age} years old</p>
        <p><strong>Address:</strong> ${address}</p>
        <p><strong>Service:</strong> ${clearanceType}</p>
        <p><strong>Base Fee:</strong> ₱${fee}</p>
        ${discount > 0 ? `<p><strong>Senior Discount:</strong> -₱${discount}</p>` : ''}
        <p><strong>Total Fee:</strong> ₱${totalFee}</p>
        <p><strong>Application Date:</strong> ${applicationDate}</p>
    </div>
`;
```

---

## Activity 5: Destructuring in Function Parameters

You can destructure objects/arrays directly in function parameters.

### Without Destructuring:
```javascript
function displayResident(resident) {
    console.log(`Name: ${resident.name}`);
    console.log(`Age: ${resident.age}`);
    console.log(`Address: ${resident.address}`);
}

const person = { name: "Juan", age: 30, address: "Manila" };
displayResident(person);
```

### With Destructuring (Cleaner):
```javascript
// Destructure in function parameter
function displayResident({ name, age, address }) {
    console.log(`Name: ${name}`);
    console.log(`Age: ${age}`);
    console.log(`Address: ${address}`);
}

const person = { name: "Juan", age: 30, address: "Manila" };
displayResident(person);
```

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fee Calculator</title>
</head>
<body>
    <h1>Clearance Fee Calculator</h1>
    <div id="results"></div>

    <script src="calculator.js"></script>
</body>
</html>
```

### JavaScript (calculator.js):
```javascript
const residents = [
    { name: "Juan Dela Cruz", age: 65, clearanceType: "Barangay Clearance", baseFee: 50 },
    { name: "Maria Santos", age: 45, clearanceType: "Police Clearance", baseFee: 100 },
    { name: "Pedro Reyes", age: 70, clearanceType: "Business Permit", baseFee: 150 }
];

// Function with destructured parameters
const calculateFee = ({ age, baseFee }) => {
    const discount = age >= 60 ? baseFee * 0.2 : 0;
    return baseFee - discount;
};

// Function to display resident fee (destructured parameters + arrow function)
const displayResidentFee = ({ name, age, clearanceType, baseFee }) => {
    const totalFee = calculateFee({ age, baseFee });
    const discountInfo = age >= 60 ? ' (Senior Discount Applied)' : '';
    
    return `
        <div style="padding: 15px; background: #f9f9f9; margin: 10px 0; border-radius: 5px;">
            <h3>${name}</h3>
            <p>Age: ${age}</p>
            <p>Service: ${clearanceType}</p>
            <p>Total Fee: ₱${totalFee}${discountInfo}</p>
        </div>
    `;
};

// Use map with arrow function and spread results
const resultsHTML = residents
    .map(resident => displayResidentFee(resident))
    .join('');

document.getElementById('results').innerHTML = resultsHTML;
```

---

## Activity 6: The Spread Operator (...)

The spread operator (`...`) expands arrays or objects.

### Array Spread:
```javascript
const services1 = ["Clearance", "Permit"];
const services2 = ["ID", "Certificate"];

// Combine arrays
const allServices = [...services1, ...services2];
console.log(allServices);  // ["Clearance", "Permit", "ID", "Certificate"]

// Copy array
const servicesCopy = [...services1];

// Add items while spreading
const moreServices = ["Business License", ...services1, "Health Certificate"];
```

### Object Spread:
```javascript
const resident = {
    name: "Juan Dela Cruz",
    age: 65
};

// Add properties
const residentWithAddress = {
    ...resident,
    address: "123 Main St",
    barangay: "San Jose"
};

// Override properties
const residentWithNewAge = {
    ...resident,
    age: 66  // Overrides age: 65
};

// Combine objects
const personalInfo = { name: "Juan", age: 65 };
const contactInfo = { phone: "0912-345-6789", email: "juan@email.com" };
const fullInfo = { ...personalInfo, ...contactInfo };
```

### Practical Example:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resident Database</title>
</head>
<body>
    <h1>Add New Resident</h1>
    <form id="residentForm">
        <input type="text" id="name" placeholder="Name" required><br>
        <input type="number" id="age" placeholder="Age" required><br>
        <input type="text" id="address" placeholder="Address" required><br>
        <button type="submit">Add Resident</button>
    </form>
    
    <h2>Residents:</h2>
    <div id="residentList"></div>

    <script src="database.js"></script>
</body>
</html>
```

### JavaScript (database.js):
```javascript
let residents = [
    { id: 1, name: "Juan Dela Cruz", age: 65, address: "123 Main St" },
    { id: 2, name: "Maria Santos", age: 45, address: "456 Oak Ave" }
];

const displayResidents = () => {
    const html = residents.map(({ id, name, age, address }) => `
        <div style="padding: 10px; background: #f5f5f5; margin: 5px 0; border-radius: 5px;">
            ${id}. ${name} (${age}) - ${address}
        </div>
    `).join('');
    
    document.getElementById('residentList').innerHTML = html;
};

document.getElementById('residentForm').addEventListener('submit', (event) => {
    event.preventDefault();
    
    const name = document.getElementById('name').value;
    const age = parseInt(document.getElementById('age').value);
    const address = document.getElementById('address').value;
    
    // Create new resident with spread operator
    const newResident = {
        id: residents.length + 1,
        name,           // ES6 shorthand for name: name
        age,
        address
    };
    
    // Add to array using spread
    residents = [...residents, newResident];
    
    displayResidents();
    event.target.reset();
});

displayResidents();
```

---

## Activity 7: Complete Modern JavaScript Example

Let's combine arrow functions, destructuring, and spread operator in a real application.

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Clearance System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background: #f5f5f5;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        .form-section {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        input, select {
            width: 100%;
            padding: 8px;
            border: 2px solid #ddd;
            border-radius: 5px;
        }
        
        button {
            padding: 10px 20px;
            background: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        button:hover {
            background: #45a049;
        }
        
        .application-card {
            padding: 20px;
            background: #e8f5e9;
            border-radius: 8px;
            margin-bottom: 15px;
            border-left: 4px solid #4caf50;
        }
        
        .application-card h3 {
            margin-bottom: 10px;
            color: #2e7d32;
        }
        
        .application-card p {
            margin: 5px 0;
        }
        
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .stat-card {
            padding: 20px;
            background: #e3f2fd;
            border-radius: 8px;
            text-align: center;
        }
        
        .stat-card h3 {
            color: #1976d2;
            font-size: 2em;
            margin-bottom: 5px;
        }
        
        .stat-card p {
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏘️ Barangay Clearance Management System</h1>
        
        <div class="stats" id="stats"></div>
        
        <div class="form-section">
            <h2>New Application</h2>
            <form id="applicationForm">
                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" required>
                </div>
                
                <div class="form-group">
                    <label for="age">Age:</label>
                    <input type="number" id="age" min="1" required>
                </div>
                
                <div class="form-group">
                    <label for="clearanceType">Clearance Type:</label>
                    <select id="clearanceType" required>
                        <option value="">-- Select --</option>
                        <option value="Barangay Clearance">Barangay Clearance (₱50)</option>
                        <option value="Police Clearance">Police Clearance (₱100)</option>
                        <option value="Business Permit">Business Permit (₱150)</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="purpose">Purpose:</label>
                    <input type="text" id="purpose" required>
                </div>
                
                <button type="submit">Submit Application</button>
            </form>
        </div>
        
        <h2>Applications</h2>
        <div id="applicationList"></div>
    </div>

    <script src="modern.js"></script>
</body>
</html>
```

### JavaScript (modern.js):
```javascript
// Initial data
let applications = [
    {
        id: 1,
        name: "Juan Dela Cruz",
        age: 65,
        clearanceType: "Barangay Clearance",
        purpose: "Employment",
        baseFee: 50,
        date: "2024-01-15"
    },
    {
        id: 2,
        name: "Maria Santos",
        age: 45,
        clearanceType: "Police Clearance",
        purpose: "Loan Application",
        baseFee: 100,
        date: "2024-01-16"
    }
];

// Fee mapping (using object)
const feeMap = {
    "Barangay Clearance": 50,
    "Police Clearance": 100,
    "Business Permit": 150
};

// Calculate fee with discount (arrow function + destructuring)
const calculateFee = ({ age, baseFee }) => 
    age >= 60 ? baseFee * 0.8 : baseFee;

// Display single application (arrow function + destructuring)
const displayApplication = ({ id, name, age, clearanceType, purpose, baseFee, date }) => {
    const totalFee = calculateFee({ age, baseFee });
    const discount = age >= 60 ? '(20% Senior Discount)' : '';
    
    return `
        <div class="application-card">
            <h3>Application #${id}</h3>
            <p><strong>Name:</strong> ${name}</p>
            <p><strong>Age:</strong> ${age} years old</p>
            <p><strong>Type:</strong> ${clearanceType}</p>
            <p><strong>Purpose:</strong> ${purpose}</p>
            <p><strong>Fee:</strong> ₱${totalFee} ${discount}</p>
            <p><strong>Date:</strong> ${date}</p>
        </div>
    `;
};

// Display all applications
const displayAllApplications = () => {
    const html = applications
        .map(app => displayApplication(app))
        .join('');
    
    document.getElementById('applicationList').innerHTML = html || '<p>No applications yet.</p>';
};

// Calculate statistics (using reduce with arrow functions)
const calculateStats = () => {
    const total = applications.length;
    
    const totalRevenue = applications.reduce((sum, app) => 
        sum + calculateFee(app), 0
    );
    
    const seniorCount = applications.filter(({ age }) => age >= 60).length;
    
    return { total, totalRevenue, seniorCount };
};

// Display statistics
const displayStats = () => {
    const { total, totalRevenue, seniorCount } = calculateStats();
    
    document.getElementById('stats').innerHTML = `
        <div class="stat-card">
            <h3>${total}</h3>
            <p>Total Applications</p>
        </div>
        <div class="stat-card">
            <h3>₱${totalRevenue}</h3>
            <p>Total Revenue</p>
        </div>
        <div class="stat-card">
            <h3>${seniorCount}</h3>
            <p>Senior Citizens</p>
        </div>
    `;
};

// Handle form submission (arrow function)
document.getElementById('applicationForm').addEventListener('submit', (event) => {
    event.preventDefault();
    
    // Get form values
    const name = document.getElementById('name').value.trim();
    const age = parseInt(document.getElementById('age').value);
    const clearanceType = document.getElementById('clearanceType').value;
    const purpose = document.getElementById('purpose').value.trim();
    
    // Create new application (object shorthand + spread)
    const newApplication = {
        id: applications.length + 1,
        name,
        age,
        clearanceType,
        purpose,
        baseFee: feeMap[clearanceType],
        date: new Date().toISOString().split('T')[0]
    };
    
    // Add to applications array (using spread operator)
    applications = [...applications, newApplication];
    
    // Update display
    displayAllApplications();
    displayStats();
    
    // Reset form
    event.target.reset();
    
    alert(`Application submitted for ${name}!`);
});

// Initial render
displayAllApplications();
displayStats();
```

**This example demonstrates:**
1. **Arrow functions** - Shorter, cleaner syntax
2. **Object destructuring** - Extract properties easily
3. **Spread operator** - Copy and add to arrays/objects
4. **ES6 shorthand** - `name` instead of `name: name`
5. **Template literals** - Easy string interpolation
6. **Array methods** - map, filter, reduce with arrow functions
7. **Modern best practices** - Clean, readable, maintainable code

---

## 📚 Answer Key: Modern JavaScript Syntax

### Arrow Function Conversion

**Traditional:**
```javascript
function greet(name) {
    return "Hello, " + name;
}
```

**Arrow (Long):**
```javascript
const greet = (name) => {
    return `Hello, ${name}`;
};
```

**Arrow (Short):**
```javascript
const greet = (name) => `Hello, ${name}`;
```

### Arrow Function Rules

| Parameters | Syntax | Example |
|------------|--------|---------|
| No parameters | `() =>` | `() => "Hello"` |
| One parameter | `x =>` or `(x) =>` | `x => x * 2` |
| Multiple | `(x, y) =>` | `(x, y) => x + y` |

| Body | Syntax | Return |
|------|--------|--------|
| Single expression | `=>` expression | Implicit return |
| Multiple statements | `=> { }` | Need `return` keyword |
| Object literal | `=> ({ })` | Wrap in parentheses |

### Destructuring Cheat Sheet

**Array Destructuring:**
```javascript
const [a, b] = [1, 2];                    // Basic
const [first, , third] = [1, 2, 3];       // Skip
const [head, ...tail] = [1, 2, 3, 4];     // Rest
const [x, y, z = 0] = [1, 2];             // Default
```

**Object Destructuring:**
```javascript
const { name, age } = person;                    // Basic
const { name: fullName } = person;               // Rename
const { name, age = 18 } = person;               // Default
const { address: { city } } = person;            // Nested
const { name, ...rest } = person;                // Rest
```

**Function Parameter Destructuring:**
```javascript
// Array
const sum = ([a, b]) => a + b;
sum([1, 2]);  // 3

// Object
const greet = ({ name, age }) => `${name} is ${age}`;
greet({ name: "Juan", age: 30 });  // "Juan is 30"
```

### Spread Operator

**Arrays:**
```javascript
const arr1 = [1, 2];
const arr2 = [3, 4];

[...arr1, ...arr2]           // [1, 2, 3, 4]
[0, ...arr1, 5]              // [0, 1, 2, 5]
const copy = [...arr1]       // Copy array
Math.max(...arr1)            // Spread as arguments
```

**Objects:**
```javascript
const obj1 = { a: 1, b: 2 };
const obj2 = { c: 3, d: 4 };

{ ...obj1, ...obj2 }         // { a: 1, b: 2, c: 3, d: 4 }
{ ...obj1, b: 10 }           // { a: 1, b: 10 } (override)
const copy = { ...obj1 }     // Copy object
```

### ES6 Object Shorthand

```javascript
const name = "Juan";
const age = 30;

// Old way
const person = {
    name: name,
    age: age
};

// ES6 shorthand
const person = { name, age };

// Method shorthand
const person = {
    // Old
    greet: function() {
        return "Hello";
    },
    // New
    greet() {
        return "Hello";
    }
};
```

### Common Patterns

**Map with Arrow Function:**
```javascript
// Old
const doubled = numbers.map(function(n) {
    return n * 2;
});

// New
const doubled = numbers.map(n => n * 2);
```

**Filter with Arrow Function:**
```javascript
// Old
const seniors = residents.filter(function(r) {
    return r.age >= 60;
});

// New
const seniors = residents.filter(r => r.age >= 60);
```

**Reduce with Arrow Function:**
```javascript
// Old
const sum = numbers.reduce(function(acc, n) {
    return acc + n;
}, 0);

// New
const sum = numbers.reduce((acc, n) => acc + n, 0);
```

### Common Mistakes

**❌ Wrong:**
```javascript
// Forgot parentheses for object literal
const create = () => { name: "Juan" };  // Returns undefined!

// Multiple lines without braces
const calc = (a, b) =>
    const sum = a + b;  // Syntax error
    return sum;
```

**✅ Correct:**
```javascript
// Wrap object literal in parentheses
const create = () => ({ name: "Juan" });

// Use braces for multiple lines
const calc = (a, b) => {
    const sum = a + b;
    return sum;
};
```

---

## 🎯 Key Takeaways

1. **Arrow functions** (`=>`) are shorter and cleaner than traditional functions
2. **Implicit return** works with single expressions (no `return` keyword needed)
3. **Destructuring** extracts values from arrays/objects into variables
4. **Spread operator** (`...`) expands or copies arrays/objects
5. **Object shorthand** (`{ name }` instead of `{ name: name }`)
6. Modern JavaScript is more **concise** and **readable**
7. These features are **standard** in modern codebases

---

## 🚀 Practice Challenge

Refactor this old code to use modern JavaScript:

```javascript
function calculateTotal(residents) {
    var total = 0;
    for (var i = 0; i < residents.length; i++) {
        var resident = residents[i];
        var fee = resident.fee;
        var age = resident.age;
        if (age >= 60) {
            fee = fee * 0.8;
        }
        total = total + fee;
    }
    return total;
}

var residents = [
    { name: "Juan", age: 65, fee: 50 },
    { name: "Maria", age: 45, fee: 50 }
];

var result = calculateTotal(residents);
```

**Refactor using:**
- Arrow functions
- Destructuring
- Array methods (reduce)
- const/let instead of var

---

## 🎯 Interactive Coding Challenges

> **Note for Reviewers:** Arrow functions and destructuring validation.

---

### Challenge 1: Convert to Arrow

**Scenario:** Convert traditional function to arrow function.

**Your Task:**
Rewrite function using arrow syntax with implicit return.

**Starter Code:**
```javascript
function double(n) {
    return n * 2;
}

// Rewrite as arrow function
const double = // Your code here
```

**Requirements:**
- ✅ Use arrow function syntax
- ✅ Use implicit return (no braces)

**Test Cases:**
```javascript
console.assert(double(5) === 10);
console.assert(double(0) === 0);
console.assert(double(-3) === -6);
```

**Validation Criteria:**
- ⚠️ Points: 10

---

### Challenge 2: Destructure Object

**Scenario:** Extract properties using destructuring.

**Your Task:**
Return formatted string using destructured properties.

**Starter Code:**
```javascript
function formatResident(resident) {
    // Destructure: name, age from resident
    // Return "Name: [name], Age: [age]"
    
}
```

**Requirements:**
- ✅ Use object destructuring
- ✅ Format string correctly

**Test Cases:**
```javascript
const result = formatResident({ name: "Juan", age: 25 });
console.assert(result === "Name: Juan, Age: 25");
```

**Validation Criteria:**
- ⚠️ Points: 15

---

### Challenge 3: Destructure Array

**Scenario:** Swap two values using destructuring.

**Your Task:**
Return array with swapped values.

**Starter Code:**
```javascript
function swapValues(a, b) {
    // Use array destructuring to swap
    // Return [b, a]
    
}
```

**Requirements:**
- ✅ Use array destructuring
- ✅ Return swapped values

**Test Cases:**
```javascript
const [x, y] = swapValues(5, 10);
console.assert(x === 10 && y === 5);
```

**Validation Criteria:**
- ⚠️ Points: 15

---

### Challenge 4: Arrow with Array Methods

**Scenario:** Filter and map using arrow functions.

**Your Task:**
Filter adults (age >= 18), return array of names.

**Starter Code:**
```javascript
function getAdultNames(residents) {
    // Use filter and map with arrow functions
    
}
```

**Requirements:**
- ✅ Use arrow functions
- ✅ Chain filter and map

**Test Cases:**
```javascript
const residents = [
    { name: "Juan", age: 25 },
    { name: "Pedro", age: 15 },
    { name: "Maria", age: 30 }
];
const names = getAdultNames(residents);
console.assert(JSON.stringify(names) === JSON.stringify(["Juan", "Maria"]));
```

**Validation Criteria:**
- ⚠️ Points: 20

---

### Challenge 5: Default Parameters

**Scenario:** Use default parameters and destructuring.

**Your Task:**
Calculate discount with default values.

**Starter Code:**
```javascript
function applyDiscount(price, discount = 0.1, { isSenior = false } = {}) {
    // If isSenior, add 10% more discount
    // Return final price
    
}
```

**Requirements:**
- ✅ Use default parameters
- ✅ Use destructuring with defaults

**Test Cases:**
```javascript
console.assert(applyDiscount(100) === 90);  // 10% default
console.assert(applyDiscount(100, 0.2) === 80);  // 20%
console.assert(applyDiscount(100, 0.1, { isSenior: true }) === 80);  // 10% + 10%
```

**Validation Criteria:**
- ⚠️ Points: 25

---

### 📊 Challenge Summary

| Challenge | Points | Difficulty | Concepts Tested |
|-----------|--------|------------|------------------|
| Convert Arrow | 10 | Easy | Arrow syntax |
| Destructure Object | 15 | Easy | Object destructuring |
| Destructure Array | 15 | Easy | Array destructuring |
| Arrow with Arrays | 20 | Medium | Arrow + methods |
| Default Parameters | 25 | Hard | Defaults + destructuring |
| **Total** | **85** | - | - |

---

## 💡 Tips for Success

**Modern JavaScript Syntax:**
- Arrow functions: `(param) => result`
- Implicit return: No braces for single expression
- Object destructuring: `const { name, age } = obj`
- Array destructuring: `const [first, second] = arr`

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Interactive Challenge Solutions

### Challenge 1: Convert to Arrow
```javascript
const double = (n) => n * 2;

// Even shorter (single parameter doesn't need parentheses)
const double = n => n * 2;
```

---

### Challenge 2: Destructure Object
```javascript
function formatResident(resident) {
    const { name, age } = resident;
    return `Name: ${name}, Age: ${age}`;
}

// Destructure in parameters
function formatResident({ name, age }) {
    return `Name: ${name}, Age: ${age}`;
}
```

---

### Challenge 3: Destructure Array
```javascript
function swapValues(a, b) {
    return [b, a];
}

// Using destructuring inside function
function swapValues(a, b) {
    [a, b] = [b, a];
    return [a, b];
}
```

---

### Challenge 4: Arrow with Array Methods
```javascript
function getAdultNames(residents) {
    return residents
        .filter(resident => resident.age >= 18)
        .map(resident => resident.name);
}

// With destructuring
function getAdultNames(residents) {
    return residents
        .filter(({ age }) => age >= 18)
        .map(({ name }) => name);
}
```

---

### Challenge 5: Default Parameters
```javascript
function applyDiscount(price, discount = 0.1, { isSenior = false } = {}) {
    let totalDiscount = discount;
    if (isSenior) {
        totalDiscount += 0.1;
    }
    return price * (1 - totalDiscount);
}

// Shorter version
function applyDiscount(price, discount = 0.1, { isSenior = false } = {}) {
    const totalDiscount = discount + (isSenior ? 0.1 : 0);
    return price * (1 - totalDiscount);
}
```

---

</details>

Good luck! 🎉
