# Lesson 4 Activities: How Browsers Work

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
        body { background: blue; }
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
        body { background: blue; }
    </style>
</body>
</html>
```

**Test:** Open both. Do you see a flash of unstyled content (FOUC) in Version 2?

---

## Activity 5: JavaScript Blocking Experiment

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

**Tasks:**
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
- First Contentful Paint (FCP): ____ ms
- Largest Contentful Paint (LCP): ____ ms
- Time to Interactive (TTI): ____ ms
- Cumulative Layout Shift (CLS): ____
- Total Score: ____ / 100

**Questions:**
1. What suggestions does Lighthouse provide?
2. Are images optimized?
3. Is render-blocking CSS/JS present?

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: Rendering Pipeline

**Typical Timeline:**
1. **Parse HTML** (20-50ms) - Browser reads HTML, builds DOM
2. **Parse CSS** (10-30ms) - Reads stylesheets, builds CSSOM
3. **Layout/Reflow** (50-200ms) - Calculates positions and sizes
4. **Paint** (50-300ms) - Draws pixels
5. **Composite** (10-50ms) - Layers combined

**What takes longest:** Usually **Layout** and **Paint** for complex pages.

**JavaScript blocks:** Yes, shown as orange/yellow bars in timeline.

## Activity 2: DOM Inspection

**DOM Tree Example:**
```
html
├── head
│   ├── title
│   ├── meta (charset)
│   └── link (stylesheet)
└── body
    ├── header
    │   └── nav
    ├── main
    │   ├── article
    │   └── section
    └── footer
```

**Deleting elements:** Temporarily removes from page (refresh restores).

## Activity 3: Browser Comparison

**Typical Results:**
- **Chrome/Edge:** Nearly identical (both use Blink)
- **Firefox:** Slight font rendering differences
- **Safari:** Sometimes stricter CSS interpretation

**Performance:** Usually similar on modern sites, Chrome often slightly faster.

**Compatibility issues:**  
- Old CSS prefixes (-webkit-, -moz-)
- Experimental features
- Different default styles

## Activity 4: CSS Placement

**Version 1 (CSS in head):** Loads correctly, no FOUC.

**Version 2 (CSS at bottom):** 
- Brief flash of unstyled HTML
- Then styles apply
- **Bad user experience!**

**Best Practice:** Always put CSS in `<head>` to prevent FOUC.

## Activity 5: JavaScript Blocking

**Result:** Page appears blank for 3 seconds, then heading appears.

**Why:** JavaScript in `<head>` blocks HTML parsing until script finishes.

**Solutions:**
```html
<!-- Option 1: Move to bottom -->
<body>
    <h1>Content</h1>
    <script>/* code */</script>
</body>

<!-- Option 2: Use defer -->
<head>
    <script defer src="script.js"></script>
</head>

<!-- Option 3: Use async -->
<head>
    <script async src="script.js"></script>
</head>
```

**defer vs async:**
- `defer`: Wait until HTML parsed, execute in order
- `async`: Download parallel, execute immediately when ready

## Activity 6: Paint Flashing

**Actions causing repaints:**
- Scrolling (reveals new content)
- Hover effects (color/size changes)
- Animations/transitions
- Window resize (layout recalculation)
- DevTools CSS edits

**Green flashes** indicate browser redrawing that area.

**Performance tip:** Minimize repaints for smoother experience.

## Activity 7: Lighthouse Metrics

**Good Scores:**
- **FCP:** < 1.8s (green)
- **LCP:** < 2.5s (green)
- **TTI:** < 3.8s (green)
- **CLS:** < 0.1 (green)

**Common Issues:**
- Large images not optimized
- Render-blocking CSS/JS
- Missing width/height on images (causes CLS)
- No lazy loading

**Philippine Context:**
With slower internet (average 40 Mbps), aim for:
- Total page size < 1MB
- Images compressed
- Critical CSS inlined

</details>

---

**Excellent work!** You now understand the browser rendering pipeline, DOM structure, and performance optimization fundamentals!

**Next:** Developer tools and code editors!
