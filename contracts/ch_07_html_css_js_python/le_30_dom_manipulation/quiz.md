# Quiz 30: DOM Manipulation

Test your understanding of selecting and manipulating HTML elements with JavaScript!

---

## Quiz 1

### Question 1
What does DOM stand for?

A) Document Object Model  
B) Data Object Management  
C) Display Output Method  
D) Digital Online Module

**Answer: A**

DOM stands for Document Object Model - a programming interface that represents HTML documents as a tree structure that JavaScript can manipulate.

---

### Question 2
How do you select an element with id="header"?

A) `document.querySelector('header')`  
B) `document.querySelector('#header')`  
C) `document.querySelector('.header')`  
D) `document.getElementById('header')` or B

**Answer: D**

Both `document.getElementById('header')` and `document.querySelector('#header')` work. Use querySelector for flexibility with CSS selectors.

---

### Question 3
What's the difference between `textContent` and `innerHTML`?

A) No difference  
B) `textContent` treats input as plain text, `innerHTML` interprets HTML  
C) `innerHTML` is faster  
D) `textContent` doesn't work

**Answer: B**

`textContent` treats input as plain text (safe), while `innerHTML` interprets HTML tags (can be dangerous with user input).

---

### Question 4
What is the output?
```javascript
let box = document.querySelector('#box');
box.textContent = 'Hello';
console.log(box.textContent);
```

A) `undefined`  
B) `'Hello'`  
C) `#box`  
D) Error

**Answer: B**

The output is `'Hello'` because we set `textContent` to 'Hello' and then logged it.

---

### Question 5
How do you add a CSS class to an element?

A) `element.class.add('active')`  
B) `element.classList.add('active')`  
C) `element.addClass('active')`  
D) `element.class = 'active'`

**Answer: B**

Use `element.classList.add('active')` to add a CSS class to an element.

---

## Quiz 2

### Question 6
What does this code do?
```javascript
let div = document.createElement('div');
div.textContent = 'New content';
document.body.appendChild(div);
```

A) Selects existing div  
B) Creates new div and adds to page  
C) Removes div from page  
D) Changes existing div

**Answer: B**

This creates a new `<div>` element, sets its text, and appends it to the page body.

---

### Question 7
How do you change the background color of an element?

A) `element.style.background-color = 'red'`  
B) `element.style.backgroundColor = 'red'`  
C) `element.background = 'red'`  
D) `element.color = 'red'`

**Answer: B**

Use camelCase for CSS properties in JavaScript: `element.style.backgroundColor = 'red'`.

---

### Question 8
What does `querySelectorAll()` return?

A) Single element  
B) Array  
C) NodeList (array-like)  
D) String

**Answer: C**

`querySelectorAll()` returns a NodeList (array-like collection) of all matching elements.

---

### Question 9
How do you remove an element from the page?

A) `element.delete()`  
B) `element.remove()`  
C) `element.hide()`  
D) `element.destroy()`

**Answer: B**

Use `element.remove()` to remove an element from the DOM.

---

### Question 10
What is the correct way to check if an element has a class?

A) `element.hasClass('active')`  
B) `element.classList.has('active')`  
C) `element.classList.contains('active')`  
D) `element.class.includes('active')`

**Answer: C**

Use `element.classList.contains('active')` to check if an element has a specific class.

---

## Detailed Explanations

### Question 1: DOM Definition
**Answer: A - Document Object Model**

**Explanation:**
The **DOM (Document Object Model)** is a programming interface that represents HTML documents as a tree structure that JavaScript can manipulate.

**DOM Tree Example:**
```
document
  └── html
      ├── head
      │   └── title
      └── body
          ├── h1
          ├── div
          └── p
```

**Why it matters:**
- Allows JavaScript to access HTML elements
- Makes pages interactive
- Updates content dynamically without page reload

---

### Question 2: Selecting by ID
**Answer: D - Both work (`document.getElementById('header')` or `document.querySelector('#header')`)**

**Explanation:**

**Method 1: querySelector (modern, flexible)**
```javascript
let header = document.querySelector('#header');
```

**Method 2: getElementById (older, specific)**
```javascript
let header = document.getElementById('header');
```

**Key differences:**
- `querySelector`: Use CSS selector syntax, more flexible
- `getElementById`: Faster for ID-only, no `#` needed

**Barangay example:**
```html
<div id="officeStatus">Open</div>

<script>
// Both work
let status1 = document.querySelector('#officeStatus');
let status2 = document.getElementById('officeStatus');

console.log(status1.textContent);  // Open
console.log(status2.textContent);  // Open
</script>
```

**querySelector is recommended** for consistency (works with classes, IDs, tags).

---

### Question 3: textContent vs innerHTML
**Answer: B - `textContent` treats input as plain text, `innerHTML` interprets HTML**

**Explanation:**

**textContent (safe, plain text):**
```javascript
let div = document.querySelector('#box');
div.textContent = '<strong>Bold</strong>';
// Displays: <strong>Bold</strong> (as text)
```

**innerHTML (interprets HTML):**
```javascript
let div = document.querySelector('#box');
div.innerHTML = '<strong>Bold</strong>';
// Displays: Bold (rendered as HTML)
```

**Security consideration:**
```javascript
// DANGEROUS with user input
let userInput = '<script>alert("Hacked!")</script>';
div.innerHTML = userInput;  // Script executes!

// SAFE with user input
div.textContent = userInput;  // Displays as text
```

**Barangay form:**
```html
<div id="visitorName"></div>

<script>
let name = "Juan <Dela Cruz>";  // User input with <>

// Safe - displays: Juan <Dela Cruz>
document.querySelector('#visitorName').textContent = name;

// Unsafe - might break or cause XSS
// document.querySelector('#visitorName').innerHTML = name;
</script>
```

---

### Question 4: Reading textContent
```javascript
let box = document.querySelector('#box');
box.textContent = 'Hello';
console.log(box.textContent);
```

**Answer: B - `'Hello'`**

**Explanation:**
1. Select element
2. Set textContent to `'Hello'`
3. Read textContent back
4. Output: `'Hello'`

**Barangay status update:**
```html
<div id="status">Closed</div>

<script>
let status = document.querySelector('#status');

// Change text
status.textContent = 'Open';

// Read current text
console.log(status.textContent);  // 'Open'
</script>
```

---

### Question 5: Adding CSS class
**Answer: B - `element.classList.add('active')`**

**Explanation:**

**Correct way:**
```javascript
element.classList.add('active');
```

**classList methods:**
```javascript
element.classList.add('active');      // Add class
element.classList.remove('active');   // Remove class
element.classList.toggle('active');   // Toggle on/off
element.classList.contains('active'); // Check if has class
```

**Barangay service status:**
```html
<style>
.available { background-color: green; color: white; }
.unavailable { background-color: red; color: white; }
</style>

<div id="service">Barangay Clearance</div>

<script>
let service = document.querySelector('#service');

// Office open
service.classList.add('available');

// Office closed
service.classList.remove('available');
service.classList.add('unavailable');
</script>
```

---

### Question 6: Creating and appending elements
```javascript
let div = document.createElement('div');
div.textContent = 'New content';
document.body.appendChild(div);
```

**Answer: B - Creates new div and adds to page**

**Explanation:**
1. `createElement('div')`: Create new `<div>` element (not yet on page)
2. `textContent = 'New content'`: Add text to div
3. `appendChild(div)`: Add div to page body

**Barangay visitor list:**
```html
<ul id="visitorList"></ul>

<script>
let list = document.querySelector('#visitorList');

let visitors = ['Juan', 'Maria', 'Pedro'];

for (let name of visitors) {
    // Create new list item
    let li = document.createElement('li');
    li.textContent = name;
    
    // Add to list
    list.appendChild(li);
}
</script>
```

**Result:**
```html
<ul id="visitorList">
    <li>Juan</li>
    <li>Maria</li>
    <li>Pedro</li>
</ul>
```

---

### Question 7: Changing background color
**Answer: B - `element.style.backgroundColor = 'red'`**

**Explanation:**

**Correct (camelCase):**
```javascript
element.style.backgroundColor = 'red';
```

**CSS to JavaScript naming:**
- `background-color` → `backgroundColor`
- `font-size` → `fontSize`
- `border-radius` → `borderRadius`

**Barangay status indicator:**
```html
<div id="status">Office Status</div>

<script>
let status = document.querySelector('#status');

// Open (green)
status.style.backgroundColor = 'green';
status.style.color = 'white';
status.style.padding = '10px';
status.style.textAlign = 'center';

// Closed (red)
// status.style.backgroundColor = 'red';
</script>
```

---

### Question 8: querySelectorAll return type
**Answer: C - NodeList (array-like)**

**Explanation:**

**Returns NodeList:**
```javascript
let boxes = document.querySelectorAll('.box');
console.log(boxes);  // NodeList [div.box, div.box, div.box]
console.log(boxes.length);  // 3
```

**NodeList is array-like:**
```javascript
// Can use length
console.log(boxes.length);

// Can use index
console.log(boxes[0]);

// Can use forEach
boxes.forEach(box => {
    box.style.color = 'red';
});

// Can convert to array
let arrayBoxes = Array.from(boxes);
```

**Barangay services:**
```html
<div class="service">Clearance</div>
<div class="service">Residency</div>
<div class="service">Indigency</div>

<script>
let services = document.querySelectorAll('.service');

console.log(services.length);  // 3

services.forEach((service, index) => {
    service.textContent = `${index + 1}. ${service.textContent}`;
});
</script>
```

---

### Question 9: Removing elements
**Answer: B - `element.remove()`**

**Explanation:**

**Modern way:**
```javascript
let element = document.querySelector('#warning');
element.remove();
```

**Older way (still works):**
```javascript
let element = document.querySelector('#warning');
element.parentNode.removeChild(element);
```

**Barangay announcement:**
```html
<div id="tempAnnouncement">
    Office closed for maintenance
</div>

<script>
// Remove after 5 seconds
setTimeout(() => {
    let announcement = document.querySelector('#tempAnnouncement');
    announcement.remove();
}, 5000);
</script>
```

---

### Question 10: Checking for class
**Answer: C - `element.classList.contains('active')`**

**Explanation:**

**Correct method:**
```javascript
if (element.classList.contains('active')) {
    console.log('Element is active');
}
```

**Barangay service checker:**
```html
<div id="service" class="available urgent">
    Barangay Clearance
</div>

<script>
let service = document.querySelector('#service');

// Check classes
console.log(service.classList.contains('available'));  // true
console.log(service.classList.contains('urgent'));     // true
console.log(service.classList.contains('closed'));     // false

// Conditional logic
if (service.classList.contains('urgent')) {
    service.style.border = '3px solid red';
}
</script>
```

---

**DOM Manipulation Cheat Sheet:**

**Selecting:**
```javascript
document.querySelector('#id')
document.querySelector('.class')
document.querySelectorAll('.class')
```

**Modifying:**
```javascript
element.textContent = 'text'
element.innerHTML = '<p>HTML</p>'
element.style.color = 'red'
element.setAttribute('src', 'image.jpg')
```

**Classes:**
```javascript
element.classList.add('class')
element.classList.remove('class')
element.classList.toggle('class')
element.classList.contains('class')
```

**Creating:**
```javascript
let el = document.createElement('div')
parent.appendChild(el)
element.remove()
```

**Great job!** You can now control web pages with JavaScript!

---
