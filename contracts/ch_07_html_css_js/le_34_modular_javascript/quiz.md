# Quiz: Modular JavaScript

---

## Quiz 1

**1. What's the correct way to use ES6 modules in HTML?**

a) `<script src="main.js"></script>`  
b) `<script type="module" src="main.js"></script>`  
c) `<script module src="main.js"></script>`  
d) `<script import src="main.js"></script>`

---

**2. How do you export multiple functions from a module?**

a) `export {func1, func2, func3};`  
b) `export default {func1, func2, func3};`  
c) `module.exports = {func1, func2, func3};`  
d) Both a and b

---

**3. What's the difference between named and default exports?**

a) No difference  
b) Named can have multiple per file, default only one  
c) Default is faster  
d) Named exports are deprecated

---

**4. How do you import everything from a module?**

a) `import all from './module.js';`  
b) `import {*} from './module.js';`  
c) `import * as name from './module.js';`  
d) `import everything from './module.js';`

---

**5. Why use modules instead of one big JavaScript file?**

a) Better organization  
b) Easier to maintain  
c) Reusable across projects  
d) All of the above

---

## Quiz 2

**6. What does this do? `import {add as sum} from './math.js';`**

a) Creates an error  
b) Imports add and renames it to sum  
c) Imports both add and sum  
d) Exports sum

---

**7. Can you have both default and named exports in the same file?**

a) No, only one type allowed  
b) Yes, default + named exports allowed  
c) Only in Node.js  
d) Only named exports allowed

---

**8. How many default exports can a module have?**

a) Unlimited  
b) Only one  
c) Up to five  
d) Depends on file size

---

**9. What's required to run ES6 modules locally?**

a) Nothing special  
b) HTTP server (localhost)  
c) Node.js installation  
d) Internet connection

---

**10. What's the best module organization?**

a) One giant file with everything  
b) Separate modules by functionality  
c) Random splitting  
d) Alphabetical order

---

## Answers

1. **b** - `<script type="module" src="main.js"></script>`  
2. **a** - `export {func1, func2, func3};`  
3. **b** - Named can have multiple per file, default only one  
4. **c** - `import * as name from './module.js';`  
5. **d** - All of the above  
6. **b** - Imports add and renames it to sum  
7. **b** - Yes, default + named exports allowed  
8. **b** - Only one  
9. **b** - HTTP server (localhost)  
10. **b** - Separate modules by functionality

---

## Detailed Explanations

### Question 1: Module Script Tag

**Correct Answer: b) `<script type="module" src="main.js"></script>`**

ES6 modules require `type="module"` attribute:

```html
<!-- Correct - ES6 modules -->
<script type="module" src="main.js"></script>

<!-- Wrong - treats as regular script -->
<script src="main.js"></script>
```

**Barangay example:**
```html
<!DOCTYPE html>
<html>
<head>
    <title>Barangay System</title>
</head>
<body>
    <h1>Service Manager</h1>
    <div id="output"></div>
    
    <!-- Module support -->
    <script type="module" src="js/main.js"></script>
</body>
</html>
```

---

### Question 2: Multiple Exports

**Correct Answer: a) `export {func1, func2, func3};`**

**Named exports allow multiple exports per file:**

```javascript
// services.js
export const getServices = () => { /* ... */ };
export const addService = (service) => { /* ... */ };
export const removeService = (id) => { /* ... */ };

// Or export all at once
const getServices = () => { /* ... */ };
const addService = (service) => { /* ... */ };
const removeService = (id) => { /* ... */ };

export {getServices, addService, removeService};
```

**Barangay example:**
```javascript
// fees.js
export const calculateFee = (base, isSenior) => {
    return isSenior ? base * 0.8 : base;
};

export const calculateTotal = (items) => {
    return items.reduce((sum, item) => sum + item, 0);
};

export const formatCurrency = (amount) => {
    return '₱' + amount.toFixed(2);
};

// Use in main.js
import {calculateFee, formatCurrency} from './fees.js';
```

---

### Question 3: Named vs Default Exports

**Correct Answer: b) Named can have multiple per file, default only one**

```javascript
// Named exports (multiple)
export const func1 = () => {};
export const func2 = () => {};
export const func3 = () => {};

// Default export (only one)
export default class Service {}
```

**Barangay example:**
```javascript
// calculator.js - default export
const FeeCalculator = {
    standard: (fee) => fee,
    senior: (fee) => fee * 0.8,
    pwd: (fee) => fee * 0.9
};

export default FeeCalculator;

// utils.js - named exports
export const formatDate = (date) => { /* ... */ };
export const generateId = () => 'APP-' + Date.now();
export const capitalize = (str) => str.toUpperCase();

// Import both
import FeeCalculator from './calculator.js';  // default
import {formatDate, generateId} from './utils.js';  // named
```

---

### Question 4: Import Everything

**Correct Answer: c) `import * as name from './module.js';`**

```javascript
// math.js
export const add = (a, b) => a + b;
export const subtract = (a, b) => a - b;
export const multiply = (a, b) => a * b;

// main.js - import everything
import * as math from './math.js';

console.log(math.add(5, 3));      // 8
console.log(math.multiply(4, 2)); // 8
```

**Barangay example:**
```javascript
// services.js
export const clearance = {name: 'Clearance', fee: 50};
export const id = {name: 'ID', fee: 30};
export const certificate = {name: 'Certificate', fee: 40};

// main.js
import * as services from './services.js';

console.log(services.clearance.name); // Clearance
console.log(services.id.fee);         // 30
```

---

### Question 5: Why Use Modules?

**Correct Answer: d) All of the above**

**Benefits:**
1. **Better organization** - logical file structure
2. **Easier to maintain** - find and fix code quickly
3. **Reusable** - use same code in multiple projects
4. **No global conflicts** - each module has own scope
5. **Easier testing** - test modules individually
6. **Better collaboration** - team members work on separate files

**Barangay example structure:**
```
barangay-system/
├── js/
│   ├── main.js          (main logic)
│   ├── services.js      (service data)
│   ├── fees.js          (calculations)
│   ├── display.js       (UI updates)
│   ├── validation.js    (form validation)
│   └── utils.js         (helper functions)
```

Each module has one responsibility = easier to maintain!

---

### Question 6: Renaming Imports

**Correct Answer: b) Imports add and renames it to sum**

```javascript
// math.js
export const add = (a, b) => a + b;

// main.js
import {add as sum} from './math.js';

console.log(sum(5, 3)); // 8
// 'add' not available, only 'sum'
```

**Why rename?**
- Avoid naming conflicts
- More descriptive names
- Consistency with codebase

**Barangay example:**
```javascript
// fees.js
export const calculate = (fee) => fee;

// services.js
export const calculate = (service) => service;

// main.js - avoid conflict
import {calculate as calculateFee} from './fees.js';
import {calculate as calculateService} from './services.js';

let fee = calculateFee(50);
let service = calculateService({name: 'Clearance'});
```

---

### Question 7: Mixed Exports

**Correct Answer: b) Yes, default + named exports allowed**

```javascript
// module.js
const MainClass = class { /* ... */ };

const helper1 = () => {};
const helper2 = () => {};

export default MainClass;
export {helper1, helper2};

// usage.js
import MainClass, {helper1, helper2} from './module.js';
```

**Barangay example:**
```javascript
// BarangayService.js
class BarangayService {
    constructor(name) {
        this.name = name;
    }
}

// Helper functions
export const formatService = (service) => {
    return service.name.toUpperCase();
};

export const validateService = (service) => {
    return service.name && service.fee > 0;
};

// Default export
export default BarangayService;

// main.js
import BarangayService, {formatService, validateService} from './BarangayService.js';

let service = new BarangayService('Clearance');
console.log(formatService(service));
```

---

### Question 8: Default Export Limit

**Correct Answer: b) Only one**

```javascript
// WRONG - multiple defaults
export default const func1 = () => {}; // Error!
export default const func2 = () => {}; // Error!

// CORRECT - one default
export default const func1 = () => {};

// Or
const func1 = () => {};
export default func1;
```

**Barangay example:**
```javascript
// Good - one default
export default class ApplicationManager {
    add() {}
    remove() {}
    update() {}
}

// Or one object as default
const api = {
    getServices: () => {},
    getResidents: () => {},
    getApplications: () => {}
};

export default api;
```

---

### Question 9: Running Modules Locally

**Correct Answer: b) HTTP server (localhost)**

Browsers block ES6 modules from `file://` protocol for security.

**Solutions:**

```bash
# Option 1: Python HTTP Server
python -m http.server 8000
# Visit http://localhost:8000

# Option 2: Node.js http-server
npx http-server

# Option 3: VS Code Live Server extension
# Right-click HTML → "Open with Live Server"
```

**Why needed?**
- Modules use CORS (Cross-Origin Resource Sharing)
- `file://` protocol doesn't support CORS
- HTTP server provides proper environment

---

### Question 10: Module Organization

**Correct Answer: b) Separate modules by functionality**

**Good organization:**
```javascript
// By feature/responsibility
services.js      // Service data
fees.js          // Fee calculations
display.js       // UI rendering
validation.js    // Input validation
api.js           // Server communication
constants.js     // Configuration values
```

**Bad organization:**
```javascript
// Random splitting
file1.js  // Mixed functions
file2.js  // Random utilities
helpers.js  // Everything else
```

**Barangay example - organized:**
```
barangay-system/
├── data/
│   ├── services.js       (service definitions)
│   └── residents.js      (resident data)
├── logic/
│   ├── fees.js           (fee calculations)
│   ├── validation.js     (input validation)
│   └── search.js         (search/filter logic)
├── ui/
│   ├── display.js        (rendering functions)
│   ├── forms.js          (form handling)
│   └── modals.js         (popup dialogs)
└── main.js               (application entry)
```

Each module has **one clear responsibility** = easy to find, test, and maintain!

---
