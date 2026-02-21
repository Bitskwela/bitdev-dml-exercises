// Task 1: Declare and Display Personal Information

// Using const for 'name' because it won't change during execution
// const prevents accidental reassignment, making code more predictable
const name = "Odessa";

// Using let for 'age' because age could be incremented or modified later
// Even though we don't modify it here, let signals "this value might change"
let age = 20;

// Boolean values are either true or false (no quotes needed)
// const is appropriate since student status is fixed for this exercise
const isStudent = true;

// console.log() outputs values to the console for debugging and verification
// This is the most basic way to see what your variables contain
console.log(name);
console.log(age);
console.log(isStudent);

// Task 2: Use Template Literals for Formatted Output

// Template literals (backticks) allow embedding expressions with ${}
// This is much cleaner than string concatenation with + operator
// Example of what NOT to do: "Hi, I'm " + name + ", I am " + age + " years old..."
const message = `Hi, I'm ${name}, I am ${age} years old, and it is ${isStudent} that I am a student.`;

console.log(message);

// Task 3: Calculate and Display Birth Year

// Always use const for values that don't change
// This immediately tells other developers "this value is fixed"
const currentYear = 2025;

// Arithmetic operations work with numbers in JavaScript
// Subtracting age from current year gives approximate birth year
// Note: This assumes birthday has already passed this year
const birthYear = currentYear - age;

// Template literals make output messages much more readable
// Compare to: console.log("I was born in " + birthYear)
console.log(`I was born in ${birthYear}`);
