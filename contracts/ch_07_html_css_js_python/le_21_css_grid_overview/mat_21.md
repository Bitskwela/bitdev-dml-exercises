## Background Story

Tian stared at his laptop screen in the school computer lab, frustration evident on his face. He'd been trying to implement a new homepage layout for the barangay website for two hours now, and it just wasn't cooperating. The design mockup Ms. Reyes had approved looked straightforward enough—a full-width header at the top, a sidebar on the left for navigation, the main content area in the center, a secondary widget area on the right, and a footer spanning the entire bottom.

Simple in theory. A nightmare in Flexbox.

"Paano ba 'to?" he muttered, adjusting another nested Flexbox container. He'd managed to get the header working fine—that was easy, just a single row. But the moment he tried to add the sidebar alongside the main content, everything broke. The sidebar would either be too tall, or too short, or would push the main content down instead of sitting beside it.

Rhea Joy pulled her chair closer, looking at the mess of HTML and CSS. "Why do you have so many div wrappers?" she asked, counting at least six nested containers just to achieve the basic layout structure.

"Kasi Flexbox can only work in one direction at a time!" Tian explained, exasperation clear in his voice. "Para ma-align yung sidebar at main content horizontally, I need a Flexbox row. Pero para ma-stack yung header, middle section, and footer vertically, I need another Flexbox column. So I have to wrap everything in containers within containers!"

He demonstrated the problem by temporarily removing one of the wrapper divs. The entire layout collapsed, with elements stacking vertically instead of sitting side by side. "See? And if I want the footer to stay at the bottom regardless of content height, I need even more Flexbox gymnastics."

Rhea Joy nodded slowly, starting to understand the complexity. "So Flexbox is great for simple one-directional layouts, but when you need both rows AND columns working together..."

"Exactly!" Tian said. "And that's not even the worst part. Look at this photo gallery Ms. Reyes wants for the barangay events page." He pulled up another mockup showing a Pinterest-style masonry layout with different sized image cards—some tall and narrow, some wide and short, some square—all fitting together beautifully like a puzzle.

He showed her his current attempt. The images were all forced into uniform sizes, looking cramped and awkward. "With Flexbox, I can make them wrap to multiple rows, pero I can't control how many columns there are or make certain images span multiple grid cells. Everything just flows in order, same size."

"Can't you just set different widths?" Rhea Joy suggested.

"I tried that," Tian said, showing her the CSS. "But then the spacing gets all uneven. Some images stretch, some have gaps, and it looks terrible on different screen sizes. Para hindi consistent yung grid structure."

He'd even tried using percentage widths, calc() functions, and complex margin calculations to fake a grid system. But every solution felt hacky, required too much math, and broke easily when the viewport size changed. "There has to be a better way," he said, rubbing his temples.

Just then, Kuya Miguel walked into the lab, visiting the school to give a guest lecture. He immediately noticed Tian's screen full of nested Flexbox containers and the frustrated expression that came with wrestling complex layouts.

"Flexbox struggles again?" Miguel asked with a knowing smile.

"Kuya!" Tian looked up hopefully. "Flexbox is amazing for simple layouts, but for this complex page structure, it's fighting me every step. I need a header across the entire top, then a three-column layout below with sidebar-content-widgets, then a full-width footer. How do professional developers do this without going crazy?"

Rhea Joy added, "And photo galleries with different sized images in a proper grid? Flexbox just makes them all wrap unpredictably."

Miguel pulled up a chair between them. "You've discovered Flexbox's limitation—it's a **one-dimensional layout system**. It's brilliant for arranging items in a row OR a column, but when you need **two-dimensional control**—rows AND columns working together—you need a different tool."

"What tool?" they asked in unison.

"**CSS Grid**," Miguel replied, opening a new CodePen. "It's designed specifically for complex layouts where you need to control both horizontal and vertical placement simultaneously. Let me show you."

He quickly typed out a simple grid setup:

```css
.container {
    display: grid;
    grid-template-columns: 200px 1fr 300px;
    grid-template-rows: auto 1fr auto;
}
```

"This creates a 3-column, 3-row grid instantly," Miguel explained. "No nested wrappers needed. The first column is 200px for your sidebar, middle column is flexible (1fr), right column is 300px for widgets. Three rows: auto-sized header, flexible content area, auto-sized footer."

Tian's eyes widened. "Wait, that's IT? No wrapper divs?"

"No wrapper divs," Miguel confirmed. "With Grid, you define the layout structure on the container, then place items directly into grid cells. You can even make items span multiple rows or columns."

He added a few more lines:

```css
.header { grid-column: 1 / 4; }  /* Spans all 3 columns */
.footer { grid-column: 1 / 4; }  /* Spans all 3 columns */
```

"Now the header and footer automatically stretch across all three columns," Miguel said. "And for your photo gallery, Grid is even more powerful. You can define a grid with auto-filling columns and let images span multiple cells based on their aspect ratio."

Rhea Joy leaned forward, excited. "So it's like designing on graph paper? You define the grid structure, then place elements in specific grid areas?"

"Exactly!" Miguel said. "Grid is **layout-driven**—you define the page structure first, then place content into it. Flexbox is **content-driven**—the content determines the layout. Both are powerful, but for complex page layouts, Grid is the superior choice."

Tian was already mentally redesigning his entire approach. "This changes everything. Instead of fighting with nested containers and complex Flexbox calculations, I can just define a proper grid and place elements exactly where I want them."

Miguel nodded. "And the best part? Grid and Flexbox work great together. Use Grid for your overall page layout, then use Flexbox inside those grid cells for component-level alignment. They're complementary tools."

Rhea Joy was already sketching grid layouts in her notebook. "So for the barangay website—header spans full width, main grid area has three columns for sidebar-content-widgets, footer spans full width. All defined cleanly with Grid."

"Exactly," Miguel said. "And when you need responsive layouts, Grid makes it incredibly easy with features like auto-fit, minmax(), and grid-template-areas. But first, let's master the basics."

He opened a new file for them. "Let me show you how to transform Tian's nested Flexbox nightmare into a clean Grid layout, then we'll tackle that photo gallery. Once you understand Grid, you'll wonder how you ever built complex layouts without it."

Tian and Rhea Joy pulled their chairs closer, ready to learn the layout system that would finally let them build the professional, complex page structures they'd been struggling to achieve with Flexbox alone. The grid revolution was about to begin.

---

## Theory & Lecture Content

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

---

## Closing Story

Tian learned CSS Grid and rebuilt the entire layout. Two-column design for desktop. Single-column for mobile. Grid areas for semantic positioning. The code was elegant. The design was flawless.

"Grid is for page-level layout," Kuya Miguel explained. "Flexbox is for component-level. Together, they're unstoppable."

Tian combined Grid and FlexboxGrid for overall structure, Flexbox for navigation and cards. The barangay portal looked like a modern web app now. Clean. Fast. Beautiful.

_Next up: Mobile-First Designthe modern approach!_ 