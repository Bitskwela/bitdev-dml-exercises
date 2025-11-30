## Background Story

Tian clicked "Open in Browser" and waited as Chrome loaded their first HTML website—a simple page for Barangay Sto. Niño. The page appeared instantly. All the content was there: headings, paragraphs, lists of services, contact information, properly structured with semantic HTML. It was valid. It was accessible. It was functional.

It was also, Tian had to admit, painfully boring.

Black text on a white background. Times New Roman font. No spacing, no colors, no visual hierarchy beyond the browser's default styling. It looked like a document from 1995, the early web era before design became a priority.

Tian took a screenshot and sent it to the group chat with Rhea Joy and two other classmates working on the barangay website project.

**Tian:** *First draft of the barangay homepage. All the content is there. Thoughts?*

The reply came within seconds.

**Rhea Joy:** *Functional but... Tian, it looks like a Word document 😅*

**Marco:** *Did you forget to add the design?*

**Jenna:** *It works, but no one will want to use it. Sorry to be harsh.*

Tian stared at the screen, feeling a mix of defensiveness and resignation. They'd worked hard on the HTML structure—proper semantic tags, valid markup, organized sections. But the others were right. Functionality without aesthetics was like a house with no paint, no furniture, no personality. It technically provided shelter, but no one would want to live there.

The next day at school, Rhea Joy pulled Tian aside during lunch.

"Hey, don't feel bad about yesterday's comments. Your HTML structure is actually really good—I looked at the code. You used semantic tags correctly, everything is organized. But Tian, websites in 2024 need to look good. Users expect visual appeal, smooth layouts, intuitive design. That's where CSS comes in."

"CSS?" Tian asked.

"Cascading Style Sheets. It's the language that makes websites beautiful. Colors, fonts, spacing, layouts, responsive design—everything visual is CSS." Rhea Joy pulled out her phone and opened Behance, a portfolio site for designers. "Look at these websites. All of them are HTML for structure, but CSS is what makes them *stunning*."

Tian scrolled through the portfolio pieces—websites with elegant color schemes, creative layouts, smooth hover effects, perfect spacing. Each one felt like a work of art.

"I want our barangay website to look like this," Tian said. "But I have no idea where to start. I'm a structure and logic person, not a designer."

"Then let me teach you," Rhea Joy offered. "I've been learning CSS for a few months. It's easier than you think. You don't have to become a designer—you just need to understand how CSS works, how to link it to HTML, and how to apply basic styling. I'll help with the advanced design stuff."

That evening, Tian told Kuya Miguel about the situation.

"So Rhea Joy is right," Miguel confirmed. "HTML without CSS is like building a house and leaving it unpainted with bare concrete walls. Functional, but not inviting. CSS is how you transform structure into experience."

"Can you teach me the basics?" Tian asked. "I don't need to be a designer, but I need to understand how to style pages, link CSS files, and make things look... not like a 1995 Geocities site."

Miguel laughed. "Absolutely. Let me introduce you to CSS—how to write it, how to link it, and why it's called 'cascading.' By the end of today, your barangay website will actually look like a modern website."

---

## Theory & Lecture Content

## What is CSS?

**CSS (Cascading Style Sheets)** = Language for styling HTML elements

**Purpose:**
- Colors, fonts, spacing
- Layouts, positioning
- Responsive design
- Animations, transitions

**Analogy:**
- **HTML** = House structure (walls, doors, windows)
- **CSS** = House design (paint, furniture, decoration)
- **JavaScript** = House functionality (lights, appliances)

## CSS Syntax

```css
selector {
    property: value;
    property: value;
}
```

**Example:**
```css
h1 {
    color: blue;
    font-size: 32px;
    text-align: center;
}
```

**Parts:**
- **Selector:** Which element to style (`h1`)
- **Property:** What aspect to change (`color`, `font-size`)
- **Value:** How to change it (`blue`, `32px`)
- **Declaration:** Property + value pair
- **Declaration block:** All declarations inside `{ }`

## Three Ways to Add CSS

### 1. Inline CSS (Inside HTML tag)

```html
<p style="color: red; font-size: 20px;">Red text</p>
```

**Pros:** Quick, specific
**Cons:** Not reusable, hard to maintain, mixes HTML/CSS

**Use case:** Rare (emergency fixes, email HTML)

### 2. Internal CSS (Inside `<style>` tag)

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        h1 {
            color: blue;
        }
        p {
            font-size: 16px;
        }
    </style>
</head>
<body>
    <h1>Blue Title</h1>
    <p>Regular paragraph</p>
</body>
</html>
```

**Pros:** Styles in one place, affects whole page
**Cons:** Only for current page, not reusable across site

**Use case:** Single-page sites, quick prototypes

### 3. External CSS (Separate file) ✅ BEST PRACTICE

**style.css:**
```css
h1 {
    color: blue;
}
p {
    font-size: 16px;
}
```

**index.html:**
```html
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Blue Title</h1>
    <p>Regular paragraph</p>
</body>
</html>
```

**Pros:** 
- Reusable across multiple pages
- Separation of concerns (HTML = structure, CSS = style)
- Easier maintenance
- Browser caching (faster loading)

**Cons:** Extra HTTP request (minor)

## Linking External CSS

### Basic Link

```html
<head>
    <link rel="stylesheet" href="style.css">
</head>
```

**Attributes:**
- `rel="stylesheet"` = Relationship (this is a stylesheet)
- `href="style.css"` = Path to CSS file

### Multiple CSS Files

```html
<head>
    <link rel="stylesheet" href="reset.css">    <!-- First -->
    <link rel="stylesheet" href="main.css">     <!-- Then this -->
    <link rel="stylesheet" href="custom.css">  <!-- Last (highest priority) -->
</head>
```

**Order matters:** Later styles override earlier ones.

### CSS in Subfolders

```html
<!-- CSS in same folder -->
<link rel="stylesheet" href="style.css">

<!-- CSS in subfolder -->
<link rel="stylesheet" href="css/style.css">

<!-- CSS in parent folder -->
<link rel="stylesheet" href="../style.css">
```

## Filipino Example: Barangay Website

**index.html:**
```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Sto. Niño</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Barangay Sto. Niño</h1>
        <p>Serving the community since 1952</p>
    </header>
    
    <nav>
        <a href="#">Home</a>
        <a href="#">Services</a>
        <a href="#">Contact</a>
    </nav>
    
    <main>
        <h2>Welcome</h2>
        <p>Your trusted partner in community development.</p>
    </main>
</body>
</html>
```

**style.css:**
```css
/* Header styling */
header {
    background-color: #2c3e50;
    color: white;
    padding: 20px;
    text-align: center;
}

/* Navigation */
nav {
    background-color: #3498db;
    padding: 10px;
}

nav a {
    color: white;
    text-decoration: none;
    margin: 0 15px;
}

/* Main content */
main {
    padding: 20px;
    font-family: Arial, sans-serif;
}

h2 {
    color: #2980b9;
}
```

## CSS Comments

```css
/* This is a single-line comment */

/*
   Multi-line comment
   Can span
   Multiple lines
*/

h1 {
    color: blue;  /* Inline comment */
}
```

## Why "Cascading"?

**Cascade** = Styles flow down and can be overridden

**Priority order (low to high):**
1. Browser defaults
2. External CSS
3. Internal CSS (`<style>`)
4. Inline CSS (`style=""`)
5. `!important` flag (avoid unless necessary)

**Example:**
```html
<head>
    <!-- External (blue) -->
    <link rel="stylesheet" href="style.css">  
    
    <!-- Internal (red) - overrides external -->
    <style>
        h1 { color: red; }
    </style>
</head>
<body>
    <!-- Inline (green) - overrides internal -->
    <h1 style="color: green;">Green Title</h1>
</body>
```

Result: Green (inline wins)

## CSS Reset

Browsers have default styles (margins, padding, font sizes). **CSS Reset** removes these for consistent starting point.

```css
/* Simple reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
```

Popular resets:
- **Normalize.css** (standardizes across browsers)
- **Eric Meyer's Reset** (removes all defaults)

## Best Practices

1. **Use external CSS** (separate files)
2. **Organize by sections** (header, nav, main, footer)
3. **Add comments** for complex sections
4. **Consistent naming** (lowercase, hyphens: `nav-button`)
5. **Group related rules**
6. **One rule per line** (readability)

**Good CSS structure:**
```css
/* ========== Reset ========== */
* { margin: 0; padding: 0; }

/* ========== Global ========== */
body { font-family: Arial; }

/* ========== Header ========== */
header { background: #333; }

/* ========== Navigation ========== */
nav { padding: 10px; }

/* ========== Main Content ========== */
main { max-width: 1200px; }

/* ========== Footer ========== */
footer { text-align: center; }
```

## Common Mistakes

### ❌ Wrong `href` path
```html
<link rel="stylesheet" href="Style.css">  <!-- Case-sensitive on servers -->
<link rel="stylesheet" href="style.css">  <!-- Correct -->
```

### ❌ Missing `rel` attribute
```html
<link href="style.css">  <!-- WRONG: No rel -->
<link rel="stylesheet" href="style.css">  <!-- Correct -->
```

### ❌ CSS in `<body>` instead of `<head>`
```html
<body>
    <link rel="stylesheet" href="style.css">  <!-- WRONG -->
</body>
```

### ❌ Forgetting semicolons
```css
h1 {
    color: blue
    font-size: 32px  /* Missing semicolons */
}
```
✅ **Correct:**
```css
h1 {
    color: blue;
    font-size: 32px;
}
```

## Developer Tools: Inspecting CSS

**Chrome/Edge DevTools:**
1. Right-click element → "Inspect"
2. See applied CSS in "Styles" panel
3. Edit live (changes temporary)
4. See which file/line CSS comes from

**Shortcut:** `F12` or `Ctrl+Shift+I` (Windows), `Cmd+Option+I` (Mac)

## Summary

- **CSS** = Cascading Style Sheets (styling language)
- **Three methods:** Inline (avoid), Internal (single page), External (best)
- **Link syntax:** `<link rel="stylesheet" href="style.css">`
- **Cascade:** Styles override based on specificity and order
- **Best practice:** External CSS, organized, commented

**Next lesson:** Selectors, Properties, and Values

---

## Closing Story

Tian linked the first CSS file to the HTML. Refreshed the browser. The page transformed. Color. Fonts. Spacing. Magic.

"This is the fun part," Kuya Miguel laughed. "HTML is structure. CSS is art."

Tian experimented with different colors for the header. Blue. Red. Green. Settled on a deep maroonthe color of the Philippine flag. The barangay portal was no longer just functional. It was starting to look professional.

_Next up: Selectors, Properties, and ValuesCSS fundamentals!_