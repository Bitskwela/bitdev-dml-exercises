# Activity: Manipulating the Flow

In this activity, you will use the `display` property to force HTML elements to behave in ways they weren't born to. You will fix the navigation menu and create custom sized status badges for the Sto. Niño Portal.

## Objectives
- Convert vertical list items into a horizontal navigation bar.
- Transform `span` elements into sizable badges.
- Use `display: none` to simulate a toggleable UI state.

---

### Task 1: The Horizontal Navbar
By default, `<li>` (List Item) elements are `display: block`, which makes them stack vertically. We want them in a row.

**Action:** Target the nav items in your CSS and change their display type.
```css
/* In your Navbar section */
nav ul li {
    display: inline-block;
    margin-right: 20px;
    font-weight: 500;
}
```

---

### Task 2: Engineering Sizable Badges
You want to show a "NEW" badge next to the "Online Clearance" service. Spans won't let you set a specific width.

**Action:** Create a `.badge` class and override the default inline behavior.
```css
.badge {
    display: inline-block;
    width: 60px;
    height: 24px;
    line-height: 24px; /* Centers text vertically */
    text-align: center;
    background-color: var(--accent-color);
    color: white;
    font-size: 0.7rem;
    border-radius: 4px;
    margin-left: 10px;
}
```

---

### Task 3: The Service Grid (Manual)
Before we use Flexbox, let's see how `inline-block` can create a grid of cards.

**Action:** Update your `.card` class to sit side-by-side. 
```css
.card {
    display: inline-block;
    width: 30%; /* Three cards per row */
    vertical-align: top; /* Ensures they align at the top if content heights differ */
    margin: 1%;
}
```
*Note: If you use 33.3%, they might wrap to the next line because of the whitespace gap between inline-block elements!*

---

### Task 4: The Hidden Alert
We want to prepare an "Emergency Alert" banner that remains hidden until the Barangay Captain "activates" it.

**Action:** Create an emergency banner and hide it.
```html
<!-- In your HTML -->
<div class="emergency-banner">
    ⚠️ WATER INTERRUPTION LATER AT 2:00 PM
</div>
```

```css
/* In your CSS */
.emergency-banner {
    display: none; /* It exists in the code, but it is gone from the screen */
    background-color: #ff4444;
    color: white;
    padding: 1rem;
    text-align: center;
}
```
*Exercise: Change `display: none` to `display: block` in DevTools to see the alert reappear.*

---

## Submission Checklist
1. [ ] Is the navigation list horizontal now?
2. [ ] Do the badges have a specific `width` and `height`?
3. [ ] Are the service cards sitting side-by-side using `inline-block`?
4. [ ] Is the emergency banner hidden from the initial view?

**Elite Tip:** When using `inline-block`, if your boxes aren't lining up perfectly, check the `vertical-align` property. Setting it to `top` usually fixes the "uneven content" height issue.
