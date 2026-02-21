# Activity: Precision Positioning

In this activity, you will break the Sto. Niño Portal out of the normal document flow. You will anchor elements to the screen, overlap components, and manage the 3rd dimension of your UI.

## Objectives
- Create a header that follows the user during scrolling.
- Place an "Urgent" badge perfectly in the corner of a card.
- Build a persistent "Back to Top" button.
- Resolve layering issues using `z-index`.

---

### Task 1: The Persistent Header
Professional portals never leave the user without a way back.

**Action:** Update your `.navbar` (or header) to stay at the top.
```css
header {
    position: sticky;
    top: 0;
    background-color: white;
    z-index: 100; /* Ensure it stays above other content */
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
```
*Tip: For this to work, ensure no parent element has `overflow: hidden`.*

---

### Task 2: The Absolute Sniper (Badges)
We want a small red "NEW" badge to sit exactly in the top-right corner of our service card, overlapping the border slightly.

**Action:** Anchor the card and position the badge.
```css
/* 1. Set the Anchor */
.card {
    position: relative; 
    /* ... existing styles ... */
}

/* 2. Position the Sniper */
.badge {
    position: absolute;
    top: -10px;    /* Move it slightly above the card edge */
    right: -10px;  /* Move it slightly off the right edge */
    padding: 4px 12px;
    background-color: var(--accent-color);
    color: white;
    font-weight: bold;
    font-size: 0.6rem;
    border-radius: 20px;
}
```

---

### Task 3: The Viewport Glue (Fixed)
Users shouldn't have to scroll all the way back up to find the menu. Let's add a "Back to Top" button that stays in the bottom corner of the screen.

**Action:** Add a button in your HTML (outside all main containers) and style it in CSS.
```html
<button class="btn-top">↑</button>
```

```css
.btn-top {
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: var(--primary-color);
    color: white;
    border: none;
    cursor: pointer;
}
```

---

### Task 4: Mastering Depth (Z-Index)
If your absolute badge is hiding behind an image or another card, you need to bring it forward.

**Action:** Ensure your badges and navbars have the correct stacking order.
```css
.badge {
    z-index: 10;
}

header {
    z-index: 100; /* Header should be above everything else */
}
```

---

## Submission Checklist
1. [ ] Does the navbar stay at the top when you scroll?
2. [ ] Is the "NEW" badge sitting in the corner of the card without pushing the text?
3. [ ] Is the "Back to Top" button visible regardless of where you are on the page?
4. [ ] Does the header overlap the rest of the content correctly during scroll?

**Elite Tip:** When debugging `position: absolute`, remember: "Relative is the Parent, Absolute is the Child." If your child is missing, check if you gave the parent `position: relative`.
