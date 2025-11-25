# JavaScript Basics: Variables and Console Output Activity

## Initial Code

```js
// Task 1: Declare and Display Personal Information
// TODO: Create a constant variable called 'name' and assign your name as a string
// TODO: Create a variable called 'age' using 'let' and assign your age as a number
// TODO: Create a constant variable called 'isStudent' and assign a boolean value

// TODO: Display each variable using console.log()

// Task 2: Use Template Literals for Formatted Output
// TODO: Create a variable called 'message' using template literals
// The message should display: "Hi, I'm [name], I am [age] years old, and it is [true/false] that I am a student."

// TODO: Display the message using console.log()

// Task 3: Calculate and Display Birth Year
// TODO: Create a constant variable called 'currentYear' and assign 2025
// TODO: Create a constant variable called 'birthYear' by calculating currentYear - age

// TODO: Display your birth year with a descriptive message using template literals
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Variables (`let`, `const`), Data Types (Strings, Numbers, Booleans), `console.log()`, Template Literals

---

### Task 1: Declare and Display Personal Information

Create variables to store your personal information (name, age, and whether you are a student). Use `let` for values that can change and `const` for values that should remain constant. Display each variable using `console.log`.

```js
const name = "Odessa";
let age = 20;
const isStudent = true;

console.log(name);
console.log(age);
console.log(isStudent);
```

---

### Task 2: Use Template Literals for Formatted Output

Using the variables from Task 1, create a formatted message using template literals that displays: "Hi, I'm [name], I am [age] years old, and it is [true/false] that I am a student."

```js
const message = `Hi, I'm ${name}, I am ${age} years old, and it is ${isStudent} that I am a student.`;

console.log(message);
```

---

### Task 3: Calculate and Display Birth Year

Create a variable for the current year using `const`, then calculate the birth year based on the age variable. Store the result in a new variable and display it with a descriptive message.

```js
const currentYear = 2025;
const birthYear = currentYear - age;

console.log(`I was born in ${birthYear}`);
```

---

## Breakdown of the Activity

**Variables Defined:**

- `name`: A constant string variable that stores the user's name. Uses `const` because a person's name doesn't typically change during program execution.

- `age`: A numeric variable declared with `let` because age can change (e.g., if we wanted to increment it). Stores a whole number representing the user's age.

- `isStudent`: A boolean constant that stores `true` or `false`. Demonstrates the boolean data type and uses `const` since this status is fixed for the activity.

- `message`: A string variable created using template literals (backticks). Demonstrates string interpolation with `${}` syntax to embed variable values directly into a string.

- `currentYear`: A constant storing the current year as a number. Uses `const` because the current year doesn't change during execution.

- `birthYear`: A calculated variable that demonstrates arithmetic operations. Subtracts `age` from `currentYear` to derive the birth year.

**Key Concepts:**

- `let` vs `const`:
  Use `let` when the variable's value might change later in the program. Use `const` when the value should remain constant throughout execution. This helps prevent accidental reassignment and makes code more predictable.

- Template Literals:
  Template literals use backticks (`` ` ``) instead of quotes and allow embedding expressions using `${expression}` syntax. This is more readable than string concatenation with `+`.

- `console.log()`:
  A built-in function that outputs values to the browser's console or terminal. Essential for debugging and verifying that your code works correctly. Can accept multiple arguments: `console.log("Name:", name)`.

- Data Types:
  JavaScript has three primitive data types covered here: Strings (text in quotes), Numbers (integers or decimals without quotes), and Booleans (`true` or `false` without quotes).
