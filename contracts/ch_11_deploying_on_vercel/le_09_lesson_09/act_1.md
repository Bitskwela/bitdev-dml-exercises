# Vue & Nuxt Deployment Activity

Dev Sam's Palengke Manager is ready for deployment! In this activity, you'll practice deploying Vue and Nuxt applications to Vercel.

## Task for Students

### Part 1: Framework Comparison Quiz

**Question 1:** What is Nuxt to Vue?

- A) A state management library
- B) A full-stack framework like Next.js is to React
- C) A testing framework
- D) A CSS framework

**Question 2:** Which prefix do environment variables use in Vue 3 (Vite)?

- A) `VUE_`
- B) `PUBLIC_`
- C) `VITE_`
- D) `NUXT_`

**Question 3:** What is the default output directory for Vue 3 (Vite) builds?

- A) `build/`
- B) `public/`
- C) `dist/`
- D) `.output/`

**Question 4:** Where do API routes go in Nuxt 3?

- A) `/api/`
- B) `/pages/api/`
- C) `/server/api/`
- D) `/routes/`

**Question 5:** What build tool does Nuxt 3 use by default?

- A) Webpack
- B) Rollup
- C) Vite
- D) esbuild

---

### Part 2: Vue 3 Deployment Exercise

**Step 1: Create a Vue 3 Project**

```bash
npm create vue@latest my-vue-app
# Select: TypeScript? Your choice
# Select: Router? Yes
# Select: Pinia? No
cd my-vue-app
npm install
```

**Step 2: Test Locally**

```bash
npm run dev
```

**Step 3: Add an Environment Variable**

Create `.env.local`:

```
VITE_APP_NAME=Palengke Manager
```

Update `src/App.vue` to use it:

```vue
<template>
  <h1>{{ appName }}</h1>
</template>

<script setup>
const appName = import.meta.env.VITE_APP_NAME;
</script>
```

**Step 4: Deploy**

```bash
vercel
```

**Step 5: Verify**

- [ ] Site loads at Vercel URL
- [ ] Environment variable displays correctly

---

### Part 3: Nuxt 3 Deployment Exercise

**Step 1: Create a Nuxt 3 Project**

```bash
npx nuxi@latest init my-nuxt-app
cd my-nuxt-app
npm install
```

**Step 2: Create a Page**

```vue
<!-- pages/index.vue -->
<template>
  <div>
    <h1>Welcome to Nuxt 3</h1>
    <p>Deployed on Vercel!</p>
  </div>
</template>
```

**Step 3: Create an API Route**

```typescript
// server/api/hello.ts
export default defineEventHandler(() => {
  return {
    message: "Hello from Nuxt API!",
    timestamp: new Date().toISOString(),
  };
});
```

**Step 4: Test Locally**

```bash
npm run dev
# Visit http://localhost:3000
# Visit http://localhost:3000/api/hello
```

**Step 5: Deploy**

```bash
vercel
```

**Step 6: Verify**

- [ ] Homepage loads
- [ ] API route returns JSON at `/api/hello`

---

### Part 4: Nuxt Environment Variables

**Step 1: Configure Runtime Config**

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  runtimeConfig: {
    apiSecret: "server-only-secret",
    public: {
      siteName: "Palengke Manager",
    },
  },
});
```

**Step 2: Use in a Component**

```vue
<!-- pages/index.vue -->
<script setup>
const config = useRuntimeConfig();
</script>

<template>
  <h1>{{ config.public.siteName }}</h1>
</template>
```

**Step 3: Override in Vercel**

Add environment variable in Vercel dashboard:

```
Key: NUXT_PUBLIC_SITE_NAME
Value: Palengke Manager - Production
```

Note: Nuxt uses `NUXT_` prefix to override runtime config values.

---

### Part 5: Rendering Mode Exercise

Create three versions of a Nuxt page:

**SSR Page (default):**

```vue
<!-- pages/ssr.vue -->
<script setup>
const timestamp = new Date().toISOString();
</script>

<template>
  <p>SSR: {{ timestamp }}</p>
</template>
```

**Client-Only Page:**

```vue
<!-- pages/client.vue -->
<script setup>
const timestamp = ref("");

onMounted(() => {
  timestamp.value = new Date().toISOString();
});
</script>

<template>
  <p>Client: {{ timestamp }}</p>
</template>
```

**Questions:**

1. View source on `/ssr` - is the timestamp in the HTML?
2. View source on `/client` - is the timestamp in the HTML?
3. What's the SEO implication of each approach?

---

### Part 6: Deployment Checklist

Before deploying Vue/Nuxt apps, verify:

- [ ] `npm run build` succeeds locally
- [ ] Environment variables are set (locally and in Vercel)
- [ ] `.env.local` is in `.gitignore`
- [ ] API routes work locally (Nuxt)
- [ ] Router/navigation works
- [ ] No TypeScript errors (if using TS)

After deployment, verify:

- [ ] Site loads at Vercel URL
- [ ] Navigation between pages works
- [ ] API routes respond (Nuxt)
- [ ] Environment variables are correct
- [ ] No console errors

---

### What You Learned

✓ Vue 3 (Vite) deploys with `dist/` output directory
✓ Nuxt 3 has built-in Vercel support
✓ Use `VITE_` prefix for Vue environment variables
✓ Use `runtimeConfig` for Nuxt environment variables
✓ Nuxt API routes go in `/server/api/`
✓ SSR renders on server; client-only renders in browser

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-C, 4-C, 5-C

Part 5 Expected Answers:

1. Yes - timestamp is in the HTML source (SSR)
2. No - timestamp is rendered client-side after hydration
3. SSR is better for SEO because content is in initial HTML; client-only content may not be indexed
