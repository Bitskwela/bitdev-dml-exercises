# Activity: The Responsive Overhaul

In this activity, you will make the Sto. Niño Portal fully compatible with mobile devices. You will use media queries to restructure your layout and ensure every resident can use the portal, regardless of their screen size.

## Objectives
- Implement the Viewport meta tag.
- Use media queries to stack desktop columns into a mobile-friendly list.
- Adjust typography and spacing for smaller screens.
- Hide non-critical desktop components on mobile to save space.

---

### Task 1: The Viewport Audit
Without this tag, media queries will not work correctly on actual mobile devices.

**Action:** Open your `index.html` and ensure the following tag is inside the `<head>`:
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

---

### Task 2: The Collapsing Grid (Tablet Breakpoint)
When the screen gets smaller (like an iPad), the three-column service grid starts to feel cramped. Let's switch it to two columns first.

**Action:** Add a media query to your `style.css`.
```css
@media screen and (max-width: 992px) {
    .card {
        flex: 1 1 45%; /* Two cards per row with a bit of gap */
    }
}
```

---

### Task 3: The Mobile Stack (Mobile Breakpoint)
On a phone, everything should be a single column for the best scrolling experience.

**Action:** Add a mobile-specific media query.
```css
@media screen and (max-width: 600px) {
    /* Stack the Cards */
    .services-container {
        flex-direction: column;
    }

    .card {
        width: 100%;
        margin: 10px 0;
    }

    /* Adjust the Hero Text */
    .hero h1 {
        font-size: 1.8rem; /* Shrink title slightly */
    }

    /* Stack the Navbar */
    nav ul {
        flex-direction: column;
        align-items: center;
        gap: 10px;
        padding: 10px 0;
    }
}
```

---

### Task 4: Content Prioritization
On mobile, screen real estate is expensive. We should hide decorative images or large banners that don't add functional value.

**Action:** Hide a decorative element on small screens.
```css
@media screen and (max-width: 600px) {
    .hero-image {
        display: none; /* Hide large hero image to focus on the text/actions */
    }
    
    .container {
        padding: 0 15px; /* Add safety padding on the sides */
    }
}
```

---

### Task 5: Testing with DevTools
The most important part of responsive design is testing.

**Action:**
1. Open your browser's **DevTools** (F12).
2. Click the **Device Toggle** icon (looks like a phone and tablet).
3. Select "iPhone SE" or "Pixel 7" from the dropdown.
4. Watch how your code from Task 3 and 4 transforms the layout!

---

## Submission Checklist
1. [ ] Does your HTML have the `viewport` meta tag?
2. [ ] Do the service cards stack vertically on small screens?
3. [ ] Does the navigation menu stack or center correctly on mobile?
4. [ ] Did you test at least two different device sizes in DevTools?

**Elite Tip:** Use **Relative Units** (`rem`, `em`, `%`) everywhere. If you use fixed `px` for widths or font sizes, you'll spend all day writing media queries to fix them.
