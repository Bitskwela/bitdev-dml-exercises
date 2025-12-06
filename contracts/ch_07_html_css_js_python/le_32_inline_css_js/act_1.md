# Activity 1: Inline CSS and JavaScript

In this activity, you'll learn about **inline styles** and **inline JavaScript** - writing CSS and JavaScript directly in your HTML. While this approach has its uses (especially for quick tests), you'll also learn why keeping them separate is usually better for real projects.

---

## Activity 1: Understanding Inline CSS

Inline CSS means writing styles directly in an element's `style` attribute.

### HTML with Inline CSS:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Header</title>
</head>
<body>
    <h1 style="color: blue; text-align: center; font-size: 32px;">
        Welcome to Barangay San Jose
    </h1>
    
    <p style="background-color: #f0f0f0; padding: 15px; border-left: 4px solid green;">
        Your friendly community barangay serving residents since 1950.
    </p>
    
    <button style="background-color: #4caf50; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">
        Apply for Clearance
    </button>
</body>
</html>
```

**Syntax:**
```html
<element style="property: value; property: value;">
```

**When to Use:**
- Quick tests or demos
- One-time specific styling
- Dynamic styles applied via JavaScript

**Why It's Usually Not Recommended:**
- Hard to maintain (styles scattered across HTML)
- Can't reuse styles
- Increases HTML file size
- Can't use pseudo-classes (:hover, :focus)
- Overrides external CSS (high specificity)

---

## Activity 2: Inline CSS vs External CSS

Let's compare the same page with inline vs external CSS.

### With Inline CSS (Messy):
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Services</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f5f5f5;">
    <div style="max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px;">
        <h1 style="color: #2c3e50; margin-bottom: 20px;">Barangay Services</h1>
        
        <div style="padding: 15px; background: #e3f2fd; border-left: 4px solid #1976d2; margin-bottom: 15px;">
            <h3 style="margin: 0 0 10px 0; color: #1976d2;">Barangay Clearance</h3>
            <p style="margin: 0;">Fee: ₱50</p>
        </div>
        
        <div style="padding: 15px; background: #e8f5e9; border-left: 4px solid #4caf50; margin-bottom: 15px;">
            <h3 style="margin: 0 0 10px 0; color: #4caf50;">Business Permit</h3>
            <p style="margin: 0;">Fee: ₱100</p>
        </div>
    </div>
</body>
</html>
```

### With External CSS (Clean and Maintainable):
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Services</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Services</h1>
        
        <div class="service-card blue">
            <h3>Barangay Clearance</h3>
            <p>Fee: ₱50</p>
        </div>
        
        <div class="service-card green">
            <h3>Business Permit</h3>
            <p>Fee: ₱100</p>
        </div>
    </div>
</body>
</html>
```

**styles.css:**
```css
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f5f5f5;
}

.container {
    max-width: 800px;
    margin: 0 auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
}

h1 {
    color: #2c3e50;
    margin-bottom: 20px;
}

.service-card {
    padding: 15px;
    margin-bottom: 15px;
}

.service-card.blue {
    background: #e3f2fd;
    border-left: 4px solid #1976d2;
}

.service-card.blue h3 {
    color: #1976d2;
}

.service-card.green {
    background: #e8f5e9;
    border-left: 4px solid #4caf50;
}

.service-card.green h3 {
    color: #4caf50;
}

.service-card h3 {
    margin: 0 0 10px 0;
}

.service-card p {
    margin: 0;
}
```

**Why External CSS is Better:**
- Cleaner HTML (easier to read)
- Reusable styles
- Can use advanced features (:hover, @media queries)
- Easier to maintain and update
- Smaller HTML files
- Browser caching (faster loading)

---

## Activity 3: Using Inline JavaScript

Inline JavaScript means writing JavaScript directly in HTML using event attributes.

### HTML with Inline JavaScript:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Counter</title>
</head>
<body>
    <h1>Application Counter</h1>
    <p id="counter">Count: 0</p>
    
    <!-- Inline JavaScript using onclick attribute -->
    <button onclick="
        let current = parseInt(document.getElementById('counter').textContent.split(': ')[1]);
        current++;
        document.getElementById('counter').textContent = 'Count: ' + current;
    ">
        Increment
    </button>
    
    <button onclick="
        let current = parseInt(document.getElementById('counter').textContent.split(': ')[1]);
        if (current > 0) {
            current--;
            document.getElementById('counter').textContent = 'Count: ' + current;
        }
    ">
        Decrement
    </button>
    
    <button onclick="document.getElementById('counter').textContent = 'Count: 0';">
        Reset
    </button>
</body>
</html>
```

**Common Inline Event Attributes:**
- `onclick` - When element is clicked
- `onsubmit` - When form is submitted
- `oninput` - When input value changes
- `onchange` - When input loses focus after change
- `onload` - When page/image loads
- `onmouseover` - Mouse enters element
- `onmouseout` - Mouse leaves element

---

## Activity 4: Inline JavaScript vs External JavaScript

Let's compare inline vs external JavaScript for better code organization.

### With Inline JavaScript (Not Recommended):
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Clearance Form</title>
</head>
<body>
    <h1>Barangay Clearance Application</h1>
    
    <form onsubmit="
        event.preventDefault();
        const name = document.getElementById('name').value;
        const age = document.getElementById('age').value;
        const result = document.getElementById('result');
        
        if (name === '') {
            alert('Name is required!');
            return;
        }
        
        if (age < 18) {
            alert('Must be 18 years or older!');
            return;
        }
        
        result.innerHTML = '<h2>Application Submitted!</h2><p>Name: ' + name + '</p><p>Age: ' + age + '</p>';
        result.style.display = 'block';
    ">
        <label>Name:</label><br>
        <input type="text" id="name"><br><br>
        
        <label>Age:</label><br>
        <input type="number" id="age"><br><br>
        
        <button type="submit">Submit</button>
    </form>
    
    <div id="result" style="display: none; margin-top: 20px; padding: 20px; background: #e8f5e9; border-radius: 5px;"></div>
</body>
</html>
```

### With External JavaScript (Recommended):
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Clearance Form</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Barangay Clearance Application</h1>
    
    <form id="clearanceForm">
        <label>Name:</label><br>
        <input type="text" id="name"><br><br>
        
        <label>Age:</label><br>
        <input type="number" id="age"><br><br>
        
        <button type="submit">Submit</button>
    </form>
    
    <div id="result"></div>

    <script src="script.js"></script>
</body>
</html>
```

**script.js:**
```javascript
const form = document.getElementById('clearanceForm');
const result = document.getElementById('result');

form.addEventListener('submit', function(event) {
    event.preventDefault();
    
    const name = document.getElementById('name').value.trim();
    const age = parseInt(document.getElementById('age').value);
    
    // Validation
    if (name === '') {
        alert('Name is required!');
        return;
    }
    
    if (age < 18) {
        alert('Must be 18 years or older!');
        return;
    }
    
    // Display result
    result.innerHTML = `
        <h2>Application Submitted!</h2>
        <p><strong>Name:</strong> ${name}</p>
        <p><strong>Age:</strong> ${age}</p>
    `;
    result.classList.add('show');
});
```

**styles.css:**
```css
body {
    font-family: Arial, sans-serif;
    max-width: 600px;
    margin: 50px auto;
    padding: 20px;
}

h1 {
    color: #2c3e50;
}

input {
    width: 100%;
    padding: 8px;
    border: 2px solid #ddd;
    border-radius: 5px;
}

button {
    padding: 10px 20px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background: #45a049;
}

#result {
    display: none;
    margin-top: 20px;
    padding: 20px;
    background: #e8f5e9;
    border-radius: 5px;
}

#result.show {
    display: block;
}
```

**Why External JavaScript is Better:**
- Cleaner HTML
- Easier to debug
- Can reuse functions
- Better organization
- Proper error handling
- Code editor features (autocomplete, syntax highlighting)
- Can be cached by browser

---

## Activity 5: When Inline Styles Are Acceptable

Sometimes inline styles make sense, especially when set dynamically via JavaScript.

### Using JavaScript to Set Inline Styles:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dynamic Styling</title>
    <style>
        .service-card {
            padding: 20px;
            margin: 10px 0;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        button {
            margin: 5px;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Barangay Service Status</h1>
    
    <div class="service-card" id="serviceCard">
        <h2>Clearance Processing</h2>
        <p>Current Status: <span id="status">Pending</span></p>
    </div>
    
    <button onclick="setStatus('processing', '#ffc107', 'Processing')">Processing</button>
    <button onclick="setStatus('approved', '#4caf50', 'Approved')">Approved</button>
    <button onclick="setStatus('rejected', '#f44336', 'Rejected')">Rejected</button>

    <script>
        function setStatus(statusClass, color, text) {
            const card = document.getElementById('serviceCard');
            const statusSpan = document.getElementById('status');
            
            // Set inline styles dynamically (acceptable use case!)
            card.style.backgroundColor = color + '20'; // 20 adds transparency
            card.style.borderLeft = '4px solid ' + color;
            
            statusSpan.textContent = text;
            statusSpan.style.color = color;
            statusSpan.style.fontWeight = 'bold';
        }
    </script>
</body>
</html>
```

**When Inline Styles Are OK:**
- **Dynamic styling via JavaScript** - Colors, positions, sizes calculated at runtime
- **User preferences** - Font size, theme colors chosen by user
- **Animations** - Manipulating properties frame-by-frame
- **Third-party widgets** - When you can't control external CSS
- **Email HTML** - Email clients often require inline styles

---

## Activity 6: Mixing Inline and External (Practical Example)

A realistic scenario combining external CSS with dynamic inline styles.

### HTML:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resident Dashboard</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <div class="container">
        <h1>Resident Dashboard</h1>
        
        <div class="controls">
            <label>Choose Theme:</label>
            <select id="themeSelect">
                <option value="">Default</option>
                <option value="#e3f2fd">Blue</option>
                <option value="#e8f5e9">Green</option>
                <option value="#fff3e0">Orange</option>
            </select>
            
            <label>Font Size:</label>
            <input type="range" id="fontSlider" min="12" max="24" value="16">
            <span id="fontSize">16px</span>
        </div>
        
        <div class="content" id="content">
            <h2>Your Clearance Applications</h2>
            <ul>
                <li>Barangay Clearance - Approved</li>
                <li>Business Permit - Pending</li>
                <li>Police Clearance - Processing</li>
            </ul>
        </div>
    </div>

    <script src="dashboard.js"></script>
</body>
</html>
```

**dashboard.css (External - Base Styles):**
```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    padding: 20px;
    background: #f5f5f5;
}

.container {
    max-width: 800px;
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

.controls {
    padding: 15px;
    background: #f9f9f9;
    border-radius: 5px;
    margin-bottom: 20px;
}

.controls label {
    display: inline-block;
    margin-right: 10px;
    font-weight: bold;
}

.controls select,
.controls input {
    margin-right: 20px;
}

.content {
    padding: 20px;
    border-radius: 5px;
    transition: all 0.3s;
}

.content h2 {
    margin-bottom: 15px;
    color: #333;
}

.content ul {
    list-style-position: inside;
}

.content li {
    padding: 10px 0;
    border-bottom: 1px solid #eee;
}
```

**dashboard.js (JavaScript - Dynamic Inline Styles):**
```javascript
const themeSelect = document.getElementById('themeSelect');
const fontSlider = document.getElementById('fontSlider');
const fontSizeDisplay = document.getElementById('fontSize');
const content = document.getElementById('content');

// Theme change (inline style for dynamic background)
themeSelect.addEventListener('change', function() {
    const color = themeSelect.value;
    
    if (color) {
        // Apply inline style for user-chosen theme
        content.style.backgroundColor = color;
    } else {
        // Remove inline style to use default CSS
        content.style.backgroundColor = '';
    }
});

// Font size change (inline style for user preference)
fontSlider.addEventListener('input', function() {
    const size = fontSlider.value + 'px';
    
    // Apply inline style for user preference
    content.style.fontSize = size;
    fontSizeDisplay.textContent = size;
});
```

**This demonstrates:**
- External CSS for consistent base styling
- JavaScript-applied inline styles for dynamic user preferences
- Clean separation of concerns
- User customization without modifying CSS files

---

## Activity 7: Best Practices Summary

### Complete Example with All Best Practices:

**index.html (Clean HTML, No Inline Code):**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Clearance System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🏘️ Barangay San Jose</h1>
            <p class="tagline">Your Community, Your Home</p>
        </header>
        
        <main>
            <section class="services">
                <h2>Available Services</h2>
                <div class="service-grid">
                    <div class="service-card" data-fee="50">
                        <h3>Barangay Clearance</h3>
                        <p class="fee">₱50</p>
                        <button class="apply-btn">Apply Now</button>
                    </div>
                    
                    <div class="service-card" data-fee="100">
                        <h3>Business Permit</h3>
                        <p class="fee">₱100</p>
                        <button class="apply-btn">Apply Now</button>
                    </div>
                    
                    <div class="service-card" data-fee="30">
                        <h3>Barangay ID</h3>
                        <p class="fee">₱30</p>
                        <button class="apply-btn">Apply Now</button>
                    </div>
                </div>
            </section>
            
            <section class="form-section" id="formSection" style="display: none;">
                <h2>Application Form</h2>
                <form id="applicationForm">
                    <div class="form-group">
                        <label for="name">Full Name:</label>
                        <input type="text" id="name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="service">Service:</label>
                        <input type="text" id="service" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label for="purpose">Purpose:</label>
                        <textarea id="purpose" rows="4" required></textarea>
                    </div>
                    
                    <div class="fee-summary">
                        <p>Total Fee: <span id="totalFee">₱0</span></p>
                    </div>
                    
                    <button type="submit" class="submit-btn">Submit Application</button>
                    <button type="button" class="cancel-btn">Cancel</button>
                </form>
            </section>
            
            <section class="result-section" id="resultSection" style="display: none;">
                <h2>Application Submitted!</h2>
                <div id="applicationDetails"></div>
                <button class="new-app-btn">New Application</button>
            </section>
        </main>
    </div>

    <script src="script.js"></script>
</body>
</html>
```

**styles.css (All Styling in External File):**
```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
}

.container {
    max-width: 1000px;
    margin: 0 auto;
    background: white;
    border-radius: 15px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.2);
    overflow: hidden;
}

header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 40px 30px;
    text-align: center;
}

header h1 {
    font-size: 2.5em;
    margin-bottom: 10px;
}

.tagline {
    font-size: 1.2em;
    opacity: 0.9;
}

main {
    padding: 40px 30px;
}

.services h2 {
    color: #333;
    margin-bottom: 30px;
    text-align: center;
}

.service-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
}

.service-card {
    background: #f9f9f9;
    padding: 30px;
    border-radius: 10px;
    text-align: center;
    transition: transform 0.3s, box-shadow 0.3s;
    border: 2px solid transparent;
}

.service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    border-color: #667eea;
}

.service-card h3 {
    color: #667eea;
    margin-bottom: 15px;
    font-size: 1.3em;
}

.fee {
    font-size: 2em;
    color: #4caf50;
    font-weight: bold;
    margin: 20px 0;
}

.apply-btn {
    background: #667eea;
    color: white;
    padding: 12px 30px;
    border: none;
    border-radius: 25px;
    cursor: pointer;
    font-size: 1em;
    transition: background 0.3s;
}

.apply-btn:hover {
    background: #5568d3;
}

.form-section,
.result-section {
    animation: fadeIn 0.5s;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.form-section h2,
.result-section h2 {
    color: #333;
    margin-bottom: 25px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #555;
    font-weight: bold;
}

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 8px;
    font-size: 1em;
    transition: border-color 0.3s;
}

.form-group input:focus,
.form-group textarea:focus {
    border-color: #667eea;
    outline: none;
}

.fee-summary {
    background: #e8f5e9;
    padding: 20px;
    border-radius: 8px;
    margin: 20px 0;
    text-align: center;
}

.fee-summary p {
    font-size: 1.3em;
    color: #2e7d32;
}

#totalFee {
    font-weight: bold;
    font-size: 1.5em;
}

.submit-btn,
.new-app-btn {
    background: #4caf50;
    color: white;
    padding: 15px 40px;
    border: none;
    border-radius: 25px;
    cursor: pointer;
    font-size: 1em;
    margin-right: 10px;
    transition: background 0.3s;
}

.submit-btn:hover,
.new-app-btn:hover {
    background: #45a049;
}

.cancel-btn {
    background: #f44336;
    color: white;
    padding: 15px 40px;
    border: none;
    border-radius: 25px;
    cursor: pointer;
    font-size: 1em;
    transition: background 0.3s;
}

.cancel-btn:hover {
    background: #da190b;
}

#applicationDetails {
    background: #f9f9f9;
    padding: 25px;
    border-radius: 8px;
    margin: 20px 0;
}

#applicationDetails p {
    margin: 10px 0;
    font-size: 1.1em;
}

#applicationDetails strong {
    color: #667eea;
}

@media (max-width: 768px) {
    .service-grid {
        grid-template-columns: 1fr;
    }
    
    header h1 {
        font-size: 2em;
    }
}
```

**script.js (All JavaScript Logic):**
```javascript
// Get all elements
const serviceCards = document.querySelectorAll('.service-card');
const formSection = document.getElementById('formSection');
const resultSection = document.getElementById('resultSection');
const applicationForm = document.getElementById('applicationForm');
const serviceInput = document.getElementById('service');
const totalFeeSpan = document.getElementById('totalFee');
const applicationDetails = document.getElementById('applicationDetails');

let currentFee = 0;
let currentService = '';

// Handle service card clicks
serviceCards.forEach(card => {
    const applyBtn = card.querySelector('.apply-btn');
    
    applyBtn.addEventListener('click', function() {
        currentService = card.querySelector('h3').textContent;
        currentFee = parseInt(card.getAttribute('data-fee'));
        
        serviceInput.value = currentService;
        totalFeeSpan.textContent = `₱${currentFee}`;
        
        // Show form section
        document.querySelector('.services').style.display = 'none';
        formSection.style.display = 'block';
    });
});

// Handle form submission
applicationForm.addEventListener('submit', function(event) {
    event.preventDefault();
    
    const name = document.getElementById('name').value.trim();
    const purpose = document.getElementById('purpose').value.trim();
    
    // Generate application number
    const appNumber = 'BR-' + Date.now();
    
    // Display result
    applicationDetails.innerHTML = `
        <p><strong>Application Number:</strong> ${appNumber}</p>
        <p><strong>Name:</strong> ${name}</p>
        <p><strong>Service:</strong> ${currentService}</p>
        <p><strong>Purpose:</strong> ${purpose}</p>
        <p><strong>Fee:</strong> ₱${currentFee}</p>
        <p style="color: green; margin-top: 20px;">
            ✅ Your application has been received. Please proceed to the Barangay Office for payment.
        </p>
    `;
    
    // Show result section
    formSection.style.display = 'none';
    resultSection.style.display = 'block';
    
    // Reset form
    applicationForm.reset();
});

// Handle cancel button
document.querySelector('.cancel-btn').addEventListener('click', function() {
    formSection.style.display = 'none';
    document.querySelector('.services').style.display = 'block';
    applicationForm.reset();
});

// Handle new application button
document.querySelector('.new-app-btn').addEventListener('click', function() {
    resultSection.style.display = 'none';
    document.querySelector('.services').style.display = 'block';
});
```

**This example demonstrates:**
- ✅ Clean HTML with no inline CSS or JavaScript
- ✅ All styles in external CSS file
- ✅ All logic in external JavaScript file
- ✅ Proper separation of concerns
- ✅ Easy to maintain and update
- ✅ Professional, modern design
- ✅ Responsive layout
- ✅ Smooth animations

---

## 📚 Answer Key: Inline vs External

### Comparison Table

| Aspect | Inline CSS/JS | External CSS/JS |
|--------|--------------|-----------------|
| **Maintainability** | ❌ Hard to maintain | ✅ Easy to maintain |
| **Reusability** | ❌ Cannot reuse | ✅ Highly reusable |
| **Organization** | ❌ Scattered code | ✅ Well organized |
| **File Size** | ❌ Larger HTML | ✅ Smaller HTML |
| **Caching** | ❌ No caching | ✅ Browser caching |
| **Debugging** | ❌ Difficult | ✅ Easier with dev tools |
| **Collaboration** | ❌ Merge conflicts | ✅ Separate files |
| **Performance** | ❌ Slower initial load | ✅ Faster with caching |

### When to Use Inline

**Inline CSS:**
```javascript
// ✅ Good: Dynamic styling via JavaScript
element.style.backgroundColor = userPreference.color;
element.style.left = calculatedPosition + 'px';

// ❌ Bad: Static styling that could be in CSS
<div style="color: blue; padding: 20px;">
```

**Inline JavaScript:**
```html
<!-- ❌ Never recommended for production -->
<button onclick="alert('Hello')">Click</button>

<!-- ✅ Use external JS instead -->
<button id="myButton">Click</button>
<script src="script.js"></script>
```

### Inline Styles Applied by JavaScript

```javascript
// Acceptable use cases:

// 1. User preferences
element.style.fontSize = userFontSize + 'px';

// 2. Dynamic calculations
element.style.width = (containerWidth * 0.5) + 'px';

// 3. Animation frames
element.style.transform = `translateX(${position}px)`;

// 4. Conditional styling based on data
if (score > 90) {
    element.style.backgroundColor = 'green';
} else if (score > 50) {
    element.style.backgroundColor = 'yellow';
} else {
    element.style.backgroundColor = 'red';
}
```

### Best Practices Checklist

**HTML:**
- ✅ No `style=""` attributes (use classes instead)
- ✅ No `onclick=""` attributes (use addEventListener)
- ✅ Link external CSS in `<head>`
- ✅ Link external JS before `</body>`
- ✅ Use semantic HTML
- ✅ Use data attributes for configuration

**CSS:**
- ✅ Keep all styles in .css files
- ✅ Use classes for styling
- ✅ Use CSS variables for theme values
- ✅ Organize with comments
- ✅ Use meaningful class names
- ✅ Follow naming conventions (BEM, SMACSS, etc.)

**JavaScript:**
- ✅ Keep all logic in .js files
- ✅ Use addEventListener (never inline handlers)
- ✅ Apply inline styles only when dynamic
- ✅ Use classes for static styling
- ✅ Keep functions small and focused
- ✅ Use comments for complex logic

---

## 🎯 Key Takeaways

1. **Inline CSS** (`style=""`) makes HTML messy and hard to maintain
2. **Inline JavaScript** (`onclick=""`) is outdated and problematic
3. **External files** (.css and .js) are the professional standard
4. **JavaScript-applied inline styles** are OK for dynamic/calculated values
5. **Separation of concerns** makes code cleaner and easier to work with
6. **Browser caching** works better with external files
7. Always prefer **external CSS/JS** unless you have a specific reason not to

---

## 🚀 Practice Challenge

Take this messy inline code and refactor it into proper external files:

```html
<!DOCTYPE html>
<html>
<head><title>Barangay Portal</title></head>
<body style="font-family: Arial; margin: 0; padding: 20px; background: #f5f5f5;">
    <div style="max-width: 800px; margin: 0 auto; background: white; padding: 30px;">
        <h1 style="color: #2c3e50;">Welcome</h1>
        <button onclick="
            let count = parseInt(document.getElementById('count').textContent);
            count++;
            document.getElementById('count').textContent = count;
        " style="padding: 10px 20px; background: blue; color: white; border: none;">
            Click Me
        </button>
        <p>Count: <span id="count">0</span></p>
    </div>
</body>
</html>
```

**Create three files:**
1. `index.html` - Clean HTML
2. `styles.css` - All styling
3. `script.js` - All logic

Good luck! 🎉
