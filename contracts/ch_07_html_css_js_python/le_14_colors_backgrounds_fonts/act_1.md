# Activity 14: The Aesthetic Engine - Branding the Portal

## The Mission
Your mission is to transform the sterile, gray interface of the Barangay Sto. Niño portal into a professional, high-trust digital agency. You will implement a design system using Root Variables, custom typography, and advanced background layering.

---

### Task 1: The Design System (Root Variables)
Elite Coders never use naked hex codes. They create a "Central Source of Truth."

**Action:** Define your brand palette in the `:root` selector at the very top of your CSS.

```css
<style>
    :root {
        --brand-primary: #004d40;    /* Navy Green */
        --brand-accent: #ffc107;     /* Gold */
        --brand-danger: #d32f2f;     /* Alert Red */
        --surface-light: #f8f9fa;   /* Clean Background */
        --text-main: #2d3436;       /* Soft Black */
        --text-muted: #636e72;      /* Professional Gray */
    }

    body {
        background-color: var(--surface-light);
        color: var(--text-main);
    }
</style>
```

---

### Task 2: Typography Architecture (Google Fonts)
Standard fonts are for documents. Custom fonts are for products.

**Action:** Import and apply **Poppins** (for Headings) and **Inter** (for Body Text).

```html
<head>
    <!-- Task 1 meta/title tags here -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
    
    <style>
        /* Update your Task 1 styles */
        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
        }

        h1, h2, h3 {
            font-family: 'Poppins', sans-serif;
            color: var(--brand-primary);
            letter-spacing: -0.02em;
        }
    </style>
</head>
```

---

### Task 3: The Hero Background (Gradients & Depth)
Gradients create a sense of light and premium quality.

**Action:** Create a Hero header with a linear gradient and centered text.

```html
<!-- Inside <body> -->
<header class="hero">
    <h1>Barangay Sto. Niño</h1>
    <p class="tagline">Official Digital Governance Portal</p>
</header>
```

**New CSS Rules:**
```css
.hero {
    background: linear-gradient(135deg, var(--brand-primary), #00695c);
    color: white;
    padding: 4rem 2rem;
    text-align: center;
    border-bottom: 5px solid var(--brand-accent);
}

.hero h1 {
    color: white; /* Override global h1 color */
    font-size: 3rem;
    margin: 0;
}

.tagline {
    font-size: 1.2rem;
    opacity: 0.9;
    font-weight: 500;
}
```

---

### Task 4: Contextual UI Colors (Alerts & Badges)
Use color to imply meaning without the user having to read a single word.

**Action:** Create an "Emergency" component using `rgba()` for the background to create a "Soft Alert" look.

```html
<section class="alert-box">
    <h3>Flood Warning</h3>
    <p>Please monitor water levels near the river area.</p>
</section>
```

**New CSS Rules:**
```css
.alert-box {
    background-color: rgba(211, 47, 47, 0.1); /* Soft Red */
    border-left: 5px solid var(--brand-danger);
    padding: 1.5rem;
    border-radius: 8px;
    margin: 2rem 0;
}

.alert-box h3 {
    color: var(--brand-danger);
    margin: 0;
}
```

---

### Task 5: Interactive Depth (Shadows & States)
Backgrounds aren't just for containers. We can use `box-shadow` to create physical "layers."

**Action:** Style a service link to behave like a physical button.

```html
<a href="#" class="cta-button">Apply for Clearance</a>
```

**New CSS Rules:**
```css
.cta-button {
    display: inline-block;
    background-color: var(--brand-primary);
    color: white;
    padding: 1rem 2rem;
    text-decoration: none;
    border-radius: 50px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.cta-button:hover {
    background-color: #00695c;
    box-shadow: 0 6px 15px rgba(0,0,0,0.2);
    transform: translateY(-2px);
}
```

---

### Task 6: Visual Hierarchy Checklist
1.  **Brand Consistency:** Are you using `var(--brand-primary)` everywhere?
2.  **Readability:** Is the `line-height` set to `1.6` for the body?
3.  **Typography Contrast:** Did you use the bold **Poppins** for headers and clean **Inter** for descriptions?
4.  **Polish:** Does the site have a 5px accent border on the hero?

**Elite Challenge:** Try adding a background image of a map or a city hall to the `.hero` but keep it at `0.2` opacity using a linear-gradient overlay so the text remains readable.
