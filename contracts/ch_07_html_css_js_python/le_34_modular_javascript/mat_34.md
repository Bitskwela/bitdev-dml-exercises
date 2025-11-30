## Background Story

Tian scrolled through his `barangay-portal.js` file, and the scroll bar on the right side of VS Code told the story—this file had grown massive. What started as a simple 200-line project had ballooned to over 800 lines as he and Rhea Joy kept adding features: visitor management, service calculations, report generation, search functionality, data validation, UI updates, event handlers, utility functions, configuration objects.

Everything was in one giant file.

Finding specific functions meant scrolling for minutes or using Ctrl+F to search. When he wanted to reuse the fee calculation logic in another project, he had to copy-paste it along with all its dependencies—configuration objects, validation functions, utility helpers. When Rhea Joy wanted to work on the UI code while Tian worked on calculations, they couldn't work simultaneously without creating merge conflicts.

"This is getting ridiculous," Tian said during a video call with Rhea Joy, sharing his screen showing the endless scroll of code. "I spent ten minutes today looking for the `calculateDiscount()` function. It's buried somewhere in the middle of this massive file."

Rhea Joy had the same problem. "And when I want to test the UI code, I have to load all the calculation logic, validation logic, configuration data, utility functions—everything—even though I'm only working on the display components. It's slow and confusing."

They'd tried adding comments to section off different parts:

```javascript
// ============================================
// CONFIGURATION
// ============================================
const CONFIG = {...};

// ============================================
// DATA MODELS
// ============================================
class Visitor {...}

// ============================================
// CALCULATION FUNCTIONS
// ============================================
function calculateFee() {...}
function applyDiscount() {...}

// ============================================
// VALIDATION FUNCTIONS
// ============================================
function validateName() {...}
function validateAge() {...}

// ============================================
// UI UPDATE FUNCTIONS
// ============================================
function displayVisitors() {...}
function updateSummary() {...}

// ============================================
// EVENT HANDLERS
// ============================================
document.getElementById('addBtn').addEventListener(...);
```

But even with comments, it felt like a single drawer stuffed with completely different types of items—socks mixed with tools mixed with documents.

"There has to be a better way to organize this," Tian said. "Professional projects have multiple JavaScript files, right? Like, one file for calculations, one for UI, one for validation?"

Rhea Joy pulled up a GitHub repository for a popular open-source project. "Look at this structure:

```
src/
  ├── components/
  │   ├── UserCard.js
  │   ├── Dashboard.js
  │   └── Navigation.js
  ├── utils/
  │   ├── validators.js
  │   ├── formatters.js
  │   └── calculations.js
  ├── services/
  │   ├── api.js
  │   └── auth.js
  └── config/
      └── constants.js
```

They have dozens of small, focused files instead of one giant file. How do they connect them all together?"

Tian had wondered the same thing. He'd seen `import` statements at the top of many modern JavaScript files:

```javascript
import { calculateFee } from './utils/calculations.js';
import { validateVisitor } from './utils/validators.js';
import { displayList } from './components/VisitorList.js';
```

But he didn't fully understand the mechanism. "I know we can link multiple JavaScript files in HTML with multiple `<script>` tags, pero that causes problems with load order and global namespace pollution. This `import` thing seems cleaner."

They called Kuya Miguel, who immediately understood their pain point.

"Ah, you've hit the scaling problem every developer faces," Miguel said. "One file works great for 100-200 lines. But once you're beyond 500 lines, it becomes unmaintainable. You need **modular JavaScript**—splitting code into separate files (modules), each with a clear, single responsibility."

"How do modules work?" Tian asked.

Miguel shared his screen showing a simple example:

```javascript
// calculator.js
export const add = (a, b) => a + b;
export const subtract = (a, b) => a - b;

// main.js
import { add, subtract } from './calculator.js';
console.log(add(5, 3));  // 8
```

"Each file is a **module**. You use `export` to make functions, objects, or variables available to other files. You use `import` to bring them into the files that need them. Clean, explicit, no global namespace pollution."

Rhea Joy's eyes lit up with understanding. "So instead of having all our functions in one file where they're automatically globally available, we split them into logical modules and explicitly import only what each file needs?"

"Exactly!" Miguel confirmed. "This gives you several benefits:

1. **Organization**: Each file has one clear purpose
2. **Maintainability**: Easy to find and update code
3. **Reusability**: Import modules into any project
4. **Collaboration**: Multiple developers can work on different modules simultaneously
5. **Testing**: Test individual modules in isolation
6. **Performance**: Browsers can load and cache modules efficiently"

Tian was mentally restructuring his project. "So our 800-line file could become:

```
config.js          // Service types, fees, discount rates
models.js          // Visitor class definition
calculations.js    // calculateFee, applyDiscount, etc.
validators.js      // validateName, validateAge, etc.
ui.js              // Display functions
events.js          // Event handlers
main.js            // Main application logic
```

Each file small and focused?"

"Perfect structure!" Miguel said. "And the dependencies are explicit. Your `calculations.js` might import from `config.js`. Your `ui.js` might import from `calculations.js` and `validators.js`. Your `main.js` imports from everything and wires it together."

Rhea Joy saw the practical benefit immediately. "This way, if I need to fix a calculation bug, I go straight to `calculations.js`—maybe 50 lines total. I don't have to scroll through 800 lines of unrelated code."

"And if you want to reuse the calculation logic in another project," Miguel added, "you just copy `calculations.js` and `config.js`—two clean files with clear dependencies. No hunting through a monolithic file trying to extract the relevant parts."

Tian had one concern. "Does this work in browsers? I've seen `import` and `export` in Node.js tutorials, but in HTML?"

"Modern browsers fully support ES6 modules," Miguel explained. "You just need to mark your main script as a module:"

```html
<script type="module" src="main.js"></script>
```

Then all your imports work natively. No bundler needed for development. Though for production, you might use tools like Webpack or Vite to bundle modules for optimization."

Rhea Joy was already planning the refactoring. "So our workflow would be: create separate module files, add `export` to functions we want to share, use `import` to bring them into files that need them, and mark our main script as `type="module"` in HTML?"

"That's it!" Miguel confirmed. "Let me show you the refactoring process for your barangay portal."

He opened a demo project and live-coded the transformation:

**Before: barangay-portal.js (800 lines)**
```javascript
// Everything in one file
const CONFIG = {...};
function calculateFee() {...}
function validateName() {...}
function displayVisitors() {...}
document.getElementById('addBtn').addEventListener(...);
// ...700 more lines
```

**After: Modular structure**

```javascript
// config.js
export const CONFIG = {
    services: {...},
    discounts: {...}
};

// calculations.js
import { CONFIG } from './config.js';
export const calculateFee = (visitor) => {...};
export const applyDiscount = (fee, type) => {...};

// validators.js
export const validateName = (name) => {...};
export const validateAge = (age) => {...};

// ui.js
export const displayVisitors = (visitors) => {...};
export const updateSummary = (data) => {...};

// main.js
import { calculateFee } from './calculations.js';
import { validateName, validateAge } from './validators.js';
import { displayVisitors, updateSummary } from './ui.js';

// Main application logic
document.getElementById('addBtn').addEventListener('click', () => {
    // Uses imported functions
});
```

Tian watched in amazement as the 800-line monster transformed into seven focused, manageable files. "Each file is like 50-150 lines. So much easier to work with!"

Miguel showed more advanced patterns—default exports vs named exports, renaming imports, importing everything as a namespace. "But start simple: use named exports for most things. They're explicit and easier to refactor."

Rhea Joy had already opened VS Code and created a new `src/` folder with module files. "I'm going to refactor our entire portal into modules. This will make it so much easier to maintain and expand."

Tian was thinking about team collaboration. "If we split this into modules, you could work on `ui.js` while I work on `calculations.js`, and we wouldn't conflict. We're editing different files!"

"That's another huge benefit," Miguel said. "Modules enable team collaboration. In professional development, projects have dozens of developers working on hundreds of modules simultaneously. That's only possible because each module is independent with clear interfaces."

Miguel gave them a challenge: "Refactor your barangay portal into modules. Think carefully about which functions belong together. Aim for high cohesion within modules and low coupling between them. Each module should have one clear responsibility."

Tian pulled up their project, ready to split the monolith. "Time to organize this code properly. No more 800-line files."

Rhea Joy added, "And once we master modules, we can reuse them across multiple projects. Build a library of utilities we can import anywhere!"

Miguel smiled. "Now you're thinking like professional developers. Modular code is maintainable code. Welcome to the world of scalable JavaScript architecture. 🧩"

---

## Theory & Lecture Content

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