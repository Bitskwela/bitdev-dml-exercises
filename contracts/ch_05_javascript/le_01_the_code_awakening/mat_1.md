## Background Story

It's July 22, 2025, and Odessa, a determined first-year IT student at a university in San Juan City, finds herself wandering through a bustling job fair on campus. Amongst the sea of booths and flashy banners, a small stall catches her eye—the Code Awakening: JavaScript for Beginners.

Intrigued, Odessa approaches the booth where a friendly computer science professor greets her. She watches in amazement as the professor effortlessly writes a few lines of code that make the computer come alive. Odessa is captivated by the idea that she too can wield this power to create applications and tools that can make a real difference in her barangay.

With a spark ignited in her, Odessa decides to dive headfirst into the world of JavaScript. Her goal is simple yet profound: to master the language that will allow her to turn her ideas into reality. Her first challenge? To use variables and `console.log` to display her name, age, and school ID—a small step towards her dream of transforming her community through technology.

## Theory & Lecture Content

JavaScript is a powerful programming language that allows us to interact with web pages and create dynamic content. Today, we will be diving into the basics: variables, data types, `let`, `const`, and `console.log`.

### Variables

Variables are containers for storing data values. In JavaScript, we can declare variables using `let` and `const` keywords.

```js
// Using let to declare a variable
let name = "Odessa";
let age = 20;

// Using const to declare a constant variable
const schoolID = "ABC123";
```

### Data Types

JavaScript has several data types, including:

- Strings: for text data
- Numbers: for numeric data
- Booleans: for true/false values

```js
let greeting = "Hello, World!"; // String
let numStudents = 50; // Number
let isStudent = true; // Boolean
```

### `console.log`

The `console.log()` function allows us to print messages and values to the console for debugging and testing purposes.

```js
console.log(name); // Output: Odessa
console.log(`Age: ${age}`); // Output: Age: 20
console.log(`School ID: ${schoolID}`); // Output: School ID: ABC123
```

Now, let's practice what we've learned through some exercises.

## Exercises

### Exercise 1

#### Problem

Create variables to store your name, age, and school ID. Then, use `console.log` to display them.

#### Starter Code

```js
// Declare variables here
let name;
let age;
let schoolID;

// Display variables using console.log
console.log(name);
console.log(age);
console.log(schoolID);
```

#### Full Solution

```js
let name = "Odessa";
let age = 20;
const schoolID = "ABC123";

console.log(name);
console.log(age);
console.log(schoolID);
```

### Exercise 2

#### Problem

Create a variable to store your favorite food and display it using `console.log`.

#### Starter Code

```js
// Declare a variable for favorite food
let favoriteFood;

// Display the favorite food using console.log
console.log(favoriteFood);
```

#### Full Solution

```js
let favoriteFood = "Adobo";

console.log(`Favorite Food: ${favoriteFood}`);
```

### Exercise 3

#### Problem

Create a variable to store your birth year and calculate your age. Display your age using `console.log`.

#### Starter Code

```js
// Declare variables for birth year and age
let birthYear;
let currentYear = 2025;
let age;

// Calculate age and display using console.log
console.log(age);
```

#### Full Solution

```js
let birthYear = 2005;
let currentYear = 2025;
let age = currentYear - birthYear;

console.log(`Age: ${age}`);
```

## Test Cases

Ensure that your solutions are correct by running the following Jest test cases:

```js
test("display name, age, school ID", () => {
  expect(name).toBe("Odessa");
  expect(age).toBe(20);
  expect(schoolID).toBe("ABC123");
});

test("display favorite food", () => {
  expect(favoriteFood).toBe("Adobo");
});

test("calculate and display age", () => {
  expect(age).toBe(20);
});
```

## Closing Story

As Odessa successfully displays her name, age, and school ID using variables and `console.log`, she feels a rush of excitement. This is just the beginning of her JavaScript journey. With each line of code she writes, Odessa is one step closer to realizing her dream of creating technology that can positively impact her barangay.

In the next lesson, Odessa will delve into the world of functions and learn how to make her code more efficient and reusable. Join her as she continues on her path to becoming a tech-savvy full-stack developer!
