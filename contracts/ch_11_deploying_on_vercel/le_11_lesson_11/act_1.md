# Astro Deployment Activity

Astro makes content sites blazing fast. In this activity, you'll deploy an Astro site and explore its unique features.

## Task for Students

### Part 1: Astro Concepts Quiz

**Question 1:** What makes Astro different from React or Vue?

- A) It ships zero JavaScript by default
- B) It only works with TypeScript
- C) It's slower but more feature-rich
- D) It doesn't support CSS

**Question 2:** What is the "Islands Architecture"?

- A) A design pattern for mobile apps
- B) Static HTML with islands of interactivity
- C) A way to organize folder structure
- D) A database design pattern

**Question 3:** Which client directive hydrates a component when it scrolls into view?

- A) `client:load`
- B) `client:idle`
- C) `client:visible`
- D) `client:scroll`

**Question 4:** What is Astro best for?

- A) Complex real-time apps
- B) Content-heavy sites like blogs and documentation
- C) Mobile app development
- D) Database management

**Question 5:** Can you use React components in an Astro project?

- A) No, Astro is its own framework
- B) Yes, with integrations
- C) Only Vue components are supported
- D) Only Svelte components are supported

---

### Part 2: Create an Astro Site

**Step 1: Create Project**

```bash
npm create astro@latest my-astro-site
# Choose: Empty project
# Choose: Install dependencies? Yes
cd my-astro-site
```

**Step 2: Create Your First Page**

```astro
<!-- src/pages/index.astro -->
---
const siteName = "Barangay San Isidro";
const officials = [
  { name: "Hon. Juan Santos", role: "Barangay Captain" },
  { name: "Maria Cruz", role: "Secretary" },
  { name: "Pedro Reyes", role: "Treasurer" }
];
---

<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>{siteName}</title>
  </head>
  <body>
    <h1>Welcome to {siteName}</h1>

    <h2>Our Officials</h2>
    <ul>
      {officials.map(o => (
        <li><strong>{o.name}</strong> - {o.role}</li>
      ))}
    </ul>
  </body>
</html>

<style>
  body {
    font-family: system-ui, sans-serif;
    padding: 2rem;
    max-width: 800px;
    margin: 0 auto;
  }
  h1 {
    color: #1e40af;
  }
</style>
```

**Step 3: Add Another Page**

```astro
<!-- src/pages/about.astro -->
---
const title = "About Our Barangay";
---

<html lang="en">
  <head>
    <title>{title}</title>
  </head>
  <body>
    <h1>{title}</h1>
    <p>Barangay San Isidro was established in 1950...</p>
    <a href="/">← Back to Home</a>
  </body>
</html>
```

**Step 4: Test Locally**

```bash
npm run dev
# Visit http://localhost:4321
```

**Step 5: Deploy**

```bash
vercel
```

---

### Part 3: View Source Comparison

After deployment, open your site and view the page source (Ctrl+U or Cmd+Option+U).

**Questions:**

1. How much JavaScript do you see in the source?
2. Is the content visible in the HTML source?
3. Compare this to a typical React SPA - what's different?

**Expected Observations:**

- [ ] Minimal or no JavaScript
- [ ] All content is in the HTML
- [ ] CSS is included inline or linked
- [ ] No React runtime or hydration code

---

### Part 4: Add a React Island

**Step 1: Install React Integration**

```bash
npx astro add react
```

**Step 2: Create a React Component**

```jsx
// src/components/Counter.jsx
import { useState } from "react";

export default function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div
      style={{ padding: "1rem", border: "1px solid #ccc", margin: "1rem 0" }}
    >
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

**Step 3: Use with Different Client Directives**

```astro
<!-- src/pages/islands.astro -->
---
import Counter from '../components/Counter.jsx';
---

<html lang="en">
  <head>
    <title>Islands Demo</title>
  </head>
  <body>
    <h1>Islands Architecture Demo</h1>

    <h2>Static (No JavaScript)</h2>
    <Counter />

    <h2>client:load (Hydrates Immediately)</h2>
    <Counter client:load />

    <h2>client:visible (Hydrates When Visible)</h2>
    <div style="margin-top: 100vh;">
      <p>Scroll down to see this counter</p>
      <Counter client:visible />
    </div>
  </body>
</html>
```

**Step 4: Test the Differences**

- First Counter: Does the button work? (No - it's static HTML)
- Second Counter: Does it work? (Yes - hydrated immediately)
- Third Counter: Scroll down - when does it become interactive?

---

### Part 5: Content Collections

**Step 1: Create Content Config**

```typescript
// src/content/config.ts
import { defineCollection, z } from "astro:content";

const newsCollection = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    date: z.date(),
    author: z.string(),
  }),
});

export const collections = {
  news: newsCollection,
};
```

**Step 2: Add Content**

```markdown
## <!-- src/content/news/first-post.md -->

title: "Community Clean-up Day"
date: 2026-01-10
author: "Barangay Council"

---

Join us this Saturday for our monthly community clean-up!

All residents are invited to participate.
```

**Step 3: Create News Page**

```astro
<!-- src/pages/news.astro -->
---
import { getCollection } from 'astro:content';

const news = await getCollection('news');
---

<html>
  <head><title>News</title></head>
  <body>
    <h1>Barangay News</h1>
    {news.map(article => (
      <article>
        <h2>{article.data.title}</h2>
        <p>By {article.data.author} on {article.data.date.toLocaleDateString()}</p>
      </article>
    ))}
  </body>
</html>
```

---

### Part 6: Deployment Checklist

Before deploying:

- [ ] `npm run build` succeeds
- [ ] All pages render correctly
- [ ] Images are in `public/` folder
- [ ] No TypeScript errors

After deployment:

- [ ] Site loads quickly
- [ ] All pages are accessible
- [ ] Interactive components work
- [ ] View source shows HTML content
- [ ] Check Lighthouse score

---

### What You Learned

✓ Astro ships zero JS by default for fast loading
✓ Islands architecture adds interactivity only where needed
✓ Client directives control when components hydrate
✓ Content Collections manage markdown content
✓ You can use React, Vue, or Svelte components in Astro
✓ Static output is default; no adapter needed

---

**Instructor Answers:**

Part 1: 1-A, 2-B, 3-C, 4-B, 5-B

Part 3 Expected Observations:

- Minimal JavaScript (just essential scripts)
- All content visible in HTML source
- No framework runtime bundled
- Much smaller page size than SPAs
