# Le 11: Deploying Astro – The Content-Focused Framework

![Astro Deployment](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/astro-deploy.png)

## Background Story

Maria's Barangay Dashboard is working well, but Neri has another request: "We need a website for the barangay—something that loads fast, shows news, events, and contact information."

"A marketing site," Maria realizes. "Not an app."

Marco suggests something different. "For content-heavy sites, there's a framework called Astro. It ships zero JavaScript by default—just pure HTML and CSS. Perfect for fast-loading content sites."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What makes Astro unique
- Islands architecture
- Content collections
- Hybrid rendering
- Deploying to Vercel
- Using components from other frameworks

---

## What is Astro?

Astro is a **content-focused** web framework designed for performance:

| Feature    | Traditional SPA | Astro                    |
| ---------- | --------------- | ------------------------ |
| Default JS | Lots            | Zero                     |
| Loading    | Slower          | Blazing fast             |
| Best For   | Apps            | Content sites            |
| SEO        | Needs work      | Excellent out of the box |

### The Zero-JS Philosophy

```
Traditional React Site:
HTML + React Runtime (45KB) + Your App Code (30KB) = 75KB+ to load

Astro Site:
HTML + CSS = A few KB to load
(JavaScript only where needed)
```

---

## Islands Architecture

Astro uses "islands" of interactivity in a sea of static HTML:

```
┌─────────────────────────────────────────┐
│  Static HTML (fast, no JS)              │
│  ┌─────────────┐                        │
│  │ Interactive │ ← Island (React/Vue/   │
│  │  Component  │   Svelte component     │
│  └─────────────┘   with JS)             │
│  More static HTML...                    │
│  ┌─────────────┐                        │
│  │   Another   │ ← Another island       │
│  │    Island   │                        │
│  └─────────────┘                        │
└─────────────────────────────────────────┘
```

Only interactive components load JavaScript. Static content is pure HTML.

---

## Astro Project Structure

```
barangay-website/
├── src/
│   ├── pages/
│   │   ├── index.astro       → /
│   │   ├── about.astro       → /about
│   │   └── news/
│   │       └── [slug].astro  → /news/article-1
│   ├── components/
│   │   ├── Header.astro
│   │   └── ContactForm.jsx   # React component!
│   ├── layouts/
│   │   └── MainLayout.astro
│   └── content/
│       └── news/
│           ├── article-1.md
│           └── article-2.md
├── public/
│   └── images/
├── astro.config.mjs
└── package.json
```

---

## Astro Component Syntax

Astro files (`.astro`) have a frontmatter section and HTML:

```astro
---
// This is the component script (runs at build time)
const title = "Barangay San Isidro";
const announcements = await fetch('/api/news').then(r => r.json());
---

<!-- This is the HTML template -->
<html>
  <head>
    <title>{title}</title>
  </head>
  <body>
    <h1>{title}</h1>
    <ul>
      {announcements.map(a => <li>{a.title}</li>)}
    </ul>
  </body>
</html>

<style>
  /* Scoped CSS - only applies to this component */
  h1 {
    color: navy;
  }
</style>
```

---

## Using Components from Other Frameworks

Astro's superpower: use React, Vue, Svelte, or Solid components together!

### Install Integrations

```bash
npx astro add react
npx astro add vue
```

### Use in Astro Pages

```astro
---
import ReactCounter from '../components/Counter.jsx';
import VueForm from '../components/Form.vue';
---

<h1>Barangay Contact</h1>

<!-- Static by default - no JS shipped -->
<ReactCounter />

<!-- client:load - Hydrate immediately -->
<ReactCounter client:load />

<!-- client:visible - Hydrate when visible -->
<VueForm client:visible />
```

### Client Directives

| Directive        | Behavior                        |
| ---------------- | ------------------------------- |
| (none)           | Static HTML, no JS              |
| `client:load`    | Hydrate immediately             |
| `client:visible` | Hydrate when scrolled into view |
| `client:idle`    | Hydrate when browser is idle    |
| `client:only`    | Skip SSR, only render on client |

---

## Content Collections

Astro excels at managing content with **Content Collections**:

```markdown
## <!-- src/content/news/new-bridge.md -->

title: "New Bridge Construction Begins"
date: 2026-01-05
author: "Kapitan Santos"

---

Construction of the new footbridge connecting Zones 1 and 3 will begin next week...
```

```astro
---
// src/pages/news/[slug].astro
import { getCollection, getEntry } from 'astro:content';

export async function getStaticPaths() {
  const newsEntries = await getCollection('news');
  return newsEntries.map(entry => ({
    params: { slug: entry.slug },
    props: { entry },
  }));
}

const { entry } = Astro.props;
const { Content } = await entry.render();
---

<h1>{entry.data.title}</h1>
<p>By {entry.data.author} on {entry.data.date}</p>
<Content />
```

---

## Deploying Astro to Vercel

### Step 1: Create Astro Project

```bash
npm create astro@latest barangay-website
cd barangay-website
```

### Step 2: Add Vercel Adapter (for SSR)

If you need server-side features:

```bash
npx astro add vercel
```

This updates `astro.config.mjs`:

```javascript
import { defineConfig } from "astro/config";
import vercel from "@astrojs/vercel/serverless";

export default defineConfig({
  output: "server", // or 'hybrid'
  adapter: vercel(),
});
```

### Step 3: For Static Sites (Default)

No adapter needed for purely static sites:

```javascript
// astro.config.mjs
import { defineConfig } from "astro/config";

export default defineConfig({
  // Default is static output
});
```

### Step 4: Deploy

```bash
vercel
```

Vercel auto-detects Astro and configures:

```
Build Command: npm run build
Output Directory: dist
```

---

## Rendering Modes

### Static (Default)

All pages generated at build time:

```javascript
// astro.config.mjs
export default defineConfig({
  output: "static", // Default
});
```

### Server (SSR)

Pages rendered on each request:

```javascript
export default defineConfig({
  output: "server",
  adapter: vercel(),
});
```

### Hybrid

Mix static and server-rendered pages:

```javascript
export default defineConfig({
  output: "hybrid",
  adapter: vercel(),
});
```

Then mark pages:

```astro
---
// This page will be server-rendered
export const prerender = false;
---
```

---

## Environment Variables

```bash
# .env
PUBLIC_SITE_URL=https://barangay-sanisidro.vercel.app
DATABASE_URL=secret-db-connection
```

Access in Astro:

```astro
---
// Server-side (all variables available)
const dbUrl = import.meta.env.DATABASE_URL;

// Client-side (only PUBLIC_ variables)
const siteUrl = import.meta.env.PUBLIC_SITE_URL;
---
```

---

## API Routes (SSR Mode)

With SSR enabled, create API endpoints:

```javascript
// src/pages/api/news.json.js
export async function GET() {
  const news = await fetchNews();
  return new Response(JSON.stringify(news), {
    headers: { "Content-Type": "application/json" },
  });
}
```

---

## Performance Benefits

A typical Astro content site vs SPA:

| Metric              | React SPA | Astro  |
| ------------------- | --------- | ------ |
| First Paint         | 1.5s      | 0.3s   |
| Time to Interactive | 3.0s      | 0.5s   |
| Bundle Size         | 150KB     | 15KB   |
| Lighthouse Score    | 70-80     | 95-100 |

For content sites, Astro is significantly faster.

---

## Common Use Cases

Astro excels at:

- ✅ Marketing sites
- ✅ Blogs and news sites
- ✅ Documentation sites
- ✅ Portfolio sites
- ✅ Landing pages

Consider other frameworks for:

- ❌ Complex web apps (use Next.js/SvelteKit)
- ❌ Real-time dashboards (use React/Vue)
- ❌ Heavy client-side interactivity

---

## Maria's Barangay Website

Maria creates the barangay website with Astro:

```
barangay-website/
├── src/
│   ├── pages/
│   │   ├── index.astro      # Homepage
│   │   ├── about.astro      # About the barangay
│   │   ├── officials.astro  # Barangay officials
│   │   └── news/[slug].astro
│   └── content/
│       └── news/            # Markdown news articles
```

```bash
npm run build
vercel

# Result:
✅ https://barangay-sanisidro.vercel.app
# Lighthouse score: 98/100
```

---

## Key Takeaways

✓ Astro ships zero JavaScript by default
✓ Islands architecture adds JS only where needed
✓ Content Collections manage markdown content
✓ Use components from React, Vue, Svelte, or Solid
✓ Static output is default; add adapter for SSR
✓ Perfect for content sites, blogs, documentation

**Next Lesson:** Framework detection and configuration overrides!
