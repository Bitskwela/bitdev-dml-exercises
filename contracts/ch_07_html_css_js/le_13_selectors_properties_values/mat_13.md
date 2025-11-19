# Lesson 13: CSS Selectors, Properties, and Values

---

## The Barangay Website Styling Challenge

Tian sat beside Rhea Joy in their computer laboratory, both staring at their plain HTML barangay website. The structure was perfect—headers, paragraphs, lists, and images were all properly organized—but it looked boring.

"Ang plain naman ng website natin," Rhea Joy sighed. "Parang newspaper lang from the 1900s."

Tian nodded. "Yeah, pero at least na-link na natin yung CSS file last lesson. Now we need to learn kung paano actually mag-style using CSS."

Kuya Miguel, who was helping set up the laboratory's projector, overheard them. "Ah, perfect timing! Today you'll learn about CSS selectors, properties, and values—the three building blocks of styling any website."

---

## What Are CSS Selectors?

A **CSS selector** is a pattern that tells the browser which HTML elements you want to style.

Think of it like this: If your HTML elements are houses in a barangay, CSS selectors are the addresses that tell the delivery truck (browser) which houses should receive the styling package.

### Basic Syntax Review

```css
selector {
    property: value;
    property: value;
}
```

- **Selector**: Which element(s) to style
- **Property**: What aspect to change (color, size, spacing, etc.)
- **Value**: How to change it

---

## Types of CSS Selectors

### 1. Element Selector (Type Selector)

Targets all elements of a specific HTML tag.

```css
p {
    color: blue;
    font-size: 16px;
}
```

This selects **all** `<p>` elements in your HTML and makes their text blue with 16px font size.

**Filipino Example:**
```css
h1 {
    color: #1a73e8;
    text-align: center;
}

h2 {
    color: #34a853;
    border-bottom: 2px solid #34a853;
}
```

This styles all `<h1>` headings with blue centered text, and all `<h2>` headings with green text and a green bottom border.

---

### 2. Class Selector

Targets elements with a specific class attribute. Class selectors start with a dot (`.`).

**HTML:**
```html
<p class="highlight">This paragraph is highlighted.</p>
<p>This paragraph is normal.</p>
<p class="highlight">This is also highlighted.</p>
```

**CSS:**
```css
.highlight {
    background-color: yellow;
    font-weight: bold;
}
```

Only the paragraphs with `class="highlight"` will have a yellow background and bold text.

**Filipino Barangay Example:**
```html
<div class="announcement">
    <h3>Barangay Assembly</h3>
    <p>Mayroon pong barangay assembly sa Sabado, 2:00 PM.</p>
</div>

<div class="announcement">
    <h3>Free Medical Checkup</h3>
    <p>Libreng medical checkup para sa mga senior citizens.</p>
</div>
```

```css
.announcement {
    background-color: #fff3cd;
    border-left: 4px solid #ffc107;
    padding: 15px;
    margin-bottom: 10px;
}
```

All announcements will have a light yellow background with an orange left border.

**Important**: One element can have multiple classes:
```html
<p class="announcement urgent">Emergency meeting tonight!</p>
```

---

### 3. ID Selector

Targets a single element with a specific ID attribute. ID selectors start with a hash (`#`).

**HTML:**
```html
<div id="header">Welcome to Barangay San Miguel</div>
```

**CSS:**
```css
#header {
    background-color: #1a73e8;
    color: white;
    padding: 20px;
    text-align: center;
}
```

**Key Rules:**
- Each ID must be **unique** on a page (only use once)
- IDs have **higher priority** than classes in CSS
- Use IDs for unique elements like headers, navigation, or specific sections

---

### 4. Descendant Selector (Combinator)

Targets elements that are inside other elements. Use a space between selectors.

```css
div p {
    color: gray;
}
```

This selects all `<p>` elements that are inside a `<div>`, no matter how deep.

**Filipino Example:**
```html
<div class="services">
    <h2>Barangay Services</h2>
    <p>We offer various services to our residents.</p>
    <ul>
        <li>Barangay Clearance</li>
        <li>Certificate of Residency</li>
    </ul>
</div>
```

```css
.services p {
    font-size: 14px;
    color: #555;
}

.services li {
    padding: 5px 0;
    border-bottom: 1px solid #eee;
}
```

Only paragraphs and list items **inside** the element with class "services" will be affected.

---

### 5. Multiple Selectors (Grouping)

Apply the same styles to multiple selectors by separating them with commas.

```css
h1, h2, h3 {
    font-family: Arial, sans-serif;
    color: #333;
}
```

This applies the same font and color to all `<h1>`, `<h2>`, and `<h3>` elements.

---

## Common CSS Properties and Values

### Text Properties

```css
p {
    color: #333;              /* Text color */
    font-size: 16px;          /* Size of text */
    font-family: Arial;       /* Font type */
    font-weight: bold;        /* Boldness (normal, bold, 100-900) */
    text-align: center;       /* Alignment (left, center, right, justify) */
    text-decoration: underline; /* Underline, overline, line-through, none */
    line-height: 1.5;         /* Space between lines */
    letter-spacing: 2px;      /* Space between letters */
}
```

---

### Color Values

There are multiple ways to specify colors in CSS:

1. **Color Names**: `red`, `blue`, `green`, `yellow`
2. **Hexadecimal**: `#ff0000` (red), `#0000ff` (blue)
3. **RGB**: `rgb(255, 0, 0)` (red)
4. **RGBA**: `rgba(255, 0, 0, 0.5)` (semi-transparent red)

```css
.header {
    background-color: #1a73e8;  /* Hex blue */
    color: white;               /* Color name */
}

.alert {
    background-color: rgba(255, 0, 0, 0.1);  /* Light transparent red */
    border: 1px solid rgb(255, 0, 0);        /* Solid red border */
}
```

---

### Size Units

1. **px (pixels)**: Fixed size
   ```css
   font-size: 16px;
   ```

2. **em**: Relative to parent element's font size
   ```css
   font-size: 1.5em;  /* 1.5 times the parent's size */
   ```

3. **rem**: Relative to root (html) element's font size
   ```css
   font-size: 1.5rem;
   ```

4. **% (percentage)**: Relative to parent element
   ```css
   width: 50%;  /* 50% of parent's width */
   ```

---

## Complete Barangay Website Example

**HTML (index.html):**
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
    <div id="header">
        <h1>Barangay San Miguel</h1>
        <p class="tagline">Pagkakaisa, Paglilingkod, Pag-unlad</p>
    </div>

    <div class="announcement urgent">
        <h2>Emergency Announcement</h2>
        <p>Suspended ang classes dahil sa malakas na ulan.</p>
    </div>

    <div class="announcement">
        <h2>Barangay Assembly</h2>
        <p>Mayroon pong regular assembly sa Sabado, 2:00 PM sa covered court.</p>
    </div>

    <div class="services">
        <h2>Available Services</h2>
        <ul>
            <li>Barangay Clearance</li>
            <li>Certificate of Residency</li>
            <li>Certificate of Indigency</li>
        </ul>
    </div>
</body>
</html>
```

**CSS (style.css):**
```css
/* Element selector - applies to all body content */
body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
}

/* ID selector - unique header */
#header {
    background-color: #1a73e8;
    color: white;
    text-align: center;
    padding: 30px;
}

#header h1 {
    margin: 0;
    font-size: 2.5em;
}

/* Class selector */
.tagline {
    font-style: italic;
    margin-top: 10px;
}

/* Class selector for all announcements */
.announcement {
    background-color: white;
    margin: 20px;
    padding: 20px;
    border-left: 4px solid #ffc107;
}

/* Class selector for urgent announcements */
.announcement.urgent {
    border-left-color: #dc3545;
    background-color: #fff5f5;
}

/* Descendant selector - h2 inside announcements */
.announcement h2 {
    color: #333;
    margin-top: 0;
}

/* Multiple selectors - style all headings */
h1, h2, h3 {
    font-family: 'Georgia', serif;
}

/* Class selector for services section */
.services {
    background-color: white;
    margin: 20px;
    padding: 20px;
}

.services ul {
    list-style-type: none;
    padding-left: 0;
}

.services li {
    padding: 10px;
    border-bottom: 1px solid #eee;
}
```

---

## Pseudo-Classes (Bonus)

Pseudo-classes select elements based on their state or position.

```css
/* When hovering over a link */
a:hover {
    color: red;
    text-decoration: underline;
}

/* First child of a parent */
li:first-child {
    font-weight: bold;
}

/* When an input is focused */
input:focus {
    border-color: blue;
    outline: none;
}
```

---

## Selector Priority (Specificity)

When multiple CSS rules target the same element, specificity determines which style wins:

1. **Inline styles** (highest priority): `<p style="color: red;">`
2. **IDs**: `#header { color: blue; }`
3. **Classes, attributes, pseudo-classes**: `.highlight { color: green; }`
4. **Elements**: `p { color: black; }`
5. **Browser defaults** (lowest priority)

**Example:**
```html
<p id="intro" class="highlight">Hello</p>
```

```css
p { color: black; }              /* Priority: 1 */
.highlight { color: green; }     /* Priority: 10 */
#intro { color: blue; }          /* Priority: 100 */
```

The text will be **blue** because ID selectors have the highest specificity.

---

## Best Practices

1. **Use classes for reusable styles**
   ```css
   .btn { padding: 10px 20px; background: blue; }
   ```

2. **Use IDs sparingly** (only for unique elements)
   ```css
   #main-nav { /* unique navigation */ }
   ```

3. **Keep selectors simple** (avoid overly specific selectors)
   ```css
   /* Good */
   .card-title { }
   
   /* Avoid */
   div.container div.card div.card-header h3.card-title { }
   ```

4. **Use meaningful class names**
   ```css
   /* Good */
   .error-message { color: red; }
   
   /* Avoid */
   .red-text { color: red; }
   ```

5. **Group related styles together**
   ```css
   /* Typography */
   h1, h2, h3 { font-family: Arial; }
   
   /* Layout */
   .container { width: 100%; max-width: 1200px; }
   ```

---

## Common Mistakes to Avoid

1. **Forgetting the dot for classes**
   ```css
   /* Wrong */
   highlight { color: yellow; }
   
   /* Correct */
   .highlight { color: yellow; }
   ```

2. **Forgetting the hash for IDs**
   ```css
   /* Wrong */
   header { background: blue; }
   
   /* Correct */
   #header { background: blue; }
   ```

3. **Using spaces incorrectly**
   ```css
   /* Descendant selector - selects p inside div */
   div p { color: red; }
   
   /* Multiple classes - selects elements with BOTH classes */
   .announcement.urgent { border: 2px solid red; }
   ```

4. **Typos in property names**
   ```css
   /* Wrong */
   colour: red;
   
   /* Correct */
   color: red;
   ```

---

## Testing Your CSS

"So paano natin ite-test kung working ba ang CSS?" Tian asked.

Kuya Miguel smiled. "Use your browser's Developer Tools!"

1. Right-click on any element → **Inspect**
2. In the **Styles** panel, you'll see:
   - Which CSS rules are applied
   - Which rules are overridden (crossed out)
   - The specificity and source file
3. You can even **edit CSS live** to test changes!

---

## Summary

Rhea Joy summarized in her notebook:

**CSS Selectors:**
- **Element**: `p`, `h1`, `div`
- **Class**: `.announcement`, `.highlight`
- **ID**: `#header`, `#main-nav`
- **Descendant**: `div p`, `.services li`
- **Multiple**: `h1, h2, h3`

**Common Properties:**
- `color`, `background-color`
- `font-size`, `font-family`, `font-weight`
- `text-align`, `line-height`
- `padding`, `margin`, `border`

**Specificity Order:**
Inline > ID > Class > Element

Tian grinned. "Now our barangay website won't look like a boring newspaper anymore!"

---

## What's Next?

In the next lesson, you'll learn about **colors, backgrounds, and fonts** in detail—how to choose the perfect color schemes, use web fonts, and create beautiful backgrounds for your barangay website.

---