## Background Story

Tian's first HTML file sat complete on their screen—a valid document with `<!DOCTYPE html>`, proper `<html>`, `<head>`, and `<body>` structure. It was technically correct. But inside the `<body>` tag was just one line:

```html
<body>
Welcome to Barangay Sto. Niño
</body>
```

Plain text. No formatting. No structure within the content itself. When Tian opened it in the browser, all the text appeared in a single line with default browser styling.

Tian wanted to add more—a heading, paragraphs explaining barangay services, maybe a list of contact information. But they didn't know *how* to tell the browser "this is a heading" or "this is a paragraph" or "this should be bold."

They tried adding line breaks in the code:

```html
<body>
Barangay Sto. Niño

Our Services:
Barangay Clearance
Barangay ID
Indigency Certificate
</body>
```

But when they refreshed the browser, everything still appeared in one continuous line. The line breaks in the code didn't translate to line breaks in the display.

"Why doesn't the browser respect line breaks?" Tian wondered, frustrated.

They remembered Kuya Miguel mentioning something about "semantic HTML" and "tags describing content types," but they hadn't fully understood what that meant. It was time to find out.

That evening's call with Miguel started with Tian sharing their screen.

"Kuya, I have the HTML structure down, but I can't format the actual content. I want headings, paragraphs, bold text, lists... how do I tell the browser what type of content each piece is?"

Miguel smiled. "You need HTML tags—specific instructions that wrap your content and give it meaning. Think of tags as containers. Each one has a specific purpose and tells the browser how to interpret what's inside."

"Can you give examples?"

"Of course. A `<p>` tag creates a paragraph. An `<h1>` tag creates a top-level heading. A `<strong>` tag makes text bold and important. An `<img>` tag displays an image. An `<a>` tag creates a link. There are dozens of tags, each with its own semantic meaning—not just how it looks, but what it *represents*."

Miguel continued, "What you need to understand is the anatomy of tags: opening tags, closing tags, self-closing tags, and attributes that modify behavior. Once you master tags, you can structure any type of content—articles, portfolios, forms, entire web applications."

---

## Theory & Lecture Content

## What Are HTML Tags?

**HTML Tag** = Instruction wrapped in angle brackets `< >`

**Anatomy of a tag:**
```html
<tagname>Content goes here</tagname>
  │         │                 │
  │         │                 └─ Closing tag
  │         └─────────────────── Content
  └───────────────────────────── Opening tag
```

**Example:**
```html
<p>This is a paragraph.</p>
<h1>This is a heading.</h1>
<strong>This is bold text.</strong>
```

### Opening and Closing Tags

**Most tags** have opening and closing pairs:
```html
<p>Paragraph text</p>
<h1>Heading text</h1>
<div>Division/container</div>
```

**Self-closing tags** (no content inside):
```html
<img src="photo.jpg" alt="Photo">
<br>
<hr>
<input type="text">
<meta charset="UTF-8">
```

## Elements vs Tags

**Tag** = The syntax itself (`<p>`, `</p>`)
**Element** = Complete structure (opening tag + content + closing tag)

```html
<p>This is a paragraph element.</p>
│  │                           │
│  └─ Content                  └─ Closing tag
└──── Opening tag

└──────── Complete ELEMENT ─────────┘
```

**Terminology:**
- "Use a `<p>` **tag** to create a paragraph."
- "This `<p>` **element** contains text."

## Common HTML Tags

### Text Content Tags

```html
<!-- Headings (largest to smallest) -->
<h1>Main Title</h1>
<h2>Section Title</h2>
<h3>Sub-section</h3>
<h4>Minor heading</h4>
<h5>Smaller heading</h5>
<h6>Smallest heading</h6>

<!-- Paragraphs -->
<p>This is a paragraph of text.</p>

<!-- Line break (self-closing) -->
<p>First line<br>Second line</p>

<!-- Horizontal rule (self-closing) -->
<hr>

<!-- Preformatted text (preserves spaces/line breaks) -->
<pre>
Code or
  formatted
    text
</pre>
```

### Text Formatting Tags

```html
<!-- Bold/Strong -->
<strong>Important text</strong>
<b>Bold text (visual only)</b>

<!-- Italic/Emphasis -->
<em>Emphasized text</em>
<i>Italic text (visual only)</i>

<!-- Underline -->
<u>Underlined text</u>

<!-- Strikethrough -->
<s>Deleted text</s>
<del>Removed content</del>

<!-- Small text -->
<small>Fine print</small>

<!-- Mark/Highlight -->
<mark>Highlighted text</mark>

<!-- Subscript and Superscript -->
H<sub>2</sub>O (water)
E=mc<sup>2</sup> (Einstein)
```

### Container Tags

```html
<!-- Generic block container -->
<div>
  Content grouped together
</div>

<!-- Generic inline container -->
<span>Inline text</span>
```

## Attributes

**Attributes** = Extra information added to tags

**Syntax:**
```html
<tagname attribute="value">Content</tagname>
          │          │
          │          └─ Value (in quotes)
          └──────────── Attribute name
```

**Examples:**
```html
<img src="photo.jpg" alt="My photo">
     │              │
     │              └─ alt attribute (alternate text)
     └──────────────── src attribute (image source)

<a href="https://google.com" target="_blank">Google</a>
   │                        │
   │                        └─ target attribute
   └───────────────────────── href attribute (link destination)

<p id="intro" class="highlight">Text</p>
   │         │
   │         └─ class attribute (CSS styling)
   └─────────── id attribute (unique identifier)
```

### Common Attributes

#### Global Attributes (work on any tag)

```html
<!-- id: Unique identifier -->
<div id="header">Header content</div>

<!-- class: CSS styling (can be reused) -->
<p class="highlight">Important text</p>
<p class="highlight">Another important text</p>

<!-- style: Inline CSS -->
<p style="color: red; font-size: 20px;">Red text</p>

<!-- title: Tooltip on hover -->
<p title="This appears on hover">Hover over me</p>

<!-- hidden: Hide element -->
<p hidden>This is hidden</p>

<!-- lang: Language -->
<p lang="tl">Kumusta ka?</p>
```

#### Tag-Specific Attributes

```html
<!-- <img> attributes -->
<img src="photo.jpg" alt="Description" width="300" height="200">

<!-- <a> attributes -->
<a href="page.html" target="_blank" title="Opens in new tab">Link</a>

<!-- <input> attributes -->
<input type="text" placeholder="Enter name" required maxlength="50">
```

## Nesting Elements

**Nesting** = Placing elements inside other elements

**Correct nesting:**
```html
<div>
  <h1>Title</h1>
  <p>This is a <strong>bold word</strong> in a paragraph.</p>
</div>
```

**WRONG nesting (overlapping tags):**
```html
<p>This is <strong>bold and italic</em></strong></p>
<!-- WRONG: <em> closes before <strong> -->
```

**CORRECT:**
```html
<p>This is <strong><em>bold and italic</em></strong></p>
```

**Rule:** Last opened, first closed (like nested boxes).

## Filipino Context Example

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Officials</title>
</head>
<body>
    <!-- Main heading -->
    <h1>Barangay Sto. Niño Officials</h1>
    
    <!-- Captain info -->
    <h2>Barangay Captain</h2>
    <p>
        <strong>Hon. Maria Santos</strong><br>
        Term: <em>2022-2025</em><br>
        Contact: <a href="tel:+639171234567">0917-123-4567</a>
    </p>
    
    <hr>
    
    <!-- Kagawad list -->
    <h2>Kagawad Members</h2>
    <p>
        1. <span class="kagawad">Juan Dela Cruz</span> - Health Committee<br>
        2. <span class="kagawad">Ana Reyes</span> - Education Committee<br>
        3. <span class="kagawad">Pedro Garcia</span> - Peace and Order
    </p>
    
    <!-- Office hours -->
    <h3>Office Hours</h3>
    <p title="Monday to Friday">
        <mark>8:00 AM - 5:00 PM</mark> (Weekdays only)
    </p>
</body>
</html>
```

## Block vs Inline Elements

### Block-Level Elements

**Behavior:** Takes full width, starts on new line

```html
<div>Block element 1</div>
<div>Block element 2</div>
<p>Paragraph (block)</p>
<h1>Heading (block)</h1>
```

**Result:** Each on separate line (stacked vertically)

**Common block elements:** `<div>`, `<p>`, `<h1>`-`<h6>`, `<ul>`, `<ol>`, `<li>`, `<header>`, `<footer>`, `<section>`

### Inline Elements

**Behavior:** Takes only necessary width, stays on same line

```html
<span>Inline 1</span> <span>Inline 2</span> <strong>Bold</strong>
```

**Result:** All on same line (flows like text)

**Common inline elements:** `<span>`, `<a>`, `<strong>`, `<em>`, `<img>`, `<br>`, `<input>`

### Mixing Block and Inline

```html
<p>
    This is a paragraph (block) with <strong>bold text</strong> (inline)
    and a <a href="#">link</a> (inline) inside.
</p>
```

## Semantic vs Non-Semantic Tags

### Semantic Tags (meaningful)

```html
<article>Article content</article>  <!-- Clearly means "article" -->
<nav>Navigation menu</nav>          <!-- Clearly means "navigation" -->
<header>Page header</header>        <!-- Clearly means "header" -->
```

### Non-Semantic Tags (generic)

```html
<div>Generic container</div>        <!-- No specific meaning -->
<span>Generic inline</span>         <!-- No specific meaning -->
```

**Why semantic matters:**
- **SEO:** Google understands content better
- **Accessibility:** Screen readers for blind users
- **Maintainability:** Easier for developers to read

## Common Mistakes

### ❌ Forgetting Closing Tags
```html
<p>Paragraph 1
<p>Paragraph 2
<!-- WRONG: Missing </p> -->
```
✅ **Correct:**
```html
<p>Paragraph 1</p>
<p>Paragraph 2</p>
```

### ❌ Attribute Quotes
```html
<img src=photo.jpg>  <!-- WRONG: No quotes -->
```
✅ **Correct:**
```html
<img src="photo.jpg">
```

### ❌ Wrong Nesting
```html
<p><div>Text</div></p>  <!-- WRONG: Block inside inline parent -->
```
✅ **Correct:**
```html
<div><p>Text</p></div>
```

## Best Practices

1. **Close all tags** (except self-closing)
2. **Use lowercase** for tag names (`<div>` not `<DIV>`)
3. **Quote attribute values** (`src="image.jpg"` not `src=image.jpg`)
4. **Proper nesting** (last opened, first closed)
5. **Semantic tags** when possible (not just `<div>` everywhere)
6. **Meaningful IDs/classes** (`class="nav-button"` not `class="x1"`)

## Summary

- **Tags** = Syntax (`<p>`, `</p>`)
- **Elements** = Complete structure (tag + content + closing tag)
- **Attributes** = Extra info in opening tag (`id`, `class`, `src`, `href`)
- **Block** = Full width, new line (`<div>`, `<p>`, `<h1>`)
- **Inline** = Flows with text (`<span>`, `<strong>`, `<a>`)
- **Semantic** = Meaningful tags (`<article>`, `<nav>`)

**Next lesson:** Text Formatting (Headings, Paragraphs, Lists)

---

## Closing Story

Tian added a paragraph, a link, and an image to the barangay website. Three different tags. Three different purposes. All working together.

Kuya Miguel reviewed the code over screen share. "Good use of attributes. Semantic tag names. Alt text for accessibility. You're thinking like a professional already."

"I just followed the patterns you showed me," Tian said humbly.

"That's exactly what professionals do. We don't memorize every tag. We understand the pattern: opening tag, attributes, content, closing tag. Once you understand the pattern, you can use any tag."

Tian refreshed the browser. The image loaded. The link worked. The heading stood bold. It wasn't fancy, but it was functional. And function was the first step toward beauty.

_Next up: Text Formattingmaking content readable!_