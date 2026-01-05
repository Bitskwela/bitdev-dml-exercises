# Next.js Deployment Activity

Next.js is the React framework with superpowers—and Vercel is its home. In this activity, you'll deploy a Next.js application and explore its unique features.

## Task for Students

### Part 1: Concept Quiz

**Question 1:** What company created both Next.js and Vercel?

- A) Facebook (Meta)
- B) Vercel
- C) Google
- D) Microsoft

**Question 2:** Which rendering strategy generates pages at build time?

- A) SSR (Server-Side Rendering)
- B) SSG (Static Site Generation)
- C) CSR (Client-Side Rendering)
- D) ISR (Incremental Static Regeneration)

**Question 3:** Where do you put API routes in the App Router?

- A) `/pages/api/`
- B) `/api/`
- C) `/app/api/`
- D) `/routes/api/`

**Question 4:** Which prefix is required for client-side environment variables in Next.js?

- A) `REACT_APP_`
- B) `VITE_`
- C) `NEXT_PUBLIC_`
- D) `CLIENT_`

**Question 5:** What does ISR allow you to do?

- A) Build pages once and never update
- B) Rebuild static pages at specified intervals
- C) Only render pages on the client
- D) Skip the build step entirely

---

### Part 2: Create and Deploy

**Step 1: Create a Next.js Project**

```bash
npx create-next-app@latest my-nextjs-app
cd my-nextjs-app
```

Choose these options:

- TypeScript: Your preference
- ESLint: Yes
- Tailwind CSS: Your preference
- `src/` directory: No
- App Router: Yes
- Import alias: Default

**Step 2: Test Locally**

```bash
npm run dev
```

Visit `http://localhost:3000`

**Step 3: Deploy to Vercel**

Option A - Via CLI:

```bash
vercel
```

Option B - Via Git:

1. Push to GitHub
2. Import in Vercel dashboard
3. Click Deploy

**Step 4: Verify Deployment**

- [ ] Site loads at the Vercel URL
- [ ] No build errors in Vercel dashboard
- [ ] Page source shows HTML content (not empty body)

---

### Part 3: Create an API Route

**Step 1:** Create the API route file:

```
app/api/hello/route.js
```

**Step 2:** Add the code:

```javascript
export async function GET() {
  return Response.json({
    message: "Hello from the Barangay API!",
    timestamp: new Date().toISOString(),
  });
}
```

**Step 3:** Test locally:

```bash
npm run dev
# Visit http://localhost:3000/api/hello
```

**Step 4:** Deploy and test:

```bash
git add .
git commit -m "Add API route"
git push
```

Visit `https://yourapp.vercel.app/api/hello`

---

### Part 4: Rendering Strategy Exercise

Create three pages with different rendering strategies:

**Page 1: Static (SSG)**

```javascript
// app/static-page/page.js
export default function StaticPage() {
  return <h1>Built at: {new Date().toISOString()}</h1>;
}
```

**Page 2: Dynamic (SSR)**

```javascript
// app/dynamic-page/page.js
export const dynamic = "force-dynamic";

export default function DynamicPage() {
  return <h1>Rendered at: {new Date().toISOString()}</h1>;
}
```

**Page 3: ISR**

```javascript
// app/isr-page/page.js
export const revalidate = 60; // Regenerate every 60 seconds

export default function ISRPage() {
  return <h1>Regenerated at: {new Date().toISOString()}</h1>;
}
```

**Questions:**

1. Refresh `/static-page` multiple times. Does the timestamp change?
2. Refresh `/dynamic-page` multiple times. Does the timestamp change?
3. Refresh `/isr-page` multiple times. When does it change?

---

### Part 5: Environment Variables

**Step 1:** Create `.env.local`:

```
DATABASE_URL=this-is-secret
NEXT_PUBLIC_SITE_NAME=Barangay Dashboard
```

**Step 2:** Create a page that uses them:

```javascript
// app/env-test/page.js
export default function EnvTest() {
  // This will be undefined in browser (server-only)
  const dbUrl = process.env.DATABASE_URL;

  // This is available in browser
  const siteName = process.env.NEXT_PUBLIC_SITE_NAME;

  return (
    <div>
      <h1>{siteName}</h1>
      <p>DB URL visible: {dbUrl ? "Yes (server)" : "No (client)"}</p>
    </div>
  );
}
```

**Step 3:** Add `NEXT_PUBLIC_SITE_NAME` in Vercel dashboard with a different value

**Step 4:** Redeploy and verify the change

---

### Part 6: Deployment Verification Checklist

After deployment, verify:

- [ ] Homepage loads correctly
- [ ] Navigation works (if you have multiple pages)
- [ ] API routes respond with JSON
- [ ] Images load (if using next/image)
- [ ] No console errors
- [ ] Environment variables are accessible
- [ ] View page source shows server-rendered HTML

---

### What You Learned

✓ Next.js provides SSR, SSG, and ISR out of the box
✓ API routes in `/app/api/` become Serverless Functions
✓ Vercel auto-detects and optimally configures Next.js
✓ `NEXT_PUBLIC_` prefix exposes env vars to the client
✓ Different rendering strategies suit different use cases

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-C, 4-C, 5-B

Part 4 Expected Behavior:

1. Static page: Timestamp NEVER changes (built once)
2. Dynamic page: Timestamp changes EVERY refresh (SSR)
3. ISR page: Timestamp changes after ~60 seconds (revalidates)
