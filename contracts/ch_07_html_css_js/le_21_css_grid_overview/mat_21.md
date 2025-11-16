# Lesson 21: CSS Grid Overview

---

## The Layout Challenge

"Kuya Miguel, Flexbox is great for rows and columns, pero paano yung complex layouts?" Tian showed a design mockup. "I need a header across the top, sidebar on the left, main content in the center, and footer at the bottom. Flexbox feels complicated!"

Rhea Joy agreed. "Yes! And what if we want a photo gallery with different sized images arranged in a grid?"

Kuya Miguel smiled. "That's where **CSS Grid** shines. It's a 2D layout system—you can control **rows and columns simultaneously**. Perfect for complex page layouts."

---

## What is CSS Grid?

**CSS Grid** is a two-dimensional layout system that lets you create grid-based layouts with **rows and columns**.

**Flexbox vs Grid:**

| Flexbox | Grid |
|---------|------|
| 1D (row OR column) | 2D (rows AND columns) |
| Content-driven | Layout-driven |
| Best for components | Best for page layouts |

**Visual:**
```
Flexbox (1D):
[→→→→→→→→]  Row
[↓]              Column
[↓]
[↓]

Grid (2D):
+---+---+---+
| 1 | 2 | 3 |
+---+---+---+
| 4 | 5 | 6 |
+---+---+---+
Rows AND Columns!
```

---

## Basic Grid Setup

### HTML
```html
<div class="grid-container">
    <div class="item">Item 1</div>
    <div class="item">Item 2</div>
    <div class="item">Item 3</div>
    <div class="item">Item 4</div>
    <div class="item">Item 5</div>
    <div class="item">Item 6</div>
</div>
```

### CSS
```css
.grid-container {
    display: grid;  /* Enable Grid */
}
```

That's it! `display: grid` creates a grid container.

---

## Defining Columns

**Use `grid-template-columns` to define column widths.**

### Fixed Width Columns

```css
.grid-container {
    display: grid;
    grid-template-columns: 200px 200px 200px;  /* 3 columns, 200px each */
}
```

**Result:**
```
+-------+-------+-------+
| 200px | 200px | 200px |
+-------+-------+-------+
```

---

### Flexible Columns with `fr` (Fractions)

**`fr` represents a fraction of available space.**

```css
.grid-container {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;  /* 3 equal columns */
}
```

**Result:** Columns split available space equally.

```
+-------+-------+-------+
|  33%  |  33%  |  33%  |
+-------+-------+-------+
```

---

### Mixing Units

```css
.grid-container {
    display: grid;
    grid-template-columns: 200px 1fr 2fr;
    /*                     fixed  flex flex */
}
```

**How it works:**
1. Fixed column gets 200px
2. Remaining space divided: `1fr + 2fr = 3 parts`
3. Column 2: 1/3 of remaining
4. Column 3: 2/3 of remaining

**Visual (1000px container):**
```
Total: 1000px
- Column 1: 200px (fixed)
- Remaining: 800px
- Column 2: 800px × (1/3) = 267px
- Column 3: 800px × (2/3) = 533px

+-----+---------+---------------+
|200px|  267px  |     533px     |
+-----+---------+---------------+
```

---

### Repeat Function

**Shortcut for repeating column definitions.**

```css
/* Instead of this */
.grid-container {
    grid-template-columns: 1fr 1fr 1fr 1fr;
}

/* Use repeat() */
.grid-container {
    grid-template-columns: repeat(4, 1fr);
    /*                     repeat(count, size) */
}
```

**More examples:**
```css
/* 3 equal columns */
grid-template-columns: repeat(3, 1fr);

/* 5 columns of 100px */
grid-template-columns: repeat(5, 100px);

/* Pattern: 200px, 1fr, 200px, 1fr */
grid-template-columns: repeat(2, 200px 1fr);
```

---

## Defining Rows

**Use `grid-template-rows` to define row heights.**

```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-template-rows: 100px 200px 100px;  /* 3 rows */
}
```

**Result:**
```
+-------+-------+-------+
|  100px height         |
+-------+-------+-------+
|  200px height         |
+-------+-------+-------+
|  100px height         |
+-------+-------+-------+
```

**Auto rows (default):**
```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-auto-rows: 150px;  /* Any extra rows are 150px */
}
```

---

## Gap (Spacing)

**Add spacing between grid items.**

```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;  /* 20px spacing between all items */
}
```

**Separate row and column gaps:**
```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    row-gap: 20px;     /* Vertical spacing */
    column-gap: 30px;  /* Horizontal spacing */
}

/* Shorthand: */
gap: 20px 30px;  /* row-gap column-gap */
```

---

## Barangay Services Grid Example

**HTML:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Services</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="services-grid">
        <div class="service">Barangay Clearance</div>
        <div class="service">Residency Certificate</div>
        <div class="service">Indigency Certificate</div>
        <div class="service">Business Permit</div>
        <div class="service">Community Tax</div>
        <div class="service">Complaint Assistance</div>
    </div>
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
    padding: 2rem;
    background: #f5f5f5;
}

.services-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);  /* 3 equal columns */
    gap: 20px;                              /* 20px spacing */
}

.service {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    font-size: 1.1rem;
    color: #1a73e8;
    font-weight: bold;
}

.service:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    transition: all 0.3s ease;
}

/* Responsive */
@media (max-width: 768px) {
    .services-grid {
        grid-template-columns: repeat(2, 1fr);  /* 2 columns on tablet */
    }
}

@media (max-width: 480px) {
    .services-grid {
        grid-template-columns: 1fr;  /* 1 column on mobile */
    }
}
```

**Result:**
- **Desktop:** 3 columns
- **Tablet:** 2 columns
- **Mobile:** 1 column

---

## Spanning Multiple Columns/Rows

**Make items span across multiple grid cells.**

### Column Span

```css
.item1 {
    grid-column: span 2;  /* Span 2 columns */
}

.item2 {
    grid-column: 1 / 4;  /* Start at line 1, end at line 4 (spans 3 columns) */
}
```

### Row Span

```css
.item3 {
    grid-row: span 2;  /* Span 2 rows */
}
```

---

### Barangay Page Layout Example

**HTML:**
```html
<div class="page-layout">
    <header class="header">Header</header>
    <aside class="sidebar">Sidebar</aside>
    <main class="main-content">Main Content</main>
    <footer class="footer">Footer</footer>
</div>
```

**CSS:**
```css
.page-layout {
    display: grid;
    grid-template-columns: 250px 1fr;  /* Sidebar | Content */
    grid-template-rows: 80px 1fr 60px; /* Header | Main | Footer */
    gap: 20px;
    height: 100vh;
}

.header {
    grid-column: 1 / 3;  /* Span both columns */
    background: #1a73e8;
    color: white;
    display: flex;
    align-items: center;
    padding: 0 2rem;
    font-size: 1.5rem;
}

.sidebar {
    background: #f5f5f5;
    padding: 1.5rem;
}

.main-content {
    background: white;
    padding: 2rem;
}

.footer {
    grid-column: 1 / 3;  /* Span both columns */
    background: #333;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
}
```

**Visual:**
```
+------------------+
|     Header       |  (spans 2 columns)
+------+-----------+
|Side- | Main      |
|bar   | Content   |
|      |           |
+------+-----------+
|     Footer       |  (spans 2 columns)
+------------------+
```

---

## Grid Template Areas (Named Layout)

**Define layout using named areas (very intuitive!).**

**CSS:**
```css
.page-layout {
    display: grid;
    grid-template-columns: 250px 1fr;
    grid-template-rows: 80px 1fr 60px;
    grid-template-areas:
        "header  header"
        "sidebar main"
        "footer  footer";
    gap: 20px;
    height: 100vh;
}

.header  { grid-area: header; }
.sidebar { grid-area: sidebar; }
.main-content { grid-area: main; }
.footer  { grid-area: footer; }
```

**Visual representation in CSS matches actual layout!**

```css
grid-template-areas:
    "header  header"   ← Header spans 2 columns
    "sidebar main"     ← Sidebar and Main side-by-side
    "footer  footer";  ← Footer spans 2 columns
```

---

## Responsive Grid

### Auto-Fit and Auto-Fill

**Automatically adjust number of columns based on available space.**

```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
}
```

**How it works:**
- `auto-fit`: Creates as many columns as fit
- `minmax(250px, 1fr)`: Each column is at least 250px, grows to fill space
- Automatically responsive! No media queries needed.

**Examples:**
```
1200px screen:
+-------+-------+-------+-------+
| 250px | 250px | 250px | 250px |  (4 columns fit)
+-------+-------+-------+-------+

600px screen:
+-------+-------+
| 250px | 250px |  (2 columns fit)
+-------+-------+

300px screen:
+-------+
| 300px |  (1 column, grows to fit)
+-------+
```

---

### Barangay Announcements Grid

**HTML:**
```html
<div class="announcements-grid">
    <div class="announcement">Vaccination Drive - March 15</div>
    <div class="announcement">Barangay Assembly - March 20</div>
    <div class="announcement">Basketball League Finals - March 25</div>
    <div class="announcement">Clean-Up Day - March 30</div>
    <div class="announcement">Senior Citizens' Day - April 5</div>
    <div class="announcement">Scholarship Application Open</div>
</div>
```

**CSS:**
```css
.announcements-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
    padding: 2rem;
}

.announcement {
    background: linear-gradient(135deg, #1a73e8, #34a853);
    color: white;
    padding: 2rem;
    border-radius: 10px;
    font-size: 1.1rem;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}
```

**Result:** Grid automatically adjusts columns based on screen size!

---

## Alignment

### Justify Items (Horizontal)

```css
.grid-container {
    justify-items: start;    /* Left */
    justify-items: center;   /* Center */
    justify-items: end;      /* Right */
    justify-items: stretch;  /* Fill width (default) */
}
```

---

### Align Items (Vertical)

```css
.grid-container {
    align-items: start;      /* Top */
    align-items: center;     /* Middle */
    align-items: end;        /* Bottom */
    align-items: stretch;    /* Fill height (default) */
}
```

---

### Center Everything

```css
.grid-container {
    display: grid;
    place-items: center;  /* Shorthand for justify-items + align-items */
}
```

---

## Grid vs Flexbox: When to Use?

**Use Grid when:**
✅ Creating page layouts (header, sidebar, content, footer)
✅ Two-dimensional layouts (rows AND columns)
✅ Fixed grid structures (photo galleries)
✅ Complex overlapping layouts

**Use Flexbox when:**
✅ One-dimensional layouts (navbar, button groups)
✅ Content-driven sizing
✅ Simple alignment tasks
✅ Components within Grid cells

**Often used together:**
```css
/* Grid for page layout */
.page {
    display: grid;
    grid-template-columns: 1fr 3fr;
}

/* Flexbox for navbar within header */
.navbar {
    display: flex;
    justify-content: space-between;
}
```

---

## Summary

Tian summarized:

**CSS Grid Basics:**
```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);  /* 3 equal columns */
    grid-template-rows: 100px auto;         /* Row heights */
    gap: 20px;                              /* Spacing */
}
```

**Key Concepts:**
- `display: grid`: Enable Grid
- `grid-template-columns`: Define columns
- `grid-template-rows`: Define rows
- `gap`: Spacing between items
- `fr`: Flexible fraction unit
- `repeat()`: Repeat pattern
- `grid-column: span 2`: Span multiple columns
- `auto-fit + minmax()`: Automatic responsive grid

**Grid vs Flexbox:**
- Grid: 2D (rows + columns), layout-driven
- Flexbox: 1D (row or column), content-driven

Rhea Joy smiled. "Grid makes complex layouts so much easier!"

---

## What's Next?

In the next lesson, you'll learn about **Mobile-First Design**—a strategy for building responsive websites starting from mobile screens up to desktop.

---