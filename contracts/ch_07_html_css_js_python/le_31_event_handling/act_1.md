# Activity 1: Event Handling in JavaScript

In this activity, you'll learn how to make your web pages interactive by handling user events like clicks, form submissions, and keyboard input. Events are actions that happen in the browser (clicking a button, typing in a form, pressing a key) that JavaScript can respond to.

---

## Activity 1: Click Events

Events are the foundation of interactive web pages. The most common event is `click`.

### HTML Setup:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Clearance Counter</title>
</head>
<body>
    <h1>Barangay Clearance Applications Today</h1>
    <p id="counter">Applications: 0</p>
    <button id="addBtn">New Application</button>
    <button id="resetBtn">Reset Counter</button>
    <p id="message"></p>

    <script src="script.js"></script>
</body>
</html>
```

### JavaScript (script.js):
```javascript
// Get elements
const counterDisplay = document.getElementById('counter');
const addBtn = document.getElementById('addBtn');
const resetBtn = document.getElementById('resetBtn');
const message = document.getElementById('message');

// Initialize counter
let count = 0;

// Add event listener for "New Application" button
addBtn.addEventListener('click', function() {
    count++;
    counterDisplay.textContent = `Applications: ${count}`;
    message.textContent = `Application #${count} recorded!`;
    message.style.color = 'green';
});

// Add event listener for "Reset Counter" button
resetBtn.addEventListener('click', function() {
    count = 0;
    counterDisplay.textContent = 'Applications: 0';
    message.textContent = 'Counter reset.';
    message.style.color = 'blue';
});
```

**How it works:**
- `addEventListener('click', function)` - Attaches an event listener to an element
- When the button is clicked, the function runs
- We can update the DOM inside the event handler function

---

## Activity 2: Form Submission Events

Forms are crucial for collecting user data. The `submit` event fires when a form is submitted.

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay ID Application</title>
</head>
<body>
    <h1>Barangay ID Application Form</h1>
    <form id="idForm">
        <label>Full Name:</label><br>
        <input type="text" id="fullName" required><br><br>
        
        <label>Age:</label><br>
        <input type="number" id="age" required><br><br>
        
        <button type="submit">Submit Application</button>
    </form>
    
    <div id="result"></div>

    <script src="form.js"></script>
</body>
</html>
```

### JavaScript (form.js):
```javascript
const form = document.getElementById('idForm');
const result = document.getElementById('result');

form.addEventListener('submit', function(event) {
    // Prevent the form from submitting and refreshing the page
    event.preventDefault();
    
    // Get form values
    const fullName = document.getElementById('fullName').value;
    const age = document.getElementById('age').value;
    
    // Display the information
    result.innerHTML = `
        <h2>Application Received!</h2>
        <p><strong>Name:</strong> ${fullName}</p>
        <p><strong>Age:</strong> ${age}</p>
        <p style="color: green;">Your Barangay ID will be processed within 3-5 days.</p>
    `;
    
    // Clear the form
    form.reset();
});
```

**Key Concepts:**
- `event.preventDefault()` - Stops the form from submitting normally (which would reload the page)
- Access form field values using `.value`
- `form.reset()` - Clears all form fields

---

## Activity 3: Input Events (Real-time Validation)

The `input` event fires every time a user types in an input field. This is perfect for real-time validation.

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Clearance Purpose</title>
    <style>
        #charCount { font-size: 14px; color: gray; }
        .warning { color: red; }
    </style>
</head>
<body>
    <h1>Purpose of Clearance</h1>
    <label>Enter purpose (max 100 characters):</label><br>
    <textarea id="purpose" rows="4" cols="50" maxlength="100"></textarea><br>
    <span id="charCount">0 / 100 characters</span>

    <script src="input.js"></script>
</body>
</html>
```

### JavaScript (input.js):
```javascript
const purposeField = document.getElementById('purpose');
const charCount = document.getElementById('charCount');

purposeField.addEventListener('input', function() {
    const currentLength = purposeField.value.length;
    charCount.textContent = `${currentLength} / 100 characters`;
    
    // Change color when approaching limit
    if (currentLength > 80) {
        charCount.classList.add('warning');
    } else {
        charCount.classList.remove('warning');
    }
});
```

**How it works:**
- `input` event fires on every keystroke
- `.value.length` gets the current character count
- We update the display in real-time
- Change styling when near the limit

---

## Activity 4: Keyboard Events

Keyboard events let you respond to keys being pressed. Useful for keyboard shortcuts.

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Document System</title>
    <style>
        .shortcut-info {
            background: #f0f0f0;
            padding: 10px;
            margin: 10px 0;
            border-left: 4px solid #007bff;
        }
    </style>
</head>
<body>
    <div class="shortcut-info">
        <strong>Keyboard Shortcuts:</strong><br>
        - Press <kbd>C</kbd> for Clearance<br>
        - Press <kbd>P</kbd> for Permit<br>
        - Press <kbd>I</kbd> for ID<br>
        - Press <kbd>Esc</kbd> to clear selection
    </div>
    
    <h2>Select Document Type:</h2>
    <p id="selection">No document selected</p>

    <script src="keyboard.js"></script>
</body>
</html>
```

### JavaScript (keyboard.js):
```javascript
const selection = document.getElementById('selection');

// Listen for keyboard events on the whole document
document.addEventListener('keydown', function(event) {
    const key = event.key.toLowerCase();
    
    if (key === 'c') {
        selection.textContent = 'Selected: Barangay Clearance';
        selection.style.color = 'blue';
    } else if (key === 'p') {
        selection.textContent = 'Selected: Business Permit';
        selection.style.color = 'green';
    } else if (key === 'i') {
        selection.textContent = 'Selected: Barangay ID';
        selection.style.color = 'purple';
    } else if (key === 'escape') {
        selection.textContent = 'No document selected';
        selection.style.color = 'black';
    }
});
```

**Key Concepts:**
- `keydown` event fires when a key is pressed
- `event.key` gives you the key that was pressed
- `.toLowerCase()` makes the comparison case-insensitive

---

## Activity 5: The Event Object

Every event handler receives an `event` object with useful information about the event.

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Event Information</title>
    <style>
        .service-btn {
            padding: 10px 20px;
            margin: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        #info {
            margin-top: 20px;
            padding: 15px;
            background: #e8f5e9;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h1>Barangay Services</h1>
    <button class="service-btn" data-fee="50">Barangay Clearance</button>
    <button class="service-btn" data-fee="100">Business Permit</button>
    <button class="service-btn" data-fee="30">Barangay ID</button>
    
    <div id="info">Click a service to see details</div>

    <script src="event-obj.js"></script>
</body>
</html>
```

### JavaScript (event-obj.js):
```javascript
const buttons = document.querySelectorAll('.service-btn');
const info = document.getElementById('info');

buttons.forEach(button => {
    button.addEventListener('click', function(event) {
        // event.target - the element that was clicked
        const clickedButton = event.target;
        
        // Get information from the clicked element
        const serviceName = clickedButton.textContent;
        const fee = clickedButton.getAttribute('data-fee');
        
        // event.type - the type of event ('click' in this case)
        const eventType = event.type;
        
        // Display information
        info.innerHTML = `
            <h3>Event Details:</h3>
            <p><strong>Event Type:</strong> ${eventType}</p>
            <p><strong>Service:</strong> ${serviceName}</p>
            <p><strong>Fee:</strong> ₱${fee}</p>
            <p><strong>Element Clicked:</strong> ${clickedButton.tagName}</p>
        `;
    });
});
```

**Useful Event Object Properties:**
- `event.target` - The element that triggered the event
- `event.type` - The type of event ('click', 'submit', etc.)
- `event.preventDefault()` - Prevents default behavior
- `event.key` - The key pressed (for keyboard events)

---

## Activity 6: Event Delegation

Event delegation is a technique where you add one event listener to a parent element instead of many listeners to child elements. This is especially useful for dynamically created elements.

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resident List</title>
    <style>
        .resident {
            padding: 10px;
            margin: 5px 0;
            background: #f5f5f5;
            border-radius: 5px;
            cursor: pointer;
        }
        .resident:hover {
            background: #e0e0e0;
        }
        .selected {
            background: #4caf50 !important;
            color: white;
        }
    </style>
</head>
<body>
    <h1>Resident Directory</h1>
    <button id="addResident">Add New Resident</button>
    
    <div id="residentList">
        <div class="resident" data-id="1">Juan Dela Cruz</div>
        <div class="resident" data-id="2">Maria Santos</div>
        <div class="resident" data-id="3">Pedro Reyes</div>
    </div>
    
    <p id="selectedInfo">Click a resident to select</p>

    <script src="delegation.js"></script>
</body>
</html>
```

### JavaScript (delegation.js):
```javascript
const residentList = document.getElementById('residentList');
const selectedInfo = document.getElementById('selectedInfo');
const addBtn = document.getElementById('addResident');

let residentCount = 3;

// Event delegation: One listener on the parent handles all clicks
residentList.addEventListener('click', function(event) {
    // Check if a resident div was clicked
    if (event.target.classList.contains('resident')) {
        // Remove 'selected' class from all residents
        const allResidents = document.querySelectorAll('.resident');
        allResidents.forEach(r => r.classList.remove('selected'));
        
        // Add 'selected' class to clicked resident
        event.target.classList.add('selected');
        
        // Get resident information
        const residentName = event.target.textContent;
        const residentId = event.target.getAttribute('data-id');
        
        // Display information
        selectedInfo.textContent = `Selected: ${residentName} (ID: ${residentId})`;
    }
});

// Add new resident dynamically
addBtn.addEventListener('click', function() {
    residentCount++;
    const newResident = document.createElement('div');
    newResident.className = 'resident';
    newResident.setAttribute('data-id', residentCount);
    newResident.textContent = `New Resident ${residentCount}`;
    
    residentList.appendChild(newResident);
    
    // No need to add event listener to the new element!
    // Event delegation handles it automatically
});
```

**Why Event Delegation?**
- **Efficiency:** One event listener instead of many
- **Dynamic elements:** Works with elements added later
- **Memory:** Uses less memory
- **Maintenance:** Easier to manage code

---

## Activity 7: Complete Interactive Clearance Form

Let's combine everything we've learned into a complete interactive form.

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Clearance Application</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        
        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        input:focus,
        select:focus,
        textarea:focus {
            border-color: #4caf50;
            outline: none;
        }
        
        .char-count {
            font-size: 12px;
            color: #666;
            text-align: right;
        }
        
        .char-count.warning {
            color: #f44336;
            font-weight: bold;
        }
        
        .fee-display {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        
        .fee-display h3 {
            color: #1976d2;
            margin-bottom: 10px;
        }
        
        button {
            width: 100%;
            padding: 12px;
            background: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        button:hover {
            background: #45a049;
        }
        
        button:disabled {
            background: #cccccc;
            cursor: not-allowed;
        }
        
        #result {
            margin-top: 20px;
            padding: 20px;
            background: #e8f5e9;
            border-radius: 5px;
            display: none;
        }
        
        #result h2 {
            color: #2e7d32;
            margin-bottom: 15px;
        }
        
        .shortcut-hint {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏘️ Barangay Clearance Application</h1>
        
        <form id="clearanceForm">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" required>
            </div>
            
            <div class="form-group">
                <label for="age">Age:</label>
                <input type="number" id="age" min="1" required>
            </div>
            
            <div class="form-group">
                <label for="clearanceType">Clearance Type:</label>
                <select id="clearanceType" required>
                    <option value="">-- Select Type --</option>
                    <option value="barangay">Barangay Clearance (₱50)</option>
                    <option value="police">Police Clearance (₱100)</option>
                    <option value="business">Business Permit (₱150)</option>
                </select>
                <div class="shortcut-hint">Keyboard shortcut: Press B, P, or R to quick-select</div>
            </div>
            
            <div class="form-group">
                <label for="purpose">Purpose:</label>
                <textarea id="purpose" rows="4" maxlength="200" required></textarea>
                <div class="char-count" id="charCount">0 / 200 characters</div>
            </div>
            
            <div class="fee-display">
                <h3>Fee Summary</h3>
                <p>Base Fee: <span id="baseFee">₱0</span></p>
                <p>Senior Discount: <span id="discount">₱0</span></p>
                <p><strong>Total: <span id="totalFee">₱0</span></strong></p>
            </div>
            
            <button type="submit" id="submitBtn" disabled>Submit Application</button>
        </form>
        
        <div id="result"></div>
    </div>

    <script src="complete.js"></script>
</body>
</html>
```

### JavaScript (complete.js):
```javascript
// Get all elements
const form = document.getElementById('clearanceForm');
const fullNameInput = document.getElementById('fullName');
const ageInput = document.getElementById('age');
const clearanceTypeSelect = document.getElementById('clearanceType');
const purposeTextarea = document.getElementById('purpose');
const charCount = document.getElementById('charCount');
const baseFeeSpan = document.getElementById('baseFee');
const discountSpan = document.getElementById('discount');
const totalFeeSpan = document.getElementById('totalFee');
const submitBtn = document.getElementById('submitBtn');
const result = document.getElementById('result');

// Fee structure
const fees = {
    barangay: 50,
    police: 100,
    business: 150
};

// Character count for purpose field (input event)
purposeTextarea.addEventListener('input', function() {
    const currentLength = purposeTextarea.value.length;
    charCount.textContent = `${currentLength} / 200 characters`;
    
    if (currentLength > 160) {
        charCount.classList.add('warning');
    } else {
        charCount.classList.remove('warning');
    }
    
    checkFormValidity();
});

// Update fee when clearance type changes
clearanceTypeSelect.addEventListener('change', function() {
    updateFeeDisplay();
    checkFormValidity();
});

// Update fee when age changes (for senior discount)
ageInput.addEventListener('input', function() {
    updateFeeDisplay();
    checkFormValidity();
});

// Check name input
fullNameInput.addEventListener('input', checkFormValidity);

// Function to update fee display
function updateFeeDisplay() {
    const clearanceType = clearanceTypeSelect.value;
    const age = parseInt(ageInput.value) || 0;
    
    if (clearanceType && fees[clearanceType]) {
        const baseFee = fees[clearanceType];
        let discount = 0;
        
        // Senior citizen discount (20% off for 60+)
        if (age >= 60) {
            discount = baseFee * 0.20;
        }
        
        const totalFee = baseFee - discount;
        
        baseFeeSpan.textContent = `₱${baseFee}`;
        discountSpan.textContent = discount > 0 ? `₱${discount}` : '₱0';
        totalFeeSpan.textContent = `₱${totalFee}`;
    } else {
        baseFeeSpan.textContent = '₱0';
        discountSpan.textContent = '₱0';
        totalFeeSpan.textContent = '₱0';
    }
}

// Check if form is valid and enable/disable submit button
function checkFormValidity() {
    const isValid = fullNameInput.value.trim() !== '' &&
                    ageInput.value !== '' &&
                    clearanceTypeSelect.value !== '' &&
                    purposeTextarea.value.trim() !== '';
    
    submitBtn.disabled = !isValid;
}

// Keyboard shortcuts for clearance type (keydown event)
document.addEventListener('keydown', function(event) {
    const key = event.key.toLowerCase();
    
    // Only trigger if not typing in an input field
    if (event.target.tagName !== 'INPUT' && 
        event.target.tagName !== 'TEXTAREA' && 
        event.target.tagName !== 'SELECT') {
        
        if (key === 'b') {
            clearanceTypeSelect.value = 'barangay';
            updateFeeDisplay();
            checkFormValidity();
        } else if (key === 'p') {
            clearanceTypeSelect.value = 'police';
            updateFeeDisplay();
            checkFormValidity();
        } else if (key === 'r') {
            clearanceTypeSelect.value = 'business';
            updateFeeDisplay();
            checkFormValidity();
        }
    }
});

// Form submission (submit event)
form.addEventListener('submit', function(event) {
    event.preventDefault();
    
    const fullName = fullNameInput.value.trim();
    const age = ageInput.value;
    const clearanceType = clearanceTypeSelect.value;
    const clearanceText = clearanceTypeSelect.options[clearanceTypeSelect.selectedIndex].text;
    const purpose = purposeTextarea.value.trim();
    const totalFee = totalFeeSpan.textContent;
    
    // Generate application number
    const applicationNumber = 'BR-' + Date.now();
    
    // Display result
    result.innerHTML = `
        <h2>✅ Application Submitted Successfully!</h2>
        <p><strong>Application Number:</strong> ${applicationNumber}</p>
        <p><strong>Name:</strong> ${fullName}</p>
        <p><strong>Age:</strong> ${age} years old</p>
        <p><strong>Type:</strong> ${clearanceText}</p>
        <p><strong>Purpose:</strong> ${purpose}</p>
        <p><strong>Total Fee:</strong> ${totalFee}</p>
        <hr>
        <p style="color: #2e7d32; margin-top: 15px;">
            <strong>Next Steps:</strong><br>
            1. Pay the fee at the Barangay Office<br>
            2. Wait for 3-5 business days<br>
            3. Claim your clearance with this application number
        </p>
    `;
    result.style.display = 'block';
    
    // Reset form
    form.reset();
    updateFeeDisplay();
    checkFormValidity();
    charCount.textContent = '0 / 200 characters';
    charCount.classList.remove('warning');
    
    // Scroll to result
    result.scrollIntoView({ behavior: 'smooth' });
});
```

**This complete example demonstrates:**
1. **Form submission with preventDefault** - Stops page reload
2. **Input event** - Real-time character counting
3. **Change event** - Update fees when selection changes
4. **Keyboard shortcuts** - Quick selection with keys
5. **Event object usage** - Access event.target, event.key
6. **Form validation** - Enable/disable submit button
7. **Dynamic calculations** - Senior citizen discount
8. **Professional UI** - Clean, modern design

---

## 📚 Answer Key: Event Handling Concepts

### Event Listener Syntax
```javascript
element.addEventListener('eventType', function(event) {
    // Code to run when event occurs
});
```

### Common Event Types

| Event Type | When it Fires | Common Use |
|------------|---------------|------------|
| `click` | Element is clicked | Buttons, links |
| `submit` | Form is submitted | Form handling |
| `input` | Input value changes | Real-time validation |
| `change` | Input loses focus after value change | Dropdowns, checkboxes |
| `keydown` | Key is pressed down | Keyboard shortcuts |
| `keyup` | Key is released | Text input |
| `mouseenter` | Mouse enters element | Hover effects |
| `mouseleave` | Mouse leaves element | Hide tooltips |
| `focus` | Element gains focus | Input highlighting |
| `blur` | Element loses focus | Validation on blur |

### Event Object Properties

```javascript
element.addEventListener('click', function(event) {
    event.target;           // Element that triggered event
    event.type;             // Type of event ('click')
    event.preventDefault(); // Prevent default action
    event.stopPropagation(); // Stop event bubbling
    event.key;              // Key pressed (keyboard events)
    event.clientX;          // Mouse X position (mouse events)
    event.clientY;          // Mouse Y position (mouse events)
});
```

### Event Delegation Pattern

**Without Event Delegation (Bad):**
```javascript
// Adding listener to each button individually
const buttons = document.querySelectorAll('.btn');
buttons.forEach(btn => {
    btn.addEventListener('click', handleClick);
});
// Problem: Doesn't work for buttons added later
```

**With Event Delegation (Good):**
```javascript
// One listener on parent handles all buttons
document.getElementById('container').addEventListener('click', function(event) {
    if (event.target.classList.contains('btn')) {
        handleClick(event);
    }
});
// Works for all buttons, even ones added dynamically!
```

### Preventing Default Behavior

```javascript
// Prevent form from submitting and reloading page
form.addEventListener('submit', function(event) {
    event.preventDefault();
    // Handle form submission with JavaScript
});

// Prevent link from navigating
link.addEventListener('click', function(event) {
    event.preventDefault();
    // Do something else instead
});
```

### Form Events Best Practices

```javascript
// 1. Always prevent default on submit
form.addEventListener('submit', function(event) {
    event.preventDefault();
    // Process form
});

// 2. Use 'input' for real-time updates
input.addEventListener('input', function() {
    // Updates as user types
});

// 3. Use 'change' for final value
select.addEventListener('change', function() {
    // Updates when selection changes
});
```

### Keyboard Event Keys

```javascript
document.addEventListener('keydown', function(event) {
    console.log(event.key); // Key name as string
    
    // Common checks:
    if (event.key === 'Enter') { /* Enter key */ }
    if (event.key === 'Escape') { /* Escape key */ }
    if (event.key === ' ') { /* Spacebar */ }
    if (event.key === 'ArrowUp') { /* Arrow keys */ }
    if (event.ctrlKey && event.key === 's') { 
        event.preventDefault();
        /* Ctrl+S */ 
    }
});
```

### Common Mistakes to Avoid

**❌ Wrong:**
```javascript
// Forgetting to prevent default
form.addEventListener('submit', function(event) {
    // Page will reload!
    console.log('Form submitted');
});

// Calling function immediately instead of passing reference
button.addEventListener('click', handleClick()); // ❌ Runs immediately

// Not checking event.target in delegation
parent.addEventListener('click', function(event) {
    // Might not be the element you want!
    event.target.classList.add('selected');
});
```

**✅ Correct:**
```javascript
// Prevent default
form.addEventListener('submit', function(event) {
    event.preventDefault(); // ✅ Prevents reload
    console.log('Form submitted');
});

// Pass function reference
button.addEventListener('click', handleClick); // ✅ Correct

// Check event.target in delegation
parent.addEventListener('click', function(event) {
    if (event.target.classList.contains('button')) {
        event.target.classList.add('selected'); // ✅ Safe
    }
});
```

### Removing Event Listeners

```javascript
function handleClick() {
    console.log('Clicked!');
}

// Add listener
button.addEventListener('click', handleClick);

// Remove listener (must use same function reference)
button.removeEventListener('click', handleClick);

// ❌ This won't work (anonymous functions can't be removed):
button.addEventListener('click', function() {
    console.log('Clicked!');
});
// Can't remove because we don't have a reference to the function
```

### Event Flow (Bubbling and Capturing)

```javascript
// Event bubbling (default): child → parent → grandparent
// Event capturing: grandparent → parent → child

// Capturing phase (useCapture = true)
element.addEventListener('click', handler, true);

// Bubbling phase (default)
element.addEventListener('click', handler, false);

// Stop event from bubbling up
element.addEventListener('click', function(event) {
    event.stopPropagation();
});
```

---

## 🎯 Key Takeaways

1. **addEventListener** is how you respond to user interactions
2. **event.preventDefault()** stops default browser behavior (crucial for forms!)
3. **event.target** tells you which element triggered the event
4. **Event delegation** is efficient for multiple or dynamic elements
5. **input** event updates in real-time, **change** event fires on blur
6. **Keyboard events** enable shortcuts and better UX
7. Always remove event listeners when no longer needed (prevents memory leaks)

---

## 🚀 Practice Challenge

Create a complete **Barangay Complaint Form** with:
- Form fields: Name, Contact, Complaint Type (dropdown), Description
- Real-time character counter on description (max 500 characters)
- Display fee based on complaint type
- Keyboard shortcut (Ctrl+Enter) to submit form
- Form validation (disable submit until all fields filled)
- Display submitted complaint details after submission
- Add ability to "Edit" or "Delete" submitted complaint using event delegation

This will test your understanding of all event types!

---

**Great job!** You now know how to make web pages interactive with events. Next, we'll learn form validation techniques to ensure data quality! 🎉
