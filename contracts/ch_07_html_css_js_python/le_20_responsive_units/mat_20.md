## Background Story

After learning media queries, Tian and Rhea Joy had refactored their barangay website to be responsive. They'd added breakpoints for mobile, tablet, and desktop. The layout adapted properly—single column on mobile, multiple columns on desktop.

But there were still problems. Subtle, frustrating problems.

On mobile, they'd set:

```css
@media (max-width: 768px) {
    h1 { font-size: 24px; }
    p { font-size: 14px; }
    .container { padding: 15px; }
}
```

On desktop:

```css
@media (min-width: 769px) {
    h1 { font-size: 36px; }
    p { font-size: 16px; }
    .container { padding: 30px; }
}
```

They'd specified exact pixel values for every screen size. The website worked, but it required dozens of media query rules for every minor adjustment. Adding a new element meant defining its size at every breakpoint.

Worse, when users zoomed in or out (common for accessibility), the fixed pixel values didn't scale. A visually impaired user who increased browser zoom to 150% found that the layout broke because the pixel-based sizing didn't adapt.

Then there was the issue of viewport variation. Not all phones are the same size. An iPhone SE (375px wide) and an iPhone Pro Max (428px wide) both fell into the same mobile breakpoint, but Tian's fixed 14px font looked very different on each. Too small on the larger phone, almost too large on the smaller one.

Rhea Joy encountered a related problem with her hero section—the large banner at the top of the homepage. She wanted it to always fill the entire viewport height, regardless of device. She tried:

```css
.hero {
    height: 800px;  /* Looks good on desktop */
}
```

But 800px was taller than most phone screens and shorter than many desktop monitors. The hero section was either cut off or had awkward empty space.

It was Thursday night—the day before launch. They'd fixed the responsive layout, but these sizing issues made the site feel unpolished.

Tian was in the school library, Rhea Joy was at home, and both were on a group video call.

"The media queries work, but we're using fixed pixels for everything," Tian said. "Font sizes don't scale smoothly. Spacing doesn't feel proportional across devices. And when users zoom, things break."

"My hero section won't fill the viewport height properly," Rhea Joy added. "I'd need separate media queries for every possible screen height, which is insane."

They'd both been researching and kept seeing references to units other than `px`: `rem`, `em`, `%`, `vh`, `vw`. Professional websites seemed to use these extensively.

"What's the difference between all these units?" Tian asked aloud. "And which should we use?"

They called Kuya Miguel.

"Kuya, we fixed the responsive layout with media queries, but we're still using fixed pixel values for everything. Our font sizes don't scale naturally, our spacing isn't proportional, and our hero section won't adapt to viewport height. We keep seeing references to relative units like `rem` and `vh` but we don't understand when to use what."

Miguel pulled up a comparison chart on his screen.

"You've discovered the limitation of absolute units. Pixels are fixed—they don't scale, they don't adapt, they don't respect user preferences. Modern responsive design uses relative units that scale based on context. `rem` for typography that respects browser settings. `em` for spacing relative to font size. `%` for layouts relative to parents. `vh` and `vw` for viewport-based sizing. Each has specific use cases."

"So we should never use pixels?" Rhea Joy asked.

"Not never, but rarely. Borders, maybe. But for fonts, spacing, layouts—relative units create more flexible, accessible, truly responsive designs. Today, I'm teaching you every relative unit, when to use each, and how to refactor your pixel-based stylesheet to use scalable, adaptive sizing."

---

## Theory & Lecture Content

## Absolute vs Relative Units

### Absolute Units (Fixed)

**Always the same size, regardless of screen or parent.**

- `px` (pixels): Most common absolute unit
- `pt` (points): Used in print (1pt = 1/72 inch)
- `cm`, `mm`, `in`: Physical units (rarely used on web)

**Example:**
```css
h1 {
    font-size: 32px;  /* Always 32 pixels */
}
```

**Problem:** Doesn't scale on different screens or zoom levels.

---

### Relative Units (Flexible)

**Size changes based on context (parent, root, viewport).**

| Unit | Name | Relative To |
|------|------|-------------|
| `%` | Percentage | Parent element |
| `em` | Em | Parent element's font size |
| `rem` | Root em | Root (`html`) font size |
| `vw` | Viewport width | 1% of viewport width |
| `vh` | Viewport height | 1% of viewport height |
| `vmin` | Viewport minimum | Smaller of vw or vh |
| `vmax` | Viewport maximum | Larger of vw or vh |

---

## Percentage (%)

**Relative to parent element.**

```css
.parent {
    width: 1000px;
}

.child {
    width: 50%;  /* 50% of 1000px = 500px */
}
```

### Width/Height Example

```html
<div class="container">
    <div class="sidebar">Sidebar</div>
    <div class="main-content">Content</div>
</div>
```

```css
.container {
    display: flex;
    width: 100%;  /* 100% of screen width */
}

.sidebar {
    width: 25%;   /* 25% of container */
}

.main-content {
    width: 75%;   /* 75% of container */
}
```

**Result:** Sidebar and content adjust proportionally on any screen size.

---

### Font-Size with Percentage

```css
/* Parent */
.card {
    font-size: 16px;
}

/* Child */
.card-title {
    font-size: 150%;  /* 150% of 16px = 24px */
}

.card-subtitle {
    font-size: 87.5%; /* 87.5% of 16px = 14px */
}
```

---

## EM Unit

**Relative to parent element's font size.**

**Base concept:**
```css
parent-font-size: 16px
1em = 16px
2em = 32px
0.5em = 8px
```

### Font-Size Example

```css
body {
    font-size: 16px;  /* Base */
}

.section {
    font-size: 1.25em;  /* 1.25 × 16px = 20px */
}

.section p {
    font-size: 0.9em;   /* 0.9 × 20px = 18px (parent is 20px!) */
}
```

**Warning:** Em compounds! Child elements inherit parent's computed font-size.

---

### Spacing with Em

```css
h1 {
    font-size: 2em;      /* 32px (if parent is 16px) */
    margin-bottom: 0.5em; /* 0.5 × 32px = 16px */
    padding: 0.25em;      /* 0.25 × 32px = 8px */
}
```

**Benefit:** Spacing scales with font size!

---

## REM Unit (Recommended)

**Relative to ROOT (`<html>`) element's font size.**

**Default:** Browser default is usually `16px`.

```css
/* Root (default) */
html {
    font-size: 16px;  /* 1rem = 16px */
}

h1 {
    font-size: 2rem;   /* 2 × 16px = 32px */
}

p {
    font-size: 1rem;   /* 1 × 16px = 16px */
}

.small {
    font-size: 0.875rem; /* 0.875 × 16px = 14px */
}
```

**Why REM is better than EM:**
✅ Consistent sizing (always relative to root)
✅ No compounding issues
✅ Easier to calculate
✅ User can adjust root size (accessibility)

---

### Barangay Website with REM

```css
/* Set root font size */
html {
    font-size: 16px;  /* Base: 1rem = 16px */
}

/* Typography */
h1 {
    font-size: 2.5rem;   /* 40px */
    margin-bottom: 1rem; /* 16px */
}

h2 {
    font-size: 2rem;     /* 32px */
    margin-bottom: 0.75rem; /* 12px */
}

p {
    font-size: 1rem;     /* 16px */
    line-height: 1.5;    /* 24px (1.5 × 16px) */
    margin-bottom: 1rem; /* 16px */
}

.small-text {
    font-size: 0.875rem; /* 14px */
}

/* Spacing */
.section {
    padding: 3rem 1.5rem; /* 48px 24px */
}

.button {
    padding: 0.75rem 1.5rem; /* 12px 24px */
    font-size: 1rem;
    border-radius: 0.5rem;   /* 8px */
}

/* Responsive: Adjust root size */
@media (max-width: 768px) {
    html {
        font-size: 14px;  /* 1rem now = 14px */
    }
    /* All rem-based sizes scale down automatically! */
}
```

**Magic:** Changing root `font-size` scales ALL rem-based sizes proportionally!

---

## Viewport Units

### VW (Viewport Width)

**1vw = 1% of viewport width.**

```css
/* On 1200px screen: 1vw = 12px */
/* On 360px screen: 1vw = 3.6px */

.hero {
    width: 100vw;        /* Full viewport width */
    font-size: 5vw;      /* Scales with screen width */
}
```

**Example:**
```css
.hero-title {
    font-size: 10vw;  /* 10% of viewport width */
}

/* On 1920px screen: 10vw = 192px */
/* On 360px screen: 10vw = 36px */
```

---

### VH (Viewport Height)

**1vh = 1% of viewport height.**

```css
/* Full-screen hero section */
.hero {
    height: 100vh;  /* Always full screen height */
}

/* Half-screen section */
.section {
    min-height: 50vh;  /* At least half screen */
}
```

**Barangay example:**
```css
/* Full-screen welcome banner */
.welcome-banner {
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: url('barangay-bg.jpg');
    background-size: cover;
}

.welcome-banner h1 {
    font-size: 8vh;   /* 8% of viewport height */
    color: white;
}
```

---

### VMIN and VMAX

**VMIN:** Smaller of vw or vh
**VMAX:** Larger of vw or vh

```css
/* Ensures element never too large on any orientation */
.square {
    width: 50vmin;  /* 50% of smaller dimension */
    height: 50vmin;
}
```

**Example:**
- Landscape 1920×1080: `1vmin = 10.8px` (height is smaller)
- Portrait 1080×1920: `1vmin = 10.8px` (width is smaller)

---

## Combining Units: Best Practices

### Typography

```css
/* Use REM for font sizes (consistent, accessible) */
html {
    font-size: 16px;  /* Base */
}

h1 { font-size: 2.5rem; }   /* 40px */
h2 { font-size: 2rem; }     /* 32px */
p { font-size: 1rem; }      /* 16px */

/* Responsive root size */
@media (max-width: 768px) {
    html { font-size: 14px; }  /* Scale everything down */
}
```

---

### Layout Widths

```css
/* Use % or vw for flexible widths */
.container {
    width: 90%;          /* 90% of parent */
    max-width: 1200px;   /* But never exceed 1200px */
    margin: 0 auto;      /* Center */
}

.full-width {
    width: 100vw;        /* Full viewport */
}
```

---

### Spacing (Padding/Margin)

```css
/* Use REM for consistent, scalable spacing */
.section {
    padding: 3rem 1.5rem;      /* Scales with root font-size */
    margin-bottom: 2rem;
}

.button {
    padding: 0.75rem 1.5rem;
    margin: 0.5rem;
}
```

---

### Heights

```css
/* Full-screen sections: VH */
.hero {
    height: 100vh;
}

/* Flexible height: auto or min-height */
.content {
    min-height: 50vh;  /* At least half screen */
    height: auto;      /* Expand as needed */
}
```

---

## Complete Barangay Responsive Example

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
    <section class="hero">
        <h1>Barangay San Miguel</h1>
        <p>Pagkakaisa, Paglilingkod, Pag-unlad</p>
    </section>

    <section class="services">
        <div class="service-card">
            <h3>Barangay Clearance</h3>
            <p>Processing: 3-5 days</p>
        </div>
        <div class="service-card">
            <h3>Residency Certificate</h3>
            <p>Processing: Same day</p>
        </div>
    </section>
</body>
</html>
```

```css
/* ========== ROOT SIZING ========== */
html {
    font-size: 16px;  /* 1rem = 16px */
}

/* Mobile: Smaller base */
@media (max-width: 768px) {
    html {
        font-size: 14px;  /* All rem values scale down */
    }
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
}

/* ========== HERO SECTION ========== */
.hero {
    height: 100vh;              /* Full viewport height */
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #1a73e8, #34a853);
    color: white;
    padding: 2rem;              /* rem-based spacing */
}

.hero h1 {
    font-size: 5vw;             /* Viewport-based (scales) */
    min-font-size: 2rem;        /* But at least 32px */
    max-font-size: 4rem;        /* Max 64px */
    margin-bottom: 1rem;
}

.hero p {
    font-size: 1.5rem;          /* 24px on desktop, 21px on mobile */
}

/* ========== SERVICES SECTION ========== */
.services {
    display: flex;
    flex-wrap: wrap;
    gap: 2rem;                  /* rem-based gap */
    padding: 3rem 5%;           /* Mix: rem + % */
    max-width: 1200px;
    margin: 0 auto;
}

.service-card {
    flex: 1 1 calc(33.333% - 2rem);  /* Flexible with calc */
    min-width: 250px;                /* Minimum size */
    background: white;
    padding: 2rem;                   /* rem-based */
    border-radius: 0.5rem;           /* 8px rounded corners */
    box-shadow: 0 0.25rem 0.5rem rgba(0,0,0,0.1);  /* rem-based shadow */
}

.service-card h3 {
    font-size: 1.5rem;          /* 24px on desktop */
    color: #1a73e8;
    margin-bottom: 0.75rem;
}

.service-card p {
    font-size: 1rem;            /* 16px on desktop */
    color: #666;
}

/* ========== MOBILE ADJUSTMENTS ========== */
@media (max-width: 768px) {
    .hero h1 {
        font-size: 8vw;         /* Larger vw for better mobile visibility */
    }
    
    .services {
        flex-direction: column;
        padding: 2rem 1rem;     /* Less padding */
    }
    
    .service-card {
        width: 100%;            /* Full width on mobile */
    }
}
```

---

## Clamp Function (Modern)

**Responsive sizing with min, preferred, and max values.**

```css
font-size: clamp(min, preferred, max);
```

**Example:**
```css
h1 {
    font-size: clamp(1.5rem, 5vw, 4rem);
    /*         ↓       ↓    ↓
               min     pref max
    */
}
```

**How it works:**
- **Min:** Never smaller than `1.5rem` (24px)
- **Preferred:** `5vw` (scales with viewport)
- **Max:** Never larger than `4rem` (64px)

**Barangay example:**
```css
.hero h1 {
    font-size: clamp(2rem, 5vw, 5rem);
    /* Mobile: 2rem (32px)
       Scales with viewport
       Desktop max: 5rem (80px) */
}

.section {
    padding: clamp(1rem, 5%, 3rem);
    /* Small: 1rem padding
       Scales with width
       Large: 3rem padding */
}
```

---

## Unit Conversion Reference

**Assuming default root font-size: 16px**

| Pixels | REM | EM (if parent is 16px) | % (if parent is 16px) |
|--------|-----|------------------------|------------------------|
| 8px | 0.5rem | 0.5em | 50% |
| 12px | 0.75rem | 0.75em | 75% |
| 14px | 0.875rem | 0.875em | 87.5% |
| 16px | 1rem | 1em | 100% |
| 20px | 1.25rem | 1.25em | 125% |
| 24px | 1.5rem | 1.5em | 150% |
| 32px | 2rem | 2em | 200% |
| 40px | 2.5rem | 2.5em | 250% |
| 48px | 3rem | 3em | 300% |

---

## Quick Reference

**Font Sizes:** Use `rem`
```css
font-size: 1rem;  /* Consistent, accessible */
```

**Widths:** Use `%` or `vw`
```css
width: 90%;       /* Relative to parent */
width: 100vw;     /* Full viewport */
```

**Heights:** Use `vh` for full-screen, `auto` otherwise
```css
height: 100vh;    /* Full screen */
height: auto;     /* Content-based */
```

**Spacing:** Use `rem`
```css
padding: 2rem;    /* Scales with root */
margin: 1rem;
```

**Modern Responsive:** Use `clamp()`
```css
font-size: clamp(1rem, 3vw, 2rem);
```

---

## Summary

Tian summarized:

**Responsive Units:**
- `%`: Relative to parent
- `em`: Relative to parent font-size (compounds)
- `rem`: Relative to root font-size (recommended)
- `vw`: 1% of viewport width
- `vh`: 1% of viewport height
- `clamp()`: Min, preferred, max

**Best Practices:**
- Typography: `rem`
- Widths: `%` or `vw`
- Heights: `vh` for full-screen
- Spacing: `rem`
- Always set root font-size in `html`

Rhea Joy smiled. "Now everything scales perfectly!"

---

## What's Next?

In the next lesson, you'll learn **CSS Grid**—a powerful 2D layout system for creating complex responsive layouts.

---

---

## Closing Story

Tian replaced fixed pixel values with relative units. Font sizes in 
em. Widths in %. Heights in h. The page became fluid. Flexible. Truly responsive.

"This is the secret," Kuya Miguel revealed. "Stop thinking in pixels. Think in proportions. Let the content adapt, not force it."

Tian resized the browser window. Everything scaled smoothly. No overflow. No broken layouts. Just clean, adaptive design. This was professional-grade work.

_Next up: CSS Gridpowerful layout system!_