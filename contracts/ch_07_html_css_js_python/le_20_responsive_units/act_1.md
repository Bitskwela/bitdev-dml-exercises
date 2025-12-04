# Lesson 20 Activities: Responsive Units

## Building Truly Scalable Layouts

Pixels are fixed. Rem, em, percentages, and viewport units scale. Let's build flexible designs!

---

## Activity 1: Understanding Rem vs Em vs Px

**Goal:** Compare how different units scale.

**Create:** `units-comparison.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Units Comparison</title>
    <link rel="stylesheet" href="units-comparison.css">
</head>
<body>
    <div class="container">
        <h1>Font Size Units Comparison</h1>
        <p>Use browser zoom (Ctrl/Cmd + or -) to see how units behave!</p>
        
        <section class="demo px-demo">
            <h2>Pixels (px) - Fixed</h2>
            <p class="large">16px text doesn't scale with browser zoom</p>
            <p class="medium">14px medium text</p>
            <p class="small">12px small text</p>
        </section>
        
        <section class="demo rem-demo">
            <h2>Rem - Scales with Root</h2>
            <p class="large">1rem text scales with browser zoom!</p>
            <p class="medium">0.875rem medium text</p>
            <p class="small">0.75rem small text</p>
        </section>
        
        <section class="demo em-demo">
            <h2>Em - Scales with Parent</h2>
            <p class="large">1.2em text scales with parent</p>
            <p class="medium">1em medium text</p>
            <p class="small">0.9em small text</p>
        </section>
    </div>
</body>
</html>
```

**Create:** `units-comparison.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Root font size - rem is based on this */
html {
    font-size: 16px;  /* 1rem = 16px */
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
    margin-bottom: 20px;
}

body > .container > p {
    text-align: center;
    color: #666;
    margin-bottom: 40px;
}

.demo {
    background-color: white;
    padding: 30px;
    margin-bottom: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.demo h2 {
    color: #333;
    margin-bottom: 20px;
    font-size: 1.5rem;
}

.demo p {
    margin-bottom: 10px;
    padding: 10px;
    background-color: #f9f9f9;
    border-left: 4px solid #2196f3;
}

/* PIXELS - Fixed size */
.px-demo .large {
    font-size: 16px;
}

.px-demo .medium {
    font-size: 14px;
}

.px-demo .small {
    font-size: 12px;
}

/* REM - Relative to root */
.rem-demo .large {
    font-size: 1rem;  /* 16px */
}

.rem-demo .medium {
    font-size: 0.875rem;  /* 14px */
}

.rem-demo .small {
    font-size: 0.75rem;  /* 12px */
}

/* EM - Relative to parent */
.em-demo {
    font-size: 16px;  /* Parent size */
}

.em-demo .large {
    font-size: 1.2em;  /* 1.2 * 16px = 19.2px */
}

.em-demo .medium {
    font-size: 1em;  /* 1 * 16px = 16px */
}

.em-demo .small {
    font-size: 0.9em;  /* 0.9 * 16px = 14.4px */
}
```

**Test:** Zoom browser - rem scales, px doesn't!

---

## Activity 2: Rem-Based Typography System

**Goal:** Build scalable typography with rem.

**Create:** `rem-typography.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rem Typography System</title>
    <link rel="stylesheet" href="rem-typography.css">
</head>
<body>
    <article class="article">
        <h1>Barangay San Miguel: A Model Community</h1>
        <p class="lead">Serving with excellence, building together as one family</p>
        
        <h2>Our Vision</h2>
        <p>To be a progressive, peaceful, and united barangay where every resident thrives and contributes to community development.</p>
        
        <h3>Core Values</h3>
        <ul>
            <li>Integrity in public service</li>
            <li>Transparency in governance</li>
            <li>Community participation</li>
            <li>Sustainable development</li>
        </ul>
        
        <h4>Available Services</h4>
        <p>We offer comprehensive services including document processing, community programs, and emergency response.</p>
        
        <blockquote>
            "Ang barangay ay tahanan ng pagkakaisa at pag-unlad."
        </blockquote>
        
        <p class="small">All services are available Monday to Friday, 8:00 AM to 5:00 PM.</p>
    </article>
</body>
</html>
```

**Create:** `rem-typography.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Set base font size */
html {
    font-size: 16px;  /* 1rem = 16px */
}

body {
    font-family: 'Georgia', serif;
    background-color: #f5f5f5;
    padding: 2rem;
    line-height: 1.6;
}

.article {
    max-width: 800px;
    margin: 0 auto;
    background-color: white;
    padding: 3rem;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

/* Typography scale using rem */
h1 {
    font-size: 2.5rem;  /* 40px */
    color: #1a73e8;
    margin-bottom: 1rem;
    line-height: 1.2;
}

h2 {
    font-size: 2rem;  /* 32px */
    color: #333;
    margin-top: 2.5rem;
    margin-bottom: 1rem;
}

h3 {
    font-size: 1.5rem;  /* 24px */
    color: #333;
    margin-top: 2rem;
    margin-bottom: 0.75rem;
}

h4 {
    font-size: 1.25rem;  /* 20px */
    color: #333;
    margin-top: 1.5rem;
    margin-bottom: 0.5rem;
}

.lead {
    font-size: 1.25rem;  /* 20px */
    color: #666;
    font-style: italic;
    margin-bottom: 2rem;
}

p {
    font-size: 1rem;  /* 16px */
    color: #444;
    margin-bottom: 1rem;
}

.small {
    font-size: 0.875rem;  /* 14px */
    color: #999;
}

ul {
    margin-left: 2rem;
    margin-bottom: 1.5rem;
}

li {
    font-size: 1rem;
    color: #444;
    margin-bottom: 0.5rem;
}

blockquote {
    font-size: 1.25rem;
    font-style: italic;
    color: #1a73e8;
    border-left: 0.25rem solid #1a73e8;
    padding-left: 1.5rem;
    margin: 2rem 0;
}

/* Responsive: Adjust base size */
@media (max-width: 768px) {
    html {
        font-size: 14px;  /* All rem values scale down! */
    }
    
    .article {
        padding: 2rem;
    }
}
```

**Magic:** Change html font-size, everything scales proportionally!

---

## Activity 3: Percentage-Based Layouts

**Goal:** Create fluid layouts with percentages.

**Create:** `percentage-layouts.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Percentage Layouts</title>
    <link rel="stylesheet" href="percentage-layouts.css">
</head>
<body>
    <div class="container">
        <h1>Percentage-Based Layouts</h1>
        
        <section class="demo">
            <h2>Two-Column Layout (70% / 30%)</h2>
            <div class="two-column">
                <div class="main-content">
                    <h3>Main Content (70%)</h3>
                    <p>This column takes 70% of the width, leaving 30% for the sidebar.</p>
                </div>
                <div class="sidebar">
                    <h3>Sidebar (30%)</h3>
                    <p>Sidebar content here.</p>
                </div>
            </div>
        </section>
        
        <section class="demo">
            <h2>Three Equal Columns (33.333% each)</h2>
            <div class="three-column">
                <div class="column">
                    <h3>Clearance</h3>
                    <p>₱50.00</p>
                </div>
                <div class="column">
                    <h3>Barangay ID</h3>
                    <p>₱30.00</p>
                </div>
                <div class="column">
                    <h3>Permit</h3>
                    <p>₱500.00</p>
                </div>
            </div>
        </section>
        
        <section class="demo">
            <h2>Responsive Widths</h2>
            <div class="responsive-box">
                <p>I'm 90% wide on mobile, 80% on tablet, 60% on desktop</p>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `percentage-layouts.css`

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
    max-width: 1200px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

.demo {
    background-color: white;
    padding: 30px;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.demo h2 {
    color: #333;
    margin-bottom: 20px;
}

/* TWO-COLUMN LAYOUT */
.two-column {
    display: flex;
    gap: 20px;
}

.main-content {
    width: 70%;  /* 70% of parent */
    background-color: #e3f2fd;
    padding: 20px;
    border-radius: 8px;
}

.sidebar {
    width: 30%;  /* 30% of parent */
    background-color: #fff3e0;
    padding: 20px;
    border-radius: 8px;
}

/* THREE-COLUMN LAYOUT */
.three-column {
    display: flex;
    gap: 20px;
}

.column {
    width: 33.333%;  /* Equal width */
    background-color: #f1f8e9;
    padding: 20px;
    border-radius: 8px;
    text-align: center;
}

.column h3 {
    color: #1a73e8;
    margin-bottom: 10px;
}

.column p {
    color: #4caf50;
    font-size: 1.5rem;
    font-weight: bold;
}

/* RESPONSIVE BOX */
.responsive-box {
    width: 90%;  /* Mobile: 90% */
    margin: 0 auto;
    background-color: #f9f9f9;
    padding: 30px;
    border-radius: 8px;
    border: 3px solid #2196f3;
    text-align: center;
}

/* Tablet */
@media (min-width: 768px) {
    .responsive-box {
        width: 80%;  /* Tablet: 80% */
    }
}

/* Desktop */
@media (min-width: 1024px) {
    .responsive-box {
        width: 60%;  /* Desktop: 60% */
    }
}

/* Stack columns on mobile */
@media (max-width: 767px) {
    .two-column,
    .three-column {
        flex-direction: column;
    }
    
    .main-content,
    .sidebar,
    .column {
        width: 100%;
    }
}
```

**Percentages:** Always relative to parent element's width!

---

## Activity 4: Viewport Units (vw, vh)

**Goal:** Use viewport units for full-screen elements.

**Create:** `viewport-units.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Viewport Units</title>
    <link rel="stylesheet" href="viewport-units.css">
</head>
<body>
    <section class="hero">
        <h1>Welcome to Barangay San Miguel</h1>
        <p>Serving our community with integrity</p>
    </section>
    
    <section class="content">
        <h2>What are Viewport Units?</h2>
        <div class="demo-grid">
            <div class="demo-box vw-demo">
                <h3>50vw</h3>
                <p>50% of viewport width</p>
            </div>
            
            <div class="demo-box vh-demo">
                <h3>50vh</h3>
                <p>50% of viewport height</p>
            </div>
            
            <div class="demo-box vmin-demo">
                <h3>30vmin</h3>
                <p>30% of smaller dimension</p>
            </div>
            
            <div class="demo-box vmax-demo">
                <h3>30vmax</h3>
                <p>30% of larger dimension</p>
            </div>
        </div>
        
        <div class="explanation">
            <h3>Viewport Units Explained</h3>
            <ul>
                <li><strong>vw:</strong> 1vw = 1% of viewport width</li>
                <li><strong>vh:</strong> 1vh = 1% of viewport height</li>
                <li><strong>vmin:</strong> 1vmin = 1% of smaller dimension (width or height)</li>
                <li><strong>vmax:</strong> 1vmax = 1% of larger dimension</li>
            </ul>
        </div>
    </section>
</body>
</html>
```

**Create:** `viewport-units.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
}

/* HERO - Full viewport height */
.hero {
    width: 100vw;   /* 100% of viewport width */
    height: 100vh;  /* 100% of viewport height */
    background: linear-gradient(135deg, #1a73e8, #4caf50);
    color: white;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 20px;
}

.hero h1 {
    font-size: 5vw;  /* Scales with viewport width */
    margin-bottom: 20px;
}

.hero p {
    font-size: 2vw;
}

/* CONTENT SECTION */
.content {
    padding: 60px 20px;
    max-width: 1200px;
    margin: 0 auto;
}

.content h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2.5rem;
    margin-bottom: 40px;
}

/* DEMO GRID */
.demo-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
}

.demo-box {
    background-color: #2196f3;
    color: white;
    padding: 30px;
    border-radius: 10px;
    text-align: center;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.demo-box h3 {
    font-size: 2rem;
    margin-bottom: 10px;
}

.demo-box p {
    font-size: 1rem;
}

/* Viewport width demo */
.vw-demo {
    width: 50vw;   /* 50% of viewport width */
    min-height: 200px;
}

/* Viewport height demo */
.vh-demo {
    height: 50vh;  /* 50% of viewport height */
}

/* Viewport minimum demo */
.vmin-demo {
    width: 30vmin;   /* 30% of smaller dimension */
    height: 30vmin;
    background-color: #ff9800;
}

/* Viewport maximum demo */
.vmax-demo {
    width: 30vmax;   /* 30% of larger dimension */
    height: 30vmax;
    background-color: #4caf50;
}

/* EXPLANATION */
.explanation {
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.explanation h3 {
    color: #1a73e8;
    margin-bottom: 20px;
}

.explanation ul {
    list-style: none;
}

.explanation li {
    padding: 10px;
    margin-bottom: 10px;
    background-color: #f9f9f9;
    border-left: 4px solid #2196f3;
}

.explanation strong {
    color: #1a73e8;
}

/* Responsive font size */
@media (max-width: 768px) {
    .hero h1 {
        font-size: 8vw;  /* Larger on mobile */
    }
    
    .hero p {
        font-size: 4vw;
    }
}
```

**Use cases:**
- `100vh`: Full-screen hero sections
- `vw`: Responsive font sizes
- `vmin/vmax`: Square elements that scale

---

## Activity 5: The calc() Function

**Goal:** Combine different units with calculations.

**Create:** `calc-function.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CSS calc() Function</title>
    <link rel="stylesheet" href="calc-function.css">
</head>
<body>
    <div class="container">
        <h1>CSS calc() Examples</h1>
        
        <section class="demo">
            <h2>Sidebar Layout with Fixed Width</h2>
            <p>Main content = 100% width - fixed sidebar width - gap</p>
            <div class="layout">
                <aside class="sidebar-fixed">
                    <h3>Sidebar</h3>
                    <p>Fixed 200px width</p>
                </aside>
                <main class="main-calc">
                    <h3>Main Content</h3>
                    <p>Width: calc(100% - 200px - 20px)</p>
                    <p>Takes remaining space after sidebar and gap</p>
                </main>
            </div>
        </section>
        
        <section class="demo">
            <h2>Centered Element with Offset</h2>
            <div class="centered-offset">
                <p>Centered with 50px offset from top</p>
            </div>
        </section>
        
        <section class="demo">
            <h2>Responsive Padding</h2>
            <div class="responsive-padding">
                <p>Padding: calc(2rem + 2vw)</p>
                <p>Grows with viewport but has minimum base size</p>
            </div>
        </section>
        
        <section class="demo">
            <h2>Card Grid with Gap</h2>
            <div class="card-grid">
                <div class="card">Card 1</div>
                <div class="card">Card 2</div>
                <div class="card">Card 3</div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `calc-function.css`

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
    max-width: 1200px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

.demo {
    background-color: white;
    padding: 30px;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.demo h2 {
    color: #333;
    margin-bottom: 10px;
}

.demo > p {
    color: #666;
    margin-bottom: 20px;
    font-style: italic;
}

/* SIDEBAR LAYOUT */
.layout {
    display: flex;
    gap: 20px;
    min-height: 200px;
}

.sidebar-fixed {
    width: 200px;  /* Fixed width */
    background-color: #e3f2fd;
    padding: 20px;
    border-radius: 8px;
}

.main-calc {
    width: calc(100% - 200px - 20px);  /* Remaining space */
    background-color: #f1f8e9;
    padding: 20px;
    border-radius: 8px;
}

/* CENTERED WITH OFFSET */
.centered-offset {
    width: 80%;
    max-width: 600px;
    margin: 0 auto;
    margin-top: calc(50px + 2rem);  /* Fixed + relative */
    background-color: #fff3e0;
    padding: 30px;
    text-align: center;
    border-radius: 8px;
}

/* RESPONSIVE PADDING */
.responsive-padding {
    background-color: #f3e5f5;
    padding: calc(2rem + 2vw);  /* Base + responsive */
    border-radius: 8px;
    text-align: center;
}

/* CARD GRID */
.card-grid {
    display: flex;
    gap: 20px;
}

.card {
    width: calc(33.333% - 14px);  /* Equal width minus gap */
    background-color: #2196f3;
    color: white;
    padding: 40px 20px;
    text-align: center;
    font-weight: bold;
    border-radius: 8px;
}

/* Responsive */
@media (max-width: 768px) {
    .layout {
        flex-direction: column;
    }
    
    .sidebar-fixed,
    .main-calc {
        width: 100%;
    }
    
    .card-grid {
        flex-direction: column;
    }
    
    .card {
        width: 100%;
    }
}
```

**calc() examples:**
- `calc(100% - 200px)`: Mix percentages and pixels
- `calc(2rem + 2vw)`: Combine rem and viewport units
- `calc(33.333% - 14px)`: Adjust for gaps

---

## Activity 6: Complete Responsive Unit System

**Goal:** Build a design using all responsive units together.

**Create:** `complete-unit-system.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Portal - All Units</title>
    <link rel="stylesheet" href="complete-unit-system.css">
</head>
<body>
    <!-- Hero: 100vh -->
    <section class="hero">
        <h1>Barangay San Miguel</h1>
        <p>Serving with dedication</p>
        <button>Get Started</button>
    </section>
    
    <!-- Services: rem + percentage -->
    <section class="services">
        <h2>Our Services</h2>
        <div class="services-grid">
            <div class="service-card">
                <div class="icon">📄</div>
                <h3>Clearance</h3>
                <p>Barangay clearance for various purposes</p>
                <div class="price">₱50.00</div>
            </div>
            
            <div class="service-card">
                <div class="icon">🆔</div>
                <h3>Barangay ID</h3>
                <p>Official resident identification</p>
                <div class="price">₱30.00</div>
            </div>
            
            <div class="service-card">
                <div class="icon">💼</div>
                <h3>Business Permit</h3>
                <p>Required for business operations</p>
                <div class="price">₱500.00</div>
            </div>
        </div>
    </section>
    
    <!-- About: max-width + padding -->
    <section class="about">
        <h2>About Our Barangay</h2>
        <p>We are committed to providing excellent service to all residents through efficient governance and community programs.</p>
    </section>
    
    <!-- Contact: vmin for square elements -->
    <section class="contact">
        <h2>Contact Information</h2>
        <div class="contact-grid">
            <div class="contact-item">
                <div class="square-icon">📞</div>
                <h4>Phone</h4>
                <p>043-123-4567</p>
            </div>
            
            <div class="contact-item">
                <div class="square-icon">📧</div>
                <h4>Email</h4>
                <p>info@brgy.ph</p>
            </div>
            
            <div class="contact-item">
                <div class="square-icon">🏛️</div>
                <h4>Office</h4>
                <p>Barangay Hall</p>
            </div>
        </div>
    </section>
</body>
</html>
```

**Create:** `complete-unit-system.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Base font size for rem */
html {
    font-size: 16px;
}

body {
    font-family: Arial, sans-serif;
}

/* HERO: Viewport units */
.hero {
    width: 100vw;
    height: 100vh;
    background: linear-gradient(135deg, #1a73e8, #4caf50);
    color: white;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: calc(2rem + 2vw);  /* Calc for responsive padding */
}

.hero h1 {
    font-size: clamp(2rem, 5vw, 4rem);  /* Fluid typography */
    margin-bottom: 1rem;
}

.hero p {
    font-size: clamp(1rem, 2vw, 1.5rem);
    margin-bottom: 2rem;
}

.hero button {
    padding: 1rem 2.5rem;
    font-size: 1.1rem;
    background-color: white;
    color: #1a73e8;
    border: none;
    border-radius: 2rem;
    font-weight: bold;
    cursor: pointer;
}

/* SERVICES: Rem + percentage */
.services {
    padding: 4rem 5%;  /* Percentage horizontal padding */
    background-color: #f5f5f5;
}

.services h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2.5rem;  /* Rem for typography */
    margin-bottom: 3rem;
}

.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.service-card {
    background-color: white;
    padding: 2rem;  /* Rem for internal spacing */
    border-radius: 1rem;
    text-align: center;
    box-shadow: 0 0.25rem 0.5rem rgba(0,0,0,0.1);
}

.icon {
    font-size: 4rem;
    margin-bottom: 1rem;
}

.service-card h3 {
    color: #333;
    font-size: 1.5rem;
    margin-bottom: 0.75rem;
}

.service-card p {
    color: #666;
    font-size: 1rem;
    margin-bottom: 1rem;
}

.price {
    color: #4caf50;
    font-size: 2rem;
    font-weight: bold;
}

/* ABOUT: Max-width + padding */
.about {
    max-width: 800px;  /* Fixed max-width */
    margin: 0 auto;
    padding: 4rem 5%;  /* Percentage padding */
    text-align: center;
}

.about h2 {
    color: #1a73e8;
    font-size: 2.5rem;
    margin-bottom: 1.5rem;
}

.about p {
    color: #666;
    font-size: 1.2rem;
    line-height: 1.8;
}

/* CONTACT: Vmin for squares */
.contact {
    padding: 4rem 5%;
    background-color: #f5f5f5;
}

.contact h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2.5rem;
    margin-bottom: 3rem;
}

.contact-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 2rem;
    max-width: 1000px;
    margin: 0 auto;
}

.contact-item {
    background-color: white;
    padding: 2rem;
    border-radius: 1rem;
    text-align: center;
    box-shadow: 0 0.25rem 0.5rem rgba(0,0,0,0.1);
}

.square-icon {
    width: 15vmin;   /* Square using vmin */
    height: 15vmin;
    max-width: 100px;
    max-height: 100px;
    margin: 0 auto 1rem;
    background-color: #1a73e8;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 3rem;
}

.contact-item h4 {
    color: #1a73e8;
    font-size: 1.25rem;
    margin-bottom: 0.5rem;
}

.contact-item p {
    color: #666;
    font-size: 1rem;
}

/* Responsive */
@media (max-width: 768px) {
    html {
        font-size: 14px;  /* Scale down rem */
    }
}
```

**Units used:**
✅ `rem`: Typography, spacing  
✅ `vw/vh`: Full-screen hero  
✅ `%`: Grid widths, padding  
✅ `vmin`: Square icons  
✅ `calc()`: Responsive padding  
✅ `clamp()`: Fluid typography  
✅ `px`: Max-widths, box-shadow

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Responsive Units Complete Reference

### Unit Types

**Absolute Units:**
- `px`: Pixels - fixed size, doesn't scale

**Relative Units:**
- `rem`: Relative to root font-size
- `em`: Relative to parent font-size
- `%`: Percentage of parent
- `vw`: Viewport width (1vw = 1% of viewport width)
- `vh`: Viewport height (1vh = 1% of viewport height)
- `vmin`: Smaller of vw or vh
- `vmax`: Larger of vw or vh

---

### Rem vs Em

**Rem (Root Em):**
```css
html {
    font-size: 16px;  /* Base size */
}

h1 {
    font-size: 2rem;  /* 32px (2 * 16px) */
}

p {
    font-size: 1rem;  /* 16px (1 * 16px) */
}
```

**Benefits:**
- Predictable scaling
- One place to change all sizes
- Accessible (respects user preferences)

**Em:**
```css
.parent {
    font-size: 20px;
}

.child {
    font-size: 1.5em;  /* 30px (1.5 * 20px) */
}
```

**Benefits:**
- Component-based sizing
- Scales with parent

**When to use:**
- `rem`: Typography, spacing, most layouts
- `em`: Component-relative sizing (buttons, badges)

---

### Viewport Units

**vw (Viewport Width):**
```css
.element {
    width: 50vw;  /* 50% of viewport width */
    font-size: 5vw;  /* Scales with viewport */
}
```

**vh (Viewport Height):**
```css
.hero {
    height: 100vh;  /* Full viewport height */
}
```

**vmin/vmax:**
```css
.square {
    width: 20vmin;   /* 20% of smaller dimension */
    height: 20vmin;  /* Always square */
}
```

**Use cases:**
- `100vh`: Full-screen sections
- `vw`: Fluid typography
- `vmin`: Square elements that scale
- `vmax`: Fill larger dimension

---

### Percentages

```css
.container {
    width: 80%;  /* 80% of parent width */
}

.column {
    width: 33.333%;  /* One-third of parent */
}

.padding-box {
    padding: 5%;  /* 5% of parent width (yes, even vertical!) */
}
```

**Note:** Percentage padding/margin is always based on parent WIDTH, even for top/bottom!

---

### calc() Function

**Mixing units:**
```css
.element {
    width: calc(100% - 200px);  /* Percentage minus fixed */
    padding: calc(2rem + 2vw);  /* Rem plus viewport */
    margin-top: calc(50vh - 100px);  /* Center with offset */
}
```

**Operators:**
- `+`: Addition (spaces required!)
- `-`: Subtraction (spaces required!)
- `*`: Multiplication
- `/`: Division

**Examples:**
```css
/* Sidebar layout */
.sidebar {
    width: 250px;
}

.main {
    width: calc(100% - 250px - 20px);  /* Remaining space minus gap */
}

/* Responsive padding */
.box {
    padding: calc(1rem + 1vw);  /* Grows with viewport */
}

/* Grid columns with gap */
.column {
    width: calc(33.333% - 20px);  /* Equal width minus gap */
}
```

---

### clamp() Function

**Fluid typography:**
```css
h1 {
    font-size: clamp(1.5rem, 5vw, 3rem);
    /* min: 1.5rem, preferred: 5vw, max: 3rem */
}
```

**Format:** `clamp(min, preferred, max)`

---

### min() and max()

```css
.element {
    width: min(90%, 1200px);  /* Smaller of 90% or 1200px */
    padding: max(20px, 2rem);  /* Larger of 20px or 2rem */
}
```

---

## When to Use Each Unit

**Typography:**
```css
/* Use rem for consistency */
html { font-size: 16px; }
h1 { font-size: 2.5rem; }
p { font-size: 1rem; }

/* Or fluid with clamp() */
h1 { font-size: clamp(2rem, 5vw, 4rem); }
```

**Spacing:**
```css
/* Use rem for consistency */
.container {
    padding: 2rem;
    margin-bottom: 3rem;
    gap: 1.5rem;
}
```

**Layout Widths:**
```css
/* Use percentages or fr units */
.column {
    width: 33.333%;  /* Or use CSS Grid */
}

.container {
    max-width: 1200px;  /* Max-width in px is fine */
    width: 90%;         /* Fluid width */
}
```

**Full-Screen Elements:**
```css
.hero {
    width: 100vw;
    height: 100vh;
}
```

**Responsive Padding:**
```css
.section {
    padding: calc(2rem + 2vw);  /* Grows with viewport */
}
```

---

## Best Practices

1. **Set base font-size:**
   ```css
   html {
       font-size: 16px;  /* Or 100% for user preference */
   }
   ```

2. **Use rem for typography and spacing**
3. **Use % for layout widths**
4. **Use vw/vh for full-screen elements**
5. **Use calc() to mix units**
6. **Avoid em for global sizing** (compounds with nesting)
7. **Test with browser zoom** - rem scales, px doesn't!

---

## Common Patterns

**Responsive Typography:**
```css
html { font-size: 16px; }

h1 { font-size: 2.5rem; }
h2 { font-size: 2rem; }
p { font-size: 1rem; }

@media (max-width: 768px) {
    html { font-size: 14px; }  /* Everything scales down! */
}
```

**Full-Screen Hero:**
```css
.hero {
    width: 100vw;
    height: 100vh;
    padding: calc(2rem + 2vw);
}
```

**Fluid Layout:**
```css
.container {
    width: 90%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}
```

**Responsive Grid:**
```css
.grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
}
```

</details>

---

**Congratulations!** You've mastered responsive units!

**Next Lesson:** CSS Grid - Two-dimensional layouts!

