# Text Formatting Quiz

---

# Quiz 1

## Quiz: Headings and Structure

**Scenario:**

Tian creates a barangay services page:

```html
<h1>Barangay Sto. Niño Services</h1>

<h2>Document Services</h2>
<p>We offer the following documents:</p>
<ul>
    <li>Barangay Clearance</li>
    <li>Cedula</li>
    <li>Business Permit</li>
</ul>

<h2>How to Apply</h2>
<ol>
    <li>Visit office</li>
    <li>Submit requirements</li>
    <li>Pay fee</li>
</ol>
```

**Question 1:** How many `<h1>` tags should a page have?

- A) As many as you want
- B) Only one (main title)
- C) At least two
- D) None

**Answer: B**

A page should have only one `<h1>` tag for the main title. Multiple `<h1>` tags confuse search engines and screen readers. Use `<h2>` for sections, `<h3>` for sub-sections.

**Question 2:** What's wrong with this code?
```html
<h1>Title</h1>
<h4>Section</h4>
```

- A) Nothing
- B) Skipped h2 and h3 (bad hierarchy)
- C) Should use h6
- D) Missing closing tags

**Answer: B**

Don't skip heading levels. Proper hierarchy: h1→h2→h3→h4. Skipping levels (h1→h4) breaks semantic structure and accessibility.

---

# Quiz 2

**Question 3:** What's the difference between `<ul>` and `<ol>`?

- A) No difference
- B) `<ul>` = bullets, `<ol>` = numbers
- C) `<ul>` = numbers, `<ol>` = bullets
- D) Both create paragraphs

**Answer: B**

`<ul>` creates unordered lists with bullet points, `<ol>` creates ordered lists with numbers. Use `<ul>` for items without specific order, `<ol>` for steps/sequences.

**Question 4:** Which creates a line break **within** the same paragraph?

- A) `<p>`
- B) `<br>`
- C) `<hr>`
- D) `<li>`

**Answer: B**

`<br>` creates a line break within the same paragraph (no extra spacing). `<p>` creates a new paragraph with extra spacing.

**Question 5:** What does `<hr>` do?

- A) Creates heading
- B) Horizontal line separator
- C) Highlights text
- D) Line break

**Answer: B**

`<hr>` creates a horizontal line (thematic break) to separate sections. It's a self-closing tag.  

---

## Detailed Explanations

Q1 **One `<h1>` rule:** Main page title only. Sections use `<h2>`, sub-sections `<h3>`, etc. Multiple `<h1>` tags confuse search engines and screen readers.

Q2 **Heading hierarchy:** Don't skip levels. Proper: h1→h2→h3→h4. Wrong: h1→h4 (skips h2, h3). Breaks semantic structure and accessibility.

Q3 **List types:**
- **`<ul>`** (Unordered List) = Bullet points • ◦ ▪
- **`<ol>`** (Ordered List) = Numbers 1, 2, 3
- Use `<ul>` for items without specific order
- Use `<ol>` for steps/sequences

Q4 **Line break:** `<br>` creates line break within same paragraph (no extra spacing). `<p>` creates new paragraph (extra spacing). Use `<br>` sparingly (addresses, poetry).

Q5 **Horizontal rule:** `<hr>` creates horizontal line (thematic break). Useful for separating sections. Self-closing tag (no `</hr>`).

---

**Key Concepts:**
- **Hierarchy:** h1 (once) > h2 > h3 > h4 > h5 > h6
- **Lists:** `<ul>` bullets, `<ol>` numbers, `<dl>` definitions
- **Line breaks:** `<br>` (inline), `<p>` (block), `<hr>` (separator)
- **Semantic:** Use tags for meaning, not just appearance

**Next:** Lesson 9 (Links and Images).