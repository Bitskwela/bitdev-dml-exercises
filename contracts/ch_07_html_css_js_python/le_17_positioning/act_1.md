# Lesson 17 Activities: CSS Positioning

## Taking Control of Element Placement

Master CSS positioning to place elements exactly where you need them - from floating badges to sticky headers!

---

## Activity 1: Position Relative - Offset from Normal Position

**Goal:** Understand how relative positioning shifts elements.

**Create:** `relative-positioning.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Relative Positioning</title>
    <link rel="stylesheet" href="relative-positioning.css">
</head>
<body>
    <div class="container">
        <h1>Position: Relative</h1>
        
        <div class="box box1">Box 1 (Normal)</div>
        <div class="box box2">Box 2 (Shifted Down & Right)</div>
        <div class="box box3">Box 3 (Normal)</div>
        
        <p class="explanation">
            Box 2 is shifted but its original space is preserved. 
            Notice Box 3 doesn't move up to fill the gap.
        </p>
    </div>
</body>
</html>
```

**Create:** `relative-positioning.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px;
}

.container {
    max-width: 600px;
    margin: 0 auto;
    background-color: white;
    padding: 30px;
    border-radius: 10px;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 30px;
}

.box {
    background-color: #2196f3;
    color: white;
    padding: 20px;
    margin-bottom: 10px;
    text-align: center;
    font-weight: bold;
}

/* Box 2: Relative positioning with offset */
.box2 {
    position: relative;
    top: 20px;      /* Moves 20px DOWN from original position */
    left: 30px;     /* Moves 30px RIGHT from original position */
    background-color: #ff9800;
}

.explanation {
    margin-top: 30px;
    padding: 15px;
    background-color: #e3f2fd;
    border-left: 4px solid #2196f3;
    color: #1565c0;
}
```

**Test:** Notice how Box 2 shifts but Box 3 doesn't move - the original space is preserved!

---

## Activity 2: Position Absolute - Badge in Corner

**Goal:** Create a floating badge using absolute positioning.

**Create:** `absolute-badge.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Absolute Positioning Badge</title>
    <link rel="stylesheet" href="absolute-badge.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Announcements</h1>
        
        <div class="announcement-card">
            <span class="badge">URGENT</span>
            <h2>Typhoon Warning</h2>
            <p class="date">December 4, 2025</p>
            <p class="content">
                Signal #2 is in effect. All classes and government work suspended. 
                Stay indoors and monitor updates.
            </p>
        </div>
        
        <div class="announcement-card">
            <span class="badge new">NEW</span>
            <h2>Christmas Program</h2>
            <p class="date">December 20, 2025</p>
            <p class="content">
                Join our annual Christmas celebration with games, raffles, 
                and gifts for all residents.
            </p>
        </div>
    </div>
</body>
</html>
```

**Create:** `absolute-badge.css`

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

/* Card with relative positioning (context for badge) */
.announcement-card {
    position: relative;  /* Establishes positioning context */
    background-color: white;
    padding: 25px;
    margin-bottom: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

/* Badge with absolute positioning */
.badge {
    position: absolute;  /* Removed from flow */
    top: 15px;           /* 15px from top of card */
    right: 15px;         /* 15px from right of card */
    background-color: #f44336;
    color: white;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
}

.badge.new {
    background-color: #4caf50;
}

.announcement-card h2 {
    color: #333;
    margin-bottom: 8px;
    padding-right: 80px;  /* Space for badge */
}

.date {
    font-size: 13px;
    color: #999;
    margin-bottom: 15px;
}

.content {
    color: #666;
    line-height: 1.6;
}
```

**Key concept:** Parent needs `position: relative` to establish positioning context for absolutely positioned children!

---

## Activity 3: Position Fixed - Sticky Header

**Goal:** Create a header that stays at top when scrolling.

**Create:** `fixed-header.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fixed Header</title>
    <link rel="stylesheet" href="fixed-header.css">
</head>
<body>
    <!-- Fixed header -->
    <header class="header">
        <div class="header-content">
            <h1>Barangay San Miguel</h1>
            <nav>
                <a href="#home">Home</a>
                <a href="#services">Services</a>
                <a href="#announcements">Announcements</a>
                <a href="#contact">Contact</a>
            </nav>
        </div>
    </header>
    
    <!-- Main content (add padding-top for fixed header) -->
    <main class="main-content">
        <section id="home">
            <h2>Welcome</h2>
            <p>Scroll down to see the fixed header in action!</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit...</p>
        </section>
        
        <section id="services">
            <h2>Our Services</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...</p>
            <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur...</p>
        </section>
        
        <section id="announcements">
            <h2>Announcements</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit...</p>
            <p>Excepteur sint occaecat cupidatat non proident...</p>
        </section>
        
        <section id="contact">
            <h2>Contact Us</h2>
            <p>Visit us at the barangay hall or call 043-123-4567</p>
            <p>Email: info@barangaysanmiguel.gov.ph</p>
        </section>
    </main>
    
    <!-- Fixed back-to-top button -->
    <button class="back-to-top" onclick="window.scrollTo({top: 0, behavior: 'smooth'})">
        ↑
    </button>
</body>
</html>
```

**Create:** `fixed-header.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
}

/* Fixed header - stays at top when scrolling */
.header {
    position: fixed;     /* Fixed to viewport */
    top: 0;              /* Stick to top */
    left: 0;
    width: 100%;         /* Full width */
    background-color: #1a73e8;
    color: white;
    z-index: 1000;       /* Above other content */
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
}

.header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header h1 {
    font-size: 1.5rem;
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

/* Main content - add padding-top for fixed header */
.main-content {
    padding-top: 100px;  /* Height of fixed header + spacing */
    max-width: 1200px;
    margin: 0 auto;
    padding-left: 20px;
    padding-right: 20px;
}

section {
    padding: 60px 0;
    min-height: 400px;
}

section h2 {
    color: #1a73e8;
    margin-bottom: 20px;
    font-size: 2rem;
}

section p {
    color: #666;
    margin-bottom: 15px;
    font-size: 1.1rem;
}

/* Fixed back-to-top button */
.back-to-top {
    position: fixed;      /* Fixed to viewport */
    bottom: 30px;         /* 30px from bottom */
    right: 30px;          /* 30px from right */
    width: 50px;
    height: 50px;
    background-color: #1a73e8;
    color: white;
    border: none;
    border-radius: 50%;
    font-size: 24px;
    cursor: pointer;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
    z-index: 1000;
    transition: background-color 0.3s, transform 0.3s;
}

.back-to-top:hover {
    background-color: #1557b0;
    transform: scale(1.1);
}

/* Responsive */
@media (max-width: 768px) {
    .header-content {
        flex-direction: column;
        gap: 15px;
    }
    
    .header nav {
        flex-direction: column;
        gap: 10px;
        width: 100%;
    }
    
    .header nav a {
        text-align: center;
    }
}
```

**Test:** Scroll down - header stays fixed at top!

---

## Activity 4: Position Sticky - Section Headers

**Goal:** Create headers that stick when scrolling past them.

**Create:** `sticky-headers.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sticky Section Headers</title>
    <link rel="stylesheet" href="sticky-headers.css">
</head>
<body>
    <header class="main-header">
        <h1>Barangay Document Processing</h1>
    </header>
    
    <main class="container">
        <section>
            <h2 class="sticky-header">Pending Applications</h2>
            <div class="document">Document 1 - Barangay Clearance</div>
            <div class="document">Document 2 - Business Permit</div>
            <div class="document">Document 3 - Residency Certificate</div>
            <div class="document">Document 4 - Indigency Certificate</div>
            <div class="document">Document 5 - Community Tax Certificate</div>
        </section>
        
        <section>
            <h2 class="sticky-header">Processing</h2>
            <div class="document">Document 6 - Barangay Clearance</div>
            <div class="document">Document 7 - Business Permit Renewal</div>
            <div class="document">Document 8 - Certificate of Residency</div>
            <div class="document">Document 9 - Barangay ID Application</div>
            <div class="document">Document 10 - Building Permit</div>
        </section>
        
        <section>
            <h2 class="sticky-header">Ready for Pickup</h2>
            <div class="document">Document 11 - Barangay Clearance</div>
            <div class="document">Document 12 - Indigency Certificate</div>
            <div class="document">Document 13 - Community Tax</div>
            <div class="document">Document 14 - Residency Certificate</div>
            <div class="document">Document 15 - Business Permit</div>
        </section>
        
        <section>
            <h2 class="sticky-header">Completed</h2>
            <div class="document">Document 16 - Barangay Clearance</div>
            <div class="document">Document 17 - Barangay ID</div>
            <div class="document">Document 18 - Certificate of Residency</div>
            <div class="document">Document 19 - Business Permit</div>
            <div class="document">Document 20 - Community Tax</div>
        </section>
    </main>
</body>
</html>
```

**Create:** `sticky-headers.css`

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

.main-header {
    background: linear-gradient(135deg, #1a73e8, #4caf50);
    color: white;
    text-align: center;
    padding: 40px 20px;
}

.main-header h1 {
    font-size: 2rem;
}

.container {
    max-width: 900px;
    margin: 0 auto;
    padding: 20px;
}

section {
    margin-bottom: 20px;
}

/* Sticky section header */
.sticky-header {
    position: sticky;     /* Sticky positioning */
    top: 0;               /* Stick to top when scrolling */
    background-color: #1a73e8;
    color: white;
    padding: 15px 20px;
    margin-bottom: 15px;
    border-radius: 5px;
    font-size: 1.3rem;
    z-index: 10;          /* Above documents */
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
}

.document {
    background-color: white;
    padding: 20px;
    margin-bottom: 10px;
    border-left: 4px solid #2196f3;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.document:hover {
    background-color: #f9f9f9;
}
```

**Test:** Scroll down - each section header sticks to top as you scroll past it!

---

## Activity 5: Z-Index - Stacking Order

**Goal:** Control which elements appear on top using z-index.

**Create:** `z-index-demo.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Z-Index Stacking</title>
    <link rel="stylesheet" href="z-index-demo.css">
</head>
<body>
    <div class="container">
        <h1>Z-Index Stacking Order</h1>
        
        <div class="stacking-demo">
            <div class="box box1">Z-Index: 1</div>
            <div class="box box2">Z-Index: 10</div>
            <div class="box box3">Z-Index: 5</div>
        </div>
        
        <p class="explanation">
            Higher z-index values appear on top. 
            Box 2 (z-index: 10) is on top, then Box 3 (z-index: 5), then Box 1 (z-index: 1).
        </p>
    </div>
</body>
</html>
```

**Create:** `z-index-demo.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px;
}

.container {
    max-width: 800px;
    margin: 0 auto;
    background-color: white;
    padding: 30px;
    border-radius: 10px;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 30px;
}

.stacking-demo {
    position: relative;
    height: 300px;
    background-color: #f9f9f9;
    border: 2px dashed #ccc;
    margin-bottom: 30px;
}

.box {
    position: absolute;
    width: 200px;
    height: 150px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    font-size: 1.2rem;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
}

.box1 {
    top: 20px;
    left: 20px;
    background-color: #f44336;
    z-index: 1;  /* Bottom */
}

.box2 {
    top: 60px;
    left: 100px;
    background-color: #4caf50;
    z-index: 10;  /* Top */
}

.box3 {
    top: 100px;
    left: 180px;
    background-color: #2196f3;
    z-index: 5;  /* Middle */
}

.explanation {
    padding: 15px;
    background-color: #e3f2fd;
    border-left: 4px solid #2196f3;
    color: #1565c0;
    line-height: 1.6;
}
```

---

## Activity 6: Modal Overlay

**Goal:** Create a centered modal using positioning.

**Create:** `modal-overlay.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Modal Overlay</title>
    <link rel="stylesheet" href="modal-overlay.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Clearance Application</h1>
        <p>Click the button to open the application form.</p>
        <button class="btn" onclick="openModal()">Apply for Clearance</button>
    </div>
    
    <!-- Modal overlay (hidden by default) -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Barangay Clearance Application</h2>
            <form>
                <div class="form-group">
                    <label>Full Name:</label>
                    <input type="text" required>
                </div>
                <div class="form-group">
                    <label>Address:</label>
                    <input type="text" required>
                </div>
                <div class="form-group">
                    <label>Purpose:</label>
                    <select required>
                        <option value="">Select purpose</option>
                        <option>Employment</option>
                        <option>Business</option>
                        <option>Travel</option>
                        <option>Other</option>
                    </select>
                </div>
                <button type="submit" class="btn">Submit Application</button>
            </form>
        </div>
    </div>
    
    <script>
        function openModal() {
            document.getElementById('modal').style.display = 'flex';
        }
        
        function closeModal() {
            document.getElementById('modal').style.display = 'none';
        }
        
        // Close when clicking outside modal
        window.onclick = function(event) {
            const modal = document.getElementById('modal');
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>
```

**Create:** `modal-overlay.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px;
}

.container {
    max-width: 800px;
    margin: 0 auto;
    background-color: white;
    padding: 40px;
    border-radius: 10px;
}

h1 {
    color: #1a73e8;
    margin-bottom: 20px;
}

.btn {
    background-color: #1a73e8;
    color: white;
    border: none;
    padding: 12px 30px;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    margin-top: 20px;
}

.btn:hover {
    background-color: #1557b0;
}

/* Modal overlay - fixed positioning */
.modal {
    display: none;  /* Hidden by default */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);  /* Semi-transparent overlay */
    z-index: 1000;
    align-items: center;
    justify-content: center;
}

/* Modal content - absolute positioning */
.modal-content {
    position: relative;
    background-color: white;
    padding: 40px;
    border-radius: 15px;
    max-width: 500px;
    width: 90%;
    max-height: 90vh;
    overflow-y: auto;
    box-shadow: 0 10px 40px rgba(0,0,0,0.3);
    animation: slideDown 0.3s ease;
}

@keyframes slideDown {
    from {
        transform: translateY(-50px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

/* Close button */
.close {
    position: absolute;
    top: 15px;
    right: 20px;
    font-size: 30px;
    font-weight: bold;
    color: #999;
    cursor: pointer;
    transition: color 0.3s;
}

.close:hover {
    color: #333;
}

.modal-content h2 {
    color: #1a73e8;
    margin-bottom: 25px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    color: #333;
    font-weight: bold;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
}

.form-group input:focus,
.form-group select:focus {
    outline: none;
    border-color: #1a73e8;
}
```

---

## Activity 7: Complete Barangay Portal with All Positioning Types

**Goal:** Combine all positioning techniques in one page.

**Create:** `complete-positioning.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay San Miguel Portal</title>
    <link rel="stylesheet" href="complete-positioning.css">
</head>
<body>
    <!-- Fixed header -->
    <header class="header">
        <div class="header-content">
            <h1>Barangay San Miguel</h1>
            <nav>
                <a href="#home">Home</a>
                <a href="#services">Services</a>
                <a href="#announcements">Announcements</a>
                <a href="#contact">Contact</a>
            </nav>
        </div>
    </header>
    
    <!-- Main content -->
    <main class="main-content">
        <!-- Hero section -->
        <section id="home" class="hero">
            <h2>Welcome to Our Community</h2>
            <p>Pagkakaisa, Paglilingkod, Pag-unlad</p>
        </section>
        
        <!-- Announcements with badges (absolute) -->
        <section id="announcements">
            <h2 class="sticky-section-header">Latest Announcements</h2>
            
            <div class="announcement-card">
                <span class="badge urgent">URGENT</span>
                <h3>Typhoon Warning</h3>
                <p>Signal #2 in effect. Stay safe and monitor updates.</p>
            </div>
            
            <div class="announcement-card">
                <span class="badge new">NEW</span>
                <h3>Christmas Program</h3>
                <p>Join us December 20 for our annual celebration!</p>
            </div>
        </section>
        
        <!-- Services section -->
        <section id="services">
            <h2 class="sticky-section-header">Available Services</h2>
            
            <div class="services-grid">
                <div class="service-card">
                    <div class="icon">📄</div>
                    <h4>Barangay Clearance</h4>
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
            </div>
        </section>
        
        <!-- Contact section -->
        <section id="contact">
            <h2 class="sticky-section-header">Contact Us</h2>
            <p>Visit us at the barangay hall or reach out through:</p>
            <p><strong>Phone:</strong> 043-123-4567</p>
            <p><strong>Email:</strong> info@barangaysanmiguel.gov.ph</p>
        </section>
    </main>
    
    <!-- Fixed back-to-top button -->
    <button class="back-to-top" onclick="window.scrollTo({top: 0, behavior: 'smooth'})">
        ↑
    </button>
    
    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 Barangay San Miguel. All rights reserved.</p>
    </footer>
</body>
</html>
```

**Create:** `complete-positioning.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
}

/* FIXED HEADER */
.header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background-color: #1a73e8;
    color: white;
    z-index: 1000;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
}

.header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header h1 {
    font-size: 1.5rem;
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

/* MAIN CONTENT */
.main-content {
    padding-top: 80px;  /* Space for fixed header */
    max-width: 1200px;
    margin: 0 auto;
    padding-left: 20px;
    padding-right: 20px;
}

/* HERO SECTION */
.hero {
    text-align: center;
    padding: 100px 20px;
    background: linear-gradient(135deg, #1a73e8, #4caf50);
    color: white;
    margin: 0 -20px 40px;
    border-radius: 15px;
}

.hero h2 {
    font-size: 3rem;
    margin-bottom: 15px;
}

.hero p {
    font-size: 1.5rem;
    font-style: italic;
}

/* SECTIONS */
section {
    margin-bottom: 60px;
}

/* STICKY SECTION HEADERS */
.sticky-section-header {
    position: sticky;
    top: 80px;  /* Below fixed header */
    background-color: #f5f5f5;
    padding: 15px 20px;
    border-left: 5px solid #1a73e8;
    color: #1a73e8;
    font-size: 1.8rem;
    z-index: 100;
    margin-bottom: 30px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

/* ANNOUNCEMENTS with ABSOLUTE BADGES */
.announcement-card {
    position: relative;  /* Context for badge */
    background-color: white;
    padding: 25px;
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.badge {
    position: absolute;
    top: 15px;
    right: 15px;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: bold;
    text-transform: uppercase;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
}

.badge.urgent {
    background-color: #f44336;
    color: white;
}

.badge.new {
    background-color: #4caf50;
    color: white;
}

.announcement-card h3 {
    color: #333;
    margin-bottom: 10px;
    padding-right: 80px;  /* Space for badge */
}

.announcement-card p {
    color: #666;
}

/* SERVICES GRID */
.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
}

.service-card {
    background-color: white;
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    transition: transform 0.3s;
}

.service-card:hover {
    transform: translateY(-5px);
}

.icon {
    font-size: 64px;
    margin-bottom: 15px;
}

.service-card h4 {
    color: #1a73e8;
    margin-bottom: 10px;
    font-size: 1.3rem;
}

.service-card p {
    color: #4caf50;
    font-weight: bold;
    font-size: 1.5rem;
}

/* CONTACT SECTION */
#contact p {
    margin-bottom: 10px;
    color: #666;
    font-size: 1.1rem;
}

/* FIXED BACK-TO-TOP BUTTON */
.back-to-top {
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    background-color: #1a73e8;
    color: white;
    border: none;
    border-radius: 50%;
    font-size: 24px;
    cursor: pointer;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
    z-index: 1000;
    transition: all 0.3s;
}

.back-to-top:hover {
    background-color: #1557b0;
    transform: scale(1.1);
}

/* FOOTER */
.footer {
    background-color: #333;
    color: white;
    text-align: center;
    padding: 30px 20px;
    margin-top: 60px;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .header-content {
        flex-direction: column;
        gap: 15px;
    }
    
    .header nav {
        flex-direction: column;
        width: 100%;
        gap: 10px;
    }
    
    .header nav a {
        text-align: center;
    }
    
    .hero h2 {
        font-size: 2rem;
    }
    
    .hero p {
        font-size: 1.2rem;
    }
}
```

**Features implemented:**
✅ Fixed header (stays at top)  
✅ Sticky section headers (stick when scrolling)  
✅ Absolute badge positioning (top-right corner)  
✅ Fixed back-to-top button (bottom-right corner)  
✅ Z-index for proper stacking  
✅ Responsive design

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## CSS Positioning Complete Reference

### Position: Static (Default)

Normal document flow. No special positioning.

```css
.element {
    position: static;  /* Default */
    /* top, right, bottom, left have NO effect */
}
```

---

### Position: Relative

Offset from normal position, original space preserved.

```css
.element {
    position: relative;
    top: 20px;     /* Moves DOWN 20px */
    left: 30px;    /* Moves RIGHT 30px */
}
```

**Use cases:**
- Slight adjustments from normal position
- Establish positioning context for absolute children
- Badge adjustments

**Key point:** Original space is reserved; other elements don't move.

---

### Position: Absolute

Removed from flow, positioned relative to nearest positioned ancestor.

```css
.parent {
    position: relative;  /* Establishes context */
}

.child {
    position: absolute;
    top: 10px;     /* 10px from parent's top */
    right: 10px;   /* 10px from parent's right */
}
```

**Use cases:**
- Badges in corners
- Dropdown menus
- Tooltips
- Overlays

**Key point:** Removed from flow; no space reserved.

---

### Position: Fixed

Positioned relative to viewport, stays when scrolling.

```css
.header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
}

body {
    padding-top: 80px;  /* Account for fixed header */
}
```

**Use cases:**
- Fixed navigation headers
- Floating action buttons
- Chat widgets
- Cookie notices

**Key point:** Always add padding to body for fixed header height!

---

### Position: Sticky

Hybrid: relative until threshold, then fixed.

```css
.section-header {
    position: sticky;
    top: 0;
    background-color: white;
    z-index: 10;
}
```

**Use cases:**
- Section headers
- Table headers
- Sidebar navigation

**Requirements:**
- Must specify top, bottom, left, or right
- Parent must have scrollable area

---

## Z-Index (Stacking Order)

Controls which elements appear on top.

```css
.element {
    position: relative;  /* z-index only works on positioned elements */
    z-index: 10;         /* Higher = on top */
}
```

**Common scale:**
```css
/* Content: 1-10 */
.content { z-index: 1; }

/* Dropdowns/tooltips: 100-500 */
.dropdown { z-index: 100; }

/* Fixed headers: 500-900 */
.header { z-index: 500; }

/* Modals/overlays: 1000+ */
.modal-overlay { z-index: 1000; }
.modal { z-index: 1001; }
```

---

## Centering with Positioning

**Absolute centering:**
```css
.centered {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
```

**Fixed centering (modal):**
```css
.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
}
```

---

## Common Patterns

### Fixed Header
```css
.header {
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 1000;
}

body {
    padding-top: 80px;  /* Header height */
}
```

### Badge in Corner
```css
.card {
    position: relative;
}

.badge {
    position: absolute;
    top: 10px;
    right: 10px;
}
```

### Sticky Section Header
```css
.section-header {
    position: sticky;
    top: 0;
    background: white;
    z-index: 10;
}
```

### Modal Overlay
```css
.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.6);
    z-index: 1000;
}

.modal-content {
    position: relative;
    background: white;
    padding: 40px;
    border-radius: 10px;
}
```

---

## Best Practices

1. **Use relative on parent for absolute children**
2. **Add padding for fixed headers**
3. **Use consistent z-index scale**
4. **Test sticky on different browsers**
5. **Avoid overusing absolute positioning**

---

## Common Mistakes

1. **Forgetting positioning context**
   ```css
   /* Won't work as expected */
   .badge { position: absolute; }  /* Where's the parent? */
   
   /* Fix */
   .card { position: relative; }
   .badge { position: absolute; }
   ```

2. **Not accounting for fixed header**
   ```css
   /* Content hidden under header */
   .header { position: fixed; height: 60px; }
   
   /* Fix */
   body { padding-top: 60px; }
   ```

3. **Z-index without positioning**
   ```css
   /* Won't work */
   .element { z-index: 100; }
   
   /* Fix */
   .element { position: relative; z-index: 100; }
   ```

</details>

---

**Congratulations!** You've mastered CSS positioning! You can now place elements exactly where you need them using relative, absolute, fixed, and sticky positioning.

**Next Lesson:** Flexbox Basics - Modern one-dimensional layouts!

