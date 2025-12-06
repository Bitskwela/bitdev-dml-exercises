# HTML Document Structure Quiz

---

# Quiz 1

## Quiz: Understanding HTML Document Anatomy

**Scenario:**

Tian creates his first HTML page for a barangay clearance portal. Here's his code:

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Clearance Portal</title>
    <meta name="description" content="Apply for barangay clearance online">
</head>
<body>
    <h1>Barangay Sto. Niño Clearance System</h1>
    <p>Welcome to our online portal!</p>
</body>
</html>
```

**Question 1:** What is the purpose of `<!DOCTYPE html>`?

- A) Sets the webpage title
- B) Tells browser this is an HTML5 document
- C) Links to CSS file
- D) Creates a paragraph

**Answer: B**

`<!DOCTYPE html>` tells browsers to use HTML5 standards (modern rendering mode). Without it, browsers enter "quirks mode" (outdated behavior).

**Question 2:** What belongs inside the `<head>` section?

- A) Visible content like headings and paragraphs
- B) Metadata (title, charset, viewport)
- C) Only the title tag
- D) JavaScript code only

**Answer: B**

The `<head>` contains metadata invisible to users—title (tab text), charset (character support), viewport (responsive), description (SEO), CSS/JS links.

---

# Quiz 2

**Question 3:** What does `<meta charset="UTF-8">` do?

- A) Sets page width
- B) Supports international characters (ñ, é, ü)
- C) Links external files
- D) Creates responsive design

**Answer: B**

UTF-8 is universal character encoding supporting Filipino (ñ), Spanish (á, é), symbols (€, ™), emojis. Without it, special characters display as �.

**Question 4:** Why is `index.html` a special filename?

- A) Required by law
- B) Default homepage browsers load automatically
- C) Only for images
- D) No special meaning

**Answer: B**

Web servers automatically serve `index.html` when visiting root URL (`www.example.com` loads `index.html`). Other pages need explicit URLs.

**Question 5:** Where should visible content (text, images) be placed?

- A) `<head>` section
- B) `<body>` section
- C) Before `<!DOCTYPE>`
- D) Outside `<html>` tags

**Answer: B**

All visible content—headings, paragraphs, images, links, videos—goes in `<body>`. The `<head>` is for metadata (invisible), `<body>` is for content (visible).  

---

## Detailed Explanations

Q1 **DOCTYPE declaration:** `<!DOCTYPE html>` tells browsers to use HTML5 standards (modern rendering mode). Without it, browsers enter "quirks mode" (outdated behavior).

Q2 **`<head>` contents:** Metadata invisible to users—title (tab text), charset (character support), viewport (responsive), description (SEO), CSS/JS links.

Q3 **UTF-8 charset:** Universal character encoding supporting Filipino (ñ), Spanish (á, é), symbols (€, ™), emojis (😊). Without it, special characters display as �.

Q4 **index.html convention:** Web servers automatically serve `index.html` when visiting root URL (`www.example.com` loads `index.html`). Other pages need explicit URLs (`example.com/about.html`).

Q5 **`<body>` section:** All visible content—headings, paragraphs, images, links, videos. `<head>` = metadata (invisible), `<body>` = content (visible).

---

**Key Concepts:**
- **HTML5 Structure:** DOCTYPE → html → head + body
- **Separation:** Metadata (`<head>`) vs Content (`<body>`)
- **UTF-8:** Universal character support
- **Semantic Naming:** `index.html` = homepage convention
- **Validation:** Use W3C Validator to check correctness

**Next:** Lesson 7 (Tags, Elements, Attributes).