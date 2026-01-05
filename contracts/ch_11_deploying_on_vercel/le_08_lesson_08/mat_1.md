# Le 08: Deploying Next.js – The Full-Stack React Framework

![Next.js Deployment](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/nextjs-deploy.png)

## Background Story

Marco reviews Maria's React dashboard. "This is great, but have you thought about SEO? Search engines can't read your content—it's all rendered in JavaScript."

"SEO?" Maria asks.

"Search Engine Optimization. When Google crawls your site, it sees an empty page. For a public-facing barangay dashboard, that's a problem."

"How do I fix it?"

"Next.js," Marco says with a knowing smile. "It's React with superpowers. And Vercel—the company that makes Next.js—has first-class support for it."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What is Next.js and why use it
- App Router vs Pages Router
- SSR, SSG, and ISR explained
- Deploying Next.js to Vercel
- Serverless functions automatic setup
- Static export option

---

## What is Next.js?

Next.js is a **React framework** that adds:

| Feature            | Plain React          | Next.js                 |
| ------------------ | -------------------- | ----------------------- |
| Routing            | Need React Router    | Built-in file-based     |
| Server Rendering   | Manual setup         | Automatic               |
| SEO                | Poor (client-side)   | Excellent (server-side) |
| API Routes         | Need Express/backend | Built-in `/api` routes  |
| Image Optimization | Manual               | Automatic               |
| TypeScript         | Manual config        | Zero config             |

Next.js is created by Vercel, so deployment is seamless.

---

## App Router vs Pages Router (2026)

Next.js has two routing systems:

### App Router (Recommended - Next.js 13+)

```
app/
├── page.js           → /
├── about/
│   └── page.js       → /about
├── dashboard/
│   ├── page.js       → /dashboard
│   └── [id]/
│       └── page.js   → /dashboard/123
└── api/
    └── users/
        └── route.js  → /api/users
```

### Pages Router (Legacy)

```
pages/
├── index.js          → /
├── about.js          → /about
└── api/
    └── users.js      → /api/users
```

**Use App Router for new projects** — it's the future of Next.js.

---

## Rendering Strategies

Next.js supports multiple rendering strategies:

### 1. Server-Side Rendering (SSR)

Page is generated on each request:

```javascript
// app/dashboard/page.js
export const dynamic = "force-dynamic";

export default async function Dashboard() {
  const data = await fetch("https://api.example.com/stats");
  return <div>{/* real-time data */}</div>;
}
```

**Use for:** Real-time data, personalized content

### 2. Static Site Generation (SSG)

Page is generated at build time:

```javascript
// app/about/page.js
export default function About() {
  return <div>About our Barangay</div>;
}
// No data fetching = static by default
```

**Use for:** Blog posts, marketing pages, documentation

### 3. Incremental Static Regeneration (ISR)

Static page that updates periodically:

```javascript
// app/products/page.js
export const revalidate = 3600; // Regenerate every hour

export default async function Products() {
  const products = await fetch("https://api.example.com/products");
  return <div>{/* products list */}</div>;
}
```

**Use for:** E-commerce, news sites, data that changes hourly/daily

---

## Deploying Next.js to Vercel

### Step 1: Prepare Your Project

Ensure you have a Next.js project:

```bash
# Create new project
npx create-next-app@latest my-nextjs-app
cd my-nextjs-app
```

Verify package.json:

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  }
}
```

### Step 2: Deploy via Git

1. Push to GitHub:

   ```bash
   git add .
   git commit -m "Ready for deployment"
   git push origin main
   ```

2. Go to [vercel.com/new](https://vercel.com/new)
3. Select your repository
4. Vercel auto-detects Next.js
5. Click "Deploy"

### Step 3: Automatic Configuration

Vercel automatically sets:

```
Framework Preset: Next.js
Build Command: next build
Output Directory: .next
Node.js Version: 20.x
```

No additional configuration needed!

---

## Serverless Functions (Automatic)

When you create API routes in Next.js, Vercel automatically deploys them as **Serverless Functions**:

```javascript
// app/api/hello/route.js
export async function GET() {
  return Response.json({ message: "Hello from the API!" });
}
```

After deployment:

- Your page: `https://yourapp.vercel.app`
- Your API: `https://yourapp.vercel.app/api/hello`

No additional configuration—Vercel handles the infrastructure.

---

## Environment Variables in Next.js

### Server-Side Variables

Available only on the server:

```bash
# .env.local
DATABASE_URL=postgresql://...
API_SECRET=super-secret-key
```

```javascript
// app/api/data/route.js
const db = process.env.DATABASE_URL; // ✅ Works on server
```

### Client-Side Variables

Must use `NEXT_PUBLIC_` prefix:

```bash
# .env.local
NEXT_PUBLIC_API_URL=https://api.example.com
```

```javascript
// Any component
const apiUrl = process.env.NEXT_PUBLIC_API_URL; // ✅ Works in browser
```

### In Vercel Dashboard

Add variables for each environment:

```
DATABASE_URL: [Different for Production/Preview]
NEXT_PUBLIC_SITE_URL: https://yoursite.com
```

---

## Static Export (Optional)

If you don't need server features, export as static HTML:

```javascript
// next.config.js
const nextConfig = {
  output: "export",
};

export default nextConfig;
```

```bash
npm run build
# Creates /out directory with static files
```

This is useful for:

- GitHub Pages hosting
- S3/CloudFront hosting
- Environments without Node.js

Note: API routes and SSR won't work with static export.

---

## Build Output Explained

When Vercel builds your Next.js app:

```
Build Output:
├── .vercel/output/
│   ├── static/         # Static assets (CSS, JS, images)
│   ├── functions/      # Serverless functions (pages, API routes)
│   └── config.json     # Routing configuration
```

Vercel intelligently:

- Caches static assets on CDN
- Deploys functions to edge locations
- Configures routes automatically

---

## Common Next.js Deployment Issues

### Issue 1: Build Fails with TypeScript Errors

```
Type error: Property 'x' does not exist
```

**Fix:** Either fix the type errors or (not recommended) skip type checking:

```javascript
// next.config.js
const nextConfig = {
  typescript: {
    ignoreBuildErrors: true, // Not recommended for production
  },
};
```

### Issue 2: Image Optimization Not Working

```
Error: Image Optimization using default loader is not compatible with static export
```

**Fix:** If using static export, configure an external loader:

```javascript
// next.config.js
const nextConfig = {
  output: "export",
  images: {
    unoptimized: true,
  },
};
```

### Issue 3: Environment Variables Undefined

**Fix:**

1. Check if using `NEXT_PUBLIC_` prefix for client-side
2. Add variables in Vercel dashboard
3. Redeploy (env vars require rebuild)

---

## Vercel-Specific Features for Next.js

### Speed Insights

```javascript
// app/layout.js
import { SpeedInsights } from "@vercel/speed-insights/next";

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <SpeedInsights />
      </body>
    </html>
  );
}
```

### Analytics

```javascript
import { Analytics } from "@vercel/analytics/react";

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <Analytics />
      </body>
    </html>
  );
}
```

---

## Maria's Next.js Migration

Maria upgrades her dashboard to Next.js:

**Benefits gained:**

- ✅ SEO-friendly pages (SSR)
- ✅ Built-in API routes for data fetching
- ✅ Automatic image optimization
- ✅ Faster page loads with ISR

**Deployment:**

```bash
git push origin main
# Vercel automatically builds and deploys
# ✅ https://barangay-dashboard.vercel.app
```

---

## Key Takeaways

✓ Next.js is React with server-side rendering, routing, and API routes
✓ App Router is the modern approach (use for new projects)
✓ Vercel auto-detects Next.js and configures everything
✓ API routes become Serverless Functions automatically
✓ Use `NEXT_PUBLIC_` prefix for client-side environment variables
✓ Static export is available but removes server features

**Next Lesson:** Deploying Vue and Nuxt applications!
