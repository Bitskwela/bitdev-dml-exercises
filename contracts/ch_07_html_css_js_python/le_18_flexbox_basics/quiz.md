# Quiz 1

**Scenario:** Tian is learning Flexbox to improve the barangay website layout.

1. How do you create a flex container?
   - A. `display: flexbox;`
   - B. `display: flex;`
   - C. `flex: container;`
   - D. `layout: flex;`

2. What is the default `flex-direction`?
   - A. `column` (vertical)
   - B. `row` (horizontal)
   - C. `row-reverse`
   - D. `wrap`

3. Rhea Joy wants to center items both horizontally and vertically. Which CSS is correct?
   - A. `justify-content: center;` only
   - B. `align-items: center;` only
   - C. `justify-content: center; align-items: center;`
   - D. `text-align: center;`

4. What does `gap: 20px;` do in a flex container?
   - A. Adds 20px padding to all items
   - B. Adds 20px margin to all items
   - C. Adds 20px space between items
   - D. Sets item width to 20px

5. Which property controls spacing along the main axis?
   - A. `align-items`
   - B. `justify-content`
   - C. `align-content`
   - D. `flex-align`

---

# Quiz 2

**Scenario:** Tian created a flex container:

```css
.container {
    display: flex;
    flex-direction: row;
}
```

6. Which property allows flex items to wrap to the next line?
   - A. `flex-wrap: wrap;`
   - B. `flex-break: true;`
   - C. `wrap: enabled;`
   - D. `multi-line: true;`

7. What does `justify-content: space-between;` do?
   - A. Adds equal space inside each item
   - B. Puts space only between items (no space at edges)
   - C. Centers all items
   - D. Aligns items to the end

8. Rhea Joy wants navigation links side by side with space between them. Which is best?
   - A. `display: block; margin: 10px;`
   - B. `display: inline-block; margin: 10px;`
   - C. `display: flex; gap: 10px;`
   - D. `display: grid; gap: 10px;`

9. What does `align-items: center;` do when `flex-direction: row;`?
   - A. Centers items horizontally
   - B. Centers items vertically
   - C. Centers text inside items
   - D. Has no effect

10. Which property makes a flex item grow to fill available space?
    - A. `flex-size: grow;`
    - B. `flex-grow: 1;`
    - C. `grow: true;`
    - D. `expand: 1;`

---

# Answers

1. **B** - `display: flex;`
2. **B** - `row` (horizontal)
3. **C** - `justify-content: center; align-items: center;`
4. **C** - Adds 20px space between items
5. **B** - `justify-content`
6. **A** - `flex-wrap: wrap;`
7. **B** - Puts space only between items (no space at edges)
8. **C** - `display: flex; gap: 10px;`
9. **B** - Centers items vertically
10. **B** - `flex-grow: 1;`

---

# Explanations

**Question 1:** To enable Flexbox, set `display: flex;` on the **parent container**. The children automatically become **flex items**.

```css
/* Create flex container */
.container {
    display: flex;  /* ✅ Correct */
}

/* Wrong syntax */
.container {
    display: flexbox;  /* ❌ Doesn't exist */
    flex: container;   /* ❌ Wrong */
}
```

**What happens:**
```html
<div class="container">
    <div>Item 1</div>  <!-- Becomes flex item -->
    <div>Item 2</div>  <!-- Becomes flex item -->
    <div>Item 3</div>  <!-- Becomes flex item -->
</div>
```

**Without Flexbox:**
- Items stack vertically (default block behavior)

**With `display: flex;`:**
- Items line up horizontally (default flex behavior)
- You can now use flexbox properties

**Barangay example:**
```css
/* Horizontal navigation */
.nav {
    display: flex;  /* Links now side by side */
}
```

---

**Question 2:** The default `flex-direction` is **`row`**, which arranges flex items **horizontally** from left to right.

```css
.container {
    display: flex;
    /* flex-direction: row; */  /* Default - not needed */
}
```

**Flex direction options:**
```css
flex-direction: row;           /* → Left to right (default) */
flex-direction: row-reverse;   /* ← Right to left */
flex-direction: column;        /* ↓ Top to bottom */
flex-direction: column-reverse; /* ↑ Bottom to top */
```

**Visual:**
```
row:           [1] [2] [3] →

row-reverse:   ← [3] [2] [1]

column:        [1]
               [2]
               [3]
               ↓

column-reverse: ↑
               [3]
               [2]
               [1]
```

**Barangay examples:**
```css
/* Horizontal nav (default) */
.nav {
    display: flex;
    /* flex-direction: row; */  /* Default */
}

/* Vertical sidebar menu */
.sidebar-menu {
    display: flex;
    flex-direction: column;  /* Stack vertically */
}
```

---

**Question 3:** To center items **both horizontally and vertically**, use **both** `justify-content: center;` and `align-items: center;`.

```css
.container {
    display: flex;
    justify-content: center;  /* Horizontal center (main axis) */
    align-items: center;      /* Vertical center (cross axis) */
    height: 400px;            /* Container needs height */
}
```

**Why both?**
- `justify-content` controls the **main axis** (horizontal for row)
- `align-items` controls the **cross axis** (vertical for row)
- Both needed for full centering

**Barangay hero section:**
```css
.hero {
    display: flex;
    justify-content: center;  /* Center horizontally */
    align-items: center;      /* Center vertically */
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

**Result:** Content perfectly centered in hero section!

---

**Question 4:** The `gap` property adds **space between flex items** (not inside them). It's much cleaner than using margins.

```css
.container {
    display: flex;
    gap: 20px;  /* 20px space between items */
}
```

**Comparison:**
```css
/* Old way: margins */
.item {
    margin-right: 20px;
}
.item:last-child {
    margin-right: 0;  /* Remove from last item */
}

/* Flexbox way: gap */
.container {
    display: flex;
    gap: 20px;  /* Automatic! No margin on edges */
}
```

**Visual:**
```
Without gap:  [Item1][Item2][Item3]

With gap:     [Item1]  [Item2]  [Item3]
                  ↑        ↑
                20px    20px
```

**Barangay example:**
```css
/* Navigation with consistent spacing */
.nav {
    display: flex;
    gap: 15px;  /* 15px between each link */
}
```

**Advanced:** You can set different horizontal and vertical gaps:
```css
.container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px 30px;  /* 20px vertical, 30px horizontal */
}
```

---

**Question 5:** `justify-content` controls spacing along the **main axis**. For `flex-direction: row;` (default), the main axis is **horizontal**.

```css
.container {
    display: flex;
    justify-content: flex-start;    /* Left (default) */
    justify-content: flex-end;      /* Right */
    justify-content: center;        /* Center */
    justify-content: space-between; /* Space between */
    justify-content: space-around;  /* Space around */
    justify-content: space-evenly;  /* Equal space */
}
```

**Visual comparison:**
```
flex-start:    [1][2][3]...................

flex-end:      ...................[1][2][3]

center:        .........[1][2][3].........

space-between: [1].........[2].........[3]
               No space    Even      No space
               at start    space     at end

space-around:  ...[1].....[2].....[3]...
               Half   Full  Full  Half
               space  space space space

space-evenly:  ....[1]....[2]....[3]....
               Equal spacing everywhere
```

**Barangay examples:**
```css
/* Logo left, menu right */
.header {
    display: flex;
    justify-content: space-between;
}

/* Centered navigation */
.nav {
    display: flex;
    justify-content: center;
}

/* Even spacing for service cards */
.services {
    display: flex;
    justify-content: space-evenly;
}
```

---

**Question 6:** `flex-wrap: wrap;` allows flex items to **wrap to the next line** when they don't fit in one line.

```css
.container {
    display: flex;
    flex-wrap: nowrap;  /* Default: single line, may overflow */
    flex-wrap: wrap;    /* Wrap to multiple lines */
}
```

**Without wrap (default):**
```
[Item1][Item2][Item3][Item4][Item5][Item6]... (squeezed)
```

**With wrap:**
```
[Item1][Item2][Item3]
[Item4][Item5][Item6]
```

**Perfect for responsive card grids:**
```css
.card-container {
    display: flex;
    flex-wrap: wrap;  /* Cards wrap on small screens */
    gap: 20px;
}

.card {
    width: 300px;  /* Fixed width */
    height: 200px;
}
```

**On wide screen:** 3 cards per row
**On narrow screen:** 2 cards per row, then 1 card per row

**Barangay example:**
```css
.services {
    display: flex;
    flex-wrap: wrap;        /* Wrap on small screens */
    justify-content: center;
    gap: 30px;
}

.service-card {
    width: 280px;
    /* Cards automatically wrap based on container width */
}
```

---

**Question 7:** `justify-content: space-between;` puts space **only between items**, with **no space at the edges**. First item touches the start, last item touches the end.

```css
.container {
    display: flex;
    justify-content: space-between;
}
```

**Visual comparison:**
```
space-between:
[Item1]...........[Item2]...........[Item3]
↑                                        ↑
No space at start               No space at end
Equal space between items

space-around:
...[Item1]........[Item2]........[Item3]...
↑                                        ↑
Half space                       Half space

space-evenly:
.....[Item1]......[Item2]......[Item3].....
↑                                        ↑
Equal space everywhere
```

**Perfect for:**
```css
/* Header: logo left, menu right */
.header {
    display: flex;
    justify-content: space-between;
}
/* <header class="header">
     <div class="logo">Logo</div>      ← Left edge
     <nav class="menu">Menu</nav>      ← Right edge
   </header> */

/* Footer: copyright left, social right */
.footer {
    display: flex;
    justify-content: space-between;
}
```

---

**Question 8:** For navigation links, **Flexbox with gap** is the cleanest modern approach.

```css
/* Best: Flexbox with gap */
.nav {
    display: flex;   /* Side by side */
    gap: 10px;       /* Space between */
}

/* Clean, no margin issues, automatic spacing */
```

**Comparison:**
```css
/* Old way 1: inline-block */
.nav a {
    display: inline-block;
    margin-right: 10px;
}
.nav a:last-child {
    margin-right: 0;  /* Remove from last link */
}
/* Issues: Whitespace gaps, need to handle last-child */

/* Old way 2: float */
.nav a {
    float: left;
    margin-right: 10px;
}
/* Issues: Need clearfix, outdated */

/* Modern way: Flexbox */
.nav {
    display: flex;
    gap: 10px;  /* ✅ Clean, automatic, perfect */
}
```

**Complete barangay navigation:**
```css
.nav {
    display: flex;
    gap: 15px;
    align-items: center;  /* Vertically center links */
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
```

---

**Question 9:** When `flex-direction: row;` (horizontal layout), `align-items` controls **vertical alignment** (cross axis).

```css
.container {
    display: flex;
    flex-direction: row;      /* Horizontal (default) */
    align-items: center;      /* Vertical center */
    height: 80px;             /* Container needs height */
}
```

**Visual:**
```
align-items: flex-start (top):
+---------------------------+
| [Item1] [Item2] [Item3]   | <-- Items at top
|                           |
|                           |
+---------------------------+

align-items: center (middle):
+---------------------------+
|                           |
| [Item1] [Item2] [Item3]   | <-- Items centered
|                           |
+---------------------------+

align-items: flex-end (bottom):
+---------------------------+
|                           |
|                           |
| [Item1] [Item2] [Item3]   | <-- Items at bottom
+---------------------------+
```

**Barangay header example:**
```css
.header {
    display: flex;
    align-items: center;  /* Logo and title vertically centered */
    height: 80px;
    padding: 0 20px;
}
```

```html
<header class="header">
    <img src="logo.png" height="50">  <!-- Centered vertically -->
    <h1>Barangay San Miguel</h1>     <!-- Centered vertically -->
</header>
```

**Key concept:**
- **Main axis** (justify-content): Direction of `flex-direction`
- **Cross axis** (align-items): Perpendicular to main axis
- Row: main=horizontal, cross=vertical
- Column: main=vertical, cross=horizontal

---

**Question 10:** `flex-grow: 1;` makes a flex item **grow to fill available space** in the container.

```css
.item {
    flex-grow: 0;  /* Default: don't grow */
    flex-grow: 1;  /* Grow to fill space */
    flex-grow: 2;  /* Grow twice as much as flex-grow: 1 */
}
```

**Example: Sidebar + Main content**
```css
.container {
    display: flex;
}

.sidebar {
    width: 250px;   /* Fixed width */
    flex-grow: 0;   /* Don't grow (default) */
}

.main-content {
    flex-grow: 1;   /* Takes remaining space */
}
```

**Visual:**
```
Container: 1000px wide

+----------+-------------------------+
| Sidebar  |     Main Content       |
|  250px   |   750px (fills rest)   |
|  fixed   |    flex-grow: 1        |
+----------+-------------------------+
```

**Multiple growing items:**
```css
.container { display: flex; }

.item1 { flex-grow: 1; }  /* Gets 1 share */
.item2 { flex-grow: 2; }  /* Gets 2 shares (twice as much) */
.item3 { flex-grow: 1; }  /* Gets 1 share */
/* Total: 4 shares */
```

**Result:** Available space divided into 4 parts
- Item1: 25% of space
- Item2: 50% of space
- Item3: 25% of space

**Barangay example:**
```css
/* Search bar grows, button fixed */
.search-form {
    display: flex;
    gap: 10px;
}

.search-input {
    flex-grow: 1;    /* Takes available space */
    padding: 10px;
}

.search-button {
    width: 100px;    /* Fixed width */
    flex-grow: 0;    /* Don't grow (default) */
}
```

---