# Lesson 21 Activities: CSS Grid Overview

## The Ultimate Two-Dimensional Layout System

Flexbox is great for rows or columns. Grid handles both simultaneously - perfect for complex layouts!

---

## Activity 1: Grid Basics - Rows and Columns

**Goal:** Create your first CSS Grid layout.

**Create:** `grid-basics.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CSS Grid Basics</title>
    <link rel="stylesheet" href="grid-basics.css">
</head>
<body>
    <div class="container">
        <h1>CSS Grid Basics</h1>
        
        <section class="demo">
            <h2>3 Columns × 2 Rows</h2>
            <div class="grid-container">
                <div class="grid-item">Item 1</div>
                <div class="grid-item">Item 2</div>
                <div class="grid-item">Item 3</div>
                <div class="grid-item">Item 4</div>
                <div class="grid-item">Item 5</div>
                <div class="grid-item">Item 6</div>
            </div>
        </section>
        
        <section class="demo">
            <h2>2 Columns × 3 Rows</h2>
            <div class="grid-container-2">
                <div class="grid-item">Item 1</div>
                <div class="grid-item">Item 2</div>
                <div class="grid-item">Item 3</div>
                <div class="grid-item">Item 4</div>
                <div class="grid-item">Item 5</div>
                <div class="grid-item">Item 6</div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `grid-basics.css`

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

/* GRID CONTAINER - 3 columns */
.grid-container {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;  /* 3 equal columns */
    grid-template-rows: 100px 100px;     /* 2 rows of 100px */
    gap: 15px;
}

/* GRID CONTAINER 2 - 2 columns */
.grid-container-2 {
    display: grid;
    grid-template-columns: 1fr 1fr;      /* 2 equal columns */
    grid-template-rows: 100px 100px 100px;  /* 3 rows */
    gap: 15px;
}

.grid-item {
    background-color: #2196f3;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 1.2rem;
    border-radius: 8px;
}
```

**Key concepts:**
- `display: grid` creates grid container
- `grid-template-columns` defines column sizes
- `grid-template-rows` defines row sizes
- `gap` adds spacing between items

---

## Activity 2: Grid Template with Different Sizes

**Goal:** Create columns with different widths.

**Create:** `grid-template-sizes.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grid Template Sizes</title>
    <link rel="stylesheet" href="grid-template-sizes.css">
</head>
<body>
    <div class="container">
        <h1>Grid Column Sizes</h1>
        
        <section class="demo">
            <h2>Sidebar Layout (200px + Auto + 200px)</h2>
            <div class="sidebar-grid">
                <div class="grid-item">Left Sidebar<br>200px</div>
                <div class="grid-item">Main Content<br>Flexible</div>
                <div class="grid-item">Right Sidebar<br>200px</div>
            </div>
        </section>
        
        <section class="demo">
            <h2>Proportional (1fr + 2fr + 1fr)</h2>
            <p class="note">2fr column is twice as wide as 1fr columns</p>
            <div class="proportional-grid">
                <div class="grid-item">1fr</div>
                <div class="grid-item">2fr (double width)</div>
                <div class="grid-item">1fr</div>
            </div>
        </section>
        
        <section class="demo">
            <h2>Mixed Units (200px + 1fr + 20%)</h2>
            <div class="mixed-grid">
                <div class="grid-item">200px Fixed</div>
                <div class="grid-item">1fr Flexible</div>
                <div class="grid-item">20% Relative</div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `grid-template-sizes.css`

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
    margin-bottom: 15px;
}

.note {
    color: #666;
    font-style: italic;
    margin-bottom: 20px;
}

/* SIDEBAR GRID - Fixed sidebars, flexible center */
.sidebar-grid {
    display: grid;
    grid-template-columns: 200px 1fr 200px;  /* Fixed + Flexible + Fixed */
    gap: 15px;
    min-height: 150px;
}

/* PROPORTIONAL GRID - fr units */
.proportional-grid {
    display: grid;
    grid-template-columns: 1fr 2fr 1fr;  /* 1 part, 2 parts, 1 part */
    gap: 15px;
    min-height: 150px;
}

/* MIXED UNITS GRID */
.mixed-grid {
    display: grid;
    grid-template-columns: 200px 1fr 20%;  /* px + fr + % */
    gap: 15px;
    min-height: 150px;
}

.grid-item {
    background-color: #2196f3;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    font-weight: bold;
    border-radius: 8px;
    padding: 20px;
}

/* Responsive */
@media (max-width: 768px) {
    .sidebar-grid,
    .proportional-grid,
    .mixed-grid {
        grid-template-columns: 1fr;  /* Stack on mobile */
    }
}
```

**fr unit:** Fraction of available space (like flex-grow)

---

## Activity 3: Grid Areas - Named Layout

**Goal:** Create layouts using named grid areas.

**Create:** `grid-areas.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grid Areas</title>
    <link rel="stylesheet" href="grid-areas.css">
</head>
<body>
    <div class="layout">
        <header class="header">Header</header>
        <nav class="sidebar">Sidebar Navigation</nav>
        <main class="main">Main Content Area</main>
        <aside class="ads">Advertisement</aside>
        <footer class="footer">Footer</footer>
    </div>
</body>
</html>
```

**Create:** `grid-areas.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    min-height: 100vh;
}

/* GRID LAYOUT with named areas */
.layout {
    display: grid;
    grid-template-columns: 200px 1fr 200px;
    grid-template-rows: 80px 1fr 60px;
    grid-template-areas:
        "header  header  header"
        "sidebar main    ads"
        "footer  footer  footer";
    gap: 15px;
    min-height: 100vh;
    padding: 15px;
    background-color: #f5f5f5;
}

/* Assign elements to grid areas */
.header {
    grid-area: header;
    background-color: #1a73e8;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    font-weight: bold;
    border-radius: 8px;
}

.sidebar {
    grid-area: sidebar;
    background-color: #4caf50;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    border-radius: 8px;
}

.main {
    grid-area: main;
    background-color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.ads {
    grid-area: ads;
    background-color: #ff9800;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    border-radius: 8px;
}

.footer {
    grid-area: footer;
    background-color: #333;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    border-radius: 8px;
}

/* RESPONSIVE - Stack on mobile */
@media (max-width: 768px) {
    .layout {
        grid-template-columns: 1fr;
        grid-template-rows: auto;
        grid-template-areas:
            "header"
            "main"
            "sidebar"
            "ads"
            "footer";
    }
}
```

**Grid areas:** Visual way to define layout - HTML order doesn't matter!

---

## Activity 4: Repeat() and Minmax()

**Goal:** Use repeat() for patterns and minmax() for flexibility.

**Create:** `repeat-minmax.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Repeat and Minmax</title>
    <link rel="stylesheet" href="repeat-minmax.css">
</head>
<body>
    <div class="container">
        <h1>Repeat() and Minmax()</h1>
        
        <section class="demo">
            <h2>repeat(4, 1fr) - 4 Equal Columns</h2>
            <div class="repeat-grid">
                <div class="box">1</div>
                <div class="box">2</div>
                <div class="box">3</div>
                <div class="box">4</div>
                <div class="box">5</div>
                <div class="box">6</div>
                <div class="box">7</div>
                <div class="box">8</div>
            </div>
        </section>
        
        <section class="demo">
            <h2>repeat(auto-fit, minmax(200px, 1fr)) - Responsive!</h2>
            <p class="note">Columns automatically adjust to screen size</p>
            <div class="auto-grid">
                <div class="box">Service 1</div>
                <div class="box">Service 2</div>
                <div class="box">Service 3</div>
                <div class="box">Service 4</div>
                <div class="box">Service 5</div>
                <div class="box">Service 6</div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `repeat-minmax.css`

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
    margin-bottom: 15px;
}

.note {
    color: #666;
    font-style: italic;
    margin-bottom: 20px;
}

/* REPEAT GRID - 4 equal columns */
.repeat-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);  /* Same as: 1fr 1fr 1fr 1fr */
    gap: 15px;
}

/* AUTO-FIT with MINMAX - Responsive grid! */
.auto-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    /* auto-fit: fit as many columns as possible
       minmax(200px, 1fr): min 200px, max 1fr */
    gap: 15px;
}

.box {
    background-color: #2196f3;
    color: white;
    padding: 40px 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 1.2rem;
    border-radius: 8px;
}

/* No media queries needed! Grid adjusts automatically */
```

**Magic:** `repeat(auto-fit, minmax(200px, 1fr))` = automatic responsive grid!

---

## Activity 5: Barangay Services Grid

**Goal:** Build a real-world service listing.

**Create:** `services-grid.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Services Grid</title>
    <link rel="stylesheet" href="services-grid.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Services</h1>
        <p class="subtitle">All services in one convenient location</p>
        
        <div class="services-grid">
            <div class="service-card">
                <div class="icon">📄</div>
                <h3>Barangay Clearance</h3>
                <p>For employment, business, and travel purposes</p>
                <div class="price">₱50.00</div>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">🆔</div>
                <h3>Barangay ID</h3>
                <p>Official resident identification card</p>
                <div class="price">₱30.00</div>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">💼</div>
                <h3>Business Permit</h3>
                <p>Required for all business operations</p>
                <div class="price">₱500.00</div>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">📜</div>
                <h3>Residency Certificate</h3>
                <p>Proof of barangay residency</p>
                <div class="price">₱30.00</div>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">🏥</div>
                <h3>Indigency Certificate</h3>
                <p>For medical and financial assistance</p>
                <div class="price">Free</div>
                <button>Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">💳</div>
                <h3>Community Tax</h3>
                <p>Annual community tax certificate</p>
                <div class="price">₱5.00</div>
                <button>Apply Now</button>
            </div>
        </div>
    </div>
</body>
</html>
```

**Create:** `services-grid.css`

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
    font-size: 2.5rem;
    margin-bottom: 10px;
}

.subtitle {
    text-align: center;
    color: #666;
    font-size: 1.1rem;
    margin-bottom: 40px;
}

/* SERVICES GRID - Auto-responsive! */
.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 25px;
}

.service-card {
    background-color: white;
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    transition: transform 0.3s, box-shadow 0.3s;
    display: flex;
    flex-direction: column;
}

.service-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 8px 16px rgba(0,0,0,0.2);
}

.icon {
    font-size: 64px;
    margin-bottom: 20px;
}

.service-card h3 {
    color: #1a73e8;
    font-size: 1.4rem;
    margin-bottom: 15px;
}

.service-card p {
    color: #666;
    line-height: 1.6;
    margin-bottom: 20px;
    flex-grow: 1;  /* Push button to bottom */
}

.price {
    color: #4caf50;
    font-size: 2rem;
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
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
}

.service-card button:hover {
    background-color: #1557b0;
}
```

**No media queries needed!** Grid automatically adjusts columns based on screen size.

---

## Activity 6: Dashboard Layout with Grid

**Goal:** Create a complex dashboard layout.

**Create:** `dashboard-grid.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Dashboard</title>
    <link rel="stylesheet" href="dashboard-grid.css">
</head>
<body>
    <div class="dashboard">
        <header class="header">
            <h1>Barangay Dashboard</h1>
        </header>
        
        <nav class="sidebar">
            <h3>Navigation</h3>
            <ul>
                <li>Dashboard</li>
                <li>Residents</li>
                <li>Documents</li>
                <li>Reports</li>
            </ul>
        </nav>
        
        <div class="stats">
            <div class="stat-card">
                <h2>1,234</h2>
                <p>Registered Residents</p>
            </div>
            <div class="stat-card">
                <h2>89</h2>
                <p>Pending Applications</p>
            </div>
            <div class="stat-card">
                <h2>456</h2>
                <p>This Month</p>
            </div>
            <div class="stat-card">
                <h2>₱125,000</h2>
                <p>Revenue (Monthly)</p>
            </div>
        </div>
        
        <section class="chart">
            <h3>Application Trends</h3>
            <div class="chart-placeholder">[Chart Area]</div>
        </section>
        
        <section class="recent">
            <h3>Recent Applications</h3>
            <div class="application">Juan Dela Cruz - Clearance</div>
            <div class="application">Maria Santos - Barangay ID</div>
            <div class="application">Pedro Garcia - Business Permit</div>
        </section>
        
        <footer class="footer">
            <p>&copy; 2025 Barangay San Miguel</p>
        </footer>
    </div>
</body>
</html>
```

**Create:** `dashboard-grid.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
}

/* DASHBOARD GRID LAYOUT */
.dashboard {
    display: grid;
    grid-template-columns: 250px 1fr;
    grid-template-rows: 80px auto auto 1fr 60px;
    grid-template-areas:
        "header  header"
        "sidebar stats"
        "sidebar chart"
        "sidebar recent"
        "footer  footer";
    gap: 20px;
    min-height: 100vh;
    padding: 20px;
}

/* HEADER */
.header {
    grid-area: header;
    background-color: #1a73e8;
    color: white;
    display: flex;
    align-items: center;
    padding: 0 30px;
    border-radius: 10px;
}

/* SIDEBAR */
.sidebar {
    grid-area: sidebar;
    background-color: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.sidebar h3 {
    color: #1a73e8;
    margin-bottom: 20px;
}

.sidebar ul {
    list-style: none;
}

.sidebar li {
    padding: 12px;
    margin-bottom: 8px;
    background-color: #f5f5f5;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.sidebar li:hover {
    background-color: #e3f2fd;
}

/* STATS - Nested Grid! */
.stats {
    grid-area: stats;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
}

.stat-card {
    background-color: white;
    padding: 25px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.stat-card h2 {
    color: #1a73e8;
    font-size: 2.5rem;
    margin-bottom: 10px;
}

.stat-card p {
    color: #666;
}

/* CHART */
.chart {
    grid-area: chart;
    background-color: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.chart h3 {
    color: #333;
    margin-bottom: 20px;
}

.chart-placeholder {
    background-color: #f5f5f5;
    padding: 100px;
    text-align: center;
    color: #999;
    border-radius: 5px;
}

/* RECENT */
.recent {
    grid-area: recent;
    background-color: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.recent h3 {
    color: #333;
    margin-bottom: 20px;
}

.application {
    padding: 15px;
    margin-bottom: 10px;
    background-color: #f5f5f5;
    border-left: 4px solid #2196f3;
    border-radius: 5px;
}

/* FOOTER */
.footer {
    grid-area: footer;
    background-color: #333;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 10px;
}

/* RESPONSIVE */
@media (max-width: 1024px) {
    .dashboard {
        grid-template-columns: 1fr;
        grid-template-areas:
            "header"
            "stats"
            "chart"
            "recent"
            "sidebar"
            "footer";
    }
}
```

**Nested grids:** Stats section is a grid inside the main grid!

---

## Activity 7: Complete Barangay Portal with Grid

**Goal:** Build full portal using CSS Grid.

**Create:** `complete-grid-portal.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay San Miguel - Grid Layout</title>
    <link rel="stylesheet" href="complete-grid-portal.css">
</head>
<body>
    <div class="page-grid">
        <!-- Header -->
        <header class="header">
            <div class="logo">🏛️ Barangay San Miguel</div>
            <nav>
                <a href="#home">Home</a>
                <a href="#services">Services</a>
                <a href="#announcements">Announcements</a>
                <a href="#contact">Contact</a>
            </nav>
        </header>
        
        <!-- Hero -->
        <section class="hero">
            <h1>Welcome to Our Community</h1>
            <p>Serving with integrity and excellence</p>
            <button>Get Started</button>
        </section>
        
        <!-- Services Section with Nested Grid -->
        <section class="services">
            <h2>Our Services</h2>
            <div class="services-grid">
                <div class="service">
                    <div class="icon">📄</div>
                    <h3>Clearance</h3>
                    <p>₱50.00</p>
                </div>
                <div class="service">
                    <div class="icon">🆔</div>
                    <h3>Barangay ID</h3>
                    <p>₱30.00</p>
                </div>
                <div class="service">
                    <div class="icon">💼</div>
                    <h3>Business Permit</h3>
                    <p>₱500.00</p>
                </div>
                <div class="service">
                    <div class="icon">📜</div>
                    <h3>Certificate</h3>
                    <p>₱30.00</p>
                </div>
                <div class="service">
                    <div class="icon">🏥</div>
                    <h3>Indigency</h3>
                    <p>Free</p>
                </div>
                <div class="service">
                    <div class="icon">💳</div>
                    <h3>Community Tax</h3>
                    <p>₱5.00</p>
                </div>
            </div>
        </section>
        
        <!-- Content Area with Sidebar -->
        <aside class="sidebar">
            <h3>Quick Links</h3>
            <ul>
                <li>Apply Online</li>
                <li>Check Status</li>
                <li>Download Forms</li>
                <li>FAQs</li>
            </ul>
        </aside>
        
        <main class="main-content">
            <h2>Latest News</h2>
            <article class="news-item">
                <h3>Typhoon Warning</h3>
                <p>Signal #2 in effect. Stay safe indoors.</p>
            </article>
            <article class="news-item">
                <h3>Christmas Program</h3>
                <p>Annual celebration on December 20!</p>
            </article>
        </main>
        
        <!-- Footer -->
        <footer class="footer">
            <p>&copy; 2025 Barangay San Miguel. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
```

**Create:** `complete-grid-portal.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
}

/* MAIN PAGE GRID */
.page-grid {
    display: grid;
    grid-template-columns: 250px 1fr;
    grid-template-rows: 80px auto auto 1fr 60px;
    grid-template-areas:
        "header   header"
        "hero     hero"
        "services services"
        "sidebar  main"
        "footer   footer";
    gap: 20px;
    min-height: 100vh;
    padding: 20px;
    background-color: #f5f5f5;
}

/* HEADER */
.header {
    grid-area: header;
    background-color: #1a73e8;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 30px;
    border-radius: 10px;
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
}

.header nav {
    display: flex;
    gap: 20px;
}

.header nav a {
    color: white;
    text-decoration: none;
    padding: 8px 15px;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.header nav a:hover {
    background-color: rgba(255,255,255,0.2);
}

/* HERO */
.hero {
    grid-area: hero;
    background: linear-gradient(135deg, #1a73e8, #4caf50);
    color: white;
    text-align: center;
    padding: 80px 20px;
    border-radius: 15px;
}

.hero h1 {
    font-size: 3rem;
    margin-bottom: 15px;
}

.hero p {
    font-size: 1.3rem;
    margin-bottom: 30px;
}

.hero button {
    padding: 15px 40px;
    font-size: 1.1rem;
    background-color: white;
    color: #1a73e8;
    border: none;
    border-radius: 30px;
    font-weight: bold;
    cursor: pointer;
}

/* SERVICES with NESTED GRID */
.services {
    grid-area: services;
    background-color: white;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.services h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2.5rem;
    margin-bottom: 30px;
}

.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
}

.service {
    background-color: #f9f9f9;
    padding: 30px;
    text-align: center;
    border-radius: 10px;
    transition: transform 0.3s;
}

.service:hover {
    transform: translateY(-5px);
}

.icon {
    font-size: 48px;
    margin-bottom: 15px;
}

.service h3 {
    color: #333;
    margin-bottom: 10px;
}

.service p {
    color: #4caf50;
    font-size: 1.5rem;
    font-weight: bold;
}

/* SIDEBAR */
.sidebar {
    grid-area: sidebar;
    background-color: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.sidebar h3 {
    color: #1a73e8;
    margin-bottom: 20px;
}

.sidebar ul {
    list-style: none;
}

.sidebar li {
    padding: 12px;
    margin-bottom: 8px;
    background-color: #f5f5f5;
    border-radius: 5px;
    cursor: pointer;
}

.sidebar li:hover {
    background-color: #e3f2fd;
}

/* MAIN CONTENT */
.main-content {
    grid-area: main;
    background-color: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.main-content h2 {
    color: #1a73e8;
    margin-bottom: 20px;
}

.news-item {
    padding: 20px;
    margin-bottom: 15px;
    background-color: #f9f9f9;
    border-left: 4px solid #2196f3;
    border-radius: 5px;
}

.news-item h3 {
    color: #333;
    margin-bottom: 10px;
}

.news-item p {
    color: #666;
}

/* FOOTER */
.footer {
    grid-area: footer;
    background-color: #333;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 10px;
}

/* RESPONSIVE */
@media (max-width: 1024px) {
    .page-grid {
        grid-template-columns: 1fr;
        grid-template-areas:
            "header"
            "hero"
            "services"
            "main"
            "sidebar"
            "footer";
    }
}

@media (max-width: 768px) {
    .header {
        flex-direction: column;
        gap: 15px;
        padding: 20px;
    }
    
    .header nav {
        flex-direction: column;
        width: 100%;
    }
    
    .hero h1 {
        font-size: 2rem;
    }
}
```

**Features:**
✅ Two-dimensional grid layout  
✅ Named grid areas  
✅ Nested grids (services inside main grid)  
✅ Auto-responsive services grid  
✅ Flexible sidebar + main content  
✅ Responsive breakpoints

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## CSS Grid Complete Reference

### Basic Grid Setup

```css
.container {
    display: grid;
    grid-template-columns: 200px 1fr 200px;  /* 3 columns */
    grid-template-rows: 100px auto 60px;     /* 3 rows */
    gap: 20px;  /* Spacing between cells */
}
```

---

### Grid Template Columns/Rows

**Fixed sizes:**
```css
grid-template-columns: 200px 300px 400px;
```

**Fractional units (fr):**
```css
grid-template-columns: 1fr 2fr 1fr;  /* 1 part, 2 parts, 1 part */
```

**Mixed units:**
```css
grid-template-columns: 200px 1fr 20%;  /* px, fr, % */
```

**Repeat:**
```css
grid-template-columns: repeat(3, 1fr);  /* Same as: 1fr 1fr 1fr */
grid-template-columns: repeat(4, 200px);
```

---

### Auto-Responsive Grid

**Magic pattern:**
```css
.grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
}
```

- `auto-fit`: Fit as many columns as possible
- `minmax(250px, 1fr)`: Minimum 250px, maximum 1fr
- No media queries needed!

**auto-fit vs auto-fill:**
- `auto-fit`: Collapses empty tracks
- `auto-fill`: Keeps empty tracks

---

### Grid Areas

**Define layout:**
```css
.container {
    display: grid;
    grid-template-columns: 200px 1fr 200px;
    grid-template-rows: 80px 1fr 60px;
    grid-template-areas:
        "header  header  header"
        "sidebar main    ads"
        "footer  footer  footer";
}
```

**Assign elements:**
```css
.header { grid-area: header; }
.sidebar { grid-area: sidebar; }
.main { grid-area: main; }
.ads { grid-area: ads; }
.footer { grid-area: footer; }
```

---

### Gap (Spacing)

```css
.grid {
    gap: 20px;  /* Row and column gap */
    
    /* Or separate: */
    row-gap: 30px;
    column-gap: 20px;
}
```

---

### Item Placement

**Span columns/rows:**
```css
.item {
    grid-column: span 2;  /* Span 2 columns */
    grid-row: span 3;     /* Span 3 rows */
}
```

**Specific placement:**
```css
.item {
    grid-column: 1 / 3;  /* From line 1 to line 3 */
    grid-row: 2 / 4;     /* From line 2 to line 4 */
}
```

---

### Alignment

**Align items (inside cells):**
```css
.container {
    align-items: center;     /* Vertical alignment */
    justify-items: center;   /* Horizontal alignment */
}
```

**Align content (grid in container):**
```css
.container {
    align-content: center;    /* Vertical */
    justify-content: center;  /* Horizontal */
}
```

**Individual item:**
```css
.item {
    align-self: center;
    justify-self: center;
}
```

---

## Common Patterns

### Holy Grail Layout
```css
.layout {
    display: grid;
    grid-template-columns: 200px 1fr 200px;
    grid-template-rows: 80px 1fr 60px;
    grid-template-areas:
        "header  header  header"
        "sidebar main    ads"
        "footer  footer  footer";
    min-height: 100vh;
}
```

### Card Grid (Auto-Responsive)
```css
.cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
}
```

### Dashboard Layout
```css
.dashboard {
    display: grid;
    grid-template-columns: 250px 1fr;
    grid-template-rows: 80px auto 1fr 60px;
    grid-template-areas:
        "header header"
        "sidebar stats"
        "sidebar main"
        "footer footer";
}
```

### Nested Grids
```css
.outer-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
}

.inner-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
}
```

---

## Grid vs Flexbox

**Use Grid when:**
- Two-dimensional layout (rows AND columns)
- Complex layouts with multiple areas
- Layout structure defines content placement
- Overlapping elements

**Use Flexbox when:**
- One-dimensional layout (row OR column)
- Content size determines layout
- Navigation bars, toolbars
- Card layouts with wrapping

**Often used together:** Grid for page layout, Flexbox for components!

---

## Best Practices

1. **Use auto-fit + minmax for responsive grids**
2. **Use named grid areas for complex layouts**
3. **Combine Grid (layout) with Flexbox (components)**
4. **Use fr units for flexible sizing**
5. **Test with varying content amounts**

---

## Browser Support

CSS Grid is supported in all modern browsers. Use with confidence!

</details>

---

**Congratulations!** You've mastered CSS Grid - the ultimate layout system!

**Next Lesson:** Mobile-First Design Philosophy!
