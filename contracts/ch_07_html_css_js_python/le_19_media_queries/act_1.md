# Lesson 19 Activities: Media Queries & Responsive Design

## Making Websites Work on All Devices

Your website looks great on desktop - but mobile users see a broken mess! Time to fix that with media queries.

---

## Activity 1: Basic Media Query

**Goal:** Understand how media queries detect screen size.

**Create:** `basic-media-query.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basic Media Query</title>
    <link rel="stylesheet" href="basic-media-query.css">
</head>
<body>
    <div class="container">
        <h1 class="title">Screen Size Detector</h1>
        <div class="screen-info">
            <p>Resize your browser window to see the magic!</p>
        </div>
    </div>
</body>
</html>
```

**Create:** `basic-media-query.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    padding: 40px 20px;
    transition: background-color 0.3s;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

/* Default: Desktop styles */
body {
    background-color: #e3f2fd;
}

.title {
    color: #1a73e8;
    text-align: center;
    margin-bottom: 30px;
}

.title::after {
    content: " - Desktop View";
    font-size: 1rem;
    color: #666;
}

.screen-info {
    background-color: white;
    padding: 50px;
    border-radius: 15px;
    text-align: center;
    font-size: 1.5rem;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

/* Tablet: 768px and below */
@media (max-width: 768px) {
    body {
        background-color: #fff3e0;
    }
    
    .title::after {
        content: " - Tablet View";
    }
    
    .screen-info {
        font-size: 1.3rem;
        padding: 40px;
    }
}

/* Mobile: 480px and below */
@media (max-width: 480px) {
    body {
        background-color: #f1f8e9;
    }
    
    .title::after {
        content: " - Mobile View";
    }
    
    .screen-info {
        font-size: 1.1rem;
        padding: 30px;
    }
}
```

**Test:** Resize browser - background color and text change!

**Critical:** Always add viewport meta tag for mobile!

---

## Activity 2: Mobile-First Responsive Navigation

**Goal:** Create navigation that adapts to screen size.

**Create:** `responsive-navigation.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Navigation</title>
    <link rel="stylesheet" href="responsive-navigation.css">
</head>
<body>
    <header class="header">
        <div class="logo">🏛️ Barangay San Miguel</div>
        <nav class="nav">
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#announcements">Announcements</a>
            <a href="#contact">Contact</a>
        </nav>
    </header>
    
    <main class="main-content">
        <h1>Responsive Navigation</h1>
        <p>Resize your browser to see the navigation change from horizontal to vertical.</p>
        
        <div class="demo-box">
            <h2>Mobile View (0-768px)</h2>
            <ul>
                <li>Navigation stacks vertically</li>
                <li>Full-width links</li>
                <li>Centered text</li>
            </ul>
        </div>
        
        <div class="demo-box">
            <h2>Desktop View (769px+)</h2>
            <ul>
                <li>Navigation horizontal</li>
                <li>Links side-by-side</li>
                <li>Logo and nav on same line</li>
            </ul>
        </div>
    </main>
</body>
</html>
```

**Create:** `responsive-navigation.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
}

/* MOBILE FIRST: Base styles for mobile */
.header {
    background-color: #1a73e8;
    color: white;
    padding: 20px;
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
    text-align: center;
    margin-bottom: 15px;
}

.nav {
    display: flex;
    flex-direction: column;  /* Stack vertically on mobile */
    gap: 10px;
}

.nav a {
    color: white;
    text-decoration: none;
    padding: 12px;
    text-align: center;
    background-color: rgba(255,255,255,0.1);
    border-radius: 5px;
    transition: background-color 0.3s;
}

.nav a:hover {
    background-color: rgba(255,255,255,0.2);
}

/* Main content */
.main-content {
    padding: 40px 20px;
    max-width: 1200px;
    margin: 0 auto;
}

.main-content h1 {
    color: #1a73e8;
    margin-bottom: 20px;
}

.main-content p {
    color: #666;
    margin-bottom: 30px;
    font-size: 1.1rem;
}

.demo-box {
    background-color: white;
    padding: 25px;
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.demo-box h2 {
    color: #1a73e8;
    margin-bottom: 15px;
}

.demo-box ul {
    margin-left: 20px;
    color: #666;
}

.demo-box li {
    margin-bottom: 8px;
}

/* TABLET AND UP: 768px+ */
@media (min-width: 768px) {
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px 5%;
    }
    
    .logo {
        margin-bottom: 0;
    }
    
    .nav {
        flex-direction: row;  /* Horizontal on desktop */
        gap: 20px;
    }
    
    .nav a {
        background-color: transparent;
    }
}
```

**Note:** Mobile-first means base styles are mobile, then enhance for desktop!

---

## Activity 3: Responsive Card Grid

**Goal:** Create cards that stack on mobile, grid on desktop.

**Create:** `responsive-cards.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Cards</title>
    <link rel="stylesheet" href="responsive-cards.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Services</h1>
        <p class="subtitle">Our services adapt to your screen size</p>
        
        <div class="cards-grid">
            <div class="card">
                <div class="icon">📄</div>
                <h3>Barangay Clearance</h3>
                <p>Required for employment, travel, and business applications.</p>
                <div class="price">₱50.00</div>
                <button>Apply Now</button>
            </div>
            
            <div class="card">
                <div class="icon">🆔</div>
                <h3>Barangay ID</h3>
                <p>Official identification for all barangay residents.</p>
                <div class="price">₱30.00</div>
                <button>Apply Now</button>
            </div>
            
            <div class="card">
                <div class="icon">💼</div>
                <h3>Business Permit</h3>
                <p>Required permit for all business operations.</p>
                <div class="price">₱500.00</div>
                <button>Apply Now</button>
            </div>
            
            <div class="card">
                <div class="icon">📜</div>
                <h3>Residency Certificate</h3>
                <p>Proof of residency for various purposes.</p>
                <div class="price">₱30.00</div>
                <button>Apply Now</button>
            </div>
            
            <div class="card">
                <div class="icon">💳</div>
                <h3>Community Tax</h3>
                <p>Annual community tax certificate (Cedula).</p>
                <div class="price">₱5.00</div>
                <button>Apply Now</button>
            </div>
            
            <div class="card">
                <div class="icon">🏥</div>
                <h3>Indigency Certificate</h3>
                <p>For medical and financial assistance.</p>
                <div class="price">Free</div>
                <button>Apply Now</button>
            </div>
        </div>
    </div>
</body>
</html>
```

**Create:** `responsive-cards.css`

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

/* MOBILE FIRST: Single column */
.cards-grid {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.card {
    background-color: white;
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
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
    color: #333;
    margin-bottom: 12px;
    font-size: 1.3rem;
}

.card p {
    color: #666;
    line-height: 1.6;
    margin-bottom: 15px;
}

.price {
    color: #4caf50;
    font-size: 2rem;
    font-weight: bold;
    margin-bottom: 20px;
}

.card button {
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

.card button:hover {
    background-color: #1557b0;
}

/* TABLET: 600px+ → 2 columns */
@media (min-width: 600px) {
    .cards-grid {
        flex-direction: row;
        flex-wrap: wrap;
    }
    
    .card {
        flex: 0 1 calc(50% - 10px);  /* 2 columns with gap */
    }
}

/* DESKTOP: 900px+ → 3 columns */
@media (min-width: 900px) {
    .card {
        flex: 0 1 calc(33.333% - 14px);  /* 3 columns with gap */
    }
}
```

**Breakpoints:**
- Mobile: 1 column (default)
- Tablet (600px+): 2 columns
- Desktop (900px+): 3 columns

---

## Activity 4: Responsive Typography

**Goal:** Scale font sizes for different screens.

**Create:** `responsive-typography.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Typography</title>
    <link rel="stylesheet" href="responsive-typography.css">
</head>
<body>
    <article class="article">
        <h1>Barangay San Miguel: A Community of Progress</h1>
        
        <p class="lead">
            Discover how our barangay serves the community with dedication and innovation.
        </p>
        
        <h2>Our Mission</h2>
        <p>
            To provide quality services to all residents through efficient governance, 
            community engagement, and continuous improvement of our facilities and programs.
        </p>
        
        <h2>Services We Offer</h2>
        <p>
            From barangay clearances to community events, we're here to serve you. 
            Our office is open Monday to Friday, 8:00 AM to 5:00 PM.
        </p>
        
        <blockquote>
            "Ang barangay ay hindi lamang isang lugar - ito ay isang pamilya."
        </blockquote>
        
        <h2>Get Involved</h2>
        <p>
            Join our monthly town hall meetings and be part of the decision-making process. 
            Your voice matters in shaping our community's future.
        </p>
    </article>
</body>
</html>
```

**Create:** `responsive-typography.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Georgia', serif;
    background-color: #f9f9f9;
    padding: 20px;
    line-height: 1.8;
}

.article {
    max-width: 800px;
    margin: 0 auto;
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

/* MOBILE FIRST: Smaller text */
h1 {
    font-size: 1.8rem;
    color: #1a73e8;
    margin-bottom: 20px;
    line-height: 1.3;
}

h2 {
    font-size: 1.4rem;
    color: #333;
    margin-top: 30px;
    margin-bottom: 15px;
}

.lead {
    font-size: 1.1rem;
    color: #666;
    margin-bottom: 30px;
    font-style: italic;
}

p {
    font-size: 1rem;
    color: #444;
    margin-bottom: 20px;
}

blockquote {
    font-size: 1.1rem;
    font-style: italic;
    color: #1a73e8;
    border-left: 4px solid #1a73e8;
    padding-left: 20px;
    margin: 30px 0;
}

/* TABLET: 600px+ → Larger text */
@media (min-width: 600px) {
    .article {
        padding: 40px;
    }
    
    h1 {
        font-size: 2.5rem;
    }
    
    h2 {
        font-size: 1.8rem;
    }
    
    .lead {
        font-size: 1.3rem;
    }
    
    p {
        font-size: 1.1rem;
    }
    
    blockquote {
        font-size: 1.3rem;
    }
}

/* DESKTOP: 900px+ → Even larger text */
@media (min-width: 900px) {
    .article {
        padding: 60px;
    }
    
    h1 {
        font-size: 3rem;
    }
    
    h2 {
        font-size: 2rem;
    }
    
    .lead {
        font-size: 1.4rem;
    }
    
    p {
        font-size: 1.2rem;
    }
    
    blockquote {
        font-size: 1.4rem;
    }
}
```

**Scaling:**
- Mobile: Smaller text for readability
- Tablet: Medium text
- Desktop: Larger text with more spacing

---

## Activity 5: Hide/Show Elements Responsively

**Goal:** Show/hide content based on screen size.

**Create:** `responsive-visibility.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Visibility</title>
    <link rel="stylesheet" href="responsive-visibility.css">
</head>
<body>
    <header class="header">
        <div class="logo">🏛️ Barangay San Miguel</div>
        
        <!-- Full navigation for desktop -->
        <nav class="desktop-nav">
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#announcements">Announcements</a>
            <a href="#officials">Officials</a>
            <a href="#events">Events</a>
            <a href="#contact">Contact</a>
        </nav>
        
        <!-- Simplified menu for mobile -->
        <button class="mobile-menu-btn">☰ Menu</button>
    </header>
    
    <main class="main-content">
        <section class="hero">
            <h1>Welcome to Our Community</h1>
            
            <!-- Long description for desktop -->
            <p class="desktop-only">
                Barangay San Miguel is committed to serving our community with integrity, 
                transparency, and dedication. We offer a wide range of services from document 
                processing to community programs, all designed to improve the quality of life 
                for our residents.
            </p>
            
            <!-- Short description for mobile -->
            <p class="mobile-only">
                Serving our community with integrity and dedication.
            </p>
        </section>
        
        <section class="services">
            <h2>Our Services</h2>
            <div class="services-grid">
                <div class="service-card">
                    <div class="icon">📄</div>
                    <h3>Clearance</h3>
                    <!-- Full details for desktop -->
                    <p class="desktop-only">Barangay clearance for employment, business, and travel purposes. Processing time: 1-2 business days.</p>
                    <!-- Short version for mobile -->
                    <p class="mobile-only">For employment & business</p>
                </div>
                
                <div class="service-card">
                    <div class="icon">🆔</div>
                    <h3>Barangay ID</h3>
                    <p class="desktop-only">Official identification card for all registered residents. Valid for one year.</p>
                    <p class="mobile-only">Resident identification</p>
                </div>
                
                <div class="service-card">
                    <div class="icon">💼</div>
                    <h3>Business Permit</h3>
                    <p class="desktop-only">Required permit for operating businesses within the barangay. Renewable annually.</p>
                    <p class="mobile-only">Business operations</p>
                </div>
            </div>
        </section>
    </main>
</body>
</html>
```

**Create:** `responsive-visibility.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
}

/* HEADER */
.header {
    background-color: #1a73e8;
    color: white;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
}

/* MOBILE FIRST: Show mobile elements, hide desktop */
.desktop-nav {
    display: none;  /* Hide desktop nav on mobile */
}

.mobile-menu-btn {
    display: block;  /* Show mobile menu button */
    background-color: rgba(255,255,255,0.2);
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 1rem;
    border-radius: 5px;
    cursor: pointer;
}

.desktop-only {
    display: none;  /* Hide desktop content on mobile */
}

.mobile-only {
    display: block;  /* Show mobile content */
}

/* MAIN CONTENT */
.main-content {
    padding: 40px 20px;
}

.hero {
    text-align: center;
    padding: 40px 20px;
    background: linear-gradient(135deg, #1a73e8, #4caf50);
    color: white;
    border-radius: 10px;
    margin-bottom: 40px;
}

.hero h1 {
    font-size: 2rem;
    margin-bottom: 20px;
}

.hero p {
    font-size: 1.1rem;
    line-height: 1.6;
}

.services {
    max-width: 1200px;
    margin: 0 auto;
}

.services h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2rem;
    margin-bottom: 30px;
}

.services-grid {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.service-card {
    background-color: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    text-align: center;
}

.icon {
    font-size: 48px;
    margin-bottom: 15px;
}

.service-card h3 {
    color: #1a73e8;
    margin-bottom: 10px;
}

.service-card p {
    color: #666;
}

/* DESKTOP: 768px+ → Show desktop elements, hide mobile */
@media (min-width: 768px) {
    .desktop-nav {
        display: flex;  /* Show desktop nav */
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
    
    .mobile-menu-btn {
        display: none;  /* Hide mobile menu button */
    }
    
    .desktop-only {
        display: block;  /* Show desktop content */
    }
    
    .mobile-only {
        display: none;  /* Hide mobile content */
    }
    
    .hero h1 {
        font-size: 3rem;
    }
    
    .services-grid {
        flex-direction: row;
    }
    
    .service-card {
        flex: 1;
    }
}
```

**Strategy:**
- Mobile: Show short content, simplified nav
- Desktop: Show detailed content, full nav

---

## Activity 6: Responsive Images

**Goal:** Serve appropriately sized images.

**Create:** `responsive-images.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Images</title>
    <link rel="stylesheet" href="responsive-images.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Photo Gallery</h1>
        
        <section class="demo">
            <h2>1. Max-Width for Scaling</h2>
            <p>Images scale down on smaller screens but never exceed original size.</p>
            <div class="image-box">
                <img src="https://via.placeholder.com/800x400/1a73e8/ffffff?text=Barangay+Hall" 
                     alt="Barangay Hall" 
                     class="responsive-img">
            </div>
        </section>
        
        <section class="demo">
            <h2>2. Background Images</h2>
            <p>Background images that cover their container.</p>
            <div class="bg-image">
                <div class="overlay">
                    <h3>Community Center</h3>
                    <p>Where we gather and celebrate</p>
                </div>
            </div>
        </section>
        
        <section class="demo">
            <h2>3. Image Grid</h2>
            <p>Grid that adapts: 1 column (mobile) → 2 columns (tablet) → 3 columns (desktop)</p>
            <div class="image-grid">
                <div class="grid-item">
                    <img src="https://via.placeholder.com/400x300/4caf50/ffffff?text=Event+1" alt="Event 1">
                    <p>Community Event</p>
                </div>
                <div class="grid-item">
                    <img src="https://via.placeholder.com/400x300/ff9800/ffffff?text=Event+2" alt="Event 2">
                    <p>Sports Festival</p>
                </div>
                <div class="grid-item">
                    <img src="https://via.placeholder.com/400x300/f44336/ffffff?text=Event+3" alt="Event 3">
                    <p>Health Program</p>
                </div>
                <div class="grid-item">
                    <img src="https://via.placeholder.com/400x300/9c27b0/ffffff?text=Event+4" alt="Event 4">
                    <p>Education Drive</p>
                </div>
                <div class="grid-item">
                    <img src="https://via.placeholder.com/400x300/2196f3/ffffff?text=Event+5" alt="Event 5">
                    <p>Clean-up Day</p>
                </div>
                <div class="grid-item">
                    <img src="https://via.placeholder.com/400x300/00bcd4/ffffff?text=Event+6" alt="Event 6">
                    <p>Christmas Party</p>
                </div>
            </div>
        </section>
    </div>
</body>
</html>
```

**Create:** `responsive-images.css`

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
}

/* 1. RESPONSIVE IMAGE - scales down */
.image-box {
    background-color: #f9f9f9;
    padding: 20px;
    border-radius: 10px;
}

.responsive-img {
    max-width: 100%;  /* Never exceed container */
    height: auto;     /* Maintain aspect ratio */
    display: block;
    border-radius: 8px;
}

/* 2. BACKGROUND IMAGE - cover */
.bg-image {
    height: 300px;
    background-image: url('https://via.placeholder.com/1200x400/1a73e8/ffffff?text=Community+Center');
    background-size: cover;
    background-position: center;
    border-radius: 10px;
    position: relative;
    overflow: hidden;
}

.overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
    color: white;
    padding: 30px;
}

.overlay h3 {
    font-size: 2rem;
    margin-bottom: 10px;
}

.overlay p {
    font-size: 1.2rem;
}

/* 3. IMAGE GRID - responsive */
.image-grid {
    display: grid;
    grid-template-columns: 1fr;  /* Mobile: 1 column */
    gap: 20px;
}

.grid-item {
    background-color: #f9f9f9;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    transition: transform 0.3s;
}

.grid-item:hover {
    transform: translateY(-5px);
}

.grid-item img {
    width: 100%;
    height: 200px;
    object-fit: cover;  /* Cover container while maintaining aspect ratio */
    display: block;
}

.grid-item p {
    padding: 15px;
    text-align: center;
    color: #333;
    font-weight: bold;
}

/* TABLET: 600px+ → 2 columns */
@media (min-width: 600px) {
    .image-grid {
        grid-template-columns: repeat(2, 1fr);
    }
    
    .bg-image {
        height: 400px;
    }
}

/* DESKTOP: 900px+ → 3 columns */
@media (min-width: 900px) {
    .image-grid {
        grid-template-columns: repeat(3, 1fr);
    }
    
    .bg-image {
        height: 500px;
    }
}
```

**Image best practices:**
- Use `max-width: 100%` and `height: auto` for responsive images
- Use `object-fit: cover` for consistent sizing
- Use background images for hero sections
- Optimize image file sizes

---

## Activity 7: Complete Responsive Barangay Portal

**Goal:** Build a fully responsive site with all techniques.

**Create:** `complete-responsive-portal.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay San Miguel - Responsive Portal</title>
    <link rel="stylesheet" href="complete-responsive-portal.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="logo">🏛️ Barangay San Miguel</div>
        <nav class="desktop-nav">
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#announcements">Announcements</a>
            <a href="#contact">Contact</a>
        </nav>
        <button class="mobile-menu">☰</button>
    </header>
    
    <!-- Hero -->
    <section class="hero">
        <h1>Serving Our Community</h1>
        <p class="desktop-only">Together we build a stronger, more united barangay for all residents</p>
        <p class="mobile-only">Building a stronger community</p>
        <button class="cta-btn">Apply for Services</button>
    </section>
    
    <!-- Services -->
    <section class="services">
        <h2>Available Services</h2>
        <div class="services-grid">
            <div class="service-card">
                <div class="icon">📄</div>
                <h3>Clearance</h3>
                <p class="desktop-only">Barangay clearance for employment, business, and travel. Processing: 1-2 days.</p>
                <p class="mobile-only">For employment & business</p>
                <div class="price">₱50.00</div>
                <button>Apply</button>
            </div>
            
            <div class="service-card">
                <div class="icon">🆔</div>
                <h3>Barangay ID</h3>
                <p class="desktop-only">Official resident identification. Valid for one year.</p>
                <p class="mobile-only">Resident ID</p>
                <div class="price">₱30.00</div>
                <button>Apply</button>
            </div>
            
            <div class="service-card">
                <div class="icon">💼</div>
                <h3>Business Permit</h3>
                <p class="desktop-only">Required for business operations. Renewable annually.</p>
                <p class="mobile-only">Business operations</p>
                <div class="price">₱500.00</div>
                <button>Apply</button>
            </div>
            
            <div class="service-card">
                <div class="icon">📜</div>
                <h3>Certificate</h3>
                <p class="desktop-only">Various certificates including residency and indigency.</p>
                <p class="mobile-only">Various certificates</p>
                <div class="price">₱30.00</div>
                <button>Apply</button>
            </div>
        </div>
    </section>
    
    <!-- Announcements -->
    <section class="announcements">
        <h2>Latest News</h2>
        <div class="announcements-grid">
            <article class="announcement">
                <span class="badge urgent">URGENT</span>
                <h3>Typhoon Warning</h3>
                <p>Signal #2 in effect. Classes and work suspended.</p>
                <span class="date">Dec 4, 2025</span>
            </article>
            
            <article class="announcement">
                <span class="badge new">NEW</span>
                <h3>Christmas Program</h3>
                <p>Annual celebration on December 20. All welcome!</p>
                <span class="date">Dec 20, 2025</span>
            </article>
            
            <article class="announcement">
                <span class="badge info">INFO</span>
                <h3>Extended Hours</h3>
                <p>Office open until 6PM during holiday season.</p>
                <span class="date">Dec 15, 2025</span>
            </article>
        </div>
    </section>
    
    <!-- Contact -->
    <section class="contact">
        <h2>Get in Touch</h2>
        <div class="contact-grid">
            <div class="contact-item">
                <div class="icon">📞</div>
                <h4>Phone</h4>
                <p>043-123-4567</p>
            </div>
            <div class="contact-item">
                <div class="icon">📧</div>
                <h4>Email</h4>
                <p>info@brgysanmiguel.ph</p>
            </div>
            <div class="contact-item">
                <div class="icon">🏛️</div>
                <h4>Office</h4>
                <p>Barangay Hall</p>
            </div>
            <div class="contact-item">
                <div class="icon">🕒</div>
                <h4>Hours</h4>
                <p>8AM - 5PM</p>
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

**Create:** `complete-responsive-portal.css`

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

/* ========== HEADER ========== */
.header {
    background-color: #1a73e8;
    color: white;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 1.3rem;
    font-weight: bold;
}

/* Mobile: show menu button, hide nav */
.desktop-nav {
    display: none;
}

.mobile-menu {
    display: block;
    background: rgba(255,255,255,0.2);
    border: none;
    color: white;
    padding: 10px 20px;
    font-size: 1.2rem;
    border-radius: 5px;
    cursor: pointer;
}

/* ========== HERO ========== */
.hero {
    text-align: center;
    padding: 60px 20px;
    background: linear-gradient(135deg, #1a73e8, #4caf50);
    color: white;
}

.hero h1 {
    font-size: 2rem;
    margin-bottom: 15px;
}

.hero p {
    font-size: 1.1rem;
    margin-bottom: 25px;
}

.desktop-only {
    display: none;
}

.mobile-only {
    display: block;
}

.cta-btn {
    padding: 12px 30px;
    font-size: 1rem;
    background-color: white;
    color: #1a73e8;
    border: none;
    border-radius: 25px;
    font-weight: bold;
    cursor: pointer;
}

/* ========== SERVICES ========== */
.services {
    padding: 50px 20px;
    background-color: #f5f5f5;
}

.services h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2rem;
    margin-bottom: 30px;
}

.services-grid {
    display: grid;
    grid-template-columns: 1fr;  /* Mobile: 1 column */
    gap: 20px;
    max-width: 1200px;
    margin: 0 auto;
}

.service-card {
    background: white;
    padding: 25px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.icon {
    font-size: 48px;
    margin-bottom: 10px;
}

.service-card h3 {
    color: #333;
    margin-bottom: 10px;
}

.service-card p {
    color: #666;
    margin-bottom: 15px;
    font-size: 0.95rem;
}

.price {
    color: #4caf50;
    font-size: 1.8rem;
    font-weight: bold;
    margin-bottom: 15px;
}

.service-card button {
    width: 100%;
    padding: 10px;
    background-color: #1a73e8;
    color: white;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
}

/* ========== ANNOUNCEMENTS ========== */
.announcements {
    padding: 50px 20px;
}

.announcements h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2rem;
    margin-bottom: 30px;
}

.announcements-grid {
    display: grid;
    grid-template-columns: 1fr;  /* Mobile: 1 column */
    gap: 20px;
    max-width: 1000px;
    margin: 0 auto;
}

.announcement {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    position: relative;
}

.badge {
    display: inline-block;
    padding: 5px 12px;
    border-radius: 15px;
    font-size: 10px;
    font-weight: bold;
    text-transform: uppercase;
    margin-bottom: 10px;
}

.badge.urgent { background: #f44336; color: white; }
.badge.new { background: #4caf50; color: white; }
.badge.info { background: #2196f3; color: white; }

.announcement h3 {
    color: #333;
    margin-bottom: 10px;
}

.announcement p {
    color: #666;
    margin-bottom: 15px;
}

.date {
    color: #999;
    font-size: 0.85rem;
}

/* ========== CONTACT ========== */
.contact {
    padding: 50px 20px;
    background-color: #f5f5f5;
}

.contact h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2rem;
    margin-bottom: 30px;
}

.contact-grid {
    display: grid;
    grid-template-columns: 1fr;  /* Mobile: 1 column */
    gap: 15px;
    max-width: 800px;
    margin: 0 auto;
}

.contact-item {
    background: white;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.contact-item .icon {
    font-size: 36px;
    margin-bottom: 10px;
}

.contact-item h4 {
    color: #1a73e8;
    margin-bottom: 8px;
}

.contact-item p {
    color: #666;
}

/* ========== FOOTER ========== */
.footer {
    background: #333;
    color: white;
    text-align: center;
    padding: 30px;
}

/* ========================================
   TABLET: 600px+
   ======================================== */
@media (min-width: 600px) {
    .hero h1 {
        font-size: 2.5rem;
    }
    
    .services-grid {
        grid-template-columns: repeat(2, 1fr);  /* 2 columns */
    }
    
    .announcements-grid {
        grid-template-columns: repeat(2, 1fr);  /* 2 columns */
    }
    
    .contact-grid {
        grid-template-columns: repeat(2, 1fr);  /* 2 columns */
    }
}

/* ========================================
   DESKTOP: 900px+
   ======================================== */
@media (min-width: 900px) {
    /* Header: show nav, hide menu button */
    .desktop-nav {
        display: flex;
        gap: 20px;
    }
    
    .desktop-nav a {
        color: white;
        text-decoration: none;
        padding: 8px 15px;
        border-radius: 5px;
        transition: background 0.3s;
    }
    
    .desktop-nav a:hover {
        background: rgba(255,255,255,0.2);
    }
    
    .mobile-menu {
        display: none;
    }
    
    /* Hero */
    .hero {
        padding: 100px 20px;
    }
    
    .hero h1 {
        font-size: 3.5rem;
    }
    
    .desktop-only {
        display: block;
    }
    
    .mobile-only {
        display: none;
    }
    
    /* Services: 4 columns */
    .services-grid {
        grid-template-columns: repeat(4, 1fr);
    }
    
    /* Announcements: 3 columns */
    .announcements-grid {
        grid-template-columns: repeat(3, 1fr);
    }
    
    /* Contact: 4 columns */
    .contact-grid {
        grid-template-columns: repeat(4, 1fr);
    }
}
```

**Responsive Features:**
✅ Mobile-first approach  
✅ Flexible grid layouts  
✅ Hide/show content by screen size  
✅ Responsive typography  
✅ Adaptive navigation  
✅ Breakpoints: 600px (tablet), 900px (desktop)

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Media Queries Complete Reference

### Basic Syntax

```css
/* Mobile first: base styles */
body {
    font-size: 16px;
}

/* Tablet and up */
@media (min-width: 768px) {
    body {
        font-size: 18px;
    }
}

/* Desktop and up */
@media (min-width: 1024px) {
    body {
        font-size: 20px;
    }
}
```

---

### Common Breakpoints

```css
/* Mobile: 0-599px (base styles, no media query) */

/* Tablet: 600px+ */
@media (min-width: 600px) { }

/* Desktop: 900px+ */
@media (min-width: 900px) { }

/* Large desktop: 1200px+ */
@media (min-width: 1200px) { }

/* Extra large: 1536px+ */
@media (min-width: 1536px) { }
```

**Alternative (max-width - desktop first):**
```css
/* Desktop base styles */

/* Tablet and down */
@media (max-width: 1023px) { }

/* Mobile and down */
@media (max-width: 767px) { }
```

---

### Viewport Meta Tag

**CRITICAL:** Always include in `<head>`:

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

Without this, mobile browsers zoom out to fit desktop layout!

---

### Mobile-First vs Desktop-First

**Mobile-First (Recommended):**
```css
/* Base: Mobile styles */
.element {
    font-size: 16px;
}

/* Enhance for larger screens */
@media (min-width: 768px) {
    .element {
        font-size: 20px;
    }
}
```

**Desktop-First:**
```css
/* Base: Desktop styles */
.element {
    font-size: 20px;
}

/* Reduce for smaller screens */
@media (max-width: 767px) {
    .element {
        font-size: 16px;
    }
}
```

---

### Media Query Features

```css
/* Width */
@media (min-width: 600px) { }
@media (max-width: 768px) { }
@media (width: 600px) { }  /* Exact width */

/* Height */
@media (min-height: 600px) { }
@media (max-height: 800px) { }

/* Orientation */
@media (orientation: portrait) { }
@media (orientation: landscape) { }

/* Aspect ratio */
@media (aspect-ratio: 16/9) { }
@media (min-aspect-ratio: 16/9) { }

/* Resolution */
@media (min-resolution: 192dpi) { }  /* Retina displays */

/* Hover capability */
@media (hover: hover) { }  /* Has hover (desktop) */
@media (hover: none) { }  /* No hover (touch devices) */

/* Pointer accuracy */
@media (pointer: fine) { }  /* Mouse */
@media (pointer: coarse) { }  /* Touch */
```

---

### Combining Queries

**AND:**
```css
@media (min-width: 600px) and (max-width: 900px) {
    /* Tablet only */
}

@media (min-width: 768px) and (orientation: landscape) {
    /* Tablet landscape */
}
```

**OR:**
```css
@media (max-width: 600px), (orientation: portrait) {
    /* Mobile OR portrait */
}
```

**NOT:**
```css
@media not screen and (min-width: 768px) {
    /* Not desktop screens */
}
```

---

## Common Patterns

### Responsive Grid
```css
.grid {
    display: grid;
    grid-template-columns: 1fr;  /* Mobile: 1 column */
    gap: 20px;
}

@media (min-width: 600px) {
    .grid {
        grid-template-columns: repeat(2, 1fr);  /* Tablet: 2 columns */
    }
}

@media (min-width: 900px) {
    .grid {
        grid-template-columns: repeat(3, 1fr);  /* Desktop: 3 columns */
    }
}
```

### Responsive Navigation
```css
/* Mobile: stacked */
.nav {
    display: flex;
    flex-direction: column;
}

/* Desktop: horizontal */
@media (min-width: 768px) {
    .nav {
        flex-direction: row;
    }
}
```

### Hide/Show Elements
```css
/* Mobile first */
.desktop-only {
    display: none;
}

.mobile-only {
    display: block;
}

@media (min-width: 768px) {
    .desktop-only {
        display: block;
    }
    
    .mobile-only {
        display: none;
    }
}
```

### Responsive Typography
```css
h1 {
    font-size: 2rem;  /* Mobile */
}

@media (min-width: 600px) {
    h1 {
        font-size: 2.5rem;  /* Tablet */
    }
}

@media (min-width: 900px) {
    h1 {
        font-size: 3rem;  /* Desktop */
    }
}
```

### Responsive Images
```css
img {
    max-width: 100%;
    height: auto;
}

/* Background images */
.hero {
    background-image: url('mobile.jpg');
    background-size: cover;
}

@media (min-width: 768px) {
    .hero {
        background-image: url('desktop.jpg');
    }
}
```

---

## Best Practices

1. **Always use viewport meta tag**
2. **Design mobile-first** (easier to enhance than reduce)
3. **Test on real devices** (not just browser resize)
4. **Use relative units** (rem, em, %) when possible
5. **Limit breakpoints** (3-4 is usually enough)
6. **Touch targets: 44x44px minimum** for mobile
7. **Avoid horizontal scroll** on mobile
8. **Test landscape orientation** too

---

## Testing Tips

**Browser DevTools:**
- Chrome: F12 → Toggle device toolbar (Ctrl+Shift+M)
- Test common devices: iPhone, iPad, Android

**Common test sizes:**
- Mobile: 375x667 (iPhone), 360x640 (Android)
- Tablet: 768x1024 (iPad)
- Desktop: 1920x1080

</details>

---

**Congratulations!** You've mastered responsive design with media queries!

**Next Lesson:** Responsive Units (rem, em, vw, vh) for flexible sizing!

