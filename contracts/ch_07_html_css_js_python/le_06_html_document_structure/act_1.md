# Lesson 6 Activities: HTML Document Structure

## Building Valid HTML5 Documents

Master the anatomy of HTML documents by creating properly structured pages from scratch!

---

## Activity 1: Build Your First Complete HTML Page

**Goal:** Create a valid HTML5 document with all required elements.

**Instructions:**
Create `my-first-page.html` with this structure:

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My First Webpage</title>
</head>
<body>
    <h1>Welcome to My Page</h1>
    <p>This is my first properly structured HTML document!</p>
</body>
</html>
```

**Tasks:**
1. Type it manually (don't copy-paste)
2. Save and open in browser
3. Validate at `validator.w3.org`

**Questions:**
1. What does `<!DOCTYPE html>` do?
2. Why `lang="en-PH"` instead of just `lang="en"`?
3. What's in `<head>` vs `<body>`?

---

## Activity 2: Meta Tags Exploration

**Goal:** Understand different meta tags and their purposes.

**Add these meta tags to your `<head>`:**

```html
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Official Barangay Sto. Niño website">
    <meta name="keywords" content="barangay, clearance, services, Batangas">
    <meta name="author" content="Juan Dela Cruz">
    <meta http-equiv="refresh" content="30">
    <title>Barangay Sto. Niño</title>
</head>
```

**Experiment:**
1. Test the refresh meta tag (page reloads every 30 seconds)
2. View page source — can you see meta tags?
3. Search your page on Google (description appears in results)

**Questions:**
1. Which meta tag affects mobile responsiveness?
2. Which meta tag is for SEO?
3. Should passwords be in meta tags? Why not?

---

## Activity 3: Title Tag Best Practices

**Goal:** Write effective page titles.

**Create 3 HTML pages with appropriate titles:**

| Page | Bad Title | Good Title |
|------|-----------|------------|
| Homepage | "Home" | "Barangay Sto. Niño - Official Website" |
| Services | "Page 2" | "Services - Barangay Clearance & Permits" |
| Contact | "Contact Us" | "Contact Barangay Sto. Niño - Office Hours & Map" |

**Best practices:**
- 50-60 characters max
- Include keywords (SEO)
- Brand name at end
- Descriptive, not generic

**Task:** Check how titles appear in:
- Browser tab
- Google search results
- Bookmarks

---

## Activity 4: Character Encoding Test

**Goal:** Understand UTF-8 encoding importance.

**Create two files:**

**File 1: Without charset**
```html
<!DOCTYPE html>
<html>
<head>
    <title>Test</title>
</head>
<body>
    <p>Kumusta! Maligayang pagdating sa ñ á é í ó ú</p>
</body>
</html>
```

**File 2: With charset**
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test</title>
</head>
<body>
    <p>Kumusta! Maligayang pagdating sa ñ á é í ó ú</p>
</body>
</html>
```

**Compare:** Do special Filipino characters display correctly in both?

---

## Activity 5: Viewport Meta Tag Experiment

**Goal:** See how viewport affects mobile rendering.

**Create two pages:**

**Page 1: No viewport**
```html
<!DOCTYPE html>
<html>
<head>
    <title>No Viewport</title>
</head>
<body>
    <h1>Test Page Without Viewport</h1>
    <p>This text might be tiny on mobile...</p>
</body>
</html>
```

**Page 2: With viewport**
```html
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>With Viewport</title>
</head>
<body>
    <h1>Test Page With Viewport</h1>
    <p>This text should be readable on mobile!</p>
</body>
</html>
```

**Test:**
1. Open both on mobile (or use DevTools mobile emulation)
2. Which is easier to read?
3. Which requires pinch-zoom?

---

## Activity 6: Favicon Implementation

**Goal:** Add a custom icon to your website.

**Steps:**
1. Create or download a small image (16x16 or 32x32 pixels)
2. Save as `favicon.ico` or `favicon.png`
3. Add to `<head>`:

```html
<head>
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <!-- OR -->
    <link rel="icon" href="favicon.png" type="image/png">
</head>
```

**Test:** Check browser tab — do you see your icon?

**Philippine example:** Use barangay logo as favicon.

---

## Activity 7: Complete Barangay Homepage Structure

**Goal:** Build a professional HTML document structure.

**Create:** `barangay-homepage.html`

**Requirements:**
- Valid DOCTYPE
- Language attribute (en-PH or tl)
- UTF-8 charset
- Viewport meta tag
- Descriptive title
- Author and description meta tags
- Favicon link
- Structured body content (header, main, footer)

**Template:**
```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Official website of Barangay Sto. Niño, Batangas City">
    <meta name="keywords" content="barangay, services, clearance, Batangas">
    <meta name="author" content="Barangay Sto. Niño">
    <link rel="icon" href="favicon.png">
    <title>Barangay Sto. Niño - Official Website | Services & Information</title>
</head>
<body>
    <header>
        <h1>Barangay Sto. Niño</h1>
        <p>Serving the community since 1952</p>
    </header>
    
    <main>
        <section>
            <h2>Welcome</h2>
            <p>Official website of Barangay Sto. Niño, Batangas City.</p>
        </section>
        
        <section>
            <h2>Our Services</h2>
            <ul>
                <li>Barangay Clearance</li>
                <li>Cedula</li>
                <li>Business Permits</li>
            </ul>
        </section>
    </main>
    
    <footer>
        <p>&copy; 2025 Barangay Sto. Niño. All rights reserved.</p>
    </footer>
</body>
</html>
```

**Validate:** Use W3C Validator — should pass with no errors!

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: Complete HTML Structure

**DOCTYPE Explanation:**
- `<!DOCTYPE html>` tells browser to use HTML5 mode
- Must be first line (before `<html>`)
- Not case-sensitive but uppercase is convention
- Without it, browser uses "quirks mode" (legacy rendering)

**Language Attribute:**
- `lang="en"` = English
- `lang="en-PH"` = English (Philippine variant)
- `lang="tl"` = Tagalog
- Helps screen readers pronounce correctly
- Improves SEO for region-specific searches

**Head vs Body:**
- `<head>` = Metadata (not visible on page)
- `<body>` = Visible content

## Activity 2: Meta Tags

**Essential meta tags:**

```html
<!-- Character encoding (must be first meta tag) -->
<meta charset="UTF-8">

<!-- Mobile responsive (CRITICAL) -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- SEO: Appears in Google search results -->
<meta name="description" content="150-160 character description">

<!-- SEO: Keywords (less important now) -->
<meta name="keywords" content="keyword1, keyword2, keyword3">

<!-- Author information -->
<meta name="author" content="Your Name">

<!-- Refresh page every X seconds (use sparingly) -->
<meta http-equiv="refresh" content="30">

<!-- Social media preview (Open Graph) -->
<meta property="og:title" content="Page Title">
<meta property="og:description" content="Description">
<meta property="og:image" content="image.jpg">
```

**Viewport breakdown:**
- `width=device-width` - Use device's screen width
- `initial-scale=1.0` - No zoom on load
- Makes site mobile-friendly

**Security:**
Never put sensitive data (passwords, API keys) in meta tags — visible in page source!

## Activity 3: Title Best Practices

**Formula:** `Primary Keyword - Secondary | Brand`

**Examples:**
```html
<!-- Homepage -->
<title>Barangay Sto. Niño Official Website | Batangas City</title>

<!-- Service page -->
<title>Barangay Clearance Application | Barangay Sto. Niño</title>

<!-- Contact -->
<title>Contact Us - Office Hours & Location | Barangay Sto. Niño</title>
```

**Title appears in:**
1. Browser tab (truncated if too long)
2. Google search results (50-60 chars shown)
3. Bookmarks
4. Social media shares
5. Browser history

**SEO Impact:**
- Most important on-page SEO element
- Should include target keywords
- Unique for each page

## Activity 4: Character Encoding

**Without UTF-8:**
- Filipino characters might show as: `�` or `?`
- Special characters break: ñ, á, é, í, ó, ú
- Tagalog text displays incorrectly

**With UTF-8:**
- Supports all languages (Filipino, Chinese, Arabic, etc.)
- 1+ million characters available
- International standard

**Always include:** `<meta charset="UTF-8">` as first meta tag!

## Activity 5: Viewport Effects

**Without viewport:**
- Desktop layout forced onto mobile
- Text microscopic (requires zoom)
- Horizontal scrolling
- Poor user experience

**With viewport:**
- Content fits screen width
- Readable text size
- No horizontal scroll
- Foundation for responsive design

**Mobile stats in Philippines:**
- 75%+ access via mobile
- Slow connections (average 35 Mbps)
- Viewport meta tag is ESSENTIAL

## Activity 6: Favicon Implementation

**Favicon sizes:**
- 16x16px (browser tab)
- 32x32px (browser bar)
- 180x180px (Apple touch icon)
- 192x192px (Android home screen)

**Multiple formats:**
```html
<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
```

**Tools to create favicons:**
- favicon.io (online generator)
- Canva
- GIMP / Photoshop

**Philippine example:** Barangay seal or logo

## Activity 7: Complete Structure

**Validation Checklist:**
- [x] `<!DOCTYPE html>` first line
- [x] `<html lang="...">` with language
- [x] `<head>` with charset, viewport, title
- [x] `<body>` with semantic tags
- [x] All tags properly closed
- [x] Valid meta tags
- [x] No errors in W3C Validator

**Common Validation Errors:**
1. Missing DOCTYPE
2. Unclosed tags
3. Improper nesting
4. Duplicate IDs
5. Missing alt attributes on images

**Professional template:**
```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <!-- Character encoding FIRST -->
    <meta charset="UTF-8">
    
    <!-- Viewport for mobile -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- SEO -->
    <meta name="description" content="Your description here (150-160 chars)">
    <meta name="keywords" content="keyword1, keyword2, keyword3">
    <meta name="author" content="Your Name">
    
    <!-- Social media -->
    <meta property="og:title" content="Page Title">
    <meta property="og:description" content="Description">
    <meta property="og:image" content="image.jpg">
    <meta property="og:url" content="https://yoursite.com">
    
    <!-- Favicon -->
    <link rel="icon" href="favicon.ico">
    
    <!-- Title (50-60 chars) -->
    <title>Page Title | Brand Name</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Content here -->
</body>
</html>
```

</details>

---

**Perfect!** You've mastered HTML document structure with proper DOCTYPE, meta tags, and semantic organization. Your pages are now mobile-friendly and SEO-optimized!

**Next:** Tags, elements, and attributes!
