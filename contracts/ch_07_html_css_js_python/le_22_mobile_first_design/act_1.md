# Activity: The Mobile-First Refactor

In this activity, you will perform a "Clean Sweep" of your CSS. You will delete your old desktop-first overrides and rebuild the Sto. Niño Portal using the Mobile-First methodology. This will result in cleaner code, better performance, and a perfect user experience for smartphone users.

## Objectives
- Remove all `max-width` media queries.
- Write "Base Styles" that target a 1-column mobile layout.
- Use `min-width` media queries to progressively enhance the site for Tablet and Desktop.
- Implement a fluid grid that expands as the screen grows.

---

### Task 1: The Clean Sweep
Before we build the right way, we must remove the "Architecture of the Past."

**Action:** Open `style.css` and move all your code **into a temporary backup file**. We will rebuild the core styles starting with mobile.

---

### Task 2: Base Styles (Mobile Default)
Your code outside of any media query should represent the mobile version.

**Action:** Write the base styles for a single-column experience.
```css
/* Base Styles: Mobile (< 768px) */
.container {
    width: 100%;
    padding: 0 2rem;
}

.services-grid {
    display: grid;
    grid-template-columns: 1fr; /* Single column for mobile */
    gap: 2rem;
}

.navbar ul {
    display: flex;
    flex-direction: column; /* Stacked menu for mobile */
    align-items: center;
}

.hero h1 {
    font-size: 2.4rem; /* Readable but compact */
}
```

---

### Task 3: Tablet Enhancement
Now, we add our first "Enhancement" for screens larger than 768px.

**Action:** Add a `min-width` query to introduce columns.
```css
/* Tablet Enhancement (>= 768px) */
@media screen and (max-width: 768px) {
    /* WAIT! Elite Coders use MIN-WIDTH for Mobile-First. */
}

/* Correct Elite Way: */
@media screen and (min-width: 768px) {
    .services-grid {
        grid-template-columns: repeat(2, 1fr); /* 2 columns for tablets */
    }

    .navbar ul {
        flex-direction: row; /* Horizontal menu for tablet/desktop */
    }
}
```

---

### Task 4: Desktop Expansion
Finally, we add the "Full Experience" for large screens.

**Action:** Add a breakpoint for desktops.
```css
/* Desktop Expansion (>= 1200px) */
@media screen and (min-width: 1200px) {
    .container {
        max-width: 114rem; /* 1140px fixed width for large screens */
        margin: 0 auto;
    }

    .services-grid {
        grid-template-columns: repeat(3, 1fr); /* 3 columns for desktop */
    }
}
```

---

### Task 5: The Card Detail Refactor
Let's see how `min-width` makes component styling easier.

**Action:** Style the cards using the enhancement model.
```css
.card {
    padding: 2rem;
    border: 1px solid #eee;
}

@media screen and (min-width: 768px) {
    .card {
        padding: 3rem; /* More breathing room on larger screens */
        box-shadow: 0 4px 12px rgba(0,0,0,0.05); /* Add shadow only for desktop */
    }
}
```

---

## Submission Checklist
1. [ ] Did you remove all `max-width` queries?
2. [ ] Is the code outside of media queries optimized for a single-column mobile view?
3. [ ] Did you use `min-width: 768px` for the tablet phase?
4. [ ] Did you use `min-width: 1200px` for the desktop phase?

**Elite Tip:** If you want to see if your site is truly mobile-first, load it on a slow 3G connection in DevTools. A mobile-first site will render the content and basic layout almost instantly, because it doesn't have to wait to parse and override complex desktop-only styles!
