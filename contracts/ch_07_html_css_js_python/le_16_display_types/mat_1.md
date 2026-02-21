## Display Types: The Physics of Web Layout

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_7/C7+16.0+-+COVER.png)

Tian and Rhea Joy were hitting a wall. Tian wanted to turn the service tags into colorful badges with specific sizes, but his `<span>` tags refused to stretch. Rhea Joy wanted her service cards to sit side-by-side, but her `<div>` tags kept acting like stubborn vertical towers.

**Tian:** _"I set the width to 100px, but it’s staying at 40px. CSS is broken."_
**Rhea Joy:** _"And mine are 200px wide, but they won't share the same row. Block-headed divs!"_

Miguel leaned over their screens. _"It’s not broken, Team. You’ve just met the **Default Physics** of HTML. Every element has a `display` property that dictates its social behavior. If you don't master this, you're not coding; you're just wrestling with defaults."_

---

## Theory & Elite Concepts

### 1. The Block (The Refrigerator)
`display: block` elements are the introverts of the web. They want their own space and they want it **all**.

- **Default Elements:** `<div>`, `<h1>`-`<h6>`, `<p>`, `<section>`.
- **Behavior:** They start on a new line and stretch as wide as possible (100% of the container).
- **Elite Rule:** They accept **all** box model properties (width, height, margin, padding). Use them for the "bones" of your site.

### 2. The Inline (The Beads)
`display: inline` elements are the extroverts. They flow like text in a sentence.

- **Default Elements:** `<span>`, `<a>`, `<strong>`.
- **Behavior:** They do **not** start on a new line. They only take up as much space as their content.
- **The Catch:** They **ignore** width and height. They also ignore top/bottom margins.
- **Elite Rule:** Use them only for styling parts of a text (e.g., highlighting a word).

### 3. The Inline-Block (The Professional Hybrid)
This is the "Elite Secret" for many layouts (before Flexbox simplified everything). It offers the best of both worlds.

- **Behavior:** It stays on the same line as other elements (like Inline) but **accepts** width, height, and all margins (like Block).
- **The Catch:** It leaves a small "whitespace" gap between elements in the HTML (like a space between words).
- **Elite Rule:** Perfect for navigation menus and badges.

### 4. Vanishing Acts: `none` vs. `hidden`
Sometimes you need an element to disappear (like a mobile menu toggle).

- `display: none;`: The element is **completely removed** from the layout. Other elements shift to fill the space. (Most used).
- `visibility: hidden;`: The element is invisible, but it still **occupies its space**. It's like a ghost.

---

## Comparison Table

| Feature | `block` | `inline` | `inline-block` |
| :--- | :--- | :--- | :--- |
| **New Line?** | Yes | No | No |
| **Full Width?** | Yes | No (Content only) | No (Content only) |
| **Set Width/Height?** | Yes | **No** | Yes |
| **Vertical Margins?** | Yes | **No** | Yes |

---

## The Elite Takeaway
Don't let the HTML tag decide your layout. You can turn a `<span>` into a block or a `<div>` into an inline element at any time. **Control the display, control the flow.**

---

## Closing Story
Miguel showed them how to fix it. _"Tian, the span is inline—it doesn't have dimensions. Change it to `inline-block`. Rhea Joy, the div is block—it refuses to share. Change them to `inline-block` too."_

With one line of CSS, Tian’s badges snapped into size and Rhea Joy’s cards lined up perfectly.

**Rhea Joy:** _"It’s like we just rewrote the rules of gravity."_

**Miguel:** _"Exactly. But keep your energy up. This 'inline-block' tool is powerful, but soon I'll show you **Flexbox**, which is like having superpowers for alignment."_
