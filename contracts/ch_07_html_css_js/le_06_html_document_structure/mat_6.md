# Lesson 6: Structure of an HTML Document

## Background Story

After learning how websites work, Tian was excited to actually **build** one. Kuya Miguel said, "Let's start with the foundation—HTML. Think of it as the blueprint of a bahay kubo."

Tian asked, "What's HTML?"

"HTML stands for **HyperText Markup Language**. It's not a programming language—it's a markup language that structures content on the web. Every website you visit—Facebook, YouTube, Shopee—all start with HTML."

## What is HTML?

**HTML (HyperText Markup Language)** is the skeleton of every webpage. It defines the structure and content:

- **HyperText** = Links connecting pages
- **Markup** = Tags that describe content
- **Language** = Standardized syntax browsers understand

**Analogy:** If a house is a website:
- **HTML** = Structure (walls, rooms, doors)
- **CSS** = Design (paint, furniture, decoration)
- **JavaScript** = Functionality (electricity, plumbing, security)

## Anatomy of an HTML Document

### The Basic Structure

Every HTML document follows this template:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tian's First Webpage</title>
</head>
<body>
    <h1>Welcome to my website!</h1>
    <p>This is my first HTML page.</p>
</body>
</html>
```

### Breaking It Down

#### 1. `<!DOCTYPE html>`

**Purpose:** Tells the browser "This is an HTML5 document."

- **Always** the first line
- Not case-sensitive (but convention: uppercase)
- No closing tag needed

**Why needed?** Without it, browsers enter "quirks mode" (outdated rendering).

#### 2. `<html lang="en">`

**Purpose:** Root element wrapping entire document.

- `lang="en"` = Language attribute (English)
- For Philippines, you might use `lang="en-PH"` or `lang="tl"` (Tagalog)
- Helps screen readers and search engines

**Closing tag:** `</html>` at the end of document.

#### 3. `<head>` Section

**Purpose:** Contains metadata (information **about** the page, not shown on page).

Common elements inside `<head>`:

```html
<head>
    <!-- Character encoding: supports Filipino characters like ñ, á -->
    <meta charset="UTF-8">
    
    <!-- Responsive design (mobile-friendly) -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Page title (shows in browser tab) -->
    <title>Tian's Barangay Portal</title>
    
    <!-- SEO: Description for Google search results -->
    <meta name="description" content="Community portal for Barangay Sto. Niño">
    
    <!-- Link to CSS file -->
    <link rel="stylesheet" href="style.css">
    
    <!-- Favicon (icon in browser tab) -->
    <link rel="icon" href="logo.png">
</head>
```

**Key `<meta>` tags:**

- `charset="UTF-8"`: Supports international characters (including ñ, é, ü)
- `viewport`: Essential for mobile responsiveness
- `description`: What Google shows in search results
- `keywords`: (Deprecated but still used) SEO keywords

#### 4. `<body>` Section

**Purpose:** Contains all visible content (text, images, videos, links).

Everything users see is inside `<body>`:

```html
<body>
    <h1>Welcome!</h1>
    <p>This is a paragraph.</p>
    <img src="photo.jpg" alt="My photo">
    <a href="about.html">About Me</a>
</body>
```

## Creating Your First HTML File

### Step 1: Create the File

1. Open **VS Code** (or any text editor)
2. Create new file: `index.html`
3. Type the basic HTML template
4. Save file

**Why `index.html`?** Default filename for homepage. When you visit `www.example.com`, the browser automatically loads `index.html`.

### Step 2: Open in Browser

- **Windows:** Right-click file → Open with → Chrome/Edge/Firefox
- **Or:** Drag file into browser window
- **VS Code:** Install "Live Server" extension → Right-click → Open with Live Server

### Step 3: View Source Code

- **Chrome/Edge:** Press `Ctrl+U` (Windows) or `Cmd+Option+U` (Mac)
- **Or:** Right-click page → View Page Source

This shows the raw HTML code of any website!

## Common HTML Document Patterns

### Filipino Context Example

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Sto. Niño Portal</title>
    <meta name="description" content="Official website of Barangay Sto. Niño, Batangas">
</head>
<body>
    <h1>Mabuhay! Welcome to Barangay Sto. Niño</h1>
    <p>Population: 5,432 residents</p>
    <p>Barangay Captain: Hon. Maria Santos</p>
</body>
</html>
```

## HTML Comments

Comments are notes for developers (invisible to users):

```html
<!-- This is a comment -->
<!-- Comments help you remember what code does -->

<!-- Header Section -->
<header>
    <h1>My Website</h1>
</header>

<!-- 
    Multi-line comment
    You can write multiple lines
    Very useful for documentation
-->
```

**When to use comments:**
- Explain complex sections
- Temporarily disable code (without deleting)
- Leave notes for teammates

## Indentation and Code Style

**Bad (hard to read):**
```html
<html><head><title>Title</title></head><body><h1>Hello</h1><p>Text</p></body></html>
```

**Good (proper indentation):**
```html
<html>
  <head>
    <title>Title</title>
  </head>
  <body>
    <h1>Hello</h1>
    <p>Text</p>
  </body>
</html>
```

**Indentation rules:**
- 2 spaces or 4 spaces (be consistent)
- Child elements indented inside parent
- Makes code readable for you and teammates

## Validation and Best Practices

### HTML Validator

Check if your HTML is correct:
- Website: `validator.w3.org`
- Paste your code or enter URL
- Shows errors and warnings

### Best Practices

1. **Always include `<!DOCTYPE html>`**
2. **Use `lang` attribute** in `<html>`
3. **Include `charset` and `viewport`** meta tags
4. **Meaningful `<title>`** (max 60 characters for SEO)
5. **Proper indentation** (2 or 4 spaces)
6. **Close all tags** (except self-closing like `<meta>`)
7. **Use lowercase** for tag names (convention)
8. **Add comments** for complex sections

## Common Mistakes

### ❌ Missing DOCTYPE
```html
<html> <!-- WRONG: No DOCTYPE -->
```
✅ **Correct:**
```html
<!DOCTYPE html>
<html>
```

### ❌ Content Outside `<body>`
```html
<html>
  <h1>Title</h1> <!-- WRONG: Should be in <body> -->
  <body></body>
</html>
```
✅ **Correct:**
```html
<html>
  <body>
    <h1>Title</h1>
  </body>
</html>
```

### ❌ Forgetting to Close Tags
```html
<body>
  <h1>Title
  <p>Paragraph
<!-- WRONG: Tags not closed -->
```
✅ **Correct:**
```html
<body>
  <h1>Title</h1>
  <p>Paragraph</p>
</body>
```

## Real-World Example: School Website

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Batangas National High School</title>
    <meta name="description" content="Official website of BNHS">
</head>
<body>
    <!-- Header Section -->
    <h1>Batangas National High School</h1>
    <p>Founded: 1952</p>
    
    <!-- Main Content -->
    <h2>About Us</h2>
    <p>We are a public high school serving 2,500 students in Batangas City.</p>
    
    <!-- Contact Information -->
    <h2>Contact</h2>
    <p>Address: P. Burgos St., Batangas City</p>
    <p>Phone: (043) 123-4567</p>
</body>
</html>
```

## Summary

HTML document structure:
1. **`<!DOCTYPE html>`** - HTML5 declaration
2. **`<html>`** - Root element
3. **`<head>`** - Metadata (not visible)
4. **`<body>`** - Visible content

Every webpage follows this template. Master this foundation, and you're ready to build content!

**Next lesson:** Tags, Elements, and Attributes—the building blocks of HTML.