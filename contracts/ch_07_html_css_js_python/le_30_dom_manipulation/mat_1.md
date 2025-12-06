## Background Story

Tian stared at the browser console, watching their JavaScript code execute perfectly. Variables declared. Functions defined. Loops running. Conditional logic working flawlessly. Every `console.log()` statement printed exactly what they expected.

But the webpage itself? Completely unchanged. Still the same static HTML, displaying the same text, showing the same content. It was as if the JavaScript existed in a parallel dimension, running invisibly in the background while the visible page remained frozen in time.

"This is so frustrating!" Tian said, slamming their hands on the desk.

It was Sunday afternoon, week seven of their JavaScript journey. Tian and Rhea Joy were at Tian's house, working on their barangay website project. They'd learned variables, data types, operators, conditionals, loops, functions, arrays, and objects. They could write JavaScript that worked—the console proved it.

But they couldn't make their code affect the actual webpage.

Rhea Joy pulled up their project file—a form for barangay clearance applications. The HTML was clean. The CSS was polished. And there was JavaScript in a linked file, calculating the application fee based on the type of document requested. The calculation worked perfectly in the console.

But the result never appeared on the page.

"We're writing code that lives in a bubble," Rhea Joy said, echoing Tian's frustration. "Our JavaScript runs, does its thing, and then... nothing. The page doesn't know the JavaScript exists. How do other websites do it? When you click 'Like' on Facebook, the button changes color instantly. When you add items to your Shopee cart, the count updates in real-time. How do they connect JavaScript to the actual HTML elements?"

Tian opened Facebook in another tab, opened DevTools, and switched to the Console. They typed:

```javascript
document.querySelector('h1').textContent = 'HACKED!';
```

They pressed Enter. The Facebook logo at the top of the page instantly changed to the text "HACKED!" Tian's eyes widened.

"Wait. WHAT?!" Tian shouted. "How did that work?!"

Rhea Joy leaned in, equally shocked. "You just changed Facebook's page with JavaScript in the console!"

Tian frantically typed more commands:

```javascript
document.body.style.backgroundColor = 'pink';
document.querySelectorAll('p').forEach(p => p.style.color = 'red');
```

The entire Facebook page transformed—pink background, all paragraphs turned red. It was temporary (refreshing would restore everything), but the power was undeniable.

"This is it," Tian whispered. "This is the bridge. `document.querySelector`. That's how JavaScript talks to HTML. We've been writing code in isolation, but we never learned how to connect it to the DOM. That's the missing piece!"

Tian immediately called Kuya Miguel.

"Kuya! I just hacked Facebook!"

Miguel laughed. "Did you use `document.querySelector` in the console?"

"Yes! How did you know?!"

"Because every developer discovers DOM manipulation that way—by experimenting in the console on live websites. Congratulations, Tian. You just figured out the most important concept in client-side JavaScript: the Document Object Model. The DOM is the bridge between your JavaScript code and the HTML elements on the page. Without it, your code lives in a bubble. With it, you can control everything."

"Can you teach us properly?" Tian asked, excitement overtaking the earlier frustration. "We need to learn how to select elements, change text, modify styles, respond to clicks—all of it. That's what we've been missing."

"Absolutely," Miguel said. "Clear your afternoon. We're diving deep into DOM manipulation. By the end of today, your barangay form won't just calculate fees in the console—it'll display results directly on the page, respond to user input in real-time, and actually feel like a modern web application."

---

## Theory & Lecture Content

## What is the DOM?

**DOM (Document Object Model)** is a programming interface for HTML documents. It represents the page as a tree of objects that JavaScript can manipulate.

**HTML:**
```html
<!DOCTYPE html>
<html>
<head>
    <title>My Page</title>
</head>
<body>
    <h1>Hello World</h1>
    <p>Welcome</p>
</body>
</html>
```

**DOM Tree:**
```
document
  └── html
      ├── head
      │   └── title
      └── body
          ├── h1
          └── p
```

---

## Selecting Elements

### querySelector()
**Select first matching element:**

```javascript
// Select by tag
let heading = document.querySelector('h1');

// Select by class
let box = document.querySelector('.box');

// Select by ID
let header = document.querySelector('#header');
```

### querySelectorAll()
**Select all matching elements:**

```javascript
// Returns NodeList (array-like)
let allParagraphs = document.querySelectorAll('p');
let allBoxes = document.querySelectorAll('.box');
```

**Example:**
```html
<h1>Barangay Services</h1>
<p class="service">Clearance</p>
<p class="service">Residency</p>
<p class="service">Indigency</p>

<script>
let heading = document.querySelector('h1');
let allServices = document.querySelectorAll('.service');

console.log(heading);           // <h1>...</h1>
console.log(allServices.length); // 3
</script>
```

---

## Reading and Changing Text

### textContent
**Get or set text (ignores HTML):**

```html
<h1 id="title">Hello</h1>

<script>
let title = document.querySelector('#title');

// Read text
console.log(title.textContent);  // "Hello"

// Change text
title.textContent = "Welcome to Barangay";
</script>
```

### innerHTML
**Get or set HTML (interprets HTML tags):**

```html
<div id="content"></div>

<script>
let content = document.querySelector('#content');

// Set HTML
content.innerHTML = '<h2>Services</h2><p>Clearance: ₱50</p>';
</script>
```

**Barangay announcement:**
```html
<div id="announcement"></div>

<script>
let announcement = document.querySelector('#announcement');
announcement.innerHTML = `
    <h3>Office Hours</h3>
    <p>Monday-Friday: 8 AM - 5 PM</p>
    <p>Saturday: 8 AM - 12 PM</p>
    <p>Sunday: CLOSED</p>
`;
</script>
```

---

## Changing Attributes

### getAttribute() and setAttribute()

```html
<img id="logo" src="old.png" alt="Logo">

<script>
let logo = document.querySelector('#logo');

// Get attribute
console.log(logo.getAttribute('src'));  // "old.png"

// Set attribute
logo.setAttribute('src', 'new.png');
logo.setAttribute('alt', 'New Logo');
</script>
```

**Barangay ID card:**
```html
<img id="idPhoto" src="" alt="Resident Photo">

<script>
let idPhoto = document.querySelector('#idPhoto');
idPhoto.setAttribute('src', 'resident-juan.jpg');
idPhoto.setAttribute('alt', 'Juan Dela Cruz');
</script>
```

---

## Changing Styles

### style property

```html
<div id="box">Hello</div>

<script>
let box = document.querySelector('#box');

box.style.color = 'white';
box.style.backgroundColor = 'blue';  // Use camelCase!
box.style.padding = '20px';
box.style.fontSize = '24px';
</script>
```

**Important:** CSS properties use camelCase in JavaScript:
- `background-color` → `backgroundColor`
- `font-size` → `fontSize`
- `border-radius` → `borderRadius`

**Barangay status indicator:**
```html
<div id="status">Office Status</div>

<script>
let status = document.querySelector('#status');

// Office open
status.textContent = 'OPEN';
status.style.backgroundColor = 'green';
status.style.color = 'white';
status.style.padding = '10px';
status.style.textAlign = 'center';

// Office closed
// status.textContent = 'CLOSED';
// status.style.backgroundColor = 'red';
</script>
```

---

## Working with Classes

### classList

```html
<div id="box" class="container">Content</div>

<script>
let box = document.querySelector('#box');

// Add class
box.classList.add('active');

// Remove class
box.classList.remove('container');

// Toggle class (add if absent, remove if present)
box.classList.toggle('highlight');

// Check if has class
if (box.classList.contains('active')) {
    console.log('Box is active');
}
</script>
```

**CSS:**
```css
.highlight {
    background-color: yellow;
    border: 2px solid orange;
}

.active {
    font-weight: bold;
    color: blue;
}
```

**Barangay service status:**
```html
<style>
.service-box {
    padding: 15px;
    margin: 10px;
    border: 1px solid #ccc;
}

.available {
    background-color: #d4edda;
    border-color: #28a745;
}

.unavailable {
    background-color: #f8d7da;
    border-color: #dc3545;
}
</style>

<div id="clearanceService" class="service-box">
    Barangay Clearance
</div>

<script>
let service = document.querySelector('#clearanceService');

// Mark as available
service.classList.add('available');

// Later, mark as unavailable
// service.classList.remove('available');
// service.classList.add('unavailable');
</script>
```

---

## Creating New Elements

### createElement() and appendChild()

```html
<div id="container"></div>

<script>
let container = document.querySelector('#container');

// Create new element
let paragraph = document.createElement('p');
paragraph.textContent = 'This is new text';

// Add to page
container.appendChild(paragraph);
</script>
```

**Creating multiple elements:**
```html
<ul id="serviceList"></ul>

<script>
let list = document.querySelector('#serviceList');

let services = ['Clearance', 'Residency', 'Indigency', 'Permit'];

for (let service of services) {
    let listItem = document.createElement('li');
    listItem.textContent = service;
    list.appendChild(listItem);
}
</script>
```

**Result:**
```html
<ul id="serviceList">
    <li>Clearance</li>
    <li>Residency</li>
    <li>Indigency</li>
    <li>Permit</li>
</ul>
```

---

## Removing Elements

### remove()

```html
<div id="warning">This will be removed</div>

<script>
let warning = document.querySelector('#warning');
warning.remove();
</script>
```

### removeChild()

```html
<ul id="list">
    <li id="item1">Item 1</li>
    <li id="item2">Item 2</li>
</ul>

<script>
let list = document.querySelector('#list');
let item = document.querySelector('#item1');

list.removeChild(item);
</script>
```

---

## Complete Barangay Dashboard Example

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
        }
        
        .header {
            background-color: #007bff;
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: 5px;
        }
        
        .stats {
            display: flex;
            gap: 15px;
            margin: 20px 0;
        }
        
        .stat-box {
            flex: 1;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
        }
        
        .stat-box.visitors {
            background-color: #d4edda;
            border: 2px solid #28a745;
        }
        
        .stat-box.revenue {
            background-color: #fff3cd;
            border: 2px solid #ffc107;
        }
        
        .stat-box.pending {
            background-color: #f8d7da;
            border: 2px solid #dc3545;
        }
        
        .stat-number {
            font-size: 36px;
            font-weight: bold;
            margin: 10px 0;
        }
        
        .stat-label {
            color: #666;
            font-size: 14px;
        }
        
        #visitorList {
            list-style: none;
            padding: 0;
        }
        
        #visitorList li {
            background-color: #f8f9fa;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border-left: 4px solid #007bff;
        }
        
        .visitor-name {
            font-weight: bold;
            font-size: 18px;
        }
        
        .visitor-details {
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <h1 id="barangayName">Loading...</h1>
        <p id="dateTime">Loading...</p>
    </div>
    
    <!-- Statistics -->
    <div class="stats">
        <div class="stat-box visitors">
            <div class="stat-number" id="visitorCount">0</div>
            <div class="stat-label">Total Visitors</div>
        </div>
        <div class="stat-box revenue">
            <div class="stat-number" id="totalRevenue">₱0</div>
            <div class="stat-label">Total Revenue</div>
        </div>
        <div class="stat-box pending">
            <div class="stat-number" id="pendingCount">0</div>
            <div class="stat-label">Pending Services</div>
        </div>
    </div>
    
    <!-- Visitor List -->
    <h2>Today's Visitors</h2>
    <ul id="visitorList"></ul>
    
    <script>
        // Data
        const visitors = [
            { name: "Juan Dela Cruz", age: 25, service: "Clearance", fee: 50, status: "completed" },
            { name: "Maria Santos", age: 65, service: "Residency", fee: 24, status: "completed" },
            { name: "Pedro Reyes", age: 30, service: "Indigency", fee: 16, status: "pending" },
            { name: "Rosa Garcia", age: 70, service: "Clearance", fee: 40, status: "pending" }
        ];
        
        // Update header
        document.querySelector('#barangayName').textContent = 'San Juan Barangay Hall';
        document.querySelector('#dateTime').textContent = new Date().toLocaleDateString('en-PH', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
        
        // Calculate statistics
        let totalRevenue = 0;
        let pendingCount = 0;
        
        for (let visitor of visitors) {
            totalRevenue += visitor.fee;
            if (visitor.status === 'pending') {
                pendingCount++;
            }
        }
        
        // Update statistics
        document.querySelector('#visitorCount').textContent = visitors.length;
        document.querySelector('#totalRevenue').textContent = '₱' + totalRevenue;
        document.querySelector('#pendingCount').textContent = pendingCount;
        
        // Display visitor list
        const visitorList = document.querySelector('#visitorList');
        
        for (let visitor of visitors) {
            // Create list item
            let listItem = document.createElement('li');
            
            // Add visitor name
            let nameDiv = document.createElement('div');
            nameDiv.className = 'visitor-name';
            nameDiv.textContent = visitor.name;
            
            // Add visitor details
            let detailsDiv = document.createElement('div');
            detailsDiv.className = 'visitor-details';
            
            let discount = "";
            if (visitor.age >= 60) {
                discount = " (Senior discount applied)";
            }
            
            detailsDiv.textContent = `Age: ${visitor.age} | Service: ${visitor.service} | Fee: ₱${visitor.fee}${discount} | Status: ${visitor.status.toUpperCase()}`;
            
            // Add status indicator color
            if (visitor.status === 'completed') {
                listItem.style.borderLeftColor = '#28a745';  // Green
            } else {
                listItem.style.borderLeftColor = '#ffc107';  // Yellow
            }
            
            // Append to list item
            listItem.appendChild(nameDiv);
            listItem.appendChild(detailsDiv);
            
            // Append to list
            visitorList.appendChild(listItem);
        }
    </script>
</body>
</html>
```

---

## Best Practices

### 1. Cache DOM selections
```javascript
// Bad - queries every time
for (let i = 0; i < 100; i++) {
    document.querySelector('#box').textContent = i;
}

// Good - query once
let box = document.querySelector('#box');
for (let i = 0; i < 100; i++) {
    box.textContent = i;
}
```

### 2. Use textContent for plain text
```javascript
// Use textContent for security (prevents XSS)
element.textContent = userInput;

// Only use innerHTML when you need HTML
element.innerHTML = '<strong>Bold text</strong>';
```

### 3. Use classList over direct className
```javascript
// Bad
element.className = 'box active';

// Good
element.classList.add('box');
element.classList.add('active');
```

---

## Summary

Tian reviewed DOM manipulation:

**Selecting:**
```javascript
document.querySelector('#id')      // Select by ID
document.querySelector('.class')   // Select by class
document.querySelectorAll('.class') // Select all
```

**Changing:**
```javascript
element.textContent = 'text'       // Change text
element.innerHTML = '<h1>HTML</h1>' // Change HTML
element.style.color = 'red'        // Change style
element.classList.add('class')     // Add class
```

**Creating:**
```javascript
let el = document.createElement('div')
element.appendChild(el)
```

Rhea Joy smiled. "Now we can make our pages interactive!"

---

## What's Next?

In the next lesson, you'll learn about **Event Handling**—responding to user actions like clicks, typing, and form submissions!

---

---

## Closing Story

Tian selected an HTML element with `document.querySelector()` and changed its text content. The page updated instantly. No refresh needed. This was DOM manipulationJavaScript controlling HTML in real-time.

"The DOM is your playground," Kuya Miguel grinned. "You can create, modify, delete any element on the page. Total control."

Tian added a click counter, a dynamic message board, a live clock. The barangay portal was interactive now. Users could see changes happen instantly. The static web was dead. Long live dynamic web apps.

_Next up: Event Handlingresponding to user actions!_