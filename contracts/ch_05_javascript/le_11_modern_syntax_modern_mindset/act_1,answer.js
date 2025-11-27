// Task 1: Convert to Arrow Functions
const calculateArea = (width, height) => width * height;

const greetUser = (name) => `Hello, ${name}!`;

// Task 2: Use Object Destructuring
const getUserInfo = (user) => {
  const { name, age, course } = user;
  return `${name} is ${age} years old and studying ${course}.`;
};

// Task 3: Use Array Destructuring and Template Literals
const formatScores = (scores) => {
  const [math, english, science] = scores;
  return `Math: ${math}, English: ${english}, Science: ${science}`;
};
