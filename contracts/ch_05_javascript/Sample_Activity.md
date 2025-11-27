# Conditional Statements and Logical Operators Activity

## Initial Code

```js
// Task 1: Budget Validation
function checkBudgetStatus(budget) {
  // Add your code here
}

// Task 2: Entry Validation with Multiple Conditions
function isValidEntry(amount) {
  // Add your code here
}

// Task 3: Budget Category Classifier
function classifyExpense(amount, category) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `if...else` statements, `else if`, Comparison Operators (`>`, `<`, `>=`, `<=`, `==`, `!=`), Logical Operators (`&&`, `||`, `!`)

---

### Task 1: Budget Validation

Create a function that checks the budget amount and returns different messages based on whether the budget is over, at, or under the limit of 5000.

```js
function checkBudgetStatus(budget) {
  if (budget > 5000) {
    return "Over budget";
  } else if (budget == 5000) {
    return "At limit";
  } else {
    return "Under budget";
  }
}
```

---

### Task 2: Entry Validation with Multiple Conditions

Create a function that validates whether an entry amount is valid. An entry is valid if it is a positive number AND does not exceed 5000. Use the logical AND operator (`&&`).

```js
function isValidEntry(amount) {
  if (amount > 0 && amount <= 5000) {
    return true;
  } else {
    return false;
  }
}
```

---

### Task 3: Budget Category Classifier

Create a function that classifies expenses based on both the amount and category. This task combines multiple comparison operators with logical operators (`&&` and `||`).

```js
function classifyExpense(amount, category) {
  if (category == "event" && amount > 3000) {
    return "High event expense";
  } else if (category == "event" && amount <= 3000) {
    return "Normal event expense";
  } else if (category == "supplies" || category == "food") {
    return "Operational expense";
  } else {
    return "Uncategorized expense";
  }
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `budget`: A numeric parameter representing the total budget amount. Used to compare against the limit of 5000 using comparison operators (`>`, `==`, `<`).

- `amount`: A numeric parameter representing an expense entry. Must be validated to ensure it's positive and within acceptable limits using the AND (`&&`) operator.

- `category`: A string parameter representing the type of expense (e.g., "event", "supplies", "food"). Used in combination with `amount` to determine the expense classification.

**Key Concepts:**

- `if...else` Statement:
  The basic control structure that executes different code blocks based on whether a condition evaluates to `true` or `false`. The `if` block runs when the condition is true, and the `else` block runs when it's false.

- `else if` Statement:
  Used to check multiple conditions in sequence. When the first `if` condition is false, JavaScript checks the `else if` condition. This allows for more than two possible outcomes.

- Comparison Operators:

  - `>` (greater than): Returns true if left value is larger
  - `<` (less than): Returns true if left value is smaller
  - `>=` (greater than or equal): Returns true if left value is larger or equal
  - `<=` (less than or equal): Returns true if left value is smaller or equal
  - `==` (equal to): Returns true if both values are equal
  - `!=` (not equal to): Returns true if values are different

- Logical Operators:
  - `&&` (AND): Returns true only if BOTH conditions are true. Example: `amount > 0 && amount <= 5000`
  - `||` (OR): Returns true if AT LEAST ONE condition is true. Example: `category == "supplies" || category == "food"`
  - `!` (NOT): Reverses the boolean value. Example: `!isValid` returns true if isValid is false

**Key Functions:**

- `checkBudgetStatus(budget)`:
  Demonstrates the use of `if...else if...else` chain with comparison operators. Compares the budget against a fixed limit (5000) and returns appropriate status messages.

- `isValidEntry(amount)`:
  Shows how to combine multiple conditions using the AND (`&&`) operator. Both conditions must be true for the entry to be considered valid.

- `classifyExpense(amount, category)`:
  Combines comparison operators with both AND (`&&`) and OR (`||`) logical operators. Demonstrates how to build complex conditional logic by checking multiple criteria.

#### Complete Solution

```js
// Task 1: Budget Validation
function checkBudgetStatus(budget) {
  if (budget > 5000) {
    return "Over budget";
  } else if (budget == 5000) {
    return "At limit";
  } else {
    return "Under budget";
  }
}

// Task 2: Entry Validation with Multiple Conditions
function isValidEntry(amount) {
  if (amount > 0 && amount <= 5000) {
    return true;
  } else {
    return false;
  }
}

// Task 3: Budget Category Classifier
function classifyExpense(amount, category) {
  if (category == "event" && amount > 3000) {
    return "High event expense";
  } else if (category == "event" && amount <= 3000) {
    return "Normal event expense";
  } else if (category == "supplies" || category == "food") {
    return "Operational expense";
  } else {
    return "Uncategorized expense";
  }
}
```
