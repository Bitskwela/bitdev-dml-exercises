# Activity: Flexible Layouts

In this activity, you will modernize the Sto. Niño Portal by replacing your fragile `inline-block` hacks with the robust Flexbox system. You will achieve "Perfect Centering" and create a clean, evenly spaced grid of service cards.

## Objectives
- Convert the navigation list into a flex container.
- Use `justify-content` and `align-items` to center hero text.
- Build an auto-spacing card grid.
- Ensure cards wrap correctly on smaller screens.

---

### Task 1: The Modern Flex Navbar
Elite Coders don't use `inline-block` and manual margins for navigation. We use the parent to control the space.

**Action:** Update your `nav ul` to be a flex container.
```css
nav ul {
    display: flex;
    justify-content: flex-end; /* Push menu items to the right */
    gap: 30px;                 /* Perfect 30px between minden element */
    list-style: none;          /* Clean up list bullets */
}
```

---

### Task 2: The Perfect Centering (Hero Section)
You want the "Welcome to Sto. Niño" heading and description to be perfectly centered in the middle of a large image banner.

**Action:** Turn your hero section into a flex-centering engine.
```css
.hero {
    height: 400px;
    display: flex;
    flex-direction: column;    /* Stack text vertically */
    justify-content: center;   /* Center vertically */
    align-items: center;       /* Center horizontally */
    text-align: center;
    background-color: var(--primary-color);
    color: white;
}
```

---

### Task 3: The Card Row (Distribution)
We want our three service cards to span the full width of the container with equal space between them.

**Action:** Update the parent container of your cards.
```css
.services-container {
    display: flex;
    justify-content: space-between; /* Maximum space between cards */
    flex-wrap: wrap;                /* Allow cards to move to next line if no space */
    gap: 20px;
}

.card {
    flex: 1;           /* Make all cards grow to fill the row equally */
    min-width: 300px;  /* But never let them get smaller than 300px */
}
```

---

### Task 4: The Profile Component
Many UI components (like a user profile) have an avatar image on the left and text on the right. This is a classic Flexbox use case.

**Action:** Create a profile section in your navbar or footer.
```html
<div class="profile">
    <div class="avatar"></div>
    <div class="user-info">
        <span class="user-name">Tian Dev</span>
        <span class="user-role">Resident Level 5</span>
    </div>
</div>
```

```css
.profile {
    display: flex;
    align-items: center; /* Vertically align image and text */
    gap: 15px;
}

.avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #ddd;
}
```

---

## Submission Checklist
1. [ ] Is the navigation list horizontal using `display: flex`?
2. [ ] Is the Hero text perfectly centered in its box?
3. [ ] Are the cards using `justify-content: space-between` or `gap`?
4. [ ] Do cards wrap to a new line when you shrink the browser window?

**Elite Tip:** If things aren't centering vertically, make sure the Flex Container has a defined `height`. You can't center something in the middle of a box that is only as tall as its content!
