# Lesson 15: The CSS Box Model

---

## Understanding Spacing in the Barangay Website

"Kuya Miguel, bakit ang sikip ng website natin?" Tian asked, staring at their barangay website where text and images were crammed together.

Rhea Joy nodded. "Yeah, walang breathing room. Everything is touching each other. Parang siksikan sa jeepney!"

Kuya Miguel laughed. "Ah, that's because you haven't learned about the CSS Box Model yet. It's one of the most important concepts in CSS—it controls spacing, borders, and layout."

---

## What is the CSS Box Model?

Every HTML element is treated as a **box** by the browser. The CSS Box Model describes how these boxes are structured and how they take up space on the page.

Each box has four layers (from inside to outside):

1. **Content** - The actual content (text, images, etc.)
2. **Padding** - Space between content and border (inside the box)
3. **Border** - A line around the padding and content
4. **Margin** - Space outside the border (between elements)

```
+----------------------------------------+
|              MARGIN                    |  <-- Space outside
|  +----------------------------------+  |
|  |            BORDER                |  |  <-- Border line
|  |  +--------------------------+    |  |
|  |  |       PADDING            |    |  |  <-- Space inside
|  |  |  +------------------+    |    |  |
|  |  |  |    CONTENT       |    |    |  |  <-- Text/Images
|  |  |  +------------------+    |    |  |
|  |  +--------------------------+    |  |
|  +----------------------------------+  |
+----------------------------------------+
```

---

## Content Area

The **content** area holds the actual content: text, images, videos, etc.

You control its size with `width` and `height`:

```css
.card {
    width: 300px;
    height: 200px;
}
```

**Filipino Example:**
```css
.announcement {
    width: 600px;    /* Content area width */
    height: auto;    /* Height adjusts to content */
}
```

---

## Padding

**Padding** creates space **inside** the element, between the content and the border.

### Individual Sides

```css
.box {
    padding-top: 10px;
    padding-right: 20px;
    padding-bottom: 10px;
    padding-left: 20px;
}
```

### Shorthand

```css
/* All sides */
.box {
    padding: 20px;  /* 20px on all sides */
}

/* Vertical | Horizontal */
.box {
    padding: 10px 20px;  /* 10px top/bottom, 20px left/right */
}

/* Top | Horizontal | Bottom */
.box {
    padding: 10px 20px 15px;  /* 10px top, 20px left/right, 15px bottom */
}

/* Top | Right | Bottom | Left (clockwise) */
.box {
    padding: 10px 20px 15px 5px;
}
```

**Mnemonic: TRouBLe (Top, Right, Bottom, Left)**

**Filipino Barangay Example:**
```css
.announcement {
    padding: 20px;           /* Space inside the announcement box */
    background-color: #fff3cd;
    border-left: 5px solid #ffc107;
}
```

This creates 20px of space between the text and the edges of the yellow box.

---

## Border

The **border** goes around the padding and content.

### Border Properties

```css
.box {
    border-width: 2px;       /* Thickness */
    border-style: solid;     /* Style */
    border-color: #1a73e8;   /* Color */
}
```

### Border Styles

```css
border-style: solid;   /* ━━━━ */
border-style: dashed;  /* ─ ─ ─ ─ */
border-style: dotted;  /* · · · · */
border-style: double;  /* ════ */
border-style: groove;  /* 3D grooved effect */
border-style: ridge;   /* 3D ridged effect */
border-style: inset;   /* 3D inset effect */
border-style: outset;  /* 3D outset effect */
border-style: none;    /* No border */
```

### Border Shorthand

```css
.box {
    border: 2px solid #1a73e8;  /* width style color */
}
```

### Individual Sides

```css
.card {
    border-top: 1px solid #ddd;
    border-right: none;
    border-bottom: 2px solid #1a73e8;
    border-left: 5px solid #ffc107;
}
```

**Filipino Example:**
```css
.service-card {
    border: 1px solid #e0e0e0;      /* Subtle gray border */
    border-radius: 8px;              /* Rounded corners */
}

.emergency-alert {
    border-left: 5px solid #dc3545;  /* Thick red left border */
}
```

---

## Border Radius (Rounded Corners)

```css
.box {
    border-radius: 10px;  /* All corners */
}

/* Individual corners */
.box {
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    border-bottom-right-radius: 0;
    border-bottom-left-radius: 0;
}

/* Shorthand: top-left, top-right, bottom-right, bottom-left */
.box {
    border-radius: 10px 10px 0 0;
}

/* Make a circle */
.circle {
    width: 100px;
    height: 100px;
    border-radius: 50%;  /* Circle when width = height */
}
```

---

## Margin

**Margin** creates space **outside** the element, between it and other elements.

### Individual Sides

```css
.box {
    margin-top: 20px;
    margin-right: 10px;
    margin-bottom: 20px;
    margin-left: 10px;
}
```

### Shorthand (same as padding)

```css
/* All sides */
.box {
    margin: 20px;
}

/* Vertical | Horizontal */
.box {
    margin: 20px 10px;  /* 20px top/bottom, 10px left/right */
}

/* Top | Right | Bottom | Left */
.box {
    margin: 20px 10px 15px 5px;
}
```

### Centering Elements

```css
.container {
    width: 800px;
    margin: 0 auto;  /* 0 top/bottom, auto left/right = centered */
}
```

**Filipino Example:**
```css
.announcement {
    width: 600px;
    margin: 20px auto;      /* 20px top/bottom, centered horizontally */
    padding: 20px;
    background-color: white;
}
```

---

## Padding vs. Margin

**When to use padding:**
- Add space **inside** an element
- Create breathing room between content and border
- Increase clickable/tappable area of buttons
- Padding is affected by background color/image

**When to use margin:**
- Add space **between** elements
- Separate sections of a page
- Center elements horizontally
- Margin is transparent (no background)

**Example:**
```html
<div class="box-1">Box 1</div>
<div class="box-2">Box 2</div>
```

```css
.box-1 {
    padding: 20px;        /* Space inside box */
    background-color: lightblue;
    margin-bottom: 30px;  /* Space to next element */
}

.box-2 {
    padding: 20px;
    background-color: lightgreen;
}
```

---

## Box Sizing

By default, `width` and `height` apply only to the **content area**. Padding and border are **added** to the width.

```css
.box {
    width: 300px;
    padding: 20px;
    border: 5px solid black;
}
```

**Total width** = 300px (content) + 40px (padding left/right) + 10px (border left/right) = **350px**

This can be confusing! That's why we use `box-sizing`:

### box-sizing: border-box

```css
.box {
    box-sizing: border-box;  /* Include padding and border in width */
    width: 300px;
    padding: 20px;
    border: 5px solid black;
}
```

Now **total width** = **300px** (includes padding and border)

**Best Practice:** Apply this to all elements:

```css
* {
    box-sizing: border-box;
}
```

This makes layout calculations much easier!

---

## Complete Barangay Example

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
    <header class="header">
        <h1>Barangay San Miguel</h1>
    </header>

    <div class="container">
        <div class="announcement emergency">
            <h2>Emergency Alert</h2>
            <p>Walang klase ngayong araw dahil sa signal #2.</p>
        </div>

        <div class="announcement">
            <h2>Barangay Assembly</h2>
            <p>Mayroon pong assembly sa Sabado, 2:00 PM sa covered court.</p>
        </div>

        <div class="service-cards">
            <div class="card">
                <h3>Barangay Clearance</h3>
                <p>3-5 business days processing</p>
            </div>
            <div class="card">
                <h3>Certificate of Residency</h3>
                <p>Same day processing</p>
            </div>
        </div>
    </div>
</body>
</html>
```

**CSS:**
```css
/* Global box-sizing */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    line-height: 1.6;
}

/* Header */
.header {
    background-color: #1a73e8;
    color: white;
    padding: 30px 20px;           /* Space inside header */
    margin-bottom: 40px;          /* Space below header */
    text-align: center;
}

.header h1 {
    margin: 0;                     /* Remove default margin */
}

/* Container */
.container {
    max-width: 800px;
    margin: 0 auto;                /* Center horizontally */
    padding: 0 20px;               /* Space on left/right */
}

/* Announcements */
.announcement {
    background-color: white;
    padding: 25px;                 /* Space inside */
    margin-bottom: 20px;           /* Space between announcements */
    border-left: 5px solid #ffc107;
    border-radius: 8px;            /* Rounded corners */
}

.announcement.emergency {
    background-color: #fff5f5;
    border-left-color: #dc3545;    /* Red for emergency */
}

.announcement h2 {
    margin-top: 0;                 /* Remove top margin */
    margin-bottom: 10px;           /* Space below heading */
    color: #1a73e8;
}

.announcement p {
    margin: 0;                     /* Remove default margins */
}

/* Service Cards */
.service-cards {
    display: flex;
    gap: 20px;                     /* Space between cards */
    margin-top: 30px;
}

.card {
    flex: 1;                       /* Equal width */
    background-color: white;
    padding: 20px;                 /* Space inside card */
    border: 2px solid #e0e0e0;
    border-radius: 12px;
    text-align: center;
}

.card h3 {
    margin-top: 0;
    margin-bottom: 10px;
    color: #34a853;
}

.card p {
    margin: 0;
    color: #666;
    font-size: 14px;
}
```

---

## Visualizing the Box Model

Kuya Miguel demonstrated using browser DevTools:

"Right-click any element → Inspect. Sa Styles panel, scroll down to see the Box Model diagram."

The diagram shows:
- **Blue** = Content
- **Green** = Padding
- **Orange** = Border
- **Yellow** = Margin

"Now you can see exactly how much space each element is using!"

---

## Common Spacing Patterns

### Card Spacing
```css
.card {
    padding: 20px;         /* Space inside */
    margin: 15px;          /* Space outside */
    border: 1px solid #ddd;
}
```

### Section Spacing
```css
section {
    padding: 60px 20px;    /* Vertical | Horizontal */
    margin-bottom: 40px;
}
```

### Button Spacing
```css
.button {
    padding: 12px 24px;    /* Comfortable click area */
    margin: 10px 5px;
    border: none;
    border-radius: 5px;
}
```

---

## Negative Margins

You can use negative margins to pull elements closer or overlap them:

```css
.overlap {
    margin-top: -20px;  /* Pulls element up by 20px */
}
```

**Use carefully!** Can cause layout issues if not planned properly.

---

## Best Practices

1. **Use `box-sizing: border-box`** for all elements
   ```css
   * {
       box-sizing: border-box;
   }
   ```

2. **Reset default margins/padding**
   ```css
   * {
       margin: 0;
       padding: 0;
   }
   ```

3. **Use consistent spacing values**
   ```css
   /* Create a spacing scale */
   --spacing-xs: 5px;
   --spacing-sm: 10px;
   --spacing-md: 20px;
   --spacing-lg: 40px;
   --spacing-xl: 60px;
   ```

4. **Use padding for internal spacing, margin for external**

5. **Center containers with `margin: 0 auto`**

6. **Use `border-radius` for modern, rounded designs**

---

## Common Mistakes

1. **Forgetting `box-sizing`**
   ```css
   /* Width will be 340px, not 300px! */
   .box {
       width: 300px;
       padding: 20px;
   }
   
   /* Fix: */
   .box {
       box-sizing: border-box;
       width: 300px;
       padding: 20px;  /* Width stays 300px */
   }
   ```

2. **Margin collapse** (vertical margins between elements merge)
   ```css
   .box1 { margin-bottom: 20px; }
   .box2 { margin-top: 30px; }
   /* Gap between boxes = 30px (not 50px) */
   ```

3. **Using margin instead of padding for internal spacing**
   ```css
   /* Wrong - background won't extend around text */
   .button {
       margin: 10px 20px;
       background: blue;
   }
   
   /* Right - creates clickable area with background */
   .button {
       padding: 10px 20px;
       background: blue;
   }
   ```

---

## Summary

Tian summarized in his notebook:

**Box Model Layers (inside → outside):**
1. **Content** - Text, images
2. **Padding** - Space inside border
3. **Border** - Line around padding
4. **Margin** - Space outside border

**Key Properties:**
- `width`, `height` - Content size
- `padding` - Internal spacing
- `border` - Element outline
- `margin` - External spacing
- `box-sizing: border-box` - Include padding/border in width
- `border-radius` - Rounded corners

Rhea Joy smiled. "Now our barangay website has proper breathing room. Hindi na siksikan!"

---

## What's Next?

In the next lesson, you'll learn about **CSS Display Types**—the difference between block, inline, and inline-block elements, and how they affect layout.

---