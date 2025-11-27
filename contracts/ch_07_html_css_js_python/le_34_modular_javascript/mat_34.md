# Lesson 34: Modular JavaScript - Organizing Code with Import/Export

---

## Breaking Code into Modules

"Kuya Miguel, our JavaScript files are getting long and messy. How do real developers organize code?" Tian asked.

Rhea Joy nodded. "Yeah, like having separate files for different features—one for forms, one for calculations, one for display?"

Kuya Miguel smiled. "That's **modular JavaScript** using `import` and `export`. Split your code into logical modules—easier to maintain, test, and reuse. Let's learn it!"

---

## Why Modules?

**Problems with one big file:**
- Hard to find code
- Name conflicts
- Difficult to test
- Can't reuse across projects
- Hard to collaborate

**Solution: ES6 Modules**
- Split code into separate files
- Each file is a module
- Explicit imports/exports
- No global namespace pollution

---

## Export Syntax

**Named exports (multiple per file):**

```javascript
// math.js
export const add = (a, b) => a + b;
export const subtract = (a, b) => a - b;
export const multiply = (a, b) => a * b;

// or export all at once
const add = (a, b) => a + b;
const subtract = (a, b) => a - b;
const multiply = (a, b) => a * b;

export {add, subtract, multiply};
```

**Default export (one per file):**

```javascript
// calculator.js
const calculator = {
    add: (a, b) => a + b,
    subtract: (a, b) => a - b
};

export default calculator;
```

---

## Import Syntax

**Import named exports:**

```javascript
// main.js
import {add, subtract} from './math.js';

console.log(add(5, 3));      // 8
console.log(subtract(10, 4)); // 6
```

**Import default export:**

```javascript
// main.js
import calculator from './calculator.js';

console.log(calculator.add(5, 3)); // 8
```

**Import everything:**

```javascript
import * as math from './math.js';

console.log(math.add(5, 3));      // 8
console.log(math.multiply(4, 2)); // 8
```

**Rename imports:**

```javascript
import {add as sum, subtract as diff} from './math.js';

console.log(sum(5, 3)); // 8
console.log(diff(10, 4)); // 6
```

---

## Barangay Example: Organized Modules

**Project structure:**
```
barangay-system/
├── index.html
├── js/
│   ├── main.js
│   ├── services.js
│   ├── fees.js
│   └── display.js
```

---

### services.js - Service Data

```javascript
// services.js
export const services = [
    {id: 1, name: 'Barangay Clearance', baseFee: 50, available: true},
    {id: 2, name: 'Barangay ID', baseFee: 30, available: true},
    {id: 3, name: 'Certificate of Residency', baseFee: 40, available: true},
    {id: 4, name: 'Business Permit', baseFee: 200, available: false}
];

export const getServiceById = (id) => {
    return services.find(service => service.id === id);
};

export const getAvailableServices = () => {
    return services.filter(service => service.available);
};
```

---

### fees.js - Fee Calculations

```javascript
// fees.js
export const calculateFee = (baseFee, isSenior, isPWD) => {
    let discount = 0;
    
    if (isSenior) discount += 0.20;  // 20% senior discount
    if (isPWD) discount += 0.10;     // 10% PWD discount
    
    let finalFee = baseFee * (1 - discount);
    return Math.max(finalFee, 0); // Never negative
};

export const calculateTotal = (items) => {
    return items.reduce((sum, item) => sum + item.fee, 0);
};

export const formatCurrency = (amount) => {
    return '₱' + amount.toFixed(2);
};
```

---

### display.js - UI Functions

```javascript
// display.js
import {formatCurrency} from './fees.js';

export const displayServices = (services, containerId) => {
    let container = document.querySelector(containerId);
    
    let html = services.map(service => `
        <div class="service-card">
            <h3>${service.name}</h3>
            <p>Fee: ${formatCurrency(service.baseFee)}</p>
            <p>Status: ${service.available ? '✅ Available' : '❌ Unavailable'}</p>
        </div>
    `).join('');
    
    container.innerHTML = html;
};

export const displayTotal = (total, elementId) => {
    let element = document.querySelector(elementId);
    element.textContent = `Total: ${formatCurrency(total)}`;
};

export const showMessage = (message, type = 'info') => {
    let messageDiv = document.createElement('div');
    messageDiv.className = `message message-${type}`;
    messageDiv.textContent = message;
    document.body.appendChild(messageDiv);
    
    setTimeout(() => messageDiv.remove(), 3000);
};
```

---

### main.js - Application Logic

```javascript
// main.js
import {services, getAvailableServices, getServiceById} from './services.js';
import {calculateFee, calculateTotal, formatCurrency} from './fees.js';
import {displayServices, displayTotal, showMessage} from './display.js';

// Display available services on load
document.addEventListener('DOMContentLoaded', () => {
    let availableServices = getAvailableServices();
    displayServices(availableServices, '#serviceList');
});

// Handle service request
document.querySelector('#requestBtn').addEventListener('click', () => {
    let serviceId = parseInt(document.querySelector('#serviceSelect').value);
    let isSenior = document.querySelector('#seniorCheck').checked;
    let isPWD = document.querySelector('#pwdCheck').checked;
    
    let service = getServiceById(serviceId);
    
    if (!service) {
        showMessage('Service not found!', 'error');
        return;
    }
    
    if (!service.available) {
        showMessage('Service currently unavailable!', 'warning');
        return;
    }
    
    let finalFee = calculateFee(service.baseFee, isSenior, isPWD);
    
    showMessage(`Fee for ${service.name}: ${formatCurrency(finalFee)}`, 'success');
    displayTotal(finalFee, '#totalDisplay');
});
```

---

### index.html - Setup

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Modular Barangay System</title>
    <style>
        .service-card {
            padding: 15px;
            margin: 10px 0;
            background: #f0f0f0;
            border-radius: 5px;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .message-success { background: #d4edda; color: #155724; }
        .message-error { background: #f8d7da; color: #721c24; }
        .message-warning { background: #fff3cd; color: #856404; }
    </style>
</head>
<body>
    <h1>Barangay Service Request</h1>
    
    <div id="serviceList"></div>
    
    <br>
    
    <select id="serviceSelect">
        <option value="1">Barangay Clearance</option>
        <option value="2">Barangay ID</option>
        <option value="3">Certificate of Residency</option>
        <option value="4">Business Permit</option>
    </select>
    
    <br><br>
    
    <label>
        <input type="checkbox" id="seniorCheck">
        Senior Citizen (20% discount)
    </label>
    
    <br>
    
    <label>
        <input type="checkbox" id="pwdCheck">
        PWD (10% discount)
    </label>
    
    <br><br>
    
    <button id="requestBtn">Calculate Fee</button>
    
    <br><br>
    
    <h2 id="totalDisplay">Total: ₱0.00</h2>
    
    <!-- IMPORTANT: Add type="module" -->
    <script type="module" src="js/main.js"></script>
</body>
</html>
```

**Critical:** Add `type="module"` to script tag!

---

## Module Best Practices

### 1. One responsibility per module
```javascript
// Good
// fees.js - only fee calculations
// display.js - only UI updates
// services.js - only service data

// Bad
// utils.js - everything mixed together
```

### 2. Clear naming
```javascript
// Good
import {calculateFee} from './fees.js';
import {displayServices} from './display.js';

// Bad
import {calc} from './utils.js';
import {show} from './helpers.js';
```

### 3. Keep modules small and focused
```javascript
// Good - specific modules
import {validateName, validateAge} from './validation.js';

// Bad - huge module
import {validate} from './everything.js';
```

### 4. Use default export for main functionality
```javascript
// api.js
export default class BarangayAPI {
    // Main class
}

export const formatData = () => { /* helper */ };
```

---

## Common Module Patterns

### 1. Constants Module
```javascript
// constants.js
export const API_URL = 'https://api.barangay.gov.ph';
export const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
export const ALLOWED_TYPES = ['image/jpeg', 'image/png'];

export const SERVICES = {
    CLEARANCE: 1,
    ID: 2,
    CERTIFICATE: 3
};
```

### 2. Utilities Module
```javascript
// utils.js
export const capitalize = (str) => {
    return str.charAt(0).toUpperCase() + str.slice(1);
};

export const formatDate = (date) => {
    return date.toLocaleDateString('en-PH');
};

export const generateId = () => {
    return 'APP-' + Date.now();
};
```

### 3. Config Module
```javascript
// config.js
const config = {
    barangayName: 'San Antonio',
    officeHours: '8:00 AM - 5:00 PM',
    contactNumber: '(02) 123-4567',
    address: 'Main Street, San Antonio'
};

export default config;
```

---

## Running Modules Locally

**Problem:** Browsers block modules from `file://` protocol

**Solutions:**

### 1. Use Live Server (VS Code extension)
- Install "Live Server" extension
- Right-click HTML file → "Open with Live Server"

### 2. Use Python HTTP Server
```bash
python -m http.server 8000
```
Then visit `http://localhost:8000`

### 3. Use Node.js http-server
```bash
npx http-server
```

---

## Summary

**Export:**
```javascript
export const func = () => {};          // Named export
export default obj;                     // Default export
```

**Import:**
```javascript
import {func} from './module.js';       // Named import
import obj from './module.js';          // Default import
import * as name from './module.js';    // Import all
```

**HTML:**
```html
<script type="module" src="main.js"></script>
```

**Benefits:**
- Organized code
- Reusable functions
- Easy testing
- No global conflicts
- Better collaboration

---

## What's Next?

In the next lesson, you'll learn **JSON, APIs, and Fetch**—how to get data from servers and external sources!

---

---

## Closing Story

Tian split the barangay portal code into modules: `auth.js`, `data.js`, `ui.js`. Each file had a specific responsibility. The codebase was organized. Maintainable. Scalable.

"Modules are how real applications are built," Kuya Miguel emphasized. "Separation of concerns. Single responsibility. Clean architecture."

Tian imported modules using `import/export` syntax. The code was modular now. Team-ready. Enterprise-grade.

_Next up: Working with JSON APIsfetching real data!_