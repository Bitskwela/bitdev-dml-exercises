# Svelte & SvelteKit Deployment Activity

Ana's expense tracker showcases Svelte's simplicity. In this activity, you'll deploy Svelte and SvelteKit applications to Vercel.

## Task for Students

### Part 1: Svelte Concepts Quiz

**Question 1:** What makes Svelte different from React and Vue?

- A) It uses a virtual DOM
- B) It's a compiler, not a runtime library
- C) It requires more boilerplate code
- D) It only works with TypeScript

**Question 2:** What is the Svelte equivalent of Next.js?

- A) Svelte Router
- B) SvelteKit
- C) Svelte Server
- D) Svelte Full

**Question 3:** Which adapter is needed for Vercel deployment?

- A) `@sveltejs/adapter-node`
- B) `@sveltejs/adapter-static`
- C) `@sveltejs/adapter-vercel`
- D) `@sveltejs/adapter-auto`

**Question 4:** Where do API routes go in SvelteKit?

- A) `/api/`
- B) `/src/routes/api/.../+server.js`
- C) `/server/api/`
- D) `/pages/api/`

**Question 5:** Which prefix makes environment variables public in SvelteKit?

- A) `SVELTE_PUBLIC_`
- B) `VITE_`
- C) `PUBLIC_`
- D) `NEXT_PUBLIC_`

---

### Part 2: Simple Svelte Deployment

**Step 1: Create a Svelte Project (Vite)**

```bash
npm create vite@latest my-svelte-app -- --template svelte
cd my-svelte-app
npm install
```

**Step 2: Customize the App**

Edit `src/App.svelte`:

```svelte
<script>
  let name = 'World';
  let count = 0;
</script>

<main>
  <h1>Hello {name}!</h1>

  <input bind:value={name} placeholder="Enter your name" />

  <button on:click={() => count++}>
    Clicked {count} times
  </button>
</main>

<style>
  main {
    text-align: center;
    padding: 2rem;
  }
  input, button {
    margin: 1rem;
    padding: 0.5rem 1rem;
  }
</style>
```

**Step 3: Deploy**

```bash
vercel
```

**Step 4: Verify**

- [ ] App loads at Vercel URL
- [ ] Input binding works
- [ ] Counter increments

---

### Part 3: SvelteKit Deployment

**Step 1: Create SvelteKit Project**

```bash
npm create svelte@latest my-sveltekit-app
# Choose: Skeleton project
# Choose: TypeScript (optional)
cd my-sveltekit-app
npm install
```

**Step 2: Install Vercel Adapter**

```bash
npm install -D @sveltejs/adapter-vercel
```

**Step 3: Configure Adapter**

Edit `svelte.config.js`:

```javascript
import adapter from "@sveltejs/adapter-vercel";
import { vitePreprocess } from "@sveltejs/vite-plugin-svelte";

export default {
  kit: {
    adapter: adapter(),
  },
  preprocess: vitePreprocess(),
};
```

**Step 4: Create a Page**

```svelte
<!-- src/routes/+page.svelte -->
<h1>Welcome to SvelteKit on Vercel!</h1>
<p>Deployed with the Vercel adapter.</p>
<a href="/about">About</a>
```

```svelte
<!-- src/routes/about/+page.svelte -->
<h1>About</h1>
<p>This page demonstrates SvelteKit routing.</p>
<a href="/">Home</a>
```

**Step 5: Deploy**

```bash
vercel
```

---

### Part 4: Create an API Route

**Step 1:** Create the API route:

```javascript
// src/routes/api/greeting/+server.js
export function GET({ url }) {
  const name = url.searchParams.get("name") || "World";

  return new Response(
    JSON.stringify({
      message: `Hello, ${name}!`,
      timestamp: new Date().toISOString(),
    }),
    {
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
}
```

**Step 2:** Test locally:

```bash
npm run dev
# Visit http://localhost:5173/api/greeting
# Visit http://localhost:5173/api/greeting?name=Maria
```

**Step 3:** Deploy and verify the API works on Vercel

---

### Part 5: Environment Variables

**Step 1:** Create `.env`:

```
DATABASE_URL=my-secret-db-url
PUBLIC_SITE_NAME=Expense Tracker
```

**Step 2:** Use in a server file:

```javascript
// src/routes/+page.server.js
import { env } from "$env/dynamic/private";

export function load() {
  // This is server-only
  console.log("DB URL:", env.DATABASE_URL);

  return {
    serverData: "Loaded from server",
  };
}
```

**Step 3:** Use public variable in component:

```svelte
<!-- src/routes/+page.svelte -->
<script>
  import { env } from '$env/dynamic/public';
</script>

<h1>{env.PUBLIC_SITE_NAME}</h1>
```

**Step 4:** Add to Vercel dashboard and redeploy

---

### Part 6: Prerendering Exercise

Make a page static:

```javascript
// src/routes/static-page/+page.js
export const prerender = true;
```

```svelte
<!-- src/routes/static-page/+page.svelte -->
<h1>This page is prerendered!</h1>
<p>Built at: {new Date().toISOString()}</p>
```

**Question:** After deployment, what happens when you refresh this page multiple times? Does the timestamp change?

---

### Part 7: Deployment Checklist

Before deploying SvelteKit:

- [ ] `@sveltejs/adapter-vercel` is installed
- [ ] `svelte.config.js` uses the Vercel adapter
- [ ] `npm run build` succeeds locally
- [ ] Environment variables are configured
- [ ] `.env` is in `.gitignore`

After deployment:

- [ ] All pages load correctly
- [ ] Navigation between pages works
- [ ] API routes respond
- [ ] Environment variables work
- [ ] No console errors

---

### What You Learned

✓ Svelte compiles to vanilla JS—smaller bundles
✓ SvelteKit needs `@sveltejs/adapter-vercel` for Vercel
✓ API routes use `+server.js` files
✓ Use `PUBLIC_` prefix for client-accessible env vars
✓ Use `$env/dynamic/private` for server secrets
✓ Prerendered pages are generated at build time

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-C, 4-B, 5-C

Part 6 Expected Answer: The timestamp does NOT change because the page is prerendered at build time. It's static HTML.
