## Background Story

The barangay office had a new requirement: visual status indicators. When an application was submitted, a status box should change color based on the application state:

- Pending: Yellow background
- Approved: Green background  
- Rejected: Red background
- Under Review: Blue background

Tian could change the text content using `textContent`, but they didn't know how to change CSS styles dynamically. They tried modifying the HTML directly:

```javascript
statusBox.textContent = "Approved";
// How do I also change the background to green?
```

The CSS file had classes for each status:

```css
.status-pending { background: yellow; }
.status-approved { background: green; }
.status-rejected { background: red; }
```

But Tian didn't know how to apply these classes dynamically from JavaScript. They needed a way to manipulate CSS from code.

Rhea Joy had a similar challenge with the office availability indicator. The barangay hall's hours were 8 AM to 5 PM, Monday to Friday. She wanted a visual indicator:

- When open: Green dot, text says "OPEN"
- When closed: Red dot, text says "CLOSED"
- Font size should be larger during business hours to draw attention

She could update the text with JavaScript, but not the color or size:

```javascript
let currentHour = new Date().getHours();
if (currentHour >= 8 && currentHour < 17) {
    indicator.textContent = "OPEN";
    // But how do I make it green and larger?
} else {
    indicator.textContent = "CLOSED";
    // And how do I make it red and smaller?
}
```

Both of them realized they'd learned to manipulate content (text, HTML), but not presentation (styles, colors, sizes). Their interfaces were static—they looked the same regardless of state or user interaction.

That evening, they researched "JavaScript change CSS" and found two approaches:

1. **Inline styles**: Directly modify the `style` property
```javascript
element.style.backgroundColor = 'green';
```

2. **CSS classes**: Add/remove class names that have styles defined in CSS
```javascript
element.classList.add('status-approved');
```

Tian tried the inline approach:

```javascript
statusBox.style.backgroundColor = 'green';
statusBox.style.color = 'white';
statusBox.style.padding = '15px';
```

It worked! The status box changed color based on application state.

Rhea Joy tried the class approach:

```javascript
indicator.classList.add('office-open');
indicator.classList.remove('office-closed');
```

Also worked! The indicator switched between open and closed styling.

But they'd learned through trial and error. They didn't understand:
- When to use inline styles vs classes
- How to toggle classes
- How CSS property names change in JavaScript (background-color → backgroundColor)
- How to read current styles
- Best practices for dynamic styling

They called Kuya Miguel.

"Kuya, we can change text and HTML, but we didn't know how to change styles dynamically. We discovered the `style` property and `classList`, but we're just guessing. Can you teach us how to properly manipulate CSS from JavaScript?"

Miguel pulled up examples on his screen. "Dynamic styling is what makes interfaces feel responsive and alive. The `style` property lets you modify CSS directly. The `classList` API lets you add, remove, and toggle classes. Today we're learning both approaches, when to use each, how to create interactive visual feedback, and best practices for keeping styling organized. By the end of this lesson, your interfaces will respond visually to every user interaction."

---

## Theory & Lecture Content

## The style Property

**Access and modify CSS directly:**

```javascript
element.style.propertyName = 'value';
```

**CSS property names in JavaScript use camelCase:**
- `background-color` → `backgroundColor`
- `font-size` → `fontSize`  
- `border-radius` → `borderRadius`
- `margin-top` → `marginTop`

**Basic example:**
```html
<div id="box">Hello</div>

<script>
let box = document.querySelector('#box');

box.style.color = 'white';
box.style.backgroundColor = '#007bff';
box.style.padding = '20px';
box.style.fontSize = '24px';
box.style.textAlign = 'center';
box.style.borderRadius = '10px';
</script>
```

---

## Dynamic Status Indicators

**Barangay office status:**
```html
<div id="officeStatus">Office Status</div>
<button id="toggleStatus">Toggle Status</button>

<script>
let status = document.querySelector('#officeStatus');
let button = document.querySelector('#toggleStatus');
let isOpen = true;

button.addEventListener('click', function() {
    if (isOpen) {
        // Closed
        status.textContent = 'CLOSED';
        status.style.backgroundColor = '#dc3545';
        status.style.color = 'white';
        status.style.padding = '15px';
        status.style.textAlign = 'center';
        status.style.fontWeight = 'bold';
        status.style.borderRadius = '5px';
    } else {
        // Open
        status.textContent = 'OPEN';
        status.style.backgroundColor = '#28a745';
        status.style.color = 'white';
        status.style.padding = '15px';
        status.style.textAlign = 'center';
        status.style.fontWeight = 'bold';
        status.style.borderRadius = '5px';
    }
    isOpen = !isOpen;
});
</script>
```

---

## classList - Better Approach

**Instead of inline styles, toggle CSS classes:**

```html
<style>
.box {
    padding: 20px;
    border: 2px solid #ddd;
}

.active {
    background-color: #28a745;
    color: white;
    border-color: #28a745;
}

.inactive {
    background-color: #dc3545;
    color: white;
    border-color: #dc3545;
}
</style>

<div id="serviceBox" class="box">Barangay Clearance</div>
<button id="toggleBtn">Toggle Service</button>

<script>
let box = document.querySelector('#serviceBox');
let button = document.querySelector('#toggleBtn');

button.addEventListener('click', function() {
    box.classList.toggle('active');
});
</script>
```

**classList methods:**
```javascript
element.classList.add('className');       // Add class
element.classList.remove('className');    // Remove class
element.classList.toggle('className');    // Toggle class
element.classList.contains('className'); // Check if has class
element.classList.replace('old', 'new'); // Replace class
```

---

## Interactive Form Validation Styling

**Visual feedback for input:**
```html
<style>
.form-control {
    padding: 10px;
    border: 2px solid #ddd;
    border-radius: 4px;
    width: 100%;
}

.valid {
    border-color: #28a745;
    background-color: #d4edda;
}

.invalid {
    border-color: #dc3545;
    background-color: #f8d7da;
}
</style>

<input type="text" id="name" class="form-control" placeholder="Enter name (min 3 chars)">
<p id="nameError" style="color: #dc3545; display: none;">Name must be at least 3 characters</p>

<script>
let input = document.querySelector('#name');
let error = document.querySelector('#nameError');

input.addEventListener('input', function() {
    let value = input.value.trim();
    
    if (value.length >= 3) {
        input.classList.remove('invalid');
        input.classList.add('valid');
        error.style.display = 'none';
    } else if (value.length > 0) {
        input.classList.remove('valid');
        input.classList.add('invalid');
        error.style.display = 'block';
    } else {
        input.classList.remove('valid', 'invalid');
        error.style.display = 'none';
    }
});
</script>
```

---

## Dynamic Progress Indicator

**Barangay application progress:**
```html
<style>
.progress-bar {
    width: 100%;
    height: 30px;
    background-color: #e9ecef;
    border-radius: 5px;
    overflow: hidden;
}

.progress-fill {
    height: 100%;
    background-color: #007bff;
    transition: width 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
}
</style>

<div class="progress-bar">
    <div class="progress-fill" id="progress" style="width: 0%;">0%</div>
</div>
<br>
<button id="step1">Step 1: Personal Info</button>
<button id="step2">Step 2: Service Type</button>
<button id="step3">Step 3: Payment</button>
<button id="complete">Complete</button>

<script>
let progress = document.querySelector('#progress');

document.querySelector('#step1').addEventListener('click', () => updateProgress(25));
document.querySelector('#step2').addEventListener('click', () => updateProgress(50));
document.querySelector('#step3').addEventListener('click', () => updateProgress(75));
document.querySelector('#complete').addEventListener('click', () => updateProgress(100));

function updateProgress(percent) {
    progress.style.width = percent + '%';
    progress.textContent = percent + '%';
    
    if (percent === 100) {
        progress.style.backgroundColor = '#28a745';
    } else {
        progress.style.backgroundColor = '#007bff';
    }
}
</script>
```

---

## Complete Barangay Dashboard

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dynamic Barangay Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        .stat-card.active {
            border-left: 5px solid #007bff;
        }
        
        .stat-number {
            font-size: 48px;
            font-weight: bold;
            color: #007bff;
        }
        
        .stat-label {
            color: #666;
            margin-top: 10px;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
        }
        
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .status-indicator {
            display: inline-block;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
        .status-online {
            background-color: #28a745;
        }
        
        .status-offline {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Barangay Service Dashboard</h1>
        <p>Click cards to highlight them</p>
        <br>
        
        <div class="stat-card" data-stat="visitors">
            <div class="stat-number" id="visitorCount">0</div>
            <div class="stat-label">Total Visitors Today</div>
        </div>
        
        <div class="stat-card" data-stat="revenue">
            <div class="stat-number" id="revenueCount">₱0</div>
            <div class="stat-label">Total Revenue</div>
        </div>
        
        <div class="stat-card" data-stat="pending">
            <div class="stat-number" id="pendingCount">0</div>
            <div class="stat-label">Pending Applications</div>
        </div>
        
        <br>
        
        <div style="background: white; padding: 20px; border-radius: 8px;">
            <h2>
                <span class="status-indicator status-offline" id="statusIndicator"></span>
                Office Status: <span id="statusText">CLOSED</span>
            </h2>
            <br>
            <button class="btn btn-success" id="openOffice">Open Office</button>
            <button class="btn btn-danger" id="closeOffice">Close Office</button>
            <br><br>
            <button class="btn btn-primary" id="addVisitor">Add Visitor</button>
            <button class="btn btn-primary" id="addRevenue">Add Revenue (₱50)</button>
            <button class="btn btn-primary" id="addPending">Add Pending</button>
        </div>
    </div>
    
    <script>
        // Stat tracking
        let visitors = 0;
        let revenue = 0;
        let pending = 0;
        let isOfficeOpen = false;
        
        // Elements
        const visitorCount = document.querySelector('#visitorCount');
        const revenueCount = document.querySelector('#revenueCount');
        const pendingCount = document.querySelector('#pendingCount');
        const statusIndicator = document.querySelector('#statusIndicator');
        const statusText = document.querySelector('#statusText');
        
        // Card highlighting
        const cards = document.querySelectorAll('.stat-card');
        cards.forEach(card => {
            card.addEventListener('click', function() {
                cards.forEach(c => c.classList.remove('active'));
                card.classList.add('active');
            });
        });
        
        // Office status
        document.querySelector('#openOffice').addEventListener('click', function() {
            isOfficeOpen = true;
            statusText.textContent = 'OPEN';
            statusText.style.color = '#28a745';
            statusIndicator.classList.remove('status-offline');
            statusIndicator.classList.add('status-online');
        });
        
        document.querySelector('#closeOffice').addEventListener('click', function() {
            isOfficeOpen = false;
            statusText.textContent = 'CLOSED';
            statusText.style.color = '#dc3545';
            statusIndicator.classList.remove('status-online');
            statusIndicator.classList.add('status-offline');
        });
        
        // Add visitor
        document.querySelector('#addVisitor').addEventListener('click', function() {
            if (!isOfficeOpen) {
                alert('Office is closed!');
                return;
            }
            
            visitors++;
            visitorCount.textContent = visitors;
            
            // Animation effect
            visitorCount.style.transform = 'scale(1.2)';
            setTimeout(() => {
                visitorCount.style.transform = 'scale(1)';
            }, 200);
        });
        
        // Add revenue
        document.querySelector('#addRevenue').addEventListener('click', function() {
            revenue += 50;
            revenueCount.textContent = '₱' + revenue;
            
            revenueCount.style.color = '#28a745';
            setTimeout(() => {
                revenueCount.style.color = '#007bff';
            }, 500);
        });
        
        // Add pending
        document.querySelector('#addPending').addEventListener('click', function() {
            pending++;
            pendingCount.textContent = pending;
            
            if (pending > 5) {
                pendingCount.style.color = '#dc3545';
            } else {
                pendingCount.style.color = '#007bff';
            }
        });
    </script>
</body>
</html>
```

---

## Best Practices

### 1. Use classList over style when possible
```javascript
// Good - reusable, maintainable
element.classList.add('success');

// Okay for unique dynamic values
element.style.width = calculatedWidth + 'px';
```

### 2. CSS transitions for smooth animations
```css
.box {
    transition: all 0.3s ease;
}
```

### 3. Keep styles in CSS, toggle with classes
```css
/* Define in CSS */
.highlight { background-color: yellow; }

/* Toggle in JavaScript */
element.classList.toggle('highlight');
```

---

## Summary

**style property:**
```javascript
element.style.backgroundColor = 'blue';
element.style.fontSize = '20px';
```

**classList methods:**
```javascript
element.classList.add('className');
element.classList.remove('className');
element.classList.toggle('className');
element.classList.contains('className');
```

**Best approach:** Define styles in CSS, toggle classes with JavaScript!

---

## What's Next?

In the next lesson, you'll learn **Arrow Functions, Destructuring, and Spread**—modern JavaScript syntax that makes code cleaner and more concise!

---

---

## Closing Story

Tian changed CSS properties using JavaScript: `element.style.backgroundColor = 'red';`. The page theme switched dynamically. Users could toggle dark mode, resize text, change colorsall in real-time.

"JavaScript + CSS = unlimited customization," Kuya Miguel noted. "You can create themes, animations, transitionsall programmatically."

Tian implemented a dark mode toggle for the barangay portal. One click, entire page transformed. Residents loved it. Accessibility improved. This was user-centered design.

_Next up: Arrow Functions and Destructuringmodern syntax!_