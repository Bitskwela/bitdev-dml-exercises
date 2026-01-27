# Activity 12: Engineering the Barangay Portal’s Visual Identity

## The Mission
You have the structure. Now, you need the **Visual Identity**. In this activity, you will evolve the Barangay Sto. Niño portal from a plain text document into a professional, high-performance interface using various CSS linking methods and organizational patterns.

---

### Task 1: Building the Semantic Framework
Before styling, we need a high-quality semantic structure. Create the foundation for the Barangay Portal.

**Action:** Create a new file (or update your current one) with the following semantic structure.

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Sto. Niño | Official Portal</title>
</head>
<body>
    <header>
        <h1>Barangay Sto. Niño</h1>
        <p>Official Digital Portal</p>
    </header>

    <main>
        <section id="hero">
            <h2>Public Safety & Community Service</h2>
            <p>Providing 24/7 assistance to all residents of Sto. Niño.</p>
        </section>

        <section id="services">
            <h3>Our Services</h3>
            <ul>
                <li>Barangay Clearance</li>
                <li>Business Permits</li>
                <li>Health Center Appointments</li>
            </ul>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 Barangay Sto. Niño. All Rights Reserved.</p>
    </footer>
</body>
</html>
```

---

### Task 2: Injecting "Hotfix" Styles (Inline CSS)
An Elite Coder knows that **Inline CSS** should be avoided for general styling, but it's perfect for "Quick Hacks" or highlighting specific elements. Let's make the primary heading stand out immediately.

**Action:** Add the `style` attribute to the `<h1>` tag inside the `<header>`.

```html
<!-- Inside Task 1 code -->
<header>
    <h1 style="color: #004d40; font-size: 3rem; text-transform: uppercase; font-family: sans-serif;">
        Barangay Sto. Niño
    </h1>
    <p>Official Digital Portal</p>
</header>
```

---

### Task 3: The Single-Page Style Engine (Internal CSS)
Instead of cluttering every tag with `style` attributes, we move the style logic to the `<head>`. This is called **Internal CSS**.

**Action:** Remove the inline style from Task 2 and add a `<style>` block in the `<head>` section to style the entire page.

```html
<head>
    <meta charset="UTF-8">
    <title>Barangay Sto. Niño | Official Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f4f4f4;
            margin: 0;
        }

        header {
            background-color: #004d40; /* Navy Green */
            color: white;
            padding: 2rem;
            text-align: center;
        }

        main {
            padding: 2rem;
            max-width: 800px;
            margin: 0 auto;
        }
    </style>
</head>
```

---

### Task 4: Engineering Components (Class Selectors)
Elite Coders don't style generic tags like `section` directly if they want specific behaviors. We use **Classes** to create reusable "Components."

**Action:** Add a `card` class to your services list and style it in the `<style>` block.

**Updated HTML Snippet:**
```html
<section id="services" class="card">
    <h3>Our Services</h3>
    <ul>
        <li>Barangay Clearance</li>
        <li>Business Permits</li>
        <li>Health Center Appointments</li>
    </ul>
</section>
```

**New CSS Rules (Add to <style>):**
```css
.card {
    background: white;
    padding: 1.5rem;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    margin-top: 2rem;
}

.card h3 {
    color: #004d40;
    border-bottom: 2px solid #e0e0e0;
    padding-bottom: 0.5rem;
}
```

---

### Task 5: Mastering the Cascade (The Specificity Battle)
The "Cascade" is where most juniors fail. Let's see it in action. We want to override the `header` color for a "Special Event" mode using the priority rules.

**Action:** Add a high-priority "Special" class to the header, and try to override it with an inline style to see who wins.

```html
<!-- The "Cascade" Battle -->
<header class="special-event" style="background-color: darkred;">
    <h1>Barangay Sto. Niño</h1>
    <p>Celebrating the 70th Founding Anniversary!</p>
</header>
```

**Observation:** Notice that even if you have `header { background-color: #004d40; }` in your CSS block, the **Inline Style** (`darkred`) wins because it is closer to the element.

---

### Task 6: The Professional "Global Reset"
Browsers (Chrome, Firefox, Safari) have different default spacing. Elite Coders use a **Reset** to ensure their design looks the same everywhere.

**Action:** Add this "Elite Reset" to the very top of your `<style>` block.

```css
<style>
    /* THE ELITE RESET */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box; /* Crucial for professional layouts */
    }

    /* Rest of your styles follow... */
</style>
```

---

### Final Check: The Product
Your code should now feature:
1.  **Strategic Reset:** Standardizing margins/padding.
2.  **Internal Architecting:** Centralized styles in the `<head>`.
3.  **Component Thinking:** Reusable classes like `.card`.
4.  **Separation of Concerns:** (Mostly) keeping the HTML structure clean of visual styling.

**Elite Challenge:** Once you're done, try moving all your CSS into a file named `portal.css` and link it using `<link rel="stylesheet" href="portal.css">`. This is how you build for the real world.
