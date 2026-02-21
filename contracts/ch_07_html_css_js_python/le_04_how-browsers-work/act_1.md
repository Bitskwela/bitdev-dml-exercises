# Lesson 4 Activities: How Browsers Work

**(Do this on your own computer)**

## Understanding the Browser Engine

After learning how websites communicate, it's time to understand what happens inside your browser when a page loads!

---

## Activity 1: Explore the Rendering Pipeline

**Goal:** Visualize how browsers process HTML to pixels.

**Instructions:**

1. Open Chrome DevTools (F12)
2. Go to **Performance** tab
3. Click **Record** (circle icon)
4. Refresh any website
5. Stop recording after page loads
6. Examine the timeline

**Identify these stages:**

- [ ] Parse HTML
- [ ] Parse CSS
- [ ] Layout/Reflow
- [ ] Paint
- [ ] Composite

**Questions:**

1. Which stage took the longest time?
2. How many milliseconds from start to finish?
3. Do you see JavaScript execution blocks?
4. Are there multiple paint operations?

---

## Activity 2: Inspect the DOM Tree

**Goal:** See the Document Object Model structure.

**Instructions:**

1. Visit any website
2. Open DevTools → **Elements** tab
3. Expand the HTML tree structure
4. Notice the hierarchy (parent → children)

**Tasks:**

- Find the `<body>` element
- Count how many `<div>` elements exist
- Locate an image tag (`<img>`)
- Find a link (`<a>`)

**Challenge:**  
Right-click any element → **Delete** (temporarily removes it). What happens?

---

## Activity 3: Compare Browser Engines

**Goal:** Test website rendering across different browsers.

**Test the SAME website in:**

- Google Chrome (Blink engine)
- Mozilla Firefox (Gecko engine)
- Microsoft Edge (Blink engine)
- Safari (WebKit engine) - if available

**Record:**
| Browser | Load Time | Visual Differences | Console Errors |
|---------|-----------|-------------------|----------------|
| Chrome | | | |
| Firefox | | | |
| Edge | | | |

**Questions:**

1. Did all browsers render the page identically?
2. Which loaded fastest?
3. Were there any browser-specific bugs?

---

## Activity 4: Critical Rendering Path Experiment

**Goal:** See how CSS/JS placement affects loading.

**Create test HTML:**

**Version 1 - CSS in `<head>`:**

```html
<!DOCTYPE html>
<html>
  <head>
    <style>
      body {
        background: blue;
      }
    </style>
  </head>
  <body>
    <h1>Test Page</h1>
  </body>
</html>
```

**Version 2 - CSS at bottom:**

```html
<!DOCTYPE html>
<html>
  <body>
    <h1>Test Page</h1>
    <style>
      body {
        background: blue;
      }
    </style>
  </body>
</html>
```

**Test:** Open both. Do you see a flash of unstyled content (FOUC) in Version 2?

---

## Activity 5: JavaScript Blocking Experiment

**Execute the code below in the editor to observe render-blocking behavior.**

**Goal:** Understand render-blocking scripts.

**Test file:**

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Blocking Test</title>
    <script>
      // Simulates slow script
      let start = Date.now();
      while (Date.now() - start < 3000) {
        // 3 second delay
      }
    </script>
  </head>
  <body>
    <h1>Did you see me loading?</h1>
  </body>
</html>
```

**Observe:** How long before the heading appears? Why?

**Fix:** Move `<script>` before `</body>` or add `defer` attribute.

---

## Activity 6: Paint and Reflow

**Goal:** Trigger layout recalculations.

**Instructions:**

1. Open DevTools → **Rendering** tab
2. Enable "**Paint flashing**"
3. Scroll the page
4. Hover over elements
5. Watch green flashes (= repaints)

**Observe:**

- Which actions cause repaints?
- Resize the browser window — what happens?
- Change CSS in DevTools — does it repaint?

---

## Activity 7: Lighthouse Performance Audit

**Goal:** Measure page load performance.

**Instructions:**

1. DevTools → **Lighthouse** tab
2. Select "Performance" category
3. Click "**Analyze page load**"
4. Review the report

**Record metrics:**

- First Contentful Paint (FCP): \_\_\_\_ ms
- Largest Contentful Paint (LCP): \_\_\_\_ ms
- Time to Interactive (TTI): \_\_\_\_ ms
- Cumulative Layout Shift (CLS): \_\_\_\_
- Total Score: \_\_\_\_ / 100

**Observational Notes:**

1. What suggestions does Lighthouse provide?
2. Are images optimized?
3. Is render-blocking CSS/JS present?

---

**Excellent work!** You now understand the browser rendering pipeline, DOM structure, and performance optimization fundamentals!

**Next:** Developer tools and code editors!
