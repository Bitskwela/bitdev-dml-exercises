# Forms and User Input Activity

## Initial Code

```js
// Task 1: Handle Form Submission
function setupFormSubmit() {
  // Add your code here
}

// Task 2: Get Input Value
function getInputValue(inputId) {
  // Add your code here
}

// Task 3: Real-time Input Validation
function setupValidation() {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Form Elements, Submit Events, `event.preventDefault()`, `.value` Property, Input Event Listeners

---

### Task 1: Handle Form Submission

Create a function that selects a form with id `userForm` and adds a submit event listener. When the form is submitted, prevent the default behavior and display an alert saying "Form submitted successfully!".

```js
function setupFormSubmit() {
  const form = document.querySelector("#userForm");

  form.addEventListener("submit", function (event) {
    event.preventDefault();
    alert("Form submitted successfully!");
  });
}
```

---

### Task 2: Get Input Value

Create a function that takes an input element's id as a parameter and returns the current value entered in that input field.

```js
function getInputValue(inputId) {
  const inputElement = document.querySelector(`#${inputId}`);
  return inputElement.value;
}
```

---

### Task 3: Real-time Input Validation

Create a function that sets up real-time validation for an input with id `emailInput`. Add an `input` event listener that checks if the entered value contains the "@" symbol. If it doesn't, update the text of an element with id `errorMessage` to "Please enter a valid email". If it does contain "@", clear the error message.

```js
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

---

## Breakdown of the Activity

**Variables Defined:**

- `form`: A reference to the form element with id `userForm`. Used to attach a submit event listener.

- `event`: The event object automatically passed to event handler functions. Contains information about the event and methods like `preventDefault()`.

- `inputId`: A string parameter representing the id of the input element to retrieve the value from.

- `inputElement`: A reference to the input element selected using the provided id.

- `emailInput`: A reference to the email input field. Used to listen for input changes and read the current value.

- `errorMessage`: A reference to the element that displays validation error messages.

- `email`: A variable storing the current value of the email input, used to check for the "@" symbol.

**Key Concepts:**

- Form Elements:
  HTML forms contain input fields, buttons, and other controls for collecting user data. Forms can be selected and manipulated using JavaScript.

- Submit Event:
  Triggered when a form is submitted (via button click or Enter key). The event handler can process or validate data before submission.

- `event.preventDefault()`:
  Stops the default browser behavior for an event. For forms, it prevents the page from reloading when submitted, allowing JavaScript to handle the data.

- `.value` Property:
  Accesses or sets the current value of an input element. For text inputs, it returns the string the user has typed.

- Input Event:
  Fires immediately whenever the value of an input changes (on every keystroke). Useful for real-time validation and feedback.

- `includes()` Method:
  A string method that checks if a string contains a specified substring. Returns `true` or `false`.

**Key Functions:**

- `setupFormSubmit()`:
  Demonstrates handling form submissions with `addEventListener("submit", ...)` and preventing default behavior to process data with JavaScript.

- `getInputValue(inputId)`:
  Shows how to dynamically select an input element using template literals and retrieve its value using the `.value` property.

- `setupValidation()`:
  Combines input event listeners with conditional logic to provide real-time feedback as the user types.
