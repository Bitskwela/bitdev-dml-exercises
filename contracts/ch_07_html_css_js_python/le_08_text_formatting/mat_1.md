## Background Story

Tian opened their barangay website project, ready to add the actual content. They had the HTML structure—doctype, head, body—and they'd learned about tags, elements, and attributes. Now it was time to fill the pages with real information about the barangay.

They started typing inside the `<body>` tag:

```html
<body>
Barangay Sto. Niño Official Website
Welcome to our community portal. We serve 5,432 residents across 8 sitios.
Our Services:
Barangay Clearance - ₱50
Barangay ID - ₱30
Indigency Certificate - ₱20
Certificate of Residency - ₱40
Contact Information:
Barangay Hall Address: 123 Main Street, Batangas City
Contact Number: (043) 123-4567
Email: barangay@example.com
Office Hours: Monday to Friday, 8:00 AM - 5:00 PM
</body>
```

Tian saved the file and opened it in Chrome. The content appeared... but it was a disaster. Everything was crammed into a single continuous line with no structure, no hierarchy, no visual organization. The title wasn't emphasized. The services list wasn't actually a list. The contact information was jumbled together.

It looked like a wall of text with no formatting whatsoever.

Tian tried adding line breaks in the code, pressing Enter after each line. But when they refreshed the browser, nothing changed. HTML ignored line breaks in the source code.

"Why doesn't formatting work?" Tian muttered in frustration. "In Microsoft Word, I just press Enter for a new line, or make text bold by clicking a button. Why is HTML so different?"

They called Rhea Joy, who was working on her own section of the website.

"Rhea, how do you organize text in HTML? I have all this content—titles, descriptions, lists, contact info—but I don't know how to structure it properly. Everything appears as one long sentence."

"I'm having the same problem!" Rhea Joy replied. "I tried putting spaces between sections, but the browser ignores them. There must be specific HTML tags for different text types, right? Like one tag for headings, another for paragraphs, another for lists?"

That evening, they both joined a video call with Kuya Miguel and shared their screens, showing the unformatted wall of text.

Miguel couldn't help but smile—he'd made the same mistake when he first learned HTML.

"You two have discovered a fundamental principle of HTML: formatting doesn't come from spaces and line breaks in your code. It comes from semantic tags that describe the *type* of content. HTML is a markup language—you mark up content with tags that tell the browser: 'This is a heading. This is a paragraph. This is a list. This is emphasized text.'"

"So we need specific tags for each content type?" Tian asked.

"Exactly. Just like in Microsoft Word, you have formatting options—Title, Heading 1, Heading 2, Body Text, Bullet List. HTML has equivalent tags: `<h1>` through `<h6>` for headings, `<p>` for paragraphs, `<ul>` and `<ol>` for lists, `<strong>` for bold, `<em>` for italic. Each tag serves a specific purpose and creates both visual formatting *and* semantic meaning."

Miguel continued, "Today, I'm teaching you text formatting in HTML. By the end of this lesson, your content won't be a wall of text—it'll be properly structured with hierarchical headings, readable paragraphs, organized lists, and emphasized text. You'll learn the foundation of readable web content."

---

## Theory & Lecture Content

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

---

## Closing Story

Tian formatted the barangay announcements with proper headings, paragraphs, and lists. The content was still plain, but now it had hierarchy. Structure. Readability.

"See the difference?" Kuya Miguel pointed at the screen. "Before, it was a wall of text. Now, it's organized. Easy to scan. That's the power of semantic HTML."

Tian nodded. This was typography without design. Content without decoration. And yet, it worked. The message was clear. The information was accessible. Mission accomplished.

"Next, we add links and images," Kuya Miguel said. "Then your site becomes a webconnected to the bigger internet."

Tian saved the file and closed the laptop. Step by step, tag by tag, the barangay portal was taking shape.

_Next up: Links and Imagesconnecting to the web!_