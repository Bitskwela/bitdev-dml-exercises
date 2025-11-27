# Answer Keys for Chapter 5: JavaScript

## Lesson 1: The Code Awakening

```javascript
// Task 1: Declare and Display Personal Information
const name = "Odessa";
let age = 20;
const isStudent = true;

console.log(name);
console.log(age);
console.log(isStudent);

// Task 2: Use Template Literals for Formatted Output
const message = `Hi, I'm ${name}, I am ${age} years old, and it is ${isStudent} that I am a student.`;

console.log(message);

// Task 3: Calculate and Display Birth Year
const currentYear = 2025;
const birthYear = currentYear - age;

console.log(`I was born in ${birthYear}`);
```

## Lesson 2: Smart Decisions, Smarter Code

```javascript
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

## Lesson 3: Loops of Liberation

```javascript
// Task 1: Print Numbers with For Loop
function printNumbers(start, end) {
  for (let i = start; i <= end; i++) {
    console.log(i);
  }
}

// Task 2: Sum Array Elements with While Loop
function sumArray(numbers) {
  let sum = 0;
  let i = 0;

  while (i < numbers.length) {
    sum = sum + numbers[i];
    i++;
  }

  return sum;
}

// Task 3: Generate Multiplication Table with Nested Loops
function multiplicationTable(size) {
  let table = [];

  for (let i = 0; i < size; i++) {
    let row = [];
    for (let j = 0; j < size; j++) {
      row.push((i + 1) * (j + 1));
    }
    table.push(row);
  }

  return table;
}
```

## Lesson 4: Function Overload

```javascript
// Task 1: Welcome Message Function
function welcomeStudent(name) {
  if (!name) {
    return "Welcome, Student!";
  } else {
    return `Welcome, ${name}!`;
  }
}

// Task 2: Calculate Total Price
function calculateTotal(price, quantity) {
  if (!quantity) {
    quantity = 1;
  }
  return price * quantity;
}

// Task 3: Check Pass or Fail
function checkGrade(score) {
  return score >= 75 ? "Passed" : "Failed";
}
```

## Lesson 5: Array of Possibilities

```javascript
// Task 1: Find the Highest Score
function findHighestScore(scores) {
  let highest = scores[0];

  for (let i = 1; i < scores.length; i++) {
    if (scores[i] > highest) {
      highest = scores[i];
    }
  }

  return highest;
}

// Task 2: Get Even Numbers
function getEvenNumbers(numbers) {
  let evenNumbers = [];

  for (let i = 0; i < numbers.length; i++) {
    if (numbers[i] % 2 === 0) {
      evenNumbers.push(numbers[i]);
    }
  }

  return evenNumbers;
}

// Task 3: Calculate Average
function calculateAverage(grades) {
  let sum = 0;

  for (let i = 0; i < grades.length; i++) {
    sum += grades[i];
  }

  let average = sum / grades.length;
  return average;
}
```

## Lesson 6: Objects in the Mirror

```javascript
// Task 1: Create and Access Student Object
function getStudentSummary(student) {
  return `${student.name} is ${student.age} years old, studying ${student.course} in year ${student.year}.`;
}

// Task 2: Build Object with Bracket Notation
function createProfile(keys, values) {
  let profile = {};

  for (let i = 0; i < keys.length; i++) {
    profile[keys[i]] = values[i];
  }

  return profile;
}

// Task 3: Access Nested Object Data
function getTeacherEmail(classInfo) {
  return classInfo.teacher.email;
}
```

## Lesson 7: Dominate the Web

```javascript
// Task 1: Select and Update Text Content
function updateWelcomeMessage(username) {
  const welcomeElement = document.querySelector("#welcome");
  welcomeElement.innerText = `Welcome, ${username}!`;
}

// Task 2: Add Click Event Listener
function setupClickHandler() {
  const alertBtn = document.querySelector("#alertBtn");
  const statusElement = document.querySelector("#status");

  alertBtn.addEventListener("click", function () {
    statusElement.innerText = "Button was clicked!";
  });
}

// Task 3: Toggle Element Visibility
function setupToggle() {
  const toggleBtn = document.querySelector("#toggleBtn");
  const contentElement = document.querySelector("#content");

  toggleBtn.addEventListener("click", function () {
    if (contentElement.style.display === "none") {
      contentElement.style.display = "block";
    } else {
      contentElement.style.display = "none";
    }
  });
}
```

## Lesson 8: The Suggestion Box

```javascript
// Task 1: Handle Form Submission
function setupFormSubmit() {
  const form = document.querySelector("#userForm");

  form.addEventListener("submit", function (event) {
    event.preventDefault();
    alert("Form submitted successfully!");
  });
}

// Task 2: Get Input Value
function getInputValue(inputId) {
  const inputElement = document.querySelector(`#${inputId}`);
  return inputElement.value;
}

// Task 3: Real-time Input Validation
function setupValidation() {
  const emailInput = document.querySelector("#emailInput");
  const errorMessage = document.querySelector("#errorMessage");

  emailInput.addEventListener("input", function () {
    const email = emailInput.value;

    if (!email.includes("@")) {
      errorMessage.innerText = "Please enter a valid email";
    } else {
      errorMessage.innerText = "";
    }
  });
}
```

## Lesson 9: Debugging the Future

```javascript
// Task 1: Parse JSON Safely
function parseJSONSafely(jsonString) {
  try {
    const data = JSON.parse(jsonString);
    return data;
  } catch (error) {
    console.error("Error parsing JSON:", error.message);
    return null;
  }
}

// Task 2: Safe Division
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

// Task 3: Handle API Error
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

## Lesson 10: Map, Filter, Rise

```javascript
// Task 1: Extract and Transform with Map
function getProductNames(products) {
  return products.map((product) => product.name.toUpperCase());
}

// Task 2: Filter by Condition
function filterLowStock(products, threshold) {
  return products.filter((product) => product.stock < threshold);
}

// Task 3: Calculate Total with Reduce
function calculateTotalValue(products) {
  return products.reduce(
    (total, product) => total + product.price * product.stock,
    0
  );
}
```

## Lesson 11: Modern Syntax, Modern Mindset

```javascript
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
```

## Lesson 12: Clocked In

```javascript
// Task 1: Get Tomorrow's Date
function getTomorrowDate() {
  const today = new Date();
  const tomorrow = new Date(today);
  tomorrow.setDate(today.getDate() + 1);

  const year = tomorrow.getFullYear();
  const month = String(tomorrow.getMonth() + 1).padStart(2, "0");
  const day = String(tomorrow.getDate()).padStart(2, "0");

  return `${year}-${month}-${day}`;
}

// Task 2: Calculate Hours Between Dates
function getHoursDifference(startDate, endDate) {
  const start = new Date(startDate);
  const end = new Date(endDate);

  const diffMs = end.getTime() - start.getTime();
  const diffHours = diffMs / (1000 * 60 * 60);

  return diffHours;
}

// Task 3: Format Date as String
function formatDatePH(date) {
  const day = String(date.getDate()).padStart(2, "0");
  const month = date.toLocaleString("en-PH", { month: "short" });
  const year = date.getFullYear();

  return `${day} ${month} ${year}`;
}
```

## Lesson 13: Divide and Conquer

```javascript
// utils/mathUtils.js
export function add(a, b) {
  return a + b;
}

export function multiply(a, b) {
  return a * b;
}

// calculator.js
import { add, multiply } from "./utils/mathUtils.js";

export function calculate(a, b) {
  return {
    sum: add(a, b),
    product: multiply(a, b),
  };
}

// config.js
const config = {
  appName: "MyApp",
  version: "1.0.0",
  environment: "development",
};

export default config;

// app.js (using the default export)
import config from "./config.js";

console.log(config.appName); // "MyApp"
```

## Lesson 14: Fetch the Future

```javascript
// Task 1: Fetch Data with Async/Await
async function fetchUserData(userId) {
  try {
    const response = await fetch(
      `https://jsonplaceholder.typicode.com/users/${userId}`
    );

    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    const user = await response.json();
    return user;
  } catch (error) {
    console.error("Failed to fetch user:", error.message);
    throw error;
  }
}

// Task 2: Fetch with Promise Chaining
function fetchPostTitle(postId) {
  return fetch(`https://jsonplaceholder.typicode.com/posts/${postId}`)
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return response.json();
    })
    .then((post) => post.title)
    .catch((error) => {
      console.error("Failed to fetch post:", error.message);
      throw error;
    });
}

// Task 3: Fetch Multiple Resources
async function fetchUserAndPosts(userId) {
  try {
    const [user, posts] = await Promise.all([
      fetch(`https://jsonplaceholder.typicode.com/users/${userId}`).then(
        (res) => res.json()
      ),
      fetch(`https://jsonplaceholder.typicode.com/posts?userId=${userId}`).then(
        (res) => res.json()
      ),
    ]);

    return {
      user: user,
      posts: posts,
    };
  } catch (error) {
    console.error("Failed to fetch data:", error.message);
    throw error;
  }
}
```

## Lesson 15: Building from Scratch

```javascript
// Task 1: Create an Element
function createCard(title, content) {
  const card = document.createElement("div");
  card.className = "card";

  const titleElement = document.createElement("h3");
  titleElement.textContent = title;
  card.appendChild(titleElement);

  const contentElement = document.createElement("p");
  contentElement.textContent = content;
  card.appendChild(contentElement);

  return card;
}

// Task 2: Append Multiple Elements
function createList(items) {
  const ul = document.createElement("ul");

  for (let i = 0; i < items.length; i++) {
    const li = document.createElement("li");
    li.textContent = items[i];
    ul.appendChild(li);
  }

  return ul;
}

// Task 3: Remove an Element
function removeCardById(id, container) {
  const card = container.querySelector(`[data-id="${id}"]`);

  if (card) {
    container.removeChild(card);
    return true;
  }

  return false;
}
```

## Lesson 16: State of Barangay

```javascript
// stateManager.js
const state = {
  currentScreen: "home",
  draft: "",
  items: [],
};

function getState(key) {
  return state[key];
}

function setState(key, value) {
  state[key] = value;
}

function saveState() {
  localStorage.setItem("appState", JSON.stringify(state));
}

function loadState() {
  const json = localStorage.getItem("appState");
  if (json) {
    Object.assign(state, JSON.parse(json));
  }
}

// app.js
function showScreen(name) {
  setState("currentScreen", name);
  saveState();

  const sections = document.querySelectorAll("section");
  sections.forEach((section) => {
    if (section.id === name) {
      section.style.display = "block";
    } else {
      section.style.display = "none";
    }
  });
}

function setupDraftPersistence() {
  const draftTextarea = document.querySelector("#draft");

  // Load saved draft
  draftTextarea.value = getState("draft");

  // Save draft on input
  draftTextarea.addEventListener("input", function (event) {
    setState("draft", event.target.value);
    saveState();
  });
}

// Initialize app
document.addEventListener("DOMContentLoaded", function () {
  loadState();
  showScreen(getState("currentScreen"));
  setupDraftPersistence();
});
```

## Lesson 17: Saving Memory

```javascript
// Task 1: Save and Load Theme Preference
function saveTheme(theme) {
  localStorage.setItem("app-theme", theme);
}

function loadTheme() {
  const savedTheme = localStorage.getItem("app-theme");

  if (savedTheme === "dark") {
    return "dark";
  } else {
    return "light";
  }
}

// Task 2: Save and Load Array Data
function saveScores(scores) {
  localStorage.setItem("app-scores", JSON.stringify(scores));
}

function loadScores() {
  const raw = localStorage.getItem("app-scores");

  if (!raw) {
    return [];
  }

  try {
    const parsed = JSON.parse(raw);
    if (Array.isArray(parsed)) {
      return parsed;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}

// Task 3: Clear Specific Data
function clearUserData(key) {
  const exists = localStorage.getItem(key) !== null;

  if (exists) {
    localStorage.removeItem(key);
    return true;
  }

  return false;
}
```

## Lesson 18: Blueprints with Classes

```javascript
// Task 1: Create a Product Class
class Product {
  constructor(id, name, price) {
    this.id = id;
    this.name = name;
    this.price = price;
  }

  applyDiscount(percent) {
    this.price = this.price * (1 - percent / 100);
  }

  toString() {
    return `${this.name} (₱${this.price.toFixed(2)})`;
  }
}

// Task 2: Create a User Class
class User {
  constructor(username, email) {
    this.username = username;
    this.email = email;
  }

  greet() {
    return `Hello, ${this.username}!`;
  }

  updateEmail(newEmail) {
    this.email = newEmail;
  }
}

// Task 3: Create a Class with Static Members
class Counter {
  static count = 0;

  constructor(name) {
    this.name = name;
    Counter.count++;
  }

  dispose() {
    Counter.count--;
  }

  static getCount() {
    return Counter.count;
  }
}
```

## Lesson 19: The Timer That Launched a Startup

```javascript
// Task 1: Delayed Execution
function delayedGreeting(name, ms) {
  const timeoutId = setTimeout(function () {
    console.log(`Hello, ${name}!`);
  }, ms);

  return timeoutId;
}

// Task 2: Simple Countdown
function startCountdown(seconds, onTick, onFinish) {
  let remaining = seconds;

  // Call onTick immediately with initial value
  onTick(remaining);

  const intervalId = setInterval(function () {
    remaining--;
    onTick(remaining);

    if (remaining <= 0) {
      clearInterval(intervalId);
      onFinish();
    }
  }, 1000);

  return intervalId;
}

// Task 3: Stoppable Interval
function createRepeater(callback, ms) {
  let intervalId = null;

  return {
    start: function () {
      if (intervalId === null) {
        intervalId = setInterval(callback, ms);
      }
    },
    stop: function () {
      if (intervalId !== null) {
        clearInterval(intervalId);
        intervalId = null;
      }
    },
  };
}
```

## Lesson 20: Drag It, Drop It, Own It

```javascript
// Task 1: Core Drag and Drop Functions
function allowDrop(evt) {
  evt.preventDefault();
}

function drag(evt) {
  evt.dataTransfer.setData("text/plain", evt.target.id);
  evt.target.classList.add("dragging");
}

function drop(evt) {
  evt.preventDefault();
  const id = evt.dataTransfer.getData("text/plain");
  const card = document.getElementById(id);
  const column = evt.target.closest(".column");
  column.appendChild(card);
  card.classList.remove("dragging");
}

function dragEnd(evt) {
  evt.target.classList.remove("dragging");
}

// Task 2: Create a Draggable Task Card
function createTaskCard(id, text) {
  const card = document.createElement("div");
  card.className = "task-card";
  card.draggable = true;
  card.id = id;
  card.textContent = text;

  card.addEventListener("dragstart", drag);
  card.addEventListener("dragend", dragEnd);

  return card;
}

// Task 3: Wire Up Drag Events to Columns
function setupDragAndDrop() {
  const columns = document.querySelectorAll(".column");

  columns.forEach(function (column) {
    column.addEventListener("dragover", allowDrop);
    column.addEventListener("drop", drop);

    column.addEventListener("dragenter", function () {
      column.classList.add("over");
    });

    column.addEventListener("dragleave", function () {
      column.classList.remove("over");
    });
  });
}

// Initialize on page load
document.addEventListener("DOMContentLoaded", function () {
  setupDragAndDrop();

  // Example: Add a new task card
  const todoColumn = document.querySelector("#todo");
  const newCard = createTaskCard("task3", "New Task");
  todoColumn.appendChild(newCard);
});
```
