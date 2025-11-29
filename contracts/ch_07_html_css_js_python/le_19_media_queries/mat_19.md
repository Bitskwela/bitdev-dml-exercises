# Lesson 19: Media Queries and Responsive Breakpoints

---

## The Multi-Device Challenge

"Kuya Miguel, tingnan mo!" Tian showed his phone with frustration. "Ang ganda ng barangay website sa computer, pero sa phone ang laki ng text at ang liit ng buttons. Hindi maganda!"

Rhea Joy nodded. "Oo nga! And yung navigation bar, hindi kasya sa screen. We need different layouts for different devices."

Kuya Miguel smiled. "That's exactly what **media queries** are for. They let you apply different CSS based on screen size, making your website look good on phones, tablets, and desktops."

---

## What Are Media Queries?

**Media queries** are CSS rules that apply styles **only when certain conditions are met**, like screen width, height, or orientation.

**Syntax:**
```css
@media (condition) {
    /* CSS rules that apply when condition is true */
}
```

**Example:**
```css
/* Default: Desktop styles */
.container {
    width: 1200px;
}

/* Smaller screens: Tablet */
@media (max-width: 768px) {
    .container {
        width: 100%;  /* Full width on tablets */
    }
}
```

---

## Basic Media Query Syntax

### Max-Width (Most Common)

Applies styles when screen is **smaller than or equal to** specified width.

```css
@media (max-width: 768px) {
    /* Styles for screens 768px or smaller */
}
```

**Use case:** Desktop-first approach (start with desktop styles, override for smaller screens)

---

### Min-Width

Applies styles when screen is **larger than or equal to** specified width.

```css
@media (min-width: 768px) {
    /* Styles for screens 768px or larger */
}
```

**Use case:** Mobile-first approach (start with mobile styles, add for larger screens)

---

### Combining Conditions

```css
/* Between two sizes */
@media (min-width: 768px) and (max-width: 1024px) {
    /* Styles for tablets only (768px - 1024px) */
}

/* Multiple conditions with OR */
@media (max-width: 768px), (orientation: portrait) {
    /* Styles for small screens OR portrait orientation */
}
```

---

## Common Breakpoints

**Standard device breakpoints:**

```css
/* Extra small devices (phones, portrait) */
@media (max-width: 575px) { }

/* Small devices (phones, landscape / small tablets) */
@media (min-width: 576px) and (max-width: 767px) { }

/* Medium devices (tablets) */
@media (min-width: 768px) and (max-width: 991px) { }

/* Large devices (desktops) */
@media (min-width: 992px) and (max-width: 1199px) { }

/* Extra large devices (large desktops) */
@media (min-width: 1200px) { }
```

**Simplified common breakpoints:**
```css
/* Mobile */
@media (max-width: 767px) { }

/* Tablet */
@media (min-width: 768px) and (max-width: 1023px) { }

/* Desktop */
@media (min-width: 1024px) { }
```

---

## Filipino Barangay Website Example

**HTML:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay San Miguel</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header class="header">
        <h1>Barangay San Miguel</h1>
        <nav class="nav">
            <a href="#">Home</a>
            <a href="#">Services</a>
            <a href="#">Announcements</a>
            <a href="#">Contact</a>
        </nav>
    </header>

    <main class="container">
        <section class="hero">
            <h2>Welcome to Our Community</h2>
            <p>Pagkakaisa, Paglilingkod, Pag-unlad</p>
        </section>

        <section class="services">
            <div class="service-card">
                <h3>Barangay Clearance</h3>
                <p>Processing: 3-5 days</p>
            </div>
            <div class="service-card">
                <h3>Residency Certificate</h3>
                <p>Processing: Same day</p>
            </div>
            <div class="service-card">
                <h3>Indigency Certificate</h3>
                <p>Processing: 1-2 days</p>
            </div>
        </section>
    </main>
</body>
</html>
```

**CSS with Media Queries:**
```css
/* ========== BASE / DESKTOP STYLES ========== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
}

/* Header - Desktop */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 40px;
    background: #1a73e8;
    color: white;
}

.header h1 {
    font-size: 2rem;
}

.nav {
    display: flex;
    gap: 20px;
}

.nav a {
    color: white;
    text-decoration: none;
    padding: 10px 15px;
}

/* Hero Section - Desktop */
.hero {
    text-align: center;
    padding: 100px 20px;
    background: linear-gradient(135deg, #1a73e8, #34a853);
    color: white;
}

.hero h2 {
    font-size: 3rem;
    margin-bottom: 15px;
}

.hero p {
    font-size: 1.5rem;
}

/* Services - Desktop */
.services {
    display: flex;
    gap: 30px;
    padding: 60px 20px;
    max-width: 1200px;
    margin: 0 auto;
}

.service-card {
    flex: 1;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    text-align: center;
}

.service-card h3 {
    font-size: 1.5rem;
    color: #1a73e8;
    margin-bottom: 10px;
}

/* ========== TABLET (768px - 1023px) ========== */
@media (min-width: 768px) and (max-width: 1023px) {
    .header h1 {
        font-size: 1.5rem;  /* Smaller heading */
    }
    
    .nav {
        gap: 10px;  /* Less space between links */
    }
    
    .nav a {
        padding: 8px 12px;  /* Smaller padding */
        font-size: 0.9rem;
    }
    
    .hero h2 {
        font-size: 2rem;  /* Smaller hero text */
    }
    
    .hero p {
        font-size: 1.2rem;
    }
    
    .services {
        gap: 20px;  /* Less gap between cards */
    }
}

/* ========== MOBILE (max 767px) ========== */
@media (max-width: 767px) {
    /* Header - Stack vertically */
    .header {
        flex-direction: column;
        gap: 15px;
        padding: 15px;
    }
    
    .header h1 {
        font-size: 1.3rem;
    }
    
    /* Navigation - Stack vertically */
    .nav {
        flex-direction: column;
        align-items: center;
        gap: 5px;
        width: 100%;
    }
    
    .nav a {
        display: block;
        width: 100%;
        text-align: center;
        padding: 10px;
        font-size: 0.9rem;
    }
    
    /* Hero - Smaller */
    .hero {
        padding: 60px 20px;
    }
    
    .hero h2 {
        font-size: 1.8rem;
    }
    
    .hero p {
        font-size: 1rem;
    }
    
    /* Services - Stack vertically */
    .services {
        flex-direction: column;
        padding: 30px 15px;
    }
    
    .service-card {
        width: 100%;
        margin-bottom: 15px;
    }
}

/* ========== EXTRA SMALL MOBILE (max 480px) ========== */
@media (max-width: 480px) {
    .header h1 {
        font-size: 1.1rem;
    }
    
    .hero h2 {
        font-size: 1.5rem;
    }
    
    .service-card {
        padding: 20px;
    }
    
    .service-card h3 {
        font-size: 1.2rem;
    }
}
```

---

## Media Query Features

### Screen Width/Height

```css
@media (max-width: 768px) { }      /* Maximum width */
@media (min-width: 768px) { }      /* Minimum width */
@media (max-height: 600px) { }     /* Maximum height */
@media (min-height: 800px) { }     /* Minimum height */
```

---

### Orientation

```css
/* Portrait (height > width) */
@media (orientation: portrait) {
    /* Styles for vertical screens */
}

/* Landscape (width > height) */
@media (orientation: landscape) {
    /* Styles for horizontal screens */
}
```

**Example:**
```css
/* Show different message based on orientation */
.portrait-message {
    display: none;
}

.landscape-message {
    display: block;
}

@media (orientation: portrait) {
    .portrait-message {
        display: block;
    }
    
    .landscape-message {
        display: none;
    }
}
```

---

### Resolution/Pixel Density

```css
/* High-resolution displays (Retina, etc.) */
@media (-webkit-min-device-pixel-ratio: 2),
       (min-resolution: 192dpi) {
    /* Use higher quality images */
    .logo {
        background-image: url('logo@2x.png');
    }
}
```

---

### Dark Mode

```css
/* Light mode (default) */
body {
    background: white;
    color: black;
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
    body {
        background: #1a1a1a;
        color: white;
    }
    
    .card {
        background: #2a2a2a;
        border-color: #444;
    }
}
```

---

## Best Practices

### 1. Mobile-First Approach (Recommended)

Start with mobile styles, add complexity for larger screens.

```css
/* Base: Mobile styles (no media query needed) */
.nav {
    flex-direction: column;
}

/* Tablet and up */
@media (min-width: 768px) {
    .nav {
        flex-direction: row;
    }
}

/* Desktop */
@media (min-width: 1024px) {
    .nav {
        gap: 30px;
        font-size: 1.1rem;
    }
}
```

**Why mobile-first?**
- Simpler mobile styles as base
- Progressive enhancement
- Better performance on mobile
- Easier to maintain

---

### 2. Use Logical Breakpoints

Base breakpoints on content, not specific devices.

```css
/* Don't do this */
@media (max-width: 375px) { /* iPhone 8 */ }
@media (max-width: 414px) { /* iPhone Plus */ }
@media (max-width: 768px) { /* iPad */ }

/* Do this instead */
@media (max-width: 767px) { /* Small screens */ }
@media (min-width: 768px) { /* Medium+ screens */ }
@media (min-width: 1024px) { /* Large screens */ }
```

---

### 3. Test on Real Devices

**Chrome DevTools:**
1. Open DevTools (F12)
2. Click "Toggle device toolbar" (Ctrl+Shift+M)
3. Select device or custom size
4. Test different screen sizes

**Real devices:**
- Test on actual phones/tablets
- Check touch interactions
- Verify readability

---

### 4. Don't Forget the Viewport Meta Tag

**ALWAYS include in `<head>`:**
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

**What it does:**
- `width=device-width`: Match screen width
- `initial-scale=1.0`: No zoom by default
- Without this, mobile browsers may display desktop version!

---

## Common Responsive Patterns

### Stack on Mobile, Row on Desktop

```css
.container {
    display: flex;
    flex-direction: column;  /* Mobile: stacked */
}

@media (min-width: 768px) {
    .container {
        flex-direction: row;  /* Desktop: side by side */
    }
}
```

---

### Hide/Show Elements

```css
/* Hide mobile menu on desktop */
.mobile-menu {
    display: block;
}

.desktop-menu {
    display: none;
}

@media (min-width: 768px) {
    .mobile-menu {
        display: none;
    }
    
    .desktop-menu {
        display: flex;
    }
}
```

---

### Responsive Images

```css
img {
    max-width: 100%;   /* Never exceed container width */
    height: auto;      /* Maintain aspect ratio */
}

/* Different images for different screens */
.hero {
    background-image: url('hero-mobile.jpg');
}

@media (min-width: 768px) {
    .hero {
        background-image: url('hero-desktop.jpg');
    }
}
```

---

## Summary

Tian summarized:

**Media Query Syntax:**
```css
@media (condition) {
    /* CSS rules */
}
```

**Common Conditions:**
- `max-width`: Smaller than or equal
- `min-width`: Larger than or equal
- `orientation`: Portrait or landscape
- `prefers-color-scheme`: Dark or light mode

**Standard Breakpoints:**
- Mobile: `max-width: 767px`
- Tablet: `min-width: 768px` and `max-width: 1023px`
- Desktop: `min-width: 1024px`

**Best Practices:**
- Mobile-first approach
- Always include viewport meta tag
- Test on real devices
- Use logical breakpoints

Rhea Joy smiled. "Now our barangay website looks great on all devices!"

---

## What's Next?

In the next lesson, you'll learn about **Responsive CSS Units**—using `rem`, `em`, `vh`, `vw`, and percentages to create truly flexible layouts.

---

---

## Closing Story

Tian opened the browser's DevTools and toggled device emulation. Desktop. Tablet. Phone. The barangay portal adapted perfectly to each screen size.

"Media queries are magic," Tian whispered.

"Not magiclogic," Kuya Miguel corrected. "You're telling the browser: 'If the screen is this size, apply these styles.' Responsive design is just conditional CSS."

Tian tested on a real phone. Everything worked. The navigation collapsed into a hamburger menu. Images scaled down. Text remained readable. The portal was officially mobile-friendly.

_Next up: CSS Unitspx, %, em, rem, vh, vw!_