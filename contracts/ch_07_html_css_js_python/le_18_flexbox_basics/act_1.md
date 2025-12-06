# Lesson 18 Activities: Flexbox Basics

## The Modern Layout System

Say goodbye to inline-block hacks! Flexbox makes layout simple and intuitive.

---

## Activity 1: Flex Container Basics

**Goal:** Understand how flexbox transforms layout behavior.

**Create:** `flex-container-basics.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Flex Container Basics</title>
    <link rel="stylesheet" href="flex-container-basics.css">
</head>
<body>
    <div class="container">
        <h1>Normal vs Flexbox</h1>
        
        <section>
            <h2>Normal Block Layout</h2>
            <div class="normal-container">
                <div class="box">Box 1</div>
                <div class="box">Box 2</div>
                <div class="box">Box 3</div>
            </div>
        </section>
        
        <section>
            <h2>Flexbox Layout</h2>
            <div class="flex-container">
                <div class="box">Box 1</div>
                <div class="box">Box 2</div>
                <div class="box">Box 3</div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `flex-container-basics.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px 20px;
}

.container {
    max-width: 800px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

section {
    background-color: white;
    padding: 30px;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

h2 {
    color: #333;
    margin-bottom: 20px;
}

.box {
    background-color: #2196f3;
    color: white;
    padding: 20px;
    text-align: center;
    font-weight: bold;
    border-radius: 5px;
    margin-bottom: 10px;
}

/* Normal container - blocks stack vertically */
.normal-container .box {
    /* Default block behavior */
}

/* Flex container - children align horizontally */
.flex-container {
    display: flex;  /* Magic! Children now flex items */
    /* By default: flex-direction: row */
}

.flex-container .box {
    margin-right: 10px;
    margin-bottom: 0;
}

.flex-container .box:last-child {
    margin-right: 0;
}
```

**Key concept:** `display: flex` on parent makes children flexible!

---

## Activity 2: Justify-Content (Main Axis Alignment)

**Goal:** Align items along the main axis (horizontal by default).

**Create:** `justify-content.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Justify-Content</title>
    <link rel="stylesheet" href="justify-content.css">
</head>
<body>
    <div class="container">
        <h1>Justify-Content Options</h1>
        
        <section>
            <h2>flex-start (default)</h2>
            <div class="flex-container start">
                <div class="box">1</div>
                <div class="box">2</div>
                <div class="box">3</div>
            </div>
        </section>
        
        <section>
            <h2>center</h2>
            <div class="flex-container center">
                <div class="box">1</div>
                <div class="box">2</div>
                <div class="box">3</div>
            </div>
        </section>
        
        <section>
            <h2>flex-end</h2>
            <div class="flex-container end">
                <div class="box">1</div>
                <div class="box">2</div>
                <div class="box">3</div>
            </div>
        </section>
        
        <section>
            <h2>space-between</h2>
            <div class="flex-container between">
                <div class="box">1</div>
                <div class="box">2</div>
                <div class="box">3</div>
            </div>
        </section>
        
        <section>
            <h2>space-around</h2>
            <div class="flex-container around">
                <div class="box">1</div>
                <div class="box">2</div>
                <div class="box">3</div>
            </div>
        </section>
        
        <section>
            <h2>space-evenly</h2>
            <div class="flex-container evenly">
                <div class="box">1</div>
                <div class="box">2</div>
                <div class="box">3</div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `justify-content.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px 20px;
}

.container {
    max-width: 900px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

section {
    background-color: white;
    padding: 30px;
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

h2 {
    color: #333;
    margin-bottom: 15px;
    font-size: 1.1rem;
}

.flex-container {
    display: flex;
    background-color: #e3f2fd;
    padding: 20px;
    border-radius: 5px;
    min-height: 80px;
}

.box {
    background-color: #2196f3;
    color: white;
    padding: 20px 30px;
    font-weight: bold;
    border-radius: 5px;
    font-size: 1.2rem;
}

/* Justify-content options */
.start {
    justify-content: flex-start;  /* Default - items at start */
}

.center {
    justify-content: center;  /* Items centered */
}

.end {
    justify-content: flex-end;  /* Items at end */
}

.between {
    justify-content: space-between;  /* Space between items */
}

.around {
    justify-content: space-around;  /* Space around items */
}

.evenly {
    justify-content: space-evenly;  /* Equal space everywhere */
}
```

**Compare:**
- `space-between`: No space at edges
- `space-around`: Half space at edges
- `space-evenly`: Equal space everywhere

---

## Activity 3: Align-Items (Cross Axis Alignment)

**Goal:** Align items along the cross axis (vertical by default).

**Create:** `align-items.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Align-Items</title>
    <link rel="stylesheet" href="align-items.css">
</head>
<body>
    <div class="container">
        <h1>Align-Items Options</h1>
        
        <section>
            <h2>stretch (default)</h2>
            <div class="flex-container stretch">
                <div class="box">Short</div>
                <div class="box tall">Tall<br>Content<br>Here</div>
                <div class="box">Short</div>
            </div>
        </section>
        
        <section>
            <h2>flex-start</h2>
            <div class="flex-container start">
                <div class="box">Short</div>
                <div class="box tall">Tall<br>Content<br>Here</div>
                <div class="box">Short</div>
            </div>
        </section>
        
        <section>
            <h2>center</h2>
            <div class="flex-container center">
                <div class="box">Short</div>
                <div class="box tall">Tall<br>Content<br>Here</div>
                <div class="box">Short</div>
            </div>
        </section>
        
        <section>
            <h2>flex-end</h2>
            <div class="flex-container end">
                <div class="box">Short</div>
                <div class="box tall">Tall<br>Content<br>Here</div>
                <div class="box">Short</div>
            </div>
        </section>
        
        <section>
            <h2>baseline</h2>
            <div class="flex-container baseline">
                <div class="box small">Small</div>
                <div class="box large">Large</div>
                <div class="box small">Small</div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `align-items.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px 20px;
}

.container {
    max-width: 900px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

section {
    background-color: white;
    padding: 30px;
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

h2 {
    color: #333;
    margin-bottom: 15px;
    font-size: 1.1rem;
}

.flex-container {
    display: flex;
    background-color: #e3f2fd;
    padding: 20px;
    border-radius: 5px;
    min-height: 150px;
}

.box {
    background-color: #2196f3;
    color: white;
    padding: 20px 30px;
    font-weight: bold;
    border-radius: 5px;
    margin-right: 10px;
}

.box:last-child {
    margin-right: 0;
}

.tall {
    background-color: #ff9800;
}

.small {
    font-size: 14px;
}

.large {
    font-size: 28px;
}

/* Align-items options */
.stretch {
    align-items: stretch;  /* Default - items stretch to fill */
}

.start {
    align-items: flex-start;  /* Items at top */
}

.center {
    align-items: center;  /* Items centered vertically */
}

.end {
    align-items: flex-end;  /* Items at bottom */
}

.baseline {
    align-items: baseline;  /* Items aligned by text baseline */
}

/* Prevent stretch for non-stretch examples */
.start .box,
.center .box,
.end .box,
.baseline .box {
    align-self: auto;  /* Override stretch */
}
```

**Note:** `align-items: center` is the secret to easy vertical centering!

---

## Activity 4: Flex-Wrap - Responsive Layout

**Goal:** Allow flex items to wrap to multiple lines.

**Create:** `flex-wrap.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flex-Wrap</title>
    <link rel="stylesheet" href="flex-wrap.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Services</h1>
        
        <section>
            <h2>Without Wrap (nowrap - default)</h2>
            <p class="note">Items shrink to fit in one line</p>
            <div class="flex-container nowrap">
                <div class="service-card">Clearance</div>
                <div class="service-card">ID</div>
                <div class="service-card">Permit</div>
                <div class="service-card">Certificate</div>
                <div class="service-card">Residency</div>
                <div class="service-card">Indigency</div>
            </div>
        </section>
        
        <section>
            <h2>With Wrap</h2>
            <p class="note">Items wrap to new lines when needed</p>
            <div class="flex-container wrap">
                <div class="service-card">Clearance</div>
                <div class="service-card">ID</div>
                <div class="service-card">Permit</div>
                <div class="service-card">Certificate</div>
                <div class="service-card">Residency</div>
                <div class="service-card">Indigency</div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `flex-wrap.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px 20px;
}

.container {
    max-width: 1000px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

section {
    background-color: white;
    padding: 30px;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

h2 {
    color: #333;
    margin-bottom: 10px;
}

.note {
    color: #666;
    font-size: 0.9rem;
    margin-bottom: 20px;
    font-style: italic;
}

.flex-container {
    display: flex;
    background-color: #e3f2fd;
    padding: 20px;
    border-radius: 5px;
}

.service-card {
    background-color: #2196f3;
    color: white;
    padding: 30px;
    font-weight: bold;
    border-radius: 8px;
    margin: 5px;
    text-align: center;
    min-width: 150px;
}

/* Without wrap - items squeeze */
.nowrap {
    flex-wrap: nowrap;  /* Default */
}

/* With wrap - items maintain size and wrap */
.wrap {
    flex-wrap: wrap;
}
```

**Test:** Resize browser to see wrapping in action!

---

## Activity 5: Gap - Modern Spacing

**Goal:** Use the gap property for clean spacing.

**Create:** `flex-gap.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Flexbox Gap</title>
    <link rel="stylesheet" href="flex-gap.css">
</head>
<body>
    <div class="container">
        <h1>Flexbox Gap Property</h1>
        
        <section>
            <h2>Old Way: Margins</h2>
            <p class="note">Need margin on each item + remove from last</p>
            <div class="flex-container old-way">
                <div class="box">Box 1</div>
                <div class="box">Box 2</div>
                <div class="box">Box 3</div>
                <div class="box">Box 4</div>
            </div>
        </section>
        
        <section>
            <h2>New Way: Gap</h2>
            <p class="note">One property, clean and simple!</p>
            <div class="flex-container new-way">
                <div class="box">Box 1</div>
                <div class="box">Box 2</div>
                <div class="box">Box 3</div>
                <div class="box">Box 4</div>
            </div>
        </section>
        
        <section>
            <h2>Different Gaps</h2>
            <p class="note">row-gap and column-gap</p>
            <div class="flex-container different-gaps">
                <div class="box">Box 1</div>
                <div class="box">Box 2</div>
                <div class="box">Box 3</div>
                <div class="box">Box 4</div>
                <div class="box">Box 5</div>
                <div class="box">Box 6</div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `flex-gap.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px 20px;
}

.container {
    max-width: 900px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

section {
    background-color: white;
    padding: 30px;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

h2 {
    color: #333;
    margin-bottom: 10px;
}

.note {
    color: #666;
    font-size: 0.9rem;
    margin-bottom: 20px;
    font-style: italic;
}

.flex-container {
    display: flex;
    flex-wrap: wrap;
    background-color: #e3f2fd;
    padding: 20px;
    border-radius: 5px;
}

.box {
    background-color: #2196f3;
    color: white;
    padding: 20px 30px;
    font-weight: bold;
    border-radius: 5px;
}

/* Old way - margins */
.old-way .box {
    margin-right: 15px;
    margin-bottom: 15px;
}

.old-way .box:last-child {
    margin-right: 0;  /* Remove from last item */
}

/* New way - gap property */
.new-way {
    gap: 15px;  /* Space between items */
}

/* Different gaps */
.different-gaps {
    row-gap: 30px;     /* Vertical spacing */
    column-gap: 15px;  /* Horizontal spacing */
}
```

**Gap is cleaner:** No need to remove margins from last items!

---

## Activity 6: Flex-Grow and Flex-Shrink

**Goal:** Control how items grow and shrink.

**Create:** `flex-grow-shrink.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flex Grow & Shrink</title>
    <link rel="stylesheet" href="flex-grow-shrink.css">
</head>
<body>
    <div class="container">
        <h1>Flex-Grow & Flex-Shrink</h1>
        
        <section>
            <h2>Flex-Grow: 0 (default)</h2>
            <p class="note">Items don't grow to fill space</p>
            <div class="flex-container">
                <div class="box no-grow">Box 1</div>
                <div class="box no-grow">Box 2</div>
                <div class="box no-grow">Box 3</div>
            </div>
        </section>
        
        <section>
            <h2>Flex-Grow: 1</h2>
            <p class="note">Items grow equally to fill space</p>
            <div class="flex-container">
                <div class="box grow">Box 1</div>
                <div class="box grow">Box 2</div>
                <div class="box grow">Box 3</div>
            </div>
        </section>
        
        <section>
            <h2>Different Grow Values</h2>
            <p class="note">Middle box grows twice as much</p>
            <div class="flex-container">
                <div class="box grow-1">Grow: 1</div>
                <div class="box grow-2">Grow: 2</div>
                <div class="box grow-1">Grow: 1</div>
            </div>
        </section>
        
        <section>
            <h2>Real Example: Search Bar</h2>
            <div class="search-bar">
                <input type="text" placeholder="Search barangay services...">
                <button>Search</button>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `flex-grow-shrink.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px 20px;
}

.container {
    max-width: 900px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

section {
    background-color: white;
    padding: 30px;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

h2 {
    color: #333;
    margin-bottom: 10px;
}

.note {
    color: #666;
    font-size: 0.9rem;
    margin-bottom: 20px;
    font-style: italic;
}

.flex-container {
    display: flex;
    gap: 10px;
    background-color: #e3f2fd;
    padding: 20px;
    border-radius: 5px;
}

.box {
    background-color: #2196f3;
    color: white;
    padding: 20px;
    font-weight: bold;
    border-radius: 5px;
    text-align: center;
}

/* Flex-grow values */
.no-grow {
    flex-grow: 0;  /* Default - don't grow */
}

.grow {
    flex-grow: 1;  /* Grow to fill space */
}

.grow-1 {
    flex-grow: 1;
    background-color: #2196f3;
}

.grow-2 {
    flex-grow: 2;  /* Grows twice as much */
    background-color: #ff9800;
}

/* Real example: Search bar */
.search-bar {
    display: flex;
    gap: 10px;
}

.search-bar input {
    flex-grow: 1;  /* Input grows to fill space */
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
}

.search-bar button {
    flex-grow: 0;  /* Button stays fixed size */
    padding: 12px 30px;
    background-color: #1a73e8;
    color: white;
    border: none;
    border-radius: 5px;
    font-weight: bold;
    cursor: pointer;
}

.search-bar button:hover {
    background-color: #1557b0;
}
```

**Key concept:** `flex-grow: 1` makes items fill available space!

---

## Activity 7: Complete Barangay Service Portal with Flexbox

**Goal:** Build a full responsive layout using flexbox.

**Create:** `complete-flexbox-portal.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Services Portal</title>
    <link rel="stylesheet" href="complete-flexbox-portal.css">
</head>
<body>
    <!-- Header with flexbox -->
    <header class="header">
        <div class="logo">🏛️ Barangay San Miguel</div>
        <nav class="nav">
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#announcements">Announcements</a>
            <a href="#contact">Contact</a>
        </nav>
    </header>
    
    <!-- Hero section -->
    <section class="hero">
        <h1>Welcome to Our Community</h1>
        <p>Serving with integrity and dedication</p>
        <button class="cta-button">Apply for Services</button>
    </section>
    
    <!-- Quick services grid -->
    <section class="quick-services">
        <h2>Quick Services</h2>
        <div class="services-grid">
            <div class="service-card">
                <div class="icon">📄</div>
                <h3>Barangay Clearance</h3>
                <p>₱50.00</p>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">🆔</div>
                <h3>Barangay ID</h3>
                <p>₱30.00</p>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">💼</div>
                <h3>Business Permit</h3>
                <p>₱500.00</p>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">📜</div>
                <h3>Certificate</h3>
                <p>₱30.00</p>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">🏠</div>
                <h3>Residency</h3>
                <p>₱50.00</p>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">💳</div>
                <h3>Community Tax</h3>
                <p>₱5.00</p>
                <button>Apply Now</button>
            </div>
        </div>
    </section>
    
    <!-- Announcements -->
    <section class="announcements">
        <h2>Latest Announcements</h2>
        <div class="announcement-list">
            <div class="announcement">
                <div class="announcement-header">
                    <span class="badge urgent">URGENT</span>
                    <span class="date">Dec 4, 2025</span>
                </div>
                <h3>Typhoon Warning</h3>
                <p>Signal #2 in effect. All classes suspended. Stay safe indoors.</p>
            </div>
            
            <div class="announcement">
                <div class="announcement-header">
                    <span class="badge new">NEW</span>
                    <span class="date">Dec 20, 2025</span>
                </div>
                <h3>Christmas Program</h3>
                <p>Join our annual celebration with games, raffles, and gifts!</p>
            </div>
            
            <div class="announcement">
                <div class="announcement-header">
                    <span class="badge info">INFO</span>
                    <span class="date">Dec 15, 2025</span>
                </div>
                <h3>Office Hours Extended</h3>
                <p>Hall open until 6PM for holiday rush assistance.</p>
            </div>
        </div>
    </section>
    
    <!-- Contact section -->
    <section class="contact">
        <h2>Contact Us</h2>
        <div class="contact-grid">
            <div class="contact-card">
                <div class="icon">📞</div>
                <h4>Phone</h4>
                <p>043-123-4567</p>
            </div>
            
            <div class="contact-card">
                <div class="icon">📧</div>
                <h4>Email</h4>
                <p>info@brgysanmiguel.ph</p>
            </div>
            
            <div class="contact-card">
                <div class="icon">🏛️</div>
                <h4>Office</h4>
                <p>Barangay Hall, San Miguel</p>
            </div>
            
            <div class="contact-card">
                <div class="icon">🕒</div>
                <h4>Hours</h4>
                <p>Mon-Fri: 8AM - 5PM</p>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 Barangay San Miguel. All rights reserved.</p>
    </footer>
</body>
</html>
```

**Create:** `complete-flexbox-portal.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
}

/* HEADER - Flexbox for logo and nav */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 5%;
    background-color: #1a73e8;
    color: white;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
}

.nav {
    display: flex;
    gap: 30px;
}

.nav a {
    color: white;
    text-decoration: none;
    padding: 8px 15px;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.nav a:hover {
    background-color: rgba(255,255,255,0.2);
}

/* HERO SECTION - Flexbox for centering */
.hero {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    padding: 100px 20px;
    background: linear-gradient(135deg, #1a73e8, #4caf50);
    color: white;
}

.hero h1 {
    font-size: 3rem;
    margin-bottom: 15px;
}

.hero p {
    font-size: 1.3rem;
    margin-bottom: 30px;
}

.cta-button {
    padding: 15px 40px;
    font-size: 1.1rem;
    background-color: white;
    color: #1a73e8;
    border: none;
    border-radius: 30px;
    font-weight: bold;
    cursor: pointer;
    transition: transform 0.3s;
}

.cta-button:hover {
    transform: scale(1.05);
}

/* QUICK SERVICES - Flexbox grid */
.quick-services {
    padding: 60px 5%;
    background-color: #f5f5f5;
}

.quick-services h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2.5rem;
    margin-bottom: 40px;
}

.services-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
}

.service-card {
    flex: 0 1 250px;  /* Don't grow, can shrink, base 250px */
    background-color: white;
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    transition: transform 0.3s;
}

.service-card:hover {
    transform: translateY(-10px);
}

.service-card .icon {
    font-size: 64px;
    margin-bottom: 15px;
}

.service-card h3 {
    color: #333;
    margin-bottom: 10px;
}

.service-card p {
    color: #4caf50;
    font-size: 1.8rem;
    font-weight: bold;
    margin-bottom: 20px;
}

.service-card button {
    width: 100%;
    padding: 12px;
    background-color: #1a73e8;
    color: white;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
}

.service-card button:hover {
    background-color: #1557b0;
}

/* ANNOUNCEMENTS - Flexbox layout */
.announcements {
    padding: 60px 5%;
}

.announcements h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2.5rem;
    margin-bottom: 40px;
}

.announcement-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
    max-width: 900px;
    margin: 0 auto;
}

.announcement {
    background-color: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.announcement-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: bold;
    text-transform: uppercase;
}

.badge.urgent {
    background-color: #f44336;
    color: white;
}

.badge.new {
    background-color: #4caf50;
    color: white;
}

.badge.info {
    background-color: #2196f3;
    color: white;
}

.date {
    color: #999;
    font-size: 0.9rem;
}

.announcement h3 {
    color: #333;
    margin-bottom: 10px;
}

.announcement p {
    color: #666;
}

/* CONTACT - Flexbox grid */
.contact {
    padding: 60px 5%;
    background-color: #f5f5f5;
}

.contact h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2.5rem;
    margin-bottom: 40px;
}

.contact-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
    max-width: 1000px;
    margin: 0 auto;
}

.contact-card {
    flex: 1 1 200px;
    background-color: white;
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.contact-card .icon {
    font-size: 48px;
    margin-bottom: 15px;
}

.contact-card h4 {
    color: #1a73e8;
    margin-bottom: 10px;
}

.contact-card p {
    color: #666;
}

/* FOOTER */
.footer {
    background-color: #333;
    color: white;
    text-align: center;
    padding: 30px;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .header {
        flex-direction: column;
        gap: 15px;
    }
    
    .nav {
        flex-direction: column;
        gap: 10px;
        width: 100%;
    }
    
    .nav a {
        text-align: center;
    }
    
    .hero h1 {
        font-size: 2rem;
    }
    
    .hero p {
        font-size: 1rem;
    }
    
    .services-grid {
        flex-direction: column;
    }
    
    .service-card {
        flex: 1 1 auto;
    }
}
```

**Flexbox Features Used:**
✅ Header: `justify-content: space-between`  
✅ Hero: `flex-direction: column` + `align-items: center`  
✅ Services: `flex-wrap` + `gap`  
✅ Announcements: `flex-direction: column`  
✅ Contact: `flex-wrap` + responsive sizing  
✅ Responsive: Stack on mobile

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Flexbox Complete Reference

### Enable Flexbox

```css
.container {
    display: flex;  /* Makes children flex items */
}
```

---

### Flex Direction

```css
.container {
    flex-direction: row;  /* Default - horizontal */
    flex-direction: column;  /* Vertical */
    flex-direction: row-reverse;  /* Horizontal reversed */
    flex-direction: column-reverse;  /* Vertical reversed */
}
```

---

### Justify-Content (Main Axis)

```css
.container {
    justify-content: flex-start;  /* Default - start */
    justify-content: center;  /* Center */
    justify-content: flex-end;  /* End */
    justify-content: space-between;  /* Space between items */
    justify-content: space-around;  /* Space around items */
    justify-content: space-evenly;  /* Equal space */
}
```

**When to use:**
- `flex-start`: Default behavior
- `center`: Center items horizontally
- `space-between`: Spread items (no edge space)
- `space-evenly`: Equal space everywhere

---

### Align-Items (Cross Axis)

```css
.container {
    align-items: stretch;  /* Default - fill height */
    align-items: flex-start;  /* Top */
    align-items: center;  /* Middle (vertical centering!) */
    align-items: flex-end;  /* Bottom */
    align-items: baseline;  /* Text baseline */
}
```

**Secret:** `align-items: center` = easy vertical centering!

---

### Flex-Wrap

```css
.container {
    flex-wrap: nowrap;  /* Default - items shrink to fit */
    flex-wrap: wrap;  /* Items wrap to new lines */
    flex-wrap: wrap-reverse;  /* Wrap in reverse */
}
```

---

### Gap (Modern Spacing)

```css
.container {
    gap: 20px;  /* Space between items */
    
    /* Or separate: */
    row-gap: 30px;
    column-gap: 15px;
}
```

**Better than margins:** No need to remove from last item!

---

### Flex Item Properties

```css
.item {
    flex-grow: 0;  /* Default - don't grow */
    flex-grow: 1;  /* Grow to fill space */
    
    flex-shrink: 1;  /* Default - can shrink */
    flex-shrink: 0;  /* Don't shrink */
    
    flex-basis: auto;  /* Default - based on content */
    flex-basis: 200px;  /* Base size before growing/shrinking */
    
    /* Shorthand: */
    flex: 1;  /* flex-grow: 1, flex-shrink: 1, flex-basis: 0 */
    flex: 0 1 250px;  /* grow, shrink, basis */
}
```

---

## Common Patterns

### Horizontal Navigation
```css
.nav {
    display: flex;
    gap: 20px;
}
```

### Centered Content
```css
.hero {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 400px;
}
```

### Card Grid
```css
.grid {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

.card {
    flex: 0 1 250px;  /* Don't grow, can shrink, base 250px */
}
```

### Search Bar
```css
.search-bar {
    display: flex;
    gap: 10px;
}

.search-bar input {
    flex-grow: 1;  /* Input grows */
}

.search-bar button {
    flex-grow: 0;  /* Button fixed */
}
```

### Holy Grail Layout
```css
.container {
    display: flex;
}

.sidebar {
    flex: 0 0 200px;  /* Fixed width */
}

.main {
    flex: 1;  /* Grows to fill */
}
```

---

## Best Practices

1. **Use gap instead of margins** for cleaner code
2. **Use flex: 1 for equal-width items**
3. **Combine with media queries** for responsive design
4. **Use align-items: center** for easy vertical centering
5. **Use flex-wrap: wrap** for responsive grids

---

## Flexbox vs Grid

**Use Flexbox when:**
- One-dimensional layout (row OR column)
- Content determines layout
- Navigation bars
- Card layouts with wrapping

**Use Grid when:**
- Two-dimensional layout (rows AND columns)
- Layout determines content placement
- Complex page layouts
- Dashboard layouts

</details>

---

**Congratulations!** You've mastered Flexbox! You can now create modern, flexible layouts with ease.

**Next Lesson:** Media Queries - Making layouts responsive!

