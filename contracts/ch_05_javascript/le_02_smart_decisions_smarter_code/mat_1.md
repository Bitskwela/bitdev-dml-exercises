# Javascript Conditional Statements and Logical Operators

## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+2.0+-+COVER.png)

Odessa, an IT student in the Philippines is also a student council member 🏛️. One of her responsibilities is to manage the student council budget. As the year progresses, she begins to notice discrepancies in the entries, especially after events 🎉. There are entries that are either too high or too low to be standard expenditures.

![image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+2.1.png)

To simplify her work 👩‍💻 and make everything more efficient, Odessa decides to write a script to filter these entries. Her plan is to write code that checks each entry and determines if it's above or below the standard limit. This is her first encounter with conditional statements, and she's excited to learn how to use them to make smart decisions in her code.

With your help, she will learn how to write 'if' and 'else' statements, how to use comparison operators (>, <, >=, <=, ==, !=), and logical operators (&&, ||, !) in JavaScript 💻.

## Theory & Lecture Content

### What Are Conditional Statements?

**Think of conditionals like a crossroads** 🛣️. When you reach an intersection, you make a decision: "If the light is green, I go. If it's red, I stop." Your code works the same way—it checks a condition and then decides which path to take.

JavaScript if...else statement: Control structures are used to control the flow of execution in a program. The _if_ statement is the simplest form of control structure. It evaluates whether a statement is true or false, and then runs a set of statements based on the result. If the statement is true, it will execute the block of code within the if statement. If it's false, and there's an else statement, it will execute the code within the else statement.

### Basic if...else Example

```js
const budget = 5000;
if (budget > 4000) {
  console.log("Budget is within the limit");
} else {
  console.log("Budget is beyond the limit");
}
```

**Breaking it down:**

1. We check if `budget > 4000` (is 5000 greater than 4000?)
2. Since this is `true`, we run the first code block
3. If it were `false`, we'd run the `else` block instead

### Comparison Operators

These operators let you compare two values. Think of them as **asking questions about your data**:

| Operator | Meaning                  | Example         | Result |
| -------- | ------------------------ | --------------- | ------ |
| `>`      | Greater than             | `5000 > 4000`   | `true` |
| `<`      | Less than                | `3000 < 4000`   | `true` |
| `>=`     | Greater than or equal to | `5000 >= 5000`  | `true` |
| `<=`     | Less than or equal to    | `4000 <= 5000`  | `true` |
| `===`    | Strictly equal to        | `5000 === 5000` | `true` |
| `!==`    | Not equal to             | `5000 !== 4000` | `true` |

**Important:** Use `===` (strict equality) instead of `==`. The triple equals checks both value AND type, preventing nasty bugs:

```js
// Loose equality (==) can be confusing:
"5" == 5; // true (JavaScript converts types)
0 == false; // true (weird!)

// Strict equality (===) is safer:
"5" === 5; // false (different types: string vs number)
0 === false; // false (different types: number vs boolean)
```

### The else if Statement

When you have **more than two possibilities**, use `else if`:

```js
const score = 85;

if (score >= 90) {
  console.log("Excellent!");
} else if (score >= 75) {
  console.log("Passed!");
} else if (score >= 60) {
  console.log("Needs Improvement");
} else {
  console.log("Failed");
}
// Output: "Passed!"
```

JavaScript checks each condition **from top to bottom** and runs the FIRST matching block.

### Logical Operators

These let you combine multiple conditions. **Think of them like connecting sentences**:

**AND (`&&`)** – Both conditions must be true:

```js
const amount = 3000;
const isApproved = true;

if (amount > 1000 && isApproved) {
  console.log("Transaction approved!");
}
// Both conditions are true, so this runs
```

**OR (`||`)** – At least one condition must be true:

```js
const isWeekend = false;
const isHoliday = true;

if (isWeekend || isHoliday) {
  console.log("No school today!");
}
// isHoliday is true, so this runs
```

**NOT (`!`)** – Reverses a boolean value:

```js
const isRaining = false;

if (!isRaining) {
  console.log("Let's go to the beach!");
}
// !isRaining means "not raining" which is true
```

### Complex Conditions Example

```js
const age = 20;
const hasID = true;
const isStudent = true;

if ((age >= 18 && hasID) || isStudent) {
  console.log("You can enter the library");
} else {
  console.log("Sorry, access denied");
}
```

**Reading this condition:**

- Is the person 18+ AND has an ID?
- OR is the person a student?
- If either is true, they can enter

### Real-World Applications

Conditionals are everywhere in Filipino daily life:

- **Jeepney fare calculation**: If distance > 4km, charge extra
- **Sari-sari store discounts**: If total >= 100, give 5% discount
- **Class scheduling**: If day === "Monday" && time === "8am", go to Math class
- **Weather checks**: If isRaining === true, bring an umbrella

### Common Beginner Mistakes

**1. Using `=` instead of `===` in conditions**

```js
// ❌ WRONG: This assigns 5000 to budget
if ((budget = 5000)) {
  console.log("This always runs!");
}

// ✅ CORRECT: This compares budget to 5000
if (budget === 5000) {
  console.log("Budget is exactly 5000");
}
```

**2. Using `==` instead of `===`**

```js
// ❌ AVOID: Loose equality causes surprises
if (userInput == 0) {
  // "0", false, [], all match!
  console.log("Is zero");
}

// ✅ BETTER: Strict equality is predictable
if (userInput === 0) {
  // Only the number 0 matches
  console.log("Is zero");
}
```

**3. Forgetting curly braces with single statements**

```js
// ❌ RISKY: Easy to introduce bugs later
if (budget > 5000) console.log("Over budget");
doSomethingElse(); // This ALWAYS runs!

// ✅ SAFE: Always use braces
if (budget > 5000) {
  console.log("Over budget");
  doSomethingElse(); // Now this only runs if true
}
```

**4. Wrong order in else if chains**

```js
// ❌ WRONG: The 90+ check never runs!
if (score >= 60) {
  console.log("Passed");
} else if (score >= 90) {
  // This is unreachable!
  console.log("Excellent");
}

// ✅ CORRECT: Check highest values first
if (score >= 90) {
  console.log("Excellent");
} else if (score >= 60) {
  console.log("Passed");
}
```

**5. Confusing `&&` and `||`**

```js
// ❌ WRONG: This person needs BOTH, not just one
if (hasBread || hasPeanutButter) {
  console.log("Can make sandwich");
}

// ✅ CORRECT: Need both ingredients
if (hasBread && hasPeanutButter) {
  console.log("Can make sandwich");
}
```

You can learn more about comparison and logical operators [here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators#comparison_operators)

## Closing Story

With a few lines of code, Odessa has made her work more efficient. Now, whenever there's a budget entry, the script is run and it returns a verdict - if the budget is within range or over limit. She's also managed to clean up the older entries to only include positive values and those less than 5000.

In the process, she's not only learned how to use if...else statements, comparison, and logical operators, but she also saved her time 🕰️ for more important tasks ahead 💡. This was another step on her journey to becoming a full-stack developer, proving to her that with coding, every problem - no matter how daunting - can indeed have a solution.
