# Quiz: Inline CSS with JavaScript

---

## Quiz 1

**1. How do you set the background color of an element using JavaScript?**

a) `element.style.background-color = 'blue';`  
b) `element.style.backgroundColor = 'blue';`  
c) `element.style['background-color'] = 'blue';`  
d) Both b and c

---

**2. What does `classList.toggle('active')` do?**

a) Adds the 'active' class  
b) Removes the 'active' class  
c) Adds the class if not present, removes if present  
d) Checks if the class exists

---

**3. Which is the better approach for styling elements?**

a) Always use inline styles with `element.style`  
b) Define CSS classes and toggle them with `classList`  
c) Use both simultaneously  
d) Write styles directly in JavaScript strings

---

**4. What does `element.style.fontSize = '20px'` do?**

a) Sets font size to 20 pixels  
b) Returns the current font size  
c) Causes an error  
d) Sets font weight to 20

---

**5. How do you check if an element has a specific class?**

a) `element.hasClass('className')`  
b) `element.classList.has('className')`  
c) `element.classList.contains('className')`  
d) `element.containsClass('className')`

---

## Quiz 2

**6. What happens when you set `element.style.display = 'none'`?**

a) Element becomes invisible but takes up space  
b) Element is hidden and removed from layout  
c) Element becomes transparent  
d) Element changes to inline display

---

**7. How do you add multiple classes at once?**

a) `element.classList.add('class1', 'class2', 'class3');`  
b) `element.classList.add(['class1', 'class2', 'class3']);`  
c) `element.classList = 'class1 class2 class3';`  
d) Both a and c

---

**8. What does this code do? `element.style.transition = 'all 0.3s ease';`**

a) Creates a CSS animation  
b) Makes all property changes animate over 0.3 seconds  
c) Delays all changes by 0.3 seconds  
d) Causes an error

---

**9. How do you remove all classes from an element?**

a) `element.classList.removeAll();`  
b) `element.classList.clear();`  
c) `element.className = '';`  
d) `element.classList = [];`

---

**10. Which CSS property name is correct in JavaScript?**

a) `element.style.border-radius = '5px';`  
b) `element.style.borderRadius = '5px';`  
c) `element.style['border radius'] = '5px';`  
d) `element.style.BorderRadius = '5px';`

---

## Answers

1. **d** - Both b and c  
2. **c** - Adds the class if not present, removes if present  
3. **b** - Define CSS classes and toggle them with classList  
4. **a** - Sets font size to 20 pixels  
5. **c** - `element.classList.contains('className')`  
6. **b** - Element is hidden and removed from layout  
7. **a** - `element.classList.add('class1', 'class2', 'class3');`  
8. **b** - Makes all property changes animate over 0.3 seconds  
9. **c** - `element.className = '';`  
10. **b** - `element.style.borderRadius = '5px';`

---

## Detailed Explanations

### Question 1: Setting Background Color

**Correct Answer: d) Both b and c**

In JavaScript, CSS property names with hyphens must use camelCase:

```javascript
// Correct - camelCase
element.style.backgroundColor = 'blue';

// Also correct - bracket notation with hyphen
element.style['background-color'] = 'blue';

// WRONG - causes syntax error
element.style.background-color = 'blue'; // Invalid!
```

**Barangay example:**
```javascript
let officeStatus = document.querySelector('#officeStatus');

// Change background based on office hours
if (isOpen) {
    officeStatus.style.backgroundColor = '#28a745'; // Green - open
} else {
    officeStatus.style.backgroundColor = '#dc3545'; // Red - closed
}
```

---

### Question 2: classList.toggle()

**Correct Answer: c) Adds the class if not present, removes if present**

`toggle()` is a convenient method that switches a class on/off:

```javascript
// If element doesn't have 'active', it adds it
// If element has 'active', it removes it
element.classList.toggle('active');

// Useful for buttons, switches, menus
button.addEventListener('click', function() {
    menu.classList.toggle('show'); // Show/hide menu
});
```

**Barangay example:**
```javascript
let serviceCard = document.querySelector('#serviceCard');
let toggleBtn = document.querySelector('#toggleBtn');

toggleBtn.addEventListener('click', function() {
    // Toggle availability status
    serviceCard.classList.toggle('available');
    serviceCard.classList.toggle('unavailable');
    
    if (serviceCard.classList.contains('available')) {
        toggleBtn.textContent = 'Mark as Unavailable';
    } else {
        toggleBtn.textContent = 'Mark as Available';
    }
});
```

---

### Question 3: Better Styling Approach

**Correct Answer: b) Define CSS classes and toggle them with classList**

**Why classList is better:**
1. **Separation of concerns** - styles in CSS, logic in JS
2. **Reusability** - one CSS class used in many places
3. **Maintainability** - change styles without touching JS
4. **Performance** - browser optimizes CSS better

```javascript
/* Good approach */
// CSS
.success { background-color: #28a745; color: white; padding: 10px; }
.error { background-color: #dc3545; color: white; padding: 10px; }

// JavaScript
if (isValid) {
    element.classList.add('success');
} else {
    element.classList.add('error');
}

/* Bad approach - harder to maintain */
if (isValid) {
    element.style.backgroundColor = '#28a745';
    element.style.color = 'white';
    element.style.padding = '10px';
} else {
    element.style.backgroundColor = '#dc3545';
    element.style.color = 'white';
    element.style.padding = '10px';
}
```

**When to use `style` directly:**
- Dynamic values calculated at runtime
- User-controlled values (slider, color picker)

```javascript
// Good use of style - dynamic value
let width = calculateWidth(); // Function returns number
element.style.width = width + 'px';

// Good use of style - user input
colorPicker.addEventListener('change', function() {
    element.style.backgroundColor = this.value;
});
```

---

### Question 4: Setting Font Size

**Correct Answer: a) Sets font size to 20 pixels**

```javascript
element.style.fontSize = '20px';
```

This directly modifies the inline style, equivalent to:
```html
<div style="font-size: 20px;">Text</div>
```

**Important:** Always include units (`px`, `em`, `%`, `rem`)

```javascript
// Correct
element.style.fontSize = '20px';
element.style.width = '100%';
element.style.padding = '1.5rem';

// Wrong - browser may ignore
element.style.fontSize = 20; // Missing 'px'
```

**Barangay example - dynamic text scaling:**
```javascript
let heading = document.querySelector('#barangayName');
let slider = document.querySelector('#sizeSlider');

slider.addEventListener('input', function() {
    let size = this.value; // e.g., 16-48
    heading.style.fontSize = size + 'px';
});
```

---

### Question 5: Checking for Class

**Correct Answer: c) `element.classList.contains('className')`**

```javascript
if (element.classList.contains('active')) {
    console.log('Element is active!');
}

// Returns true or false
let hasError = input.classList.contains('error'); // true/false
```

**Barangay example - conditional logic:**
```javascript
let serviceCard = document.querySelector('#clearanceService');

if (serviceCard.classList.contains('unavailable')) {
    alert('Barangay Clearance service is currently unavailable. Please try later.');
} else {
    // Proceed with application
    showApplicationForm();
}

// Use in validation
function validateForm() {
    let inputs = document.querySelectorAll('input');
    let allValid = true;
    
    inputs.forEach(input => {
        if (input.classList.contains('invalid')) {
            allValid = false;
        }
    });
    
    return allValid;
}
```

---

### Question 6: display: none

**Correct Answer: b) Element is hidden and removed from layout**

```javascript
element.style.display = 'none'; // Completely hidden, no space
element.style.visibility = 'hidden'; // Hidden, but takes up space
element.style.opacity = '0'; // Invisible, but takes up space
```

**Comparison:**

| Property | Visible | Takes Space | Clickable |
|----------|---------|-------------|-----------|
| `display: none` | ❌ | ❌ | ❌ |
| `visibility: hidden` | ❌ | ✅ | ❌ |
| `opacity: 0` | ❌ | ✅ | ✅ |

**Barangay example - show/hide sections:**
```javascript
let pendingSection = document.querySelector('#pendingApplications');
let completedSection = document.querySelector('#completedApplications');
let tabBtn = document.querySelector('#showCompleted');

tabBtn.addEventListener('click', function() {
    // Hide pending, show completed
    pendingSection.style.display = 'none';
    completedSection.style.display = 'block';
});
```

---

### Question 7: Adding Multiple Classes

**Correct Answer: a) `element.classList.add('class1', 'class2', 'class3');`**

```javascript
// Correct - add multiple classes
element.classList.add('active', 'highlight', 'bordered');

// Also works - one at a time
element.classList.add('active');
element.classList.add('highlight');
element.classList.add('bordered');

// Option c also works but replaces ALL classes
element.className = 'class1 class2 class3'; // Replaces existing classes
```

**Barangay example:**
```javascript
let application = document.querySelector('#application-001');

// Mark as urgent, high-priority, reviewed
application.classList.add('urgent', 'high-priority', 'reviewed');

// Remove multiple classes
application.classList.remove('pending', 'unread');
```

---

### Question 8: CSS Transitions

**Correct Answer: b) Makes all property changes animate over 0.3 seconds**

```javascript
element.style.transition = 'all 0.3s ease';

// Now any style changes will animate
element.style.backgroundColor = 'blue'; // Animates!
element.style.transform = 'scale(1.2)'; // Animates!
```

**Better approach - define in CSS:**
```css
.box {
    transition: all 0.3s ease;
}
```

**Barangay example - smooth status changes:**
```html
<style>
.status-card {
    padding: 20px;
    transition: all 0.3s ease;
}

.status-card.approved {
    background-color: #28a745;
    transform: scale(1.05);
}
</style>

<script>
let card = document.querySelector('#applicationCard');

// When approved, changes animate smoothly
function approveApplication() {
    card.classList.add('approved');
}
</script>
```

---

### Question 9: Remove All Classes

**Correct Answer: c) `element.className = '';`**

```javascript
// Remove all classes
element.className = '';

// Alternative - remove one by one
element.classList.remove('class1', 'class2', 'class3');
```

**Note:** `className` replaces entire class attribute:
```javascript
element.className = 'newClass'; // Removes all, adds 'newClass'
element.classList.add('newClass'); // Adds without removing others
```

**Barangay example - reset form styling:**
```javascript
function resetForm() {
    let inputs = document.querySelectorAll('input');
    
    inputs.forEach(input => {
        // Remove all validation classes
        input.className = 'form-control'; // Reset to base class
        // Or
        input.classList.remove('valid', 'invalid', 'error');
    });
}
```

---

### Question 10: CSS Property Names in JS

**Correct Answer: b) `element.style.borderRadius = '5px';`**

**CSS to JavaScript naming rules:**
- Remove hyphens
- Capitalize first letter after hyphen (camelCase)
- First word stays lowercase

**Examples:**
```javascript
// CSS → JavaScript
background-color → backgroundColor
border-radius → borderRadius
font-size → fontSize
margin-top → marginTop
text-align → textAlign
z-index → zIndex
```

**Barangay example:**
```javascript
let card = document.querySelector('#serviceCard');

// Apply multiple styles
card.style.backgroundColor = '#007bff';
card.style.color = 'white';
card.style.padding = '20px';
card.style.borderRadius = '10px';
card.style.boxShadow = '0 4px 6px rgba(0,0,0,0.1)';
card.style.marginBottom = '15px';
card.style.fontSize = '18px';
card.style.textAlign = 'center';
```

---
