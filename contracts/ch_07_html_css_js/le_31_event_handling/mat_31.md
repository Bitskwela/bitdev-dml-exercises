# Lesson 31: Event Handling - Making Pages Interactive

---

## Responding to User Actions

"Kuya Miguel, we can change the page with JavaScript, but how do we make it respond when users click buttons or type in forms?" Tian asked.

Rhea Joy added, "Like clicking 'Submit' and seeing a response, or typing and seeing suggestions?"

Kuya Miguel smiled. "That's **Event Handling**—making your page respond to user actions. Events are things that happen: clicks, typing, scrolling, and more!"

---

## What are Events?

**Events** are actions that happen in the browser that JavaScript can detect and respond to.

**Common events:**
- `click` - User clicks an element
- `submit` - Form is submitted
- `input` - User types in input field
- `change` - Input value changes
- `keydown` / `keyup` - User presses/releases key
- `mouseover` / `mouseout` - Mouse enters/leaves element
- `load` - Page finishes loading

---

## addEventListener()

**Best way to handle events:**

```javascript
element.addEventListener('eventType', function() {
    // Code to run when event happens
});
```

**Click event example:**
```html
<button id="myButton">Click Me</button>

<script>
let button = document.querySelector('#myButton');

button.addEventListener('click', function() {
    alert('Button clicked!');
});
</script>
```

**Barangay service request:**
```html
<button id="requestBtn">Request Service</button>
<div id="message"></div>

<script>
let button = document.querySelector('#requestBtn');
let message = document.querySelector('#message');

button.addEventListener('click', function() {
    message.textContent = '✅ Service request submitted!';
    message.style.color = 'green';
});
</script>
```

---

## Click Events

**Button clicks:**
```html
<button id="submitBtn">Submit</button>
<p id="result"></p>

<script>
let button = document.querySelector('#submitBtn');
let result = document.querySelector('#result');

button.addEventListener('click', function() {
    result.textContent = 'Form submitted!';
});
</script>
```

**Toggle visibility:**
```html
<button id="toggleBtn">Toggle Info</button>
<div id="info" style="display: none;">
    <p>Barangay office hours: 8 AM - 5 PM</p>
</div>

<script>
let button = document.querySelector('#toggleBtn');
let info = document.querySelector('#info');

button.addEventListener('click', function() {
    if (info.style.display === 'none') {
        info.style.display = 'block';
        button.textContent = 'Hide Info';
    } else {
        info.style.display = 'none';
        button.textContent = 'Show Info';
    }
});
</script>
```

**Counter example:**
```html
<button id="incrementBtn">Add Visitor</button>
<p>Total visitors: <span id="count">0</span></p>

<script>
let button = document.querySelector('#incrementBtn');
let countSpan = document.querySelector('#count');
let count = 0;

button.addEventListener('click', function() {
    count++;
    countSpan.textContent = count;
});
</script>
```

---

## Input Events

**Respond to typing:**
```html
<input type="text" id="nameInput" placeholder="Enter name">
<p id="greeting"></p>

<script>
let input = document.querySelector('#nameInput');
let greeting = document.querySelector('#greeting');

input.addEventListener('input', function() {
    let name = input.value;
    if (name) {
        greeting.textContent = 'Hello, ' + name + '!';
    } else {
        greeting.textContent = '';
    }
});
</script>
```

**Character counter:**
```html
<textarea id="comments" maxlength="200"></textarea>
<p>Characters: <span id="charCount">0</span> / 200</p>

<script>
let textarea = document.querySelector('#comments');
let charCount = document.querySelector('#charCount');

textarea.addEventListener('input', function() {
    charCount.textContent = textarea.value.length;
});
</script>
```

**Barangay search:**
```html
<input type="text" id="searchInput" placeholder="Search services...">
<ul id="results"></ul>

<script>
let searchInput = document.querySelector('#searchInput');
let results = document.querySelector('#results');

let services = ['Barangay Clearance', 'Residency Certificate', 'Indigency Certificate', 'Business Permit'];

searchInput.addEventListener('input', function() {
    let query = searchInput.value.toLowerCase();
    results.innerHTML = '';
    
    if (query) {
        let filtered = services.filter(service => 
            service.toLowerCase().includes(query)
        );
        
        filtered.forEach(service => {
            let li = document.createElement('li');
            li.textContent = service;
            results.appendChild(li);
        });
    }
});
</script>
```

---

## Form Submit Events

**Prevent default and handle submission:**
```html
<form id="serviceForm">
    <input type="text" id="name" placeholder="Name" required>
    <input type="number" id="age" placeholder="Age" required>
    <button type="submit">Submit</button>
</form>
<div id="confirmation"></div>

<script>
let form = document.querySelector('#serviceForm');
let confirmation = document.querySelector('#confirmation');

form.addEventListener('submit', function(event) {
    event.preventDefault();  // Prevent page reload
    
    let name = document.querySelector('#name').value;
    let age = document.querySelector('#age').value;
    
    confirmation.innerHTML = `
        <h3>Application Submitted</h3>
        <p>Name: ${name}</p>
        <p>Age: ${age}</p>
    `;
    
    form.reset();  // Clear form
});
</script>
```

---

## The Event Object

**Access event details:**
```javascript
element.addEventListener('click', function(event) {
    console.log(event);  // Event object with details
});
```

**Useful event properties:**
```javascript
button.addEventListener('click', function(event) {
    console.log(event.target);       // Element that triggered event
    console.log(event.type);         // Event type ('click')
    console.log(event.clientX);      // Mouse X position
    console.log(event.clientY);      // Mouse Y position
});
```

**Get clicked element:**
```html
<button class="serviceBtn" data-service="clearance">Clearance</button>
<button class="serviceBtn" data-service="residency">Residency</button>
<button class="serviceBtn" data-service="indigency">Indigency</button>

<script>
let buttons = document.querySelectorAll('.serviceBtn');

buttons.forEach(button => {
    button.addEventListener('click', function(event) {
        let serviceType = event.target.dataset.service;
        alert('You selected: ' + serviceType);
    });
});
</script>
```

---

## Change Events

**Dropdown selection:**
```html
<select id="serviceSelect">
    <option value="">Choose service...</option>
    <option value="clearance">Barangay Clearance - ₱50</option>
    <option value="residency">Residency Certificate - ₱30</option>
    <option value="indigency">Indigency Certificate - ₱20</option>
</select>
<p id="selectedService"></p>

<script>
let select = document.querySelector('#serviceSelect');
let display = document.querySelector('#selectedService');

select.addEventListener('change', function() {
    let selected = select.options[select.selectedIndex].text;
    if (select.value) {
        display.textContent = 'Selected: ' + selected;
    } else {
        display.textContent = '';
    }
});
</script>
```

**Checkbox:**
```html
<input type="checkbox" id="agreeTerms">
<label for="agreeTerms">I agree to terms and conditions</label>
<br>
<button id="submitBtn" disabled>Submit</button>

<script>
let checkbox = document.querySelector('#agreeTerms');
let button = document.querySelector('#submitBtn');

checkbox.addEventListener('change', function() {
    button.disabled = !checkbox.checked;
});
</script>
```

---

## Mouse Events

**Hover effects:**
```html
<div id="hoverBox" style="width: 200px; height: 200px; background: lightblue;">
    Hover over me
</div>

<script>
let box = document.querySelector('#hoverBox');

box.addEventListener('mouseover', function() {
    box.style.backgroundColor = 'lightgreen';
    box.textContent = 'Mouse is over!';
});

box.addEventListener('mouseout', function() {
    box.style.backgroundColor = 'lightblue';
    box.textContent = 'Hover over me';
});
</script>
```

---

## Complete Barangay Service Form

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Service Request</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        button:hover {
            background-color: #0056b3;
        }
        
        button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        
        .fee-display {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            margin-top: 15px;
        }
        
        .confirmation {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 15px;
            border-radius: 4px;
            margin-top: 20px;
        }
        
        .error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <h1>Barangay Service Request Form</h1>
    
    <form id="serviceForm">
        <div class="form-group">
            <label for="name">Full Name:</label>
            <input type="text" id="name" required>
            <div class="error" id="nameError"></div>
        </div>
        
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" id="age" min="1" max="120" required>
            <div class="error" id="ageError"></div>
        </div>
        
        <div class="form-group">
            <label for="service">Service Type:</label>
            <select id="service" required>
                <option value="">-- Select Service --</option>
                <option value="clearance" data-fee="50">Barangay Clearance</option>
                <option value="residency" data-fee="30">Residency Certificate</option>
                <option value="indigency" data-fee="20">Indigency Certificate</option>
                <option value="permit" data-fee="100">Business Permit</option>
            </select>
        </div>
        
        <div class="form-group">
            <input type="checkbox" id="isPWD">
            <label for="isPWD" style="display: inline;">Person with Disability (PWD)</label>
        </div>
        
        <div class="fee-display" id="feeDisplay" style="display: none;">
            <h3>Fee Calculation</h3>
            <p>Base Fee: ₱<span id="baseFee">0</span></p>
            <p id="discountInfo" style="display: none;">
                Discount: <span id="discountPercent">0</span>% 
                (<span id="discountReason"></span>)
            </p>
            <p><strong>Total Fee: ₱<span id="totalFee">0</span></strong></p>
        </div>
        
        <button type="submit" id="submitBtn">Submit Application</button>
    </form>
    
    <div id="confirmation" style="display: none;"></div>
    
    <script>
        const form = document.querySelector('#serviceForm');
        const nameInput = document.querySelector('#name');
        const ageInput = document.querySelector('#age');
        const serviceSelect = document.querySelector('#service');
        const pwdCheckbox = document.querySelector('#isPWD');
        const feeDisplay = document.querySelector('#feeDisplay');
        const confirmation = document.querySelector('#confirmation');
        
        // Update fee calculation when inputs change
        function updateFeeCalculation() {
            const selectedOption = serviceSelect.options[serviceSelect.selectedIndex];
            const baseFee = parseInt(selectedOption.dataset.fee) || 0;
            const age = parseInt(ageInput.value) || 0;
            const isPWD = pwdCheckbox.checked;
            
            if (baseFee > 0) {
                feeDisplay.style.display = 'block';
                document.querySelector('#baseFee').textContent = baseFee;
                
                let discount = 0;
                let discountReason = '';
                
                if (age >= 60) {
                    discount = 0.20;
                    discountReason = 'Senior Citizen';
                } else if (isPWD) {
                    discount = 0.20;
                    discountReason = 'PWD';
                }
                
                const finalFee = baseFee * (1 - discount);
                document.querySelector('#totalFee').textContent = finalFee.toFixed(2);
                
                if (discount > 0) {
                    document.querySelector('#discountInfo').style.display = 'block';
                    document.querySelector('#discountPercent').textContent = (discount * 100);
                    document.querySelector('#discountReason').textContent = discountReason;
                } else {
                    document.querySelector('#discountInfo').style.display = 'none';
                }
            } else {
                feeDisplay.style.display = 'none';
            }
        }
        
        // Listen for changes
        serviceSelect.addEventListener('change', updateFeeCalculation);
        ageInput.addEventListener('input', updateFeeCalculation);
        pwdCheckbox.addEventListener('change', updateFeeCalculation);
        
        // Form validation
        nameInput.addEventListener('input', function() {
            const error = document.querySelector('#nameError');
            if (nameInput.value.trim().length < 3) {
                error.textContent = 'Name must be at least 3 characters';
            } else {
                error.textContent = '';
            }
        });
        
        ageInput.addEventListener('input', function() {
            const error = document.querySelector('#ageError');
            const age = parseInt(ageInput.value);
            if (age < 1 || age > 120) {
                error.textContent = 'Please enter a valid age (1-120)';
            } else {
                error.textContent = '';
            }
        });
        
        // Form submission
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            
            const name = nameInput.value.trim();
            const age = parseInt(ageInput.value);
            const serviceOption = serviceSelect.options[serviceSelect.selectedIndex];
            const serviceName = serviceOption.text;
            const baseFee = parseInt(serviceOption.dataset.fee);
            const isPWD = pwdCheckbox.checked;
            
            let discount = 0;
            let discountReason = '';
            
            if (age >= 60) {
                discount = 0.20;
                discountReason = 'Senior Citizen (20% off)';
            } else if (isPWD) {
                discount = 0.20;
                discountReason = 'PWD (20% off)';
            }
            
            const finalFee = baseFee * (1 - discount);
            
            confirmation.className = 'confirmation';
            confirmation.style.display = 'block';
            confirmation.innerHTML = `
                <h3>✅ Application Submitted Successfully</h3>
                <p><strong>Name:</strong> ${name}</p>
                <p><strong>Age:</strong> ${age}</p>
                <p><strong>Service:</strong> ${serviceName}</p>
                <p><strong>Base Fee:</strong> ₱${baseFee}</p>
                ${discount > 0 ? `<p><strong>Discount:</strong> ${discountReason}</p>` : ''}
                <p><strong>Total Fee:</strong> ₱${finalFee.toFixed(2)}</p>
                <p>Please proceed to the cashier for payment.</p>
            `;
            
            form.reset();
            feeDisplay.style.display = 'none';
            
            // Scroll to confirmation
            confirmation.scrollIntoView({ behavior: 'smooth' });
        });
    </script>
</body>
</html>
```

---

## Best Practices

### 1. Use addEventListener (not inline onclick)
```html
<!-- Bad -->
<button onclick="myFunction()">Click</button>

<!-- Good -->
<button id="myButton">Click</button>
<script>
document.querySelector('#myButton').addEventListener('click', myFunction);
</script>
```

### 2. Prevent default when needed
```javascript
form.addEventListener('submit', function(event) {
    event.preventDefault();  // Stop form from submitting normally
    // Handle with JavaScript instead
});
```

### 3. Remove event listeners when not needed
```javascript
function handleClick() {
    console.log('Clicked');
}

button.addEventListener('click', handleClick);
button.removeEventListener('click', handleClick);
```

---

## Summary

**addEventListener syntax:**
```javascript
element.addEventListener('eventType', function(event) {
    // Code to run
});
```

**Common events:**
- `click` - Button/element clicked
- `input` - Text input changes
- `change` - Select/checkbox changes
- `submit` - Form submitted
- `mouseover` / `mouseout` - Mouse hover

**Event object:**
```javascript
event.target       // Element that triggered event
event.preventDefault()  // Prevent default action
```

Rhea Joy smiled. "Now our pages can respond to users!"

---

## What's Next?

In the next lesson, you'll learn about **Inline CSS with JavaScript**—dynamically styling elements based on user interaction!

---
