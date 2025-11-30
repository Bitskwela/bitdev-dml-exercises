# Quiz 31: Event Handling

Test your understanding of JavaScript event handling!

---

## Quiz 1

### Question 1
What is the best way to add an event listener to an element?

A) `<button onclick="myFunc()">Click</button>`  
B) `element.onclick = function() {}`  
C) `element.addEventListener('click', function() {})`  
D) All are equally good

**Answer: C**

`addEventListener()` is best because it allows multiple listeners, easy removal, and cleaner separation of HTML and JavaScript.

---

### Question 2
What does `event.preventDefault()` do?

A) Removes the event listener  
B) Stops the event from bubbling  
C) Prevents the default browser action  
D) Deletes the element

**Answer: C**

`event.preventDefault()` prevents the default browser action (e.g., form submission, link navigation, checkbox toggle).

---

### Question 3
Which event fires when a user types in an input field?

A) `change`  
B) `input`  
C) `keypress`  
D) B and C

**Answer: D**

Both `input` and `keypress` events fire when typing. `input` is recommended as it works with all input types.

---

### Question 4
What is `event.target`?

A) The element that triggered the event  
B) The parent element  
C) The event type  
D) The event listener function

**Answer: A**

`event.target` is the element that triggered the event (e.g., the button that was clicked).

---

### Question 5
How do you stop a form from submitting and reloading the page?

A) `form.stop()`  
B) `event.preventDefault()` in submit handler  
C) `return false`  
D) Remove the submit button

**Answer: B**

Use `event.preventDefault()` in the submit event handler to stop form submission and handle it with JavaScript instead.

---

## Quiz 2

### Question 6
What's the difference between `input` and `change` events?

A) No difference  
B) `input` fires as you type, `change` fires when you leave the field  
C) `change` is for text, `input` is for numbers  
D) `input` is older

**Answer: B**

`input` fires as you type (real-time), while `change` fires when you leave the field (blur). Use `input` for live validation.

---

### Question 7
Which event detects when mouse enters an element?

A) `mouseenter` or `mouseover`  
B) `hover`  
C) `mouseenter`  
D) `mousein`

**Answer: A**

Both `mouseenter` and `mouseover` detect when mouse enters an element. `mouseenter` doesn't bubble, making it often preferred.

---

### Question 8
What does this code do?
```javascript
let buttons = document.querySelectorAll('button');
buttons.forEach(btn => {
    btn.addEventListener('click', () => alert('Clicked!'));
});
```

A) Adds click event to first button only  
B) Adds click event to all buttons  
C) Creates new buttons  
D) Error

**Answer: B**

This code adds a click event listener to all buttons on the page using `forEach()` to loop through the NodeList.

---

### Question 9
How do you get the value from an input field in an event handler?

A) `element.value`  
B) `element.textContent`  
C) `element.innerHTML`  
D) `event.value`

**Answer: A**

Use `element.value` to get the value from input fields (text, number, email, etc.).

---

### Question 10
What's the correct way to remove an event listener?

A) `element.removeEventListener('click', functionName)`  
B) `element.removeEvent('click')`  
C) `element.clearEvents()`  
D) Not possible

**Answer: A**

Use `element.removeEventListener('click', functionName)` with the exact same function reference used when adding the listener.

---

## Detailed Explanations

### Question 1: Best way to add event listeners
**Answer: C - `element.addEventListener('click', function() {}')`**

**Why addEventListener is best:**

**Allows multiple listeners:**
```javascript
button.addEventListener('click', function1);
button.addEventListener('click', function2);
// Both run when clicked
```

**Easy to remove:**
```javascript
button.removeEventListener('click', function1);
```

**Cleaner separation:**
```javascript
// HTML
<button id="btn">Click</button>

// JavaScript
document.querySelector('#btn').addEventListener('click', () => {
    console.log('Clicked!');
});
```

**Bad practices:**
```html
<!-- Inline (avoid) -->
<button onclick="alert('Hi')">Click</button>

<!-- Property assignment (limited) -->
<script>
button.onclick = function() { alert('Hi'); };
</script>
```

---

### Question 2: event.preventDefault()
**Answer: C - Prevents the default browser action**

**Common uses:**

**1. Stop form submission:**
```javascript
form.addEventListener('submit', function(event) {
    event.preventDefault();  // Don't reload page
    // Handle with JavaScript
});
```

**2. Stop link navigation:**
```javascript
link.addEventListener('click', function(event) {
    event.preventDefault();  // Don't navigate
    // Do something else
});
```

**3. Stop checkbox toggle:**
```javascript
checkbox.addEventListener('click', function(event) {
    event.preventDefault();  // Don't check/uncheck
    // Custom logic
});
```

**Barangay form:**
```html
<form id="serviceForm">
    <input type="text" id="name">
    <button type="submit">Submit</button>
</form>

<script>
document.querySelector('#serviceForm').addEventListener('submit', function(event) {
    event.preventDefault();  // Critical!
    
    let name = document.querySelector('#name').value;
    console.log('Processing:', name);
    // Handle without page reload
});
</script>
```

---

### Question 3: Input typing events
**Answer: D - Both `input` and `keypress`**

**`input` event (recommended):**
```javascript
input.addEventListener('input', function() {
    console.log('Current value:', input.value);
});
// Fires on every character typed
```

**`keypress` event:**
```javascript
input.addEventListener('keypress', function(event) {
    console.log('Key pressed:', event.key);
});
```

**Barangay search:**
```html
<input type="text" id="search" placeholder="Search residents...">
<div id="results"></div>

<script>
let search = document.querySelector('#search');
let results = document.querySelector('#results');

search.addEventListener('input', function() {
    let query = search.value;
    results.textContent = 'Searching for: ' + query;
});
</script>
```

---

### Question 4: event.target
**Answer: A - The element that triggered the event**

**Example:**
```html
<button id="btn1">Button 1</button>
<button id="btn2">Button 2</button>

<script>
document.querySelector('#btn1').addEventListener('click', function(event) {
    console.log(event.target);  // <button id="btn1">
    console.log(event.target.id);  // "btn1"
});
</script>
```

**Barangay service buttons:**
```html
<button class="service-btn" data-service="clearance">Clearance</button>
<button class="service-btn" data-service="residency">Residency</button>
<button class="service-btn" data-service="indigency">Indigency</button>

<script>
let buttons = document.querySelectorAll('.service-btn');

buttons.forEach(button => {
    button.addEventListener('click', function(event) {
        let service = event.target.dataset.service;
        console.log('Selected:', service);
    });
});
</script>
```

---

### Question 5: Prevent form submission
**Answer: B - `event.preventDefault()` in submit handler**

**Complete example:**
```html
<form id="applicationForm">
    <input type="text" id="name" required>
    <input type="number" id="age" required>
    <button type="submit">Submit</button>
</form>
<div id="result"></div>

<script>
let form = document.querySelector('#applicationForm');
let result = document.querySelector('#result');

form.addEventListener('submit', function(event) {
    event.preventDefault();  // Stop page reload!
    
    let name = document.querySelector('#name').value;
    let age = document.querySelector('#age').value;
    
    result.innerHTML = `
        <h3>Application Received</h3>
        <p>Name: ${name}</p>
        <p>Age: ${age}</p>
    `;
    
    form.reset();
});
</script>
```

---

### Question 6: input vs change events
**Answer: B - `input` fires as you type, `change` fires when you leave the field**

**`input` - fires immediately:**
```html
<input type="text" id="realtime">
<p id="display"></p>

<script>
document.querySelector('#realtime').addEventListener('input', function() {
    document.querySelector('#display').textContent = this.value;
    // Updates as you type
});
</script>
```

**`change` - fires when done editing:**
```html
<input type="text" id="delayed">

<script>
document.querySelector('#delayed').addEventListener('change', function() {
    console.log('Final value:', this.value);
    // Only fires when you click away or press Enter
});
</script>
```

**Use cases:**
- `input`: Real-time search, character counter, live validation
- `change`: Final value needed, dropdown selection, checkbox toggle

---

### Question 7: Mouse hover events
**Answer: A - `mouseenter` or `mouseover`**

**Both work similarly:**
```html
<div id="box" style="width: 200px; height: 200px; background: lightblue;">
    Hover me
</div>

<script>
let box = document.querySelector('#box');

box.addEventListener('mouseenter', function() {
    box.style.backgroundColor = 'lightgreen';
});

box.addEventListener('mouseleave', function() {
    box.style.backgroundColor = 'lightblue';
});
</script>
```

**Barangay service card hover:**
```html
<style>
.service-card {
    padding: 20px;
    border: 2px solid #ddd;
    transition: all 0.3s;
}
</style>

<div class="service-card">
    <h3>Barangay Clearance</h3>
    <p>Fee: ₱50</p>
</div>

<script>
let card = document.querySelector('.service-card');

card.addEventListener('mouseenter', function() {
    card.style.borderColor = '#007bff';
    card.style.backgroundColor = '#f0f8ff';
});

card.addEventListener('mouseleave', function() {
    card.style.borderColor = '#ddd';
    card.style.backgroundColor = 'white';
});
</script>
```

---

### Question 8: Adding events to multiple elements
```javascript
let buttons = document.querySelectorAll('button');
buttons.forEach(btn => {
    btn.addEventListener('click', () => alert('Clicked!'));
});
```

**Answer: B - Adds click event to all buttons**

**Explanation:**
1. Select all button elements
2. Loop through each button
3. Add click listener to each one

**Barangay service selector:**
```html
<button class="service">Clearance</button>
<button class="service">Residency</button>
<button class="service">Indigency</button>

<script>
let services = document.querySelectorAll('.service');

services.forEach(button => {
    button.addEventListener('click', function() {
        alert('You selected: ' + button.textContent);
    });
});
</script>
```

---

### Question 9: Getting input value
**Answer: A - `element.value`**

**Correct way:**
```html
<input type="text" id="name" value="Juan">

<script>
let input = document.querySelector('#name');
console.log(input.value);  // "Juan"
</script>
```

**Wrong ways:**
```javascript
input.textContent  // undefined (inputs don't use textContent)
input.innerHTML    // undefined (inputs don't have innerHTML)
event.value        // undefined (event object doesn't have value)
```

**Barangay form:**
```html
<input type="text" id="residentName" placeholder="Enter name">
<input type="number" id="residentAge" placeholder="Enter age">
<button id="submitBtn">Submit</button>

<script>
document.querySelector('#submitBtn').addEventListener('click', function() {
    let name = document.querySelector('#residentName').value;
    let age = document.querySelector('#residentAge').value;
    
    console.log('Name:', name);
    console.log('Age:', age);
});
</script>
```

---

### Question 10: Removing event listeners
**Answer: A - `element.removeEventListener('click', functionName)`**

**Requires named function:**
```javascript
function handleClick() {
    console.log('Clicked');
}

// Add
button.addEventListener('click', handleClick);

// Remove
button.removeEventListener('click', handleClick);
```

**Won't work with anonymous functions:**
```javascript
// Can't remove this
button.addEventListener('click', function() {
    console.log('Clicked');
});
```

**Barangay one-time button:**
```html
<button id="registerBtn">Register (One Time Only)</button>

<script>
let button = document.querySelector('#registerBtn');

function handleRegistration() {
    alert('Registered!');
    
    // Remove listener after first click
    button.removeEventListener('click', handleRegistration);
    button.disabled = true;
    button.textContent = 'Already Registered';
}

button.addEventListener('click', handleRegistration);
</script>
```

---

**Event Handling Cheat Sheet:**

**Common Events:**
```javascript
element.addEventListener('click', handler);
element.addEventListener('input', handler);
element.addEventListener('change', handler);
element.addEventListener('submit', handler);
element.addEventListener('mouseover', handler);
```

**Event Object:**
```javascript
function handler(event) {
    event.target          // Element that triggered
    event.preventDefault() // Stop default action
    event.stopPropagation() // Stop event bubbling
}
```

**Form Handling:**
```javascript
form.addEventListener('submit', function(event) {
    event.preventDefault();
    let value = input.value;
    // Process data
});
```

**Great job!** Your pages are now interactive!

---
