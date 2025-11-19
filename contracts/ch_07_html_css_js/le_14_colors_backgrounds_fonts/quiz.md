# Quiz 1

**Scenario:** Tian and Rhea Joy are styling the barangay website with colors and fonts.

1. Which CSS code will make text red?
   - A. `color: red;`
   - B. `text-color: red;`
   - C. `font-color: red;`
   - D. `text: red;`

2. What does `rgba(255, 0, 0, 0.5)` represent?
   - A. Fully opaque red
   - B. 50% transparent red
   - C. Fully transparent red
   - D. Invalid CSS syntax

3. Rhea Joy wants to use a custom font from Google Fonts. What should she add to the HTML?
   - A. `<font src="https://fonts.googleapis.com/...">`
   - B. `<script src="https://fonts.googleapis.com/..."></script>`
   - C. `<link href="https://fonts.googleapis.com/..." rel="stylesheet">`
   - D. `<style src="https://fonts.googleapis.com/..."></style>`

4. What does `background-size: cover;` do?
   - A. Shows the image at its original size
   - B. Scales the image to cover the entire area (may crop)
   - C. Repeats the image to fill the area
   - D. Centers the image

5. Which font category has decorative strokes?
   - A. `sans-serif`
   - B. `monospace`
   - C. `serif`
   - D. `cursive`

---

# Quiz 2

**Scenario:** Tian is refining the barangay website's typography and colors.

6. What is the correct way to specify a hexadecimal color?
   - A. `color: rgb(255, 0, 0);`
   - B. `color: #ff0000;`
   - C. `color: hex(ff0000);`
   - D. `color: 0xff0000;`

7. Rhea Joy wants text to be bold. Which CSS property should she use?
   - A. `text-weight: bold;`
   - B. `font-weight: bold;`
   - C. `text-style: bold;`
   - D. `font-bold: true;`

8. What does `text-transform: uppercase;` do?
   - A. Makes text bold
   - B. Converts text to UPPERCASE
   - C. Increases text size
   - D. Underlines text

9. Which CSS creates a background image that doesn't repeat?
   - A. `background-image: url('image.jpg'); background-repeat: none;`
   - B. `background: url('image.jpg') repeat-none;`
   - C. `background-image: url('image.jpg'); background-repeat: no-repeat;`
   - D. `background: url('image.jpg') no-tile;`

10. What unit is relative to the root (html) element's font size?
    - A. `em`
    - B. `px`
    - C. `rem`
    - D. `%`

---

# Answers

1. **A** - `color: red;`
2. **B** - 50% transparent red
3. **C** - `<link href="https://fonts.googleapis.com/..." rel="stylesheet">`
4. **B** - Scales the image to cover the entire area (may crop)
5. **C** - `serif`
6. **B** - `color: #ff0000;`
7. **B** - `font-weight: bold;`
8. **B** - Converts text to UPPERCASE
9. **C** - `background-image: url('image.jpg'); background-repeat: no-repeat;`
10. **C** - `rem`

---

# Explanations

**Question 1:** The correct CSS property for text color is `color`. There is no `text-color`, `font-color`, or `text` property for colors in CSS.

```css
/* Correct ways to set text color */
h1 {
    color: red;           /* Color name */
    color: #ff0000;       /* Hex */
    color: rgb(255,0,0);  /* RGB */
}

/* Wrong - these don't exist */
h1 {
    text-color: red;   /* ❌ Not a valid property */
    font-color: red;   /* ❌ Not a valid property */
}
```

---

**Question 2:** RGBA stands for Red-Green-Blue-Alpha. The fourth value (alpha) controls transparency: `0.0` = fully transparent, `1.0` = fully opaque. So `rgba(255, 0, 0, 0.5)` is **50% transparent red**.

```css
/* Alpha channel examples */
.fully-opaque {
    background-color: rgba(255, 0, 0, 1.0);    /* 100% opaque red */
}

.semi-transparent {
    background-color: rgba(255, 0, 0, 0.5);    /* 50% transparent red */
}

.mostly-transparent {
    background-color: rgba(255, 0, 0, 0.1);    /* 10% opaque (90% transparent) */
}

.fully-transparent {
    background-color: rgba(255, 0, 0, 0);      /* Invisible */
}
```

**Practical use - overlay:**
```css
.overlay {
    background-color: rgba(0, 0, 0, 0.5);  /* Semi-transparent black overlay */
}
```

---

**Question 3:** Google Fonts are linked using the `<link>` tag in the HTML `<head>` section, just like linking a CSS file. Use `rel="stylesheet"` to indicate it's a stylesheet.

```html
<head>
    <!-- Link Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" 
          rel="stylesheet">
    
    <!-- Then use in CSS -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
    </style>
</head>
```

**Steps to use Google Fonts:**
1. Go to [fonts.google.com](https://fonts.google.com)
2. Select a font and weights (e.g., 400, 700)
3. Copy the `<link>` code
4. Paste in HTML `<head>`
5. Use in CSS with `font-family`

---

**Question 4:** `background-size: cover;` scales the image to be **as large as possible** to cover the entire container, even if it means cropping parts of the image. The image maintains its aspect ratio.

```css
/* Background size options */
.hero-1 {
    background-image: url('image.jpg');
    background-size: cover;     /* Scale to cover, may crop */
}

.hero-2 {
    background-size: contain;   /* Scale to fit inside, may show gaps */
}

.hero-3 {
    background-size: 100% 100%; /* Stretch to fill (may distort) */
}

.hero-4 {
    background-size: 500px 300px; /* Specific dimensions */
}
```

**Visual example:**
- `cover`: Image fills entire area, excess is hidden
- `contain`: Entire image visible, may have empty space

---

**Question 5:** **Serif** fonts have decorative strokes (serifs) at the ends of letters. They look more traditional and formal.

```css
/* Serif fonts - have decorative strokes */
h1 {
    font-family: Georgia, 'Times New Roman', serif;
}

/* Sans-serif fonts - clean, no strokes */
p {
    font-family: Arial, Helvetica, sans-serif;
}

/* Monospace - fixed width (for code) */
code {
    font-family: 'Courier New', Consolas, monospace;
}
```

**Font categories:**
1. **serif**: Georgia, Times New Roman (formal, traditional)
2. **sans-serif**: Arial, Helvetica (modern, clean)
3. **monospace**: Courier, Consolas (code, technical)
4. **cursive**: Comic Sans, Brush Script (handwriting)
5. **fantasy**: Impact, Papyrus (decorative)

---

**Question 6:** Hexadecimal colors in CSS start with `#` followed by 6 characters (or 3 for shorthand). The format is `#RRGGBB` where RR=red, GG=green, BB=blue, each ranging from 00-FF.

```css
/* Correct hex format */
color: #ff0000;  /* Red */
color: #00ff00;  /* Green */
color: #0000ff;  /* Blue */
color: #ffffff;  /* White */
color: #000000;  /* Black */

/* Shorthand (when pairs are identical) */
color: #f00;     /* Same as #ff0000 */
color: #fff;     /* Same as #ffffff */

/* Breaking down hex color */
#1a73e8
  ^^ Red component (1a = 26 in decimal)
    ^^ Green component (73 = 115)
      ^^ Blue component (e8 = 232)
```

---

**Question 7:** The `font-weight` property controls how bold or light text appears. Common values are `normal` (400), `bold` (700), or numeric values from 100-900.

```css
h1 {
    font-weight: 300;    /* Light */
    font-weight: 400;    /* Normal (default) */
    font-weight: 600;    /* Semi-bold */
    font-weight: 700;    /* Bold */
    font-weight: 900;    /* Extra bold */
    
    /* Keyword values */
    font-weight: normal; /* Same as 400 */
    font-weight: bold;   /* Same as 700 */
}
```

**Note:** Not all fonts support all weights. Check the font documentation.

---

**Question 8:** `text-transform: uppercase;` converts all text to uppercase letters, regardless of how it's written in HTML.

```css
/* Text transformation */
.uppercase {
    text-transform: uppercase;   /* "hello" → "HELLO" */
}

.lowercase {
    text-transform: lowercase;   /* "HELLO" → "hello" */
}

.capitalize {
    text-transform: capitalize;  /* "hello world" → "Hello World" */
}

.normal {
    text-transform: none;        /* No transformation */
}
```

**Barangay example:**
```html
<h1 class="barangay-name">barangay san miguel</h1>
```

```css
.barangay-name {
    text-transform: uppercase;   /* Displays: BARANGAY SAN MIGUEL */
    letter-spacing: 3px;         /* Adds spacing between letters */
}
```

---

**Question 9:** To prevent a background image from repeating, use `background-repeat: no-repeat;`. By default, background images tile/repeat to fill the space.

```css
/* Correct - non-repeating background */
.hero {
    background-image: url('hero.jpg');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
}

/* Shorthand version */
.hero {
    background: url('hero.jpg') no-repeat center / cover;
}

/* Other repeat options */
.pattern {
    background-repeat: repeat;     /* Tile horizontally & vertically (default) */
    background-repeat: repeat-x;   /* Tile horizontally only */
    background-repeat: repeat-y;   /* Tile vertically only */
    background-repeat: no-repeat;  /* Show once */
}
```

---

**Question 10:** The `rem` unit stands for "root em" and is relative to the **root element's** (`<html>`) font size. Unlike `em`, which is relative to the parent element, `rem` is always relative to the root.

```css
html {
    font-size: 16px;  /* Base size */
}

/* rem - relative to root (16px) */
h1 { font-size: 2rem; }      /* 2 × 16px = 32px */
p { font-size: 1rem; }       /* 1 × 16px = 16px */
small { font-size: 0.875rem; } /* 0.875 × 16px = 14px */

/* em - relative to parent */
.parent {
    font-size: 20px;
}

.child {
    font-size: 1.5em;  /* 1.5 × 20px = 30px */
}
```

**Why use rem?**
- Consistent sizing across the entire website
- Easier to maintain and scale
- Better for accessibility (respects user's browser font settings)

**Comparison:**
- `px`: Fixed size (always 16px)
- `em`: Relative to parent (can compound)
- `rem`: Relative to root (consistent)
- `%`: Relative to parent (100% = parent's size)

---