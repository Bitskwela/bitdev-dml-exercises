# Tags, Elements, and Attributes Quiz

---

# Quiz 1

## Quiz: HTML Building Blocks

**Scenario:**

Tian creates a barangay official directory:

```html
<div id="officials" class="directory">
    <h2>Barangay Officials</h2>
    <p>
        <strong>Captain:</strong> 
        <span class="name">Maria Santos</span><br>
        <em>Term: 2022-2025</em>
    </p>
    <img src="captain.jpg" alt="Barangay Captain" width="200">
</div>
```

**Question 1:** In `<p>Content</p>`, what is the complete structure called?

- A) Tag
- B) Element (opening tag + content + closing tag)
- C) Attribute
- D) Value

**Answer: B**

An element is the complete structure: opening tag + content + closing tag. A tag is just the syntax (`<p>`, `</p>`), but the element is the whole package.

**Question 2:** Which of these is a self-closing tag?

- A) `<p>`
- B) `<div>`
- C) `<img>`
- D) `<strong>`

**Answer: C**

Self-closing tags like `<img>`, `<br>`, `<hr>`, `<input>`, `<meta>` don't need closing tags because they have no content inside. Regular tags like `<p>` and `<div>` require closing tags.

---

# Quiz 2

**Question 3:** What are `id="officials"` and `class="directory"`?

- A) Tags
- B) Attributes (extra information)
- C) Elements
- D) Content

**Answer: B**

Attributes provide extra information in the opening tag. Syntax: `attribute="value"`. Common attributes: `id` (unique), `class` (CSS), `src` (source), `href` (link), `alt` (alternate text).

**Question 4:** Which is a block-level element?

- A) `<span>`
- B) `<strong>`
- C) `<div>`
- D) `<em>`

**Answer: C**

Block-level elements take full width and start on a new line (`<div>`, `<p>`, `<h1>`, `<ul>`). Inline elements flow with text (`<span>`, `<strong>`, `<a>`, `<img>`).

**Question 5:** What's wrong with this code?
```html
<p>Text with <strong>bold and <em>italic</strong></em></p>
```

- A) Nothing wrong
- B) Incorrect nesting (tags overlap)
- C) Missing quotes
- D) Self-closing issue

**Answer: B**

Nesting rule: Last opened, first closed. The tags overlap incorrectly. Correct: `<strong><em>...</em></strong>` (properly nested).  

---

## Detailed Explanations

Q1 **Element definition:** Complete structure = opening tag + content + closing tag. **Tag** = just the syntax (`<p>`, `</p>`). **Element** = the whole package.

Q2 **Self-closing tags:** `<img>`, `<br>`, `<hr>`, `<input>`, `<meta>` don't need closing tags (no content inside). Regular tags (`<p>`, `<div>`) require `</p>`, `</div>`.

Q3 **Attributes:** Extra information in opening tag. Syntax: `attribute="value"`. Common: `id` (unique), `class` (CSS), `src` (source), `href` (link), `alt` (alternate text).

Q4 **Block vs Inline:**
- **Block:** Full width, new line (`<div>`, `<p>`, `<h1>`, `<ul>`)
- **Inline:** Flows with text (`<span>`, `<strong>`, `<a>`, `<img>`)

Q5 **Nesting rule:** Last opened, first closed. 
**Wrong:** `<strong>...<em>...</strong></em>` (overlap)  
**Correct:** `<strong><em>...</em></strong>` (nested properly)

---

**Key Concepts:**
- **Tag:** Syntax only (`<tagname>`)
- **Element:** Tag + content + closing
- **Attribute:** `name="value"` in opening tag
- **Global attributes:** `id`, `class`, `style`, `title`
- **Block/Inline:** Display behavior
- **Semantic:** Meaningful tags (`<article>` > `<div>`)

**Next:** Lesson 8 (Text Formatting).