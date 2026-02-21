# Activity: Architecting the Sto. Niño Portal

In this activity, you will transform the "suffocating" layout of the Barangay Sto. Niño Portal into a professional, spacious interface. You will learn to control the invisible boundaries of your elements.

## Objectives
- Apply the `border-box` reset to prevent layout calculation errors.
- Use `padding` to create internal breathing room in cards.
- Use `margin` and `margin: auto` to manage spacing and centering.
- Implement `border-radius` for a modern, friendly UI.

---

### Task 1: The Global Reset
Elite Coders never use the default browser math. Your first move in any project is to fix how the browser calculates box sizes.

**Action:** At the top of your `style.css`, add the universal selector with `box-sizing`.
```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
```
*Why? This removes the browser's default messy margins and ensures that padding doesn't "break" your element widths.*

---

### Task 2: Engineering Internal Space (Padding)
The navigation and cards currently look cramped because the text is touching the edges.

**Action:** Add padding to your `.navbar` and `.card` classes.
```css
.navbar {
    padding: 1rem 2rem; /* 1rem top/bottom, 2rem left/right */
}

.card {
    padding: 1.5rem; /* Even padding on all sides */
}
```
*Observe how the "background" of the card expands to accommodate the new space.*

---

### Task 3: Defining Boundaries (Borders & Radius)
Let's make the cards look like physical objects.

**Action:** Update your `.card` class with a subtle border and rounded corners.
```css
.card {
    padding: 1.5rem;
    border: 1px solid #e0e0e0; /* A soft, light gray boundary */
    border-radius: 12px;       /* Modern, friendly corners */
}
```

---

### Task 4: Mastering Proximity (Margins)
Currently, your cards are probably touching each other. We need to push them apart.

**Action:** Use margins to create space between your sections and around your cards.
```css
section {
    margin-bottom: 3rem; /* Space between big sections */
}

.card {
    margin: 10px; /* Space around each card */
}
```

---

### Task 5: The Centering Pattern
If your portal looks stretched across the whole screen, it's hard to read. We need a "Container" that stays in the middle.

**Action:** Wrap your main content in a `<div class="container">` in HTML, then add this to CSS:
```css
.container {
    max-width: 1100px;
    margin: 0 auto; /* Top/Bottom: 0, Left/Right: Auto (Centers the box!) */
    padding: 0 20px; /* Safety padding for mobile screens */
}
```

---

### Task 6: The Elite Polish (Box-Shadow)
To make your cards "pop" off the page, use a subtle shadow.

**Action:** Add a soft shadow to your `.card`.
```css
.card {
    /* ...existing styles... */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
```

---

## Submission Checklist
1. [ ] Does your site have a `*` reset at the top?
2. [ ] Is there visible "breathing room" (padding) inside your white cards?
3. [ ] Are the card corners rounded (`border-radius`)?
4. [ ] Is the main content centered on the screen using `margin: auto`?
5. [ ] Do your sections have enough margin to be distinct from one another?

**Elite Tip:** Open DevTools, hover over a card, and look at the colors (Orange = Margin, Yellow = Border, Green = Padding, Blue = Content). Use this to debug your architecture!
