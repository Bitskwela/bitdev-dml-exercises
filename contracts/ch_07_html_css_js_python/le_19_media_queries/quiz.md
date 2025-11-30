# Quiz 1

**Scenario:** Tian is making the barangay website responsive using media queries.

1. What is the correct syntax for a media query?
   - A. `@media { max-width: 768px }`
   - B. `@media (max-width: 768px) { }`
   - C. `media-query: max-width 768px;`
   - D. `if (max-width: 768px) { }`

**Answer: B**

Media query syntax uses `@media` followed by parentheses around the condition, then curly braces for CSS rules.

2. Rhea Joy wants styles for screens **768px or smaller**. Which media query should she use?
   - A. `@media (min-width: 768px)`
   - B. `@media (max-width: 768px)`
   - C. `@media (width: 768px)`
   - D. `@media (screen-width: 768px)`

**Answer: B**

`max-width: 768px` means styles apply when the screen is 768px or smaller (maximum width is 768px).

3. What does this meta tag do? `<meta name="viewport" content="width=device-width, initial-scale=1.0">`
   - A. Sets page background color
   - B. Makes website responsive on mobile devices
   - C. Loads CSS faster
   - D. Enables JavaScript

**Answer: B**

The viewport meta tag tells mobile browsers how to display the page. Without it, mobile browsers show the desktop version zoomed out.

4. Which approach is recommended for responsive design?
   - A. Desktop-first (start with desktop, override for mobile)
   - B. Mobile-first (start with mobile, add for larger screens)
   - C. Tablet-first
   - D. TV-first

**Answer: B**

Mobile-first approach starts with mobile styles, then progressively enhances for larger screens using `min-width` media queries.

5. What does `@media (orientation: portrait)` target?
   - A. Horizontal screens (width > height)
   - B. Vertical screens (height > width)
   - C. Square screens
   - D. Desktop computers only

**Answer: B**

`orientation: portrait` targets vertical screens where height is greater than width (like a phone held upright).

---

# Quiz 2

**Scenario:** Tian wants to style the barangay website for tablets (768px to 1023px).

6. Which media query is correct for tablets only?
   - A. `@media (width: 768px)`
   - B. `@media (max-width: 1023px)`
   - C. `@media (min-width: 768px) and (max-width: 1023px)`
   - D. `@media (min-width: 768px) or (max-width: 1023px)`

**Answer: C**

Use `and` to combine conditions. This targets screens between 768px and 1023px (inclusive).

7. Where should Rhea Joy place media queries in her CSS file?
   - A. At the very top, before all other CSS
   - B. In a separate file
   - C. After the styles they override
   - D. Media queries don't work in CSS

**Answer: C**

Place media queries after the base styles they override. CSS cascades, so later rules override earlier ones.

8. What does `@media (min-width: 768px)` mean?
   - A. Styles apply when screen is exactly 768px
   - B. Styles apply when screen is 768px or smaller
   - C. Styles apply when screen is 768px or larger
   - D. Styles apply only on tablets

**Answer: C**

`min-width: 768px` means styles apply when the screen is 768px or larger (minimum width is 768px).

9. Tian wants to hide the mobile menu on desktop. Which CSS is correct?
   - A. `.mobile-menu { display: none; }` (in base styles)
   - B. `@media (min-width: 768px) { .mobile-menu { display: none; } }`
   - C. `.mobile-menu { visibility: hidden; }`
   - D. `@media (mobile) { .mobile-menu { display: none; } }`

**Answer: B**

Use `@media (min-width: 768px)` to apply styles on larger screens (desktop). This hides the mobile menu when screen is 768px or wider.

10. Which media query targets dark mode preference?
    - A. `@media (theme: dark)`
    - B. `@media (color-scheme: dark)`
    - C. `@media (prefers-color-scheme: dark)`
    - D. `@media (mode: dark)`

**Answer: C**

`@media (prefers-color-scheme: dark)` detects if the user has enabled dark mode in their system settings.

---

# Explanations

**Question 1:** Media query syntax uses `@media` followed by **parentheses** around the condition, then curly braces for CSS rules.

```css
/* Correct syntax */
@media (max-width: 768px) {
    /* CSS rules here */
    .container {
        width: 100%;
    }
}

/* Wrong - missing parentheses */
@media { max-width: 768px }  /* ❌ */

/* Wrong - not a valid CSS rule */
media-query: max-width 768px;  /* ❌ */

/* Wrong - JavaScript syntax, not CSS */
if (max-width: 768px) { }  /* ❌ */
```

**Structure breakdown:**
```css
@media (condition) {
  ↑      ↑         ↑
  |      |         |
  |      |         CSS rules block
  |      Condition in parentheses
  @media keyword
}
```

---

**Question 2:** `max-width: 768px` means styles apply when the screen is **768px or smaller** (maximum width is 768px).

```css
/* For screens 768px or SMALLER */
@media (max-width: 768px) {
    /* Mobile/tablet styles */
}

/* For screens 768px or LARGER */
@media (min-width: 768px) {
    /* Desktop styles */
}
```

**Visual:**
```
<--- Screen Sizes --->
0px          768px          1920px
|-------------|---------------|--->

max-width: 768px
|=============|               Applies here (0-768px)
              
min-width: 768px
              |===============> Applies here (768px+)
```

**Barangay example:**
```css
/* Desktop: Default */
.nav {
    display: flex;
    flex-direction: row;
}

/* Mobile: 768px or smaller */
@media (max-width: 768px) {
    .nav {
        flex-direction: column;  /* Stack vertically on mobile */
    }
}
```

---

**Question 3:** The viewport meta tag tells mobile browsers **how to display the page**. Without it, mobile browsers show the desktop version zoomed out.

```html
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
```

**What it does:**
- `width=device-width`: Page width matches screen width
- `initial-scale=1.0`: No zoom (100% scale)

**Without viewport tag:**
```
Mobile shows desktop version (zoomed out)
+----------------------------------------+
| [Tiny text] [Tiny buttons]            |
| User must pinch-to-zoom to read       |
+----------------------------------------+
```

**With viewport tag:**
```
Mobile shows mobile-optimized version
+--------------------+
| [Readable text]   |
| [Tap-able buttons]|
+--------------------+
```

**ALWAYS include this tag** in responsive websites!

---

**Question 4:** **Mobile-first** is the recommended approach. Start with simple mobile styles, then add complexity for larger screens.

**Mobile-first (recommended):**
```css
/* Base: Mobile (no media query) */
.nav {
    flex-direction: column;  /* Simple mobile layout */
}

/* Tablet and up */
@media (min-width: 768px) {
    .nav {
        flex-direction: row;  /* Add horizontal layout */
    }
}

/* Desktop */
@media (min-width: 1024px) {
    .nav {
        gap: 30px;            /* Add more spacing */
        font-size: 1.1rem;    /* Larger text */
    }
}
```

**Desktop-first (not recommended):**
```css
/* Base: Desktop (complex) */
.nav {
    flex-direction: row;
    gap: 30px;
    font-size: 1.1rem;
}

/* Tablet */
@media (max-width: 1023px) {
    .nav {
        gap: 20px;            /* Override */
        font-size: 1rem;
    }
}

/* Mobile */
@media (max-width: 767px) {
    .nav {
        flex-direction: column;  /* Override again */
        gap: 10px;
        font-size: 0.9rem;
    }
}
```

**Why mobile-first?**
✅ Simpler mobile base
✅ Progressive enhancement
✅ Better mobile performance
✅ Easier to maintain

---

**Question 5:** `orientation: portrait` targets screens where **height is greater than width** (vertical).

```css
/* Portrait: Vertical (height > width) */
@media (orientation: portrait) {
    /* Phone held upright */
}

/* Landscape: Horizontal (width > height) */
@media (orientation: landscape) {
    /* Phone held sideways */
}
```

**Visual:**
```
Portrait (height > width):
+----------+
|          |
|  Screen  |
|          |
|          |
+----------+

Landscape (width > height):
+------------------------+
|       Screen           |
+------------------------+
```

**Barangay example:**
```css
/* Portrait: Show full menu */
@media (orientation: portrait) {
    .menu {
        display: flex;
        flex-direction: column;
    }
}

/* Landscape: Compact menu */
@media (orientation: landscape) and (max-width: 768px) {
    .menu {
        display: flex;
        flex-direction: row;
        font-size: 0.85rem;  /* Smaller to fit */
    }
}
```

---

**Question 6:** To target a **specific range** (tablets 768-1023px), use `and` to combine `min-width` and `max-width`.

```css
/* Tablets only: 768px to 1023px */
@media (min-width: 768px) and (max-width: 1023px) {
    /* Styles for tablets only */
}
```

**Why both conditions?**
- `min-width: 768px` = 768px or larger
- `and` = both conditions must be true
- `max-width: 1023px` = 1023px or smaller
- Result: Between 768px and 1023px

**Visual:**
```
0px      768px         1023px        1920px
|---------|-------------|-------------|--->
          ←--Applies here--→
```

**Full responsive example:**
```css
/* Mobile: 0-767px (no media query needed) */
.grid {
    grid-template-columns: 1fr;  /* 1 column */
}

/* Tablet: 768px-1023px */
@media (min-width: 768px) and (max-width: 1023px) {
    .grid {
        grid-template-columns: 1fr 1fr;  /* 2 columns */
    }
}

/* Desktop: 1024px+ */
@media (min-width: 1024px) {
    .grid {
        grid-template-columns: 1fr 1fr 1fr;  /* 3 columns */
    }
}
```

---

**Question 7:** Media queries should be placed **after the styles they override** so they take precedence (CSS cascade).

```css
/* CORRECT ORDER */

/* 1. Base styles (mobile-first) */
.nav {
    flex-direction: column;
    font-size: 1rem;
}

/* 2. Media queries AFTER base styles */
@media (min-width: 768px) {
    .nav {
        flex-direction: row;    /* Overrides column */
        font-size: 1.1rem;      /* Overrides 1rem */
    }
}
```

**Wrong order:**
```css
/* WRONG - Media query first */
@media (min-width: 768px) {
    .nav {
        flex-direction: row;
    }
}

/* Base styles AFTER media query = overrides media query! */
.nav {
    flex-direction: column;  /* This wins (comes last) */
}
```

**CSS Cascade:** Later rules override earlier rules (when specificity is equal).

---

**Question 8:** `min-width: 768px` means styles apply when screen is **768px or larger** (minimum width is 768px).

```css
@media (min-width: 768px) {
    /* Applies to screens 768px AND LARGER */
}
```

**Think of it as:**
- `min-width`: "At least this wide"
- `max-width`: "At most this wide"

**Examples:**
```css
/* Desktop and up */
@media (min-width: 1024px) {
    .container { width: 1000px; }
}
/* Applies: 1024px, 1920px, 2560px */

/* Mobile and down */
@media (max-width: 767px) {
    .container { width: 100%; }
}
/* Applies: 320px, 480px, 767px */
```

---

**Question 9:** To hide mobile menu on desktop, use a media query with `display: none` for larger screens.

```css
/* Mobile: Show menu (default) */
.mobile-menu {
    display: block;  /* Visible on mobile */
}

/* Desktop: Hide mobile menu */
@media (min-width: 768px) {
    .mobile-menu {
        display: none;  /* Hidden on desktop */
    }
}
```

**Complete mobile/desktop menu pattern:**
```css
/* Mobile menu - visible on mobile */
.mobile-menu {
    display: block;
}

/* Desktop menu - hidden on mobile */
.desktop-menu {
    display: none;
}

/* Switch on larger screens */
@media (min-width: 768px) {
    .mobile-menu {
        display: none;   /* Hide mobile menu */
    }
    
    .desktop-menu {
        display: flex;   /* Show desktop menu */
    }
}
```

---

**Question 10:** The `prefers-color-scheme` media query detects if the user's system is set to dark or light mode.

```css
/* Default: Light mode */
body {
    background: white;
    color: black;
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
    body {
        background: #1a1a1a;
        color: white;
    }
    
    .card {
        background: #2a2a2a;
        border: 1px solid #444;
    }
    
    a {
        color: #66b3ff;  /* Lighter blue for dark mode */
    }
}
```

**Barangay dark mode example:**
```css
/* Light mode (default) */
.header {
    background: #1a73e8;
    color: white;
}

.announcement {
    background: white;
    color: #333;
    border: 1px solid #e0e0e0;
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
    .header {
        background: #0d47a1;  /* Darker blue */
    }
    
    .announcement {
        background: #2a2a2a;
        color: #e0e0e0;
        border: 1px solid #444;
    }
}
```

**Testing dark mode:**
- Windows: Settings → Personalization → Colors → Dark
- Mac: System Preferences → General → Appearance → Dark
- Chrome DevTools: More tools → Rendering → Emulate CSS media feature → prefers-color-scheme: dark

---