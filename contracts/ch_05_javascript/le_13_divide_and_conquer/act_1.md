# JavaScript Modules Activity

## Initial Code

```js
// utils/mathUtils.js
// Task 1: Create Named Exports
function add(a, b) {
  // Add your code here
}

function multiply(a, b) {
  // Add your code here
}

// TODO: Export both functions

// calculator.js
// Task 2: Import and Use Named Exports
// TODO: Import add and multiply from utils/mathUtils.js

function calculate(a, b) {
  // Add your code here
}

// config.js
// Task 3: Create Default Export
const config = {
  // Add your code here
};

// TODO: Export config as default
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Named Exports, Named Imports, Default Exports, Default Imports, ES6 Modules

---

### Task 1: Create Named Exports

Create a `mathUtils.js` file with two functions: `add(a, b)` that returns the sum and `multiply(a, b)` that returns the product. Export both as named exports.

```js
// utils/mathUtils.js
export function add(a, b) {
  return a + b;
}

export function multiply(a, b) {
  return a * b;
}
```

---

### Task 2: Import and Use Named Exports

In `calculator.js`, import the `add` and `multiply` functions from `mathUtils.js`. Create a `calculate(a, b)` function that returns an object with `sum` and `product` properties.

```js
// calculator.js
import { add, multiply } from "./utils/mathUtils.js";

export function calculate(a, b) {
  return {
    sum: add(a, b),
    product: multiply(a, b),
  };
}
```

---

### Task 3: Create Default Export

Create a `config.js` file that exports a configuration object as the default export. The object should have `appName`, `version`, and `environment` properties.

```js
// config.js
const config = {
  appName: "MyApp",
  version: "1.0.0",
  environment: "development",
};

export default config;
```

---

## Breakdown of the Activity

**Variables Defined:**

- `a` and `b`: Numeric parameters used in math operations. Passed to `add` and `multiply` functions.

- `config`: An object containing application configuration settings. Exported as the default export from its module.

- `sum`: The result of adding two numbers, stored as a property in the return object of `calculate`.

- `product`: The result of multiplying two numbers, stored as a property in the return object.

**Key Concepts:**

- Named Exports:
  Export multiple items from a module using `export` before each declaration. Example: `export function add() {}`. Importers must use the exact name in curly braces.

- Named Imports:
  Import specific items using curly braces. Example: `import { add, multiply } from "./module.js"`. Names must match the exported names.

- Default Exports:
  Each module can have one default export. Syntax: `export default value`. The importer can choose any name for the import.

- Default Imports:
  Import the default export without curly braces. Example: `import config from "./config.js"`. You can name it anything.

- Module Organization:
  Organize related functions into separate files (modules). This improves code maintainability, reusability, and makes it easier to test individual pieces.

- File Extensions:
  ES6 modules typically use `.js` extension. When using `type="module"` in HTML or Node.js with ES modules, include the extension in import paths.

**Key Functions:**

- `add(a, b)`:
  A simple named export that returns the sum of two numbers. Demonstrates basic named export syntax.

- `multiply(a, b)`:
  Another named export that returns the product. Shows how multiple functions can be exported from one module.

- `calculate(a, b)`:
  Demonstrates importing and using functions from another module. Returns a structured object with multiple computed values.

- Default Export Pattern:
  Shows how configuration objects are commonly shared across an application using default exports.
