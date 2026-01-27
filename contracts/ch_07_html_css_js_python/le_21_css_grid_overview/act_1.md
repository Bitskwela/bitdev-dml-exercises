# Activity: The Grid Architect

In this activity, you will replace your complex nested Flexbox structures with a clean, 2-dimensional CSS Grid. You will architect the overall layout of the Sto. Niño Portal and build a dynamic service gallery that automatically adjusts to any number of items.

## Objectives
- Structure a full-page layout using `grid-template-areas`.
- Use the `fr` unit for fluid responsiveness.
- Build an auto-scaling gallery with `repeat()` and `auto-fit`.
- Redefine the page layout for mobile in under 5 lines of code.

---

### Task 1: Defining the Blueprint
Instead of wrapping every section in a container, we will define the layout on the `<main>` or `<body>` element.

**Action:** Identify your main sections and name them in the grid container.
```css
.portal-layout {
    display: grid;
    grid-template-columns: 25rem 1fr; /* Fixed sidebar, flexible content */
    grid-template-rows: auto 1fr auto; /* Header and Footer auto-size */
    grid-template-areas: 
        "nav nav"
        "sidebar content"
        "footer footer";
    min-height: 100vh;
}
```

---

### Task 2: Assigning Areas
Now, tell each HTML element which "room" it belongs to.

**Action:** Use the `grid-area` property on your main components.
```css
header { grid-area: nav; }
aside  { grid-area: sidebar; }
main   { grid-area: content; }
footer { grid-area: footer; }
```

---

### Task 3: The Smart Gallery (The Auto-Grid)
We want a section that shows all barangay services. Instead of manual widths, let the browser do the math.

**Action:** Use `repeat`, `auto-fit`, and `minmax` to create a smart grid.
```css
.services-grid {
    display: grid;
    /* "Keep adding columns that are at least 30rem wide, as long as they fit" */
    grid-template-columns: repeat(auto-fit, minmax(30rem, 1fr));
    gap: 3rem;
}
```
*Tip: This eliminates the need for most card-level media queries!*

---

### Task 4: The Responsive Shift
The sidebar layout won't work on mobile. We need to "stack" the blueprint.

**Action:** Update the grid areas in a media query.
```css
@media screen and (max-width: 768px) {
    .portal-layout {
        grid-template-columns: 1fr;
        grid-template-areas: 
            "nav"
            "content"
            "sidebar"
            "footer";
    }
}
```
*Observation: Notice how the Sidebar (aside) naturally moves below the content on mobile, purely by changing one word in the blueprint!*

---

## Submission Checklist
1. [ ] Is your site layout using `display: grid` on a main container?
2. [ ] Did you use `grid-template-areas` for the main structure?
3. [ ] Does the service gallery use the `auto-fit` and `minmax` pattern?
4. [ ] Does the layout rearrange itself correctly on mobile?

**Elite Tip:** Use **CSS Grid** for the "Outer Layout" (The skeleton) and **Flexbox** for the "Inner Layout" (The organs). For example, a card container is a Grid Item, but the content *inside* the card (icon + text) should be centered using Flexbox.
