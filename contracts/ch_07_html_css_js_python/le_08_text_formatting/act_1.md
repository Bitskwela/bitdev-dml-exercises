# Lesson 8 Activities: Text Formatting

## Master HTML Text Elements

Learn to structure and format text content professionally using headings, paragraphs, lists, and emphasis tags!

---

## Activity 1: Heading Hierarchy

**Goal:** Understand proper heading structure (h1-h6).

**Create:** `heading-practice.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Heading Hierarchy</title>
</head>
<body>
    <h1>Barangay Sto. Niño Website</h1>  <!-- Only ONE h1 per page -->
    
    <h2>About Us</h2>  <!-- Main sections -->
    <p>Content about the barangay...</p>
    
        <h3>Our History</h3>  <!-- Subsections -->
        <p>Founded in 1952...</p>
        
            <h4>Major Milestones</h4>  <!-- Sub-subsections -->
            <p>1952: Establishment...</p>
    
    <h2>Services</h2>
    <p>We offer various services...</p>
    
        <h3>Document Services</h3>
        <p>Clearance, cedula, permits...</p>
        
            <h4>Barangay Clearance</h4>
            <p>Required for employment...</p>
            
                <h5>Requirements</h5>  <!-- Rarely needed -->
                <p>Valid ID, 1x1 photo...</p>
                
                    <h6>Processing Time</h6>  <!-- Almost never used -->
                    <p>Same day release</p>
</body>
</html>
```

**Rules:**
1. Only ONE `<h1>` per page (main title)
2. Don't skip levels (h2 → h4 is wrong)
3. Use for structure, not styling

**Task:** Inspect in DevTools — see heading outline

---

## Activity 2: Paragraph Formatting

**Goal:** Master paragraph tags and line breaks.

**Create:** `paragraphs.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Paragraphs</title>
</head>
<body>
    <h1>Barangay Announcement</h1>
    
    <!-- Regular paragraph -->
    <p>
        Maligayang pagdating sa Barangay Sto. Niño! We are committed 
        to serving our community with integrity and excellence.
    </p>
    
    <!-- Paragraph with line break -->
    <p>
        Office Hours:<br>
        Monday - Friday: 8:00 AM - 5:00 PM<br>
        Saturday: 8:00 AM - 12:00 PM<br>
        Sunday: Closed
    </p>
    
    <!-- Multiple paragraphs (proper spacing) -->
    <p>This is the first paragraph.</p>
    <p>This is the second paragraph.</p>
    <p>This is the third paragraph.</p>
    
    <!-- ❌ Wrong: No paragraph tags -->
    This text has no structure.
    It won't have proper spacing.
    
    <!-- ❌ Wrong: Using <br> for spacing -->
    <p>Don't do this<br><br><br><br>to create space.</p>
</body>
</html>
```

**Best practices:**
- Use `<p>` for paragraphs
- Use `<br>` for line breaks within paragraphs
- Don't use multiple `<br>` for spacing (use CSS margin instead)

---

## Activity 3: Text Emphasis

**Goal:** Use emphasis and strong importance tags.

**Create:** `emphasis.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Text Emphasis</title>
</head>
<body>
    <h1>Barangay Services</h1>
    
    <!-- Strong importance (bold by default) -->
    <p>
        <strong>Important:</strong> All applicants must bring a valid ID.
    </p>
    
    <!-- Emphasis (italic by default) -->
    <p>
        Please submit your application <em>before</em> 3:00 PM.
    </p>
    
    <!-- Combining both -->
    <p>
        <strong><em>Urgent announcement:</em></strong> Office closed tomorrow.
    </p>
    
    <!-- Bold vs Strong -->
    <p>
        <b>Bold text</b> - just visual styling<br>
        <strong>Strong text</strong> - semantic importance (better for SEO/screen readers)
    </p>
    
    <!-- Italic vs Emphasis -->
    <p>
        <i>Italic text</i> - just visual styling<br>
        <em>Emphasized text</em> - semantic emphasis (better for accessibility)
    </p>
    
    <!-- Other text formatting -->
    <p>
        <mark>Highlighted text</mark> - yellow background<br>
        <small>Fine print text</small> - smaller size<br>
        <del>Deleted text</del> - strikethrough (removed content)<br>
        <ins>Inserted text</ins> - underlined (added content)<br>
        <sub>Subscript</sub> - H<sub>2</sub>O<br>
        <sup>Superscript</sup> - x<sup>2</sup>
    </p>
</body>
</html>
```

**Use semantic tags:**
- `<strong>` over `<b>` (importance)
- `<em>` over `<i>` (emphasis)

---

## Activity 4: Unordered Lists

**Goal:** Create bullet-point lists.

**Create:** `unordered-lists.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Unordered Lists</title>
</head>
<body>
    <h1>Barangay Services</h1>
    
    <!-- Simple list -->
    <ul>
        <li>Barangay Clearance</li>
        <li>Cedula</li>
        <li>Business Permit</li>
        <li>Barangay ID</li>
    </ul>
    
    <!-- Nested list -->
    <h2>Required Documents</h2>
    <ul>
        <li>Valid ID
            <ul>
                <li>Driver's License</li>
                <li>Passport</li>
                <li>SSS ID</li>
                <li>Postal ID</li>
            </ul>
        </li>
        <li>Photos
            <ul>
                <li>1x1 (2 copies)</li>
                <li>2x2 (1 copy)</li>
            </ul>
        </li>
        <li>Proof of Residency</li>
    </ul>
    
    <!-- List with formatting -->
    <h2>Office Rules</h2>
    <ul>
        <li><strong>No smoking</strong> inside the premises</li>
        <li><em>Respect</em> all staff members</li>
        <li>Keep <mark>noise to a minimum</mark></li>
    </ul>
</body>
</html>
```

**List types (CSS):**
- `disc` (default) - •
- `circle` - ○
- `square` - ▪
- `none` - no bullet

---

## Activity 5: Ordered Lists

**Goal:** Create numbered lists.

**Create:** `ordered-lists.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Ordered Lists</title>
</head>
<body>
    <h1>How to Apply for Barangay Clearance</h1>
    
    <!-- Numbered list (default) -->
    <ol>
        <li>Go to Barangay Hall</li>
        <li>Fill out application form</li>
        <li>Submit requirements (ID + photo)</li>
        <li>Pay processing fee (₱50)</li>
        <li>Wait for processing (same day)</li>
        <li>Claim your clearance</li>
    </ol>
    
    <!-- Custom start number -->
    <h2>Steps continued from #7:</h2>
    <ol start="7">
        <li>Present clearance to employer</li>
        <li>Keep a copy for your records</li>
    </ol>
    
    <!-- Reversed order -->
    <h2>Top 3 Most Requested Services:</h2>
    <ol reversed>
        <li>Business Permit</li>
        <li>Barangay ID</li>
        <li>Barangay Clearance</li>
    </ol>
    
    <!-- Different numbering styles -->
    <h2>Numbering Types (via CSS):</h2>
    
    <!-- type="1" - numbers (default) -->
    <ol type="1">
        <li>First</li>
        <li>Second</li>
    </ol>
    
    <!-- type="A" - uppercase letters -->
    <ol type="A">
        <li>First</li>
        <li>Second</li>
    </ol>
    
    <!-- type="a" - lowercase letters -->
    <ol type="a">
        <li>First</li>
        <li>Second</li>
    </ol>
    
    <!-- type="I" - uppercase Roman -->
    <ol type="I">
        <li>First</li>
        <li>Second</li>
    </ol>
    
    <!-- type="i" - lowercase Roman -->
    <ol type="i">
        <li>First</li>
        <li>Second</li>
    </ol>
</body>
</html>
```

**When to use ordered lists:**
- Step-by-step instructions
- Rankings
- Sequences that matter

---

## Activity 6: Description Lists

**Goal:** Create definition/description lists.

**Create:** `description-lists.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Description Lists</title>
</head>
<body>
    <h1>Barangay Terms Glossary</h1>
    
    <dl>
        <dt>Barangay</dt>
        <dd>The smallest administrative division in the Philippines.</dd>
        
        <dt>Kapitan</dt>
        <dd>The elected chief executive of the barangay.</dd>
        
        <dt>Kagawad</dt>
        <dd>Council member elected to assist the barangay captain.</dd>
        
        <dt>Sangguniang Barangay</dt>
        <dd>The legislative body of the barangay government.</dd>
        
        <dt>Barangay Clearance</dt>
        <dd>A document certifying that a person is a resident of the barangay and has no derogatory records.</dd>
    </dl>
    
    <h2>Service Fees</h2>
    <dl>
        <dt>Barangay Clearance</dt>
        <dd>₱50.00</dd>
        
        <dt>Cedula</dt>
        <dd>₱20.00 - ₱100.00 (based on income)</dd>
        
        <dt>Barangay ID</dt>
        <dd>₱30.00</dd>
    </dl>
</body>
</html>
```

**Structure:**
- `<dl>` - Description List container
- `<dt>` - Term (what you're defining)
- `<dd>` - Description (definition)

---

## Activity 7: Complete Barangay Services Page

**Goal:** Combine all text formatting techniques.

**Create:** `services-page.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Services - Barangay Sto. Niño</title>
</head>
<body>
    <h1>Barangay Sto. Niño Services</h1>
    
    <p>
        Welcome to our services page. We offer various documents and 
        assistance to our beloved constituents.
    </p>
    
    <hr>
    
    <h2>Available Services</h2>
    
    <h3>1. Barangay Clearance</h3>
    <p>
        A <strong>Barangay Clearance</strong> is required for employment, 
        loan applications, and other transactions. <em>Same-day processing</em> 
        is available.
    </p>
    
    <h4>Requirements:</h4>
    <ul>
        <li>Valid ID (original and photocopy)</li>
        <li>1x1 photo (2 copies)</li>
        <li>Proof of residency</li>
    </ul>
    
    <h4>Processing Steps:</h4>
    <ol>
        <li>Fill out application form</li>
        <li>Submit requirements</li>
        <li>Pay ₱50 processing fee</li>
        <li>Wait 30 minutes</li>
        <li>Claim clearance with Official Receipt</li>
    </ol>
    
    <p><mark>Important:</mark> <strong>Bring your OR when claiming!</strong></p>
    
    <hr>
    
    <h3>2. Community Tax Certificate (Cedula)</h3>
    <p>
        Required annual tax payment for residents. Fee is based on income.
    </p>
    
    <h4>Fee Schedule:</h4>
    <dl>
        <dt>Basic Fee</dt>
        <dd>₱5.00</dd>
        
        <dt>Additional (if employed)</dt>
        <dd>₱1.00 per ₱1,000 of gross income</dd>
        
        <dt>Maximum Fee</dt>
        <dd>₱5,000.00</dd>
    </dl>
    
    <hr>
    
    <h3>3. Barangay ID</h3>
    <p>
        Official identification card for barangay residents. 
        <small>(Valid for 2 years)</small>
    </p>
    
    <h4>Benefits:</h4>
    <ul>
        <li>Valid government ID</li>
        <li>Discount on barangay services</li>
        <li>Access to barangay programs
            <ul>
                <li>Scholarship programs</li>
                <li>Livelihood training</li>
                <li>Medical assistance</li>
            </ul>
        </li>
    </ul>
    
    <hr>
    
    <h2>Office Hours</h2>
    <p>
        Monday - Friday: 8:00 AM - 5:00 PM<br>
        Saturday: 8:00 AM - 12:00 PM<br>
        Sunday &amp; Holidays: <strong>Closed</strong>
    </p>
    
    <hr>
    
    <h2>Contact Information</h2>
    <address>
        <strong>Barangay Sto. Niño Hall</strong><br>
        P. Burgos Street, Batangas City<br>
        Phone: (043) 123-4567<br>
        Email: brgy.stonino@example.com
    </address>
    
    <hr>
    
    <footer>
        <p>
            <small>
                &copy; 2025 Barangay Sto. Niño. All rights reserved.<br>
                Last updated: <time datetime="2025-01-15">January 15, 2025</time>
            </small>
        </p>
    </footer>
</body>
</html>
```

**Requirements met:**
✅ Proper heading hierarchy (h1 → h6)  
✅ Well-structured paragraphs  
✅ Text emphasis (strong, em, mark)  
✅ Unordered lists (bullets)  
✅ Ordered lists (steps)  
✅ Description lists (definitions)  
✅ Line breaks (`<br>`)  
✅ Horizontal rules (`<hr>`)  
✅ Semantic tags (`<address>`, `<time>`)

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: Heading Hierarchy

**Rules:**
1. **Only ONE `<h1>` per page** (main title, SEO important)
2. **Don't skip levels:**
   ```html
   <!-- ✅ Correct -->
   <h1>Title</h1>
   <h2>Section</h2>
   <h3>Subsection</h3>
   
   <!-- ❌ Wrong -->
   <h1>Title</h1>
   <h4>Subsection</h4>  <!-- Skipped h2, h3 -->
   ```

3. **Use for structure, not styling:**
   ```html
   <!-- ❌ Wrong -->
   <h5>Big text</h5>  <!-- Using h5 because you want small text -->
   
   <!-- ✅ Correct -->
   <h2 style="font-size: 16px;">Big text</h2>  <!-- Use CSS for size -->
   ```

**Outline example:**
```
h1 - Barangay Website
  h2 - About Us
    h3 - History
      h4 - Milestones
  h2 - Services
    h3 - Document Services
      h4 - Clearance
        h5 - Requirements
```

## Activity 2: Paragraph Best Practices

**Proper paragraph usage:**
```html
<!-- ✅ Correct: One idea per paragraph -->
<p>First paragraph with one main idea.</p>
<p>Second paragraph with another idea.</p>

<!-- ❌ Wrong: No paragraph tags -->
First line of text
Second line of text
<!-- No spacing between lines -->
```

**Line breaks:**
```html
<!-- ✅ Correct: <br> for addresses/poems -->
<p>
    Barangay Hall<br>
    123 Main Street<br>
    Batangas City
</p>

<!-- ❌ Wrong: Multiple <br> for spacing -->
<p>Text<br><br><br><br>Text</p>  <!-- Use CSS margin instead -->
```

**Special characters:**
- `&nbsp;` - Non-breaking space
- `&amp;` - &
- `&lt;` - <
- `&gt;` - >
- `&copy;` - ©
- `&trade;` - ™

## Activity 3: Text Emphasis

**Semantic vs Visual:**

| Semantic (Better) | Visual (Avoid) | Purpose |
|-------------------|----------------|---------|
| `<strong>` | `<b>` | Importance |
| `<em>` | `<i>` | Emphasis |
| `<mark>` | `<span style="background:yellow">` | Highlight |

**Why semantic is better:**
1. **Screen readers** understand importance
2. **SEO** recognizes emphasis
3. **Maintainability** - meaning survives CSS changes

**Complete text formatting tags:**
```html
<strong>Important</strong> - Strong importance
<em>Emphasis</em> - Stressed emphasis
<mark>Highlighted</mark> - Marked/highlighted
<small>Fine print</small> - Side comments
<del>Deleted</del> - Removed content
<ins>Inserted</ins> - Added content
<s>Strikethrough</s> - No longer accurate
<u>Underlined</u> - Avoid (looks like link)
<code>Code</code> - Inline code
<kbd>Ctrl+C</kbd> - Keyboard input
<samp>Output</samp> - Sample output
<var>x</var> - Variable
<sub>Subscript</sub> - H<sub>2</sub>O
<sup>Superscript</sup> - x<sup>2</sup>
<abbr title="HyperText Markup Language">HTML</abbr> - Abbreviation
<cite>Book Title</cite> - Citation
<q>Quote</q> - Short inline quote
<blockquote>Long quote</blockquote> - Block quote
```

## Activity 4: Unordered Lists

**Structure:**
```html
<ul>        <!-- Container -->
    <li>Item 1</li>    <!-- List item -->
    <li>Item 2</li>
    <li>Item 3</li>
</ul>
```

**Nesting lists:**
```html
<ul>
    <li>Parent item
        <ul>  <!-- Nested list goes INSIDE parent <li> -->
            <li>Child item 1</li>
            <li>Child item 2</li>
        </ul>
    </li>
    <li>Another parent</li>
</ul>
```

**Styling bullets (CSS):**
```html
<ul style="list-style-type: disc;">  <!-- • (default) -->
<ul style="list-style-type: circle;">  <!-- ○ -->
<ul style="list-style-type: square;">  <!-- ▪ -->
<ul style="list-style-type: none;">  <!-- No bullet -->
```

## Activity 5: Ordered Lists

**Attributes:**
```html
<!-- Start at specific number -->
<ol start="5">
    <li>Item 5</li>
    <li>Item 6</li>
</ol>

<!-- Reverse order -->
<ol reversed>
    <li>Third</li>  <!-- 3. -->
    <li>Second</li>  <!-- 2. -->
    <li>First</li>   <!-- 1. -->
</ol>

<!-- Numbering types -->
<ol type="1">  <!-- 1, 2, 3 (default) -->
<ol type="A">  <!-- A, B, C -->
<ol type="a">  <!-- a, b, c -->
<ol type="I">  <!-- I, II, III -->
<ol type="i">  <!-- i, ii, iii -->
```

**When to use `<ol>` vs `<ul>`:**
- **Ordered (`<ol>`)** - Sequence matters (steps, rankings)
- **Unordered (`<ul>`)** - Order doesn't matter (features, items)

## Activity 6: Description Lists

**Structure:**
```html
<dl>                <!-- Description List -->
    <dt>Term</dt>   <!-- Description Term -->
    <dd>Definition</dd>  <!-- Description Definition -->
</dl>
```

**Multiple definitions:**
```html
<dl>
    <dt>HTML</dt>
    <dd>HyperText Markup Language</dd>
    <dd>The standard markup language for web pages</dd>
    
    <dt>CSS</dt>
    <dd>Cascading Style Sheets</dd>
</dl>
```

**Use cases:**
- Glossaries
- FAQs
- Metadata
- Key-value pairs

## Activity 7: Complete Example

**Document structure checklist:**
- [ ] Single `<h1>` for page title
- [ ] Logical heading hierarchy (h2 → h3 → h4)
- [ ] Paragraphs for content blocks
- [ ] Lists for related items
- [ ] Emphasis tags for important text
- [ ] Semantic tags (`<address>`, `<time>`, `<footer>`)
- [ ] Horizontal rules (`<hr>`) for section breaks

**Accessibility:**
```html
<!-- ✅ Good structure for screen readers -->
<h1>Main Title</h1>
<p>Introduction paragraph.</p>

<h2>Section 1</h2>
<p>Content with <strong>important</strong> information.</p>

<h3>Subsection</h3>
<ul>
    <li>Point 1</li>
    <li>Point 2</li>
</ul>

<!-- ❌ Bad: No structure -->
<div><font size="5"><b>Main Title</b></font></div>
Text without paragraphs
<div><font size="4"><b>Section 1</b></font></div>
```

**Special HTML entities:**
```html
&nbsp;  - Non-breaking space
&amp;   - & (ampersand)
&lt;    - < (less than)
&gt;    - > (greater than)
&quot;  - " (quote)
&apos;  - ' (apostrophe)
&copy;  - © (copyright)
&reg;   - ® (registered)
&trade; - ™ (trademark)
&cent;  - ¢ (cent)
&pound; - £ (pound)
&yen;   - ¥ (yen)
&euro;  - € (euro)
&deg;   - ° (degree)
&plusmn; - ± (plus-minus)
&times; - × (multiplication)
&divide; - ÷ (division)
```

**Philippine peso symbol:**
```html
₱ - &#8369; or &peso; (not widely supported, use image or ₱)
```

</details>

---

**Fantastic!** You've mastered HTML text formatting. Your content is now well-structured, accessible, and easy to read!

**Next:** Links and images to make your pages interactive and visual!
