# Quiz 1

**Scenario:** Tian is using responsive units for the barangay website.

1. If the root `<html>` font-size is `16px`, what is `2rem` in pixels?
   - A. 2px
   - B. 16px
   - C. 32px
   - D. 64px

2. What does `1vw` represent?
   - A. 1% of the viewport width
   - B. 1 pixel
   - C. 1% of the parent width
   - D. 1% of the viewport height

3. Rhea Joy wants consistent font sizing across nested elements. Which unit should she use?
   - A. `px`
   - B. `em`
   - C. `rem`
   - D. `%`

4. What is the difference between `em` and `rem`?
   - A. `em` is relative to parent, `rem` is relative to root
   - B. `em` is absolute, `rem` is relative
   - C. They are the same
   - D. `em` is for fonts, `rem` is for spacing

5. Which unit is best for a full-screen hero section height?
   - A. `px`
   - B. `%`
   - C. `vh`
   - D. `vw`

---

# Quiz 2

**Scenario:** Tian is making responsive typography for different screen sizes.

6. What does this CSS do? `font-size: clamp(1rem, 3vw, 2rem);`
   - A. Font is always 3vw
   - B. Font is between 1rem and 2rem, preferring 3vw
   - C. Font is 1rem on mobile, 2rem on desktop
   - D. Syntax error

7. If parent element has `font-size: 20px`, what is `1.5em` in pixels?
   - A. 15px
   - B. 20px
   - C. 30px
   - D. 1.5px

8. Which unit is recommended for padding and margins?
   - A. `px` (absolute)
   - B. `rem` (scales with root)
   - C. `em` (scales with parent)
   - D. `vw` (scales with viewport)

9. On a 1200px wide screen, what is `50vw` in pixels?
   - A. 50px
   - B. 120px
   - C. 600px
   - D. 1200px

10. What is the benefit of using `rem` instead of `px`?
    - A. Smaller file size
    - B. Faster rendering
    - C. Scales proportionally when root font-size changes
    - D. Works on older browsers

---

# Answers

1. **C** - 32px
2. **A** - 1% of the viewport width
3. **C** - `rem`
4. **A** - `em` is relative to parent, `rem` is relative to root
5. **C** - `vh`
6. **B** - Font is between 1rem and 2rem, preferring 3vw
7. **C** - 30px
8. **B** - `rem` (scales with root)
9. **C** - 600px
10. **C** - Scales proportionally when root font-size changes

---

# Explanations

**Question 1:** `rem` (root em) is relative to the **root `<html>` element's font-size**.

```css
/* Root font-size */
html {
    font-size: 16px;  /* 1rem = 16px */
}

/* Calculations */
1rem = 16px
2rem = 2 × 16px = 32px
0.5rem = 0.5 × 16px = 8px
1.5rem = 1.5 × 16px = 24px
```

**Barangay example:**
```css
html {
    font-size: 16px;
}

h1 {
    font-size: 2.5rem;   /* 2.5 × 16 = 40px */
    margin-bottom: 1rem; /* 1 × 16 = 16px */
}

p {
    font-size: 1rem;     /* 1 × 16 = 16px */
    padding: 0.75rem;    /* 0.75 × 16 = 12px */
}

.small {
    font-size: 0.875rem; /* 0.875 × 16 = 14px */
}
```

**Why use rem?**
✅ Consistent sizing throughout the site
✅ Scales proportionally when you change root size
✅ Better accessibility (users can adjust browser font size)

**Responsive with rem:**
```css
/* Desktop */
html {
    font-size: 16px;  /* All rem values based on 16px */
}

/* Mobile */
@media (max-width: 768px) {
    html {
        font-size: 14px;  /* All rem values scale down automatically! */
    }
}
```

---

**Question 2:** `vw` (viewport width) is **1% of the viewport's width**.

```css
1vw = 1% of viewport width
```

**Examples on different screens:**

```
1920px wide screen:
1vw = 1920 × 0.01 = 19.2px
50vw = 1920 × 0.50 = 960px

768px wide tablet:
1vw = 768 × 0.01 = 7.68px
50vw = 768 × 0.50 = 384px

360px wide phone:
1vw = 360 × 0.01 = 3.6px
50vw = 360 × 0.50 = 180px
```

**Barangay responsive text:**
```css
.hero h1 {
    font-size: 5vw;  /* Scales with screen width */
}

/* On 1920px screen: 5vw = 96px */
/* On 768px tablet: 5vw = 38.4px */
/* On 360px phone: 5vw = 18px */
```

**Full-width element:**
```css
.banner {
    width: 100vw;   /* Always full viewport width */
    padding: 2vw;   /* Padding scales with width */
}
```

**Common viewport units:**
- `vw`: Viewport width (horizontal)
- `vh`: Viewport height (vertical)
- `vmin`: Smaller of vw or vh
- `vmax`: Larger of vw or vh

---

**Question 3:** `rem` provides **consistent sizing across nested elements** because it's always relative to the root, not the parent.

**Problem with `em` (compounds):**
```css
body {
    font-size: 16px;
}

.section {
    font-size: 1.25em;  /* 1.25 × 16px = 20px */
}

.section .title {
    font-size: 1.5em;   /* 1.5 × 20px = 30px (parent is 20px!) */
}

.section .title .highlight {
    font-size: 1.2em;   /* 1.2 × 30px = 36px (compounds!) */
}
```

**Solution with `rem` (consistent):**
```css
html {
    font-size: 16px;
}

.section {
    font-size: 1.25rem;  /* 1.25 × 16px = 20px */
}

.section .title {
    font-size: 1.5rem;   /* 1.5 × 16px = 24px (always from root) */
}

.section .title .highlight {
    font-size: 1.2rem;   /* 1.2 × 16px = 19.2px (no compounding!) */
}
```

**Barangay nested example:**
```css
html { font-size: 16px; }

.announcement-card {           /* Outer card */
    font-size: 1rem;           /* 16px */
}

.announcement-card .title {    /* Title inside */
    font-size: 1.5rem;         /* Always 24px (from root) */
}

.announcement-card .title .badge {  /* Badge inside title */
    font-size: 0.75rem;        /* Always 12px (from root) */
}

/* All sizes predictable, no compounding! */
```

---

**Question 4:** `em` is relative to **parent element**, `rem` is relative to **root element**.

**Comparison:**

```css
html { font-size: 16px; }  /* Root */

/* EM - Relative to Parent */
.parent {
    font-size: 20px;       /* Parent font size */
}

.parent .child {
    font-size: 1.5em;      /* 1.5 × 20px (parent) = 30px */
    padding: 1em;          /* 1 × 30px (own font-size) = 30px */
}

/* REM - Always Relative to Root */
.another-parent {
    font-size: 20px;       /* Parent font size */
}

.another-parent .child {
    font-size: 1.5rem;     /* 1.5 × 16px (root) = 24px */
    padding: 1rem;         /* 1 × 16px (root) = 16px */
}
```

**Nesting comparison:**
```html
<div class="level1">   <!-- font-size: 20px -->
    <div class="level2">   <!-- EM or REM? -->
        <div class="level3">   <!-- EM or REM? -->
        </div>
    </div>
</div>
```

```css
/* Using EM (compounds) */
.level1 { font-size: 20px; }
.level2 { font-size: 1.2em; }  /* 1.2 × 20 = 24px */
.level3 { font-size: 1.2em; }  /* 1.2 × 24 = 28.8px (compounds!) */

/* Using REM (consistent) */
.level1 { font-size: 20px; }
.level2 { font-size: 1.2rem; }  /* 1.2 × 16 = 19.2px */
.level3 { font-size: 1.2rem; }  /* 1.2 × 16 = 19.2px (same!) */
```

**When to use each:**
- **REM:** Font sizes, spacing (predictable, consistent)
- **EM:** When you want sizing relative to current font (rare)

---

**Question 5:** `vh` (viewport height) is perfect for **full-screen hero sections** that fill the entire screen vertically.

```css
.hero {
    height: 100vh;  /* 100% of viewport height */
}
```

**Why `vh` for full-screen?**
✅ Always fills visible screen, regardless of device
✅ Responsive to browser window resizing
✅ Works on all screen sizes

**Comparison:**

```css
/* Wrong - % doesn't work if parent has no height */
.hero {
    height: 100%;  /* 100% of parent (might be 0px!) */
}

/* Wrong - Fixed height doesn't adapt */
.hero {
    height: 800px;  /* Too tall on mobile, too short on desktop */
}

/* Correct - Viewport height always works */
.hero {
    height: 100vh;  /* Perfect full screen on any device */
}
```

**Barangay full-screen welcome:**
```css
.welcome-section {
    height: 100vh;              /* Full screen */
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #1a73e8, #34a853);
    color: white;
}

.welcome-section h1 {
    font-size: 6vh;             /* 6% of height (scales!) */
}
```

**Other vh uses:**
```css
/* Half-screen section */
.half-screen {
    min-height: 50vh;
}

/* Sticky header accounting for content */
.content {
    min-height: calc(100vh - 80px);  /* Full height minus header */
}
```

---

**Question 6:** `clamp(min, preferred, max)` sets a **minimum, preferred, and maximum value**. The font size stays between the min and max, preferring the middle value.

```css
font-size: clamp(1rem, 3vw, 2rem);
/*         ↓     ↓     ↓
           min   pref  max
*/
```

**How it works:**

1. Browser tries to use **preferred** value (`3vw`)
2. If `3vw < 1rem`, use **min** (`1rem`)
3. If `3vw > 2rem`, use **max** (`2rem`)
4. Otherwise, use `3vw`

**Examples on different screens:**

```
360px phone:
3vw = 10.8px = 0.675rem (less than 1rem min)
→ Uses 1rem (16px)

768px tablet:
3vw = 23px = 1.4375rem (between 1rem and 2rem)
→ Uses 1.4375rem (23px)

1920px desktop:
3vw = 57.6px = 3.6rem (more than 2rem max)
→ Uses 2rem (32px)
```

**Barangay responsive heading:**
```css
.hero h1 {
    font-size: clamp(2rem, 5vw, 5rem);
    /* Small screens: 2rem (32px)
       Medium screens: Scales with 5vw
       Large screens: Max 5rem (80px) */
}

.section-title {
    font-size: clamp(1.25rem, 3vw, 2.5rem);
    /* Always readable, never too small or large */
}
```

**Before clamp (old way):**
```css
.hero h1 {
    font-size: 5vw;
    min-font-size: 2rem;   /* Not standard */
    max-font-size: 5rem;   /* Not standard */
}

/* Had to use media queries instead */
@media (max-width: 640px) {
    .hero h1 { font-size: 2rem; }
}
@media (min-width: 1920px) {
    .hero h1 { font-size: 5rem; }
}
```

**With clamp (modern):**
```css
.hero h1 {
    font-size: clamp(2rem, 5vw, 5rem);  /* One line! */
}
```

---

**Question 7:** `em` is relative to the **parent element's font-size**.

```css
.parent {
    font-size: 20px;  /* Parent font-size */
}

.child {
    font-size: 1.5em;  /* 1.5 × 20px = 30px */
}
```

**Calculation:**
```
parent font-size: 20px
em multiplier: 1.5
Result: 20px × 1.5 = 30px
```

**More examples:**
```css
.card {
    font-size: 16px;
}

.card-title {
    font-size: 1.5em;    /* 1.5 × 16 = 24px */
}

.card-subtitle {
    font-size: 0.875em;  /* 0.875 × 16 = 14px */
}

.card-badge {
    font-size: 0.75em;   /* 0.75 × 16 = 12px */
}
```

**Spacing with em (relative to own font-size):**
```css
h1 {
    font-size: 32px;
    margin-bottom: 0.5em;  /* 0.5 × 32px = 16px */
}

h2 {
    font-size: 24px;
    margin-bottom: 0.5em;  /* 0.5 × 24px = 12px */
}

/* Margin scales with font size! */
```

**Nesting caveat:**
```css
.level1 { font-size: 20px; }
.level2 { font-size: 1.2em; }  /* 1.2 × 20 = 24px */
.level3 { font-size: 1.2em; }  /* 1.2 × 24 = 28.8px (compounds!) */
```

---

**Question 8:** `rem` is recommended for **padding and margins** because it provides consistent, scalable spacing throughout the site.

**Why rem for spacing:**
✅ Consistent spacing relative to root font-size
✅ Scales proportionally on all devices
✅ Easy to maintain (change root size, everything scales)
✅ No compounding issues

**Barangay spacing system:**
```css
html {
    font-size: 16px;  /* 1rem = 16px */
}

/* Consistent spacing scale */
.section {
    padding: 3rem 1.5rem;      /* 48px 24px */
    margin-bottom: 2rem;       /* 32px */
}

.card {
    padding: 1.5rem;           /* 24px */
    margin-bottom: 1rem;       /* 16px */
}

.button {
    padding: 0.75rem 1.5rem;   /* 12px 24px */
    margin: 0.5rem;            /* 8px */
}

/* Mobile: Scale everything down */
@media (max-width: 768px) {
    html {
        font-size: 14px;  /* All rem-based spacing scales! */
    }
    /* section padding now: 42px 21px (3rem 1.5rem) */
    /* card padding now: 21px (1.5rem) */
    /* button padding now: 10.5px 21px (0.75rem 1.5rem) */
}
```

**Comparison:**

```css
/* BAD - Fixed px doesn't scale */
.section {
    padding: 48px 24px;  /* Same on mobile and desktop */
}

/* GOOD - rem scales with root */
.section {
    padding: 3rem 1.5rem;  /* Scales proportionally */
}
```

---

**Question 9:** `vw` is 1% of viewport width.

```
50vw = 50% of viewport width

On 1200px screen:
50vw = 1200px × 0.50 = 600px
```

**More examples:**

```
1920px desktop:
1vw = 19.2px
50vw = 960px
100vw = 1920px (full width)

768px tablet:
1vw = 7.68px
50vw = 384px
100vw = 768px (full width)

360px phone:
1vw = 3.6px
50vw = 180px
100vw = 360px (full width)
```

**Barangay uses:**
```css
/* Full-width banner */
.banner {
    width: 100vw;  /* Always full viewport width */
}

/* Half-width sections */
.half-section {
    width: 50vw;   /* Always half viewport width */
}

/* Responsive text */
.hero-title {
    font-size: 5vw;  /* Scales with screen width */
}
```

---

**Question 10:** The main benefit of `rem` is that **all sizes scale proportionally when you change the root font-size**, making responsive design much easier.

**Without rem (fixed px):**
```css
/* Desktop */
h1 { font-size: 40px; }
h2 { font-size: 32px; }
p { font-size: 16px; }
.section { padding: 48px 24px; }
.button { padding: 12px 24px; }

/* Mobile - Must override EVERY value */
@media (max-width: 768px) {
    h1 { font-size: 32px; }     /* Override */
    h2 { font-size: 24px; }     /* Override */
    p { font-size: 14px; }      /* Override */
    .section { padding: 32px 16px; }  /* Override */
    .button { padding: 10px 20px; }   /* Override */
}
/* Tedious! Easy to miss values! */
```

**With rem (scales automatically):**
```css
/* Desktop */
html { font-size: 16px; }  /* 1rem = 16px */
h1 { font-size: 2.5rem; }  /* 40px */
h2 { font-size: 2rem; }    /* 32px */
p { font-size: 1rem; }     /* 16px */
.section { padding: 3rem 1.5rem; }  /* 48px 24px */
.button { padding: 0.75rem 1.5rem; } /* 12px 24px */

/* Mobile - Change root ONCE, everything scales! */
@media (max-width: 768px) {
    html { font-size: 14px; }  /* 1rem now = 14px */
}
/* h1 now: 2.5rem = 35px (scaled automatically!) */
/* h2 now: 2rem = 28px (scaled automatically!) */
/* p now: 1rem = 14px (scaled automatically!) */
/* section padding now: 42px 21px (scaled!) */
/* button padding now: 10.5px 21px (scaled!) */
```

**Accessibility bonus:**
Users can change browser font size (Settings → Font Size), and rem-based sites scale perfectly. Fixed px sites don't respect user preferences!

---