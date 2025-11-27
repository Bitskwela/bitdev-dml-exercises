# Quiz 1

**Scenario:** Tian is learning about the CSS Box Model to improve spacing on the barangay website.

1. What are the four layers of the CSS Box Model (from inside to outside)?
   - A. Content, Border, Padding, Margin
   - B. Content, Padding, Border, Margin
   - C. Margin, Border, Padding, Content
   - D. Content, Margin, Padding, Border

2. Rhea Joy wants to add space **inside** an element, between the content and border. Which property should she use?
   - A. `margin`
   - B. `padding`
   - C. `border-spacing`
   - D. `gap`

3. What does this CSS do? `margin: 20px 10px;`
   - A. 20px on all sides, 10px on top
   - B. 20px top, 10px right/bottom/left
   - C. 20px top/bottom, 10px left/right
   - D. 20px left/right, 10px top/bottom

4. Tian wants to center a container horizontally. Which CSS should he use?
   - A. `margin: auto;`
   - B. `margin: 0 auto;`
   - C. `padding: 0 auto;`
   - D. `text-align: center;`

5. What does `border-radius: 50%;` do to a square element?
   - A. Makes it slightly rounded
   - B. Makes it a circle
   - C. Makes it an oval
   - D. Has no visible effect

---

# Quiz 2

**Scenario:** Tian created this CSS for a card:

```css
.card {
    width: 300px;
    padding: 20px;
    border: 5px solid black;
}
```

6. Without `box-sizing: border-box;`, what is the **total width** of the card?
   - A. 300px
   - B. 340px
   - C. 350px
   - D. 360px

7. What does `box-sizing: border-box;` do?
   - A. Removes padding and border
   - B. Makes padding and border part of the width
   - C. Doubles the element's width
   - D. Centers the element

8. Which property creates space **outside** an element, between it and other elements?
   - A. `padding`
   - B. `border`
   - C. `margin`
   - D. `gap`

9. What does `padding: 10px 20px 30px 40px;` mean?
   - A. 10px all sides, others ignored
   - B. 10px top, 20px right, 30px bottom, 40px left
   - C. 10px left, 20px top, 30px right, 40px bottom
   - D. Invalid CSS syntax

10. Rhea Joy wants rounded corners only on the top. Which CSS is correct?
    - A. `border-radius: 10px 10px 0 0;`
    - B. `border-radius: 0 0 10px 10px;`
    - C. `border-radius: 10px 0;`
    - D. `border-top-radius: 10px;`

---

# Answers

1. **B** - Content, Padding, Border, Margin
2. **B** - `padding`
3. **C** - 20px top/bottom, 10px left/right
4. **B** - `margin: 0 auto;`
5. **B** - Makes it a circle
6. **C** - 350px
7. **B** - Makes padding and border part of the width
8. **C** - `margin`
9. **B** - 10px top, 20px right, 30px bottom, 40px left
10. **A** - `border-radius: 10px 10px 0 0;`

---

# Explanations

**Question 1:** The CSS Box Model has four layers **from inside to outside**: **Content** (text/images) → **Padding** (space inside border) → **Border** (outline) → **Margin** (space outside border).

```
+--------------------------------+
|         MARGIN (outside)       |
|  +--------------------------+  |
|  |     BORDER (outline)     |  |
|  |  +--------------------+  |  |
|  |  |  PADDING (inside)  |  |  |
|  |  |  +--------------+  |  |  |
|  |  |  |   CONTENT    |  |  |  |
|  |  |  +--------------+  |  |  |
|  |  +--------------------+  |  |
|  +--------------------------+  |
+--------------------------------+
```

**Mnemonic:** **C**ontent **P**adding **B**order **M**argin (inside → outside)

---

**Question 2:** **Padding** creates space **inside** an element, between the content and the border. It increases the element's internal spacing while keeping the background color.

```css
/* Padding adds space INSIDE */
.announcement {
    padding: 20px;              /* Space inside the box */
    background-color: yellow;   /* Background extends to padding */
    border: 2px solid black;
}

/* Margin adds space OUTSIDE */
.announcement {
    margin: 20px;               /* Space outside the box */
    background-color: yellow;   /* Background does NOT extend to margin */
}
```

**Visual difference:**
```html
<div class="with-padding">Text</div>
<div class="with-margin">Text</div>
```

- **Padding**: Yellow background extends around text
- **Margin**: Yellow background stops at border, transparent space outside

---

**Question 3:** When padding/margin has **two values**, the first is **vertical** (top/bottom) and the second is **horizontal** (left/right).

```css
/* Two values: Vertical | Horizontal */
margin: 20px 10px;
/* Same as: */
margin-top: 20px;
margin-right: 10px;
margin-bottom: 20px;
margin-left: 10px;
```

**All shorthand patterns:**
```css
margin: 10px;                    /* All 4 sides: 10px */
margin: 10px 20px;               /* Vertical | Horizontal */
margin: 10px 20px 30px;          /* Top | Horizontal | Bottom */
margin: 10px 20px 30px 40px;     /* Top | Right | Bottom | Left (clockwise) */
```

**Mnemonic:** TRouBLe (Top, Right, Bottom, Left) - goes clockwise

---

**Question 4:** To center an element horizontally, use `margin: 0 auto;`. This sets top/bottom margin to 0 and left/right margin to `auto`, which automatically calculates equal space on both sides.

```css
.container {
    width: 800px;         /* Must have a width */
    margin: 0 auto;       /* 0 top/bottom, auto left/right = centered */
}

/* Same as: */
.container {
    width: 800px;
    margin-left: auto;
    margin-right: auto;
}
```

**Requirements for centering:**
1. Element must have a **width** (or `max-width`)
2. Element must be a **block-level** element
3. Left/right margins set to `auto`

**Barangay example:**
```css
.announcement {
    max-width: 600px;     /* Maximum width */
    margin: 20px auto;    /* 20px vertical, centered horizontal */
}
```

---

**Question 5:** `border-radius: 50%;` creates a **circle** when applied to a square element (width = height). The 50% means the radius is half the element's size.

```css
/* Make a circle */
.circle {
    width: 100px;
    height: 100px;        /* Same as width */
    border-radius: 50%;   /* Perfect circle */
    background-color: blue;
}

/* If width ≠ height, you get an oval */
.oval {
    width: 150px;
    height: 100px;        /* Different from width */
    border-radius: 50%;   /* Oval shape */
}

/* Rounded corners */
.rounded {
    width: 200px;
    height: 100px;
    border-radius: 10px;  /* Slightly rounded corners */
}
```

**Profile picture example:**
```css
.avatar {
    width: 80px;
    height: 80px;
    border-radius: 50%;   /* Circular avatar */
    border: 3px solid white;
}
```

---

**Question 6:** Without `box-sizing: border-box`, the `width` property applies **only to the content area**. Padding and border are **added** to the width.

```css
.card {
    width: 300px;           /* Content width */
    padding: 20px;          /* 20px left + 20px right = 40px */
    border: 5px solid black; /* 5px left + 5px right = 10px */
}
```

**Total width calculation:**
- Content: 300px
- Padding: 20px (left) + 20px (right) = 40px
- Border: 5px (left) + 5px (right) = 10px
- **Total: 300 + 40 + 10 = 350px**

**Visual:**
```
|<--5px-->|<--20px-->|<------ 300px ------>|<--20px-->|<--5px-->|
| Border  | Padding  |      Content        | Padding  | Border  |
|<--------------------- 350px total ----------------------->|
```

---

**Question 7:** `box-sizing: border-box;` changes how width is calculated. It makes **padding and border part of the width**, not added to it.

```css
/* Default: box-sizing: content-box */
.card {
    width: 300px;           /* Content only */
    padding: 20px;          /* Added to width */
    border: 5px solid black; /* Added to width */
    /* Total width: 350px */
}

/* With box-sizing: border-box */
.card {
    box-sizing: border-box;
    width: 300px;           /* Includes padding and border */
    padding: 20px;
    border: 5px solid black;
    /* Total width: 300px */
    /* Content shrinks to: 300 - 40 - 10 = 250px */
}
```

**Best practice - apply globally:**
```css
* {
    box-sizing: border-box;
}
```

This makes layout calculations much easier and more intuitive!

---

**Question 8:** **Margin** creates space **outside** the element, between it and other elements. It's transparent (no background color).

```css
/* Margin - space OUTSIDE */
.card {
    margin: 20px;              /* 20px space around the card */
    background-color: white;
}

/* The 20px margin area is transparent */
```

**Comparison:**
```css
.card {
    /* INSIDE the element (has background) */
    padding: 20px;
    
    /* The border line */
    border: 2px solid black;
    
    /* OUTSIDE the element (transparent) */
    margin: 20px;
}
```

**Use cases:**
- **Padding**: Space inside buttons, cards (has background)
- **Margin**: Space between sections, separate elements (transparent)

---

**Question 9:** When you use **four values** for padding or margin, they apply in **clockwise order**: **Top, Right, Bottom, Left** (TRouBLe).

```css
padding: 10px 20px 30px 40px;
/*       ↑    ↑    ↑    ↑
        Top  Right Bottom Left  */

/* Same as: */
padding-top: 10px;
padding-right: 20px;
padding-bottom: 30px;
padding-left: 40px;
```

**Visual:**
```
         10px (top)
          │
          v
    +-------------+
40px|             | 20px
 <--|   CONTENT   |--> (right)
    |             |
    +-------------+
          ^
          │
        30px (bottom)
```

**Mnemonic:** **TRouBLe** starts at **T**op and goes clockwise like a clock

---

**Question 10:** `border-radius` with **four values** applies to corners in clockwise order: **top-left, top-right, bottom-right, bottom-left**.

```css
/* Rounded top corners only */
border-radius: 10px 10px 0 0;
/*             ↑    ↑   ↑ ↑
          top-left  |   | bottom-left
                top-right|
                  bottom-right */

/* Same as: */
border-top-left-radius: 10px;
border-top-right-radius: 10px;
border-bottom-right-radius: 0;
border-bottom-left-radius: 0;
```

**Visual:**
```
top-left -------- top-right
   10px    TOP      10px
    ┌────────────┐
    |              |
    |   CONTENT    |
    |              |
    └────────────┘
    0px   BOTTOM   0px
bottom-left ---- bottom-right
```

**Common patterns:**
```css
/* All corners rounded */
border-radius: 10px;

/* Top rounded, bottom sharp */
border-radius: 10px 10px 0 0;

/* Bottom rounded, top sharp */
border-radius: 0 0 10px 10px;

/* Pill shape (left/right rounded) */
border-radius: 25px;
```

---