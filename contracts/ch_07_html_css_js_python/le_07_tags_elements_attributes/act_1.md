# Lesson 7 Activities: Tags, Elements, and Attributes

## Master HTML Syntax Building Blocks

Learn how tags, elements, and attributes work together to create structured web content!

---

## Activity 1: Tag Anatomy Practice

**Goal:** Understand opening tags, closing tags, and self-closing tags.

**Create:** `tag-practice.html`

**Types of tags:**

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Tag Types</title>
</head>
<body>
    <!-- 1. Container tags (opening + closing) -->
    <p>This is a paragraph</p>
    <h1>This is a heading</h1>
    <div>This is a division</div>
    
    <!-- 2. Self-closing tags (no closing tag needed) -->
    <img src="image.jpg" alt="Description">
    <br>
    <hr>
    <input type="text">
    
    <!-- 3. Empty elements -->
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
</body>
</html>
```

**Task:** Identify which tags require closing tags and which don't.

**Questions:**
1. What happens if you forget to close `<p>`?
2. Can you write `<br></br>` or must it be `<br>`?
3. Why do some tags need content inside them?

---

## Activity 2: Attribute Exploration

**Goal:** Learn common attributes and their syntax.

**Attribute anatomy:** `<tag attribute="value">Content</tag>`

**Common attributes:**

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Attributes</title>
</head>
<body>
    <!-- 1. Global attributes (work on any tag) -->
    <div id="unique-identifier">ID attribute</div>
    <p class="highlight">Class attribute</p>
    <span style="color: red;">Style attribute</span>
    <button title="Click me!">Hover to see title</button>
    
    <!-- 2. Tag-specific attributes -->
    <a href="https://google.com">Link with href</a>
    <img src="photo.jpg" alt="Photo description" width="300">
    <input type="email" placeholder="Enter email" required>
    
    <!-- 3. Boolean attributes -->
    <input type="checkbox" checked>
    <button disabled>Can't click</button>
    <video autoplay muted></video>
</body>
</html>
```

**Experiment:**
1. Change attribute values
2. Remove required attributes — what breaks?
3. Add multiple classes: `class="class1 class2 class3"`

---

## Activity 3: Nesting Elements Correctly

**Goal:** Master proper tag nesting rules.

**Create:** `nesting-practice.html`

**Correct nesting:**
```html
<!-- ✅ Correct -->
<div>
    <p>This is <strong>bold</strong> text.</p>
</div>

<!-- ❌ Incorrect (overlapping) -->
<p>This is <strong>bold</p></strong>

<!-- ✅ Correct list nesting -->
<ul>
    <li>Item 1
        <ul>
            <li>Sub-item A</li>
            <li>Sub-item B</li>
        </ul>
    </li>
    <li>Item 2</li>
</ul>

<!-- ❌ Incorrect (li outside ul) -->
<li>This won't work</li>
```

**Rules:**
- Last opened, first closed (like Russian dolls)
- Inline elements can't contain block elements
- Lists must be inside `<ul>` or `<ol>`

**Task:** Fix this broken code:
```html
<p>This is a <strong>paragraph with <em>nested</strong> tags</em>.</p>
```

---

## Activity 4: Barangay Officials Page

**Goal:** Build a real page using proper tags and attributes.

**Create:** `officials.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Officials - Barangay Sto. Niño</title>
</head>
<body>
    <h1>Barangay Sto. Niño Officials</h1>
    <p>Meet our dedicated public servants.</p>
    
    <!-- Barangay Captain -->
    <div id="captain" class="official">
        <img src="captain.jpg" alt="Kapitan Juan Dela Cruz" width="200">
        <h2>Juan Dela Cruz</h2>
        <p class="position">Barangay Captain</p>
        <p>Contact: <a href="tel:+639123456789">0912-345-6789</a></p>
    </div>
    
    <!-- Kagawad 1 -->
    <div id="kagawad1" class="official">
        <img src="kagawad1.jpg" alt="Kagawad Maria Santos" width="200">
        <h2>Maria Santos</h2>
        <p class="position">Kagawad - Health & Sanitation</p>
        <p>Contact: <a href="tel:+639987654321">0998-765-4321</a></p>
    </div>
    
    <!-- Add more officials... -->
    
    <hr>
    <footer>
        <p><small>&copy; 2025 Barangay Sto. Niño. All rights reserved.</small></p>
    </footer>
</body>
</html>
```

**Requirements:**
- Each official in a `<div>` with unique ID
- All share same class `official`
- Images with proper alt text
- Clickable phone numbers

---

## Activity 5: Link Attributes Deep Dive

**Goal:** Master anchor tag attributes.

**Create:** `links-test.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Link Attributes</title>
</head>
<body>
    <h1>Link Attribute Examples</h1>
    
    <!-- 1. External link (opens in new tab) -->
    <a href="https://facebook.com" target="_blank" rel="noopener noreferrer">
        Facebook
    </a>
    
    <!-- 2. Email link -->
    <a href="mailto:barangay@example.com">Email us</a>
    
    <!-- 3. Phone link -->
    <a href="tel:+639123456789">Call us: 0912-345-6789</a>
    
    <!-- 4. Download link -->
    <a href="clearance-form.pdf" download>Download Form</a>
    
    <!-- 5. Jump to section -->
    <a href="#contact">Jump to Contact Section</a>
    
    <!-- Section to jump to -->
    <div id="contact" style="margin-top: 1000px;">
        <h2>Contact Us</h2>
        <p>Barangay Hall address here.</p>
    </div>
</body>
</html>
```

**Test each link:**
1. External link behavior
2. Email client opens
3. Phone dialer on mobile
4. File downloads
5. Smooth scroll to section

---

## Activity 6: Image Attributes Mastery

**Goal:** Learn all image tag attributes.

**Create:** `image-attributes.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Image Attributes</title>
</head>
<body>
    <h1>Image Attribute Examples</h1>
    
    <!-- 1. Required attributes -->
    <img src="barangay-logo.png" alt="Barangay Sto. Niño Logo">
    
    <!-- 2. Size attributes -->
    <img src="photo.jpg" alt="Photo" width="400" height="300">
    
    <!-- 3. Title attribute (hover tooltip) -->
    <img src="captain.jpg" alt="Barangay Captain" title="Kapitan Juan Dela Cruz">
    
    <!-- 4. Loading attribute (lazy loading) -->
    <img src="large-image.jpg" alt="Description" loading="lazy">
    
    <!-- 5. Fallback with onerror -->
    <img src="missing.jpg" alt="Broken" onerror="this.src='placeholder.png'">
</body>
</html>
```

**Important:**
- `alt` is REQUIRED for accessibility
- `width`/`height` prevent layout shift
- `loading="lazy"` improves performance

---

## Activity 7: Form Input Attributes

**Goal:** Create a clearance application form with various input attributes.

**Create:** `clearance-form.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Clearance Application</title>
</head>
<body>
    <h1>Barangay Clearance Application</h1>
    
    <form action="submit.php" method="POST">
        <!-- Text input with attributes -->
        <label for="fullname">Full Name:</label>
        <input 
            type="text" 
            id="fullname" 
            name="fullname" 
            placeholder="Juan Dela Cruz" 
            required 
            minlength="3"
            maxlength="100"
        >
        <br><br>
        
        <!-- Email with validation -->
        <label for="email">Email:</label>
        <input 
            type="email" 
            id="email" 
            name="email" 
            placeholder="juan@example.com"
            required
        >
        <br><br>
        
        <!-- Number input with range -->
        <label for="age">Age:</label>
        <input 
            type="number" 
            id="age" 
            name="age" 
            min="18" 
            max="100" 
            required
        >
        <br><br>
        
        <!-- Date picker -->
        <label for="birthdate">Birthdate:</label>
        <input 
            type="date" 
            id="birthdate" 
            name="birthdate" 
            max="2007-01-01"
            required
        >
        <br><br>
        
        <!-- Dropdown -->
        <label for="purpose">Purpose:</label>
        <select id="purpose" name="purpose" required>
            <option value="">Select purpose...</option>
            <option value="employment">Employment</option>
            <option value="loan">Loan Application</option>
            <option value="school">School Requirements</option>
            <option value="other">Other</option>
        </select>
        <br><br>
        
        <!-- Radio buttons -->
        <p>Gender:</p>
        <input type="radio" id="male" name="gender" value="male" required>
        <label for="male">Male</label>
        
        <input type="radio" id="female" name="gender" value="female">
        <label for="female">Female</label>
        <br><br>
        
        <!-- Checkbox -->
        <input type="checkbox" id="agree" name="agree" required>
        <label for="agree">I certify that all information is correct</label>
        <br><br>
        
        <!-- Buttons -->
        <button type="submit">Submit Application</button>
        <button type="reset">Clear Form</button>
    </form>
</body>
</html>
```

**Test all inputs:**
1. Try submitting without required fields
2. Enter invalid email format
3. Test age range validation
4. Check date picker restrictions

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: Tag Anatomy

**Container tags (need closing):**
```html
<p>...</p>
<h1>...</h1>
<div>...</div>
<a>...</a>
<button>...</button>
<span>...</span>
```

**Self-closing tags (no closing needed):**
```html
<img src="..." alt="...">
<br>
<hr>
<input type="...">
<meta ...>
<link ...>
```

**What happens without closing tag:**
- Browser tries to auto-close (unpredictable)
- Content might render incorrectly
- Validation fails

**HTML5 self-closing syntax:**
- `<br>` is valid
- `<br />` is also valid (XML style)
- `<br></br>` is WRONG

## Activity 2: Attribute Syntax

**Global attributes (work on all tags):**
- `id` - Unique identifier (only one per page)
- `class` - Classification (multiple allowed)
- `style` - Inline CSS
- `title` - Tooltip on hover
- `lang` - Language
- `data-*` - Custom data attributes

**Attribute rules:**
```html
<!-- ✅ Correct -->
<div id="myId" class="class1 class2" title="Tooltip"></div>

<!-- ❌ Wrong -->
<div id="myId" id="anotherId"></div> <!-- Two IDs -->
<div class=no-quotes></div> <!-- Missing quotes -->
```

**Boolean attributes:**
- Presence = true, absence = false
- `<input required>` same as `<input required="required">`
- Common: `checked`, `disabled`, `readonly`, `required`, `selected`

## Activity 3: Nesting Rules

**Fixed code:**
```html
<!-- Original (broken) -->
<p>This is a <strong>paragraph with <em>nested</strong> tags</em>.</p>

<!-- Fixed -->
<p>This is a <strong>paragraph with <em>nested</em></strong> tags.</p>
```

**Nesting rules:**
1. **Last opened, first closed:**
   ```html
   <!-- ✅ Correct -->
   <div><p><strong>Text</strong></p></div>
   
   <!-- ❌ Wrong -->
   <div><p><strong>Text</div></strong></p>
   ```

2. **Block vs Inline:**
   ```html
   <!-- ✅ Correct: block contains inline -->
   <p>This is <strong>bold</strong> text.</p>
   
   <!-- ❌ Wrong: inline contains block -->
   <strong><p>This doesn't work</p></strong>
   ```

3. **List requirements:**
   ```html
   <!-- ✅ Correct -->
   <ul>
       <li>Item</li>
   </ul>
   
   <!-- ❌ Wrong -->
   <li>Item without list</li>
   ```

**Block elements:** `<div>`, `<p>`, `<h1>`, `<section>`, `<header>`, `<footer>`, `<ul>`, `<ol>`, `<li>`

**Inline elements:** `<span>`, `<a>`, `<strong>`, `<em>`, `<img>`, `<button>`

## Activity 4: Complete Structure

**ID vs Class:**
```html
<!-- ID: Unique (only one on page) -->
<div id="captain"></div>

<!-- Class: Reusable (multiple allowed) -->
<div class="official"></div>
<div class="official"></div>
<div class="official"></div>

<!-- Multiple classes on one element -->
<div class="official featured highlight"></div>
```

**Naming conventions:**
- Use kebab-case: `my-element-name`
- Or camelCase: `myElementName`
- Descriptive names: `captain`, `kagawad1` (not `div1`, `div2`)

## Activity 5: Link Attributes

**Complete reference:**
```html
<!-- 1. href (required) -->
<a href="https://example.com">Link</a>

<!-- 2. target -->
<a href="..." target="_blank">New tab</a>
<a href="..." target="_self">Same tab (default)</a>

<!-- 3. rel (for external links) -->
<a href="..." target="_blank" rel="noopener noreferrer">Secure external link</a>

<!-- 4. download -->
<a href="file.pdf" download>Download PDF</a>
<a href="file.pdf" download="my-file.pdf">Download with custom name</a>

<!-- 5. Special href values -->
<a href="mailto:email@example.com">Email</a>
<a href="tel:+639123456789">Phone</a>
<a href="#section">Jump to section</a>
<a href="#">Jump to top</a>
```

**Security note:**
Always use `rel="noopener noreferrer"` with `target="_blank"` to prevent security issues.

## Activity 6: Image Attributes

**Complete reference:**
```html
<img 
    src="path/to/image.jpg"           <!-- Required: image source -->
    alt="Description for screen readers"  <!-- Required: accessibility -->
    width="400"                        <!-- Optional: width in pixels -->
    height="300"                       <!-- Optional: height in pixels -->
    title="Tooltip on hover"           <!-- Optional: hover text -->
    loading="lazy"                     <!-- Optional: lazy loading -->
    decoding="async"                   <!-- Optional: async decoding -->
>
```

**Why alt is critical:**
1. Screen readers for blind users
2. Shows if image fails to load
3. SEO (Google reads alt text)
4. Required for valid HTML

**Alt text guidelines:**
- Describe the image content
- Keep under 125 characters
- Don't start with "Image of..."
- Empty for decorative images: `alt=""`

**Examples:**
```html
<!-- ✅ Good -->
<img src="captain.jpg" alt="Barangay Captain Juan Dela Cruz smiling in office">

<!-- ❌ Bad -->
<img src="captain.jpg" alt="Image">
<img src="captain.jpg" alt="">  <!-- Only for decorative -->
```

## Activity 7: Input Attributes

**Complete input attribute reference:**

```html
<!-- Text input -->
<input 
    type="text"                 <!-- Input type -->
    id="unique-id"              <!-- For label -->
    name="form-field-name"      <!-- Sent to server -->
    value="Default value"       <!-- Pre-filled value -->
    placeholder="Hint text"     <!-- Gray hint text -->
    required                    <!-- Must be filled -->
    readonly                    <!-- Can't edit -->
    disabled                    <!-- Grayed out -->
    minlength="3"              <!-- Minimum characters -->
    maxlength="100"            <!-- Maximum characters -->
    pattern="[A-Za-z]+"        <!-- Regex validation -->
    autocomplete="name"        <!-- Browser autofill -->
>

<!-- Number input -->
<input 
    type="number" 
    min="1"                    <!-- Minimum value -->
    max="100"                  <!-- Maximum value -->
    step="5"                   <!-- Increment step -->
>

<!-- Date input -->
<input 
    type="date" 
    min="2020-01-01"          <!-- Earliest date -->
    max="2025-12-31"          <!-- Latest date -->
>

<!-- Email (automatic validation) -->
<input type="email" required>

<!-- Checkbox -->
<input type="checkbox" checked>  <!-- Checked by default -->

<!-- Radio -->
<input type="radio" name="group" value="option1">
<input type="radio" name="group" value="option2">
<!-- Same name = only one selectable -->

<!-- File upload -->
<input type="file" accept=".pdf,.jpg" multiple>
```

**Form validation attributes:**
- `required` - Must be filled
- `minlength` / `maxlength` - String length
- `min` / `max` - Number/date range
- `pattern` - Regex pattern
- `type="email"` - Email format check
- `type="url"` - URL format check

**Philippine form example:**
```html
<form>
    <label for="mobile">Mobile Number:</label>
    <input 
        type="tel" 
        id="mobile" 
        name="mobile" 
        pattern="09[0-9]{9}"
        placeholder="09123456789"
        required
        title="Format: 09XXXXXXXXX"
    >
</form>
```

</details>

---

**Excellent!** You've mastered tags, elements, and attributes — the building blocks of HTML. You can now create properly structured, accessible web content!

**Next:** Text formatting with headings, paragraphs, and lists!
