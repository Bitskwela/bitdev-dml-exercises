## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+4.0+-+COVER.png)

Odessa is now knee-deep in her IT journey, facing new challenges and conquering them one by one. Her latest obstacle involves streamlining budget reports for her internship project. After spending countless hours staring at lines of repetitive code, she had an 'Aha!' moment. Why not condense these lengthy code blocks into neat little packages called functions?

![image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+4.1.png)

As she delves into the world of functions, Odessa realizes the power they hold. Functions not only reduce errors but also make her code cleaner and more organized. It's like decluttering her room, but instead of clothes and shoes, she's tidying up her code. With functions, Odessa transitions from merely writing code to designing logic.

In her pursuit to become a full-stack developer, Odessa knows that mastering functions is a crucial step forward. le_04_function_overload copyBy understanding function declarations, parameters, and return values, she equips herself with the tools to create efficient and elegant solutions. Let's join Odessa as she explores the concept of function overload, turning mundane code into logical masterpieces.

## Theory & Lecture Content

### What Are Functions?

**Think of functions like recipes** 📖🍳. Once you write down a recipe for adobo, you don't need to rewrite the steps every time you cook it. You just follow the same recipe! Functions work the same way—write the code once, use it many times.

In JavaScript, **functions are reusable blocks of code** designed to perform a specific task. They help in:

- **Reducing code duplication** (DRY principle: Don't Repeat Yourself)
- **Improving code readability** (organize logic into named chunks)
- **Making code easier to test and debug** (isolate functionality)
- **Enabling code reuse** (call the same function from multiple places)

### Why Functions Matter

**Without functions:**

```js
// Calculating sales tax three times
const item1Tax = 100 * 0.12;
const item2Tax = 250 * 0.12;
const item3Tax = 500 * 0.12;
console.log(item1Tax); // 12
console.log(item2Tax); // 30
console.log(item3Tax); // 60
```

**With functions:**

```js
function calculateTax(price) {
  return price * 0.12;
}

console.log(calculateTax(100)); // 12
console.log(calculateTax(250)); // 30
console.log(calculateTax(500)); // 60
```

**Benefits:**

- If tax rate changes, update ONE place (the function)
- Code is clearer: `calculateTax(100)` explains what it does
- Can reuse this function anywhere in your program

### 1. Function Declarations

A function declaration consists of the `function` keyword, followed by the function name and a pair of parentheses `()`. The function's logic goes inside curly braces `{}`.

**Basic syntax:**

```js
function functionName() {
  // code to execute
}
```

**Example: No parameters, no return value**

```js
function greet() {
  console.log("Hello, World!");
}

greet(); // Call the function
// Output: Hello, World!
```

**Example: With a return value**

```js
function greet() {
  return "Hello, World!";
}

const message = greet(); // Store the returned value
console.log(message); // Hello, World!
```

**Key difference:**

- **`console.log()`** prints to the console (side effect, no return value)
- **`return`** sends a value back to the caller (can be stored, used in calculations)

### 2. Parameters and Arguments

**Parameters** are placeholders in the function definition. **Arguments** are the actual values you pass when calling the function.

```js
function greet(name) {
  // 'name' is a parameter
  return `Hello, ${name}!`;
}

greet("Odessa"); // "Odessa" is an argument
// Returns: "Hello, Odessa!"
```

**Multiple parameters:**

```js
function calculateTotal(price, quantity) {
  return price * quantity;
}

const total = calculateTotal(50, 3);
console.log(total); // 150
```

**Parameter order matters:**

```js
function introduce(firstName, lastName) {
  return `I am ${firstName} ${lastName}`;
}

introduce("Odessa", "Santos"); // "I am Odessa Santos"
introduce("Santos", "Odessa"); // "I am Santos Odessa" (wrong order!)
```

**Default parameters** (ES6 feature):

```js
function greet(name = "Guest") {
  return `Hello, ${name}!`;
}

greet("Odessa"); // "Hello, Odessa!"
greet(); // "Hello, Guest!" (uses default)
```

### 3. Return Values

The `return` statement sends a value back from the function. **Two critical things about return:**

1. **Code after `return` never runs** (return exits the function immediately)
2. **Functions without `return` implicitly return `undefined`**

**Example 1: Explicit return**

```js
function addNumbers(a, b) {
  return a + b;
}

const sum = addNumbers(5, 7);
console.log(sum); // 12
```

**Example 2: Early return (stop execution)**

```js
function checkAge(age) {
  if (age < 18) {
    return "Too young"; // Exit function here
  }
  return "Welcome!"; // Only runs if age >= 18
}

checkAge(15); // "Too young"
checkAge(21); // "Welcome!"
```

**Example 3: No return (returns undefined)**

```js
function logMessage(msg) {
  console.log(msg);
  // No return statement
}

const result = logMessage("Hello");
console.log(result); // undefined
```

**Example 4: Returning multiple values (use an object or array)**

```js
function getNameParts(fullName) {
  const parts = fullName.split(" ");
  return {
    firstName: parts[0],
    lastName: parts[1],
  };
}

const name = getNameParts("Odessa Santos");
console.log(name.firstName); // "Odessa"
console.log(name.lastName); // "Santos"
```

### Function Scope

Variables declared inside a function are **local** (only accessible inside that function):

```js
function calculateDiscount() {
  const discountRate = 0.1; // Local variable
  return 100 * discountRate;
}

console.log(calculateDiscount()); // 10
console.log(discountRate); // Error! discountRate is not defined
```

**Global vs Local:**

```js
const tax = 0.12; // Global variable (accessible everywhere)

function calculatePrice(amount) {
  const markup = 1.2; // Local variable (only in this function)
  return amount * markup * (1 + tax);
}

console.log(calculatePrice(100)); // 134.4
console.log(tax); // 0.12 (accessible)
console.log(markup); // Error! markup is not defined outside function
```

### Real-World Applications

Functions are everywhere in Filipino daily life:

- **Jeepney fare calculator**: `calculateFare(distance)`
- **Sari-sari store change**: `getChange(payment, total)`
- **Grade calculator**: `computeFinalGrade(exam1, exam2, project)`
- **Utility bill splitter**: `splitBill(total, people)`
- **Time converter**: `convertTo24Hour(time, period)` (e.g., "3:00 PM" → 15:00)

### Common Beginner Mistakes

**1. Forgetting to call the function**

```js
// ❌ WRONG: Just declares the function, doesn't run it
function greet() {
  console.log("Hello!");
}
// Nothing happens!

// ✅ CORRECT: Call the function
function greet() {
  console.log("Hello!");
}
greet(); // Now it runs!
```

**2. Confusing parameters with arguments**

```js
// ❌ WRONG: Using different names
function add(a, b) {
  return a + b;
}
add(x, y); // Error if x and y aren't defined!

// ✅ CORRECT: Pass actual values
add(5, 10); // Returns 15
```

**3. Not returning a value when you need one**

```js
// ❌ WRONG: No return keyword
function multiply(a, b) {
  a * b; // This calculates but doesn't return!
}
const result = multiply(5, 3);
console.log(result); // undefined

// ✅ CORRECT: Use return
function multiply(a, b) {
  return a * b;
}
const result = multiply(5, 3);
console.log(result); // 15
```

**4. Code after return never executes**

```js
// ❌ WRONG: Code after return is "dead code"
function checkNumber(num) {
  return num > 0 ? "Positive" : "Negative";
  console.log("This never prints!"); // Dead code!
}

// ✅ CORRECT: Put necessary code before return
function checkNumber(num) {
  console.log("Checking number...");
  return num > 0 ? "Positive" : "Negative";
}
```

**5. Modifying global variables inside functions (bad practice)**

```js
// ❌ AVOID: Changing global state makes code unpredictable
let total = 0;
function addToTotal(amount) {
  total = total + amount; // Modifies global variable
}

// ✅ BETTER: Use parameters and return values
function addToTotal(currentTotal, amount) {
  return currentTotal + amount; // Pure function
}
let total = 0;
total = addToTotal(total, 50);
```

**6. Not using meaningful function names**

```js
// ❌ UNCLEAR: What does this do?
function x(a, b) {
  return a * b * 0.12;
}

// ✅ CLEAR: Name describes what it does
function calculateSalesTax(price, quantity) {
  return price * quantity * 0.12;
}
```

### Function Naming Best Practices

- Use **verbs** for actions: `calculateTotal`, `getUserName`, `checkStatus`
- Be **descriptive**: `getTax` is clearer than `gt`
- Use **camelCase**: `myFunction`, not `my_function` or `MyFunction`
- Make names **self-documenting**: code should explain what it does

**Resources**:

- [MDN Web Docs: Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Functions)

## Closing Story

Odessa's journey into the realm of functions has empowered her to think beyond just writing lines of code. By mastering function declarations, parameters, and return values, she's now equipped to architect logical solutions to complex problems. Functions have become her building blocks, paving the way for cleaner, more efficient code.

As Odessa continues her quest to become a top-tier developer and startup founder, she realizes that functions are not just about reducing errors but about designing scalable and elegant systems. Join Odessa in her next adventure as she dives into the world of function expressions and arrow functions, unlocking even more possibilities in her coding odyssey.
