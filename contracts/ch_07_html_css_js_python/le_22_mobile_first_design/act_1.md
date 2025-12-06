# Lesson 22 Activities: Mobile-First Design

## Building for Mobile, Enhancing for Desktop

Start with mobile, progressively enhance for larger screens - the modern way to build responsive websites!

---

## Activity 1: Understanding Mobile-First Philosophy

**Goal:** See the difference between mobile-first and desktop-first approaches.

**Create:** `mobile-first-demo.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile-First Approach</title>
    <link rel="stylesheet" href="mobile-first-demo.css">
</head>
<body>
    <div class="container">
        <h1>Mobile-First Design</h1>
        
        <section class="explanation">
            <h2>What is Mobile-First?</h2>
            <p><strong>Mobile-First:</strong> Start with mobile styles, add complexity for larger screens using min-width media queries.</p>
            <p><strong>Desktop-First:</strong> Start with desktop styles, remove complexity for smaller screens using max-width media queries.</p>
        </section>
        
        <section class="comparison">
            <div class="approach">
                <h3>❌ Desktop-First (Old Way)</h3>
                <pre><code>.container {
    width: 1200px;
    columns: 3;
}

@media (max-width: 768px) {
    .container {
        width: 100%;
        columns: 1;
    }
}</code></pre>
                <p>Starts complex, removes features</p>
            </div>
            
            <div class="approach">
                <h3>✅ Mobile-First (Modern Way)</h3>
                <pre><code>.container {
    width: 100%;
    columns: 1;
}

@media (min-width: 768px) {
    .container {
        width: 1200px;
        columns: 3;
    }
}</code></pre>
                <p>Starts simple, adds features</p>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `mobile-first-demo.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 20px;
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

.explanation {
    background-color: white;
    padding: 30px;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.explanation h2 {
    color: #333;
    margin-bottom: 20px;
}

.explanation p {
    color: #666;
    line-height: 1.8;
    margin-bottom: 15px;
}

/* MOBILE-FIRST: Start with mobile styles */
.comparison {
    display: block;  /* Mobile: stack vertically */
}

.approach {
    background-color: white;
    padding: 25px;
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.approach h3 {
    margin-bottom: 20px;
}

.approach pre {
    background-color: #f5f5f5;
    padding: 20px;
    border-radius: 5px;
    overflow-x: auto;
    margin-bottom: 15px;
}

.approach code {
    font-family: 'Courier New', monospace;
    font-size: 14px;
    line-height: 1.6;
}

.approach p {
    color: #666;
    font-style: italic;
}

/* TABLET: min-width 768px */
@media (min-width: 768px) {
    .comparison {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }
    
    .approach {
        margin-bottom: 0;
    }
}
```

**Key principle:** Start simple (mobile), enhance progressively (tablet, desktop).

---

## Activity 2: Touch-Friendly Targets

**Goal:** Create touch-friendly interactive elements.

**Create:** `touch-targets.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Touch-Friendly Design</title>
    <link rel="stylesheet" href="touch-targets.css">
</head>
<body>
    <div class="container">
        <h1>Touch Target Guidelines</h1>
        
        <section class="guideline">
            <h2>Minimum Touch Target: 44×44px</h2>
            <p>Apple and Android guidelines recommend minimum 44×44px for touch targets.</p>
        </section>
        
        <section class="demo">
            <h3>❌ Too Small (Hard to Tap)</h3>
            <div class="buttons-small">
                <button class="btn-small">Edit</button>
                <button class="btn-small">Delete</button>
                <button class="btn-small">Share</button>
            </div>
        </section>
        
        <section class="demo">
            <h3>✅ Good Size (Easy to Tap)</h3>
            <div class="buttons-good">
                <button class="btn-good">Edit</button>
                <button class="btn-good">Delete</button>
                <button class="btn-good">Share</button>
            </div>
        </section>
        
        <section class="demo">
            <h3>✅ Mobile Navigation (Touch-Friendly)</h3>
            <nav class="mobile-nav">
                <a href="#home">Home</a>
                <a href="#services">Services</a>
                <a href="#about">About</a>
                <a href="#contact">Contact</a>
            </nav>
        </section>
    </div>
</body>
</html>
```

**Create:** `touch-targets.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 20px;
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

.guideline {
    background-color: #e3f2fd;
    border-left: 5px solid #1a73e8;
    padding: 20px;
    margin-bottom: 30px;
    border-radius: 5px;
}

.guideline h2 {
    color: #1a73e8;
    margin-bottom: 10px;
}

.guideline p {
    color: #1565c0;
    line-height: 1.6;
}

.demo {
    background-color: white;
    padding: 25px;
    margin-bottom: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.demo h3 {
    margin-bottom: 20px;
}

/* ❌ TOO SMALL */
.buttons-small {
    display: flex;
    gap: 5px;
}

.btn-small {
    padding: 5px 10px;
    font-size: 12px;
    background-color: #2196f3;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}

/* ✅ GOOD SIZE - At least 44x44px */
.buttons-good {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.btn-good {
    min-width: 100px;
    min-height: 44px;  /* Minimum touch target */
    padding: 12px 24px;
    font-size: 16px;
    background-color: #1a73e8;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.3s;
}

.btn-good:hover,
.btn-good:active {
    background-color: #1557b0;
}

/* ✅ MOBILE NAVIGATION */
.mobile-nav {
    display: flex;
    flex-direction: column;
    gap: 2px;
}

.mobile-nav a {
    display: block;
    min-height: 48px;  /* Touch-friendly */
    padding: 14px 20px;
    background-color: #1a73e8;
    color: white;
    text-decoration: none;
    text-align: center;
    font-weight: bold;
    transition: background-color 0.3s;
}

.mobile-nav a:hover,
.mobile-nav a:active {
    background-color: #1557b0;
}

/* TABLET & DESKTOP: Horizontal navigation */
@media (min-width: 768px) {
    .mobile-nav {
        flex-direction: row;
    }
    
    .mobile-nav a {
        flex: 1;
    }
}
```

**Rule:** All tappable elements should be at least 44×44px!

---

## Activity 3: Mobile-First Typography

**Goal:** Scale typography from mobile to desktop.

**Create:** `mobile-first-typography.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile-First Typography</title>
    <link rel="stylesheet" href="mobile-first-typography.css">
</head>
<body>
    <article class="article">
        <h1>Barangay San Miguel Christmas Program 2025</h1>
        
        <p class="lead">Join us for our annual Christmas celebration featuring games, raffle prizes, and special performances!</p>
        
        <h2>Event Details</h2>
        <p>The Barangay San Miguel Christmas Program has been a beloved tradition for over 20 years. This year's celebration promises to be bigger and better than ever before.</p>
        
        <h3>What to Expect</h3>
        <ul>
            <li>Live music and dance performances</li>
            <li>Games for all ages</li>
            <li>Raffle draw with amazing prizes</li>
            <li>Free snacks and refreshments</li>
            <li>Special gifts for senior citizens and children</li>
        </ul>
        
        <h3>Schedule</h3>
        <p><strong>Date:</strong> December 20, 2025</p>
        <p><strong>Time:</strong> 3:00 PM - 8:00 PM</p>
        <p><strong>Venue:</strong> Barangay Covered Court</p>
        
        <h2>How to Join</h2>
        <p>All residents are welcome! Simply bring your Barangay ID or proof of residency. Registration starts at 2:00 PM.</p>
        
        <div class="cta">
            <button>Register Now</button>
        </div>
    </article>
</body>
</html>
```

**Create:** `mobile-first-typography.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* MOBILE FIRST: Base font size */
html {
    font-size: 16px;  /* Base for rem units */
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    background-color: #f5f5f5;
    padding: 20px;
}

.article {
    max-width: 800px;
    margin: 0 auto;
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

/* MOBILE: Smaller text */
.article h1 {
    font-size: 1.8rem;     /* 28.8px */
    color: #1a73e8;
    margin-bottom: 20px;
    line-height: 1.2;
}

.article h2 {
    font-size: 1.4rem;     /* 22.4px */
    color: #333;
    margin-top: 30px;
    margin-bottom: 15px;
}

.article h3 {
    font-size: 1.2rem;     /* 19.2px */
    color: #333;
    margin-top: 25px;
    margin-bottom: 10px;
}

.lead {
    font-size: 1.1rem;     /* 17.6px */
    color: #666;
    margin-bottom: 30px;
    font-weight: 500;
}

.article p {
    font-size: 1rem;       /* 16px */
    color: #666;
    margin-bottom: 15px;
}

.article ul {
    margin-left: 20px;
    margin-bottom: 20px;
}

.article li {
    color: #666;
    margin-bottom: 8px;
}

.cta {
    text-align: center;
    margin-top: 40px;
}

.cta button {
    min-width: 200px;
    min-height: 48px;
    padding: 14px 30px;
    font-size: 1rem;
    background-color: #1a73e8;
    color: white;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
}

/* TABLET: Increase text size */
@media (min-width: 768px) {
    html {
        font-size: 18px;  /* Larger base */
    }
    
    .article {
        padding: 40px;
    }
    
    .article h1 {
        font-size: 2.5rem;  /* Scales with base */
    }
    
    .article h2 {
        font-size: 1.8rem;
    }
    
    .article h3 {
        font-size: 1.4rem;
    }
}

/* DESKTOP: Further increase */
@media (min-width: 1024px) {
    html {
        font-size: 20px;
    }
    
    .article {
        padding: 60px;
    }
    
    .article h1 {
        font-size: 3rem;
    }
}
```

**Technique:** Change base `font-size` on html, all rem values scale automatically!

---

## Activity 4: Progressive Enhancement - Navigation

**Goal:** Simple mobile menu, enhanced desktop navigation.

**Create:** `progressive-nav.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Progressive Navigation</title>
    <link rel="stylesheet" href="progressive-nav.css">
</head>
<body>
    <header class="header">
        <div class="logo">🏛️ Barangay San Miguel</div>
        
        <button class="menu-toggle" id="menuToggle">☰ Menu</button>
        
        <nav class="nav" id="nav">
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#announcements">Announcements</a>
            <a href="#officials">Officials</a>
            <a href="#contact">Contact</a>
        </nav>
    </header>
    
    <main class="content">
        <h1>Progressive Enhancement</h1>
        <p>The navigation starts as a simple vertical menu on mobile, then enhances to a horizontal bar on desktop.</p>
    </main>
    
    <script>
        const menuToggle = document.getElementById('menuToggle');
        const nav = document.getElementById('nav');
        
        menuToggle.addEventListener('click', () => {
            nav.classList.toggle('active');
        });
    </script>
</body>
</html>
```

**Create:** `progressive-nav.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
}

/* MOBILE FIRST: Simple stacked navigation */
.header {
    background-color: #1a73e8;
    color: white;
    padding: 15px 20px;
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
    margin-bottom: 15px;
}

.menu-toggle {
    display: block;
    width: 100%;
    min-height: 48px;
    padding: 12px;
    background-color: rgba(255,255,255,0.2);
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
    margin-bottom: 15px;
}

.menu-toggle:hover {
    background-color: rgba(255,255,255,0.3);
}

/* Mobile nav: hidden by default, shown when .active */
.nav {
    display: none;
    flex-direction: column;
    gap: 2px;
}

.nav.active {
    display: flex;
}

.nav a {
    display: block;
    min-height: 48px;
    padding: 14px 20px;
    background-color: rgba(255,255,255,0.1);
    color: white;
    text-decoration: none;
    transition: background-color 0.3s;
}

.nav a:hover {
    background-color: rgba(255,255,255,0.2);
}

.content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
}

.content h1 {
    color: #1a73e8;
    margin-bottom: 20px;
}

.content p {
    color: #666;
    line-height: 1.6;
}

/* TABLET: Horizontal navigation, hide toggle */
@media (min-width: 768px) {
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px 40px;
    }
    
    .logo {
        margin-bottom: 0;
    }
    
    .menu-toggle {
        display: none;  /* Hide menu button on desktop */
    }
    
    .nav {
        display: flex;  /* Always visible on desktop */
        flex-direction: row;
        gap: 5px;
    }
    
    .nav a {
        min-height: auto;
        padding: 10px 20px;
        border-radius: 5px;
    }
}

/* DESKTOP: More spacing */
@media (min-width: 1024px) {
    .nav {
        gap: 10px;
    }
    
    .nav a {
        padding: 12px 24px;
    }
}
```

**Progressive enhancement:** Mobile gets simple menu, desktop gets enhanced horizontal bar!

---

## Activity 5: Content-First Approach

**Goal:** Prioritize content on mobile, add extras on desktop.

**Create:** `content-first.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Content-First Design</title>
    <link rel="stylesheet" href="content-first.css">
</head>
<body>
    <div class="page">
        <header class="header">
            <h1>Barangay Services</h1>
        </header>
        
        <main class="main">
            <article class="service">
                <h2>Barangay Clearance</h2>
                <p class="price">₱50.00</p>
                <p>Required for employment, business, and travel purposes. Processing takes 1-2 business days.</p>
                <button>Apply Now</button>
            </article>
            
            <article class="service">
                <h2>Barangay ID</h2>
                <p class="price">₱30.00</p>
                <p>Official identification for all registered residents. Valid for one year.</p>
                <button>Apply Now</button>
            </article>
            
            <article class="service">
                <h2>Business Permit</h2>
                <p class="price">₱500.00</p>
                <p>Required for all business operations within the barangay. Renewed annually.</p>
                <button>Apply Now</button>
            </article>
        </main>
        
        <aside class="sidebar">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="#requirements">Requirements</a></li>
                <li><a href="#forms">Download Forms</a></li>
                <li><a href="#status">Check Status</a></li>
                <li><a href="#hours">Office Hours</a></li>
            </ul>
            
            <div class="contact">
                <h3>Contact Us</h3>
                <p>📞 043-123-4567</p>
                <p>📧 info@brgy.gov.ph</p>
            </div>
        </aside>
    </div>
</body>
</html>
```

**Create:** `content-first.css`

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

/* MOBILE FIRST: Content-only, no sidebar */
.page {
    max-width: 1400px;
    margin: 0 auto;
}

.header {
    background-color: #1a73e8;
    color: white;
    padding: 30px 20px;
    text-align: center;
}

.header h1 {
    font-size: 2rem;
}

.main {
    padding: 20px;
}

.service {
    background-color: white;
    padding: 25px;
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.service h2 {
    color: #1a73e8;
    margin-bottom: 10px;
}

.price {
    color: #4caf50;
    font-size: 1.8rem;
    font-weight: bold;
    margin-bottom: 15px;
}

.service p {
    color: #666;
    line-height: 1.6;
    margin-bottom: 20px;
}

.service button {
    width: 100%;
    min-height: 48px;
    padding: 14px;
    background-color: #1a73e8;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
}

/* Sidebar: Hidden on mobile */
.sidebar {
    display: none;
}

/* TABLET: Show sidebar, grid layout */
@media (min-width: 768px) {
    .page {
        display: grid;
        grid-template-columns: 1fr 300px;
        grid-template-rows: auto 1fr;
        grid-template-areas:
            "header  header"
            "main    sidebar";
        gap: 20px;
        padding: 20px;
    }
    
    .header {
        grid-area: header;
        border-radius: 10px;
    }
    
    .main {
        grid-area: main;
        padding: 0;
    }
    
    .sidebar {
        grid-area: sidebar;
        display: block;  /* Show on tablet+ */
    }
    
    .sidebar h3 {
        background-color: #1a73e8;
        color: white;
        padding: 15px 20px;
        border-radius: 10px 10px 0 0;
    }
    
    .sidebar ul {
        background-color: white;
        list-style: none;
        padding: 20px;
        border-radius: 0 0 10px 10px;
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    
    .sidebar li {
        margin-bottom: 12px;
    }
    
    .sidebar a {
        color: #1a73e8;
        text-decoration: none;
    }
    
    .sidebar a:hover {
        text-decoration: underline;
    }
    
    .contact {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    
    .contact h3 {
        background-color: transparent;
        color: #1a73e8;
        padding: 0;
        margin-bottom: 15px;
    }
    
    .contact p {
        color: #666;
        margin-bottom: 8px;
    }
}

/* DESKTOP: Wider sidebar */
@media (min-width: 1024px) {
    .page {
        grid-template-columns: 1fr 350px;
    }
}
```

**Content-first:** Mobile shows only essential content, desktop adds sidebar!

---

## Activity 6: Performance Optimization

**Goal:** Optimize images and resources for mobile.

**Create:** `performance-optimization.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Performance</title>
    <link rel="stylesheet" href="performance-optimization.css">
</head>
<body>
    <div class="container">
        <h1>Performance Best Practices</h1>
        
        <section class="practice">
            <h2>1. Responsive Images</h2>
            <p>Use srcset to serve appropriately sized images:</p>
            <div class="code-example">
                <code>&lt;img src="small.jpg"<br>
     srcset="small.jpg 480w,<br>
             medium.jpg 768w,<br>
             large.jpg 1200w"<br>
     sizes="(max-width: 768px) 100vw, 50vw"&gt;</code>
            </div>
        </section>
        
        <section class="practice">
            <h2>2. Lazy Loading</h2>
            <p>Load images only when needed:</p>
            <div class="code-example">
                <code>&lt;img src="image.jpg" loading="lazy"&gt;</code>
            </div>
        </section>
        
        <section class="practice">
            <h2>3. Minimize CSS/JS</h2>
            <ul>
                <li>✅ Minify CSS and JavaScript files</li>
                <li>✅ Remove unused code</li>
                <li>✅ Load critical CSS inline</li>
                <li>✅ Defer non-critical scripts</li>
            </ul>
        </section>
        
        <section class="practice">
            <h2>4. Optimize Fonts</h2>
            <ul>
                <li>✅ Limit font families (max 2-3)</li>
                <li>✅ Use font-display: swap</li>
                <li>✅ Subset fonts (only needed characters)</li>
            </ul>
        </section>
        
        <section class="practice">
            <h2>5. Reduce HTTP Requests</h2>
            <ul>
                <li>✅ Combine CSS files</li>
                <li>✅ Combine JavaScript files</li>
                <li>✅ Use CSS sprites for icons</li>
                <li>✅ Inline small images as Data URLs</li>
            </ul>
        </section>
        
        <section class="checklist">
            <h2>Mobile Performance Checklist</h2>
            <div class="checklist-items">
                <label><input type="checkbox"> Optimized images (WebP format)</label>
                <label><input type="checkbox"> Lazy loading enabled</label>
                <label><input type="checkbox"> Minified CSS and JS</label>
                <label><input type="checkbox"> Critical CSS inlined</label>
                <label><input type="checkbox"> Fonts optimized</label>
                <label><input type="checkbox"> HTTP requests minimized</label>
                <label><input type="checkbox"> Gzip compression enabled</label>
                <label><input type="checkbox"> Browser caching configured</label>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `performance-optimization.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 20px;
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

.practice {
    background-color: white;
    padding: 30px;
    margin-bottom: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.practice h2 {
    color: #1a73e8;
    margin-bottom: 15px;
}

.practice p {
    color: #666;
    margin-bottom: 15px;
    line-height: 1.6;
}

.code-example {
    background-color: #f5f5f5;
    padding: 20px;
    border-radius: 5px;
    border-left: 4px solid #1a73e8;
    overflow-x: auto;
}

.code-example code {
    font-family: 'Courier New', monospace;
    font-size: 14px;
    color: #333;
    line-height: 1.8;
}

.practice ul {
    margin-left: 20px;
}

.practice li {
    color: #666;
    margin-bottom: 10px;
    line-height: 1.6;
}

.checklist {
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.checklist h2 {
    color: #1a73e8;
    margin-bottom: 20px;
}

.checklist-items {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.checklist-items label {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px;
    background-color: #f9f9f9;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.checklist-items label:hover {
    background-color: #e3f2fd;
}

.checklist-items input[type="checkbox"] {
    width: 20px;
    height: 20px;
    cursor: pointer;
}

/* TABLET & DESKTOP: Two-column checklist */
@media (min-width: 768px) {
    .checklist-items {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
    }
}
```

**Performance matters:** Faster mobile sites = better user experience!

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Mobile-First Design Complete Reference

### What is Mobile-First?

**Definition:** Design and develop for mobile devices first, then progressively enhance for larger screens.

**Benefits:**
- ✅ Forces focus on essential content
- ✅ Better performance (lighter initial load)
- ✅ Easier to enhance than to simplify
- ✅ Matches actual usage patterns (mobile-first world)

---

### Mobile-First vs Desktop-First

**Desktop-First (Old Way):**
```css
/* Start with desktop */
.container {
    width: 1200px;
    display: grid;
    grid-template-columns: repeat(4, 1fr);
}

/* Remove features for mobile */
@media (max-width: 768px) {
    .container {
        width: 100%;
        grid-template-columns: 1fr;
    }
}
```

**Mobile-First (Modern Way):**
```css
/* Start with mobile */
.container {
    width: 100%;
    display: grid;
    grid-template-columns: 1fr;
}

/* Add features for larger screens */
@media (min-width: 768px) {
    .container {
        width: 1200px;
        grid-template-columns: repeat(4, 1fr);
    }
}
```

---

### Standard Breakpoints

```css
/* Mobile: 320px - 767px (base styles, no media query) */

/* Tablet: 768px and up */
@media (min-width: 768px) {
    /* Tablet enhancements */
}

/* Desktop: 1024px and up */
@media (min-width: 1024px) {
    /* Desktop enhancements */
}

/* Large Desktop: 1440px and up */
@media (min-width: 1440px) {
    /* Large screen enhancements */
}
```

---

### Touch Target Guidelines

**Minimum size: 44×44px** (Apple & Android guidelines)

```css
button, a, input {
    min-width: 44px;
    min-height: 44px;
    padding: 12px 20px;
}
```

**Spacing between targets:**
```css
.buttons {
    display: flex;
    gap: 10px;  /* Minimum 8-10px spacing */
}
```

---

### Mobile-First Typography

**Scale with rem and responsive font-size:**

```css
/* Mobile */
html {
    font-size: 16px;
}

h1 { font-size: 2rem; }      /* 32px */
h2 { font-size: 1.5rem; }    /* 24px */
p { font-size: 1rem; }       /* 16px */

/* Tablet */
@media (min-width: 768px) {
    html {
        font-size: 18px;  /* All rem values scale! */
    }
}

/* Desktop */
@media (min-width: 1024px) {
    html {
        font-size: 20px;
    }
}
```

**Fluid typography with clamp:**
```css
h1 {
    font-size: clamp(1.8rem, 5vw, 3rem);
    /* Min: 1.8rem, Preferred: 5vw, Max: 3rem */
}
```

---

### Progressive Enhancement

**Core principle:** Start with basic functionality, add enhancements.

**Example - Navigation:**
```css
/* Mobile: Simple vertical menu */
.nav {
    display: flex;
    flex-direction: column;
}

/* Desktop: Enhanced horizontal menu */
@media (min-width: 768px) {
    .nav {
        flex-direction: row;
        justify-content: space-between;
    }
}
```

---

### Content Priority

**Mobile-First Content Strategy:**

1. **Essential content only** on mobile
2. **Add supporting content** on tablet
3. **Full experience** on desktop

```css
/* Hide non-essential on mobile */
.sidebar,
.ads,
.extra-info {
    display: none;
}

/* Show on larger screens */
@media (min-width: 768px) {
    .sidebar {
        display: block;
    }
}
```

---

### Performance Optimization

**1. Responsive Images:**
```html
<img src="small.jpg"
     srcset="small.jpg 480w,
             medium.jpg 768w,
             large.jpg 1200w"
     sizes="(max-width: 768px) 100vw, 50vw"
     alt="Description">
```

**2. Lazy Loading:**
```html
<img src="image.jpg" loading="lazy" alt="Description">
```

**3. Modern Image Formats:**
```html
<picture>
    <source srcset="image.webp" type="image/webp">
    <img src="image.jpg" alt="Description">
</picture>
```

**4. Critical CSS:**
```html
<style>
    /* Inline critical CSS for above-the-fold content */
</style>
<link rel="stylesheet" href="rest.css">
```

**5. Defer JavaScript:**
```html
<script src="app.js" defer></script>
```

---

### Mobile Performance Checklist

- ✅ **Images optimized** (WebP, properly sized)
- ✅ **Lazy loading** enabled
- ✅ **CSS/JS minified** and combined
- ✅ **Critical CSS** inlined
- ✅ **Fonts optimized** (2-3 max, font-display: swap)
- ✅ **HTTP requests** minimized
- ✅ **Gzip compression** enabled
- ✅ **Browser caching** configured
- ✅ **Touch targets** 44×44px minimum
- ✅ **Viewport meta tag** present

---

### Viewport Meta Tag

**CRITICAL - Always include:**
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

Without this, mobile browsers render at desktop width!

---

### Mobile Testing

**Test on:**
1. Chrome DevTools (Device Mode)
2. Real mobile devices
3. Various screen sizes (320px, 375px, 414px, 768px, 1024px)
4. Different orientations (portrait, landscape)

**Test for:**
- Touch target sizes
- Text readability
- Image loading
- Navigation usability
- Form input ease

---

### Best Practices Summary

1. **Start with mobile styles** (no media query)
2. **Use min-width media queries** for enhancements
3. **Touch targets minimum 44×44px**
4. **Optimize images** for mobile bandwidth
5. **Prioritize content** (essential first)
6. **Test on real devices**
7. **Measure performance** (Lighthouse, PageSpeed)
8. **Progressive enhancement** over graceful degradation

</details>

---

**Congratulations!** You've learned mobile-first design principles!

**Next Lesson:** JavaScript Variables and Data Types - Let's add interactivity!
