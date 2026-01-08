# Chapter 6 Quiz: JavaScript Mini Projects

```json
[
  {
    "id": 1,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The event that fires when a user leaves the page" },
      { "id": "b", "text": "The event that fires when a form is submitted" },
      { "id": "c", "text": "The event that fires when an input value changes" },
      { "id": "d", "text": "The event that fires when a button is created" }
    ],
    "question": "In a form-based project like a calculator, what is the 'submit' event used for?"
  },
  {
    "id": 2,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "event.preventDefault()" },
      { "id": "b", "text": "event.stopPropagation()" },
      { "id": "c", "text": "event.returnValue = false" },
      { "id": "d", "text": "return false" }
    ],
    "question": "Which method prevents a form from submitting and reloading the page?"
  },
  {
    "id": 3,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "In a mini project, you can use querySelector to select form input elements."
  },
  {
    "id": 4,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "element.innerHTML" },
      { "id": "b", "text": "element.textContent" },
      { "id": "c", "text": "element.value" },
      { "id": "d", "text": "All of the above" }
    ],
    "question": "Which of these can be used to get or set content in a DOM element?"
  },
  {
    "id": 5,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "The .value property is used to get text content from div elements."
  },
  {
    "id": 6,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "element.hide()" },
      { "id": "b", "text": "element.visible = false" },
      { "id": "c", "text": "element.style.display = 'none'" },
      { "id": "d", "text": "element.remove()" }
    ],
    "question": "How do you hide an element in JavaScript without removing it from the DOM?"
  },
  {
    "id": 7,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "array[array.length - 1]" },
      { "id": "b", "text": "array.pop()" },
      { "id": "c", "text": "array.shift()" },
      { "id": "d", "text": "array.slice(-1)" }
    ],
    "question": "Which method both accesses AND removes the last element of an array?"
  },
  {
    "id": 8,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "The .push() method adds elements to the end of an array."
  },
  {
    "id": 9,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "parseFloat()" },
      { "id": "b", "text": "parseInt()" },
      { "id": "c", "text": "toString()" },
      { "id": "d", "text": "toNumber()" }
    ],
    "question": "Which function converts a string to a decimal number in a calculator project?"
  },
  {
    "id": 10,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "parseInt() will always return a whole number, even if the string contains decimal points."
  },
  {
    "id": 11,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It stores the current price of items" },
      { "id": "b", "text": "It prevents users from changing values" },
      {
        "id": "c",
        "text": "It stores key-value pairs for item names and prices"
      },
      { "id": "d", "text": "It is used for HTML structure only" }
    ],
    "question": "In a POS calculator project, what is the purpose of using an object to store item data?"
  },
  {
    "id": 12,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "object.keys()" },
      { "id": "b", "text": "object.values()" },
      { "id": "c", "text": "object.entries()" },
      { "id": "d", "text": "object.items()" }
    ],
    "question": "Which method returns an array of all values in an object?"
  },
  {
    "id": 13,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "You can calculate the sum of array elements using the reduce() method."
  },
  {
    "id": 14,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "element.innerHTML += newContent" },
      { "id": "b", "text": "element.innerHTML = newContent" },
      { "id": "c", "text": "element.append(newContent)" },
      {
        "id": "d",
        "text": "element.insertAdjacentHTML('beforeend', newContent)"
      }
    ],
    "question": "How do you add content to an element without replacing existing content?"
  },
  {
    "id": 15,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "The 'change' event fires on an input element every time a keystroke occurs."
  },
  {
    "id": 16,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Preventing the default form submission" },
      { "id": "b", "text": "Checking if input values are valid" },
      { "id": "c", "text": "All of the above" },
      { "id": "d", "text": "None of the above" }
    ],
    "question": "What is required when handling form submissions in a mini project?"
  },
  {
    "id": 17,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Check if the input is empty" },
      { "id": "b", "text": "Check if the input is a valid number" },
      { "id": "c", "text": "Check if the input is in the correct format" },
      { "id": "d", "text": "All of the above" }
    ],
    "question": "In a calculator project, what validation might you perform on user inputs?"
  },
  {
    "id": 18,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Conditional statements (if/else) are essential for validating and processing data in mini projects."
  },
  {
    "id": 19,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "filter()" },
      { "id": "b", "text": "map()" },
      { "id": "c", "text": "reduce()" },
      { "id": "d", "text": "find()" }
    ],
    "question": "Which array method is best for finding items that match a specific criteria in a project?"
  },
  {
    "id": 20,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "You can use template literals to dynamically create HTML content in a mini project."
  },
  {
    "id": 21,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "To add CSS styling directly" },
      { "id": "b", "text": "To select multiple elements" },
      { "id": "c", "text": "To store data and calculate totals" },
      { "id": "d", "text": "To display HTML only" }
    ],
    "question": "What is the primary purpose of using arrays in a tracking or logging project?"
  },
  {
    "id": 22,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "element.click()" },
      { "id": "b", "text": "element.addEventListener('click', function)" },
      { "id": "c", "text": "element.onclick = function" },
      { "id": "d", "text": "Both B and C" }
    ],
    "question": "What is the modern way to attach a click event handler to an element?"
  },
  {
    "id": 23,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Using inline HTML event attributes (like onclick) is the best practice in modern JavaScript projects."
  },
  {
    "id": 24,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "It accumulates a single value from all array elements"
      },
      { "id": "b", "text": "It returns a new array with filtered elements" },
      {
        "id": "c",
        "text": "It returns the first element that matches a condition"
      },
      { "id": "d", "text": "It removes elements from the array" }
    ],
    "question": "What does the reduce() method do in JavaScript?"
  },
  {
    "id": 25,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "When the page loads" },
      { "id": "b", "text": "When a button is clicked" },
      { "id": "c", "text": "When form data is submitted" },
      { "id": "d", "text": "All of the above" }
    ],
    "question": "When should you update the DOM in a mini project?"
  },
  {
    "id": 26,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Calculating totals and amounts" },
      { "id": "b", "text": "Matching or comparing items based on criteria" },
      { "id": "c", "text": "Storing temporary data" },
      { "id": "d", "text": "Creating HTML elements" }
    ],
    "question": "In a job matching portal, what would be the primary use of filter()?"
  },
  {
    "id": 27,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "LocalStorage can be used to persist data across browser sessions in a mini project."
  },
  {
    "id": 28,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Check if the required field is not empty" },
      { "id": "b", "text": "Check if the value is a string" },
      { "id": "c", "text": "Check if the value is an object" },
      { "id": "d", "text": "Check if the value is displayed on screen" }
    ],
    "question": "What is basic validation for a required input field in a form?"
  },
  {
    "id": 29,
    "type": "FIB",
    "answer": "event listener",
    "points": 1,
    "question": "An ______ is attached to a DOM element to detect and respond to user interactions like clicks."
  },
  {
    "id": 30,
    "type": "FIB",
    "answer": "DOM manipulation",
    "points": 1,
    "question": "______ is the process of changing, adding, or removing elements and content from the HTML document using JavaScript."
  }
]
```
