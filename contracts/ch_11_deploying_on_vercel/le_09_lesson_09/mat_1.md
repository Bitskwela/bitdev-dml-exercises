# Le 09: Deploying Vue & Nuxt – The Progressive JavaScript Framework

![Vue Deployment](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/vue-deploy.png)

## Background Story

Dev Sam joins the call. He's been working on a separate project—a vendor management system for the Palengke.

"I built it with Vue," he explains. "It's like React, but I find it more intuitive. Can I deploy it on Vercel too?"

"Absolutely," Marco confirms. "Vercel supports Vue and Nuxt just as well as React and Next.js."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Vue 3 and Vite deployment
- Nuxt 3 framework overview
- SSR and static generation in Nuxt
- Configuration and environment variables
- Common Vue/Nuxt deployment patterns

---

## Vue 3 Overview

Vue is a progressive JavaScript framework for building user interfaces:

| Feature         | Vue                    | React                      |
| --------------- | ---------------------- | -------------------------- |
| Syntax          | Template-based         | JSX                        |
| State           | Reactive refs/reactive | useState/useReducer        |
| Learning Curve  | Gentler                | Steeper                    |
| Official Router | Vue Router             | React Router (third-party) |
| SSR Framework   | Nuxt                   | Next.js                    |

Vue 3 with Vite is the modern stack for Vue development.

---

## Deploying Vue 3 (Vite)

### Project Structure

```
my-vue-app/
├── public/
│   └── favicon.ico
├── src/
│   ├── App.vue
│   ├── main.js
│   └── components/
├── index.html
├── package.json
└── vite.config.js
```

### Build Configuration

```javascript
// vite.config.js
import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

export default defineConfig({
  plugins: [vue()],
});
```

### Deployment Steps

**Step 1: Create Vue Project**

```bash
npm create vue@latest my-vue-app
cd my-vue-app
npm install
```

**Step 2: Test Locally**

```bash
npm run dev
```

**Step 3: Deploy to Vercel**

```bash
# Via CLI
vercel

# Via Git
git push origin main
# Import in Vercel dashboard
```

Vercel auto-detects Vue/Vite and sets:

```
Build Command: npm run build
Output Directory: dist
```

---

## Environment Variables in Vue

Use the `VITE_` prefix:

```bash
# .env.local
VITE_API_URL=https://api.palengke.ph
VITE_APP_TITLE=Palengke Manager
```

Access in Vue components:

```vue
<script setup>
const apiUrl = import.meta.env.VITE_API_URL;
const title = import.meta.env.VITE_APP_TITLE;
</script>

<template>
  <h1>{{ title }}</h1>
</template>
```

---

## What is Nuxt?

Nuxt is to Vue what Next.js is to React—a full-stack framework with:

- Server-side rendering (SSR)
- Static site generation (SSG)
- File-based routing
- Auto-imports
- Built-in API routes

### Nuxt 3 vs Nuxt 2

| Feature       | Nuxt 2      | Nuxt 3            |
| ------------- | ----------- | ----------------- |
| Vue Version   | Vue 2       | Vue 3             |
| Build Tool    | Webpack     | Vite (or Webpack) |
| API           | Options API | Composition API   |
| Server Engine | Connect     | Nitro             |
| Performance   | Good        | Excellent         |

**Use Nuxt 3 for new projects.**

---

## Nuxt 3 Project Structure

```
my-nuxt-app/
├── app.vue
├── pages/
│   ├── index.vue         → /
│   ├── about.vue         → /about
│   └── products/
│       └── [id].vue      → /products/123
├── server/
│   └── api/
│       └── hello.ts      → /api/hello
├── components/
├── composables/
├── nuxt.config.ts
└── package.json
```

---

## Deploying Nuxt 3

### Step 1: Create Nuxt Project

```bash
npx nuxi@latest init my-nuxt-app
cd my-nuxt-app
npm install
```

### Step 2: Test Locally

```bash
npm run dev
```

### Step 3: Deploy to Vercel

Nuxt 3 has built-in Vercel preset:

```bash
# No additional configuration needed
vercel

# Or push to GitHub and import
```

Vercel automatically:

- Detects Nuxt 3
- Uses the Vercel preset
- Deploys server routes as Serverless Functions

---

## Nuxt Rendering Modes

### Universal (SSR + Client Hydration)

Default mode—pages render on server, then hydrate on client:

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  ssr: true, // Default
});
```

### Static Generation

Generate all pages at build time:

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  ssr: true,
  nitro: {
    prerender: {
      routes: ["/", "/about", "/products"],
    },
  },
});
```

Or fully static:

```bash
npm run generate
# Creates .output/public with static files
```

### Client-Only (SPA)

Disable SSR for a traditional SPA:

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  ssr: false,
});
```

---

## Nuxt API Routes

Create serverless API endpoints:

```typescript
// server/api/vendors.ts
export default defineEventHandler(async (event) => {
  return {
    vendors: [
      { id: 1, name: "Mang Pedro", stall: "A1" },
      { id: 2, name: "Aling Rosa", stall: "B3" },
    ],
  };
});
```

Access at: `https://yourapp.vercel.app/api/vendors`

---

## Environment Variables in Nuxt

### Runtime Config

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  runtimeConfig: {
    // Server-only
    apiSecret: process.env.API_SECRET,

    // Public (exposed to client)
    public: {
      apiBase: process.env.NUXT_PUBLIC_API_BASE,
    },
  },
});
```

### In Components

```vue
<script setup>
const config = useRuntimeConfig();
console.log(config.public.apiBase);
</script>
```

### In Server Routes

```typescript
// server/api/data.ts
export default defineEventHandler((event) => {
  const config = useRuntimeConfig();
  // Access server-only secrets
  const secret = config.apiSecret;
});
```

---

## Common Nuxt Deployment Issues

### Issue 1: Nitro Preset Not Detected

**Fix:** Explicitly set the Vercel preset:

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  nitro: {
    preset: "vercel",
  },
});
```

### Issue 2: 500 Errors on API Routes

**Fix:** Check server logs in Vercel dashboard:

1. Go to Project → Deployments → Latest
2. Click "Functions" tab
3. View function logs

### Issue 3: Build Failing with Type Errors

**Fix:** Nuxt is strict about TypeScript. Either fix errors or:

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  typescript: {
    strict: false,
  },
});
```

---

## Vue Router vs Nuxt File Routing

### Vue Router (Manual)

```javascript
// router/index.js
const routes = [
  { path: "/", component: Home },
  { path: "/about", component: About },
  { path: "/products/:id", component: Product },
];
```

### Nuxt (Automatic)

```
pages/
├── index.vue        → /
├── about.vue        → /about
└── products/
    └── [id].vue     → /products/:id
```

No router configuration needed—Nuxt generates it from the file structure.

---

## Dev Sam's Deployment

Dev Sam deploys his Palengke Vendor Manager:

```bash
# Create Nuxt 3 project
npx nuxi@latest init palengke-manager
cd palengke-manager

# Add pages
mkdir pages
# Create pages/index.vue, pages/vendors.vue, etc.

# Add API
mkdir -p server/api
# Create server/api/vendors.ts

# Deploy
vercel
```

Result: `https://palengke-manager.vercel.app`

---

## Key Takeaways

✓ Vue 3 with Vite deploys like any Vite project
✓ Nuxt 3 is the Vue equivalent of Next.js
✓ Nuxt has built-in Vercel preset—zero config deployment
✓ Use `VITE_` prefix for Vue env vars
✓ Use `runtimeConfig` for Nuxt env vars
✓ Nuxt's `/server/api` routes become Serverless Functions

**Next Lesson:** Deploying Svelte and SvelteKit!
