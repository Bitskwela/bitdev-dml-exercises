# Lesson 14: Colors, Backgrounds, and Fonts in CSS

---

## Making the Barangay Website Beautiful

"Okay, so alam ko na how to select elements," Tian said, looking at their barangay website. "But ang boring pa rin ng colors. Everything is just black text on white background."

Rhea Joy nodded enthusiastically. "Exactly! We need to add colors, nice backgrounds, and better fonts. Parang yung mga professional websites na makikita sa internet."

Kuya Miguel, who was setting up a projector for their presentation, overheard them. "Perfect timing! Today we'll learn about CSS colors, backgrounds, and fonts—the tools that make websites visually appealing."

---

## CSS Colors

### Ways to Specify Colors

In CSS, there are multiple ways to define colors:

#### 1. Color Names

CSS recognizes 140 standard color names.

```css
h1 {
    color: red;
    background-color: lightblue;
}
```

**Common color names:**
- `red`, `blue`, `green`, `yellow`, `orange`, `purple`
- `white`, `black`, `gray`, `lightgray`, `darkgray`
- `pink`, `brown`, `cyan`, `magenta`

**Filipino Example:**
```css
.announcement {
    color: darkred;
    background-color: lightyellow;
}
```

---

#### 2. Hexadecimal Colors (#RRGGBB)

Hex colors use 6 digits: 2 for red, 2 for green, 2 for blue. Each pair ranges from 00 to FF (0-255 in decimal).

```css
.header {
    color: #ffffff;        /* White */
    background-color: #1a73e8;  /* Blue */
}
```

**Common hex colors:**
- `#ffffff` = White
- `#000000` = Black
- `#ff0000` = Red
- `#00ff00` = Green
- `#0000ff` = Blue
- `#ffc107` = Orange/Amber

**Shorthand:** If each pair is the same, you can use 3 digits:
```css
color: #f00;  /* Same as #ff0000 (red) */
color: #0f0;  /* Same as #00ff00 (green) */
color: #fff;  /* Same as #ffffff (white) */
```

---

#### 3. RGB Colors

RGB specifies colors using Red, Green, Blue values from 0-255.

```css
.button {
    background-color: rgb(255, 0, 0);     /* Red */
    color: rgb(255, 255, 255);            /* White */
}
```

**Examples:**
```css
color: rgb(255, 0, 0);     /* Pure red */
color: rgb(0, 255, 0);     /* Pure green */
color: rgb(0, 0, 255);     /* Pure blue */
color: rgb(255, 255, 0);   /* Yellow (red + green) */
color: rgb(128, 128, 128); /* Gray */
```

---

#### 4. RGBA Colors (with Transparency)

RGBA adds an **alpha channel** for transparency (0.0 = fully transparent, 1.0 = fully opaque).

```css
.overlay {
    background-color: rgba(0, 0, 0, 0.5);  /* 50% transparent black */
}

.highlight {
    background-color: rgba(255, 255, 0, 0.3);  /* 30% transparent yellow */
}
```

**Filipino Barangay Example:**
```css
.emergency-banner {
    background-color: rgba(220, 53, 69, 0.1);  /* Light red background */
    border-left: 4px solid rgb(220, 53, 69);   /* Solid red border */
    padding: 15px;
}
```

---

### Choosing Color Schemes

**Filipino branding example for barangay website:**
```css
:root {
    --primary-color: #1a73e8;      /* Blue - trust, stability */
    --secondary-color: #34a853;    /* Green - growth, health */
    --accent-color: #ffc107;       /* Amber - attention, energy */
    --danger-color: #dc3545;       /* Red - emergency, warnings */
    --text-dark: #333333;
    --text-light: #666666;
    --background: #f5f5f5;
}
```

---

## CSS Backgrounds

### Background Color

```css
body {
    background-color: #f5f5f5;  /* Light gray */
}

.card {
    background-color: white;
}
```

---

### Background Images

```css
.hero {
    background-image: url('images/barangay-hall.jpg');
    background-size: cover;        /* Cover entire area */
    background-position: center;   /* Center the image */
    background-repeat: no-repeat;  /* Don't repeat image */
}
```

**Background properties:**

1. **background-size:**
   - `cover` - Scale to cover entire area (may crop)
   - `contain` - Scale to fit inside area (may show gaps)
   - `100% 100%` - Stretch to fill
   - `200px 150px` - Specific dimensions

2. **background-position:**
   - `center`, `top`, `bottom`, `left`, `right`
   - `top left`, `center right`, etc.
   - `50% 50%` (percentages)

3. **background-repeat:**
   - `no-repeat` - Show once
   - `repeat` - Tile horizontally and vertically
   - `repeat-x` - Tile horizontally only
   - `repeat-y` - Tile vertically only

**Filipino Example:**
```css
.barangay-header {
    background-image: url('images/manila-skyline.jpg');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;  /* Parallax effect */
    color: white;
    padding: 100px 20px;
    text-align: center;
}
```

---

### Background Shorthand

You can combine all background properties in one line:

```css
.banner {
    background: #1a73e8 url('pattern.png') no-repeat center / cover;
    /* color, image, repeat, position / size */
}
```

---

### Multiple Backgrounds

```css
.hero {
    background: 
        linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)),
        url('hero-image.jpg') center/cover no-repeat;
}
```

This creates a dark overlay on top of an image.

---

## CSS Fonts

### Font Family

The `font-family` property specifies which font to use.

```css
body {
    font-family: Arial, Helvetica, sans-serif;
}

h1 {
    font-family: 'Georgia', serif;
}
```

**Why multiple fonts?**

The browser tries each font in order. If the first isn't available, it uses the second, and so on.

**Font categories:**
1. **serif** - Fonts with decorative strokes (e.g., Times New Roman, Georgia)
2. **sans-serif** - Clean fonts without strokes (e.g., Arial, Helvetica)
3. **monospace** - Fixed-width fonts (e.g., Courier, Consolas)
4. **cursive** - Handwriting-style fonts
5. **fantasy** - Decorative fonts

**Filipino Barangay Example:**
```css
/* Headings - formal serif font */
h1, h2, h3 {
    font-family: 'Georgia', 'Times New Roman', serif;
}

/* Body text - clean sans-serif */
body {
    font-family: Arial, Helvetica, sans-serif;
}

/* Code or technical text - monospace */
code {
    font-family: 'Courier New', Consolas, monospace;
}
```

---

### Web Fonts (Google Fonts)

You can use fonts from Google Fonts for free!

**Step 1:** Add this in your HTML `<head>`:
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
```

**Step 2:** Use it in your CSS:
```css
body {
    font-family: 'Roboto', sans-serif;
}
```

**Popular Google Fonts:**
- Roboto (modern, clean)
- Open Sans (friendly, readable)
- Lato (professional)
- Montserrat (bold, stylish)
- Poppins (geometric, modern)

---

### Font Size

```css
h1 {
    font-size: 32px;      /* Pixels */
    font-size: 2em;       /* Relative to parent */
    font-size: 2rem;      /* Relative to root */
    font-size: 150%;      /* Percentage of parent */
}
```

**Best practice:** Use `rem` for consistent sizing.

```css
html {
    font-size: 16px;  /* Base size */
}

h1 { font-size: 2rem; }    /* 32px */
h2 { font-size: 1.5rem; }  /* 24px */
p { font-size: 1rem; }     /* 16px */
small { font-size: 0.875rem; } /* 14px */
```

---

### Font Weight

Controls how bold or light the text is.

```css
p {
    font-weight: normal;   /* Same as 400 */
    font-weight: bold;     /* Same as 700 */
    font-weight: 300;      /* Light */
    font-weight: 600;      /* Semi-bold */
    font-weight: 900;      /* Extra bold */
}
```

**Common weights:**
- 100-300: Light
- 400: Normal (default)
- 500-600: Medium/Semi-bold
- 700: Bold
- 800-900: Extra bold/Black

---

### Font Style

```css
em {
    font-style: italic;
}

.normal-text {
    font-style: normal;  /* Remove italic */
}
```

---

### Text Properties

```css
p {
    text-align: center;         /* left, right, center, justify */
    text-decoration: underline; /* none, underline, line-through, overline */
    text-transform: uppercase;  /* uppercase, lowercase, capitalize */
    line-height: 1.6;          /* Space between lines */
    letter-spacing: 2px;       /* Space between letters */
    word-spacing: 5px;         /* Space between words */
}
```

**Filipino Example:**
```css
.barangay-name {
    text-transform: uppercase;    /* "barangay san miguel" → "BARANGAY SAN MIGUEL" */
    letter-spacing: 3px;          /* Spaced out for emphasis */
    font-weight: 700;
}

.tagline {
    font-style: italic;
    text-align: center;
    color: #666;
}
```

---

## Complete Barangay Website Example

**HTML:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay San Miguel</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header class="hero">
        <h1 class="barangay-name">Barangay San Miguel</h1>
        <p class="tagline">Pagkakaisa, Paglilingkod, Pag-unlad</p>
    </header>

    <main>
        <section class="announcement emergency">
            <h2>Emergency Alert</h2>
            <p>Suspended ang classes dahil sa typhoon signal #2.</p>
        </section>

        <section class="announcement">
            <h2>Community Assembly</h2>
            <p>Mayroon pong barangay assembly sa Sabado, 2:00 PM sa covered court.</p>
        </section>

        <section class="services">
            <h2>Available Services</h2>
            <div class="service-card">
                <h3>Barangay Clearance</h3>
                <p>Processing time: 3-5 business days</p>
            </div>
            <div class="service-card">
                <h3>Certificate of Residency</h3>
                <p>Processing time: Same day</p>
            </div>
        </section>
    </main>
</body>
</html>
```

**CSS:**
```css
/* Reset and base styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background-color: #f5f5f5;
}

/* Hero section */
.hero {
    background: linear-gradient(rgba(26, 115, 232, 0.8), rgba(26, 115, 232, 0.9)),
                url('images/barangay-hall.jpg') center/cover no-repeat;
    color: white;
    text-align: center;
    padding: 100px 20px;
}

.barangay-name {
    font-size: 3rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 4px;
    margin-bottom: 10px;
}

.tagline {
    font-size: 1.2rem;
    font-style: italic;
    font-weight: 400;
    opacity: 0.9;
}

/* Announcement styles */
.announcement {
    background-color: white;
    margin: 20px auto;
    padding: 25px;
    max-width: 800px;
    border-left: 5px solid #ffc107;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.announcement.emergency {
    background-color: rgba(220, 53, 69, 0.05);
    border-left-color: #dc3545;
}

.announcement h2 {
    color: #1a73e8;
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 10px;
}

.announcement.emergency h2 {
    color: #dc3545;
}

.announcement p {
    color: #555;
    font-size: 1rem;
    line-height: 1.8;
}

/* Services section */
.services {
    max-width: 800px;
    margin: 40px auto;
    padding: 0 20px;
}

.services h2 {
    text-align: center;
    color: #1a73e8;
    font-size: 2rem;
    margin-bottom: 30px;
}

.service-card {
    background-color: white;
    padding: 20px;
    margin-bottom: 15px;
    border-radius: 8px;
    border: 1px solid #e0e0e0;
    transition: transform 0.2s;
}

.service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

.service-card h3 {
    color: #34a853;
    font-size: 1.3rem;
    font-weight: 600;
    margin-bottom: 8px;
}

.service-card p {
    color: #666;
    font-size: 0.9rem;
}
```

---

## Best Practices

1. **Use consistent color schemes**
   ```css
   /* Define colors as variables (CSS custom properties) */
   :root {
       --primary: #1a73e8;
       --secondary: #34a853;
       --text: #333;
   }
   
   .button {
       background-color: var(--primary);
       color: white;
   }
   ```

2. **Ensure good contrast for readability**
   - Dark text on light backgrounds
   - Light text on dark backgrounds
   - Avoid low contrast (e.g., light gray on white)

3. **Limit your font families**
   - Use 2-3 fonts maximum
   - One for headings, one for body text

4. **Use web-safe fonts or Google Fonts**
   - Don't rely on fonts that users might not have

5. **Set a base font size**
   ```css
   html {
       font-size: 16px;
   }
   ```

---

## Common Mistakes

1. **Too many colors**
   - Stick to 3-5 main colors

2. **Poor contrast**
   ```css
   /* Bad - hard to read */
   .text { color: #ccc; background: white; }
   
   /* Good - high contrast */
   .text { color: #333; background: white; }
   ```

3. **Forgetting fallback fonts**
   ```css
   /* Bad */
   font-family: 'CustomFont';
   
   /* Good */
   font-family: 'CustomFont', Arial, sans-serif;
   ```

4. **Using too many font sizes**
   - Create a consistent scale (e.g., 12px, 14px, 16px, 20px, 24px, 32px)

---

## Summary

Rhea Joy updated her notes:

**Colors:**
- Names: `red`, `blue`
- Hex: `#ff0000`, `#1a73e8`
- RGB: `rgb(255, 0, 0)`
- RGBA: `rgba(255, 0, 0, 0.5)`

**Backgrounds:**
- `background-color`, `background-image`
- `background-size`, `background-position`
- `background-repeat`

**Fonts:**
- `font-family`, `font-size`, `font-weight`
- `text-align`, `text-decoration`, `text-transform`
- Google Fonts for custom typography

Tian smiled. "Now our barangay website looks professional and colorful!"

---

## What's Next?

In the next lesson, you'll learn about the **CSS Box Model**—how padding, borders, and margins work to control spacing and layout in your designs.

---

---

## Closing Story

Tian designed a color scheme inspired by Filipino culture: maroon, gold, white. Background gradients. Custom fonts from Google Fonts. Shadow effects for depth.

The barangay portal looked beautiful now. Not just functional. Not just structured. **Beautiful**.

"You're thinking like a designer," Kuya Miguel noted. "That's rare for developers. Most focus only on code. You're balancing aesthetics with functionality."

Tian zoomed out and admired the page. This was no longer a beginner's project. This was legitimate web design.

_Next up: Box Modelunderstanding spacing!_