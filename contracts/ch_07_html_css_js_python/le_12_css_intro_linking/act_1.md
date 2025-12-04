# Lesson 12 Activities: CSS Introduction and Linking

## Styling Your Webpages

Learn how to add CSS (Cascading Style Sheets) to transform plain HTML into beautiful, styled webpages!

---

## Activity 1: Inline CSS

**Goal:** Apply CSS directly to HTML elements.

**Create:** `inline-css.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Inline CSS</title>
</head>
<body>
    <h1 style="color: blue; font-size: 36px; text-align: center;">
        Barangay Sto. Niño
    </h1>
    
    <p style="color: #333; font-size: 16px; line-height: 1.6;">
        Welcome to our official website.
    </p>
    
    <div style="background-color: #4CAF50; color: white; padding: 20px; margin: 10px 0;">
        <h2 style="margin: 0;">Office Hours</h2>
        <p style="margin: 5px 0;">Monday - Friday: 8:00 AM - 5:00 PM</p>
    </div>
    
    <button style="background-color: #008CBA; color: white; padding: 10px 20px; border: none; cursor: pointer; font-size: 16px;">
        Apply Now
    </button>
</body>
</html>
```

**Pros:**
- Quick testing
- Highest specificity

**Cons:**
- Hard to maintain
- Mixes content with presentation
- Can't reuse styles
- **Not recommended for production!**

---

## Activity 2: Internal CSS

**Goal:** Use `<style>` tag in HTML head.

**Create:** `internal-css.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Internal CSS</title>
    <style>
        /* CSS goes here inside <style> tag */
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        
        h1 {
            color: #4CAF50;
            text-align: center;
            font-size: 36px;
            margin-bottom: 10px;
        }
        
        p {
            color: #333;
            font-size: 16px;
        }
        
        .box {
            background-color: white;
            padding: 20px;
            margin: 20px 0;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .button {
            background-color: #008CBA;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        
        .button:hover {
            background-color: #007B9A;
        }
    </style>
</head>
<body>
    <h1>Barangay Sto. Niño</h1>
    <p>Welcome to our official website.</p>
    
    <div class="box">
        <h2>Office Hours</h2>
        <p>Monday - Friday: 8:00 AM - 5:00 PM</p>
        <p>Saturday: 8:00 AM - 12:00 PM</p>
    </div>
    
    <a href="apply.html" class="button">Apply Now</a>
</body>
</html>
```

**Pros:**
- Styles organized in one place
- Reusable within single page
- Good for page-specific styles

**Cons:**
- Can't share styles across pages
- Page becomes larger
- Still mixes content/presentation

---

## Activity 3: External CSS

**Goal:** Link external CSS file (best practice).

**Create:** `external-css.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>External CSS</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Barangay Sto. Niño</h1>
        <nav>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="services.html">Services</a></li>
                <li><a href="contact.html">Contact</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <section class="hero">
            <h2>Serving the Community Since 1952</h2>
            <p>Transparent, efficient, and responsive governance.</p>
            <a href="services.html" class="button">View Services</a>
        </section>
        
        <section class="services">
            <h2>Quick Access</h2>
            <div class="service-grid">
                <div class="service-card">
                    <h3>Barangay Clearance</h3>
                    <p>Apply for clearance online or in-person.</p>
                </div>
                <div class="service-card">
                    <h3>Barangay ID</h3>
                    <p>Get your official barangay identification.</p>
                </div>
                <div class="service-card">
                    <h3>Business Permit</h3>
                    <p>Register your business with us.</p>
                </div>
            </div>
        </section>
    </main>
    
    <footer>
        <p>&copy; 2025 Barangay Sto. Niño. All rights reserved.</p>
    </footer>
</body>
</html>
```

**Create:** `style.css` (in same folder)

```css
/* Global Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
}

/* Header */
header {
    background-color: #4CAF50;
    color: white;
    padding: 20px;
    text-align: center;
}

header h1 {
    font-size: 32px;
    margin-bottom: 10px;
}

/* Navigation */
nav ul {
    list-style: none;
    display: flex;
    justify-content: center;
    gap: 20px;
}

nav a {
    color: white;
    text-decoration: none;
    padding: 5px 10px;
    border-radius: 3px;
    transition: background-color 0.3s;
}

nav a:hover {
    background-color: rgba(255, 255, 255, 0.2);
}

/* Main Content */
main {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

/* Hero Section */
.hero {
    text-align: center;
    padding: 60px 20px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border-radius: 10px;
    margin-bottom: 40px;
}

.hero h2 {
    font-size: 36px;
    margin-bottom: 15px;
}

.hero p {
    font-size: 18px;
    margin-bottom: 25px;
}

/* Button */
.button {
    display: inline-block;
    background-color: white;
    color: #667eea;
    padding: 12px 30px;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
    transition: transform 0.3s, box-shadow 0.3s;
}

.button:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

/* Service Grid */
.services h2 {
    text-align: center;
    margin-bottom: 30px;
    color: #4CAF50;
}

.service-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
}

.service-card {
    background-color: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s;
}

.service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
}

.service-card h3 {
    color: #4CAF50;
    margin-bottom: 10px;
}

/* Footer */
footer {
    background-color: #333;
    color: white;
    text-align: center;
    padding: 20px;
    margin-top: 40px;
}
```

**Pros:**
- ✅ Separation of concerns
- ✅ Reusable across multiple pages
- ✅ Cached by browser (faster loading)
- ✅ Easy to maintain
- ✅ **BEST PRACTICE!**

---

## Activity 4: CSS Linking Methods Comparison

**Goal:** Understand all three methods and when to use each.

**Create:** `css-comparison.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>CSS Methods Comparison</title>
    
    <!-- Internal CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        
        .internal {
            background-color: #ffffcc;
            padding: 15px;
            margin: 10px 0;
            border-left: 4px solid #ffcc00;
        }
    </style>
    
    <!-- External CSS -->
    <link rel="stylesheet" href="comparison.css">
</head>
<body>
    <h1>CSS Linking Methods</h1>
    
    <!-- 1. Inline CSS (highest priority) -->
    <div style="background-color: #ffcccc; padding: 15px; margin: 10px 0; border-left: 4px solid #ff0000;">
        <h2 style="color: #cc0000; margin: 0;">1. Inline CSS</h2>
        <p style="margin: 5px 0;">Styles applied directly to element using style attribute.</p>
        <ul style="margin: 10px 0;">
            <li>✅ Highest specificity</li>
            <li>✅ Quick testing</li>
            <li>❌ Hard to maintain</li>
            <li>❌ Can't reuse</li>
        </ul>
    </div>
    
    <!-- 2. Internal CSS -->
    <div class="internal">
        <h2 style="color: #cc9900; margin: 0;">2. Internal CSS</h2>
        <p style="margin: 5px 0;">Styles in &lt;style&gt; tag within &lt;head&gt;.</p>
        <ul style="margin: 10px 0;">
            <li>✅ Organized in one place</li>
            <li>✅ Reusable within page</li>
            <li>❌ Not shared across pages</li>
            <li>❌ Larger HTML file</li>
        </ul>
    </div>
    
    <!-- 3. External CSS (styled by comparison.css) -->
    <div class="external">
        <h2>3. External CSS</h2>
        <p>Styles in separate .css file linked with &lt;link&gt;.</p>
        <ul>
            <li>✅ Separation of concerns</li>
            <li>✅ Reusable across pages</li>
            <li>✅ Browser caching</li>
            <li>✅ Best practice</li>
        </ul>
    </div>
    
    <hr>
    
    <h2>Priority Order (Specificity)</h2>
    <p id="test-priority" class="priority-test" style="color: red;">
        This text is RED because inline style (highest priority) overrides everything else.
    </p>
</body>
</html>
```

**Create:** `comparison.css`

```css
.external {
    background-color: #ccffcc;
    padding: 15px;
    margin: 10px 0;
    border-left: 4px solid #00cc00;
}

.external h2 {
    color: #009900;
    margin: 0;
}

.external p {
    margin: 5px 0;
}

.external ul {
    margin: 10px 0;
}

/* This will be overridden by inline style */
.priority-test {
    color: blue !important;  /* Even !important can't beat inline */
}

#test-priority {
    color: green;
}
```

---

## Activity 5: Multiple External CSS Files

**Goal:** Link multiple CSS files (organization).

**Create:** `multiple-css.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Multiple CSS Files</title>
    
    <!-- Load order matters! -->
    <link rel="stylesheet" href="reset.css">      <!-- 1. Reset -->
    <link rel="stylesheet" href="base.css">       <!-- 2. Base styles -->
    <link rel="stylesheet" href="layout.css">     <!-- 3. Layout -->
    <link rel="stylesheet" href="components.css"> <!-- 4. Components -->
    <link rel="stylesheet" href="utilities.css">  <!-- 5. Utilities -->
</head>
<body>
    <header class="site-header">
        <h1>Barangay Website</h1>
    </header>
    
    <main class="container">
        <section class="card">
            <h2>Content Card</h2>
            <p>Styled by multiple CSS files.</p>
        </section>
    </main>
    
    <footer class="site-footer">
        <p>&copy; 2025</p>
    </footer>
</body>
</html>
```

**File organization:**

**reset.css** (remove browser defaults):
```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
```

**base.css** (global styles):
```css
body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
}
```

**layout.css** (page structure):
```css
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}
```

**components.css** (reusable components):
```css
.card {
    background: white;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
```

**utilities.css** (helper classes):
```css
.text-center { text-align: center; }
.mt-20 { margin-top: 20px; }
.mb-20 { margin-bottom: 20px; }
```

---

## Activity 6: CSS Syntax and Comments

**Goal:** Learn proper CSS syntax.

**Create:** `css-syntax.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>CSS Syntax</title>
    <link rel="stylesheet" href="syntax.css">
</head>
<body>
    <h1 class="main-title">CSS Syntax</h1>
    <p id="intro">Understanding CSS rules.</p>
    <button class="btn btn-primary">Click Me</button>
</body>
</html>
```

**Create:** `syntax.css`

```css
/* 
   CSS Comment Syntax
   Can span multiple lines
*/

/* 
   CSS RULE ANATOMY:
   selector { property: value; }
*/

/* Element selector */
body {
    font-family: Arial, sans-serif;  /* Font for entire page */
    background-color: #f4f4f4;       /* Light gray background */
}

/* Class selector (starts with .) */
.main-title {
    color: #4CAF50;          /* Green text */
    font-size: 32px;         /* Font size */
    text-align: center;      /* Center alignment */
    margin-bottom: 20px;     /* Space below */
}

/* ID selector (starts with #) */
#intro {
    font-size: 18px;
    line-height: 1.6;
    color: #666;
}

/* Multiple selectors (comma-separated) */
h1, h2, h3 {
    font-family: 'Georgia', serif;
}

/* Class selector with multiple declarations */
.btn {
    padding: 10px 20px;          /* Shorthand: top/bottom left/right */
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.3s ease;   /* Smooth transitions */
}

/* Multiple classes */
.btn-primary {
    background-color: #008CBA;
    color: white;
}

.btn-primary:hover {
    background-color: #007B9A;
    transform: scale(1.05);
}

/* 
   PROPERTY VALUE TYPES:
   - Colors: #ff0000, rgb(255,0,0), hsl(0,100%,50%)
   - Lengths: px, em, rem, %, vw, vh
   - Keywords: auto, none, inherit
*/
```

**Syntax rules:**
- Selector → what to style
- Property → what aspect
- Value → how to style
- Each declaration ends with `;`
- Comments: `/* comment */`

---

## Activity 7: Complete Barangay Website with External CSS

**Goal:** Build a complete styled website.

**Create:** `index.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Sto. Niño - Official Website</title>
    <link rel="stylesheet" href="main.css">
</head>
<body>
    <header class="header">
        <div class="container">
            <div class="header-content">
                <img src="logo.png" alt="Barangay Logo" class="logo">
                <div>
                    <h1>Barangay Sto. Niño</h1>
                    <p class="tagline">Serving with Integrity Since 1952</p>
                </div>
            </div>
            <nav class="nav">
                <ul>
                    <li><a href="index.html" class="active">Home</a></li>
                    <li><a href="about.html">About</a></li>
                    <li><a href="services.html">Services</a></li>
                    <li><a href="officials.html">Officials</a></li>
                    <li><a href="contact.html">Contact</a></li>
                </ul>
            </nav>
        </div>
    </header>
    
    <main>
        <section class="hero">
            <div class="container">
                <h2>Welcome to Our Community</h2>
                <p>Transparent, efficient, and responsive governance for all residents.</p>
                <a href="services.html" class="btn btn-large">View Our Services</a>
            </div>
        </section>
        
        <section class="features">
            <div class="container">
                <h2 class="section-title">Quick Access</h2>
                <div class="feature-grid">
                    <div class="feature-card">
                        <div class="icon">📄</div>
                        <h3>Barangay Clearance</h3>
                        <p>Apply online or visit us for same-day processing.</p>
                        <a href="services.html#clearance" class="link">Apply Now →</a>
                    </div>
                    <div class="feature-card">
                        <div class="icon">🆔</div>
                        <h3>Barangay ID</h3>
                        <p>Get your official identification card.</p>
                        <a href="services.html#id" class="link">Get ID →</a>
                    </div>
                    <div class="feature-card">
                        <div class="icon">💼</div>
                        <h3>Business Permit</h3>
                        <p>Register your business with ease.</p>
                        <a href="services.html#permit" class="link">Register →</a>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="announcements">
            <div class="container">
                <h2 class="section-title">Latest Announcements</h2>
                <div class="announcement-list">
                    <article class="announcement-card">
                        <span class="date">Dec 4, 2025</span>
                        <h3>Extended Office Hours</h3>
                        <p>Office will be open until 6 PM throughout December.</p>
                    </article>
                    <article class="announcement-card">
                        <span class="date">Nov 28, 2025</span>
                        <h3>Free Medical Mission</h3>
                        <p>Join us this Saturday for free medical checkup.</p>
                    </article>
                </div>
            </div>
        </section>
    </main>
    
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div>
                    <h3>Barangay Sto. Niño</h3>
                    <p>P. Burgos Street, Batangas City</p>
                    <p>Phone: 043-123-4567</p>
                    <p>Email: brgy.stonino@example.com</p>
                </div>
                <div>
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="services.html">Services</a></li>
                        <li><a href="forms.html">Download Forms</a></li>
                        <li><a href="fees.html">Fee Schedule</a></li>
                    </ul>
                </div>
                <div>
                    <h3>Office Hours</h3>
                    <p>Mon-Fri: 8:00 AM - 5:00 PM</p>
                    <p>Sat: 8:00 AM - 12:00 PM</p>
                    <p>Sun: Closed</p>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 Barangay Sto. Niño. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>
```

**Create:** `main.css`

```css
/* CSS RESET */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* GLOBAL STYLES */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
    background-color: #f8f9fa;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* HEADER */
.header {
    background-color: #4CAF50;
    color: white;
    padding: 20px 0;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.header-content {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 15px;
}

.logo {
    width: 60px;
    height: 60px;
}

.header h1 {
    font-size: 28px;
    margin-bottom: 5px;
}

.tagline {
    font-size: 14px;
    opacity: 0.9;
}

/* NAVIGATION */
.nav ul {
    list-style: none;
    display: flex;
    gap: 5px;
}

.nav a {
    color: white;
    text-decoration: none;
    padding: 10px 20px;
    display: block;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.nav a:hover,
.nav a.active {
    background-color: rgba(255, 255, 255, 0.2);
}

/* HERO SECTION */
.hero {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    text-align: center;
    padding: 80px 20px;
}

.hero h2 {
    font-size: 42px;
    margin-bottom: 15px;
}

.hero p {
    font-size: 20px;
    margin-bottom: 30px;
    opacity: 0.95;
}

/* BUTTONS */
.btn {
    display: inline-block;
    padding: 12px 30px;
    background-color: white;
    color: #667eea;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
    transition: transform 0.3s, box-shadow 0.3s;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.btn-large {
    padding: 15px 40px;
    font-size: 18px;
}

/* SECTIONS */
.features,
.announcements {
    padding: 60px 0;
}

.section-title {
    text-align: center;
    font-size: 32px;
    color: #4CAF50;
    margin-bottom: 40px;
}

/* FEATURE GRID */
.feature-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 30px;
}

.feature-card {
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    text-align: center;
    transition: transform 0.3s, box-shadow 0.3s;
}

.feature-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 20px rgba(0,0,0,0.15);
}

.icon {
    font-size: 48px;
    margin-bottom: 15px;
}

.feature-card h3 {
    color: #4CAF50;
    margin-bottom: 10px;
    font-size: 22px;
}

.feature-card p {
    color: #666;
    margin-bottom: 15px;
}

.link {
    color: #667eea;
    text-decoration: none;
    font-weight: bold;
}

.link:hover {
    text-decoration: underline;
}

/* ANNOUNCEMENTS */
.announcements {
    background-color: white;
}

.announcement-list {
    display: grid;
    gap: 20px;
}

.announcement-card {
    background: #f8f9fa;
    padding: 25px;
    border-left: 4px solid #4CAF50;
    border-radius: 5px;
}

.date {
    display: inline-block;
    background: #4CAF50;
    color: white;
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 14px;
    margin-bottom: 10px;
}

.announcement-card h3 {
    color: #333;
    margin-bottom: 10px;
}

.announcement-card p {
    color: #666;
}

/* FOOTER */
.footer {
    background-color: #333;
    color: white;
    padding: 40px 0 20px;
    margin-top: 60px;
}

.footer-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
    margin-bottom: 30px;
}

.footer h3 {
    color: #4CAF50;
    margin-bottom: 15px;
}

.footer-links {
    list-style: none;
}

.footer-links a {
    color: white;
    text-decoration: none;
    opacity: 0.8;
    transition: opacity 0.3s;
}

.footer-links a:hover {
    opacity: 1;
}

.copyright {
    text-align: center;
    padding-top: 20px;
    border-top: 1px solid #555;
    opacity: 0.7;
}
```

**Features implemented:**
✅ External CSS (best practice)  
✅ Responsive grid layout  
✅ Hover effects and transitions  
✅ Consistent color scheme  
✅ Organized CSS structure  
✅ Professional design  
✅ Mobile-friendly foundation

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## CSS Linking Methods

### 1. Inline CSS
```html
<p style="color: red; font-size: 16px;">Text</p>
```

**Use when:**
- Quick testing/debugging
- Email HTML (limited CSS support)
- Dynamic styles (JavaScript)

**Avoid because:**
- Hard to maintain
- Can't reuse
- Mixes content/presentation
- Highest specificity (hard to override)

### 2. Internal CSS
```html
<head>
    <style>
        p { color: red; }
    </style>
</head>
```

**Use when:**
- Single-page websites
- Page-specific styles
- Critical CSS (above-the-fold)
- Overriding external styles

**Avoid because:**
- Not reusable across pages
- Makes HTML file larger
- Still mixes content/presentation

### 3. External CSS (BEST PRACTICE)
```html
<head>
    <link rel="stylesheet" href="style.css">
</head>
```

**Use when:**
- Multi-page websites (always!)
- Sharing styles across pages
- Team collaboration
- Production websites

**Benefits:**
- ✅ Separation of concerns
- ✅ Reusable and maintainable
- ✅ Browser caching (faster)
- ✅ Easy updates
- ✅ Industry standard

## CSS Syntax

**Anatomy of CSS rule:**
```css
selector {
    property: value;
    property: value;
}
```

**Example:**
```css
/* Comment */
.button {
    background-color: blue;  /* Property: value */
    color: white;
    padding: 10px 20px;
}
```

**Multiple selectors:**
```css
h1, h2, h3 {
    font-family: Arial;
}
```

**Shorthand properties:**
```css
/* Individual properties */
margin-top: 10px;
margin-right: 20px;
margin-bottom: 10px;
margin-left: 20px;

/* Shorthand (top right bottom left) */
margin: 10px 20px 10px 20px;

/* Shorthand (vertical horizontal) */
margin: 10px 20px;

/* Shorthand (all sides) */
margin: 10px;
```

## CSS Specificity and Priority

**Priority order (high to low):**
1. **Inline styles** - `style="..."` (1000 points)
2. **IDs** - `#id` (100 points)
3. **Classes/attributes/pseudo-classes** - `.class`, `[type]`, `:hover` (10 points)
4. **Elements/pseudo-elements** - `p`, `::before` (1 point)

**Example:**
```html
<p id="text" class="highlight" style="color: red;">Text</p>
```

```css
p { color: blue; }              /* 1 point */
.highlight { color: green; }    /* 10 points */
#text { color: yellow; }        /* 100 points */
/* inline style wins: RED */    /* 1000 points */
```

**!important override (avoid!):**
```css
p { color: blue !important; }  /* Overrides everything (bad practice) */
```

## File Organization

**Single CSS file (small projects):**
```
project/
├── index.html
├── about.html
└── style.css
```

**Multiple CSS files (large projects):**
```
project/
├── index.html
└── css/
    ├── reset.css        /* Browser reset */
    ├── base.css         /* Global styles */
    ├── layout.css       /* Page structure */
    ├── components.css   /* Reusable components */
    └── utilities.css    /* Helper classes */
```

**Load order in HTML:**
```html
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/base.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/components.css">
```

## Comments in CSS

```css
/* Single-line comment */

/*
   Multi-line comment
   Can span multiple lines
*/

/* TODO: Fix responsive layout */

/* 
   SECTION: NAVIGATION STYLES
   ================================
*/
.nav { ... }
```

## Common CSS Properties

**Text:**
```css
color: #333;
font-size: 16px;
font-weight: bold;
text-align: center;
line-height: 1.6;
text-decoration: none;
```

**Box model:**
```css
padding: 20px;
margin: 10px;
border: 1px solid #ddd;
border-radius: 5px;
```

**Background:**
```css
background-color: #f4f4f4;
background-image: url('image.jpg');
```

**Display:**
```css
display: block;
display: inline;
display: flex;
display: grid;
display: none;
```

## Link Tag Attributes

```html
<link 
    rel="stylesheet"          <!-- Relationship (required) -->
    href="style.css"          <!-- File path (required) -->
    type="text/css"           <!-- MIME type (optional, implied) -->
    media="screen"            <!-- Media type (optional) -->
>
```

**Media attribute:**
```html
<!-- Different CSS for different devices -->
<link rel="stylesheet" href="screen.css" media="screen">
<link rel="stylesheet" href="print.css" media="print">
<link rel="stylesheet" href="mobile.css" media="(max-width: 768px)">
```

</details>

---

**Fantastic!** You've learned how to add CSS to your HTML! You can now style your webpages and make them visually appealing.

**Next:** CSS selectors, properties, and values!
