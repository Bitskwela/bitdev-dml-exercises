# Activity: Scaling the Sto. Niño Portal

In this activity, you will refactor your Sto. Niño Portal to use relative units. This will ensure that your site remains accessible and looks perfectly proportioned on any screen, from small phones to large desktops.

## Objectives
- Apply the 62.5% font-size trick for easy math.
- Replace all fixed `px` font sizes and margins with `rem`.
- Use `vh` to create a hero section that always fills the screen.
- Ensure images are fluid using `%` widths.

---

### Task 1: The 62.5% Calculation Reset
We want `1rem` to equal `10px`. This is the industry standard for Elite Coders.

**Action:** Update your `html` and `body` selectors in `style.css`.
```css
html {
    font-size: 62.5%; /* 1rem = 10px */
}

body {
    font-size: 1.6rem; /* Base text size = 16px */
    font-family: 'Inter', sans-serif;
    line-height: 1.6;
}
```

---

### Task 2: Refactoring Typography
Now that our root is set, we need to convert our headings and paragraphs.

**Action:** Replace all `px` font sizes with `rem`.
```css
h1 {
    font-size: 4rem; /* 40px */
    margin-bottom: 2rem; /* 20px */
}

h2 {
    font-size: 2.8rem; /* 28px */
}

p {
    font-size: 1.6rem; /* 16px */
}
```

---

### Task 3: Scalable Containers & Spacing
A container shouldn't just be `1200px`. If the user zooms in, it might break.

**Action:** Update your container and section spacing.
```css
.container {
    max-width: 120rem; /* 1200px */
    margin: 0 auto;
    padding: 0 2rem;
}

section {
    padding: 8rem 0; /* 80px top/bottom spacing */
}
```

---

### Task 4: Viewport Hero Section
We want the entrance to our portal (the Hero section) to always fill exactly the user's screen height, whether they are on a phone or laptop.

**Action:** Use `vh` for the hero height.
```css
.hero {
    min-height: 100vh; /* Exactly 100% of the screen height */
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background-size: cover;
    background-position: center;
}
```

---

### Task 5: Fluid Media
Images should never have a fixed width like `width: 500px`. They will explode out of their containers on mobile.

**Action:** Make all images responsive.
```css
img {
    max-width: 100%; /* Never gets wider than its parent */
    height: auto;    /* Mantains aspect ratio */
    display: block;
}
```

---

## Submission Checklist
1. [ ] Is the `html` font-size set to `62.5%`?
2. [ ] Are all your `font-size` and `margin` values in `rem`?
3. [ ] Does the Hero section fill the entire screen height (`100vh`)?
4. [ ] Do images shrink automatically when you make the browser window small?

**Elite Tip:** If you see an element with `width: 100%` and it’s popping out of the container, check if you have `padding` or `border` on it. Remember Task 1 from Lesson 15? Use `box-sizing: border-box` to fix it!
