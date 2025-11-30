## Background Story

The barangay website had a new requirement from Ms. Reyes, the barangay secretary: emergency announcements needed a visual indicator. When an announcement was urgent (like typhoon warnings, health alerts, or security notices), a red "EMERGENCY" badge should appear in the top-right corner of the announcement card.

Tian created the badge HTML:

```html
<div class="announcement-card">
  <span class="emergency-badge">EMERGENCY</span>
  <h3>Typhoon Warning</h3>
  <p>All residents are advised to stay indoors...</p>
</div>
```

They styled the badge with red background and white text. But positioning it in the top-right corner was proving impossible. The badge appeared at the beginning of the card, pushing the heading down. When Tian tried using margins to move it right and up, it pushed other content around, breaking the layout.

```css
.emergency-badge {
    background: red;
    color: white;
    margin-top: -20px;  /* Trying to move it up */
    margin-right: -100px;  /* Trying to move it right */
}
```

This created chaos—overlapping text, broken layouts, content pushed out of containers. There had to be a better way to place elements precisely without affecting surrounding content.

Rhea Joy was facing a different but related problem. She'd created a navigation bar that looked great at the top of the page. But when users scrolled down to read long content, the navigation disappeared off-screen. She'd seen websites where the navigation "stuck" to the top of the viewport even during scrolling—how was that achieved?

She tried various CSS approaches:

```css
.navbar {
    margin-top: 0;
    top: 0;
}
```

Nothing worked. The navbar remained in its normal position in the document flow, scrolling away when users moved down the page.

Both of them were encountering the limits of normal document flow. They needed to break elements out of the standard layout and position them in specific, controlled ways.

It was Tuesday evening. They were both on a video call with Kuya Miguel, sharing screens and explaining their positioning challenges.

"I need this badge to float in the top-right corner of its container," Tian said, "but every method I try either pushes content around or doesn't work at all."

"And I need this navbar to stay at the top of the screen even when scrolling," Rhea Joy added. "I've seen it on professional websites but I don't know the CSS for it."

Miguel pulled up his code editor.

"You both need to understand CSS positioning—one of the most powerful but initially confusing topics in CSS. By default, all elements use `position: static`, which means they follow normal document flow. But CSS provides four other positioning schemes: `relative`, `absolute`, `fixed`, and `sticky`. Each removes elements from normal flow in different ways."

"So we can make elements ignore normal flow?" Tian asked.

"Exactly. Absolute positioning removes an element from the document flow entirely and positions it relative to its nearest positioned ancestor. That's perfect for your emergency badge. Fixed positioning positions elements relative to the viewport and keeps them there even during scrolling—perfect for Rhea Joy's navbar."

Miguel continued, "But here's the tricky part: positioning is powerful but can be confusing. You need to understand the relationship between `position` values and the offset properties (`top`, `right`, `bottom`, `left`). You need to understand `z-index` for stacking order. And you need to know when *not* to use positioning—modern layout systems like Flexbox and Grid often provide better solutions."

"Can you teach us all of this today?" both asked.

"Absolutely. Today we're covering all positioning types, when to use each, common positioning patterns, and how to avoid common pitfalls. By the end of this lesson, you'll be able to place elements exactly where you need them."

---

## Theory & Lecture Content

## What is CSS Positioning?

The `position` property controls **how** and **where** an element is placed on the page.

```css
element {
    position: static;    /* Default - normal flow */
    position: relative;  /* Offset from normal position */
    position: absolute;  /* Removed from flow, positioned relative to parent */
    position: fixed;     /* Positioned relative to viewport */
    position: sticky;    /* Hybrid: relative + fixed */
}
```

When you use positioning (except `static`), you can use:
- `top` - Distance from top
- `right` - Distance from right
- `bottom` - Distance from bottom
- `left` - Distance from left
- `z-index` - Stacking order (higher = front)

---

## Position: Static (Default)

Every element is `static` by default. Elements follow normal document flow.

```css
.element {
    position: static;  /* Default */
    /* top, right, bottom, left have NO effect */
}
```

**Normal flow** means:
- Block elements stack vertically
- Inline elements flow horizontally
- No overlap (unless using margin/padding)

---

## Position: Relative

**Relative positioning** moves an element **relative to its original position**, but the original space is **preserved**.

```css
.box {
    position: relative;
    top: 20px;      /* Moves 20px DOWN from original position */
    left: 30px;     /* Moves 30px RIGHT from original position */
}
```

**Key points:**
- Element shifts from original position
- Original space is **still occupied** (other elements don't move)
- Element can overlap other content

**Example:**
```html
<div class="box box1">Box 1</div>
<div class="box box2">Box 2 (shifted)</div>
<div class="box box3">Box 3</div>
```

```css
.box {
    width: 100px;
    height: 100px;
    background: lightblue;
    margin: 10px;
}

.box2 {
    position: relative;
    top: 20px;      /* Moves down */
    left: 30px;     /* Moves right */
    background: lightcoral;
}
```

Box 2 shifts down and right, but Box 3 stays in its original position (gap remains where Box 2 was).

**Filipino Barangay Example:**
```css
.announcement-badge {
    position: relative;
    top: -5px;      /* Lift badge slightly */
    background: #dc3545;
    color: white;
    padding: 3px 8px;
    border-radius: 3px;
}
```

---

## Position: Absolute

**Absolute positioning** removes the element from normal flow and positions it **relative to its nearest positioned ancestor** (an ancestor with `position: relative`, `absolute`, or `fixed`).

If no positioned ancestor exists, it positions relative to the `<body>`.

```css
.parent {
    position: relative;  /* Establishes positioning context */
}

.child {
    position: absolute;
    top: 10px;           /* 10px from parent's top */
    right: 10px;         /* 10px from parent's right */
}
```

**Key points:**
- Element is **removed from normal flow** (other elements behave as if it doesn't exist)
- No space is reserved for it
- Positioned relative to nearest positioned ancestor

**Filipino Barangay Example:**
```html
<div class="announcement-card">
    <span class="emergency-badge">URGENT</span>
    <h3>Emergency Announcement</h3>
    <p>Suspended ang classes dahil sa typhoon.</p>
</div>
```

```css
.announcement-card {
    position: relative;     /* Establishes context for badge */
    padding: 20px;
    background: white;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
}

.emergency-badge {
    position: absolute;     /* Positioned absolutely within card */
    top: 10px;              /* 10px from top of card */
    right: 10px;            /* 10px from right of card */
    background: #dc3545;
    color: white;
    padding: 5px 12px;
    border-radius: 5px;
    font-size: 12px;
    font-weight: bold;
}
```

The badge appears in the top-right corner without pushing other content!

---

## Position: Fixed

**Fixed positioning** positions the element **relative to the viewport** (browser window). It stays in place even when scrolling.

```css
.navbar {
    position: fixed;
    top: 0;          /* Stick to top of viewport */
    left: 0;
    width: 100%;     /* Full width */
    z-index: 1000;   /* Above other content */
}
```

**Key points:**
- Removed from normal flow
- Positioned relative to viewport
- **Stays in place when scrolling**
- Common for headers, navigation, "back to top" buttons

**Filipino Barangay Example:**
```css
/* Fixed navigation bar */
.header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background: #1a73e8;
    color: white;
    padding: 15px 20px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    z-index: 100;
}

/* Add padding to body so content doesn't hide under fixed header */
body {
    padding-top: 60px;  /* Height of fixed header */
}

/* "Back to Top" button */
.back-to-top {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background: #1a73e8;
    color: white;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    text-align: center;
    line-height: 50px;
    cursor: pointer;
    box-shadow: 0 2px 10px rgba(0,0,0,0.2);
}
```

---

## Position: Sticky

**Sticky positioning** is a hybrid: it acts like `relative` until you scroll past a threshold, then it acts like `fixed`.

```css
.section-header {
    position: sticky;
    top: 0;           /* Stick to top when scrolling */
    background: white;
    padding: 10px;
    border-bottom: 2px solid #e0e0e0;
    z-index: 10;
}
```

**Key points:**
- Acts **relative** within its container
- Becomes **fixed** when scrolling past `top` threshold
- Must specify `top`, `bottom`, `left`, or `right`
- Parent must have enough height to scroll

**Filipino Example:**
```css
/* Sticky navigation that sticks after scrolling past header */
.nav {
    position: sticky;
    top: 0;
    background: #1a73e8;
    color: white;
    padding: 15px;
    z-index: 100;
}
```

---

## Z-Index (Stacking Order)

When elements overlap, `z-index` controls which appears on top.

```css
.element {
    position: relative;  /* z-index only works on positioned elements */
    z-index: 10;         /* Higher = closer to viewer */
}
```

**Rules:**
- Only works on positioned elements (`relative`, `absolute`, `fixed`, `sticky`)
- Higher values appear in front
- Default is `auto` (stacking order based on HTML order)

**Example:**
```css
.background {
    position: absolute;
    z-index: 1;      /* Behind */
}

.content {
    position: relative;
    z-index: 10;     /* Middle */
}

.popup {
    position: fixed;
    z-index: 1000;   /* Front (on top of everything) */
}
```

**Common z-index scale:**
```css
/* Base content: 1-10 */
.content { z-index: 1; }

/* Dropdowns/tooltips: 100-500 */
.dropdown { z-index: 100; }

/* Fixed headers: 500-900 */
.header { z-index: 500; }

/* Modals/overlays: 1000+ */
.modal-overlay { z-index: 1000; }
.modal { z-index: 1001; }
```

---

## Complete Barangay Website Example

**HTML:**
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
    <!-- Fixed header -->
    <header class="header">
        <h1>Barangay San Miguel</h1>
        <nav>
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#announcements">Announcements</a>
        </nav>
    </header>

    <!-- Main content -->
    <main class="container">
        <!-- Sticky section header -->
        <section id="announcements">
            <h2 class="section-header">Announcements</h2>
            
            <!-- Card with absolute badge -->
            <div class="announcement-card">
                <span class="badge emergency">URGENT</span>
                <h3>Emergency Alert</h3>
                <p>Suspended ang classes dahil sa signal #2. Stay safe!</p>
            </div>

            <div class="announcement-card">
                <span class="badge">NEW</span>
                <h3>Barangay Assembly</h3>
                <p>Regular assembly sa Sabado, 2:00 PM sa covered court.</p>
            </div>
        </section>

        <section id="services">
            <h2 class="section-header">Services</h2>
            <p>Lorem ipsum dolor sit amet... (long content for scrolling)</p>
            <!-- More content -->
        </section>
    </main>

    <!-- Fixed back-to-top button -->
    <button class="back-to-top" onclick="window.scrollTo({top: 0, behavior: 'smooth'});">
        ↑
    </button>
</body>
</html>
```

**CSS:**
```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    padding-top: 80px;  /* Space for fixed header */
}

/* Fixed header */
.header {
    position: fixed;    /* Stays at top when scrolling */
    top: 0;
    left: 0;
    width: 100%;
    background: #1a73e8;
    color: white;
    padding: 20px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    z-index: 100;       /* Above content */
}

.header h1 {
    margin-bottom: 10px;
}

.header nav a {
    color: white;
    text-decoration: none;
    margin-right: 20px;
    padding: 5px 10px;
}

.header nav a:hover {
    background: rgba(255,255,255,0.2);
    border-radius: 3px;
}

/* Sticky section headers */
.section-header {
    position: sticky;   /* Sticks to top when scrolling */
    top: 80px;          /* Below fixed header */
    background: #f5f5f5;
    padding: 15px 20px;
    border-bottom: 3px solid #1a73e8;
    z-index: 50;        /* Above cards */
    margin-bottom: 20px;
}

/* Container */
.container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

/* Announcement cards with absolute badges */
.announcement-card {
    position: relative;  /* Context for absolute badge */
    background: white;
    padding: 25px;
    margin-bottom: 20px;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

/* Absolute badge */
.badge {
    position: absolute;  /* Positioned within card */
    top: 15px;
    right: 15px;
    background: #34a853;
    color: white;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: bold;
    text-transform: uppercase;
}

.badge.emergency {
    background: #dc3545;
}

.announcement-card h3 {
    color: #1a73e8;
    margin-bottom: 10px;
    padding-right: 80px;  /* Space for badge */
}

/* Fixed back-to-top button */
.back-to-top {
    position: fixed;     /* Stays in corner */
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    background: #1a73e8;
    color: white;
    border: none;
    border-radius: 50%;
    font-size: 20px;
    cursor: pointer;
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    z-index: 200;        /* Above everything */
    transition: background 0.3s;
}

.back-to-top:hover {
    background: #1557b0;
}
```

---

## Centering with Absolute Positioning

A common technique to center elements:

```css
.centered {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);  /* Shift back by half its size */
}
```

**Modal example:**
```css
.modal {
    position: fixed;     /* Cover viewport */
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);  /* Dark overlay */
    z-index: 1000;
}

.modal-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: white;
    padding: 30px;
    border-radius: 10px;
    max-width: 500px;
}
```

---

## Best Practices

1. **Use `position: relative` on parent for absolute children**
   ```css
   .card {
       position: relative;  /* Context for badges, overlays */
   }
   .badge {
       position: absolute;
   }
   ```

2. **Add padding to body for fixed headers**
   ```css
   .header { position: fixed; height: 60px; }
   body { padding-top: 60px; }
   ```

3. **Use z-index scale consistently**
   - Content: 1-10
   - Dropdowns: 100-500
   - Headers: 500-900
   - Modals: 1000+

4. **Test sticky on different browsers** (older browsers may not support)

5. **Avoid overusing absolute positioning** (hard to maintain)

---

## Common Mistakes

1. **Forgetting `position: relative` on parent**
   ```css
   /* Won't work as expected */
   .card { /* no position */ }
   .badge { position: absolute; top: 10px; }  /* Positions relative to body! */
   
   /* Fix */
   .card { position: relative; }
   .badge { position: absolute; top: 10px; }  /* Positions relative to card */
   ```

2. **Not accounting for fixed header height**
   ```css
   .header { position: fixed; height: 60px; }
   /* Content hidden under header! */
   
   /* Fix */
   body { padding-top: 60px; }
   ```

3. **Using z-index without positioning**
   ```css
   /* Won't work */
   .element { z-index: 100; }  /* No position property */
   
   /* Fix */
   .element { position: relative; z-index: 100; }
   ```

---

## Summary

Tian summarized:

**Position Types:**
- **static**: Normal flow (default)
- **relative**: Offset from original, space preserved
- **absolute**: Removed from flow, relative to positioned parent
- **fixed**: Relative to viewport, stays when scrolling
- **sticky**: Relative until threshold, then fixed

**Positioning Properties:**
- `top`, `right`, `bottom`, `left`
- `z-index` (stacking order)

**Common Patterns:**
- Fixed header: `position: fixed; top: 0;`
- Badges: Parent `relative`, badge `absolute`
- Sticky headers: `position: sticky; top: 0;`

Rhea Joy smiled. "Now I can create floating badges and sticky navigation!"

---

## What's Next?

In the next lesson, you'll learn about **Flexbox**—a modern layout system that makes it easy to create responsive, flexible layouts without complex positioning.

---

---

## Closing Story

Tian positioned elements using static, relative, absolute, fixed, and sticky. The page came aliveelements floating, overlapping, staying fixed during scroll.

"Be careful with positioning," Kuya Miguel warned. "It's powerful but dangerous. Overuse it, and your layout breaks on different screen sizes."

Tian created a sticky navigation bar that stayed at the top during scroll. Added a fixed announcement banner. The page felt dynamic now. Interactive. Modern.

_Next up: Flexbox Basicsthe future of layout!_