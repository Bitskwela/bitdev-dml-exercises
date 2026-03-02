// Task 1: Convert to Arrow Functions
// ARROW FUNCTIONS: Modern ES6 syntax for writing functions
// Syntax: (parameters) => expression
// When body is a single expression, you can omit {} and 'return'

const calculateArea = (width, height) => width * height;
// Arrow function with implicit return
// Equivalent to: function calculateArea(width, height) { return width * height; }
// Concise for simple one-liner functions

const greetUser = (name) => `Hello, ${name}!`;
// Single parameter can omit parentheses: name => ...
// But using (name) is more consistent and recommended

// Task 2: Use Object Destructuring
// DESTRUCTURING: Extract properties from objects/arrays into variables
// Avoids repetitive obj.property access

const getUserInfo = (user) => {
  // Extract name, age, course from user object into individual variables
  // Instead of: const name = user.name; const age = user.age; etc.
  const { name, age, course } = user;

  return `${name} is ${age} years old and studying ${course}.`;

  // COULD ALSO destructure in parameters:
  // const getUserInfo = ({ name, age, course }) => {
  //   return `${name} is ${age} years old and studying ${course}.`;
  // };
};

// Task 3: Use Array Destructuring and Template Literals
// ARRAY DESTRUCTURING: Extract array elements by position

const formatScores = (scores) => {
  // Extract first 3 array elements into named variables
  // scores[0] → math, scores[1] → english, scores[2] → science
  const [math, english, science] = scores;

  // Template literals (backticks) allow ${} interpolation
  // Cleaner than: "Math: " + math + ", English: " + english + ...
  return `Math: ${math}, English: ${english}, Science: ${science}`;

  // ADVANCED: Can skip elements or use rest operator
  // const [first, , third] = scores;  // Skip second element
  // const [first, ...rest] = scores;  // rest = [all remaining elements]
};
