# Lesson 16 Activities: Display Types

## Controlling Element Layout Behavior

Master `display` property to control how elements behave in layouts - the key to understanding CSS layout!

---

## Activity 1: Block vs Inline vs Inline-Block

**Goal:** Understand the three main display types.

**Create:** `display-comparison.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Display Types Comparison</title>
    <link rel="stylesheet" href="display-comparison.css">
</head>
<body>
    <h1>CSS Display Types</h1>
    
    <section>
        <h2>Block Elements (display: block)</h2>
        <p>Block elements take full width and start on new line.</p>
        <div class="block">Block 1</div>
        <div class="block">Block 2</div>
        <div class="block">Block 3</div>
    </section>
    
    <section>
        <h2>Inline Elements (display: inline)</h2>
        <p>Inline elements flow with text and don't accept width/height.</p>
        <span class="inline">Inline 1</span>
        <span class="inline">Inline 2</span>
        <span class="inline">Inline 3</span>
    </section>
    
    <section>
        <h2>Inline-Block Elements (display: inline-block)</h2>
        <p>Inline-block elements flow side by side but accept width/height.</p>
        <div class="inline-block">Inline-Block 1</div>
        <div class="inline-block">Inline-Block 2</div>
        <div class="inline-block">Inline-Block 3</div>
    </section>
</body>
</html>
```

**Create:** `display-comparison.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    padding: 40px;
    background-color: #f5f5f5;
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
}

h2 {
    color: #333;
    margin-bottom: 15px;
}

section > p {
    margin-bottom: 20px;
    color: #666;
}

/* Block - Takes full width, starts on new line */
.block {
    display: block;
    background-color: #2196f3;
    color: white;
    padding: 15px;
    margin-bottom: 10px;
    width: 200px;  /* Width works! */
    height: 50px;  /* Height works! */
}

/* Inline - Flows with text, no width/height */
.inline {
    display: inline;
    background-color: #4caf50;
    color: white;
    padding: 10px 15px;
    margin: 5px;  /* Only left/right work */
    width: 200px;  /* IGNORED! */
    height: 50px;  /* IGNORED! */
}

/* Inline-Block - Side by side, accepts width/height */
.inline-block {
    display: inline-block;
    background-color: #ff9800;
    color: white;
    padding: 15px;
    margin: 5px;
    width: 150px;  /* Width works! */
    height: 80px;  /* Height works! */
    vertical-align: top;
}
```

**Test:** Observe how each display type behaves differently.

---

## Activity 2: Navigation Bar with Inline-Block

**Goal:** Create a horizontal navigation menu.

**Create:** `navbar-inline-block.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Navigation</title>
    <link rel="stylesheet" href="navbar-inline-block.css">
</head>
<body>
    <header>
        <h1>Barangay San Miguel</h1>
        <nav class="nav">
            <a href="#" class="nav-link">Home</a>
            <a href="#" class="nav-link">Services</a>
            <a href="#" class="nav-link">Announcements</a>
            <a href="#" class="nav-link">Officials</a>
            <a href="#" class="nav-link">Contact</a>
        </nav>
    </header>
    
    <main>
        <h2>Welcome to Our Barangay Website</h2>
        <p>Serving the community since 1952.</p>
    </main>
</body>
</html>
```

**Create:** `navbar-inline-block.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
}

/* Header */
header {
    background-color: #1a73e8;
    color: white;
    padding: 20px;
    text-align: center;
}

header h1 {
    margin-bottom: 15px;
}

/* Navigation with inline-block */
.nav {
    background-color: rgba(255,255,255,0.1);
    padding: 10px;
    border-radius: 5px;
}

.nav-link {
    display: inline-block;  /* Side by side, accepts dimensions */
    color: white;
    text-decoration: none;
    padding: 10px 20px;
    margin: 0 5px;
    background-color: rgba(255,255,255,0.2);
    border-radius: 5px;
    transition: background-color 0.3s;
}

.nav-link:hover {
    background-color: rgba(255,255,255,0.3);
}

/* Main Content */
main {
    max-width: 800px;
    margin: 40px auto;
    padding: 0 20px;
}

main h2 {
    color: #1a73e8;
    margin-bottom: 15px;
}

main p {
    color: #666;
    line-height: 1.6;
}
```

---

## Activity 3: Service Cards Grid

**Goal:** Create a card layout using inline-block.

**Create:** `service-cards-grid.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Services</title>
    <link rel="stylesheet" href="service-cards-grid.css">
</head>
<body>
    <div class="container">
        <h1>Available Services</h1>
        
        <div class="cards-container">
            <div class="card">
                <div class="icon">📄</div>
                <h3>Barangay Clearance</h3>
                <p>Processing: 3-5 days</p>
                <p class="price">₱50.00</p>
            </div>
            
            <div class="card">
                <div class="icon">🆔</div>
                <h3>Barangay ID</h3>
                <p>Processing: Same day</p>
                <p class="price">₱30.00</p>
            </div>
            
            <div class="card">
                <div class="icon">💼</div>
                <h3>Business Permit</h3>
                <p>Processing: 5-7 days</p>
                <p class="price">₱500.00</p>
            </div>
            
            <div class="card">
                <div class="icon">📝</div>
                <h3>Residency Certificate</h3>
                <p>Processing: 1-2 days</p>
                <p class="price">₱30.00</p>
            </div>
            
            <div class="card">
                <div class="icon">💸</div>
                <h3>Indigency Certificate</h3>
                <p>Processing: 2-3 days</p>
                <p class="price">Free</p>
            </div>
            
            <div class="card">
                <div class="icon">👥</div>
                <h3>Community Tax</h3>
                <p>Processing: Same day</p>
                <p class="price">₱5.00+</p>
            </div>
        </div>
    </div>
</body>
</html>
```

**Create:** `service-cards-grid.css`

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
    font-size: 2rem;
}

/* Cards Container */
.cards-container {
    text-align: center;  /* Center inline-block elements */
    font-size: 0;        /* Remove whitespace gaps */
}

/* Card using inline-block */
.card {
    display: inline-block;
    width: 300px;
    background-color: white;
    padding: 30px;
    margin: 15px;
    border-radius: 15px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    vertical-align: top;  /* Align tops */
    text-align: center;
    font-size: 1rem;      /* Reset font-size */
    transition: transform 0.3s;
}

.card:hover {
    transform: translateY(-5px);
}

.icon {
    font-size: 64px;
    margin-bottom: 15px;
}

.card h3 {
    color: #1a73e8;
    margin-bottom: 10px;
    font-size: 1.3rem;
}

.card p {
    color: #666;
    margin-bottom: 10px;
}

.price {
    font-size: 1.5rem;
    font-weight: bold;
    color: #4caf50;
    margin-top: 15px;
}

/* Responsive */
@media (max-width: 768px) {
    .card {
        display: block;  /* Stack on mobile */
        width: 100%;
        margin: 15px 0;
    }
}
```

---

## Activity 4: Display None - Show/Hide Elements

**Goal:** Use `display: none` to hide elements.

**Create:** `display-none-demo.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Display None Demo</title>
    <link rel="stylesheet" href="display-none-demo.css">
</head>
<body>
    <div class="container">
        <h1>Show/Hide Elements</h1>
        
        <div class="controls">
            <button onclick="toggleElement('announcement1')">Toggle Announcement 1</button>
            <button onclick="toggleElement('announcement2')">Toggle Announcement 2</button>
            <button onclick="toggleElement('announcement3')">Toggle Announcement 3</button>
        </div>
        
        <div class="announcements">
            <div id="announcement1" class="announcement">
                <h3>Announcement 1</h3>
                <p>Barangay assembly on Saturday, 2:00 PM.</p>
            </div>
            
            <div id="announcement2" class="announcement">
                <h3>Announcement 2</h3>
                <p>Free medical mission on Sunday.</p>
            </div>
            
            <div id="announcement3" class="announcement hidden">
                <h3>Announcement 3 (Initially Hidden)</h3>
                <p>Community clean-up drive next week.</p>
            </div>
        </div>
    </div>
    
    <script>
        function toggleElement(id) {
            const element = document.getElementById(id);
            element.classList.toggle('hidden');
        }
    </script>
</body>
</html>
```

**Create:** `display-none-demo.css`

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
    margin-bottom: 30px;
}

.controls {
    text-align: center;
    margin-bottom: 30px;
}

.controls button {
    background-color: #1a73e8;
    color: white;
    border: none;
    padding: 10px 20px;
    margin: 5px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}

.controls button:hover {
    background-color: #1557b0;
}

.announcement {
    background-color: white;
    padding: 20px;
    margin-bottom: 15px;
    border-left: 5px solid #1a73e8;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.announcement h3 {
    color: #1a73e8;
    margin-bottom: 10px;
}

.announcement p {
    color: #666;
}

/* Hidden class - completely removes from layout */
.hidden {
    display: none;
}
```

---

## Activity 5: Responsive Display Changes

**Goal:** Change display types at different screen sizes.

**Create:** `responsive-display.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Display</title>
    <link rel="stylesheet" href="responsive-display.css">
</head>
<body>
    <header class="header">
        <div class="logo">Barangay San Miguel</div>
        <nav class="desktop-nav">
            <a href="#">Home</a>
            <a href="#">Services</a>
            <a href="#">Announcements</a>
            <a href="#">Contact</a>
        </nav>
        <button class="mobile-menu-btn">☰</button>
    </header>
    
    <main class="container">
        <div class="sidebar">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="#">Apply for Clearance</a></li>
                <li><a href="#">Check Status</a></li>
                <li><a href="#">Pay Online</a></li>
            </ul>
        </div>
        
        <div class="content">
            <h1>Welcome</h1>
            <p>Barangay San Miguel has been serving the community since 1952.</p>
        </div>
    </main>
</body>
</html>
```

**Create:** `responsive-display.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
}

/* Header */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #1a73e8;
    color: white;
    padding: 20px;
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
}

/* Desktop Navigation - visible on desktop */
.desktop-nav {
    display: flex;
    gap: 20px;
}

.desktop-nav a {
    color: white;
    text-decoration: none;
    padding: 8px 15px;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.desktop-nav a:hover {
    background-color: rgba(255,255,255,0.2);
}

/* Mobile Menu Button - hidden on desktop */
.mobile-menu-btn {
    display: none;
    background-color: transparent;
    color: white;
    border: 2px solid white;
    padding: 8px 15px;
    font-size: 1.2rem;
    border-radius: 5px;
    cursor: pointer;
}

/* Main Content */
.container {
    display: flex;
    max-width: 1200px;
    margin: 40px auto;
    gap: 30px;
    padding: 0 20px;
}

/* Sidebar - visible on desktop */
.sidebar {
    width: 250px;
    background-color: #f5f5f5;
    padding: 20px;
    border-radius: 10px;
}

.sidebar h3 {
    color: #1a73e8;
    margin-bottom: 15px;
}

.sidebar ul {
    list-style: none;
}

.sidebar li {
    margin-bottom: 10px;
}

.sidebar a {
    color: #666;
    text-decoration: none;
}

.sidebar a:hover {
    color: #1a73e8;
}

/* Content */
.content {
    flex: 1;
}

.content h1 {
    color: #1a73e8;
    margin-bottom: 15px;
}

.content p {
    color: #666;
    line-height: 1.6;
}

/* RESPONSIVE: Tablet and below (max 768px) */
@media (max-width: 768px) {
    /* Hide desktop nav */
    .desktop-nav {
        display: none;
    }
    
    /* Show mobile menu button */
    .mobile-menu-btn {
        display: block;
    }
    
    /* Stack sidebar and content */
    .container {
        flex-direction: column;
    }
    
    .sidebar {
        width: 100%;
    }
}
```

---

## Activity 6: Badge System with Inline-Block

**Goal:** Create inline badges for status indicators.

**Create:** `badge-system.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Document Status</title>
    <link rel="stylesheet" href="badge-system.css">
</head>
<body>
    <div class="container">
        <h1>Document Processing Status</h1>
        
        <div class="document-list">
            <div class="document">
                <h3>Barangay Clearance Application</h3>
                <p>Applicant: Juan dela Cruz</p>
                <p>Date: December 1, 2025</p>
                <span class="badge badge-pending">Pending</span>
            </div>
            
            <div class="document">
                <h3>Business Permit Renewal</h3>
                <p>Applicant: Maria Santos</p>
                <p>Date: November 28, 2025</p>
                <span class="badge badge-processing">Processing</span>
            </div>
            
            <div class="document">
                <h3>Residency Certificate</h3>
                <p>Applicant: Pedro Reyes</p>
                <p>Date: November 25, 2025</p>
                <span class="badge badge-approved">Approved</span>
            </div>
            
            <div class="document">
                <h3>Indigency Certificate</h3>
                <p>Applicant: Ana Garcia</p>
                <p>Date: November 20, 2025</p>
                <span class="badge badge-ready">Ready for Pickup</span>
            </div>
            
            <div class="document">
                <h3>Community Tax Certificate</h3>
                <p>Applicant: Carlos Lopez</p>
                <p>Date: October 15, 2025</p>
                <span class="badge badge-expired">Expired</span>
            </div>
        </div>
    </div>
</body>
</html>
```

**Create:** `badge-system.css`

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

.document {
    background-color: white;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.document h3 {
    color: #333;
    margin-bottom: 10px;
}

.document p {
    color: #666;
    margin-bottom: 5px;
    font-size: 14px;
}

/* Badge using inline-block */
.badge {
    display: inline-block;  /* Accepts width/height, flows inline */
    padding: 6px 14px;
    margin-top: 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.badge-pending {
    background-color: #fff3cd;
    color: #856404;
}

.badge-processing {
    background-color: #cfe2ff;
    color: #084298;
}

.badge-approved {
    background-color: #d1e7dd;
    color: #0f5132;
}

.badge-ready {
    background-color: #d1ecf1;
    color: #0c5460;
}

.badge-expired {
    background-color: #f8d7da;
    color: #842029;
}
```

---

## Activity 7: Complete Barangay Portal Layout

**Goal:** Combine all display types in a professional layout.

**Create:** `complete-portal.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay San Miguel Portal</title>
    <link rel="stylesheet" href="complete-portal.css">
</head>
<body>
    <!-- Header (block) -->
    <header class="header">
        <div class="header-content">
            <h1>Barangay San Miguel</h1>
            <p class="tagline">Serving the Community Since 1952</p>
        </div>
        
        <!-- Navigation (inline-block) -->
        <nav class="nav">
            <a href="#" class="nav-link">Home</a>
            <a href="#" class="nav-link">Services</a>
            <a href="#" class="nav-link">Announcements</a>
            <a href="#" class="nav-link">Officials</a>
            <a href="#" class="nav-link">Contact</a>
        </nav>
    </header>
    
    <!-- Main Content (block with flex) -->
    <main class="main">
        <!-- Announcements Section (block) -->
        <section class="section">
            <h2>Latest Announcements</h2>
            
            <div class="announcement">
                <span class="badge urgent">URGENT</span>
                <h3>Typhoon Warning</h3>
                <p>All classes suspended. Stay indoors and monitor weather updates.</p>
                <span class="date">December 4, 2025</span>
            </div>
            
            <div class="announcement">
                <span class="badge new">NEW</span>
                <h3>Barangay Assembly</h3>
                <p>Monthly assembly on December 10 at 2:00 PM. All residents welcome.</p>
                <span class="date">December 3, 2025</span>
            </div>
        </section>
        
        <!-- Services Grid (inline-block) -->
        <section class="section">
            <h2>Quick Services</h2>
            
            <div class="services-grid">
                <div class="service-card">
                    <div class="icon">📄</div>
                    <h4>Clearance</h4>
                    <p>₱50.00</p>
                </div>
                
                <div class="service-card">
                    <div class="icon">🆔</div>
                    <h4>Barangay ID</h4>
                    <p>₱30.00</p>
                </div>
                
                <div class="service-card">
                    <div class="icon">💼</div>
                    <h4>Business Permit</h4>
                    <p>₱500.00</p>
                </div>
                
                <div class="service-card">
                    <div class="icon">📝</div>
                    <h4>Residency</h4>
                    <p>₱30.00</p>
                </div>
            </div>
        </section>
        
        <!-- Statistics (inline-block) -->
        <section class="section">
            <h2>Barangay Statistics</h2>
            
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-number">12,543</div>
                    <div class="stat-label">Population</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">3,214</div>
                    <div class="stat-label">Households</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">856</div>
                    <div class="stat-label">Documents Processed</div>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer (block) -->
    <footer class="footer">
        <p>&copy; 2025 Barangay San Miguel. All rights reserved.</p>
    </footer>
</body>
</html>
```

**Create:** `complete-portal.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    line-height: 1.6;
}

/* HEADER - Block Element */
.header {
    display: block;
    background: linear-gradient(135deg, #1a73e8 0%, #4caf50 100%);
    color: white;
    text-align: center;
    padding: 40px 20px 20px;
}

.header-content h1 {
    font-size: 2.5rem;
    margin-bottom: 5px;
}

.tagline {
    font-size: 1.1rem;
    opacity: 0.95;
    margin-bottom: 20px;
}

/* NAVIGATION - Inline-Block Elements */
.nav {
    background-color: rgba(255,255,255,0.1);
    padding: 10px;
    border-radius: 5px;
    display: inline-block;
}

.nav-link {
    display: inline-block;  /* Side by side */
    color: white;
    text-decoration: none;
    padding: 10px 20px;
    margin: 0 3px;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.nav-link:hover {
    background-color: rgba(255,255,255,0.2);
}

/* MAIN - Block Container */
.main {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
}

/* SECTION - Block Elements */
.section {
    display: block;
    background-color: white;
    padding: 30px;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.section h2 {
    color: #1a73e8;
    margin-bottom: 25px;
    font-size: 1.8rem;
}

/* ANNOUNCEMENTS - Block Elements */
.announcement {
    display: block;
    padding: 20px;
    margin-bottom: 20px;
    background-color: #f9f9f9;
    border-left: 5px solid #2196f3;
    border-radius: 5px;
}

.announcement:last-child {
    margin-bottom: 0;
}

.announcement h3 {
    color: #333;
    margin-bottom: 10px;
}

.announcement p {
    color: #666;
    margin-bottom: 10px;
}

/* BADGES - Inline-Block Elements */
.badge {
    display: inline-block;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: bold;
    text-transform: uppercase;
    margin-bottom: 10px;
}

.badge.urgent {
    background-color: #f44336;
    color: white;
}

.badge.new {
    background-color: #4caf50;
    color: white;
}

/* DATE - Inline Element */
.date {
    display: inline;
    font-size: 13px;
    color: #999;
    font-style: italic;
}

/* SERVICES GRID - Inline-Block Elements */
.services-grid {
    text-align: center;
    font-size: 0;  /* Remove gaps */
}

.service-card {
    display: inline-block;
    width: 200px;
    padding: 30px 20px;
    margin: 10px;
    background: linear-gradient(to bottom, #f9f9f9, white);
    border: 2px solid #e0e0e0;
    border-radius: 15px;
    text-align: center;
    vertical-align: top;
    font-size: 1rem;
    transition: transform 0.3s;
}

.service-card:hover {
    transform: translateY(-5px);
}

.icon {
    font-size: 48px;
    margin-bottom: 10px;
}

.service-card h4 {
    color: #1a73e8;
    margin-bottom: 8px;
}

.service-card p {
    color: #4caf50;
    font-weight: bold;
    font-size: 1.2rem;
}

/* STATISTICS - Inline-Block Elements */
.stats {
    text-align: center;
    font-size: 0;
}

.stat-card {
    display: inline-block;
    width: 250px;
    padding: 30px;
    margin: 10px;
    background-color: #1a73e8;
    color: white;
    border-radius: 15px;
    text-align: center;
    vertical-align: top;
    font-size: 1rem;
}

.stat-number {
    font-size: 3rem;
    font-weight: bold;
    margin-bottom: 10px;
}

.stat-label {
    font-size: 1rem;
    opacity: 0.9;
}

/* FOOTER - Block Element */
.footer {
    display: block;
    background-color: #333;
    color: white;
    text-align: center;
    padding: 30px 20px;
    margin-top: 40px;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    /* Stack navigation */
    .nav-link {
        display: block;
        margin: 5px 0;
    }
    
    /* Full width cards */
    .service-card,
    .stat-card {
        display: block;
        width: 100%;
        margin: 10px 0;
    }
    
    .header-content h1 {
        font-size: 1.8rem;
    }
}
```

**Features demonstrated:**
✅ Block elements for main structure  
✅ Inline-block for navigation, cards, statistics  
✅ Inline for badges and dates  
✅ Responsive display changes  
✅ Professional spacing and hover effects

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Display Property Complete Reference

### Display: Block

**Characteristics:**
- Takes up full width available
- Starts on a new line
- Accepts width and height
- Accepts all margins and padding

**Default block elements:**
`<div>`, `<p>`, `<h1>`-`<h6>`, `<header>`, `<footer>`, `<section>`, `<article>`, `<ul>`, `<ol>`, `<li>`, `<form>`

**CSS:**
```css
.element {
    display: block;
    width: 300px;      /* Works */
    height: 100px;     /* Works */
    margin: 20px;      /* All sides work */
    padding: 20px;     /* All sides work */
}
```

**When to use:**
- Main containers (header, main, footer)
- Sections and articles
- Full-width elements

---

### Display: Inline

**Characteristics:**
- Flows with text (no line break)
- Takes only needed width
- **Cannot set width/height**
- Only left/right margins work
- Padding works but may overlap

**Default inline elements:**
`<span>`, `<a>`, `<strong>`, `<em>`, `<code>`, `<label>`

**CSS:**
```css
.element {
    display: inline;
    width: 200px;      /* IGNORED */
    height: 50px;      /* IGNORED */
    margin: 20px 10px; /* Only left/right (10px) work */
    padding: 10px;     /* Works but may overlap */
}
```

**When to use:**
- Text styling (strong, em)
- Links within paragraphs
- Small inline decorations

---

### Display: Inline-Block

**Characteristics:**
- Flows inline (side by side)
- **Accepts width and height**
- Accepts all margins and padding
- Best of both worlds!

**CSS:**
```css
.element {
    display: inline-block;
    width: 200px;      /* Works! */
    height: 100px;     /* Works! */
    margin: 20px;      /* All sides work! */
    padding: 20px;     /* All sides work! */
    vertical-align: top; /* Control alignment */
}
```

**When to use:**
- Navigation menus (horizontal)
- Card layouts
- Button groups
- Image galleries
- Any elements that need to be side by side with dimensions

---

### Display: None

**Characteristics:**
- Completely hidden
- Takes up no space
- Removed from layout flow

**CSS:**
```css
.hidden {
    display: none;
}
```

**Different from visibility: hidden:**
```css
/* Still takes up space, just invisible */
.invisible {
    visibility: hidden;
}

/* Completely removed, no space */
.hidden {
    display: none;
}
```

**When to use:**
- Hide mobile/desktop specific elements
- Toggle visibility with JavaScript
- Conditional content

---

## Comparison Table

| Feature | block | inline | inline-block |
|---------|-------|--------|--------------|
| **New line?** | Yes | No | No |
| **Width/Height?** | Yes | **No** | Yes |
| **Top/Bottom margin?** | Yes | **No** | Yes |
| **Left/Right margin?** | Yes | Yes | Yes |
| **Padding?** | Yes (all) | Yes (may overlap) | Yes (all) |
| **Use case** | Containers | Text styling | Navigation, cards |

---

## Common Patterns

### Horizontal Navigation
```css
nav a {
    display: inline-block;
    padding: 10px 20px;
    margin: 0 5px;
}
```

### Card Grid
```css
.container {
    text-align: center;
    font-size: 0;  /* Remove gaps */
}

.card {
    display: inline-block;
    width: 300px;
    margin: 15px;
    vertical-align: top;
    font-size: 1rem;
}
```

### Responsive Display
```css
/* Desktop: side by side */
.nav-link {
    display: inline-block;
}

/* Mobile: stacked */
@media (max-width: 768px) {
    .nav-link {
        display: block;
    }
}
```

---

## Fixing Inline-Block Gaps

Inline-block elements have whitespace gaps from HTML:

**Problem:**
```html
<div class="card">Card 1</div>
<div class="card">Card 2</div>
<!-- Whitespace creates gap -->
```

**Solution 1: Font-size 0**
```css
.container {
    font-size: 0;
}
.card {
    font-size: 1rem;
}
```

**Solution 2: Use Flexbox (better)**
```css
.container {
    display: flex;
    gap: 20px;
}
```

---

## Vertical Alignment

With inline-block, use `vertical-align`:

```css
.card {
    display: inline-block;
    vertical-align: top;  /* Align tops */
}
```

**Options:**
- `top` - Align element tops
- `middle` - Align middles
- `bottom` - Align bottoms
- `baseline` - Align text baselines (default)

---

## Best Practices

1. **Use block for main structure**
2. **Use inline for text styling**
3. **Use inline-block for horizontal layouts**
4. **Consider Flexbox/Grid for modern layouts**
5. **Test responsive display changes**

</details>

---

**Congratulations!** You've mastered CSS display types! You now understand how to control whether elements stack vertically (block), flow inline (inline), or combine both behaviors (inline-block).

**Next Lesson:** CSS Positioning - Absolute control over element placement!

