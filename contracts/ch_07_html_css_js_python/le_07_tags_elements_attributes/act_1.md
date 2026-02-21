# Activity: Engineering the Barangay Digital Hub

In this activity, you will use tags, elements, and attributes to structure the content of the **Barangay Sto. Niño Digital Hub**. You will move beyond plain text and start using semantic containers.

---

## Task 1: The Primary Heading
Professional pages need a single, clear `<h1>` that defines the entire page.

**Action:** Add an `<h1>` tag with the text "Barangay Sto. Niño Digital Hub" inside the `<body>`.
```html
<h1>Barangay Sto. Niño Digital Hub</h1>
```

---

## Task 2: Sub-sections for Organization
Use an `<h2>` to define the "Available Services" section. This creates a logical hierarchy for the browser.

**Action:** Add an `<h2>` tag below the `<h1>`.
```html
<h2>Available Services</h2>
```

---

## Task 3: Narrative Text
Standard information should always live inside paragraph tags.

**Action:** Add a `<p>` tag describing the services: "Our office provides essential documents for residents."
```html
<p>Our office provides essential documents for residents.</p>
```

---

## Task 4: Semantic Emphasis
Highlight the most important word in your paragraph. Don't just make it bold; give it *meaning*.

**Action:** Wrap the word "essential" in a `<strong>` tag inside your paragraph.
```html
<p>Our office provides <strong>essential</strong> documents for residents.</p>
```

---

## Task 5: The "Division" Container
In elite development, we group related elements using `<div>`. This allows us to treat a section as a single unit. Use an `id` attribute to give it a unique name.

**Action:** Wrap the `<h2>` and `<p>` you just created inside a `<div>` with the attribute `id="services-section"`.
```html
<div id="services-section">
  <h2>Available Services</h2>
  <p>Our office provides <strong>essential</strong> documents for residents.</p>
</div>
```

---

## Task 6: External Connectivity (Attributes)
A hub is useless if it doesn't connect. Create a link to the official government portal using the `href` attribute.

**Action:** Add an `<a>` tag with the text "Gov.ph Portal" and the attribute `href="https://gov.ph"`.
```html
<a href="https://gov.ph">Gov.ph Portal</a>
```

---

## Task 7: Visual Verification (Images)
Add a placeholder image for the Barangay Seal. Remember the `alt` attribute—it’s the hallmark of a developer who cares about accessibility.

**Action:** Add an `<img>` tag with the attributes `src="https://via.placeholder.com/150"` and `alt="Barangay Sto. Niño Seal"`.
```html
<img src="https://via.placeholder.com/150" alt="Barangay Sto. Niño Seal">
```

---

### Elite Developer Checklist:
- [ ] Do all your opening tags have matching closing tags? (Except `img`)
- [ ] Is your `id` attribute inside the opening `<div>` tag?
- [ ] Did you use `<strong>` for focus instead of just `<b>`?
- [ ] Are your tags properly nested (indented)?
