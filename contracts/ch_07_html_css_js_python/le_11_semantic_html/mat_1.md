## Background Story

Tian's barangay website was functional. It had proper structure, formatted text, navigation links, and images. The HTML was valid according to the W3C validator. Everything worked.

But when Tian showed the code to Ms. Santos, their Computer Science teacher, she frowned while scrolling through the HTML.

"Tian, your website works, but your code is full of generic `<div>` tags. Look at this:"

```html
<div id="header">
  <div id="logo">...</div>
  <div id="navigation">...</div>
</div>
<div id="main-content">
  <div class="article">...</div>
  <div class="sidebar">...</div>
</div>
<div id="footer">...</div>
```

"Everything is a `<div>`. When I read this code, I can't immediately understand what each section does. I have to read the IDs and classes to figure out that this div is a header, that div is navigation, another div is an article. The tags themselves are meaningless."

Tian was confused. "But it works fine. And I used descriptive IDs and classes, so it's clear what each section does, right?"

"It's clear to you because you wrote it and named everything descriptively. But HTML5 introduced semantic tags specifically designed for common page structures. Instead of `<div id='header'>`, you should use `<header>`. Instead of `<div id='navigation'>`, use `<nav>`. Instead of `<div class='article'>`, use `<article>`."

"But why? What's the actual difference if it looks and works the same?"

Ms. Santos opened the Chrome DevTools and navigated to the Lighthouse audit tool. She ran an accessibility test on Tian's website. The results showed several warnings:

- "Document doesn't use semantic landmarks"
- "Navigation regions not properly identified"
- "Main content area not defined"
- "Accessibility score: 73/100"

"See these warnings? Screen readers used by visually impaired users rely on semantic landmarks to navigate. When everything is a generic `<div>`, screen readers can't distinguish between your header, navigation, main content, and footer. A blind user would have difficulty navigating your site."

Tian felt a wave of guilt. They'd been so focused on making the website *look* good, they hadn't considered accessibility.

Ms. Santos continued, "Also, search engines like Google use semantic HTML to better understand your content structure. When Google's crawler sees a `<header>` tag, it knows that's the site header. When it sees an `<article>` tag, it knows that's main content. When it sees a `<nav>` tag, it knows that's navigation. Generic `<div>` tags don't provide that information."

That evening, Tian researched semantic HTML and found that HTML5 had introduced dozens of meaningful tags designed to replace generic divs: `<header>`, `<nav>`, `<main>`, `<article>`, `<section>`, `<aside>`, `<footer>`, and more.

They called Kuya Miguel.

"Kuya, Ms. Santos criticized my code for using too many generic `<div>` tags. She said I should use semantic HTML—tags like `<header>`, `<nav>`, `<article>` that actually describe what the content is, not just generic containers. She showed me accessibility warnings and said it affects both screen readers and SEO. I thought I was doing well, but apparently I've been writing HTML the old way."

Miguel nodded. "Your teacher is absolutely right. Before HTML5, we had no choice—everything was divs and spans with classes and IDs. But HTML5 gave us semantic elements that make code more meaningful, more accessible, and more SEO-friendly. The structure becomes self-documenting. When another developer reads your code, they immediately understand what each section is without having to parse through class names."

"So I need to refactor my entire website?"

"Yes, but it's worth it. Today, I'll teach you all the major semantic HTML5 elements, when to use each one, and how to restructure your website from div-soup into meaningful, semantic markup. By the end of this lesson, your accessibility score will improve, your code will be cleaner, and you'll be writing modern, professional HTML."

---

## Theory & Lecture Content

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