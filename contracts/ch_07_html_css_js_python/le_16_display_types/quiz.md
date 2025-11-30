# Quiz 1

**Scenario:** Tian is styling navigation buttons for the barangay website.

1. Which display type takes up the full width and starts on a new line?
   - A. `display: inline;`
   - B. `display: block;`
   - C. `display: inline-block;`
   - D. `display: none;`

**Answer: B**

Block elements take up the full width available and automatically start on a new line. Each block element stacks vertically.

2. Rhea Joy wants three buttons side by side that accept width and height. Which display should she use?
   - A. `display: block;`
   - B. `display: inline;`
   - C. `display: inline-block;`
   - D. `display: flex;`

**Answer: C**

Inline-block is perfect for buttons or cards that need to be side by side while accepting width and height.

3. What happens when you set `width: 200px;` on an element with `display: inline;`?
   - A. The width is applied normally
   - B. The width is ignored
   - C. The element breaks
   - D. The element becomes block-level

**Answer: B**

Inline elements do NOT accept width or height. The browser ignores these properties on inline elements.

4. Which HTML element has `display: inline;` by default?
   - A. `<div>`
   - B. `<p>`
   - C. `<span>`
   - D. `<section>`

**Answer: C**

`<span>` is an inline element by default. `<div>`, `<p>`, and `<section>` are block-level elements.

5. What does `display: none;` do?
   - A. Makes element transparent
   - B. Completely hides element (takes no space)
   - C. Makes element invisible but keeps space
   - D. Disables element interactions

**Answer: B**

`display: none;` completely hides the element and it takes no space in the layout. It's as if the element doesn't exist.

---

# Quiz 2

**Scenario:** Tian created service cards for the barangay website:

```css
.card {
    display: inline-block;
    width: 200px;
    height: 150px;
}
```

6. Why might the cards not align at the top?
   - A. They need `margin-top: 0;`
   - B. They need `vertical-align: top;`
   - C. They need `display: block;`
   - D. They need `text-align: top;`

**Answer: B**

Inline-block elements default to `vertical-align: baseline;`. Use `vertical-align: top;` to align them at the top.

7. Which is TRUE about `display: inline-block;`?
   - A. Elements start on new lines
   - B. Elements flow side by side and accept width/height
   - C. Elements cannot have margins
   - D. Elements must be `<span>` tags

**Answer: B**

Inline-block elements flow side by side like inline elements, but accept width, height, and all margins/padding like block elements.

8. What's the difference between `display: none;` and `visibility: hidden;`?
   - A. They're the same
   - B. `display: none` takes no space, `visibility: hidden` takes space
   - C. `visibility: hidden` takes no space, `display: none` takes space
   - D. `display: none` is faster

**Answer: B**

`display: none` removes the element from layout (no space). `visibility: hidden` hides the element but keeps its space in the layout.

9. Which display type flows within text and does NOT accept top/bottom margins?
   - A. `block`
   - B. `inline`
   - C. `inline-block`
   - D. `none`

**Answer: B**

Inline elements flow within text and do NOT accept top/bottom margins or width/height. They only accept left/right margins.

10. Tian wants links in a navigation bar to be side by side with padding. Which is best?
    - A. `display: block;`
    - B. `display: inline;`
    - C. `display: inline-block;`
    - D. Keep default `display: inline;`

**Answer: C**

Use `display: inline-block;` for navigation links that need to be side by side with padding. It allows proper spacing control.

---

# Explanations

**Question 1:** **Block elements** take up the full width available (like a full row) and automatically start on a new line. Each block element stacks vertically.

```css
/* Block elements */
div, p, h1, section, header {
    display: block;  /* Default */
}
```

**Example:**
```html
<div>First block</div>    <!-- Takes full width, new line -->
<div>Second block</div>   <!-- Takes full width, new line -->
<div>Third block</div>    <!-- Takes full width, new line -->
```

Result: Three boxes stacked vertically, each taking full width

**Block characteristics:**
- ✅ Full width (100% of parent)
- ✅ Starts on new line
- ✅ Accepts width, height
- ✅ Accepts all margins/padding

---

**Question 2:** **Inline-block** is perfect for buttons or cards that need to be side by side while accepting width and height.

```css
.button {
    display: inline-block;   /* Side by side + size control */
    width: 150px;
    height: 50px;
    padding: 10px;
    margin: 5px;
}
```

**Comparison:**
```css
/* Block: Stacks vertically */
.button { display: block; }
/* Result: Each button on new line */

/* Inline: Side by side but NO width/height */
.button {
    display: inline;
    width: 150px;   /* IGNORED */
}

/* Inline-block: Side by side WITH width/height */
.button {
    display: inline-block;
    width: 150px;   /* WORKS! */
}
```

**Barangay example:**
```html
<a href="#" class="service-btn">Clearance</a>
<a href="#" class="service-btn">Residency</a>
<a href="#" class="service-btn">Indigency</a>
```

```css
.service-btn {
    display: inline-block;  /* Side by side */
    width: 180px;
    padding: 15px;
    background: #1a73e8;
    color: white;
    text-align: center;
}
```

---

**Question 3:** Inline elements **do NOT accept width or height**. The browser ignores these properties on inline elements.

```css
/* Inline element */
span {
    display: inline;
    width: 200px;     /* ❌ IGNORED */
    height: 100px;    /* ❌ IGNORED */
    margin-top: 20px; /* ❌ IGNORED */
}
```

**Why?** Inline elements flow with text. Setting width would break text flow.

**Solutions:**
```css
/* Option 1: Use inline-block */
span {
    display: inline-block;
    width: 200px;     /* ✅ Works */
}

/* Option 2: Use block */
span {
    display: block;
    width: 200px;     /* ✅ Works */
}
```

**What DOES work on inline elements:**
- ✅ `color`, `font-size`, `font-weight`
- ✅ `margin-left`, `margin-right` (horizontal margins)
- ✅ `padding` (but may overlap other content)
- ❌ `width`, `height`
- ❌ `margin-top`, `margin-bottom`

---

**Question 4:** `<span>` is an **inline element** by default. It flows within text without breaking lines.

**Default inline elements:**
```html
<span>inline</span>
<a href="#">inline</a>
<strong>inline</strong>
<em>inline</em>
<code>inline</code>
```

**Default block elements:**
```html
<div>block</div>
<p>block</p>
<h1>block</h1>
<section>block</section>
<header>block</header>
```

**Example:**
```html
<p>
    This is a paragraph with <span>inline span</span> 
    and <strong>inline strong</strong> that flow with the text.
</p>
```

The `<span>` and `<strong>` stay within the paragraph flow.

---

**Question 5:** `display: none;` completely removes the element from the page layout. It takes **no space** and is invisible.

```css
.hidden {
    display: none;  /* Completely hidden, no space */
}
```

**Visual example:**
```html
<div>Box 1</div>
<div class="hidden">Box 2 (display: none)</div>
<div>Box 3</div>
```

Result: You see Box 1, then Box 3. Box 2 is gone (no gap).

**Use cases:**
- Hide mobile menus (show with JavaScript)
- Conditional content
- Tooltips/modals (hidden by default)

---

**Question 6:** When using `inline-block`, elements align by their **baseline** (text baseline) by default. This causes misalignment if elements have different heights or content.

```css
/* Problem: Cards misaligned */
.card {
    display: inline-block;
}

/* Solution: Align tops */
.card {
    display: inline-block;
    vertical-align: top;  /* ✅ Aligns tops */
}
```

**vertical-align options:**
```css
vertical-align: top;      /* Align tops */
vertical-align: middle;   /* Align middles */
vertical-align: bottom;   /* Align bottoms */
vertical-align: baseline; /* Align text baselines (default) */
```

**Visual:**
```
Without vertical-align:     With vertical-align: top:
  +-------+                   +-------+
  | Card1 |                   | Card1 |
  |       | +-------+          |       |
  +-------+ | Card2 |          +-------+
            |       |          +-------+
            |       |          | Card2 |
            +-------+          |       |
   (misaligned)                |       |
                               +-------+
                               (aligned)
```

---

**Question 7:** `display: inline-block;` combines benefits of both inline and block:

**Inline-block characteristics:**
- ✅ Elements flow **side by side** (like inline)
- ✅ Accepts **width and height** (like block)
- ✅ Accepts **all margins and padding** (like block)
- ✅ Can be applied to **any element** (div, span, a, etc.)

```css
.card {
    display: inline-block;  /* Best of both! */
    width: 200px;           /* Works (like block) */
    height: 150px;          /* Works (like block) */
    margin: 10px;           /* Works on all sides (like block) */
    /* But flows side by side (like inline) */
}
```

**Comparison table:**
| Feature | inline | block | inline-block |
|---------|--------|-------|---------------|
| Side by side | ✅ | ❌ | ✅ |
| Width/Height | ❌ | ✅ | ✅ |
| All margins | ❌ | ✅ | ✅ |

---

**Question 8:** The key difference is **space taken**:

```css
/* display: none - No space, completely removed */
.hidden-none {
    display: none;
}

/* visibility: hidden - Takes space, just invisible */
.hidden-visibility {
    visibility: hidden;
}
```

**Visual example:**
```html
<div>Box 1</div>
<div style="display: none;">Box 2</div>
<div>Box 3</div>
<!-- Result: Box 1, Box 3 (no gap) -->

<div>Box 1</div>
<div style="visibility: hidden;">Box 2</div>
<div>Box 3</div>
<!-- Result: Box 1, [empty space], Box 3 (gap preserved) -->
```

**When to use each:**
- **`display: none`**: Menu toggles, modals, conditional content (truly hide)
- **`visibility: hidden`**: Preserve layout, temporary hiding, animations

**Analogy:**
- `display: none` = Removing a book from a shelf (shelf space reclaimed)
- `visibility: hidden` = Covering a book (book still takes shelf space)

---

**Question 9:** **Inline elements** flow within text and only accept **horizontal margins** (left/right), not vertical margins (top/bottom).

```css
span {
    display: inline;
    margin-left: 10px;    /* ✅ Works */
    margin-right: 10px;   /* ✅ Works */
    margin-top: 20px;     /* ❌ Ignored */
    margin-bottom: 20px;  /* ❌ Ignored */
}
```

**Why?** Inline elements flow with text lines. Vertical margins would disrupt text line height.

**Padding on inline elements:**
```css
span {
    display: inline;
    padding: 10px;  /* Technically works but may overlap */
}
```

Padding is applied but may visually overlap other lines of text.

**Solution if you need vertical spacing:**
```css
span {
    display: inline-block;  /* Now accepts all margins */
    margin: 20px 10px;
}
```

---

**Question 10:** For navigation bars, `inline-block` is best because:
1. Links appear **side by side**
2. You can set **padding** comfortably (creates clickable area)
3. You can set **width** if needed
4. Margins work on all sides

```css
/* Good: Inline-block navigation */
.nav-link {
    display: inline-block;
    padding: 10px 20px;     /* Comfortable click area */
    margin: 0 5px;          /* Space between links */
    background: #1a73e8;
    color: white;
    text-decoration: none;
    border-radius: 5px;
}

/* Not ideal: Plain inline */
.nav-link {
    display: inline;        /* Default for <a> */
    padding: 10px 20px;     /* May overlap */
    /* Can't control width reliably */
}
```

**Barangay navigation example:**
```html
<nav>
    <a href="#" class="nav-link">Home</a>
    <a href="#" class="nav-link">Services</a>
    <a href="#" class="nav-link">Announcements</a>
    <a href="#" class="nav-link">Contact</a>
</nav>
```

```css
.nav-link {
    display: inline-block;  /* Perfect for navigation */
    padding: 12px 24px;
    margin: 5px;
    background: #1a73e8;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    transition: background 0.3s;
}

.nav-link:hover {
    background: #1557b0;
}
```

**Modern alternative:** Use **flexbox** for even better control:
```css
nav {
    display: flex;
    gap: 10px;  /* Consistent spacing */
}
```

---