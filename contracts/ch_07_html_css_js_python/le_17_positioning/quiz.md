# Quiz 1

**Scenario:** Tian is adding positioning to the barangay website.

1. What is the default `position` value for all HTML elements?
   - A. `relative`
   - B. `absolute`
   - C. `static`
   - D. `fixed`

**Answer: C**

All HTML elements have `position: static;` by default. This means they follow normal document flow.

2. Rhea Joy wants a badge in the top-right corner of a card. Which positioning should she use?
   - A. Parent: `static`, Badge: `relative`
   - B. Parent: `relative`, Badge: `absolute`
   - C. Parent: `absolute`, Badge: `fixed`
   - D. Parent: `fixed`, Badge: `static`

**Answer: B**

Set parent to `position: relative;` (creates positioning context) and badge to `position: absolute;` (positions within parent).

3. What does `position: fixed;` do?
   - A. Positions element relative to its parent
   - B. Positions element relative to viewport and stays when scrolling
   - C. Positions element in normal flow
   - D. Makes element disappear

**Answer: B**

`position: fixed;` positions the element relative to the viewport (browser window) and it stays in place when scrolling.

4. Tian sets `position: relative; top: 20px;` on an element. What happens?
   - A. Element moves 20px up from its original position
   - B. Element moves 20px down from its original position
   - C. Element moves to top of page
   - D. Nothing happens

**Answer: B**

`top: 20px` with `position: relative` moves the element 20px down from its original position (positive values move down).

5. Which property controls stacking order when elements overlap?
   - A. `stack-order`
   - B. `layer`
   - C. `z-index`
   - D. `order`

**Answer: C**

`z-index` controls stacking order. Higher values appear on top. Only works on positioned elements (not `static`).

---

# Quiz 2

**Scenario:** Tian is creating a fixed navigation bar:

```css
.header {
    position: fixed;
    top: 0;
    width: 100%;
    height: 60px;
}
```

6. What problem might occur with this fixed header?
   - A. Header won't stay at top
   - B. Content will be hidden under the header
   - C. Header will scroll with page
   - D. Header will disappear

**Answer: B**

Fixed elements are removed from normal flow, so content starts at the top and gets hidden under the header. Add `padding-top: 60px;` to body to fix this.

7. What's the difference between `position: absolute;` and `position: relative;`?
   - A. They're the same
   - B. Absolute removes element from flow, relative keeps space
   - C. Relative removes element from flow, absolute keeps space
   - D. Absolute works with `top`, relative doesn't

**Answer: B**

`absolute` removes the element from flow (other elements behave as if it doesn't exist). `relative` keeps its space in the flow.

8. When does `z-index` work?
   - A. On any element
   - B. Only on positioned elements (not `static`)
   - C. Only on `fixed` elements
   - D. Only on `absolute` elements

**Answer: B**

`z-index` only works on positioned elements (`relative`, `absolute`, `fixed`, or `sticky`). It has no effect on `static` elements.

9. What does `position: sticky; top: 0;` do?
   - A. Acts like `fixed` immediately
   - B. Acts like `relative` until scrolling past threshold, then acts like `fixed`
   - C. Same as `position: static;`
   - D. Same as `position: absolute;`

**Answer: B**

`sticky` acts like `relative` until you scroll past it, then it "sticks" like `fixed`. Great for section headers.

10. Rhea Joy wants to center a modal dialog. Which CSS is correct?
    - A. `position: fixed; top: 50%; left: 50%;`
    - B. `position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);`
    - C. `position: relative; margin: auto;`
    - D. `position: static; text-align: center;`

**Answer: B**

Use `top: 50%; left: 50%;` to position at center, then `transform: translate(-50%, -50%);` to offset by element's own dimensions for perfect centering.

---

# Explanations

**Question 1:** All HTML elements have `position: static;` by default. This means they follow **normal document flow**—block elements stack vertically, inline elements flow horizontally.

```css
/* Every element starts like this */
div {
    position: static;  /* Default */
}
```

**Normal flow characteristics:**
- Elements appear in order they're written in HTML
- Block elements take full width, stack vertically
- `top`, `right`, `bottom`, `left` have **no effect**
- No overlapping (unless using margins/transforms)

**To use positioning features**, change to `relative`, `absolute`, `fixed`, or `sticky`.

---

**Question 2:** To position a badge in the corner of a card, use **parent `relative`** and **badge `absolute`**.

```css
/* Parent establishes positioning context */
.card {
    position: relative;  /* Creates context */
}

/* Badge positions absolutely within parent */
.badge {
    position: absolute;  /* Removed from flow */
    top: 10px;           /* 10px from parent's top */
    right: 10px;         /* 10px from parent's right */
}
```

**Why this works:**
- `position: relative` on parent makes it the **positioning context**
- `position: absolute` on child positions it **relative to that parent**
- Badge doesn't push other content (removed from flow)

**Barangay example:**
```html
<div class="announcement-card">
    <span class="urgent-badge">URGENT</span>
    <h3>Emergency Alert</h3>
    <p>Classes suspended due to typhoon.</p>
</div>
```

```css
.announcement-card {
    position: relative;  /* ✅ Context */
    padding: 20px;
}

.urgent-badge {
    position: absolute;  /* ✅ Positioned within card */
    top: 15px;
    right: 15px;
    background: #dc3545;
    color: white;
    padding: 5px 12px;
    border-radius: 5px;
}
```

---

**Question 3:** `position: fixed;` positions the element **relative to the viewport** (browser window) and it **stays in place when scrolling**.

```css
.navbar {
    position: fixed;
    top: 0;          /* Stick to top of viewport */
    left: 0;
    width: 100%;
}
```

**Fixed positioning characteristics:**
- ✅ Removed from normal flow
- ✅ Positioned relative to **viewport** (not parent)
- ✅ **Stays in place when scrolling**
- ✅ Other elements behave as if it doesn't exist

**Common uses:**
- Fixed navigation bars
- "Back to top" buttons
- Chat widgets
- Cookie consent banners

**Barangay example:**
```css
/* Fixed header that stays at top */
.header {
    position: fixed;
    top: 0;
    width: 100%;
    background: #1a73e8;
    z-index: 100;
}

/* Fixed "Back to Top" button */
.back-to-top {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background: #1a73e8;
    color: white;
    width: 50px;
    height: 50px;
    border-radius: 50%;
}
```

---

**Question 4:** With `position: relative;`, the `top` property moves the element **down** (positive values) or **up** (negative values) from its **original position**.

```css
.box {
    position: relative;
    top: 20px;     /* Moves 20px DOWN */
    left: 10px;    /* Moves 10px RIGHT */
}
```

**Think of it as push/pull:**
- `top: 20px` = Push **away from top** = moves **down** 20px
- `bottom: 20px` = Push **away from bottom** = moves **up** 20px
- `left: 10px` = Push **away from left** = moves **right** 10px
- `right: 10px` = Push **away from right** = moves **left** 10px

**Important:** Original space is **preserved**—other elements don't move.

**Visual:**
```
Original position:     After top: 20px:
+-------+              +-------+
| Box 1 |              | Box 1 |
+-------+              +-------+
+-------+              [gap]
| Box 2 |              +-------+
+-------+              | Box 2 | <-- Shifted down
+-------+              +-------+
| Box 3 |              +-------+
+-------+              | Box 3 |
                       +-------+
```

---

**Question 5:** The `z-index` property controls **stacking order** when elements overlap. Higher values appear **in front** of lower values.

```css
.background {
    position: relative;
    z-index: 1;      /* Behind */
}

.content {
    position: relative;
    z-index: 10;     /* In front of background */
}

.modal {
    position: fixed;
    z-index: 1000;   /* In front of everything */
}
```

**Z-index rules:**
1. Only works on **positioned elements** (`relative`, `absolute`, `fixed`, `sticky`)
2. Higher number = closer to viewer
3. Default is `auto` (stacking based on HTML order)

**Common z-index scale:**
```css
/* Base content */
.content { z-index: 1; }

/* Dropdowns/tooltips */
.dropdown { z-index: 100; }

/* Fixed headers */
.header { z-index: 500; }

/* Modals/overlays */
.modal-overlay { z-index: 1000; }
.modal { z-index: 1001; }
```

**Barangay example:**
```css
.announcement-card { position: relative; z-index: 1; }
.urgent-badge { position: absolute; z-index: 10; }  /* Badge on top */
.header { position: fixed; z-index: 100; }  /* Header above cards */
```

---

**Question 6:** With a fixed header at `top: 0`, the page content will **start behind the header**, hiding the top portion.

```css
/* Problem: Content hidden */
.header {
    position: fixed;
    top: 0;
    height: 60px;
}
/* First section's content is hidden under header! */
```

**Solution: Add padding to body**
```css
.header {
    position: fixed;
    top: 0;
    height: 60px;
}

body {
    padding-top: 60px;  /* Same as header height */
}
```

This pushes all content down so it starts **below** the fixed header.

**Barangay example:**
```css
.header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 70px;
    background: #1a73e8;
    z-index: 100;
}

body {
    padding-top: 70px;  /* Prevents content from hiding */
}
```

---

**Question 7:** The key difference:
- **`position: absolute`**: Removes element from flow, no space reserved
- **`position: relative`**: Keeps space in flow, element can be offset

**Visual comparison:**
```css
/* Relative: Space preserved */
.box {
    position: relative;
    top: 20px;  /* Shifts but leaves gap */
}
```

```
+-------+
| Box 1 |
+-------+
[gap]        <-- Original space preserved
+-------+
| Box 2 | <-- Shifted down
+-------+
+-------+
| Box 3 |    <-- Doesn't move up
+-------+
```

```css
/* Absolute: Space NOT preserved */
.box {
    position: absolute;
    top: 50px;  /* No gap left behind */
}
```

```
+-------+
| Box 1 |
+-------+
+-------+
| Box 3 |    <-- Moves up (Box 2 removed from flow)
+-------+

[Box 2 floats at top: 50px from parent]
```

**When to use:**
- **Relative**: Nudge elements slightly, create positioning context
- **Absolute**: Badges, overlays, tooltips (removed from flow)

---

**Question 8:** `z-index` **only works on positioned elements**—elements with `position` set to anything **except `static`**.

```css
/* Won't work - element is static */
.element {
    z-index: 100;  /* ❌ Ignored */
}

/* Works - element is positioned */
.element {
    position: relative;  /* or absolute, fixed, sticky */
    z-index: 100;        /* ✅ Works */
}
```

**Why?** In normal flow (`static`), elements don't overlap, so z-index is meaningless.

**Quick fix for z-index issues:**
```css
/* If z-index not working, add position */
.element {
    position: relative;  /* Minimal positioning */
    z-index: 10;         /* Now works */
}
```

---

**Question 9:** `position: sticky;` is a **hybrid**: it acts like **`relative`** until you scroll past a threshold, then it acts like **`fixed`**.

```css
.section-header {
    position: sticky;
    top: 0;  /* When scroll reaches top, it sticks */
}
```

**Behavior:**
1. **Before scrolling past:** Acts like `relative` (normal flow)
2. **After scrolling past `top` threshold:** Acts like `fixed` (sticks in place)
3. **When scrolling back:** Returns to relative behavior

**Requirements:**
- Must specify `top`, `bottom`, `left`, or `right`
- Parent must have scrollable content

**Barangay example:**
```css
/* Sticky navigation that sticks after scrolling */
.nav {
    position: sticky;
    top: 0;
    background: #1a73e8;
    z-index: 100;
}

/* Sticky section headers */
.section-header {
    position: sticky;
    top: 70px;  /* Below fixed header */
    background: #f5f5f5;
}
```

**Visual:**
```
Before scrolling:        After scrolling:
+-------------------+    +-------------------+
| Header            |    | Header (sticky)   | <-- Stuck at top
+-------------------+    +-------------------+
| Content...        |    | More content...   |
| More content...   |    | Even more...      |
```

---

**Question 10:** To **perfectly center** a modal, use `position: absolute`, set `top: 50%; left: 50%;`, then use `transform: translate(-50%, -50%)` to shift it back.

```css
.modal {
    position: absolute;  /* or fixed */
    top: 50%;            /* Move to middle vertically */
    left: 50%;           /* Move to middle horizontally */
    transform: translate(-50%, -50%);  /* Shift back by half its size */
}
```

**Why transform?**
- `top: 50%` positions the **top edge** at center
- `left: 50%` positions the **left edge** at center
- Element is off-center by half its size
- `translate(-50%, -50%)` shifts it back to true center

**Visual:**
```
top: 50%; left: 50% only:    With transform:
        |
   -----+-------              +-----------+
        |                     |   Modal   |
        +------+              |  (center) |
        | Modal|              +-----------+
        +------+
```

**Complete modal example:**
```css
/* Dark overlay */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
    z-index: 1000;
}

/* Centered modal */
.modal-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: white;
    padding: 30px;
    border-radius: 10px;
    max-width: 500px;
    z-index: 1001;
}
```

---