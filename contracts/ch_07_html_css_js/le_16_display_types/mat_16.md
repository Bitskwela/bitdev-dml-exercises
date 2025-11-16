# Lesson 16: CSS Display Types

---

## The Layout Mystery

"Kuya Miguel, bakit yung `<span>` ko hindi tumatanggap ng width at height?" Tian asked, frustrated with his barangay website. "Pero yung `<div>` okay naman?"

Rhea Joy chimed in, "And bakit yung mga `<div>` ko, each one starts on a new line? Gusto ko sila side by side!"

Kuya Miguel smiled. "Ah, that's because of the `display` property. Different HTML elements have different default display values that control how they behave in the layout."

---

## What is the Display Property?

The `display` property controls:
1. Whether an element appears on its own line or inline with text
2. Whether it accepts width and height
3. How it interacts with surrounding elements

```css
element {
    display: block;         /* Takes full width, new line */
    display: inline;        /* Flows with text */
    display: inline-block;  /* Best of both */
    display: none;          /* Hidden */
}
```

---

## Display: Block

**Block elements:**
- Take up the **full width** available (entire row)
- Start on a **new line**
- Accept **width** and **height** properties
- Can have top/bottom/left/right margins and padding

**Default block elements:**
- `<div>`, `<p>`, `<h1>`-`<h6>`
- `<header>`, `<footer>`, `<section>`, `<article>`
- `<ul>`, `<ol>`, `<li>`
- `<form>`, `<table>`

```css
.block-element {
    display: block;
    width: 300px;          /* Works! */
    height: 100px;         /* Works! */
    margin: 20px;          /* Works on all sides */
    background: lightblue;
}
```

**Example:**
```html
<div>First block</div>
<div>Second block</div>
<div>Third block</div>
```

Each `<div>` will be on its own line, stacked vertically.

**Filipino Barangay Example:**
```css
.announcement {
    display: block;        /* Takes full width */
    width: 100%;
    padding: 20px;
    margin-bottom: 15px;
    background: white;
}
```

---

## Display: Inline

**Inline elements:**
- Flow within text (don't start on new line)
- Take up only as much width as needed
- **Do NOT accept** width and height
- Only accept left/right margins (not top/bottom)
- Padding works but may overlap other elements

**Default inline elements:**
- `<span>`, `<a>`, `<strong>`, `<em>`
- `<img>`, `<button>`, `<input>`
- `<code>`, `<label>`

```css
.inline-element {
    display: inline;
    width: 300px;          /* IGNORED! */
    height: 100px;         /* IGNORED! */
    margin: 20px 10px;     /* Only left/right work */
    background: yellow;
}
```

**Example:**
```html
<p>
    This is <span>inline text</span> that flows
    <span>with the paragraph</span> naturally.
</p>
```

The `<span>` elements stay within the text flow.

**Filipino Example:**
```html
<p>
    Para sa <strong>emergency cases</strong>, tumawag sa 
    <a href="tel:911">911</a> o sa barangay hotline.
</p>
```

---

## Display: Inline-Block

**Inline-block combines the best of both:**
- Flow inline (side by side) like inline elements
- Accept width, height, and all margins like block elements

```css
.inline-block-element {
    display: inline-block;
    width: 200px;          /* Works! */
    height: 100px;         /* Works! */
    margin: 20px;          /* Works on all sides! */
    background: lightgreen;
}
```

**Perfect for:**
- Navigation buttons side by side
- Image galleries
- Card layouts (before flexbox/grid)
- Form elements

**Example:**
```html
<div class="card">Card 1</div>
<div class="card">Card 2</div>
<div class="card">Card 3</div>
```

```css
.card {
    display: inline-block;  /* Side by side */
    width: 200px;
    height: 150px;
    margin: 10px;
    padding: 20px;
    background: white;
    border: 1px solid #ddd;
    vertical-align: top;    /* Align tops */
}
```

**Filipino Barangay Example:**
```css
.service-button {
    display: inline-block;
    width: 180px;
    padding: 15px;
    margin: 10px;
    text-align: center;
    background: #1a73e8;
    color: white;
    text-decoration: none;
    border-radius: 5px;
}
```

```html
<a href="#" class="service-button">Barangay Clearance</a>
<a href="#" class="service-button">Residency Certificate</a>
<a href="#" class="service-button">Indigency Certificate</a>
```

Buttons appear side by side instead of stacked!

---

## Display: None

**Completely hides an element:**
- Element doesn't take up any space
- Removed from layout flow
- Still in HTML (can be shown with JavaScript)

```css
.hidden {
    display: none;  /* Completely hidden */
}
```

**Different from `visibility: hidden`:**
```css
/* Takes up space but invisible */
.invisible {
    visibility: hidden;
}

/* Takes NO space, completely removed */
.hidden {
    display: none;
}
```

**Filipino Example:**
```css
/* Hide mobile menu by default */
.mobile-menu {
    display: none;
}

/* Show on small screens */
@media (max-width: 768px) {
    .mobile-menu {
        display: block;
    }
}
```

---

## Comparison Table

| Feature | block | inline | inline-block |
|---------|-------|--------|---------------|
| New line? | Yes | No | No |
| Width/Height? | Yes | **No** | Yes |
| Top/Bottom margin? | Yes | **No** | Yes |
| Left/Right margin? | Yes | Yes | Yes |
| Padding? | Yes (all sides) | Yes (may overlap) | Yes (all sides) |
| Use case | Containers, sections | Text styling, links | Buttons, cards |

---

## Changing Display Types

You can override default display values:

```css
/* Make a link behave like a block */
a.button {
    display: block;       /* Full width, new line */
    width: 200px;
    text-align: center;
}

/* Make a div flow inline */
div.inline-box {
    display: inline;
    /* Won't accept width/height */
}

/* Make spans into blocks */
span.tag {
    display: inline-block;
    padding: 5px 10px;
    margin: 2px;
    background: #e0e0e0;
    border-radius: 3px;
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
    <title>Barangay San Miguel Services</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header class="header">
        <h1>Barangay San Miguel</h1>
        <nav class="nav">
            <a href="#" class="nav-link">Home</a>
            <a href="#" class="nav-link">Services</a>
            <a href="#" class="nav-link">Announcements</a>
            <a href="#" class="nav-link">Contact</a>
        </nav>
    </header>

    <main>
        <section class="services">
            <h2>Available Services</h2>
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

        <section class="announcement">
            <h2>Latest Announcement</h2>
            <p>
                Mayroon pong <strong>barangay assembly</strong> sa 
                <span class="highlight">Sabado, November 18, 2:00 PM</span> 
                sa covered court.
            </p>
        </section>
    </main>
</body>
</html>
```

**CSS:**
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

/* Header - block element */
.header {
    display: block;              /* Default for div */
    background: #1a73e8;
    color: white;
    padding: 20px;
    text-align: center;
}

.header h1 {
    margin-bottom: 15px;
}

/* Navigation - inline-block links */
.nav {
    display: block;
}

.nav-link {
    display: inline-block;       /* Changed from default inline */
    padding: 10px 20px;
    margin: 0 5px;
    color: white;
    text-decoration: none;
    background: rgba(255,255,255,0.2);
    border-radius: 5px;
}

.nav-link:hover {
    background: rgba(255,255,255,0.3);
}

/* Services section */
.services {
    display: block;              /* Default */
    padding: 40px 20px;
    text-align: center;
}

.services h2 {
    margin-bottom: 30px;
}

/* Service cards - inline-block for side-by-side */
.service-card {
    display: inline-block;       /* Side by side! */
    width: 250px;
    margin: 10px;
    padding: 30px 20px;
    background: white;
    border: 2px solid #e0e0e0;
    border-radius: 10px;
    vertical-align: top;         /* Align tops */
}

.service-card h3 {
    color: #1a73e8;
    margin-bottom: 10px;
}

.service-card p {
    color: #666;
    font-size: 14px;
}

/* Announcement section - block */
.announcement {
    display: block;
    background: #fff3cd;
    padding: 30px;
    margin: 20px;
    border-left: 5px solid #ffc107;
}

.announcement h2 {
    margin-bottom: 15px;
    color: #333;
}

.announcement p {
    color: #555;
}

/* Inline text styling */
.announcement strong {
    display: inline;             /* Default, flows with text */
    font-weight: bold;
    color: #1a73e8;
}

/* Highlight span - inline-block for padding */
.highlight {
    display: inline-block;       /* Accepts padding better */
    background: #ffc107;
    padding: 3px 8px;
    border-radius: 3px;
    font-weight: bold;
}

/* Responsive: Stack cards on small screens */
@media (max-width: 768px) {
    .service-card {
        display: block;          /* Changed to block */
        width: 100%;
        margin: 10px 0;
    }
}
```

---

## Vertical Alignment with Inline-Block

When using `inline-block`, elements may not align as expected:

```css
.card {
    display: inline-block;
    vertical-align: top;     /* Options: top, middle, bottom, baseline */
}
```

**vertical-align options:**
- `top` - Align tops of elements
- `middle` - Align middles
- `bottom` - Align bottoms
- `baseline` - Align text baselines (default)

---

## Common Layout Patterns

### Horizontal Navigation
```css
nav a {
    display: inline-block;
    padding: 10px 20px;
    margin: 0 5px;
}
```

### Button Group
```css
.button-group button {
    display: inline-block;
    padding: 8px 16px;
    margin-right: 5px;
}
```

### Image Gallery
```css
.gallery img {
    display: inline-block;
    width: 200px;
    height: 200px;
    margin: 10px;
    object-fit: cover;
}
```

---

## Best Practices

1. **Use block for:**
   - Main containers (header, main, footer)
   - Sections and articles
   - Full-width elements

2. **Use inline for:**
   - Text styling (strong, em)
   - Small icons within text
   - Links within paragraphs

3. **Use inline-block for:**
   - Navigation menus
   - Button groups
   - Card layouts (or use flexbox/grid)
   - Form elements side by side

4. **Use display: none for:**
   - Hidden elements (mobile menus, modals)
   - Elements to show/hide with JavaScript

---

## Common Mistakes

1. **Setting width on inline elements**
   ```css
   /* Won't work */
   span {
       display: inline;
       width: 200px;  /* IGNORED */
   }
   
   /* Fix: Use inline-block */
   span {
       display: inline-block;
       width: 200px;  /* Works! */
   }
   ```

2. **Unwanted spaces between inline-block elements**
   ```html
   <!-- HTML whitespace creates gaps -->
   <div class="card">Card 1</div>
   <div class="card">Card 2</div>
   ```
   
   **Fix:**
   ```css
   .parent {
       font-size: 0;  /* Remove space */
   }
   .card {
       font-size: 16px;  /* Restore size */
   }
   
   /* Better: Use flexbox instead */
   .parent {
       display: flex;
       gap: 10px;
   }
   ```

3. **Forgetting vertical-align**
   ```css
   .card {
       display: inline-block;
       vertical-align: top;  /* Prevent misalignment */
   }
   ```

---

## Summary

Tian summarized:

**Display Types:**
- **block**: Full width, new line, accepts width/height
- **inline**: Flows with text, no width/height
- **inline-block**: Side by side, accepts width/height
- **none**: Completely hidden

**Default Display:**
- Block: `<div>`, `<p>`, `<h1>`, `<section>`
- Inline: `<span>`, `<a>`, `<strong>`, `<em>`

**Changing Display:**
```css
element { display: block | inline | inline-block | none; }
```

Rhea Joy smiled. "Now I can control kung side by side o stacked ang elements!"

---

## What's Next?

In the next lesson, you'll learn about **CSS Positioning**—how to control exactly where elements appear using static, relative, absolute, fixed, and sticky positioning.

---