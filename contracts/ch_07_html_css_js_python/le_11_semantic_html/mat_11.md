# Lesson 11: Semantic HTML

## Background Story

Tian's website worked, but Kuya Miguel said, "Your code uses too many `<div>` tags. Let's use **semantic HTML**—tags that describe their meaning, not just appearance. It helps search engines, screen readers, and other developers understand your content."

"What's the difference?" Tian asked.

"Instead of `<div id="header">`, use `<header>`. Instead of `<div class="nav">`, use `<nav>`. The tag name itself explains its purpose."

## What is Semantic HTML?

**Semantic** = Tags with meaning

**Non-semantic tags** (generic, no meaning):
```html
<div>Content</div>
<span>Text</span>
```

**Semantic tags** (meaningful, descriptive):
```html
<header>Page header</header>
<nav>Navigation menu</nav>
<article>Article content</article>
<footer>Page footer</footer>
```

### Why Semantic HTML Matters

1. **SEO:** Google understands content structure better
2. **Accessibility:** Screen readers navigate by semantic landmarks
3. **Maintainability:** Code is self-documenting (easier to read)
4. **Future-proof:** Better browser/device support

## Common Semantic Tags

### Document Structure

#### `<header>` - Page or Section Header

```html
<header>
    <img src="logo.png" alt="Barangay Logo">
    <h1>Barangay Sto. Niño</h1>
    <p>Official Website</p>
</header>
```

**Use for:** Logo, site title, main navigation

#### `<nav>` - Navigation Links

```html
<nav>
    <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="services.html">Services</a></li>
        <li><a href="contact.html">Contact</a></li>
    </ul>
</nav>
```

**Use for:** Main menu, breadcrumbs, pagination

#### `<main>` - Main Content

```html
<main>
    <h1>Welcome to our Website</h1>
    <p>Main page content goes here...</p>
</main>
```

**Rules:**
- Only **one** `<main>` per page
- Not inside `<header>`, `<footer>`, `<nav>`, `<aside>`, or `<article>`

#### `<article>` - Self-Contained Content

```html
<article>
    <h2>Barangay Assembly Announcement</h2>
    <p>Published: November 15, 2025</p>
    <p>The monthly barangay assembly will be held...</p>
</article>
```

**Use for:** Blog posts, news articles, forum posts, comments (can stand alone)

#### `<section>` - Thematic Grouping

```html
<section>
    <h2>Services Offered</h2>
    <p>We provide the following services...</p>
</section>

<section>
    <h2>Office Hours</h2>
    <p>Monday - Friday: 8 AM - 5 PM</p>
</section>
```

**Use for:** Chapters, tabs, themed content blocks

**Difference:** `<article>` = standalone, `<section>` = part of larger whole

#### `<aside>` - Sidebar Content

```html
<aside>
    <h3>Quick Links</h3>
    <ul>
        <li><a href="#">Facebook Page</a></li>
        <li><a href="#">Hotline</a></li>
    </ul>
</aside>
```

**Use for:** Sidebars, related links, ads, pull quotes

#### `<footer>` - Page or Section Footer

```html
<footer>
    <p>&copy; 2025 Barangay Sto. Niño. All rights reserved.</p>
    <p>Contact: (043) 123-4567</p>
</footer>
```

**Use for:** Copyright, contact info, site map, social links

### Content Semantic Tags

#### `<figure>` and `<figcaption>` - Images with Captions

```html
<figure>
    <img src="office.jpg" alt="Barangay Hall">
    <figcaption>Barangay Sto. Niño Hall (2024)</figcaption>
</figure>
```

#### `<time>` - Date/Time

```html
<p>Event Date: <time datetime="2025-12-25">December 25, 2025</time></p>
```

**`datetime` attribute:** Machine-readable format for browsers/search engines

#### `<mark>` - Highlighted Text

```html
<p>Office is <mark>closed</mark> on December 25.</p>
```

#### `<address>` - Contact Information

```html
<address>
    Barangay Hall, Sto. Niño<br>
    Batangas City, Philippines<br>
    Email: <a href="mailto:barangay@gov.ph">barangay@gov.ph</a>
</address>
```

## Semantic HTML5 Page Structure

### Non-Semantic (Old Way)

```html
<body>
    <div id="header">
        <div id="logo">Logo</div>
        <div id="nav">
            <a href="#">Home</a>
            <a href="#">About</a>
        </div>
    </div>
    
    <div id="content">
        <div class="post">
            <h2>Title</h2>
            <p>Content...</p>
        </div>
    </div>
    
    <div id="sidebar">
        <div class="widget">Widget</div>
    </div>
    
    <div id="footer">
        <p>Copyright 2025</p>
    </div>
</body>
```

### Semantic (Modern Way)

```html
<body>
    <header>
        <img src="logo.png" alt="Logo">
        <nav>
            <a href="#">Home</a>
            <a href="#">About</a>
        </nav>
    </header>
    
    <main>
        <article>
            <h2>Title</h2>
            <p>Content...</p>
        </article>
    </main>
    
    <aside>
        <section>Widget</section>
    </aside>
    
    <footer>
        <p>Copyright 2025</p>
    </footer>
</body>
```

## Complete Semantic Example: Barangay Website

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Sto. Niño</title>
</head>
<body>
    <!-- Page Header -->
    <header>
        <img src="logo.png" alt="Barangay Logo" width="100">
        <h1>Barangay Sto. Niño</h1>
        <p>Serving the community since 1952</p>
        
        <!-- Main Navigation -->
        <nav>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="officials.html">Officials</a></li>
                <li><a href="services.html">Services</a></li>
                <li><a href="news.html">News</a></li>
                <li><a href="contact.html">Contact</a></li>
            </ul>
        </nav>
    </header>
    
    <!-- Main Content -->
    <main>
        <!-- Hero Section -->
        <section>
            <h2>Welcome to Barangay Sto. Niño</h2>
            <p>Your trusted partner in community development.</p>
            <figure>
                <img src="barangay-hall.jpg" alt="Barangay Hall exterior">
                <figcaption>Barangay Hall - Open Monday to Friday</figcaption>
            </figure>
        </section>
        
        <!-- Services Section -->
        <section>
            <h2>Our Services</h2>
            <article>
                <h3>Barangay Clearance</h3>
                <p>Get your barangay clearance for employment, school, or loan applications.</p>
                <p>Fee: ₱50 | Processing: Same day</p>
            </article>
            
            <article>
                <h3>Cedula (Community Tax Certificate)</h3>
                <p>Required for various transactions.</p>
                <p>Fee: ₱5-100 (based on income)</p>
            </article>
        </section>
        
        <!-- News Section -->
        <section>
            <h2>Latest News</h2>
            <article>
                <header>
                    <h3>Monthly Barangay Assembly</h3>
                    <p>Published: <time datetime="2025-11-10">November 10, 2025</time></p>
                </header>
                <p>The monthly assembly will discuss budget allocations...</p>
                <a href="news-detail.html">Read more</a>
            </article>
        </section>
    </main>
    
    <!-- Sidebar -->
    <aside>
        <section>
            <h3>Quick Links</h3>
            <ul>
                <li><a href="https://facebook.com/barangay">Facebook Page</a></li>
                <li><a href="tel:+6343123456">Hotline: (043) 123-4567</a></li>
            </ul>
        </section>
        
        <section>
            <h3>Office Hours</h3>
            <p>Monday - Friday: 8:00 AM - 5:00 PM</p>
            <p>Saturday: 8:00 AM - 12:00 PM</p>
        </section>
    </aside>
    
    <!-- Page Footer -->
    <footer>
        <address>
            Barangay Hall, Sto. Niño<br>
            Batangas City, Philippines 4200<br>
            Email: <a href="mailto:barangay.stonino@gov.ph">barangay.stonino@gov.ph</a>
        </address>
        
        <p>&copy; 2025 Barangay Sto. Niño. All rights reserved.</p>
        
        <nav>
            <a href="privacy.html">Privacy Policy</a> |
            <a href="terms.html">Terms of Service</a>
        </nav>
    </footer>
</body>
</html>
```

## When to Use `<div>` and `<span>`

**Still use `<div>` and `<span>` when:**
- No semantic tag fits
- Purely for styling/layout
- Wrapper for CSS/JavaScript hooks

```html
<!-- Styling wrapper (no semantic meaning) -->
<div class="container">
    <section>
        <h2>Content</h2>
    </section>
</div>

<!-- Inline styling -->
<p>Text with <span class="highlight">highlighted</span> word.</p>
```

## Accessibility Benefits

Screen readers use semantic tags as landmarks:

```
User hears:
"Banner region" (<header>)
"Navigation region" (<nav>)
"Main region" (<main>)
"Complementary region" (<aside>)
"Content information region" (<footer>)
```

Users can jump directly to specific sections.

## SEO Benefits

Google's search algorithm:
```html
<!-- Better SEO -->
<article>
    <h1>Main Title</h1>  <!-- Google knows this is the main topic -->
    <p>Content...</p>
</article>

<!-- Worse SEO -->
<div>
    <div class="title">Main Title</div>  <!-- Google less certain -->
    <div>Content...</div>
</div>
```

## Best Practices

1. **Use semantic tags** when they fit (not just `<div>` everywhere)
2. **One `<main>` per page** (main content area)
3. **One `<h1>` per page** (usually in `<header>` or `<main>`)
4. **Nest properly:** `<article>` can contain `<section>`, not vice versa
5. **Don't overuse:** If no semantic tag fits, `<div>` is fine

## Common Mistakes

### ❌ Using `<section>` without heading
```html
<section>
    <p>Content with no heading</p>  <!-- Missing h2-h6 -->
</section>
```
✅ **Correct:**
```html
<section>
    <h2>Section Title</h2>
    <p>Content</p>
</section>
```

### ❌ Multiple `<main>` tags
```html
<main>Content 1</main>
<main>Content 2</main>  <!-- WRONG: Only one <main> -->
```

### ❌ `<header>`/`<footer>` inside `<main>`
```html
<main>
    <header>Page header</header>  <!-- WRONG: Should be outside -->
</main>
```

## Summary

**Semantic structure:**
- `<header>` = Page/section header
- `<nav>` = Navigation
- `<main>` = Main content (one per page)
- `<article>` = Self-contained content
- `<section>` = Thematic grouping
- `<aside>` = Sidebar/related content
- `<footer>` = Page/section footer

**Benefits:**
- Better SEO (Google understands structure)
- Accessibility (screen readers navigate landmarks)
- Maintainability (self-documenting code)

**Next:** Course 03 - CSS Foundations

---

## Closing Story

Tian refactored the entire barangay website using semantic HTML. `<header>`, `<nav>`, `<main>`, `<article>`, `<aside>`, `<footer>`. The structure was elegant now. Meaningful. Accessible.

"Look at your HTML," Kuya Miguel said proudly. "Even without CSS, I can understand the structure. That's semantic markup. That's professional code."

Tian validated the HTML using the W3C validator. Zero errors. Zero warnings. Green checkmark.

"Chapter complete," Kuya Miguel announced. "You've mastered HTML foundations. From document structure to semantic markup. You're ready for the next phase."

"What's next?" Tian asked.

"CSS," Miguel smiled. "Time to make it beautiful."

Tian looked at the plain black-and-white website. It worked. It was valid. It was semantic. But it was boring. Tomorrow, color. Tomorrow, style. Tomorrow, beauty.

_Next up: Chapter 3Kulay at Kultura: Styling the Bayan!_ 