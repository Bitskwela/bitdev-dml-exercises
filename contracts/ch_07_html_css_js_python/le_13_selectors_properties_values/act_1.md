# Lesson 13 Activities: Selectors, Properties, and Values

## Targeting HTML Elements with Precision

Master CSS selectors to style exactly what you want, and learn essential properties and values!

---

## Activity 1: Basic Selectors

**Goal:** Learn element, class, and ID selectors.

**Create:** `basic-selectors.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Basic Selectors</title>
    <link rel="stylesheet" href="basic-selectors.css">
</head>
<body>
    <h1>Barangay Sto. Niño</h1>
    <p>This is a regular paragraph.</p>
    <p class="highlight">This paragraph has class="highlight"</p>
    <p id="special">This paragraph has id="special"</p>
    <p class="highlight">Another highlighted paragraph</p>
    
    <div class="box">
        <h2>Service Information</h2>
        <p>Content inside a box div.</p>
    </div>
    
    <div class="box featured">
        <h2>Featured Service</h2>
        <p>This box has two classes: box and featured.</p>
    </div>
</body>
</html>
```

**Create:** `basic-selectors.css`

```css
/* ELEMENT SELECTOR - Selects all elements of that type */
p {
    color: #333;
    line-height: 1.6;
}

h1 {
    color: #4CAF50;
    text-align: center;
}

h2 {
    color: #0066cc;
}

/* CLASS SELECTOR - Starts with dot (.) */
.highlight {
    background-color: yellow;
    padding: 10px;
    border-left: 4px solid orange;
}

.box {
    background-color: #f4f4f4;
    padding: 20px;
    margin: 20px 0;
    border-radius: 5px;
}

/* Multiple classes on same element */
.featured {
    border: 3px solid #4CAF50;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

/* ID SELECTOR - Starts with hash (#) */
#special {
    background-color: #e3f2fd;
    padding: 15px;
    border: 2px dashed #0066cc;
    font-weight: bold;
}
```

**Key differences:**
- **Element selector:** Styles ALL elements of that type
- **Class selector:** Reusable, multiple per page
- **ID selector:** Unique, only ONE per page

---

## Activity 2: Combinator Selectors

**Goal:** Select elements based on relationships.

**Create:** `combinators.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Combinator Selectors</title>
    <link rel="stylesheet" href="combinators.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Services</h1>
        <p>Introduction paragraph.</p>
        
        <div class="service">
            <h2>Barangay Clearance</h2>
            <p>Required for employment.</p>
            <span>Processing time: Same day</span>
        </div>
        
        <div class="service">
            <h2>Barangay ID</h2>
            <p>Official identification.</p>
            <span>Processing time: 3 days</span>
        </div>
    </div>
    
    <p>Paragraph outside container.</p>
</body>
</html>
```

**Create:** `combinators.css`

```css
/* DESCENDANT SELECTOR (space) - All descendants */
.container p {
    color: #666;
    font-size: 16px;
}

/* CHILD SELECTOR (>) - Direct children only */
.container > p {
    background-color: #ffffcc;
    padding: 10px;
}

/* ADJACENT SIBLING (+) - Immediately following sibling */
h2 + p {
    font-weight: bold;
    color: #0066cc;
}

/* GENERAL SIBLING (~) - All following siblings */
h2 ~ span {
    display: block;
    color: #999;
    font-size: 14px;
    margin-top: 10px;
}

/* Combining selectors */
.service > h2 {
    color: #4CAF50;
    border-bottom: 2px solid #4CAF50;
    padding-bottom: 5px;
}
```

**Combinator types:**
- `A B` - Descendant (all B inside A)
- `A > B` - Child (direct B children of A)
- `A + B` - Adjacent sibling (B immediately after A)
- `A ~ B` - General sibling (all B siblings after A)

---

## Activity 3: Attribute Selectors

**Goal:** Select elements by attributes.

**Create:** `attributes.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Attribute Selectors</title>
    <link rel="stylesheet" href="attributes.css">
</head>
<body>
    <h1>Download Forms</h1>
    
    <ul>
        <li><a href="clearance.pdf">Clearance Form</a></li>
        <li><a href="id-application.pdf">ID Application</a></li>
        <li><a href="https://example.com" target="_blank">External Link</a></li>
        <li><a href="permit.doc">Business Permit Form</a></li>
    </ul>
    
    <form>
        <input type="text" placeholder="Name" required>
        <input type="email" placeholder="Email" required>
        <input type="tel" placeholder="Phone">
        <button type="submit">Submit</button>
    </form>
</body>
</html>
```

**Create:** `attributes.css`

```css
/* Has attribute */
[required] {
    border: 2px solid #ff6b6b;
}

/* Exact match */
[type="email"] {
    background-color: #e3f2fd;
}

/* Contains word */
[href*="pdf"] {
    color: #d32f2f;
    font-weight: bold;
}

[href*="pdf"]::after {
    content: " 📄";
}

/* Starts with */
[href^="https"] {
    color: #4CAF50;
}

[href^="https"]::after {
    content: " 🔗";
}

/* Ends with */
[href$=".doc"] {
    color: #0066cc;
}

[href$=".doc"]::after {
    content: " 📝";
}

/* Target attribute exists */
[target] {
    background-color: #fff3cd;
    padding: 2px 5px;
}
```

**Attribute selector patterns:**
- `[attr]` - Has attribute
- `[attr="value"]` - Exact match
- `[attr^="value"]` - Starts with
- `[attr$="value"]` - Ends with
- `[attr*="value"]` - Contains
- `[attr~="value"]` - Contains word

---

## Activity 4: Pseudo-classes

**Goal:** Style elements based on state.

**Create:** `pseudo-classes.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Pseudo-classes</title>
    <link rel="stylesheet" href="pseudo-classes.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="index.html">Home</a></li>
            <li><a href="services.html">Services</a></li>
            <li><a href="contact.html">Contact</a></li>
        </ul>
    </nav>
    
    <div class="services">
        <div class="service-item">First Service</div>
        <div class="service-item">Second Service</div>
        <div class="service-item">Third Service</div>
        <div class="service-item">Fourth Service</div>
        <div class="service-item">Fifth Service</div>
    </div>
    
    <form>
        <input type="text" placeholder="Name" required>
        <input type="email" placeholder="Email">
        <button type="submit">Submit</button>
    </form>
</body>
</html>
```

**Create:** `pseudo-classes.css`

```css
/* LINK PSEUDO-CLASSES */
a:link {
    color: #0066cc;
    text-decoration: none;
}

a:visited {
    color: #663399;
}

a:hover {
    color: #ff6b6b;
    text-decoration: underline;
}

a:active {
    color: #d32f2f;
}

/* STRUCTURAL PSEUDO-CLASSES */
.service-item:first-child {
    background-color: #4CAF50;
    color: white;
    font-weight: bold;
}

.service-item:last-child {
    background-color: #ff9800;
    color: white;
}

.service-item:nth-child(odd) {
    background-color: #f4f4f4;
}

.service-item:nth-child(even) {
    background-color: #e0e0e0;
}

.service-item:nth-child(3) {
    border: 3px solid #0066cc;
}

/* USER ACTION PSEUDO-CLASSES */
button:hover {
    background-color: #45a049;
    cursor: pointer;
    transform: scale(1.05);
}

button:active {
    transform: scale(0.95);
}

input:focus {
    outline: 2px solid #0066cc;
    background-color: #e3f2fd;
}

input:required {
    border-left: 4px solid #ff6b6b;
}

input:valid {
    border-left: 4px solid #4CAF50;
}

input:invalid {
    border-left: 4px solid #d32f2f;
}

/* NOT PSEUDO-CLASS */
.service-item:not(:first-child) {
    margin-top: 10px;
}
```

**Common pseudo-classes:**
- `:hover` - Mouse over
- `:active` - Being clicked
- `:focus` - Has keyboard focus
- `:first-child` - First child
- `:last-child` - Last child
- `:nth-child(n)` - Nth child
- `:not(selector)` - Negation

---

## Activity 5: Pseudo-elements

**Goal:** Style specific parts of elements.

**Create:** `pseudo-elements.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Pseudo-elements</title>
    <link rel="stylesheet" href="pseudo-elements.css">
</head>
<body>
    <h1>Barangay Sto. Niño</h1>
    
    <p class="intro">
        Welcome to our official website. We serve the community with dedication and transparency.
    </p>
    
    <ul class="checklist">
        <li>Barangay Clearance</li>
        <li>Barangay ID</li>
        <li>Business Permit</li>
    </ul>
    
    <blockquote>
        "Service to the people is the highest form of leadership."
    </blockquote>
    
    <a href="document.pdf" class="download-link">Download Form</a>
</body>
</html>
```

**Create:** `pseudo-elements.css`

```css
/* FIRST LETTER */
.intro::first-letter {
    font-size: 3em;
    font-weight: bold;
    color: #4CAF50;
    float: left;
    line-height: 1;
    margin-right: 5px;
}

/* FIRST LINE */
.intro::first-line {
    font-weight: bold;
    color: #0066cc;
}

/* BEFORE and AFTER */
h1::before {
    content: "🏛️ ";
}

h1::after {
    content: " 🏛️";
}

/* Custom bullets */
.checklist {
    list-style: none;
    padding-left: 0;
}

.checklist li::before {
    content: "✅ ";
    margin-right: 10px;
}

/* Quote marks */
blockquote::before {
    content: """;
    font-size: 4em;
    color: #4CAF50;
    position: absolute;
    left: 10px;
    top: 10px;
}

blockquote {
    position: relative;
    padding: 40px 20px 20px 60px;
    background: #f4f4f4;
    font-style: italic;
}

/* Download icon */
.download-link::after {
    content: " ⬇️";
}

/* SELECTION (highlighted text) */
::selection {
    background-color: #4CAF50;
    color: white;
}
```

**Pseudo-elements (::):**
- `::before` - Insert content before
- `::after` - Insert content after
- `::first-letter` - Style first letter
- `::first-line` - Style first line
- `::selection` - Highlighted text

---

## Activity 6: Specificity Practice

**Goal:** Understand CSS specificity and override rules.

**Create:** `specificity.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Specificity</title>
    <link rel="stylesheet" href="specificity.css">
</head>
<body>
    <p>Regular paragraph (element selector)</p>
    <p class="highlight">Paragraph with class (class selector)</p>
    <p id="special">Paragraph with ID (ID selector)</p>
    <p class="highlight" id="special">Paragraph with both class and ID</p>
    <p class="highlight" id="special" style="color: purple;">Paragraph with inline style</p>
    
    <div class="container">
        <p class="text">Paragraph inside container</p>
    </div>
</body>
</html>
```

**Create:** `specificity.css`

```css
/* Specificity: 0-0-1 (1 element) */
p {
    color: black;
}

/* Specificity: 0-1-0 (1 class) */
.highlight {
    color: blue;
}

/* Specificity: 1-0-0 (1 ID) */
#special {
    color: red;
}

/* Specificity: 0-1-1 (1 class + 1 element) */
.container p {
    color: green;
}

/* Specificity: 0-2-0 (2 classes) */
.container .text {
    color: orange;
}

/* Specificity: 1-1-0 (1 ID + 1 class) */
#special.highlight {
    color: purple;
}

/* Inline style: Specificity 1-0-0-0 (highest, except !important) */
/* <p style="color: purple;"> */

/* !important overrides everything (avoid!) */
p {
    color: gray !important;
}
```

**Specificity calculation:**
- Style attribute: 1000
- ID: 100
- Class/attribute/pseudo-class: 10
- Element/pseudo-element: 1

**Example:**
```css
p { }                    /* 1 */
.class { }              /* 10 */
#id { }                 /* 100 */
p.class { }             /* 11 */
div p.class { }         /* 12 */
#id .class { }          /* 110 */
style="..."             /* 1000 */
!important              /* Overrides all */
```

---

## Activity 7: Complete Barangay Services Page

**Goal:** Apply all selector types in a real project.

**Create:** `services.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services - Barangay Sto. Niño</title>
    <link rel="stylesheet" href="services.css">
</head>
<body>
    <header class="site-header">
        <div class="container">
            <h1>Barangay Sto. Niño Services</h1>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="services.html" class="active">Services</a></li>
                    <li><a href="contact.html">Contact</a></li>
                </ul>
            </nav>
        </div>
    </header>
    
    <main class="container">
        <section class="intro">
            <p>We offer various services to our constituents. All applications can be processed on-site or online.</p>
        </section>
        
        <section class="services">
            <article class="service-card" id="clearance">
                <h2>Barangay Clearance</h2>
                <p class="description">Required for employment, loan applications, and other transactions.</p>
                <dl class="details">
                    <dt>Processing Time:</dt>
                    <dd>Same day</dd>
                    <dt>Fee:</dt>
                    <dd>₱50.00</dd>
                    <dt>Requirements:</dt>
                    <dd>
                        <ul>
                            <li>Valid ID</li>
                            <li>2x2 Photo (2 copies)</li>
                            <li>Proof of Residency</li>
                        </ul>
                    </dd>
                </dl>
                <a href="apply.html?service=clearance" class="btn">Apply Now</a>
            </article>
            
            <article class="service-card featured" id="barangay-id">
                <h2>Barangay ID</h2>
                <span class="badge">Most Popular</span>
                <p class="description">Official identification card for barangay residents.</p>
                <dl class="details">
                    <dt>Processing Time:</dt>
                    <dd>3 working days</dd>
                    <dt>Fee:</dt>
                    <dd>₱30.00</dd>
                    <dt>Requirements:</dt>
                    <dd>
                        <ul>
                            <li>Valid ID</li>
                            <li>1x1 Photo (2 copies)</li>
                        </ul>
                    </dd>
                </dl>
                <a href="apply.html?service=id" class="btn btn-primary">Apply Now</a>
            </article>
            
            <article class="service-card" id="business-permit">
                <h2>Business Permit</h2>
                <p class="description">Register your business and start operations legally.</p>
                <dl class="details">
                    <dt>Processing Time:</dt>
                    <dd>5-7 working days</dd>
                    <dt>Fee:</dt>
                    <dd>₱500.00 (New) / ₱300.00 (Renewal)</dd>
                    <dt>Requirements:</dt>
                    <dd>
                        <ul>
                            <li>DTI/SEC Registration</li>
                            <li>Business Plan</li>
                            <li>Valid ID</li>
                            <li>Location Sketch</li>
                        </ul>
                    </dd>
                </dl>
                <a href="apply.html?service=permit" class="btn">Apply Now</a>
            </article>
        </section>
        
        <aside class="help-section">
            <h3>Need Help?</h3>
            <p>Contact us for assistance with your application.</p>
            <ul class="contact-list">
                <li><a href="tel:+6343123456">Call: 043-123-4567</a></li>
                <li><a href="mailto:brgy@example.com">Email: brgy@example.com</a></li>
                <li><a href="https://facebook.com/brgyston" target="_blank">Facebook: @brgyston</a></li>
            </ul>
        </aside>
    </main>
    
    <footer class="site-footer">
        <div class="container">
            <p>&copy; 2025 Barangay Sto. Niño. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
```

**Create:** `services.css`

```css
/* RESET */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* GLOBAL STYLES (element selectors) */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
}

/* LAYOUT (class selectors) */
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* HEADER (descendant selectors) */
.site-header {
    background-color: #4CAF50;
    color: white;
    padding: 20px 0;
}

.site-header h1 {
    margin-bottom: 15px;
    text-align: center;
}

/* NAVIGATION (pseudo-classes) */
nav ul {
    list-style: none;
    display: flex;
    justify-content: center;
    gap: 20px;
}

nav a {
    color: white;
    text-decoration: none;
    padding: 8px 16px;
    border-radius: 4px;
    transition: background-color 0.3s;
}

nav a:hover {
    background-color: rgba(255, 255, 255, 0.2);
}

nav a.active {
    background-color: rgba(255, 255, 255, 0.3);
    font-weight: bold;
}

/* INTRO (child selector) */
.intro > p {
    font-size: 18px;
    text-align: center;
    padding: 40px 20px;
    background: linear-gradient(to right, #667eea, #764ba2);
    color: white;
    border-radius: 8px;
    margin: 20px 0;
}

/* PSEUDO-ELEMENT */
.intro > p::first-letter {
    font-size: 2em;
    font-weight: bold;
}

/* SERVICE GRID */
.services {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
    margin: 40px 0;
}

/* SERVICE CARDS */
.service-card {
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s, box-shadow 0.3s;
    position: relative;
}

.service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
}

/* FEATURED CARD (multiple classes) */
.service-card.featured {
    border: 3px solid #ff9800;
}

/* ID SELECTOR */
#barangay-id {
    background: linear-gradient(135deg, #fff 0%, #ffe0b2 100%);
}

/* ADJACENT SIBLING */
h2 + .description {
    margin-top: 10px;
    font-style: italic;
    color: #666;
}

/* ATTRIBUTE SELECTOR */
[href^="tel"]::before {
    content: "📞 ";
}

[href^="mailto"]::before {
    content: "✉️ ";
}

[href^="https"]::after {
    content: " 🔗";
}

[target="_blank"] {
    background-color: #fff3cd;
    padding: 2px 5px;
    border-radius: 3px;
}

/* PSEUDO-CLASS - nth-child */
.service-card:first-child h2 {
    color: #4CAF50;
}

.service-card:nth-child(2) h2 {
    color: #ff9800;
}

.service-card:last-child h2 {
    color: #2196F3;
}

/* DETAILS LIST */
.details {
    margin: 20px 0;
    padding: 15px;
    background: #f9f9f9;
    border-radius: 5px;
}

.details dt {
    font-weight: bold;
    color: #4CAF50;
    margin-top: 10px;
}

.details dt:first-child {
    margin-top: 0;
}

.details dd {
    margin-left: 20px;
    color: #666;
}

/* NESTED LISTS */
.details ul {
    list-style-position: inside;
    margin-top: 5px;
}

.details li::marker {
    color: #4CAF50;
}

/* BADGE */
.badge {
    display: inline-block;
    background: #ff9800;
    color: white;
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    position: absolute;
    top: 10px;
    right: 10px;
}

/* BUTTONS */
.btn {
    display: inline-block;
    padding: 12px 24px;
    background-color: #4CAF50;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    transition: all 0.3s;
    margin-top: 15px;
}

.btn:hover {
    background-color: #45a049;
    transform: scale(1.05);
}

.btn-primary {
    background-color: #ff9800;
}

.btn-primary:hover {
    background-color: #e68900;
}

/* HELP SECTION */
.help-section {
    background: #e3f2fd;
    padding: 30px;
    border-radius: 8px;
    margin: 40px 0;
}

.help-section h3 {
    color: #1976d2;
    margin-bottom: 15px;
}

.contact-list {
    list-style: none;
    margin-top: 15px;
}

.contact-list li {
    padding: 8px 0;
}

.contact-list a {
    color: #1976d2;
    text-decoration: none;
}

.contact-list a:hover {
    text-decoration: underline;
}

/* FOOTER */
.site-footer {
    background: #333;
    color: white;
    padding: 20px 0;
    text-align: center;
    margin-top: 60px;
}

/* SELECTION */
::selection {
    background-color: #4CAF50;
    color: white;
}
```

**Selectors used:**
✅ Element selectors  
✅ Class selectors  
✅ ID selectors  
✅ Descendant selectors  
✅ Child selectors  
✅ Adjacent sibling  
✅ Attribute selectors  
✅ Pseudo-classes (:hover, :active, :first-child, :nth-child)  
✅ Pseudo-elements (::before, ::after, ::selection)  
✅ Multiple classes  
✅ Specificity management

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## CSS Selectors Reference

### Basic Selectors

```css
/* Element selector */
p { color: blue; }

/* Class selector */
.highlight { background: yellow; }

/* ID selector */
#special { font-weight: bold; }

/* Universal selector */
* { margin: 0; }

/* Multiple selectors */
h1, h2, h3 { font-family: Arial; }
```

### Combinator Selectors

```css
/* Descendant (space) - all descendants */
div p { color: red; }

/* Child (>) - direct children only */
div > p { color: blue; }

/* Adjacent sibling (+) - immediately following */
h2 + p { font-weight: bold; }

/* General sibling (~) - all following siblings */
h2 ~ p { color: gray; }
```

### Attribute Selectors

```css
/* Has attribute */
[required] { border: 2px solid red; }

/* Exact value */
[type="email"] { background: lightblue; }

/* Starts with */
[href^="https"] { color: green; }

/* Ends with */
[href$=".pdf"] { font-weight: bold; }

/* Contains */
[href*="example"] { text-decoration: underline; }

/* Contains word */
[class~="highlight"] { background: yellow; }
```

### Pseudo-classes

```css
/* Link states */
a:link { color: blue; }
a:visited { color: purple; }
a:hover { color: red; }
a:active { color: darkred; }

/* Structural */
:first-child { font-weight: bold; }
:last-child { margin-bottom: 0; }
:nth-child(2) { background: gray; }
:nth-child(odd) { background: #f4f4f4; }
:nth-child(even) { background: white; }
:nth-child(3n) { color: red; }

/* UI states */
:hover { background: lightblue; }
:focus { outline: 2px solid blue; }
:active { transform: scale(0.95); }
:disabled { opacity: 0.5; }
:enabled { cursor: pointer; }
:checked { background: green; }

/* Form validation */
:required { border-left: 4px solid red; }
:optional { border-left: 4px solid gray; }
:valid { border-color: green; }
:invalid { border-color: red; }
:in-range { background: lightgreen; }
:out-of-range { background: lightcoral; }

/* Other */
:not(.special) { opacity: 0.5; }
:empty { display: none; }
:target { background: yellow; }
```

### Pseudo-elements

```css
/* Content insertion */
::before { content: "→ "; }
::after { content: " ←"; }

/* Text styling */
::first-letter { font-size: 2em; }
::first-line { font-weight: bold; }

/* Selection */
::selection { 
    background: blue;
    color: white;
}

/* Placeholder */
::placeholder { color: gray; }
```

## Specificity Calculator

**Format:** (inline, IDs, classes, elements)

```css
* { }                         /* (0,0,0,0) */
p { }                         /* (0,0,0,1) */
.class { }                    /* (0,0,1,0) */
#id { }                       /* (0,1,0,0) */
style=""                      /* (1,0,0,0) */

p.class { }                   /* (0,0,1,1) */
div p { }                     /* (0,0,0,2) */
.container .box { }           /* (0,0,2,0) */
#header .nav { }              /* (0,1,1,0) */
div#main .content p { }       /* (0,1,1,2) */
```

**Winner:** Highest specificity, or last declared if equal.

**!important:** Overrides specificity (avoid!)

## Property Value Types

### Colors

```css
/* Named colors */
color: red;
color: blue;

/* Hexadecimal */
color: #ff0000;
color: #f00;  /* Shorthand */

/* RGB */
color: rgb(255, 0, 0);
color: rgba(255, 0, 0, 0.5);  /* With alpha */

/* HSL */
color: hsl(0, 100%, 50%);
color: hsla(0, 100%, 50%, 0.5);  /* With alpha */
```

### Lengths

```css
/* Absolute */
width: 100px;    /* Pixels */
width: 1in;      /* Inches */
width: 2cm;      /* Centimeters */

/* Relative */
width: 50%;      /* Percent of parent */
width: 2em;      /* Relative to font-size */
width: 2rem;     /* Relative to root font-size */
width: 50vw;     /* Viewport width */
width: 50vh;     /* Viewport height */
width: 2ch;      /* Character width */
```

### Keywords

```css
display: none;
display: block;
display: inline;

width: auto;
margin: 0;
text-align: center;
```

## Common Properties

### Text

```css
color: #333;
font-size: 16px;
font-weight: bold;  /* normal, bold, 100-900 */
font-style: italic;
text-align: center;  /* left, right, center, justify */
text-decoration: underline;  /* none, underline, line-through */
text-transform: uppercase;  /* lowercase, uppercase, capitalize */
line-height: 1.6;
letter-spacing: 2px;
word-spacing: 5px;
```

### Box Model

```css
/* Padding (inside border) */
padding: 10px;
padding: 10px 20px;  /* vertical horizontal */
padding: 10px 20px 30px 40px;  /* top right bottom left */

/* Margin (outside border) */
margin: 10px;
margin: 0 auto;  /* Center horizontally */

/* Border */
border: 1px solid black;
border-width: 2px;
border-style: solid;  /* solid, dashed, dotted, double */
border-color: red;
border-radius: 5px;

/* Box sizing */
box-sizing: border-box;  /* Include padding/border in width */
```

### Display and Position

```css
display: block;
display: inline;
display: inline-block;
display: flex;
display: grid;
display: none;

position: static;  /* Default */
position: relative;
position: absolute;
position: fixed;
position: sticky;
```

</details>

---

**Perfect!** You've mastered CSS selectors and can now target any element with precision. Combined with properties and values, you have full styling control!

**Next:** Colors, backgrounds, and fonts!
