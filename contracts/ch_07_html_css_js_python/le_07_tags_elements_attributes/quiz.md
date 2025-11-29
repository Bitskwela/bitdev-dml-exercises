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

**Question 2:** Which of these is a self-closing tag?

- A) `<p>`
- B) `<div>`
- C) `<img>`
- D) `<strong>`

---

# Quiz 2

**Question 3:** What are `id="officials"` and `class="directory"`?

- A) Tags
- B) Attributes (extra information)
- C) Elements
- D) Content

**Question 4:** Which is a block-level element?

- A) `<span>`
- B) `<strong>`
- C) `<div>`
- D) `<em>`

**Question 5:** What's wrong with this code?
```html
<p>Text with <strong>bold and <em>italic</strong></em></p>
```

- A) Nothing wrong
- B) Incorrect nesting (tags overlap)
- C) Missing quotes
- D) Self-closing issue

---

## Answers
1: B  
2: C  
3: B  
4: C  
5: B  

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