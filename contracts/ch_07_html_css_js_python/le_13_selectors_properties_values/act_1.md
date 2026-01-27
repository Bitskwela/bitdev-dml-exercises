# Activity 13: The Selector Strike - Precision Targeting for the Portal

## The Mission
Your mission is to upgrade the **Barangay Sto. Niño Portal** with surgical styling. You will move away from generic "one-size-fits-all" rules and implement a sophisticated targeting system using IDs, Classes, Descendants, and Pseudo-selectors.

---

### Task 1: The Global Canvas (Element Selectors)
Start by defining the "Base Logic" of your portal. This ensures every element has a standard, professional look before we get specific.

**Action:** Wrap your portal in a `main` tag and define global defaults for fonts and spacing in a `<style>` block.

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Sto. Niño | Precision Portal</title>
    <style>
        /* BASE LOGIC */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f2f5;
            color: #1c1e21;
            margin: 0;
            padding: 20px;
        }

        h1, h2, h3 {
            color: #004d40;
            margin-bottom: 1rem;
        }

        p {
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <main>
        <h1>Barangay Sto. Niño</h1>
        <p>Your official community dashboard.</p>
    </main>
</body>
</html>
```

---

### Task 2: Component Architecture (Class Selectors)
Elite Coders build "Components," not just tags. Let's create a **Service Card** component that we can reuse multiple times.

**Action:** Add three service cards with the same class.

```html
<!-- Inside <main> -->
<section class="service-grid">
    <div class="service-card">
        <h3>Clearance</h3>
        <p>Rapid processing for employment.</p>
    </div>
    <div class="service-card">
        <h3>Health</h3>
        <p>Schedule your checkup online.</p>
    </div>
    <div class="service-card">
        <h3>Business</h3>
        <p>Permit registration system.</p>
    </div>
</section>
```

**New CSS Rules:**
```css
.service-card {
    background: white;
    padding: 2rem;
    border-radius: 12px;
    border: 1px solid #ddd;
    margin-bottom: 1rem;
}

.service-card h3 {
    margin-top: 0;
    color: #2c3e50;
}
```

---

### Task 3: The "Unique Target" (ID Selector)
Some things only happen once. The **Emergency Alert** needs a unique identifier so it can be styled independently of other cards.

**Action:** Add an ID to the first service card to mark it as high priority.

```html
<div class="service-card" id="emergency-alert">
    <h3>Emergency Response</h3>
    <p>24/7 rescue and fire assistance.</p>
</div>
```

**New CSS Rule:**
```css
#emergency-alert {
    background-color: #fff1f0;
    border: 2px solid #ff4d4f;
}

#emergency-alert h3 {
    color: #cf1322;
}
```

---

### Task 4: Relationship Management (Descendant Combinators)
Instead of adding classes to every single paragraph, target them based on where they live.

**Action:** Create a footer and style its links and text using a descendant selector.

```html
<footer>
    <p>Contact us: <a href="mailto:brgy@email.com">Email Us</a></p>
</footer>
```

**New CSS Rules:**
```css
footer p {
    font-size: 0.9rem;
    color: #606770;
    text-align: center;
    border-top: 1px solid #ddd;
    margin-top: 3rem;
    padding-top: 1rem;
}

footer a {
    color: #004d40;
    font-weight: bold;
    text-decoration: none;
}
```

---

### Task 5: The Interaction Layer (Pseudo-Classes)
Websites should feel "alive." We use pseudo-classes to provide instant feedback when a user interacts with an element.

**Action:** Add a hover effect to your service cards and footer links.

```css
.service-card:hover {
    border-color: #004d40;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    cursor: pointer;
}

footer a:hover {
    text-decoration: underline;
    color: #00695c;
}
```

---

### Task 6: Strategic Content Injection (Pseudo-Elements)
Sometimes you want to add visual hints (like icons) without touching the HTML.

**Action:** Use `::before` to add a "NEW" badge to the Health card.

```html
<!-- Update the Health card -->
<div class="service-card new-feature">
    <h3>Health</h3>
    <p>Schedule your checkup online.</p>
</div>
```

**New CSS Rule:**
```css
.new-feature h3::after {
    content: " NEW";
    font-size: 0.7rem;
    background: #52c41a;
    color: white;
    padding: 2px 6px;
    border-radius: 4px;
    vertical-align: middle;
    margin-left: 10px;
}
```

---

### Task 7: The Specificity Battle (Challenge)
Try to change the color of the text in `#emergency-alert` using a generic `p` selector at the bottom of your CSS.

**Question:** Does it work?
**Elite Answer:** No, because the ID selector has a specificity of 100, while the `p` selector only has 1. To override it, you MUST use the ID again or a more specific combined selector like `#emergency-alert p`.

---

### Final Check: The Precision Portal
Your code now should feature:
1.  **Context-Aware Styling:** Using descendants instead of class bloat.
2.  **State-Based Feedback:** Hover effects that guide the user.
3.  **Unique Identifiers:** IDs used for critical, one-off elements.
4.  **Logical Architecture:** A clear separation between global styles and component styles.
