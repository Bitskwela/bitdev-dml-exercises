# Lesson 8: Text Formatting - Headings, Paragraphs, Lists

## Background Story

Tian started building the barangay website content. Kuya Miguel said, "Now let's organize text properly. You need headings for titles, paragraphs for content, and lists for organized information. These are the foundation of readable web content."

"Like Microsoft Word?" Tian asked.

"Exactly! But in HTML, you use specific tags for each text type."

## Headings (`<h1>` to `<h6>`)

**Headings** = Titles and subtitles (6 levels)

```html
<h1>Main Title (Largest)</h1>
<h2>Major Section</h2>
<h3>Sub-section</h3>
<h4>Minor heading</h4>
<h5>Smaller heading</h5>
<h6>Smallest heading</h6>
```

### Visual Hierarchy

**Default sizes** (browser default, can be changed with CSS):
- `<h1>` = 32px (2em)
- `<h2>` = 24px (1.5em)
- `<h3>` = 18.72px (1.17em)
- `<h4>` = 16px (1em)
- `<h5>` = 13.28px (0.83em)
- `<h6>` = 10.72px (0.67em)

### Heading Best Practices

```html
<!-- CORRECT: One <h1> per page (main title) -->
<h1>Barangay Sto. Niño Website</h1>

<h2>About Us</h2>
<p>Content...</p>

<h2>Services</h2>
<h3>Barangay Clearance</h3>
<p>Details...</p>
<h3>Cedula</h3>
<p>Details...</p>

<h2>Contact</h2>
<p>Contact info...</p>
```

**❌ Common Mistakes:**
```html
<!-- WRONG: Skipping levels -->
<h1>Title</h1>
<h4>Should be h2</h4>  <!-- Don't skip h2, h3 -->

<!-- WRONG: Multiple h1 on one page -->
<h1>First title</h1>
<h1>Second title</h1>  <!-- Use h2 instead -->

<!-- WRONG: Using headings for styling -->
<h1>This shouldn't be h1 just because I want big text</h1>
```

### Why Heading Hierarchy Matters

1. **SEO:** Google uses headings to understand page structure
2. **Accessibility:** Screen readers navigate via headings
3. **Readability:** Clear structure helps users scan content

## Paragraphs (`<p>`)

**Paragraph tag** = Block of text

```html
<p>This is a paragraph. It automatically adds spacing above and below.</p>
<p>This is another paragraph. Each <p> tag starts on a new line.</p>
```

### Line Breaks vs Paragraphs

```html
<!-- Line break <br> (same paragraph) -->
<p>
    First line<br>
    Second line<br>
    Third line
</p>

<!-- Multiple paragraphs -->
<p>First paragraph</p>
<p>Second paragraph</p>
<p>Third paragraph</p>
```

**Difference:**
- `<br>` = Line break (no extra spacing)
- `<p>` = New paragraph (extra spacing above/below)

### Filipino Example

```html
<h1>Barangay Services</h1>

<h2>Barangay Clearance</h2>
<p>
    Kailangan ng barangay clearance para sa:<br>
    - Job application<br>
    - School enrollment<br>
    - Loan application
</p>

<h3>Requirements</h3>
<p>1 valid ID + ₱50 processing fee</p>

<h3>Processing Time</h3>
<p>Same day release (if complete requirements)</p>
```

## Lists

### Unordered List (`<ul>`) - Bullet Points

```html
<h2>Required Documents</h2>
<ul>
    <li>Valid ID</li>
    <li>Barangay clearance</li>
    <li>Birth certificate</li>
    <li>2x2 ID photo</li>
</ul>
```

**Output:**
- Valid ID
- Barangay clearance
- Birth certificate
- 2x2 ID photo

### Ordered List (`<ol>`) - Numbered List

```html
<h2>Application Steps</h2>
<ol>
    <li>Fill out form</li>
    <li>Submit requirements</li>
    <li>Pay processing fee</li>
    <li>Wait for approval</li>
    <li>Claim clearance</li>
</ol>
```

**Output:**
1. Fill out form
2. Submit requirements
3. Pay processing fee
4. Wait for approval
5. Claim clearance

### List Attributes

```html
<!-- Start from different number -->
<ol start="5">
    <li>Fifth item</li>
    <li>Sixth item</li>
</ol>

<!-- Reverse order -->
<ol reversed>
    <li>First (shows as 3)</li>
    <li>Second (shows as 2)</li>
    <li>Third (shows as 1)</li>
</ol>

<!-- Different bullet type (CSS better for this) -->
<ol type="A">
    <li>Item A</li>
    <li>Item B</li>
</ol>
<!-- type: 1 (numbers), A (uppercase), a (lowercase), I (Roman), i (roman) -->
```

### Nested Lists

```html
<h2>Barangay Officials</h2>
<ul>
    <li>Barangay Captain
        <ul>
            <li>Maria Santos</li>
        </ul>
    </li>
    <li>Kagawad Members
        <ol>
            <li>Juan Dela Cruz</li>
            <li>Ana Reyes</li>
            <li>Pedro Garcia</li>
        </ol>
    </li>
    <li>SK Chairman
        <ul>
            <li>Carlo Mendoza</li>
        </ul>
    </li>
</ul>
```

**Output:**
- Barangay Captain
  - Maria Santos
- Kagawad Members
  1. Juan Dela Cruz
  2. Ana Reyes
  3. Pedro Garcia
- SK Chairman
  - Carlo Mendoza

## Description Lists (`<dl>`)

For **term-definition** pairs:

```html
<h2>Barangay Fees</h2>
<dl>
    <dt>Barangay Clearance</dt>
    <dd>₱50 - Valid for 6 months</dd>
    
    <dt>Cedula</dt>
    <dd>₱5-100 - Based on income</dd>
    
    <dt>Business Permit</dt>
    <dd>₱500-2000 - Based on business type</dd>
</dl>
```

**Tags:**
- `<dl>` = Description List (wrapper)
- `<dt>` = Term (title)
- `<dd>` = Definition (description)

## Horizontal Rule (`<hr>`)

Visual separator (horizontal line):

```html
<h2>Section 1</h2>
<p>Content...</p>

<hr>

<h2>Section 2</h2>
<p>Content...</p>
```

## Preformatted Text (`<pre>`)

Preserves spaces and line breaks:

```html
<pre>
Barangay Office Hours:
Monday    - 8:00 AM - 5:00 PM
Tuesday   - 8:00 AM - 5:00 PM
Wednesday - 8:00 AM - 5:00 PM
</pre>
```

**Without `<pre>`:** Extra spaces collapse to one space.  
**With `<pre>`:** Exactly as typed (useful for code, ASCII art, formatted text).

## Real-World Example: Barangay Services Page

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Services</title>
</head>
<body>
    <h1>Barangay Sto. Niño Services</h1>
    
    <h2>1. Barangay Clearance</h2>
    <p>
        Required for job applications, school enrollment, and other transactions.
    </p>
    
    <h3>Requirements:</h3>
    <ul>
        <li>Valid ID (photocopy)</li>
        <li>Cedula (Community Tax Certificate)</li>
        <li>₱50 processing fee</li>
    </ul>
    
    <h3>Processing Time:</h3>
    <p>Same day release if documents are complete.</p>
    
    <hr>
    
    <h2>2. How to Apply</h2>
    <ol>
        <li>Visit barangay hall during office hours</li>
        <li>Get application form at window 1</li>
        <li>Fill out form completely</li>
        <li>Submit form + requirements at window 2</li>
        <li>Pay at cashier</li>
        <li>Claim clearance (15-30 minutes)</li>
    </ol>
    
    <hr>
    
    <h2>3. Office Hours</h2>
    <dl>
        <dt>Monday - Friday</dt>
        <dd>8:00 AM - 5:00 PM</dd>
        
        <dt>Saturday</dt>
        <dd>8:00 AM - 12:00 PM</dd>
        
        <dt>Sunday</dt>
        <dd>Closed</dd>
    </dl>
    
    <h2>Contact Information</h2>
    <p>
        Hotline: (043) 123-4567<br>
        Email: barangay.stonino@gmail.com<br>
        Address: Barangay Hall, Sto. Niño, Batangas City
    </p>
</body>
</html>
```

## Text Formatting Tags (Quick Reference)

```html
<!-- Bold/Strong -->
<strong>Important</strong> or <b>Bold</b>

<!-- Italic/Emphasis -->
<em>Emphasized</em> or <i>Italic</i>

<!-- Underline -->
<u>Underlined</u>

<!-- Strikethrough -->
<s>Strikethrough</s> or <del>Deleted</del>

<!-- Mark/Highlight -->
<mark>Highlighted</mark>

<!-- Small text -->
<small>Fine print</small>

<!-- Subscript/Superscript -->
H<sub>2</sub>O and x<sup>2</sup>

<!-- Code -->
<code>console.log('hello')</code>

<!-- Blockquote (indented quote) -->
<blockquote>
    "Education is the key to success." - Jose Rizal
</blockquote>
```

## Best Practices

1. **One `<h1>` per page** (main title)
2. **Don't skip heading levels** (h1→h2→h3, not h1→h4)
3. **Use `<strong>`/`<em>` for meaning**, `<b>`/`<i>` for style
4. **Lists for grouped items** (not manual bullet points)
5. **Semantic structure** (headings for navigation, not just big text)

## Common Mistakes

### ❌ Using `<br>` for spacing
```html
<p>Text</p>
<br><br><br>  <!-- WRONG: Use CSS margin instead -->
<p>More text</p>
```

### ❌ Headings for styling
```html
<h1>I just want big text</h1>  <!-- WRONG: Use CSS font-size -->
```

### ❌ Manual numbering
```html
<p>1. First item</p>
<p>2. Second item</p>
<!-- WRONG: Use <ol><li> instead -->
```

## Summary

- **Headings:** `<h1>` to `<h6>` (hierarchy matters)
- **Paragraphs:** `<p>` (block of text)
- **Line breaks:** `<br>` (within same paragraph)
- **Unordered list:** `<ul><li>` (bullets)
- **Ordered list:** `<ol><li>` (numbers)
- **Description list:** `<dl><dt><dd>` (term-definition)
- **Horizontal rule:** `<hr>` (separator)
- **Preformatted:** `<pre>` (preserves formatting)

**Next lesson:** Links and Images