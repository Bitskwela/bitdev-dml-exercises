# Debugging and Error Handling Activity

## Initial Code

```js
// Task 1: Parse JSON Safely
function parseJSONSafely(jsonString) {
  // Add your code here
}

// Task 2: Safe Division
function safeDivide(a, b) {
  // Add your code here
}

// Task 3: Handle API Error
function fetchUserData() {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `try...catch` Statement, Error Handling, `console.log`, `console.error`, Error Messages, `throw` Statement

---

### Task 1: Parse JSON Safely

Create a function that attempts to parse a JSON string. Use a `try...catch` block to handle any parsing errors. If successful, return the parsed object. If an error occurs, log the error message to the console and return `null`.

```js
function parseJSONSafely(jsonString) {
  try {
    const data = JSON.parse(jsonString);
    return data;
  } catch (error) {
    console.error("Error parsing JSON:", error.message);
    return null;
  }
}
```

---

### Task 2: Safe Division

Create a function that divides two numbers safely. If the second number is zero, throw an error with the message "Cannot divide by zero". Use a `try...catch` block to handle the error and return `null` if division fails.

```js
function safeDivide(a, b) {
  try {
    if (b === 0) {
      throw new Error("Cannot divide by zero");
    }
    return a / b;
  } catch (error) {
    console.error("Division error:", error.message);
    return null;
  }
}
```

---

### Task 3: Handle API Error

Create a function that simulates fetching user data. The function should throw an error to simulate a network failure. Use a `try...catch` block to catch the error and log "Failed to fetch user data: [error message]" to the console. Return an object with `success: false` and the error message.

```js
function fetchUserData() {
  try {
    // Simulating network failure
    throw new Error("Network connection failed");
  } catch (error) {
    console.error("Failed to fetch user data:", error.message);
    return {
      success: false,
      error: error.message,
    };
  }
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `jsonString`: A string parameter containing JSON data to be parsed. May be valid or invalid JSON.

- `data`: The JavaScript object resulting from successfully parsing the JSON string.

- `error`: The error object caught in the `catch` block. Contains properties like `message` that describe what went wrong.

- `a`: The dividend (the number being divided) in the division operation.

- `b`: The divisor (the number to divide by). If this is zero, an error should be thrown.

**Key Concepts:**

- `try...catch` Statement:
  A control structure for handling errors gracefully. Code in the `try` block is executed, and if an error occurs, execution jumps to the `catch` block instead of crashing.

- Error Object:
  When an error is caught, it's an object with properties like `message` (description of the error) and `name` (type of error like "SyntaxError" or "TypeError").

- `throw` Statement:
  Manually creates and throws an error. Use `throw new Error("message")` to generate a custom error that will be caught by a `catch` block.

- `console.log`:
  Outputs information to the console for debugging. Useful for tracking variable values and program flow.

- `console.error`:
  Similar to `console.log` but specifically for error messages. Often displayed in red in the console for visibility.

- `JSON.parse()`:
  Converts a JSON string into a JavaScript object. Throws a `SyntaxError` if the string is not valid JSON.

**Key Functions:**

- `parseJSONSafely(jsonString)`:
  Demonstrates using `try...catch` to handle potential JSON parsing errors. Returns the parsed data on success or `null` on failure.

- `safeDivide(a, b)`:
  Shows how to manually throw errors using `throw new Error()` and catch them. Validates input before performing operations.

- `fetchUserData()`:
  Simulates an asynchronous operation that might fail. Demonstrates returning structured error information using an object.
