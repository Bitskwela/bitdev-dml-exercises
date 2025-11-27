# ES6 Modern Syntax Activity

## Initial Code

```js
// Task 1: Convert to Arrow Functions
function calculateArea(width, height) {
  // Add your code here
}

function greetUser(name) {
  // Add your code here
}

// Task 2: Use Object Destructuring
function getUserInfo(user) {
  // Add your code here
}

// Task 3: Use Array Destructuring and Template Literals
function formatScores(scores) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Arrow Functions, Object Destructuring, Array Destructuring, Template Literals

---

### Task 1: Convert to Arrow Functions

Convert the traditional functions to arrow functions. `calculateArea` should take `width` and `height` and return the area. `greetUser` should take `name` and return a greeting using template literals.

```js
const calculateArea = (width, height) => width * height;

const greetUser = (name) => `Hello, ${name}!`;
```

---

### Task 2: Use Object Destructuring

Create a function that receives a `user` object with `name`, `age`, and `course` properties. Use object destructuring to extract these values and return a formatted string: "[name] is [age] years old and studying [course]."

```js
const getUserInfo = (user) => {
  const { name, age, course } = user;
  return `${name} is ${age} years old and studying ${course}.`;
};
```

---

### Task 3: Use Array Destructuring and Template Literals

Create a function that receives an array of three scores (math, english, science). Use array destructuring to extract the values and return a formatted report using template literals.

```js
const formatScores = (scores) => {
  const [math, english, science] = scores;
  return `Math: ${math}, English: ${english}, Science: ${science}`;
};
```

---

## Breakdown of the Activity

**Variables Defined:**

- `width`: A numeric parameter representing the width of a rectangle. Used in the arrow function to calculate area.

- `height`: A numeric parameter representing the height of a rectangle. Multiplied with width to get the area.

- `name`: A string parameter representing a person's name. Used in template literals for personalized greetings.

- `user`: An object parameter containing `name`, `age`, and `course` properties. Destructured to extract individual values.

- `scores`: An array parameter containing three numeric scores. Destructured into individual variables for math, english, and science.

**Key Concepts:**

- Arrow Functions:
  A concise syntax for writing functions. Single expression functions can omit braces and `return`. Example: `(a, b) => a + b` is equivalent to `function(a, b) { return a + b; }`.

- Implicit Return:
  Arrow functions without braces automatically return the expression. With braces, you must use an explicit `return` statement.

- Object Destructuring:
  Extract properties from objects into variables. Syntax: `const { prop1, prop2 } = object;`. Variable names must match property names (or use aliasing).

- Array Destructuring:
  Extract elements from arrays by position. Syntax: `const [first, second, third] = array;`. Variables are assigned based on array index order.

- Template Literals:
  Strings using backticks that allow embedded expressions with `${expression}`. Support multi-line strings and make string building cleaner than concatenation.

**Key Functions:**

- `calculateArea(width, height)`:
  Demonstrates a concise arrow function with implicit return. Shows how simple calculations can be written in one line.

- `greetUser(name)`:
  Combines arrow functions with template literals for clean, readable string creation.

- `getUserInfo(user)`:
  Shows object destructuring inside a function to extract multiple properties at once, then uses them in a template literal.

- `formatScores(scores)`:
  Demonstrates array destructuring to assign array elements to named variables, making the code more readable and self-documenting.
