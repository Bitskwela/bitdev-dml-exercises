# Quiz 1

**Scenario:** Tian is creating a grid layout for the barangay services page.

1. What is the correct CSS to enable Grid layout?
   - A. `layout: grid;`
   - B. `display: grid;`
   - C. `grid: enabled;`
   - D. `flex: grid;`

**Answer: B**

To enable CSS Grid, use `display: grid;` on the container element.

2. What does `grid-template-columns: 1fr 2fr 1fr;` create?
   - A. 3 equal columns
   - B. 3 columns: left and right are half the size of middle
   - C. 3 columns with 1px, 2px, 1px widths
   - D. Syntax error

**Answer: B**

`fr` (fraction) represents a portion of available space. `1fr 2fr 1fr` means the middle column is twice as wide as the left and right columns (25%, 50%, 25%).

3. Rhea Joy wants 4 equal columns. Which CSS is correct?
   - A. `grid-template-columns: 4fr;`
   - B. `grid-template-columns: 1fr 1fr 1fr 1fr;`
   - C. `grid-template-columns: repeat(4);`
   - D. `grid-columns: 4;`

**Answer: B**

To create 4 equal columns, list `1fr` four times. You can also use `repeat(4, 1fr)` as a shortcut.

4. What does the `gap` property do in CSS Grid?
   - A. Creates space between grid items
   - B. Sets grid container width
   - C. Defines number of columns
   - D. Aligns items vertically

**Answer: A**

The `gap` property creates spacing between grid items (like margin, but only between items, not around edges).

5. Which property makes an item span 2 columns?
   - A. `column-span: 2;`
   - B. `grid-column: span 2;`
   - C. `span: 2 columns;`
   - D. `width: 2fr;`

**Answer: B**

Use `grid-column: span 2;` to make an item span across 2 columns in the grid.

---

# Quiz 2

**Scenario:** Tian wants to create a responsive grid that automatically adjusts columns.

6. What does `repeat(3, 1fr)` create?
   - A. 1 column repeated 3 times
   - B. 3 equal columns
   - C. 3 rows
   - D. Syntax error

**Answer: B**

`repeat(3, 1fr)` is shorthand for `1fr 1fr 1fr`, creating 3 equal columns.

7. Which CSS creates an auto-responsive grid (columns adjust to screen size)?
   - A. `grid-template-columns: auto;`
   - B. `grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));`
   - C. `grid-template-columns: responsive;`
   - D. `grid-auto-columns: fit;`

**Answer: B**

`repeat(auto-fit, minmax(250px, 1fr))` creates a responsive grid where columns automatically adjust. Each column is minimum 250px, grows to fill space.

8. When should Rhea Joy use Grid instead of Flexbox?
   - A. For a horizontal navigation bar
   - B. For a page layout with header, sidebar, content, and footer
   - C. For a row of buttons
   - D. Grid and Flexbox are the same

**Answer: B**

Use Grid for 2D layouts (rows and columns together). Use Flexbox for 1D layouts (single row or column).

9. What does `fr` unit mean in Grid?
   - A. "Frame" - fixed pixel size
   - B. "Fraction" - portion of available space
   - C. "Free" - no width
   - D. "Full row"

**Answer: B**

`fr` stands for "fraction" - a portion of the available space in the grid container.

10. How do you make an element span all columns in a 3-column grid?
    - A. `grid-column: 1 / 4;`
    - B. `grid-column: span all;`
    - C. `width: 100%;`
    - D. `grid-column: full;`

**Answer: A**

`grid-column: 1 / 4;` starts at column line 1 and ends at line 4, spanning all 3 columns.

---

# Explanations

**Question 1:** To enable CSS Grid, use `display: grid;` on the container element.

```css
/* Correct - Enable Grid */
.grid-container {
    display: grid;
}

/* Wrong - Invalid properties */
layout: grid;        /* ❌ No such property */
grid: enabled;       /* ❌ Wrong syntax */
flex: grid;          /* ❌ Can't mix flex and grid */
```

**Complete barangay example:**
```html
<div class="services-grid">
    <div class="service">Barangay Clearance</div>
    <div class="service">Residency Certificate</div>
    <div class="service">Indigency</div>
</div>
```

```css
.services-grid {
    display: grid;                      /* Enable Grid */
    grid-template-columns: repeat(3, 1fr);  /* 3 columns */
    gap: 20px;                          /* Spacing */
}

.service {
    background: white;
    padding: 2rem;
    border-radius: 10px;
}
```

**Result:**
```
+-------------+-------------+-------------+
|  Barangay   | Residency   | Indigency   |
|  Clearance  | Certificate |             |
+-------------+-------------+-------------+
```

---

**Question 2:** `fr` (fraction) represents a **portion of available space**. `1fr 2fr 1fr` means the middle column is **twice as wide** as the left and right columns.

**Calculation:**
```
Total fractions: 1fr + 2fr + 1fr = 4fr

Column 1: 1fr = 1/4 = 25% of available space
Column 2: 2fr = 2/4 = 50% of available space
Column 3: 1fr = 1/4 = 25% of available space
```

**Visual (800px container):**
```
Column 1: 800px × 0.25 = 200px
Column 2: 800px × 0.50 = 400px
Column 3: 800px × 0.25 = 200px

+-------+--------------+-------+
| 200px |    400px     | 200px |
+-------+--------------+-------+
```

**Barangay layout example:**
```css
.page-layout {
    display: grid;
    grid-template-columns: 1fr 2fr 1fr;
    /*                     sidebar main ads */
}
```

**More fraction examples:**
```css
/* Equal columns */
grid-template-columns: 1fr 1fr 1fr;  /* 33.33% each */

/* First column twice as wide */
grid-template-columns: 2fr 1fr 1fr;  /* 50%, 25%, 25% */

/* Last column twice as wide */
grid-template-columns: 1fr 1fr 2fr;  /* 25%, 25%, 50% */
```

---

**Question 3:** To create **4 equal columns**, list `1fr` four times (or use `repeat()`).

**Correct options:**
```css
/* Option 1: List all columns */
grid-template-columns: 1fr 1fr 1fr 1fr;

/* Option 2: Use repeat() (better) */
grid-template-columns: repeat(4, 1fr);
```

**Both create the same result:**
```
+------+------+------+------+
| 25%  | 25%  | 25%  | 25%  |
+------+------+------+------+
```

**Barangay services example:**
```css
.services-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);  /* 4 equal columns */
    gap: 20px;
}
```

```html
<div class="services-grid">
    <div class="service">Clearance</div>
    <div class="service">Residency</div>
    <div class="service">Indigency</div>
    <div class="service">Permit</div>
</div>
```

**Wrong answers:**
```css
grid-template-columns: 4fr;  /* ❌ Only 1 column with 4fr width */
grid-template-columns: repeat(4);  /* ❌ Missing size parameter */
grid-columns: 4;  /* ❌ No such property */
```

**Repeat syntax:**
```css
repeat(count, size)
       ↓      ↓
       3      1fr  = 1fr 1fr 1fr
       5      100px = 100px 100px 100px 100px 100px
```

---

**Question 4:** The `gap` property creates **spacing between grid items** (like margin, but only between items, not around edges).

**CSS:**
```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;  /* 20px spacing between items */
}
```

**Visual:**
```
Without gap:
+---+---+---+
|   |   |   |
+---+---+---+

With gap: 20px:
+---+ +---+ +---+
|   | |   | |   |
+---+ +---+ +---+
  ↑    ↑    ↑
 20px  20px
```

**Separate row and column gaps:**
```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    row-gap: 20px;      /* Vertical spacing */
    column-gap: 30px;   /* Horizontal spacing */
}

/* Shorthand */
gap: 20px 30px;  /* row-gap column-gap */
```

**Barangay announcements:**
```css
.announcements-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1.5rem;  /* Clean spacing between cards */
}

.announcement {
    background: white;
    padding: 1.5rem;
    border-radius: 8px;
}
```

**Gap vs Margin:**
```css
/* Gap - Only between items */
gap: 20px;
+---+ +---+ +---+
|   | |   | |   |
+---+ +---+ +---+

/* Margin - Around all items (including edges) */
margin: 10px;
  +---+ +---+ +---+
  |   | |   | |   |
  +---+ +---+ +---+
↑               ↑
Extra margin on edges
```

---

**Question 5:** Use `grid-column: span 2;` to make an item **span 2 columns**.

**CSS:**
```css
.item1 {
    grid-column: span 2;  /* Span 2 columns */
}
```

**Visual:**
```
Normal 3-column grid:
+---+---+---+
| 1 | 2 | 3 |
+---+---+---+
| 4 | 5 | 6 |
+---+---+---+

With item1 spanning 2 columns:
+-------+---+
|   1   | 2 |
+-------+---+
| 3 | 4 | 5 |
+---+---+---+
```

**Barangay featured announcement:**
```html
<div class="announcements-grid">
    <div class="announcement featured">IMPORTANT: Town Hall Meeting</div>
    <div class="announcement">Vaccination</div>
    <div class="announcement">Basketball</div>
    <div class="announcement">Clean-Up</div>
</div>
```

```css
.announcements-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}

.announcement.featured {
    grid-column: span 2;  /* Spans 2 columns (larger!) */
    background: #1a73e8;
    color: white;
    font-size: 1.3rem;
}
```

**Alternative syntax (start/end lines):**
```css
.item {
    grid-column: 1 / 3;   /* Start at line 1, end at line 3 (spans 2 columns) */
}

/* Visual of grid lines:
    1    2    3    4
    |    |    |    |
    +----+----+----+
    | C1 | C2 | C3 |
    +----+----+----+

    grid-column: 1 / 3 spans from line 1 to 3 (columns 1-2)
    grid-column: 2 / 4 spans from line 2 to 4 (columns 2-3)
*/
```

**Spanning rows:**
```css
.item {
    grid-row: span 2;  /* Span 2 rows vertically */
}
```

---

**Question 6:** `repeat(3, 1fr)` creates **3 equal columns** (shorthand for `1fr 1fr 1fr`).

**Syntax:**
```css
repeat(count, size)
       ↓      ↓
```

**Examples:**
```css
/* 3 equal columns */
repeat(3, 1fr)
= 1fr 1fr 1fr

/* 4 columns of 100px */
repeat(4, 100px)
= 100px 100px 100px 100px

/* 2 columns: 200px and 1fr, repeated twice */
repeat(2, 200px 1fr)
= 200px 1fr 200px 1fr
```

**Barangay grid:**
```css
.services-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    /* Same as: 1fr 1fr 1fr */
    gap: 20px;
}
```

**Visual:**
```
+--------+--------+--------+
| 33.33% | 33.33% | 33.33% |
+--------+--------+--------+
```

**More repeat patterns:**
```css
/* 5 equal columns */
grid-template-columns: repeat(5, 1fr);

/* 3 columns: fixed, flexible, fixed */
grid-template-columns: 200px 1fr 200px;

/* 4 columns with pattern */
grid-template-columns: repeat(2, 1fr 2fr);
/* = 1fr 2fr 1fr 2fr */
```

---

**Question 7:** `repeat(auto-fit, minmax(250px, 1fr))` creates an **automatically responsive grid** where columns adjust based on available space.

**How it works:**

```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
}
```

**Breaking it down:**

1. **`auto-fit`**: Creates as many columns as fit in the container
2. **`minmax(250px, 1fr)`**: Each column is:
   - Minimum: 250px
   - Maximum: 1fr (grows to fill space)

**Responsive behavior (no media queries needed!):**

```
1200px screen:
+-----+-----+-----+-----+
| 250 | 250 | 250 | 250 |  (4 columns fit)
+-----+-----+-----+-----+

800px screen:
+-----+-----+-----+
| 250 | 250 | 250 |  (3 columns fit)
+-----+-----+-----+

600px screen:
+-----+-----+
| 300 | 300 |  (2 columns fit, grow to 300px)
+-----+-----+

300px screen:
+-----+
| 300 |  (1 column, grows to full width)
+-----+
```

**Barangay announcements auto-responsive:**
```css
.announcements-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
}

.announcement {
    background: white;
    padding: 1.5rem;
    border-radius: 8px;
}

/* No media queries needed! Automatically responsive! */
```

**Auto-fit vs Auto-fill:**
- **`auto-fit`**: Collapses empty tracks, stretches items to fill
- **`auto-fill`**: Keeps empty tracks, maintains grid structure

---

**Question 8:** Use **Grid for 2D layouts** (rows AND columns), **Flexbox for 1D layouts** (row OR column).

**Use Grid when:**
✅ Page layouts (header, sidebar, content, footer)
✅ Two-dimensional layouts
✅ Fixed grid structures (galleries)
✅ Complex overlapping layouts

**Use Flexbox when:**
✅ Navigation bars (1D row)
✅ Button groups (1D row)
✅ Simple alignment
✅ Content-driven sizing

**Grid example (2D page layout):**
```css
.page {
    display: grid;
    grid-template-columns: 250px 1fr;
    grid-template-rows: 80px 1fr 60px;
    grid-template-areas:
        "header  header"
        "sidebar main"
        "footer  footer";
}
```

**Visual:**
```
+-------------------+
|      Header       |  ← Spans both columns
+------+------------+
|Side- |   Main     |  ← Two columns
|bar   |   Content  |
|      |            |
+------+------------+
|      Footer       |  ← Spans both columns
+-------------------+
```

**Flexbox example (1D navbar):**
```css
.navbar {
    display: flex;
    justify-content: space-between;  /* Space between items */
    align-items: center;
}
```

**Visual:**
```
[Logo] [Link] [Link] [Link] [Button]
←-------------- Flexbox (1D row) --------------→
```

**Often used together:**
```css
/* Grid for overall page structure */
.page {
    display: grid;
    grid-template-areas: "header" "main" "footer";
}

/* Flexbox for navbar inside header */
.navbar {
    display: flex;
    justify-content: space-between;
}

/* Grid for services inside main */
.services {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
}
```

---

**Question 9:** `fr` stands for **"fraction"**—a portion of available space in the grid container.

**How it works:**

```css
grid-template-columns: 1fr 2fr 1fr;
/*                     ↑
                       fraction of available space
*/
```

**Calculation (1000px container):**
```
Total fractions: 1fr + 2fr + 1fr = 4fr

Column 1: 1/4 of 1000px = 250px
Column 2: 2/4 of 1000px = 500px
Column 3: 1/4 of 1000px = 250px
```

**Fr vs other units:**

```css
/* Pixels (fixed) */
grid-template-columns: 200px 200px 200px;
/* Always 200px, doesn't adapt */

/* Fr (flexible) */
grid-template-columns: 1fr 1fr 1fr;
/* Adapts to container width */

/* Mix fixed and flexible */
grid-template-columns: 200px 1fr 1fr;
/* First column fixed 200px, rest splits remaining space */
```

**Barangay example:**
```css
.page-layout {
    display: grid;
    grid-template-columns: 250px 2fr 1fr;
    /*                     sidebar main ads */
}
```

**On 1200px screen:**
- Sidebar: 250px (fixed)
- Remaining: 1200px - 250px = 950px
- Main: 950px × (2/3) = 633px
- Ads: 950px × (1/3) = 317px

---

**Question 10:** To span **all columns**, use `grid-column: 1 / 4;` (start at line 1, end at line 4).

**Grid line numbers:**

```
    1    2    3    4   ← Grid lines
    |    |    |    |
    +----+----+----+
    | C1 | C2 | C3 |   ← 3 columns
    +----+----+----+
```

**To span all 3 columns:**
```css
.header {
    grid-column: 1 / 4;  /* Start at line 1, end at line 4 */
}
```

**Visual:**
```
Normal 3-column grid:
+---+---+---+
| 1 | 2 | 3 |
+---+---+---+
| 4 | 5 | 6 |
+---+---+---+

With header spanning all columns:
+===========+
|  Header   |  ← Spans 1 to 4 (all columns)
+---+---+---+
| 1 | 2 | 3 |
+---+---+---+
```

**Barangay page layout:**
```css
.page-layout {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
}

.header {
    grid-column: 1 / 4;   /* Spans all 3 columns */
    background: #1a73e8;
    padding: 1.5rem;
}

.footer {
    grid-column: 1 / 4;   /* Spans all 3 columns */
    background: #333;
    color: white;
}
```

**Alternative syntaxes:**
```css
/* Start/end lines */
grid-column: 1 / 4;

/* Span count */
grid-column: span 3;

/* Start line and span */
grid-column: 1 / span 3;

/* Shorthand for "all columns" */
grid-column: 1 / -1;  /* -1 means last line */
```

---