# Quiz 1

**Scenario:** Tian is styling the barangay website. He wants to make all paragraph text blue.

1. Which CSS selector should Tian use to target **all** `<p>` elements?
   - A. `.p { color: blue; }`
   - B. `p { color: blue; }`
   - C. `#p { color: blue; }`
   - D. `<p> { color: blue; }`

**Answer: B**

The element selector targets all elements of a specific HTML tag without any prefix. Classes use a dot (`.`), IDs use a hash (`#`), and you never use angle brackets in CSS selectors.

2. Rhea Joy created this HTML: `<div class="announcement">Meeting today</div>`. Which CSS selector targets this element?
   - A. `#announcement { }`
   - B. `announcement { }`
   - C. `.announcement { }`
   - D. `div.announcement { }`

**Answer: C**

Class selectors always start with a dot (`.`). The HTML `class="announcement"` is targeted with `.announcement` in CSS. Option D would also work but is more specific than necessary.

3. Tian has this HTML: `<h1 id="main-title">Barangay San Miguel</h1>`. Which selector is correct?
   - A. `.main-title { }`
   - B. `#main-title { }`
   - C. `main-title { }`
   - D. `id.main-title { }`

**Answer: B**

ID selectors always start with a hash (`#`). The HTML `id="main-title"` is targeted with `#main-title` in CSS. Remember: IDs must be unique on a page.

4. What does this CSS selector do? `div p { color: red; }`
   - A. Selects all `<div>` and all `<p>` elements
   - B. Selects only `<p>` elements that are inside `<div>` elements
   - C. Selects `<div>` elements with class "p"
   - D. This is invalid CSS syntax

**Answer: B**

The space between `div` and `p` creates a descendant selector. It means "select all `<p>` elements that are anywhere inside a `<div>` element (child, grandchild, etc.)."

5. Rhea Joy wants the same font for all headings. Which is most efficient?
   - A. `h1 { font-family: Arial; } h2 { font-family: Arial; } h3 { font-family: Arial; }`
   - B. `h1, h2, h3 { font-family: Arial; }`
   - C. `.h1, .h2, .h3 { font-family: Arial; }`
   - D. `#h1, #h2, #h3 { font-family: Arial; }`

**Answer: B**

Multiple selectors (grouping) let you apply the same styles to different elements by separating them with commas. This is much more efficient than repeating the same style rules.

---

# Quiz 2

**Scenario:** Tian created the following HTML and CSS for the barangay website:

```html
<p id="intro" class="highlight">Welcome to our barangay!</p>
```

```css
p { color: black; }
.highlight { color: green; }
#intro { color: blue; }
```

6. What color will the paragraph text be?
   - A. Black
   - B. Green
   - C. Blue
   - D. The default browser color

**Answer: C**

The text will be blue because of specificity. When multiple rules target the same element, the priority is: Inline styles > IDs > Classes > Elements. Since `#intro` is an ID selector, it has higher priority than `.highlight` (class) and `p` (element).

7. Which CSS property controls the space between lines of text?
   - A. `letter-spacing`
   - B. `line-height`
   - C. `text-spacing`
   - D. `line-spacing`

**Answer: B**

`line-height` controls the vertical space between lines of text. `letter-spacing` controls horizontal space between individual characters.

8. Tian wrote `color: rgb(255, 0, 0);`. What color is this?
   - A. Blue
   - B. Green
   - C. Red
   - D. Yellow

**Answer: C**

RGB stands for Red, Green, Blue. `rgb(255, 0, 0)` means maximum red (255), no green (0), no blue (0) = Red.

9. What does this CSS do? `.announcement.urgent { border: 2px solid red; }`
   - A. Selects `.announcement` OR `.urgent` elements
   - B. Selects `.urgent` elements inside `.announcement` elements
   - C. Selects elements that have BOTH classes `announcement` and `urgent`
   - D. This is invalid CSS

**Answer: C**

When class selectors are written together without a space (`.announcement.urgent`), it selects elements that have BOTH classes. A space would create a descendant selector instead.

10. Which unit is relative to the parent element's font size?
    - A. `px` (pixels)
    - B. `em`
    - C. `%` (percentage)
    - D. `pt` (points)

**Answer: B**

`em` is relative to the parent element's font size. `1em` = parent's font size, `2em` = twice the parent's font size. `px` is absolute, not relative.

---

# Explanations

**Question 1:** The **element selector** targets all elements of a specific HTML tag without any prefix. Classes use a dot (`.`), IDs use a hash (`#`), and you never use angle brackets in CSS selectors.

```css
/* Element selector - no prefix */
p { color: blue; }

/* Class selector - dot prefix */
.highlight { color: yellow; }

/* ID selector - hash prefix */
#header { background: blue; }
```

---

**Question 2:** **Class selectors** always start with a dot (`.`). The HTML `class="announcement"` is targeted with `.announcement` in CSS. Option D (`div.announcement`) would also work but is more specific than necessary.

```html
<div class="announcement">Meeting today</div>
```

```css
/* Correct - targets any element with class="announcement" */
.announcement {
    background-color: yellow;
}

/* Also works but more specific */
div.announcement {
    background-color: yellow;
}
```

---

**Question 3:** **ID selectors** always start with a hash (`#`). The HTML `id="main-title"` is targeted with `#main-title` in CSS. Remember: IDs must be unique on a page.

```html
<h1 id="main-title">Barangay San Miguel</h1>
```

```css
/* Correct ID selector */
#main-title {
    font-size: 2em;
    color: blue;
}
```

---

**Question 4:** The space between `div` and `p` creates a **descendant selector**. It means "select all `<p>` elements that are anywhere inside a `<div>` element (child, grandchild, etc.)."

```html
<div>
    <p>This will be red</p>
    <section>
        <p>This will also be red (grandchild)</p>
    </section>
</div>
<p>This will NOT be red (not inside a div)</p>
```

```css
div p {
    color: red; /* Only affects <p> inside <div> */
}
```

---

**Question 5:** **Multiple selectors** (grouping) let you apply the same styles to different elements by separating them with commas. This is much more efficient than repeating the same style rules.

```css
/* Efficient - one rule for all */
h1, h2, h3 {
    font-family: Arial;
}

/* Inefficient - repeated rules */
h1 { font-family: Arial; }
h2 { font-family: Arial; }
h3 { font-family: Arial; }
```

---

**Question 6:** The text will be **blue** because of **specificity**. When multiple rules target the same element, the priority is: Inline styles > IDs > Classes > Elements. Since `#intro` is an ID selector, it has higher priority than `.highlight` (class) and `p` (element).

```css
p { color: black; }         /* Priority: 1 */
.highlight { color: green; } /* Priority: 10 */
#intro { color: blue; }      /* Priority: 100 - WINS */
```

**Specificity hierarchy:**
1. Inline: `<p style="color: red;">` (1000)
2. ID: `#intro` (100)
3. Class: `.highlight` (10)
4. Element: `p` (1)

---

**Question 7:** The `line-height` property controls the vertical space between lines of text. It's like the leading in typography. `letter-spacing` controls horizontal space between letters.

```css
p {
    line-height: 1.6;      /* 1.6 times the font size */
    letter-spacing: 2px;   /* 2px between letters */
}
```

---

**Question 8:** RGB stands for Red-Green-Blue. The values range from 0-255. `rgb(255, 0, 0)` means maximum red (255), no green (0), no blue (0) = **red**.

```css
.red { color: rgb(255, 0, 0); }      /* Pure red */
.green { color: rgb(0, 255, 0); }    /* Pure green */
.blue { color: rgb(0, 0, 255); }     /* Pure blue */
.yellow { color: rgb(255, 255, 0); } /* Red + Green = Yellow */
.white { color: rgb(255, 255, 255); }/* All colors = White */
.black { color: rgb(0, 0, 0); }      /* No colors = Black */
```

---

**Question 9:** When you write two classes **without a space** (`.announcement.urgent`), it selects elements that have **BOTH** classes. With a space (`.announcement .urgent`), it would select `.urgent` elements **inside** `.announcement` elements.

```html
<!-- This element will be selected -->
<div class="announcement urgent">Emergency!</div>

<!-- These will NOT be selected -->
<div class="announcement">Regular announcement</div>
<div class="urgent">Just urgent</div>
```

```css
/* No space = BOTH classes required */
.announcement.urgent {
    border: 2px solid red;
}

/* With space = nested elements */
.announcement .urgent {
    /* Selects .urgent INSIDE .announcement */
}
```

---

**Question 10:** The `em` unit is relative to the **parent element's font size**. If the parent has `font-size: 16px`, then `1em = 16px`, `2em = 32px`, etc. This is useful for scalable designs.

```css
body {
    font-size: 16px; /* Base size */
}

h1 {
    font-size: 2em;  /* 2 × 16px = 32px */
}

p {
    font-size: 1em;  /* 1 × 16px = 16px */
}

small {
    font-size: 0.8em; /* 0.8 × 16px = 12.8px */
}
```

**Other units:**
- `px`: Fixed size (16px is always 16 pixels)
- `rem`: Relative to root (html) element's font size
- `%`: Relative to parent (50% width means half of parent's width)

---