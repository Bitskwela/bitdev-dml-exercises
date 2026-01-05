# Le 10: Deploying Svelte & SvelteKit – Compiled Simplicity

![Svelte Deployment](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/svelte-deploy.png)

## Background Story

Neri's niece, Ana, has been learning web development. She shows Maria her first project—a simple expense tracker.

"I built it with Svelte," Ana explains. "My bootcamp said it's the easiest framework to learn."

Maria looks at the code. "This is so clean! No `useState`, no `useEffect`... it just works."

"That's Svelte," Marco chimes in. "It compiles away the framework. Let's deploy it to Vercel."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What makes Svelte different
- SvelteKit framework overview
- Adapter-vercel for deployment
- Environment variables and configuration
- Static vs server rendering

---

## What Makes Svelte Different?

Svelte is a **compiler**, not a runtime library:

| Feature        | React/Vue                   | Svelte                 |
| -------------- | --------------------------- | ---------------------- |
| Approach       | Runtime library             | Compile-time           |
| Bundle Size    | Larger (includes framework) | Smaller (no framework) |
| Reactivity     | Manual (useState, ref)      | Automatic              |
| Learning Curve | Steeper                     | Gentler                |
| Performance    | Fast                        | Very fast              |

### Svelte Syntax

```svelte
<!-- No imports needed for reactivity! -->
<script>
  let count = 0;

  function increment() {
    count += 1; // Automatically triggers update
  }
</script>

<button on:click={increment}>
  Count: {count}
</button>
```

Compare to React:

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return <button onClick={() => setCount(count + 1)}>Count: {count}</button>;
}
```

---

## What is SvelteKit?

SvelteKit is to Svelte what Next.js is to React:

- File-based routing
- Server-side rendering
- Static site generation
- API routes
- Adapters for different platforms

### SvelteKit Project Structure

```
my-sveltekit-app/
├── src/
│   ├── routes/
│   │   ├── +page.svelte      → /
│   │   ├── +layout.svelte
│   │   ├── about/
│   │   │   └── +page.svelte  → /about
│   │   └── api/
│   │       └── hello/
│   │           └── +server.js → /api/hello
│   ├── lib/
│   └── app.html
├── static/
├── svelte.config.js
└── package.json
```

---

## Deploying Svelte (Vite)

For simple Svelte apps without SvelteKit:

### Step 1: Create Project

```bash
npm create vite@latest my-svelte-app -- --template svelte
cd my-svelte-app
npm install
```

### Step 2: Test Locally

```bash
npm run dev
```

### Step 3: Deploy

```bash
vercel
```

Vercel auto-detects Svelte/Vite:

```
Build Command: npm run build
Output Directory: dist
```

---

## Deploying SvelteKit

SvelteKit requires an **adapter** to deploy. Vercel has a dedicated adapter.

### Step 1: Create SvelteKit Project

```bash
npm create svelte@latest my-sveltekit-app
cd my-sveltekit-app
npm install
```

### Step 2: Install Vercel Adapter

```bash
npm install -D @sveltejs/adapter-vercel
```

### Step 3: Configure Adapter

```javascript
// svelte.config.js
import adapter from "@sveltejs/adapter-vercel";
import { vitePreprocess } from "@sveltejs/vite-plugin-svelte";

export default {
  kit: {
    adapter: adapter({
      // Optional configuration
      runtime: "nodejs20.x",
    }),
  },
  preprocess: vitePreprocess(),
};
```

### Step 4: Deploy

```bash
vercel

# Or push to GitHub and import
```

---

## SvelteKit Routing

### Pages

```svelte
<!-- src/routes/+page.svelte -->
<h1>Welcome to SvelteKit</h1>
```

### Dynamic Routes

```svelte
<!-- src/routes/products/[id]/+page.svelte -->
<script>
  export let data;
</script>

<h1>Product: {data.id}</h1>
```

```javascript
// src/routes/products/[id]/+page.server.js
export function load({ params }) {
  return {
    id: params.id,
  };
}
```

### API Routes

```javascript
// src/routes/api/hello/+server.js
export function GET() {
  return new Response(
    JSON.stringify({
      message: "Hello from SvelteKit!",
    }),
    {
      headers: { "Content-Type": "application/json" },
    }
  );
}
```

---

## Environment Variables

### Private Variables (Server-Only)

```bash
# .env
DATABASE_URL=postgresql://...
API_SECRET=super-secret
```

Access in server files:

```javascript
// +page.server.js or +server.js
import { env } from "$env/dynamic/private";

export function load() {
  const dbUrl = env.DATABASE_URL;
  // Use for server-side operations
}
```

### Public Variables

```bash
# .env
PUBLIC_API_URL=https://api.example.com
```

Access anywhere:

```javascript
// Any .svelte or .js file
import { env } from "$env/dynamic/public";

const apiUrl = env.PUBLIC_API_URL;
```

### Static Environment Variables

For build-time variables:

```javascript
import { PUBLIC_API_URL } from "$env/static/public";
```

---

## Rendering Options

### SSR (Default)

Pages render on the server:

```javascript
// src/routes/+page.server.js
export function load() {
  return {
    data: "Server-rendered content",
  };
}
```

### Static Prerendering

Generate HTML at build time:

```javascript
// src/routes/about/+page.js
export const prerender = true;
```

Or prerender all pages:

```javascript
// svelte.config.js
export default {
  kit: {
    adapter: adapter(),
    prerender: {
      entries: ["*"],
    },
  },
};
```

### Client-Side Only

Disable SSR for specific pages:

```javascript
// src/routes/dashboard/+page.js
export const ssr = false;
```

---

## Vercel-Specific Features

### Edge Functions

Deploy routes to the edge:

```javascript
// src/routes/api/fast/+server.js
export const config = {
  runtime: "edge",
};

export function GET() {
  return new Response("Fast edge response!");
}
```

### ISR (Incremental Static Regeneration)

```javascript
// src/routes/products/+page.server.js
export const config = {
  isr: {
    expiration: 60, // Revalidate every 60 seconds
  },
};
```

---

## Common Deployment Issues

### Issue 1: Adapter Not Found

```
Error: @sveltejs/adapter-vercel not found
```

**Fix:** Install the adapter:

```bash
npm install -D @sveltejs/adapter-vercel
```

### Issue 2: Build Fails with Node APIs

```
Error: fs is not defined
```

**Fix:** Ensure Node APIs are only used in server files (`+page.server.js`, `+server.js`)

### Issue 3: Environment Variables Undefined

**Fix:**

1. Use correct prefix (`PUBLIC_` for public vars)
2. Use correct import (`$env/dynamic/private` or `$env/dynamic/public`)
3. Add to Vercel dashboard and redeploy

---

## Svelte vs React: Performance Comparison

A typical bundle size comparison:

| App Type    | React   | Svelte |
| ----------- | ------- | ------ |
| Hello World | ~45 KB  | ~3 KB  |
| Todo App    | ~60 KB  | ~8 KB  |
| Dashboard   | ~150 KB | ~45 KB |

Svelte's compiler removes the framework overhead, resulting in smaller bundles.

---

## Ana's Expense Tracker

Ana deploys her first SvelteKit app:

```bash
# Install adapter
npm install -D @sveltejs/adapter-vercel

# Update svelte.config.js
# ... (add adapter)

# Deploy
vercel

# Result:
✅ https://expense-tracker-ana.vercel.app
```

"My first deployed app!" Ana celebrates. Maria smiles—she remembers that feeling.

---

## Key Takeaways

✓ Svelte is a compiler—smaller bundles, simpler syntax
✓ SvelteKit is the full-stack framework for Svelte
✓ Use `@sveltejs/adapter-vercel` for Vercel deployment
✓ `PUBLIC_` prefix for client-accessible environment variables
✓ Use `$env/dynamic/private` for server-only secrets
✓ SvelteKit supports SSR, static generation, and edge functions

**Next Lesson:** Deploying Astro—the content-focused framework!
