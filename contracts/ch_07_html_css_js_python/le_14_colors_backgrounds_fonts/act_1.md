# Lesson 14 Activities: Colors, Backgrounds, and Fonts

## Bringing Visual Appeal to Your Website

Master color systems, background properties, and typography to create beautiful, professional designs!

---

## Activity 1: Color Formats

**Goal:** Learn all CSS color formats.

**Create:** `color-formats.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Color Formats</title>
    <link rel="stylesheet" href="color-formats.css">
</head>
<body>
    <h1>CSS Color Formats</h1>
    
    <div class="color-box named">Named Color</div>
    <div class="color-box hex">Hexadecimal</div>
    <div class="color-box hex-short">Hex Shorthand</div>
    <div class="color-box rgb">RGB</div>
    <div class="color-box rgba">RGBA (with transparency)</div>
    <div class="color-box hsl">HSL</div>
    <div class="color-box hsla">HSLA (with transparency)</div>
</body>
</html>
```

**Create:** `color-formats.css`

```css
.color-box {
    padding: 30px;
    margin: 10px 0;
    font-size: 20px;
    font-weight: bold;
    text-align: center;
    border-radius: 8px;
}

/* 1. NAMED COLORS */
.named {
    background-color: tomato;
    color: white;
}

/* 2. HEXADECIMAL (#RRGGBB) */
.hex {
    background-color: #4CAF50;  /* Green */
    color: white;
}

/* 3. HEX SHORTHAND (#RGB) */
.hex-short {
    background-color: #09f;  /* Same as #0099ff */
    color: white;
}

/* 4. RGB (Red, Green, Blue) */
.rgb {
    background-color: rgb(255, 152, 0);  /* Orange */
    color: white;
}

/* 5. RGBA (RGB + Alpha channel for transparency) */
.rgba {
    background-color: rgba(33, 150, 243, 0.7);  /* 70% opacity */
    color: white;
}

/* 6. HSL (Hue, Saturation, Lightness) */
.hsl {
    background-color: hsl(280, 100%, 50%);  /* Purple */
    color: white;
}

/* 7. HSLA (HSL + Alpha) */
.hsla {
    background-color: hsla(120, 100%, 50%, 0.6);  /* Semi-transparent green */
    color: white;
}

/* COMPARISON */
body {
    background-color: #f4f4f4;
    color: #333;  /* Dark gray text */
}
```

**Color formats:**
- **Named:** `red`, `blue`, `tomato` (140+ colors)
- **Hex:** `#RRGGBB` (00-FF per channel)
- **RGB:** `rgb(0-255, 0-255, 0-255)`
- **HSL:** `hsl(0-360, 0-100%, 0-100%)`
- **Alpha:** Add `a` for transparency (0-1)

---

## Activity 2: Color Scheme Design

**Goal:** Create a cohesive color palette for barangay website.

**Create:** `color-scheme.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Color Scheme</title>
    <link rel="stylesheet" href="color-scheme.css">
</head>
<body>
    <h1>Barangay Sto. Niño Color Palette</h1>
    
    <div class="palette">
        <div class="color-swatch primary">
            <h3>Primary</h3>
            <p>#4CAF50</p>
            <p>Green</p>
        </div>
        
        <div class="color-swatch secondary">
            <h3>Secondary</h3>
            <p>#2196F3</p>
            <p>Blue</p>
        </div>
        
        <div class="color-swatch accent">
            <h3>Accent</h3>
            <p>#FF9800</p>
            <p>Orange</p>
        </div>
        
        <div class="color-swatch neutral-dark">
            <h3>Dark</h3>
            <p>#333333</p>
            <p>Charcoal</p>
        </div>
        
        <div class="color-swatch neutral-light">
            <h3>Light</h3>
            <p>#F4F4F4</p>
            <p>Light Gray</p>
        </div>
    </div>
    
    <section class="example">
        <h2>Applied Color Scheme</h2>
        <p>This is a paragraph with our primary text color.</p>
        <button class="btn-primary">Primary Button</button>
        <button class="btn-secondary">Secondary Button</button>
        <button class="btn-accent">Accent Button</button>
    </section>
</body>
</html>
```

**Create:** `color-scheme.css`

```css
/* COLOR VARIABLES (CSS Custom Properties) */
:root {
    --primary: #4CAF50;
    --secondary: #2196F3;
    --accent: #FF9800;
    --dark: #333333;
    --light: #F4F4F4;
    --white: #FFFFFF;
    --text: #333333;
    --text-light: #666666;
}

body {
    font-family: Arial, sans-serif;
    background-color: var(--light);
    color: var(--text);
    padding: 20px;
}

/* PALETTE DISPLAY */
.palette {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 20px;
    margin: 30px 0;
}

.color-swatch {
    padding: 40px 20px;
    text-align: center;
    border-radius: 10px;
    color: white;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.primary { background-color: var(--primary); }
.secondary { background-color: var(--secondary); }
.accent { background-color: var(--accent); }
.neutral-dark { background-color: var(--dark); }
.neutral-light { 
    background-color: var(--light); 
    color: var(--dark);
    border: 2px solid var(--dark);
}

.color-swatch h3 {
    margin-bottom: 10px;
    font-size: 18px;
}

.color-swatch p {
    margin: 5px 0;
    font-size: 14px;
}

/* EXAMPLE SECTION */
.example {
    background: white;
    padding: 40px;
    border-radius: 10px;
    margin-top: 40px;
}

.example h2 {
    color: var(--primary);
    margin-bottom: 20px;
}

/* BUTTONS */
button {
    padding: 12px 30px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    margin-right: 10px;
    transition: transform 0.2s, box-shadow 0.2s;
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

.btn-primary {
    background-color: var(--primary);
    color: white;
}

.btn-secondary {
    background-color: var(--secondary);
    color: white;
}

.btn-accent {
    background-color: var(--accent);
    color: white;
}
```

**Color palette principles:**
- **Primary:** Main brand color (60% usage)
- **Secondary:** Supporting color (30% usage)
- **Accent:** Call-to-action (10% usage)
- **Neutrals:** Text and backgrounds

---

## Activity 3: Background Properties

**Goal:** Master all background CSS properties.

**Create:** `backgrounds.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Background Properties</title>
    <link rel="stylesheet" href="backgrounds.css">
</head>
<body>
    <h1>CSS Background Properties</h1>
    
    <div class="box bg-color">
        <h2>Background Color</h2>
        <p>Solid color background</p>
    </div>
    
    <div class="box bg-image">
        <h2>Background Image</h2>
        <p>Image as background</p>
    </div>
    
    <div class="box bg-gradient">
        <h2>Linear Gradient</h2>
        <p>Smooth color transition</p>
    </div>
    
    <div class="box bg-radial">
        <h2>Radial Gradient</h2>
        <p>Circular gradient</p>
    </div>
    
    <div class="box bg-pattern">
        <h2>Background Repeat</h2>
        <p>Tiled pattern</p>
    </div>
    
    <div class="box bg-fixed">
        <h2>Background Fixed</h2>
        <p>Parallax effect (scroll down)</p>
    </div>
</body>
</html>
```

**Create:** `backgrounds.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    padding: 20px;
    background-color: #f4f4f4;
}

h1 {
    text-align: center;
    margin-bottom: 30px;
    color: #333;
}

.box {
    padding: 60px 40px;
    margin: 20px 0;
    border-radius: 10px;
    color: white;
    min-height: 200px;
}

.box h2 {
    margin-bottom: 10px;
}

/* 1. SOLID COLOR */
.bg-color {
    background-color: #4CAF50;
}

/* 2. BACKGROUND IMAGE */
.bg-image {
    background-image: url('barangay-hall.jpg');
    background-size: cover;        /* Fill entire container */
    background-position: center;   /* Center the image */
    background-repeat: no-repeat;  /* Don't tile */
    text-shadow: 2px 2px 4px rgba(0,0,0,0.7);
}

/* 3. LINEAR GRADIENT */
.bg-gradient {
    background: linear-gradient(to right, #667eea, #764ba2);
}

/* Gradient variations */
.bg-gradient-diagonal {
    background: linear-gradient(135deg, #667eea, #764ba2);
}

.bg-gradient-multiple {
    background: linear-gradient(to right, #f12711, #f5af19, #00c6ff);
}

/* 4. RADIAL GRADIENT */
.bg-radial {
    background: radial-gradient(circle, #ff6b6b, #4ecdc4);
}

/* 5. REPEATING PATTERN */
.bg-pattern {
    background-color: #2196F3;
    background-image: repeating-linear-gradient(
        45deg,
        transparent,
        transparent 10px,
        rgba(255,255,255,0.1) 10px,
        rgba(255,255,255,0.1) 20px
    );
}

/* 6. FIXED BACKGROUND (PARALLAX) */
.bg-fixed {
    background-image: url('city-background.jpg');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;  /* Parallax effect */
    background-repeat: no-repeat;
    min-height: 400px;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.7);
}

/* MULTIPLE BACKGROUNDS */
.bg-multiple {
    background-image: 
        url('logo.png'),
        linear-gradient(to bottom, #667eea, #764ba2);
    background-position: 
        top right,
        center;
    background-repeat: 
        no-repeat,
        repeat;
    background-size: 
        100px,
        cover;
}
```

**Background properties:**
- `background-color` - Solid color
- `background-image` - Image or gradient
- `background-size` - `cover`, `contain`, `100px`
- `background-position` - Position image
- `background-repeat` - Tile image
- `background-attachment` - `fixed`, `scroll`

---

## Activity 4: Gradients

**Goal:** Create beautiful gradient backgrounds.

**Create:** `gradients.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>CSS Gradients</title>
    <link rel="stylesheet" href="gradients.css">
</head>
<body>
    <h1>CSS Gradient Examples</h1>
    
    <div class="gradient-grid">
        <div class="gradient g1">
            <h3>Horizontal</h3>
        </div>
        
        <div class="gradient g2">
            <h3>Vertical</h3>
        </div>
        
        <div class="gradient g3">
            <h3>Diagonal</h3>
        </div>
        
        <div class="gradient g4">
            <h3>Multiple Colors</h3>
        </div>
        
        <div class="gradient g5">
            <h3>Radial</h3>
        </div>
        
        <div class="gradient g6">
            <h3>Conic</h3>
        </div>
    </div>
</body>
</html>
```

**Create:** `gradients.css`

```css
body {
    font-family: Arial, sans-serif;
    padding: 20px;
    background: #f4f4f4;
}

h1 {
    text-align: center;
    margin-bottom: 30px;
}

.gradient-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
}

.gradient {
    padding: 80px 40px;
    border-radius: 10px;
    text-align: center;
    color: white;
    font-weight: bold;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.gradient h3 {
    font-size: 24px;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

/* 1. HORIZONTAL GRADIENT */
.g1 {
    background: linear-gradient(to right, #f12711, #f5af19);
}

/* 2. VERTICAL GRADIENT */
.g2 {
    background: linear-gradient(to bottom, #4CAF50, #2196F3);
}

/* 3. DIAGONAL GRADIENT */
.g3 {
    background: linear-gradient(135deg, #667eea, #764ba2);
}

/* 4. MULTIPLE COLOR STOPS */
.g4 {
    background: linear-gradient(
        to right,
        #ff6b6b 0%,
        #feca57 25%,
        #48dbfb 50%,
        #ff9ff3 75%,
        #54a0ff 100%
    );
}

/* 5. RADIAL GRADIENT */
.g5 {
    background: radial-gradient(circle, #fddb92, #d1fdff);
}

/* 6. CONIC GRADIENT */
.g6 {
    background: conic-gradient(
        from 0deg,
        red, orange, yellow, green, blue, indigo, violet, red
    );
}

/* PRACTICAL EXAMPLES */

/* Overlay gradient */
.overlay {
    background: linear-gradient(
        to bottom,
        rgba(0,0,0,0) 0%,
        rgba(0,0,0,0.7) 100%
    );
}

/* Button gradient */
.btn-gradient {
    background: linear-gradient(135deg, #667eea, #764ba2);
    padding: 15px 30px;
    color: white;
    border: none;
    border-radius: 25px;
    font-size: 16px;
    cursor: pointer;
    transition: transform 0.3s;
}

.btn-gradient:hover {
    transform: scale(1.05);
}

/* Philippine flag gradient */
.ph-flag {
    background: linear-gradient(
        to bottom,
        #0038a8 0%,
        #0038a8 50%,
        #ce1126 50%,
        #ce1126 100%
    );
}
```

**Gradient syntax:**
```css
/* Linear */
linear-gradient(direction, color1, color2, ...)

/* Radial */
radial-gradient(shape, color1, color2, ...)

/* Conic */
conic-gradient(from angle, color1, color2, ...)
```

---

## Activity 5: Typography Basics

**Goal:** Master font properties.

**Create:** `typography.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Typography</title>
    <link rel="stylesheet" href="typography.css">
</head>
<body>
    <h1>Barangay Sto. Niño</h1>
    <p class="tagline">Serving the community since 1952</p>
    
    <h2>Font Properties</h2>
    
    <p class="demo font-family">Font Family: Arial, Helvetica, sans-serif</p>
    <p class="demo font-size">Font Size: 20px</p>
    <p class="demo font-weight">Font Weight: bold (700)</p>
    <p class="demo font-style">Font Style: italic</p>
    <p class="demo text-transform">Text Transform: UPPERCASE</p>
    <p class="demo text-decoration">Text Decoration: underline</p>
    <p class="demo letter-spacing">Letter Spacing: 3px</p>
    <p class="demo line-height">Line height: 2.0 - This paragraph has increased line height for better readability and breathing room between lines.</p>
    <p class="demo text-align">Text Align: center</p>
</body>
</html>
```

**Create:** `typography.css`

```css
body {
    font-family: Arial, Helvetica, sans-serif;
    line-height: 1.6;
    padding: 40px;
    background-color: #f4f4f4;
    color: #333;
}

h1 {
    font-size: 48px;
    font-weight: 700;
    color: #4CAF50;
    text-align: center;
    margin-bottom: 10px;
    font-family: Georgia, serif;
}

.tagline {
    text-align: center;
    font-style: italic;
    color: #666;
    margin-bottom: 40px;
}

h2 {
    font-size: 32px;
    color: #0066cc;
    border-bottom: 3px solid #0066cc;
    padding-bottom: 10px;
    margin: 30px 0 20px;
}

.demo {
    background: white;
    padding: 20px;
    margin: 15px 0;
    border-left: 4px solid #4CAF50;
    border-radius: 5px;
}

/* FONT FAMILY */
.font-family {
    font-family: Arial, Helvetica, sans-serif;
}

/* FONT SIZE */
.font-size {
    font-size: 20px;
}

/* FONT WEIGHT */
.font-weight {
    font-weight: bold;  /* or 700 */
}

/* FONT STYLE */
.font-style {
    font-style: italic;
}

/* TEXT TRANSFORM */
.text-transform {
    text-transform: uppercase;
}

/* TEXT DECORATION */
.text-decoration {
    text-decoration: underline;
}

/* LETTER SPACING */
.letter-spacing {
    letter-spacing: 3px;
}

/* LINE HEIGHT */
.line-height {
    line-height: 2.0;
}

/* TEXT ALIGN */
.text-align {
    text-align: center;
}
```

**Font properties:**
- `font-family` - Typeface
- `font-size` - Size (px, em, rem)
- `font-weight` - Thickness (normal, bold, 100-900)
- `font-style` - Normal, italic, oblique
- `text-transform` - uppercase, lowercase, capitalize
- `text-decoration` - underline, line-through, none
- `letter-spacing` - Space between letters
- `line-height` - Space between lines
- `text-align` - left, center, right, justify

---

## Activity 6: Google Fonts

**Goal:** Use custom web fonts.

**Create:** `google-fonts.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Google Fonts</title>
    
    <!-- Import Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&family=Roboto:wght@400;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="google-fonts.css">
</head>
<body>
    <header>
        <h1>Barangay Sto. Niño</h1>
        <p class="subtitle">Transparent, Efficient, Responsive</p>
    </header>
    
    <main>
        <section>
            <h2>About Us</h2>
            <p class="body-text">
                Barangay Sto. Niño has been serving the community since 1952. 
                Our commitment to transparent governance and quality public 
                service remains unwavering.
            </p>
        </section>
        
        <section>
            <h2>Our Services</h2>
            <ul>
                <li>Barangay Clearance</li>
                <li>Barangay ID</li>
                <li>Business Permits</li>
                <li>Community Programs</li>
            </ul>
        </section>
    </main>
</body>
</html>
```

**Create:** `google-fonts.css`

```css
/* FONT ASSIGNMENTS */
:root {
    --font-heading: 'Playfair Display', serif;
    --font-body: 'Poppins', sans-serif;
    --font-accent: 'Roboto', sans-serif;
}

body {
    font-family: var(--font-body);
    line-height: 1.6;
    color: #333;
    padding: 40px;
    background-color: #f9f9f9;
}

/* HEADINGS */
h1, h2 {
    font-family: var(--font-heading);
    color: #4CAF50;
}

h1 {
    font-size: 56px;
    font-weight: 700;
    margin-bottom: 10px;
}

.subtitle {
    font-family: var(--font-accent);
    font-size: 18px;
    font-weight: 300;
    color: #666;
    letter-spacing: 2px;
    text-transform: uppercase;
}

h2 {
    font-size: 36px;
    margin: 30px 0 15px;
    border-bottom: 3px solid #4CAF50;
    padding-bottom: 10px;
}

/* BODY TEXT */
.body-text {
    font-size: 18px;
    font-weight: 400;
    line-height: 1.8;
}

/* LISTS */
ul {
    font-family: var(--font-body);
    font-size: 16px;
    line-height: 2;
}

li {
    margin-bottom: 10px;
}
```

**How to use Google Fonts:**
1. Visit `fonts.google.com`
2. Select fonts
3. Copy `<link>` tag
4. Add to `<head>`
5. Use in CSS: `font-family: 'Font Name', fallback;`

---

## Activity 7: Complete Styled Barangay Website

**Goal:** Apply colors, backgrounds, and fonts together.

**Create:** `final-design.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Sto. Niño - Official Website</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="final-design.css">
</head>
<body>
    <!-- Hero Section -->
    <header class="hero">
        <div class="container">
            <h1>Barangay Sto. Niño</h1>
            <p class="hero-subtitle">Serving the Community Since 1952</p>
            <a href="#services" class="btn btn-hero">Explore Services</a>
        </div>
    </header>
    
    <!-- Services Section -->
    <section class="services" id="services">
        <div class="container">
            <h2 class="section-title">Our Services</h2>
            
            <div class="service-grid">
                <div class="service-card">
                    <div class="icon">📄</div>
                    <h3>Barangay Clearance</h3>
                    <p>Required for employment and transactions. Same-day processing available.</p>
                    <span class="price">₱50.00</span>
                </div>
                
                <div class="service-card featured">
                    <span class="badge">Most Popular</span>
                    <div class="icon">🆔</div>
                    <h3>Barangay ID</h3>
                    <p>Official identification card for all residents.</p>
                    <span class="price">₱30.00</span>
                </div>
                
                <div class="service-card">
                    <div class="icon">💼</div>
                    <h3>Business Permit</h3>
                    <p>Register your business and start operations legally.</p>
                    <span class="price">₱500.00</span>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Announcements Section -->
    <section class="announcements">
        <div class="container">
            <h2 class="section-title">Latest Announcements</h2>
            
            <div class="announcement-grid">
                <article class="announcement-card">
                    <span class="date">Dec 4, 2025</span>
                    <h3>Extended Office Hours</h3>
                    <p>Office will be open until 6 PM throughout December to better serve our constituents.</p>
                </article>
                
                <article class="announcement-card">
                    <span class="date">Nov 28, 2025</span>
                    <h3>Free Medical Mission</h3>
                    <p>Join us this Saturday for free medical checkup at the barangay covered court.</p>
                </article>
            </div>
        </div>
    </section>
    
    <!-- Contact Section -->
    <section class="contact">
        <div class="container">
            <h2 class="section-title light">Get in Touch</h2>
            <div class="contact-grid">
                <div class="contact-info">
                    <h3>Visit Us</h3>
                    <p>P. Burgos Street<br>Batangas City, Batangas</p>
                </div>
                <div class="contact-info">
                    <h3>Call Us</h3>
                    <p>Phone: 043-123-4567<br>Mobile: 0912-345-6789</p>
                </div>
                <div class="contact-info">
                    <h3>Email Us</h3>
                    <p>brgy.stonino@example.com</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 Barangay Sto. Niño. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
```

**Create:** `final-design.css`

```css
/* CSS VARIABLES */
:root {
    --primary: #4CAF50;
    --secondary: #2196F3;
    --accent: #FF9800;
    --dark: #333333;
    --light: #F4F4F4;
    --white: #FFFFFF;
    --gradient-1: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --gradient-2: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    --shadow-lg: 0 10px 30px rgba(0, 0, 0, 0.15);
}

/* RESET & GLOBAL */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    line-height: 1.6;
    color: var(--dark);
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* HERO SECTION */
.hero {
    background: var(--gradient-1);
    color: var(--white);
    text-align: center;
    padding: 100px 20px;
    position: relative;
    overflow: hidden;
}

.hero::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-image: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="40" fill="rgba(255,255,255,0.05)"/></svg>');
    background-size: 100px 100px;
}

.hero h1 {
    font-size: 56px;
    font-weight: 700;
    margin-bottom: 15px;
    position: relative;
    z-index: 1;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.hero-subtitle {
    font-size: 20px;
    font-weight: 300;
    margin-bottom: 30px;
    opacity: 0.95;
    position: relative;
    z-index: 1;
}

.btn {
    display: inline-block;
    padding: 15px 40px;
    text-decoration: none;
    border-radius: 30px;
    font-weight: 600;
    transition: all 0.3s ease;
    cursor: pointer;
}

.btn-hero {
    background-color: var(--white);
    color: #667eea;
    box-shadow: var(--shadow-lg);
    position: relative;
    z-index: 1;
}

.btn-hero:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 40px rgba(0,0,0,0.2);
}

/* SERVICES SECTION */
.services {
    padding: 80px 0;
    background-color: var(--light);
}

.section-title {
    text-align: center;
    font-size: 42px;
    font-weight: 700;
    color: var(--primary);
    margin-bottom: 50px;
    position: relative;
}

.section-title::after {
    content: '';
    display: block;
    width: 80px;
    height: 4px;
    background: var(--gradient-1);
    margin: 15px auto 0;
    border-radius: 2px;
}

.service-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
}

.service-card {
    background: var(--white);
    padding: 40px 30px;
    border-radius: 15px;
    text-align: center;
    box-shadow: var(--shadow);
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.service-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 5px;
    background: var(--gradient-1);
    transform: scaleX(0);
    transition: transform 0.3s ease;
}

.service-card:hover {
    transform: translateY(-10px);
    box-shadow: var(--shadow-lg);
}

.service-card:hover::before {
    transform: scaleX(1);
}

.service-card.featured {
    background: linear-gradient(135deg, #FFF5E1 0%, #FFE4B5 100%);
    border: 2px solid var(--accent);
}

.icon {
    font-size: 64px;
    margin-bottom: 20px;
    display: inline-block;
    animation: float 3s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.service-card h3 {
    font-size: 24px;
    color: var(--dark);
    margin-bottom: 15px;
    font-weight: 600;
}

.service-card p {
    color: #666;
    margin-bottom: 20px;
    line-height: 1.8;
}

.price {
    display: inline-block;
    background: var(--gradient-1);
    color: var(--white);
    padding: 10px 25px;
    border-radius: 25px;
    font-weight: 700;
    font-size: 18px;
}

.badge {
    position: absolute;
    top: 15px;
    right: 15px;
    background: var(--accent);
    color: var(--white);
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
}

/* ANNOUNCEMENTS SECTION */
.announcements {
    padding: 80px 0;
    background: var(--white);
}

.announcement-grid {
    display: grid;
    gap: 25px;
    max-width: 900px;
    margin: 0 auto;
}

.announcement-card {
    background: var(--light);
    padding: 30px;
    border-left: 5px solid var(--primary);
    border-radius: 8px;
    transition: all 0.3s ease;
}

.announcement-card:hover {
    transform: translateX(5px);
    box-shadow: var(--shadow);
}

.date {
    display: inline-block;
    background: var(--primary);
    color: var(--white);
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
    margin-bottom: 15px;
}

.announcement-card h3 {
    font-size: 24px;
    color: var(--dark);
    margin-bottom: 10px;
    font-weight: 600;
}

.announcement-card p {
    color: #666;
    line-height: 1.8;
}

/* CONTACT SECTION */
.contact {
    padding: 80px 0;
    background: var(--gradient-1);
    color: var(--white);
}

.section-title.light {
    color: var(--white);
}

.section-title.light::after {
    background: var(--white);
}

.contact-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
    text-align: center;
    margin-top: 40px;
}

.contact-info h3 {
    font-size: 24px;
    margin-bottom: 15px;
    font-weight: 600;
}

.contact-info p {
    font-size: 16px;
    opacity: 0.95;
    line-height: 1.8;
}

/* FOOTER */
.footer {
    background-color: var(--dark);
    color: var(--white);
    text-align: center;
    padding: 30px 0;
}

.footer p {
    opacity: 0.8;
}

/* SELECTION */
::selection {
    background-color: var(--primary);
    color: var(--white);
}

/* SMOOTH SCROLL */
html {
    scroll-behavior: smooth;
}
```

**Features implemented:**
✅ CSS variables for consistent colors  
✅ Gradient backgrounds  
✅ Google Fonts typography  
✅ Hover effects and transitions  
✅ Box shadows  
✅ Grid layouts  
✅ Responsive design foundation  
✅ Professional color scheme  
✅ Smooth animations  
✅ Modern, clean design

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Color Systems

### Hexadecimal
```css
#RRGGBB  /* Red, Green, Blue (00-FF each) */
#ff0000  /* Red */
#00ff00  /* Green */
#0000ff  /* Blue */
#ffffff  /* White */
#000000  /* Black */
#f00     /* Shorthand for #ff0000 */
```

### RGB/RGBA
```css
rgb(255, 0, 0)           /* Red */
rgba(255, 0, 0, 0.5)     /* Red at 50% opacity */
rgb(0, 128, 255)         /* Custom blue */
```

### HSL/HSLA
```css
hsl(0, 100%, 50%)        /* Red */
hsl(120, 100%, 50%)      /* Green */
hsl(240, 100%, 50%)      /* Blue */
hsla(0, 100%, 50%, 0.5)  /* Red at 50% opacity */
```

**HSL explained:**
- **Hue:** 0-360 (color wheel degrees)
- **Saturation:** 0-100% (color intensity)
- **Lightness:** 0-100% (0=black, 100=white)

## Background Properties

```css
/* Color */
background-color: #4CAF50;

/* Image */
background-image: url('image.jpg');

/* Size */
background-size: cover;     /* Fill container */
background-size: contain;   /* Fit inside container */
background-size: 100px 200px;  /* Exact size */

/* Position */
background-position: center;
background-position: top right;
background-position: 50% 50%;

/* Repeat */
background-repeat: no-repeat;
background-repeat: repeat;
background-repeat: repeat-x;  /* Horizontal only */
background-repeat: repeat-y;  /* Vertical only */

/* Attachment */
background-attachment: scroll;  /* Default */
background-attachment: fixed;   /* Parallax effect */

/* Shorthand */
background: #4CAF50 url('image.jpg') no-repeat center/cover fixed;
```

## Gradients

### Linear Gradient
```css
/* Basic */
background: linear-gradient(to right, red, blue);

/* Diagonal */
background: linear-gradient(45deg, red, blue);
background: linear-gradient(135deg, red, blue);

/* Multiple colors */
background: linear-gradient(to right, red, yellow, green, blue);

/* Color stops */
background: linear-gradient(
    to right,
    red 0%,
    yellow 25%,
    green 75%,
    blue 100%
);
```

### Radial Gradient
```css
/* Basic */
background: radial-gradient(circle, red, blue);

/* Ellipse */
background: radial-gradient(ellipse, red, blue);

/* At position */
background: radial-gradient(circle at top left, red, blue);
```

### Conic Gradient
```css
background: conic-gradient(red, yellow, green, blue, red);
background: conic-gradient(from 90deg, red, yellow, green);
```

## Font Properties

```css
/* Font family */
font-family: Arial, Helvetica, sans-serif;
font-family: 'Times New Roman', serif;
font-family: 'Courier New', monospace;

/* Font size */
font-size: 16px;     /* Absolute */
font-size: 1.5em;    /* Relative to parent */
font-size: 1.5rem;   /* Relative to root */

/* Font weight */
font-weight: normal;  /* 400 */
font-weight: bold;    /* 700 */
font-weight: 100;     /* Thin */
font-weight: 900;     /* Black */

/* Font style */
font-style: normal;
font-style: italic;
font-style: oblique;

/* Text properties */
text-align: left;
text-align: center;
text-align: right;
text-align: justify;

text-decoration: none;
text-decoration: underline;
text-decoration: line-through;
text-decoration: overline;

text-transform: none;
text-transform: uppercase;
text-transform: lowercase;
text-transform: capitalize;

/* Spacing */
letter-spacing: 2px;
word-spacing: 5px;
line-height: 1.6;

/* Font shorthand */
font: italic bold 16px/1.6 Arial, sans-serif;
/* style weight size/line-height family */
```

## Google Fonts

**Steps:**
1. Visit `fonts.google.com`
2. Select fonts (click + icon)
3. Click "View selected families"
4. Copy `<link>` tag
5. Add to HTML `<head>`
6. Use in CSS

**Example:**
```html
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
```

```css
body {
    font-family: 'Poppins', sans-serif;
}
```

## CSS Variables

```css
/* Define variables */
:root {
    --primary: #4CAF50;
    --secondary: #2196F3;
    --font-main: 'Poppins', sans-serif;
    --shadow: 0 4px 6px rgba(0,0,0,0.1);
}

/* Use variables */
h1 {
    color: var(--primary);
    font-family: var(--font-main);
    box-shadow: var(--shadow);
}
```

## Color Palette Best Practices

**60-30-10 Rule:**
- 60% - Primary/dominant color
- 30% - Secondary color
- 10% - Accent color

**Philippine barangay colors:**
```css
:root {
    --primary: #4CAF50;      /* Green (growth, nature) */
    --secondary: #2196F3;    /* Blue (trust, stability) */
    --accent: #FF9800;       /* Orange (energy, warmth) */
    --dark: #333333;         /* Text */
    --light: #F4F4F4;        /* Background */
}
```

</details>

---

**Congratulations!** You've completed Batch 1! You've mastered HTML fundamentals, semantic structure, and CSS basics. You can now create beautiful, accessible, and professional-looking websites!

**Batch 1 Complete (Lessons 5-14):**
✅ Dev tools & editors  
✅ HTML document structure  
✅ Tags, elements, attributes  
✅ Text formatting  
✅ Links and images  
✅ Tables, forms, inputs  
✅ Semantic HTML  
✅ CSS introduction  
✅ Selectors, properties, values  
✅ Colors, backgrounds, fonts

**Next Batch (Lessons 15-24):** CSS layout (box model, display, positioning, flexbox, media queries, responsive design, grid, mobile-first) + JavaScript basics!
