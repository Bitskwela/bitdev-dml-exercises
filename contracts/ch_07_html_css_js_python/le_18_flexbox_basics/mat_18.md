## Background Story

Tian slammed their fist on the desk, startling Rhea Joy who was sitting next to them in the computer lab.

"What's wrong?" Rhea Joy asked.

"This!" Tian pointed at their screen, showing three service cards that were supposed to be horizontally aligned but were plagued with problems.

The cards were using `display: inline-block;` as they'd learned, but:

1. There were mysterious white spaces between the cards that no amount of margin adjustment could fix
2. The cards weren't vertically aligned properly—one was slightly higher than the others
3. Centering them horizontally required text-align on the parent, which felt wrong
4. The cards didn't wrap nicely on smaller screens
5. Trying to distribute space evenly between them was a nightmare of percentage calculations

"I've been fighting this layout for two hours," Tian said, exhausted. "I've tried floats—clearing issues. I've tried inline-block—spacing issues. I've tried absolute positioning—overlapping issues. CSS layout feels like constantly fighting against the browser instead of working with it."

Rhea Joy nodded sympathetically. She was experiencing similar frustrations with her own project—a navigation menu that needed to be centered both horizontally and vertically within its container.

"To center something both ways, I need like five different properties," she said, pulling up her code:

```css
.container {
    position: relative;
}

.centered-item {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
```

"It works, but it feels hacky. Like we're exploiting browser behavior instead of using proper tools. Doesn't CSS have, I don't know, a built-in way to handle common layout patterns?"

Their teacher, Ms. Santos, happened to walk by at that moment. She glanced at their screens and immediately understood the problem.

"You're using old layout techniques," she said. "Floats and inline-block were never designed for modern web layouts—they were hacks that developers used because nothing better existed. But CSS has evolved. You should be using Flexbox for one-dimensional layouts and Grid for two-dimensional layouts."

"Flexbox?" Tian and Rhea Joy said simultaneously.

"Flexible Box Layout. It was created specifically to solve the exact problems you're experiencing—alignment, distribution, spacing, ordering. It makes layouts that were painful with old methods incredibly easy with new ones."

Ms. Santos quickly typed a simple example:

```css
.container {
    display: flex;
    justify-content: center;
    align-items: center;
}
```

"That's it. Three lines. Perfectly centered, horizontally and vertically. No positioning hacks. No transform tricks. Just clear, semantic layout properties."

Tian and Rhea Joy stared at the code, then at each other.

That evening, they both called Kuya Miguel.

"Kuya, why didn't you teach us Flexbox earlier?! We've been suffering with inline-block and positioning hacks when there's a modern layout system designed for this!"

Miguel chuckled. "I wanted you to understand the old way first, so you'd appreciate how much better Flexbox is. Now that you've felt the pain of traditional layout methods, you're ready to learn the modern way. Trust me—once you understand Flexbox, you'll never want to go back to floats and inline-block for layout."

---

## Theory & Lecture Content

## What is Flexbox?

**Flexbox** (Flexible Box Layout) is a CSS layout mode designed for **one-dimensional layouts**—either in a row or a column.

It makes it easy to:
- Align items horizontally and vertically
- Distribute space between items
- Reorder items visually
- Create responsive layouts
- Handle different screen sizes

**Key concept:** You have a **flex container** (parent) with **flex items** (children).

```css
.container {
    display: flex;  /* Makes this a flex container */
}
```

---

## Creating a Flex Container

To use flexbox, set `display: flex;` on the parent element.

```css
.container {
    display: flex;  /* Children become flex items */
}
```

**HTML:**
```html
<div class="container">
    <div class="item">Item 1</div>
    <div class="item">Item 2</div>
    <div class="item">Item 3</div>
</div>
```

**Without Flexbox:**
- Items stack vertically (default block behavior)

**With Flexbox:**
- Items line up horizontally in a row (default flex behavior)

---

## Flex Direction

Controls the main axis direction (row or column).

```css
.container {
    display: flex;
    flex-direction: row;         /* Default: left to right */
    flex-direction: row-reverse; /* Right to left */
    flex-direction: column;      /* Top to bottom */
    flex-direction: column-reverse; /* Bottom to top */
}
```

**Examples:**
```css
/* Horizontal layout (default) */
.nav {
    display: flex;
    flex-direction: row;  /* Items side by side */
}

/* Vertical layout */
.sidebar {
    display: flex;
    flex-direction: column;  /* Items stacked */
}
```

**Filipino Barangay Example:**
```css
/* Horizontal navigation */
.nav {
    display: flex;
    flex-direction: row;  /* Links side by side */
}

/* Vertical menu */
.menu {
    display: flex;
    flex-direction: column;  /* Links stacked */
}
```

---

## Justify Content (Main Axis Alignment)

Controls alignment along the **main axis** (horizontal for row, vertical for column).

```css
.container {
    display: flex;
    justify-content: flex-start;    /* Default: start of container */
    justify-content: flex-end;      /* End of container */
    justify-content: center;        /* Center */
    justify-content: space-between; /* Space between items */
    justify-content: space-around;  /* Space around items */
    justify-content: space-evenly;  /* Equal space everywhere */
}
```

**Visual (with `flex-direction: row;`):**

```
flex-start:    [1][2][3]...................
flex-end:      ...................[1][2][3]
center:        .........[1][2][3].........
space-between: [1].........[2].........[3]
space-around:  ...[1].....[2].....[3]...
space-evenly:  ....[1]....[2]....[3]....
```

**Filipino Barangay Example:**
```css
/* Center navigation links */
.nav {
    display: flex;
    justify-content: center;  /* Links centered */
}

/* Space between header and buttons */
.header {
    display: flex;
    justify-content: space-between;
}
/* <div class="header">
     <h1>Barangay</h1>  <--- Left
     <button>Login</button> <--- Right
   </div> */
```

---

## Align Items (Cross Axis Alignment)

Controls alignment along the **cross axis** (vertical for row, horizontal for column).

```css
.container {
    display: flex;
    align-items: stretch;      /* Default: stretch to fill */
    align-items: flex-start;   /* Top (for row) */
    align-items: flex-end;     /* Bottom (for row) */
    align-items: center;       /* Middle (for row) */
    align-items: baseline;     /* Align text baselines */
}
```

**Visual (with `flex-direction: row;`):**

```
flex-start:   [1][2][3]  <-- All at top
              

center:       
              [1][2][3]  <-- All centered vertically
              

flex-end:     
              
              [1][2][3]  <-- All at bottom
```

**Filipino Barangay Example:**
```css
/* Vertically center logo and title */
.header {
    display: flex;
    align-items: center;  /* Vertical center */
    height: 80px;
}
/* <div class="header">
     <img src="logo.png"> <--- Centered
     <h1>Barangay</h1> <--- Centered
   </div> */
```

---

## Centering with Flexbox

The easiest way to center content:

```css
.container {
    display: flex;
    justify-content: center;  /* Horizontal center */
    align-items: center;      /* Vertical center */
    height: 100vh;            /* Full viewport height */
}
```

**Perfect for:**
- Centering modals
- Hero sections
- Loading spinners
- Login forms

**Filipino Example:**
```css
/* Centered hero section */
.hero {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 400px;
    background: linear-gradient(to right, #1a73e8, #34a853);
    color: white;
}
```

```html
<div class="hero">
    <div>
        <h1>Barangay San Miguel</h1>
        <p>Pagkakaisa, Paglilingkod, Pag-unlad</p>
    </div>
</div>
```

---

## Gap (Spacing Between Items)

```css
.container {
    display: flex;
    gap: 20px;  /* Space between items */
}
```

This is **much easier** than adding margins to each item!

**Example:**
```css
/* Old way: margins on items */
.item {
    margin-right: 20px;
}
.item:last-child {
    margin-right: 0;  /* Remove margin from last item */
}

/* Flexbox way: gap on container */
.container {
    display: flex;
    gap: 20px;  /* Automatic spacing! */
}
```

---

## Flex Wrap

By default, flex items try to fit on one line. Use `flex-wrap` to allow wrapping.

```css
.container {
    display: flex;
    flex-wrap: nowrap;     /* Default: single line */
    flex-wrap: wrap;       /* Wrap to multiple lines */
    flex-wrap: wrap-reverse; /* Wrap in reverse */
}
```

**Example:**
```css
/* Card grid that wraps on small screens */
.card-grid {
    display: flex;
    flex-wrap: wrap;  /* Cards wrap to next line */
    gap: 20px;
}

.card {
    width: 300px;
    height: 200px;
}
```

---

## Flex Items Properties

### flex-grow

Controls how much a flex item grows to fill available space.

```css
.item {
    flex-grow: 0;  /* Default: don't grow */
    flex-grow: 1;  /* Grow to fill space */
    flex-grow: 2;  /* Grow twice as much as flex-grow: 1 */
}
```

**Example:**
```css
.container {
    display: flex;
}

.sidebar {
    width: 200px;
    flex-grow: 0;  /* Fixed width */
}

.main-content {
    flex-grow: 1;  /* Takes remaining space */
}
```

---

### flex-shrink

Controls how much a flex item shrinks when space is limited.

```css
.item {
    flex-shrink: 1;  /* Default: can shrink */
    flex-shrink: 0;  /* Don't shrink */
}
```

---

### align-self

Override `align-items` for individual items.

```css
.container {
    display: flex;
    align-items: center;  /* All items centered */
}

.special-item {
    align-self: flex-start;  /* This item at top */
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
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <!-- Flexbox header -->
    <header class="header">
        <div class="logo">
            <img src="logo.png" alt="Logo">
            <h1>Barangay San Miguel</h1>
        </div>
        <nav class="nav">
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#announcements">Announcements</a>
            <a href="#contact">Contact</a>
        </nav>
    </header>

    <!-- Flexbox hero section -->
    <section class="hero">
        <div class="hero-content">
            <h2>Welcome to Our Community</h2>
            <p>Pagkakaisa, Paglilingkod, Pag-unlad</p>
            <button class="btn">Learn More</button>
        </div>
    </section>

    <!-- Flexbox service cards -->
    <section class="services">
        <h2>Our Services</h2>
        <div class="card-container">
            <div class="card">
                <h3>Barangay Clearance</h3>
                <p>Processing: 3-5 days</p>
            </div>
            <div class="card">
                <h3>Residency Certificate</h3>
                <p>Processing: Same day</p>
            </div>
            <div class="card">
                <h3>Indigency Certificate</h3>
                <p>Processing: 1-2 days</p>
            </div>
        </div>
    </section>

    <!-- Flexbox footer -->
    <footer class="footer">
        <p>&copy; 2025 Barangay San Miguel</p>
        <div class="social">
            <a href="#">Facebook</a>
            <a href="#">Twitter</a>
        </div>
    </footer>
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

/* Flexbox Header */
.header {
    display: flex;
    justify-content: space-between;  /* Logo left, nav right */
    align-items: center;             /* Vertically centered */
    padding: 20px 40px;
    background: #1a73e8;
    color: white;
}

.logo {
    display: flex;
    align-items: center;  /* Vertically center logo and text */
    gap: 15px;
}

.logo img {
    width: 50px;
    height: 50px;
}

.logo h1 {
    font-size: 1.5rem;
}

/* Flexbox Navigation */
.nav {
    display: flex;
    gap: 20px;  /* Space between links */
}

.nav a {
    color: white;
    text-decoration: none;
    padding: 10px 15px;
    transition: background 0.3s;
}

.nav a:hover {
    background: rgba(255,255,255,0.2);
    border-radius: 5px;
}

/* Flexbox Hero Section */
.hero {
    display: flex;
    justify-content: center;  /* Horizontal center */
    align-items: center;      /* Vertical center */
    height: 400px;
    background: linear-gradient(135deg, #1a73e8 0%, #34a853 100%);
    color: white;
    text-align: center;
}

.hero-content h2 {
    font-size: 3rem;
    margin-bottom: 15px;
}

.hero-content p {
    font-size: 1.3rem;
    margin-bottom: 25px;
    font-style: italic;
}

.btn {
    padding: 12px 30px;
    background: white;
    color: #1a73e8;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
    transition: transform 0.2s;
}

.btn:hover {
    transform: scale(1.05);
}

/* Services Section */
.services {
    padding: 60px 20px;
    background: #f5f5f5;
}

.services h2 {
    text-align: center;
    font-size: 2rem;
    margin-bottom: 40px;
    color: #333;
}

/* Flexbox Card Container */
.card-container {
    display: flex;
    justify-content: center;  /* Center cards */
    gap: 30px;                /* Space between cards */
    flex-wrap: wrap;          /* Wrap on small screens */
}

.card {
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    width: 280px;
    text-align: center;
    transition: transform 0.3s;
}

.card:hover {
    transform: translateY(-10px);
}

.card h3 {
    color: #1a73e8;
    margin-bottom: 10px;
}

.card p {
    color: #666;
}

/* Flexbox Footer */
.footer {
    display: flex;
    justify-content: space-between;  /* Text left, links right */
    align-items: center;             /* Vertically centered */
    padding: 30px 40px;
    background: #333;
    color: white;
}

.social {
    display: flex;
    gap: 15px;
}

.social a {
    color: white;
    text-decoration: none;
}

.social a:hover {
    text-decoration: underline;
}

/* Responsive: Stack on small screens */
@media (max-width: 768px) {
    .header {
        flex-direction: column;  /* Stack vertically */
        gap: 15px;
    }
    
    .nav {
        flex-direction: column;  /* Stack links */
        align-items: center;
    }
    
    .footer {
        flex-direction: column;
        gap: 15px;
        text-align: center;
    }
}
```

---

## Common Flexbox Patterns

### Holy Grail Layout (Header, Sidebar, Content, Footer)

```css
body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

.header, .footer {
    background: #333;
    color: white;
    padding: 20px;
}

.main {
    display: flex;
    flex: 1;  /* Grow to fill space */
}

.sidebar {
    width: 250px;
    background: #f5f5f5;
}

.content {
    flex: 1;  /* Takes remaining space */
    padding: 20px;
}
```

---

### Equal Height Columns

```css
.container {
    display: flex;  /* Children automatically equal height */
}

.column {
    flex: 1;       /* Equal width */
    padding: 20px;
    background: white;
}
```

---

### Sticky Footer

```css
body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

.content {
    flex: 1;  /* Push footer to bottom */
}

.footer {
    background: #333;
    color: white;
    padding: 20px;
}
```

---

## Best Practices

1. **Use flexbox for one-dimensional layouts** (row or column)
   - Navigation bars
   - Card layouts
   - Header/footer alignment

2. **Use CSS Grid for two-dimensional layouts** (we'll learn this later)

3. **Use `gap` instead of margins** for spacing

4. **Combine `justify-content` and `align-items`** for easy centering

5. **Use `flex-wrap: wrap`** for responsive card grids

6. **Mobile-first approach:**
   ```css
   /* Mobile: column */
   .container {
       display: flex;
       flex-direction: column;
   }
   
   /* Desktop: row */
   @media (min-width: 768px) {
       .container {
           flex-direction: row;
       }
   }
   ```

---

## Flexbox vs. Other Methods

| Layout Method | Best For |
|--------------|----------|
| **Flexbox** | One-dimensional layouts (rows or columns) |
| **CSS Grid** | Two-dimensional layouts (rows AND columns) |
| **Float** | Legacy layouts (avoid in new projects) |
| **inline-block** | Simple side-by-side (flexbox is better) |
| **Positioning** | Overlays, badges, fixed elements |

---

## Summary

Tian summarized:

**Flexbox Container Properties:**
- `display: flex` - Enable flexbox
- `flex-direction` - Row or column
- `justify-content` - Main axis alignment
- `align-items` - Cross axis alignment
- `gap` - Spacing between items
- `flex-wrap` - Wrap to multiple lines

**Common Patterns:**
- Centering: `justify-content: center; align-items: center;`
- Space between: `justify-content: space-between;`
- Equal spacing: `gap: 20px;`

Rhea Joy smiled. "Flexbox makes layout so much easier! No more weird inline-block gaps!"

---

## What's Next?

Congratulations! You've completed **Course 03: CSS Foundations**.

In the next course, you'll learn about **Responsive Design**—how to make websites that look great on phones, tablets, and desktops using media queries, responsive units, and CSS Grid.

---

---

## Closing Story

Tian learned Flexbox and gasped. Centering elements? One line. Equal-height columns? Automatic. Responsive rows? Built-in.

"Flexbox changed everything," Kuya Miguel grinned. "Before Flexbox, developers used hacks and workarounds. Now? Clean, semantic, intuitive layouts."

Tian rebuilt the entire page layout using Flexbox. Header, navigation, main content, sidebar, footerall perfectly aligned. The code was clean. The design was responsive. The barangay portal was ready for real-world use.

"Chapter complete," Kuya Miguel announced. "You've mastered CSS fundamentals. Ready for responsive design?"

_Next up: Chapter 4Bayanihan Design: The Responsive Revolution!_