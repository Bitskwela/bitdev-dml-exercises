# Semantic HTML Quiz

---

# Quiz 1

## Quiz: Semantic vs Non-Semantic

**Scenario:**

Tian refactors code using semantic tags:

**Before (Non-semantic):**
```html
<div id="header">
    <div id="nav">
        <a href="#">Home</a>
    </div>
</div>
<div id="content">
    <div class="post">
        <h2>Title</h2>
        <p>Content</p>
    </div>
</div>
<div id="sidebar">Widget</div>
<div id="footer">Copyright</div>
```

**After (Semantic):**
```html
<header>
    <nav>
        <a href="#">Home</a>
    </nav>
</header>
<main>
    <article>
        <h2>Title</h2>
        <p>Content</p>
    </article>
</main>
<aside>Widget</aside>
<footer>Copyright</footer>
```

**Question 1:** What's the main benefit of semantic HTML?

- A) Faster page load
- B) Better SEO, accessibility, code readability
- C) Smaller file size
- D) No benefit

**Answer: B**

Semantic HTML improves: 1) SEO (search engines understand content structure), 2) Accessibility (screen readers navigate by landmarks), 3) Code readability (clear meaning).

**Question 2:** How many `<main>` tags should a page have?

- A) As many as needed
- B) Only one
- C) At least two
- D) None

**Answer: B**

A page should have only one `<main>` tag that identifies the primary content. Multiple `<main>` tags confuse screen readers and search engines.

---

# Quiz 2

**Question 3:** What's the difference between `<article>` and `<section>`?

- A) No difference
- B) `<article>` = standalone content, `<section>` = thematic grouping
- C) `<article>` for images only
- D) `<section>` for tables only

**Answer: B**

`<article>` is for standalone, reusable content (blog posts, news articles). `<section>` is for thematic grouping of related content within a page.

**Question 4:** Which is more semantic?

- A) `<div class="header">`
- B) `<header>`
- C) Both same
- D) `<div>` better

**Answer: B**

`<header>` is semantic and clearly identifies the header section. `<div class="header">` requires interpretation and doesn't convey meaning to search engines or screen readers.

**Question 5:** What should every `<section>` contain?

- A) Image
- B) Heading (h2-h6)
- C) Link
- D) Table

**Answer: B**

Every `<section>` should contain a heading (h2-h6) to describe the section's theme. This helps with document structure and accessibility.  

---

## Detailed Explanations

Q1 **Semantic HTML benefits:**

**1. SEO (Search Engine Optimization):**
- Google understands `<article>` = main content
- `<header>` = site branding
- `<nav>` = navigation menu
- Better ranking in search results

**2. Accessibility:**
- Screen readers navigate by landmarks
- "Jump to main content" = finds `<main>`
- "Navigation menu" = finds `<nav>`
- Critical for blind users

**3. Code Readability:**
```html
<!-- Clear meaning -->
<header>
    <nav>Menu</nav>
</header>

<!-- Unclear -->
<div id="top">
    <div class="menu">Menu</div>
</div>
```

Q2 **One `<main>` rule:**

**Correct:**
```html
<body>
    <header>Header</header>
    <main>Main content here</main>
    <footer>Footer</footer>
</body>
```

**Wrong (multiple `<main>`):**
```html
<main>Content 1</main>
<main>Content 2</main>  <!-- Invalid -->
```

`<main>` identifies primary content. Multiple confuses screen readers and search engines.

Q3 **`<article>` vs `<section>`:**

**`<article>` (standalone):**
- Blog post
- News article
- Forum post
- Comment
- Can be syndicated/shared independently

```html
<article>
    <h2>Breaking News</h2>
    <p>Content that makes sense alone...</p>
</article>
```

**`<section>` (thematic grouping):**
- Chapter of content
- Tab in tabbed interface
- Part of larger whole

```html
<section>
    <h2>Services</h2>
    <p>Part of overall page...</p>
</section>
<section>
    <h2>Contact</h2>
    <p>Another part...</p>
</section>
```

**Rule of thumb:** Can you remove it and it still makes sense? → `<article>`

Q4 **Semantic comparison:**

**Non-semantic:**
```html
<div class="header">  <!-- Generic, meaning from class name -->
<div id="nav">      <!-- Generic, meaning from id -->
```

**Semantic:**
```html
<header>  <!-- Self-descriptive -->
<nav>     <!-- Self-descriptive -->
```

**Why `<header>` better:**
- Browser knows it's a header (no CSS needed)
- Screen readers announce "Banner region"
- Search engines prioritize header content
- Future-proof (new devices understand)

Q5 **`<section>` heading requirement:**

**Correct:**
```html
<section>
    <h2>Section Title</h2>  <!-- Required -->
    <p>Content...</p>
</section>
```

**Wrong:**
```html
<section>
    <p>Content without heading</p>  <!-- Missing h2-h6 -->
</section>
```

Screen readers use headings to navigate. Section without heading is unclear.

**If no heading:** Use `<div>` instead of `<section>`.

---

**Key Concepts:**
- **Semantic = Meaningful:** `<header>`, `<nav>`, `<main>`, `<article>`, `<section>`, `<aside>`, `<footer>`
- **Benefits:** SEO, accessibility, readability
- **Rules:** One `<main>`, sections need headings
- **When:** Use semantic when tag fits meaning, `<div>` when generic

**Course 02 Complete!**  
**Next:** Course 03 (CSS Foundations).