# Functions Activity

## Initial Code

```js
// Task 1: Welcome Message Function
function welcomeStudent(name) {
  // Add your code here
}

// Task 2: Calculate Total Price
function calculateTotal(price, quantity) {
  // Add your code here
}

// Task 3: Check Pass or Fail
function checkGrade(score) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Function Declarations, Parameters, Return Values, Default Parameters, Conditional Logic in Functions

---

### Task 1: Welcome Message Function

Create a function that takes a `name` parameter and returns a personalized welcome message. If no name is provided (empty or undefined), return "Welcome, Student!".

```js
function welcomeStudent(name) {
  if (!name) {
    return "Welcome, Student!";
  } else {
    return `Welcome, ${name}!`;
  }
}
```

---

### Task 2: Calculate Total Price

Create a function that takes `price` and `quantity` as parameters and returns the total cost. If `quantity` is not provided, assume the quantity is 1.

```js
function calculateTotal(price, quantity) {
  if (!quantity) {
    quantity = 1;
  }
  return price * quantity;
}
```

---

### Task 3: Check Pass or Fail

Create a function that takes a `score` parameter and returns "Passed" if the score is 75 or above, otherwise return "Failed". Use the ternary operator for a concise solution.

```js
function checkGrade(score) {
  return score >= 75 ? "Passed" : "Failed";
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `name`: A string parameter representing the student's name. Checked for existence using `!name` to handle cases where no name is provided.

- `price`: A numeric parameter representing the cost of a single item. Used in multiplication with quantity to calculate the total.

- `quantity`: A numeric parameter representing how many items to purchase. Defaults to 1 if not provided.

- `score`: A numeric parameter representing a student's test score. Compared against the passing threshold of 75.

**Key Concepts:**

- Function Declaration:
  The `function` keyword followed by the function name, parentheses for parameters, and curly braces for the code block. Example: `function greet(name) { ... }`

- Parameters:
  Variables listed in the function definition that act as placeholders for values passed when the function is called. Multiple parameters are separated by commas.

- Return Values:
  The `return` keyword sends a value back from the function. Once `return` executes, the function stops running. Functions without a `return` statement return `undefined`.

- Default Parameter Handling:
  Using conditional checks like `if (!quantity)` to provide default values when parameters are missing or falsy. This ensures functions work even with incomplete arguments.

- Ternary Operator:
  A shorthand for `if...else` that returns one of two values based on a condition. Syntax: `condition ? valueIfTrue : valueIfFalse`. Makes code more concise for simple conditional returns.

- Template Literals:
  Strings enclosed in backticks (`` ` ``) that allow embedding expressions using `${expression}`. Makes string concatenation cleaner and more readable.

**Key Functions:**

- `welcomeStudent(name)`:
  Demonstrates handling optional parameters. Uses `!name` to check if the parameter is falsy (undefined, null, empty string) and returns a default message accordingly.

- `calculateTotal(price, quantity)`:
  Shows how to work with multiple parameters and provide default values. Calculates a simple multiplication and returns the result.

- `checkGrade(score)`:
  Uses the ternary operator for concise conditional logic. Compares the score against a threshold and returns the appropriate result string.
