# DOM Manipulation Activity

## Initial Code

```js
// Task 1: Select and Update Text Content
function updateWelcomeMessage(username) {
  // Add your code here
}

// Task 2: Add Click Event Listener
function setupClickHandler() {
  // Add your code here
}

// Task 3: Toggle Element Visibility
function setupToggle() {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `document.querySelector`, `innerText`, `addEventListener`, DOM Events, `style.display`

---

### Task 1: Select and Update Text Content

Create a function that selects an element with the id `welcome` using `document.querySelector` and updates its text content to display "Welcome, [username]!" where `[username]` is the parameter passed to the function.

```js
function updateWelcomeMessage(username) {
  const welcomeElement = document.querySelector("#welcome");
  welcomeElement.innerText = `Welcome, ${username}!`;
}
```

---

### Task 2: Add Click Event Listener

Create a function that selects a button with the id `alertBtn` and adds a click event listener. When the button is clicked, it should change the text content of an element with id `status` to "Button was clicked!".

```js
function setupClickHandler() {
  const alertBtn = document.querySelector("#alertBtn");
  const statusElement = document.querySelector("#status");

  alertBtn.addEventListener("click", function () {
    statusElement.innerText = "Button was clicked!";
  });
}
```

---

### Task 3: Toggle Element Visibility

Create a function that sets up a toggle button. When the button with id `toggleBtn` is clicked, it should show or hide the element with id `content` by changing its `display` style property between "none" and "block".

```js
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

---

## Breakdown of the Activity

**Variables Defined:**

- `welcomeElement`: A reference to the DOM element with id `welcome`. Selected using `document.querySelector("#welcome")` and used to update text content.

- `username`: A string parameter representing the user's name to be displayed in the welcome message.

- `alertBtn`: A reference to the button element with id `alertBtn`. Used to attach a click event listener.

- `statusElement`: A reference to the DOM element with id `status`. Its text content is updated when the button is clicked.

- `toggleBtn`: A reference to the toggle button element. Used to listen for click events to toggle visibility.

- `contentElement`: A reference to the content element whose visibility is toggled. Its `style.display` property is modified.

**Key Concepts:**

- `document.querySelector`:
  A method that selects the first element matching a CSS selector. Use `#` for ids (e.g., `#welcome`), `.` for classes (e.g., `.item`), or tag names (e.g., `div`).

- `innerText`:
  A property that gets or sets the visible text content of an element. When you assign a value, it replaces all the text inside the element.

- `addEventListener`:
  A method that attaches an event handler to an element. Takes two arguments: the event type (e.g., "click") and a callback function that runs when the event occurs.

- DOM Events:
  Actions triggered by user interactions (click, hover, input) or browser events. The callback function can access event details through the `event` parameter.

- `style.display`:
  A property that controls whether an element is visible. Setting it to "none" hides the element, while "block" makes it visible.

**Key Functions:**

- `updateWelcomeMessage(username)`:
  Demonstrates selecting an element by id and updating its text content using `innerText` with template literals.

- `setupClickHandler()`:
  Shows how to select elements and attach a click event listener that modifies another element's content when triggered.

- `setupToggle()`:
  Combines event listeners with conditional logic to toggle an element's visibility using the `style.display` property.
