# Lesson 15 Activities: CSS Box Model

## Understanding Spacing: The Foundation of Layout

Master the CSS Box Model to create professional layouts with proper spacing and breathing room!

---

## Activity 1: Box Model Visualization

**Goal:** Understand the four layers of the box model.

**Create:** `box-model-demo.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Box Model Visualization</title>
    <link rel="stylesheet" href="box-model-demo.css">
</head>
<body>
    <h1>CSS Box Model Layers</h1>
    
    <div class="box-container">
        <div class="box">
            <p>CONTENT</p>
            <p class="small">The actual content (text, images)</p>
        </div>
    </div>
    
    <div class="legend">
        <div class="legend-item">
            <span class="color content-color"></span>
            <span>Content - The actual text/images</span>
        </div>
        <div class="legend-item">
            <span class="color padding-color"></span>
            <span>Padding - Space inside border</span>
        </div>
        <div class="legend-item">
            <span class="color border-color"></span>
            <span>Border - Line around padding</span>
        </div>
        <div class="legend-item">
            <span class="color margin-color"></span>
            <span>Margin - Space outside border</span>
        </div>
    </div>
</body>
</html>
```

**Create:** `box-model-demo.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    padding: 40px;
    background-color: #f5f5f5;
}

h1 {
    text-align: center;
    margin-bottom: 40px;
    color: #1a73e8;
}

.box-container {
    background-color: #ffeb3b;  /* Margin (yellow) */
    padding: 30px;               /* Represents margin */
    margin: 0 auto 40px;
    max-width: 600px;
}

.box {
    background-color: #ff9800;  /* Border (orange) */
    padding: 5px;                /* Represents border */
}

.box {
    background-color: #4caf50;  /* Padding (green) */
    padding: 30px;
}

.box p {
    background-color: #2196f3;  /* Content (blue) */
    color: white;
    padding: 20px;
    margin: 0;
    text-align: center;
}

.box .small {
    font-size: 14px;
    margin-top: 10px;
}

/* Legend */
.legend {
    max-width: 600px;
    margin: 0 auto;
}

.legend-item {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.color {
    display: inline-block;
    width: 30px;
    height: 30px;
    margin-right: 15px;
    border: 1px solid #333;
}

.content-color { background-color: #2196f3; }
.padding-color { background-color: #4caf50; }
.border-color { background-color: #ff9800; }
.margin-color { background-color: #ffeb3b; }
```

**Test:** Open in browser, inspect with DevTools, observe box model diagram.

---

## Activity 2: Padding Practice

**Goal:** Master padding properties for internal spacing.

**Create:** `padding-practice.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Padding Practice</title>
    <link rel="stylesheet" href="padding-practice.css">
</head>
<body>
    <h1>Padding Examples</h1>
    
    <div class="example">
        <h2>No Padding</h2>
        <div class="box no-padding">
            Text touches edges. Uncomfortable!
        </div>
    </div>
    
    <div class="example">
        <h2>Equal Padding (20px)</h2>
        <div class="box equal-padding">
            Much better! Space around text.
        </div>
    </div>
    
    <div class="example">
        <h2>Vertical | Horizontal (10px 30px)</h2>
        <div class="box vh-padding">
            10px top/bottom, 30px left/right
        </div>
    </div>
    
    <div class="example">
        <h2>Individual Sides</h2>
        <div class="box individual-padding">
            Top: 5px, Right: 30px, Bottom: 15px, Left: 10px
        </div>
    </div>
</body>
</html>
```

**Create:** `padding-practice.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    padding: 40px;
    background-color: #f5f5f5;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

.example {
    margin-bottom: 30px;
}

.example h2 {
    font-size: 18px;
    color: #333;
    margin-bottom: 10px;
}

.box {
    background-color: #4caf50;
    color: white;
    border: 3px solid #2e7d32;
    max-width: 500px;
}

/* No padding - cramped */
.no-padding {
    padding: 0;
}

/* Equal padding on all sides */
.equal-padding {
    padding: 20px;
}

/* Vertical | Horizontal */
.vh-padding {
    padding: 10px 30px;
}

/* Individual sides (top, right, bottom, left) */
.individual-padding {
    padding-top: 5px;
    padding-right: 30px;
    padding-bottom: 15px;
    padding-left: 10px;
}
```

**Observe:** Notice how padding creates breathing room inside elements.

---

## Activity 3: Margin Practice

**Goal:** Master margin properties for external spacing.

**Create:** `margin-practice.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Margin Practice</title>
    <link rel="stylesheet" href="margin-practice.css">
</head>
<body>
    <h1>Margin Examples</h1>
    
    <h2>No Margins - Cards Touch</h2>
    <div class="card no-margin">Card 1</div>
    <div class="card no-margin">Card 2</div>
    <div class="card no-margin">Card 3</div>
    
    <h2>Bottom Margin - Cards Separated</h2>
    <div class="card with-margin">Card 1</div>
    <div class="card with-margin">Card 2</div>
    <div class="card with-margin">Card 3</div>
    
    <h2>Centered with Auto Margin</h2>
    <div class="card centered">Centered Card</div>
</body>
</html>
```

**Create:** `margin-practice.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    padding: 40px;
    background-color: #f5f5f5;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

h2 {
    font-size: 18px;
    color: #666;
    margin: 30px 0 15px;
}

.card {
    background-color: #2196f3;
    color: white;
    padding: 20px;
    border-radius: 8px;
}

/* No margin - cards touch */
.no-margin {
    margin: 0;
}

/* With bottom margin - cards separated */
.with-margin {
    margin-bottom: 15px;
}

/* Centered using auto margin */
.centered {
    width: 300px;
    margin: 0 auto;  /* Horizontal centering */
}
```

**Test:** See how margins create space between elements and center containers.

---

## Activity 4: Border Styling

**Goal:** Apply and style borders effectively.

**Create:** `border-styles.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Border Styles</title>
    <link rel="stylesheet" href="border-styles.css">
</head>
<body>
    <h1>Border Styles</h1>
    
    <div class="border-demo solid-border">Solid Border</div>
    <div class="border-demo dashed-border">Dashed Border</div>
    <div class="border-demo dotted-border">Dotted Border</div>
    <div class="border-demo double-border">Double Border</div>
    <div class="border-demo left-accent">Left Accent Border</div>
    <div class="border-demo rounded-border">Rounded Border</div>
    <div class="border-demo circle">Circle</div>
</body>
</html>
```

**Create:** `border-styles.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    padding: 40px;
    background-color: #f5f5f5;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

.border-demo {
    background-color: white;
    padding: 20px;
    margin-bottom: 20px;
    max-width: 400px;
    margin-left: auto;
    margin-right: auto;
}

/* Different border styles */
.solid-border {
    border: 3px solid #2196f3;
}

.dashed-border {
    border: 3px dashed #4caf50;
}

.dotted-border {
    border: 3px dotted #ff9800;
}

.double-border {
    border: 5px double #9c27b0;
}

/* Left accent (common pattern) */
.left-accent {
    border-left: 5px solid #f44336;
    border: 1px solid #e0e0e0;
    border-left-width: 5px;
    border-left-color: #f44336;
}

/* Rounded corners */
.rounded-border {
    border: 2px solid #00bcd4;
    border-radius: 15px;
}

/* Circle (width = height, 50% radius) */
.circle {
    width: 150px;
    height: 150px;
    border: 3px solid #673ab7;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
}
```

**Experiment:** Try different border styles, widths, and colors.

---

## Activity 5: Box-Sizing Property

**Goal:** Understand `box-sizing: border-box` vs `content-box`.

**Create:** `box-sizing-demo.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Box-Sizing Demo</title>
    <link rel="stylesheet" href="box-sizing-demo.css">
</head>
<body>
    <h1>Box-Sizing Comparison</h1>
    
    <div class="container">
        <div class="box content-box">
            <h3>content-box (default)</h3>
            <p>Width: 300px</p>
            <p>Padding: 20px</p>
            <p>Border: 5px</p>
            <p class="total">Total width: 350px!</p>
            <p class="calculation">(300 + 40 + 10)</p>
        </div>
        
        <div class="box border-box">
            <h3>border-box</h3>
            <p>Width: 300px</p>
            <p>Padding: 20px</p>
            <p>Border: 5px</p>
            <p class="total">Total width: 300px!</p>
            <p class="calculation">(Padding & border included)</p>
        </div>
    </div>
    
    <div class="explanation">
        <h2>Why use border-box?</h2>
        <p><strong>content-box:</strong> Width doesn't include padding/border (confusing!)</p>
        <p><strong>border-box:</strong> Width includes padding/border (predictable!)</p>
        <p class="recommendation">✅ Recommendation: Always use border-box</p>
    </div>
</body>
</html>
```

**Create:** `box-sizing-demo.css`

```css
/* Don't apply box-sizing globally yet - we want to demonstrate the difference */

body {
    font-family: Arial, sans-serif;
    padding: 40px;
    background-color: #f5f5f5;
    margin: 0;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
}

.container {
    display: flex;
    gap: 30px;
    justify-content: center;
    margin-bottom: 40px;
    flex-wrap: wrap;
}

.box {
    width: 300px;
    padding: 20px;
    border: 5px solid #2196f3;
    background-color: white;
}

/* Default - width doesn't include padding/border */
.content-box {
    box-sizing: content-box;
    background-color: #ffebee;
    border-color: #f44336;
}

/* Modern - width includes padding/border */
.border-box {
    box-sizing: border-box;
    background-color: #e8f5e9;
    border-color: #4caf50;
}

.box h3 {
    margin-top: 0;
    margin-bottom: 15px;
    color: #333;
}

.box p {
    margin: 5px 0;
    color: #666;
}

.total {
    font-weight: bold;
    color: #1a73e8;
    margin-top: 15px;
}

.calculation {
    font-size: 14px;
    font-style: italic;
    color: #999;
}

.explanation {
    max-width: 800px;
    margin: 0 auto;
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.explanation h2 {
    color: #1a73e8;
    margin-bottom: 15px;
}

.explanation p {
    margin-bottom: 10px;
    line-height: 1.6;
}

.recommendation {
    background-color: #e8f5e9;
    padding: 15px;
    border-left: 4px solid #4caf50;
    margin-top: 20px;
    font-weight: bold;
}
```

**Test:** Inspect both boxes in DevTools to see the total width difference.

---

## Activity 6: Barangay Announcement Card

**Goal:** Apply box model properties to create a professional card.

**Create:** `announcement-card.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Announcement Card</title>
    <link rel="stylesheet" href="announcement-card.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Announcements</h1>
        
        <div class="announcement-card urgent">
            <span class="badge">URGENT</span>
            <h2>Typhoon Warning</h2>
            <p class="date">December 4, 2025</p>
            <p class="content">
                Signal #2 is in effect. All classes and work in government 
                offices are suspended. Residents are advised to stay indoors 
                and secure their properties.
            </p>
            <button class="btn">Read More</button>
        </div>
        
        <div class="announcement-card">
            <span class="badge">NEW</span>
            <h2>Barangay Assembly</h2>
            <p class="date">December 10, 2025</p>
            <p class="content">
                Regular monthly assembly will be held at the covered court 
                at 2:00 PM. All residents are encouraged to attend.
            </p>
            <button class="btn">Read More</button>
        </div>
        
        <div class="announcement-card">
            <span class="badge">EVENT</span>
            <h2>Christmas Program</h2>
            <p class="date">December 20, 2025</p>
            <p class="content">
                Join us for our annual Christmas celebration with games, 
                raffles, and gift-giving for children and senior citizens.
            </p>
            <button class="btn">Read More</button>
        </div>
    </div>
</body>
</html>
```

**Create:** `announcement-card.css`

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;  /* Always use border-box! */
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 40px 20px;
}

.container {
    max-width: 800px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #1a73e8;
    margin-bottom: 40px;
    font-size: 2rem;
}

/* Announcement Card with Box Model */
.announcement-card {
    background-color: white;
    padding: 25px;                /* Internal spacing */
    margin-bottom: 25px;          /* Space between cards */
    border: 2px solid #e0e0e0;    /* Border */
    border-left-width: 5px;       /* Accent border */
    border-left-color: #2196f3;   /* Blue accent */
    border-radius: 10px;          /* Rounded corners */
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    position: relative;
}

/* Urgent variant - red accent */
.announcement-card.urgent {
    border-left-color: #f44336;
    background-color: #fff5f5;
}

/* Badge */
.badge {
    display: inline-block;
    background-color: #2196f3;
    color: white;
    padding: 5px 12px;            /* Internal spacing */
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
    margin-bottom: 15px;          /* Space below badge */
}

.urgent .badge {
    background-color: #f44336;
}

/* Heading */
.announcement-card h2 {
    color: #333;
    font-size: 1.5rem;
    margin-bottom: 10px;          /* Space below heading */
}

/* Date */
.date {
    color: #666;
    font-size: 14px;
    margin-bottom: 15px;          /* Space below date */
}

/* Content */
.content {
    color: #555;
    line-height: 1.6;
    margin-bottom: 20px;          /* Space below content */
}

/* Button */
.btn {
    background-color: #1a73e8;
    color: white;
    border: none;
    padding: 10px 20px;           /* Internal spacing */
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    transition: background-color 0.3s;
}

.btn:hover {
    background-color: #1557b0;
}

/* Responsive */
@media (max-width: 768px) {
    .announcement-card {
        padding: 20px;            /* Less padding on mobile */
        margin-bottom: 20px;
    }
    
    h1 {
        font-size: 1.5rem;
    }
    
    .announcement-card h2 {
        font-size: 1.2rem;
    }
}
```

**Key concepts applied:**
- Padding for internal spacing
- Margin for external spacing
- Border for visual separation
- Border-radius for rounded corners
- box-sizing: border-box for predictable sizing

---

## Activity 7: Complete Barangay Service Cards

**Goal:** Create a professional service card layout using all box model concepts.

**Create:** `service-cards.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Services</title>
    <link rel="stylesheet" href="service-cards.css">
</head>
<body>
    <header class="header">
        <h1>Barangay San Miguel Services</h1>
        <p class="tagline">Fast, Efficient, Transparent</p>
    </header>
    
    <main class="container">
        <div class="services-grid">
            <div class="service-card">
                <div class="icon">📄</div>
                <h3>Barangay Clearance</h3>
                <p class="description">
                    Required for employment, business permits, and various transactions.
                </p>
                <p class="processing">Processing: 3-5 business days</p>
                <p class="fee">₱50.00</p>
                <button class="btn btn-primary">Apply Now</button>
            </div>
            
            <div class="service-card featured">
                <span class="ribbon">Most Popular</span>
                <div class="icon">🆔</div>
                <h3>Barangay ID</h3>
                <p class="description">
                    Official identification card for all barangay residents.
                </p>
                <p class="processing">Processing: Same day</p>
                <p class="fee">₱30.00</p>
                <button class="btn btn-primary">Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">💼</div>
                <h3>Business Permit</h3>
                <p class="description">
                    Register your business and operate legally within the barangay.
                </p>
                <p class="processing">Processing: 5-7 business days</p>
                <p class="fee">₱500.00</p>
                <button class="btn btn-primary">Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">📝</div>
                <h3>Certificate of Residency</h3>
                <p class="description">
                    Proof of residence within Barangay San Miguel.
                </p>
                <p class="processing">Processing: 1-2 business days</p>
                <p class="fee">₱30.00</p>
                <button class="btn btn-primary">Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">💸</div>
                <h3>Indigency Certificate</h3>
                <p class="description">
                    For medical assistance and government programs.
                </p>
                <p class="processing">Processing: 2-3 business days</p>
                <p class="fee">Free</p>
                <button class="btn btn-primary">Apply Now</button>
            </div>
            
            <div class="service-card">
                <div class="icon">👥</div>
                <h3>Community Tax Certificate</h3>
                <p class="description">
                    Annual tax certification (Cedula) for residents.
                </p>
                <p class="processing">Processing: Same day</p>
                <p class="fee">₱5.00 - ₱500.00</p>
                <button class="btn btn-primary">Apply Now</button>
            </div>
        </div>
    </main>
</body>
</html>
```

**Create:** `service-cards.css`

```css
/* GLOBAL RESET with box-sizing */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
    background-color: #f5f5f5;
    line-height: 1.6;
}

/* HEADER */
.header {
    background: linear-gradient(135deg, #1a73e8 0%, #4caf50 100%);
    color: white;
    text-align: center;
    padding: 60px 20px;              /* Padding for internal spacing */
    margin-bottom: 50px;             /* Margin for space below */
}

.header h1 {
    font-size: 2.5rem;
    margin-bottom: 10px;
}

.tagline {
    font-size: 1.2rem;
    opacity: 0.95;
}

/* CONTAINER */
.container {
    max-width: 1200px;
    margin: 0 auto;                  /* Auto margin for centering */
    padding: 0 20px 60px;            /* Padding on sides and bottom */
}

/* SERVICES GRID */
.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;                       /* Space between cards */
}

/* SERVICE CARD with Complete Box Model */
.service-card {
    background-color: white;
    padding: 30px;                   /* Internal spacing */
    border: 2px solid #e0e0e0;       /* Border */
    border-radius: 15px;             /* Rounded corners */
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    text-align: center;
    position: relative;
    transition: transform 0.3s, box-shadow 0.3s;
}

.service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0,0,0,0.15);
}

/* Featured Card */
.service-card.featured {
    border-color: #ff9800;
    border-width: 3px;
    background: linear-gradient(to bottom, #fff9e6 0%, white 100%);
}

/* Ribbon for Featured */
.ribbon {
    position: absolute;
    top: 15px;
    right: -5px;
    background-color: #ff9800;
    color: white;
    padding: 5px 15px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
    border-radius: 3px 0 0 3px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
}

/* Icon */
.icon {
    font-size: 64px;
    margin-bottom: 20px;
}

/* Card Heading */
.service-card h3 {
    font-size: 1.5rem;
    color: #1a73e8;
    margin-bottom: 15px;            /* Space below heading */
}

/* Description */
.description {
    color: #666;
    margin-bottom: 15px;            /* Space below description */
    min-height: 60px;
}

/* Processing Time */
.processing {
    font-size: 14px;
    color: #999;
    margin-bottom: 10px;
}

/* Fee */
.fee {
    font-size: 1.8rem;
    font-weight: bold;
    color: #4caf50;
    margin: 20px 0;                 /* Space above and below */
}

/* Button */
.btn {
    display: inline-block;
    padding: 12px 30px;             /* Internal button spacing */
    border: none;
    border-radius: 25px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s;
    text-decoration: none;
}

.btn-primary {
    background-color: #1a73e8;
    color: white;
}

.btn-primary:hover {
    background-color: #1557b0;
    transform: scale(1.05);
}

/* RESPONSIVE DESIGN */
@media (max-width: 768px) {
    .header {
        padding: 40px 20px;         /* Less padding on mobile */
    }
    
    .header h1 {
        font-size: 1.8rem;
    }
    
    .tagline {
        font-size: 1rem;
    }
    
    .services-grid {
        grid-template-columns: 1fr;  /* Single column on mobile */
        gap: 20px;
    }
    
    .service-card {
        padding: 25px;              /* Less padding on mobile */
    }
}
```

**Key learnings:**
✅ Used `box-sizing: border-box` globally  
✅ Applied padding for internal spacing (cards, buttons, header)  
✅ Applied margin for external spacing (elements separation, centering)  
✅ Used border for visual definition  
✅ Used border-radius for modern rounded corners  
✅ Understood how all box model properties work together

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Box Model Complete Reference

### Four Layers (Inside → Outside)

```
┌────────────────────────────────────┐
│          MARGIN                    │  ← Space outside (transparent)
│  ┌──────────────────────────────┐  │
│  │       BORDER                 │  │  ← Visible line
│  │  ┌────────────────────────┐  │  │
│  │  │     PADDING            │  │  │  ← Space inside (has background)
│  │  │  ┌──────────────────┐  │  │  │
│  │  │  │    CONTENT       │  │  │  │  ← Text, images
│  │  │  └──────────────────┘  │  │  │
│  │  └────────────────────────┘  │  │
│  └──────────────────────────────┘  │
└────────────────────────────────────┘
```

---

## Padding Properties

```css
/* Individual sides */
padding-top: 10px;
padding-right: 20px;
padding-bottom: 10px;
padding-left: 20px;

/* Shorthand: All sides */
padding: 20px;  /* 20px on all sides */

/* Shorthand: Vertical | Horizontal */
padding: 10px 20px;  /* 10px top/bottom, 20px left/right */

/* Shorthand: Top | Horizontal | Bottom */
padding: 10px 20px 15px;  /* 10px top, 20px left/right, 15px bottom */

/* Shorthand: Top | Right | Bottom | Left (clockwise) */
padding: 10px 20px 15px 5px;  /* TRouBLe mnemonic */
```

**When to use padding:**
- Create breathing room between content and border
- Increase clickable area of buttons/links
- Separate text from container edges
- Background color/image extends into padding area

---

## Margin Properties

```css
/* Individual sides */
margin-top: 20px;
margin-right: 10px;
margin-bottom: 20px;
margin-left: 10px;

/* Shorthand (same pattern as padding) */
margin: 20px;               /* All sides */
margin: 20px 10px;          /* Vertical | Horizontal */
margin: 20px 10px 15px;     /* Top | Horizontal | Bottom */
margin: 20px 10px 15px 5px; /* Top | Right | Bottom | Left */

/* Centering */
margin: 0 auto;  /* 0 top/bottom, auto left/right = centered */

/* Negative margins (pull elements closer) */
margin-top: -20px;  /* Pulls element up by 20px */
```

**When to use margin:**
- Create space between elements
- Separate sections of a page
- Center elements horizontally
- Margin is transparent (no background)

**Margin Collapse:**
Vertical margins between elements merge (collapse) to the larger value:
```css
.box1 { margin-bottom: 20px; }
.box2 { margin-top: 30px; }
/* Gap between boxes = 30px (not 50px!) */
```

---

## Border Properties

```css
/* Individual properties */
border-width: 2px;
border-style: solid;
border-color: #1a73e8;

/* Shorthand */
border: 2px solid #1a73e8;  /* width style color */

/* Individual sides */
border-top: 1px solid #ddd;
border-right: none;
border-bottom: 2px solid #1a73e8;
border-left: 5px solid #ffc107;

/* Specific side properties */
border-left-width: 5px;
border-left-color: #f44336;
border-top-style: dashed;
```

**Border Styles:**
```css
border-style: solid;   /* ━━━━ */
border-style: dashed;  /* ─ ─ ─ ─ */
border-style: dotted;  /* · · · · */
border-style: double;  /* ════ */
border-style: groove;  /* 3D grooved */
border-style: ridge;   /* 3D ridged */
border-style: inset;   /* 3D inset */
border-style: outset;  /* 3D outset */
border-style: none;    /* No border */
```

**Border Radius (Rounded Corners):**
```css
/* All corners */
border-radius: 10px;

/* Individual corners */
border-top-left-radius: 10px;
border-top-right-radius: 10px;
border-bottom-right-radius: 0;
border-bottom-left-radius: 0;

/* Shorthand: top-left | top-right | bottom-right | bottom-left */
border-radius: 10px 10px 0 0;

/* Circle (when width = height) */
border-radius: 50%;
```

---

## Box-Sizing Property

### content-box (default)

Width/height apply ONLY to content. Padding and border are ADDED.

```css
.box {
    box-sizing: content-box;  /* Default */
    width: 300px;
    padding: 20px;
    border: 5px solid black;
}

/* Total width = 300 + 40 (padding) + 10 (border) = 350px */
```

### border-box (recommended)

Width/height INCLUDE padding and border.

```css
.box {
    box-sizing: border-box;
    width: 300px;
    padding: 20px;
    border: 5px solid black;
}

/* Total width = 300px (padding and border included) */
```

**Best Practice - Apply globally:**
```css
* {
    box-sizing: border-box;
}
```

This makes layout calculations predictable!

---

## Complete Box Model Example

```css
.card {
    /* Content size */
    width: 300px;
    height: 200px;
    
    /* Padding (inside, has background) */
    padding: 20px;
    
    /* Border */
    border: 2px solid #e0e0e0;
    border-radius: 10px;
    
    /* Margin (outside, transparent) */
    margin: 20px auto;  /* 20px top/bottom, centered */
    
    /* Box-sizing */
    box-sizing: border-box;  /* Width includes padding/border */
    
    /* Background */
    background-color: white;
}

/* With box-sizing: border-box */
/* Total width = 300px (predictable!) */
/* Content width = 300 - 40 (padding) - 4 (border) = 256px */
```

---

## Common Box Model Patterns

### Card Spacing
```css
.card {
    padding: 20px;         /* Space inside */
    margin: 15px;          /* Space outside */
    border: 1px solid #ddd;
    border-radius: 8px;
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

### Centered Container
```css
.container {
    max-width: 1200px;
    margin: 0 auto;        /* Centered */
    padding: 0 20px;       /* Gutter on sides */
}
```

### Left Accent Border
```css
.announcement {
    border-left: 5px solid #1a73e8;
    padding: 20px;
    margin-bottom: 15px;
}
```

---

## DevTools Box Model Inspection

**To visualize the box model:**
1. Right-click element → Inspect
2. Scroll down in Styles panel
3. See box model diagram:
   - **Blue** = Content
   - **Green** = Padding
   - **Orange** = Border
   - **Yellow** = Margin

**Click on values to edit live!**

---

## Best Practices

1. **Always use `box-sizing: border-box`**
   ```css
   * { box-sizing: border-box; }
   ```

2. **Reset default margins/padding**
   ```css
   * { margin: 0; padding: 0; }
   ```

3. **Use consistent spacing scale**
   ```css
   --spacing-xs: 5px;
   --spacing-sm: 10px;
   --spacing-md: 20px;
   --spacing-lg: 40px;
   --spacing-xl: 60px;
   ```

4. **Padding for internal, margin for external**

5. **Use margin auto for centering**

6. **Border-radius for modern designs**

---

## Common Mistakes

1. **Forgetting box-sizing**
   ```css
   /* Width will be 340px! */
   .box {
       width: 300px;
       padding: 20px;  /* Adds to width */
   }
   
   /* Fix */
   .box {
       box-sizing: border-box;
       width: 300px;  /* Total width stays 300px */
       padding: 20px;
   }
   ```

2. **Margin collapse**
   ```css
   .box1 { margin-bottom: 20px; }
   .box2 { margin-top: 30px; }
   /* Gap = 30px, not 50px */
   ```

3. **Using margin for internal spacing**
   ```css
   /* Wrong */
   .button {
       margin: 10px 20px;  /* Background doesn't extend */
   }
   
   /* Right */
   .button {
       padding: 10px 20px;  /* Creates clickable area */
   }
   ```

</details>

---

**Congratulations!** You've mastered the CSS Box Model! You now understand how padding, margin, border, and box-sizing work together to create professional, well-spaced layouts.

**Next Lesson:** Display Types - Controlling element layout behavior!

