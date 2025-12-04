# Activity 1: Modular JavaScript

In this activity, you'll learn how to organize your JavaScript code into **modules** - separate files that can be imported and reused. Modular code is cleaner, more maintainable, and easier to test.

---

## Activity 1: Understanding Modules

Modules let you split your code into separate files, each with a specific purpose.

### Why Use Modules?

**Without Modules (All in One File):**
```javascript
// script.js - Everything in one file (messy!)
const residents = [];

function addResident(name, age) {
    residents.push({ name, age });
}

function calculateFee(age, baseFee) {
    return age >= 60 ? baseFee * 0.8 : baseFee;
}

function displayResidents() {
    // Display code...
}

function validateAge(age) {
    return age > 0 && age < 150;
}

// More functions...
// Gets very long and hard to manage!
```

**With Modules (Organized):**
```javascript
// residents.js - Resident management
// fees.js - Fee calculations
// validators.js - Input validation
// ui.js - Display functions
// main.js - Brings everything together
```

---

## Activity 2: Creating Your First Module (Export and Import)

Let's create a simple calculator module.

### calculator.js (Module):
```javascript
// Export individual functions
export function add(a, b) {
    return a + b;
}

export function subtract(a, b) {
    return a - b;
}

export function multiply(a, b) {
    return a * b;
}

export function divide(a, b) {
    if (b === 0) {
        throw new Error("Cannot divide by zero");
    }
    return a / b;
}

// Export a constant
export const PI = 3.14159;
```

### main.js (Using the Module):
```javascript
// Import specific functions
import { add, subtract, multiply, divide, PI } from './calculator.js';

console.log(add(5, 3));        // 8
console.log(subtract(10, 4));  // 6
console.log(multiply(3, 7));   // 21
console.log(divide(20, 5));    // 4
console.log(PI);               // 3.14159
```

### HTML (Must Use type="module"):
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Modular JavaScript</title>
</head>
<body>
    <h1>Calculator</h1>
    <p id="result"></p>

    <!-- Important: type="module" is required! -->
    <script type="module" src="main.js"></script>
</body>
</html>
```

**Key Points:**
- Use `export` keyword to make functions/variables available
- Use `import` keyword to use them in other files
- HTML script tag needs `type="module"`
- File paths must include `.js` extension

---

## Activity 3: Default Exports

Each module can have one **default export** - the main thing it exports.

### feeCalculator.js (Default Export):
```javascript
// Default export (one per file)
export default function calculateClearanceFee(age, baseFee) {
    const discount = age >= 60 ? 0.2 : 0;
    return baseFee - (baseFee * discount);
}

// Can also have named exports
export function getSeniorDiscount(baseFee) {
    return baseFee * 0.2;
}

export const BASE_FEES = {
    clearance: 50,
    permit: 100,
    id: 30
};
```

### main.js (Importing Default Export):
```javascript
// Import default (can use any name)
import calculateFee from './feeCalculator.js';

// Import named exports with curly braces
import { getSeniorDiscount, BASE_FEES } from './feeCalculator.js';

// Or import both at once
import calculateFee, { getSeniorDiscount, BASE_FEES } from './feeCalculator.js';

console.log(calculateFee(65, 50));         // 40 (with senior discount)
console.log(getSeniorDiscount(50));        // 10
console.log(BASE_FEES.clearance);          // 50
```

**Named vs Default Exports:**

| Named Export | Default Export |
|--------------|----------------|
| `export function name() {}` | `export default function name() {}` |
| Import with exact name | Import with any name |
| Can have multiple per file | Only one per file |
| `import { name } from './file.js'` | `import name from './file.js'` |

---

## Activity 4: Practical Module Structure for Barangay System

Let's organize a complete barangay clearance system into modules.

### Project Structure:
```
project/
├── index.html
├── js/
│   ├── main.js
│   ├── modules/
│   │   ├── residents.js
│   │   ├── fees.js
│   │   ├── validators.js
│   │   └── ui.js
```

### js/modules/fees.js:
```javascript
// Fee calculation module
const BASE_FEES = {
    "Barangay Clearance": 50,
    "Police Clearance": 100,
    "Business Permit": 150
};

const SENIOR_DISCOUNT_RATE = 0.2;

export function calculateFee(clearanceType, age) {
    const baseFee = BASE_FEES[clearanceType] || 0;
    const discount = age >= 60 ? baseFee * SENIOR_DISCOUNT_RATE : 0;
    return baseFee - discount;
}

export function getBaseFee(clearanceType) {
    return BASE_FEES[clearanceType] || 0;
}

export function getDiscount(clearanceType, age) {
    if (age >= 60) {
        const baseFee = BASE_FEES[clearanceType] || 0;
        return baseFee * SENIOR_DISCOUNT_RATE;
    }
    return 0;
}

export { BASE_FEES, SENIOR_DISCOUNT_RATE };
```

### js/modules/validators.js:
```javascript
// Validation functions module
export function validateName(name) {
    if (!name || name.trim() === '') {
        return { valid: false, message: "Name is required" };
    }
    if (name.length < 2) {
        return { valid: false, message: "Name must be at least 2 characters" };
    }
    return { valid: true };
}

export function validateAge(age) {
    const ageNum = parseInt(age);
    if (isNaN(ageNum)) {
        return { valid: false, message: "Age must be a number" };
    }
    if (ageNum < 18) {
        return { valid: false, message: "Must be 18 years or older" };
    }
    if (ageNum > 150) {
        return { valid: false, message: "Invalid age" };
    }
    return { valid: true };
}

export function validateClearanceType(type) {
    const validTypes = ["Barangay Clearance", "Police Clearance", "Business Permit"];
    if (!validTypes.includes(type)) {
        return { valid: false, message: "Invalid clearance type" };
    }
    return { valid: true };
}

export function validateForm(name, age, clearanceType) {
    const nameCheck = validateName(name);
    if (!nameCheck.valid) return nameCheck;
    
    const ageCheck = validateAge(age);
    if (!ageCheck.valid) return ageCheck;
    
    const typeCheck = validateClearanceType(clearanceType);
    if (!typeCheck.valid) return typeCheck;
    
    return { valid: true };
}
```

### js/modules/residents.js:
```javascript
// Resident data management module
import { calculateFee } from './fees.js';

let residents = [];
let nextId = 1;

export function addResident(name, age, clearanceType, purpose) {
    const resident = {
        id: nextId++,
        name,
        age: parseInt(age),
        clearanceType,
        purpose,
        fee: calculateFee(clearanceType, age),
        date: new Date().toISOString().split('T')[0]
    };
    
    residents.push(resident);
    return resident;
}

export function getAllResidents() {
    return [...residents]; // Return a copy
}

export function getResidentById(id) {
    return residents.find(r => r.id === id);
}

export function deleteResident(id) {
    const index = residents.findIndex(r => r.id === id);
    if (index !== -1) {
        residents.splice(index, 1);
        return true;
    }
    return false;
}

export function getTotalRevenue() {
    return residents.reduce((sum, r) => sum + r.fee, 0);
}

export function getSeniorCount() {
    return residents.filter(r => r.age >= 60).length;
}

export function clearAllResidents() {
    residents = [];
    nextId = 1;
}
```

### js/modules/ui.js:
```javascript
// UI/Display functions module
export function displayResident(resident) {
    const discount = resident.age >= 60 ? '(Senior Discount Applied)' : '';
    
    return `
        <div class="resident-card" data-id="${resident.id}">
            <h3>${resident.name}</h3>
            <p><strong>Age:</strong> ${resident.age} years old</p>
            <p><strong>Type:</strong> ${resident.clearanceType}</p>
            <p><strong>Purpose:</strong> ${resident.purpose}</p>
            <p><strong>Fee:</strong> ₱${resident.fee} ${discount}</p>
            <p><strong>Date:</strong> ${resident.date}</p>
            <button class="delete-btn" data-id="${resident.id}">Delete</button>
        </div>
    `;
}

export function displayAllResidents(residents) {
    if (residents.length === 0) {
        return '<p>No residents yet.</p>';
    }
    return residents.map(r => displayResident(r)).join('');
}

export function displayStats(total, revenue, seniorCount) {
    return `
        <div class="stats-grid">
            <div class="stat-card">
                <h3>${total}</h3>
                <p>Total Applications</p>
            </div>
            <div class="stat-card">
                <h3>₱${revenue}</h3>
                <p>Total Revenue</p>
            </div>
            <div class="stat-card">
                <h3>${seniorCount}</h3>
                <p>Senior Citizens</p>
            </div>
        </div>
    `;
}

export function showError(message) {
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-message';
    errorDiv.textContent = message;
    document.body.appendChild(errorDiv);
    
    setTimeout(() => {
        errorDiv.remove();
    }, 3000);
}

export function showSuccess(message) {
    const successDiv = document.createElement('div');
    successDiv.className = 'success-message';
    successDiv.textContent = message;
    document.body.appendChild(successDiv);
    
    setTimeout(() => {
        successDiv.remove();
    }, 3000);
}
```

### js/main.js (Main Application):
```javascript
// Import all modules
import { calculateFee } from './modules/fees.js';
import { validateForm } from './modules/validators.js';
import { 
    addResident, 
    getAllResidents, 
    deleteResident, 
    getTotalRevenue, 
    getSeniorCount 
} from './modules/residents.js';
import { 
    displayAllResidents, 
    displayStats, 
    showError, 
    showSuccess 
} from './modules/ui.js';

// DOM elements
const form = document.getElementById('applicationForm');
const residentListDiv = document.getElementById('residentList');
const statsDiv = document.getElementById('stats');

// Update display
function updateDisplay() {
    const residents = getAllResidents();
    residentListDiv.innerHTML = displayAllResidents(residents);
    
    const total = residents.length;
    const revenue = getTotalRevenue();
    const seniorCount = getSeniorCount();
    statsDiv.innerHTML = displayStats(total, revenue, seniorCount);
    
    // Add delete button listeners
    document.querySelectorAll('.delete-btn').forEach(btn => {
        btn.addEventListener('click', handleDelete);
    });
}

// Handle form submission
function handleSubmit(event) {
    event.preventDefault();
    
    const name = document.getElementById('name').value.trim();
    const age = document.getElementById('age').value;
    const clearanceType = document.getElementById('clearanceType').value;
    const purpose = document.getElementById('purpose').value.trim();
    
    // Validate
    const validation = validateForm(name, age, clearanceType);
    if (!validation.valid) {
        showError(validation.message);
        return;
    }
    
    // Add resident
    const resident = addResident(name, age, clearanceType, purpose);
    
    // Update display
    updateDisplay();
    
    // Show success
    showSuccess(`Application for ${name} submitted successfully!`);
    
    // Reset form
    form.reset();
}

// Handle delete
function handleDelete(event) {
    const id = parseInt(event.target.dataset.id);
    if (confirm('Are you sure you want to delete this application?')) {
        deleteResident(id);
        updateDisplay();
        showSuccess('Application deleted');
    }
}

// Initialize
form.addEventListener('submit', handleSubmit);
updateDisplay();
```

### index.html:
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
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            padding: 20px;
            background: #e3f2fd;
            border-radius: 8px;
            text-align: center;
        }
        
        .stat-card h3 {
            font-size: 2em;
            color: #1976d2;
            margin-bottom: 5px;
        }
        
        .form-section {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        input, select, textarea {
            width: 100%;
            padding: 10px;
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
        
        .resident-card {
            padding: 20px;
            background: #e8f5e9;
            border-radius: 8px;
            margin-bottom: 15px;
            border-left: 4px solid #4caf50;
        }
        
        .resident-card h3 {
            color: #2e7d32;
            margin-bottom: 10px;
        }
        
        .resident-card p {
            margin: 5px 0;
        }
        
        .delete-btn {
            background: #f44336;
            margin-top: 10px;
        }
        
        .delete-btn:hover {
            background: #da190b;
        }
        
        .error-message,
        .success-message {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 5px;
            color: white;
            animation: slideIn 0.3s;
        }
        
        .error-message {
            background: #f44336;
        }
        
        .success-message {
            background: #4caf50;
        }
        
        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏘️ Barangay Clearance System</h1>
        
        <div id="stats"></div>
        
        <div class="form-section">
            <h2>New Application</h2>
            <form id="applicationForm">
                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" required>
                </div>
                
                <div class="form-group">
                    <label for="age">Age:</label>
                    <input type="number" id="age" min="18" required>
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
        <div id="residentList"></div>
    </div>

    <!-- Important: type="module" -->
    <script type="module" src="js/main.js"></script>
</body>
</html>
```

---

## Activity 5: Import Aliases

You can rename imports using `as` keyword.

```javascript
// Import with different name
import { calculateFee as computeFee } from './fees.js';
import { validateAge as checkAge } from './validators.js';

console.log(computeFee("Barangay Clearance", 65));
console.log(checkAge(25));

// Import everything from a module
import * as FeeModule from './fees.js';
import * as ValidationModule from './validators.js';

console.log(FeeModule.calculateFee("Barangay Clearance", 65));
console.log(ValidationModule.validateAge(25));
```

---

## Activity 6: Dynamic Imports

Sometimes you want to load modules only when needed (lazy loading).

```javascript
// Load module dynamically (returns a Promise)
async function loadCalculator() {
    const calculator = await import('./calculator.js');
    console.log(calculator.add(5, 3));
}

// Load module based on condition
if (userWantsFeeCalculation) {
    const feeModule = await import('./fees.js');
    const fee = feeModule.calculateFee("Barangay Clearance", 65);
    console.log(fee);
}

// Load module on button click
document.getElementById('calcBtn').addEventListener('click', async () => {
    const { calculateFee } = await import('./fees.js');
    const result = calculateFee("Barangay Clearance", 65);
    console.log(result);
});
```

---

## Activity 7: Best Practices for Modular JavaScript

### Good Module Structure:

```javascript
// ✅ Good: Single responsibility
// fees.js - Only fee-related functions
export function calculateFee(type, age) { }
export function getDiscount(age) { }
export const BASE_FEES = { };

// ✅ Good: Clear exports at the top or bottom
export { calculateFee, getDiscount, BASE_FEES };

// ✅ Good: One default export per file
export default function calculateClearanceFee() { }

// ✅ Good: Import only what you need
import { calculateFee, BASE_FEES } from './fees.js';

// ❌ Bad: Too many responsibilities in one module
// utils.js - Does everything (too general)
export function calculateFee() { }
export function validateForm() { }
export function displayUI() { }
export function makeAPICall() { }
```

### Module Naming Conventions:

```
✅ Good naming:
fees.js          - Fee calculations
validators.js    - Input validation
residents.js     - Resident data management
ui.js           - UI/display functions
api.js          - API calls
utils.js        - General utilities (keep small!)

❌ Bad naming:
stuff.js
helpers.js (too vague)
functions.js (too vague)
```

---

## 📚 Answer Key: Modules

### Export Syntax

| Type | Syntax | Import |
|------|--------|--------|
| Named export | `export function name() {}` | `import { name } from './file.js'` |
| Default export | `export default function() {}` | `import name from './file.js'` |
| Multiple named | `export { a, b, c }` | `import { a, b, c } from './file.js'` |
| Export list | `export { name1, name2 }` | `import { name1, name2 } from './file.js'` |

### Import Variations

```javascript
// Named imports
import { add, subtract } from './calc.js';

// Default import
import calculateFee from './fees.js';

// Both
import calculateFee, { BASE_FEES } from './fees.js';

// Rename
import { add as sum } from './calc.js';

// Everything
import * as Calculator from './calc.js';

// Dynamic
const module = await import('./calc.js');

// Side effects only (runs module code)
import './setup.js';
```

### Common Patterns

**Re-exporting (index.js pattern):**
```javascript
// modules/index.js
export { calculateFee, BASE_FEES } from './fees.js';
export { validateAge, validateName } from './validators.js';
export { addResident, getAllResidents } from './residents.js';

// Now you can import everything from one place
import { calculateFee, validateAge, addResident } from './modules/index.js';
```

**Namespace pattern:**
```javascript
// Import as namespace
import * as Fees from './fees.js';
import * as Validators from './validators.js';

// Use with prefix
Fees.calculateFee(50, 65);
Validators.validateAge(25);
```

### Module Benefits

✅ **Organization** - Code split into logical files
✅ **Reusability** - Import modules anywhere
✅ **Maintainability** - Easier to find and fix bugs
✅ **Testing** - Test individual modules
✅ **Collaboration** - Team members work on different modules
✅ **Encapsulation** - Private variables (not exported)
✅ **Performance** - Load only what you need

### Common Mistakes

**❌ Wrong:**
```javascript
// Forgot .js extension
import { add } from './calculator';  // Error!

// Forgot type="module" in HTML
<script src="main.js"></script>  // Modules won't work

// Circular dependencies
// a.js imports b.js, b.js imports a.js (causes issues)
```

**✅ Correct:**
```javascript
// Include .js extension
import { add } from './calculator.js';

// Use type="module"
<script type="module" src="main.js"></script>

// Avoid circular dependencies - refactor shared code into third module
```

---

## 🎯 Key Takeaways

1. **Modules** organize code into separate files
2. **`export`** makes functions/variables available to other files
3. **`import`** brings in code from other modules
4. **Default exports** for the main thing a module provides
5. **Named exports** for multiple exports from one file
6. **`type="module"`** required in HTML script tag
7. **Modular code** is cleaner, more maintainable, and testable

---

## 🚀 Practice Challenge

Refactor this monolithic code into modules:

```javascript
// Everything in one file (bad!)
const residents = [];

function validateName(name) {
    return name.length >= 2;
}

function validateAge(age) {
    return age >= 18;
}

function calculateFee(age) {
    return age >= 60 ? 40 : 50;
}

function addResident(name, age) {
    if (validateName(name) && validateAge(age)) {
        residents.push({ name, age, fee: calculateFee(age) });
    }
}

function displayResidents() {
    return residents.map(r => `${r.name} - ₱${r.fee}`).join('<br>');
}
```

**Create modules:**
1. `validators.js` - Validation functions
2. `fees.js` - Fee calculation
3. `residents.js` - Resident management
4. `ui.js` - Display functions
5. `main.js` - Bring everything together

Good luck! 🎉
