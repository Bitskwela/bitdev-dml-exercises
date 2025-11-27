# Links and Images Quiz

---

# Quiz 1

## Quiz: Links and Navigation

**Scenario:**

Tian creates navigation for barangay website:

```html
<nav>
    <a href="index.html">Home</a>
    <a href="services.html">Services</a>
    <a href="#contact">Contact</a>
    <a href="https://facebook.com/barangay" target="_blank">Facebook</a>
    <a href="mailto:barangay@gmail.com">Email Us</a>
</nav>

<h2 id="contact">Contact Information</h2>
<img src="images/office.jpg" alt="Barangay office exterior" width="400">
```

**Question 1:** What does `href` stand for?

- A) Hyperlink Reference
- B) HTTP Reference
- C) Home Reference
- D) Header Reference

**Question 2:** What does `<a href="#contact">` do?

- A) Links to external site
- B) Jumps to element with id="contact" on same page
- C) Opens email
- D) Downloads file

---

# Quiz 2

**Question 3:** What does `target="_blank"` do?

- A) Closes tab
- B) Opens link in new tab/window
- C) Downloads file
- D) Refreshes page

**Question 4:** Why is the `alt` attribute critical for images?

- A) Makes image bigger
- B) Accessibility, SEO, fallback text if image fails
- C) Optional decoration
- D) Changes image color

**Question 5:** Which image format supports transparent backgrounds?

- A) JPG
- B) PNG
- C) BMP
- D) TXT

---

## Answers
1: A  
2: B  
3: B  
4: B  
5: B  

---

## Detailed Explanations

Q1 **href = Hyperlink Reference:** Specifies link destination (URL, file, email, phone, anchor). Required attribute for `<a>` tag.

Q2 **Anchor links:** `href="#id"` jumps to element with matching `id` attribute on same page. Useful for "Back to Top", table of contents, long-form content navigation.

**Example:**
```html
<a href="#section2">Jump to Section 2</a>
...
<h2 id="section2">Section 2</h2>
```

Q3 **target="_blank":** Opens link in new tab/window (keeps original page open). Best practice for external links. Without it, link replaces current page.

**Security note:** Add `rel="noopener noreferrer"` for external links:
```html
<a href="https://example.com" target="_blank" rel="noopener">Link</a>
```

Q4 **alt attribute importance:**
1. **Accessibility:** Screen readers describe images to blind users
2. **SEO:** Google indexes alt text for image search
3. **Fallback:** Shows text if image fails to load (slow connection, broken link)
4. **Context:** Helps users understand image purpose

**Good alt:** `alt="Barangay Captain Maria Santos speaking at town hall meeting"`  
**Bad alt:** `alt="image"` or `alt=""`

Q5 **Image formats:**
- **PNG:** Transparent backgrounds, lossless, larger file size (logos, icons)
- **JPG:** No transparency, lossy, smaller file size (photos)
- **GIF:** Limited transparency, 256 colors (simple animations)
- **SVG:** Vector (scalable), transparent, XML-based (icons, illustrations)

---

**Key Concepts:**
- **Links:** `<a href="destination">text</a>`
- **Anchor:** `href="#id"` jumps to section
- **New tab:** `target="_blank"`
- **Images:** `<img src="file" alt="description">`
- **Alt text:** Required for accessibility/SEO
- **Formats:** PNG (transparency), JPG (photos)

**Next:** Lesson 10 (Tables, Forms, Inputs).