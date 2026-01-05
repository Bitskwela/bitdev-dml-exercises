# Le 07: Deploying React Apps – From localhost to Production

![React Deployment](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/react-deploy.png)

## Background Story

Maria's static HTML dashboard was just a prototype. The real Barangay Blockchain dashboard is built with React—a powerful JavaScript library for building user interfaces.

"This is so much more complex," Maria admits, looking at her `package.json`, dozens of dependencies, and a `node_modules` folder with thousands of files. "How do I deploy all of this?"

"React apps need to be **built** before deployment," Marco explains. "Vercel handles this automatically. Let me show you."

**Time Allotment**: 45 minutes

**Topics Covered**:

- How React builds work
- Vite vs Create React App
- Configuring build settings
- Output directories
- Common deployment errors
- Environment variables in React

---

## How React Deployment Works

When you develop React locally, you're running a development server:

```bash
npm run dev    # Vite
npm start      # Create React App
```

This is NOT what gets deployed. For production, React apps must be **built**:

```bash
npm run build
```

This creates optimized, minified files:

```
Development:
├── src/
│   ├── App.jsx (10 KB)
│   ├── components/ (50 KB)
│   └── styles/ (20 KB)
└── Total: ~80 KB of source code

Production Build:
├── dist/
│   ├── index.html
│   ├── assets/
│   │   ├── index-a1b2c3.js (45 KB minified)
│   │   └── index-d4e5f6.css (8 KB minified)
└── Total: ~53 KB optimized
```

---

## Vite vs Create React App

In 2026, most new React projects use **Vite** (pronounced "veet"):

| Feature        | Create React App  | Vite                |
| -------------- | ----------------- | ------------------- |
| Build Speed    | Slower            | 10-100x faster      |
| Dev Server     | Slower startup    | Instant startup     |
| Bundle Size    | Larger            | Smaller             |
| Maintenance    | Deprecated (2023) | Actively maintained |
| Vercel Support | ✅                | ✅ (Recommended)    |

### Vite Project Structure

```
my-react-app/
├── public/
│   └── favicon.ico
├── src/
│   ├── App.jsx
│   ├── main.jsx
│   └── index.css
├── index.html
├── package.json
└── vite.config.js
```

### Build Output

```bash
# Run build
npm run build

# Output directory
dist/
├── index.html
└── assets/
    ├── index-abc123.js
    └── index-def456.css
```

---

## Deploying React to Vercel

### Method 1: Git Integration (Recommended)

**Step 1: Push to GitHub**

```bash
git add .
git commit -m "Ready for deployment"
git push origin main
```

**Step 2: Import Project**

1. Go to [vercel.com/new](https://vercel.com/new)
2. Select your GitHub repository
3. Vercel auto-detects "Vite" or "Create React App"
4. Click "Deploy"

**Step 3: Automatic Configuration**

Vercel sets:

```
Build Command: npm run build
Output Directory: dist
Install Command: npm install
```

### Method 2: CLI Deployment

```bash
# Navigate to project
cd my-react-app

# Deploy
vercel

# Vercel auto-detects React/Vite
# ✅ Production: https://my-react-app.vercel.app
```

---

## Framework Detection

Vercel automatically detects your framework by checking:

1. **package.json dependencies**

   - `react` → React
   - `vite` → Vite build
   - `react-scripts` → Create React App

2. **Configuration files**

   - `vite.config.js` → Vite
   - `next.config.js` → Next.js

3. **Build scripts**
   - `"build": "vite build"` → Vite

If detection fails, you can override settings manually.

---

## Configuring Build Settings

### In Vercel Dashboard

1. Go to Project → Settings → General
2. Find "Build & Development Settings"
3. Configure:

```
Framework Preset: Vite
Build Command: npm run build
Output Directory: dist
Install Command: npm install
Node.js Version: 20.x
```

### Common Overrides

```
# For Vite
Build Command: npm run build
Output Directory: dist

# For Create React App
Build Command: npm run build
Output Directory: build

# Custom
Build Command: npm run build:production
Output Directory: dist/app
```

---

## Environment Variables in React

### Vite Projects

Environment variables must use the `VITE_` prefix:

```bash
# .env.local
VITE_API_URL=https://api.example.com
VITE_APP_TITLE=Barangay Dashboard
```

Access in code:

```javascript
const apiUrl = import.meta.env.VITE_API_URL;
const title = import.meta.env.VITE_APP_TITLE;
```

### Create React App Projects

Use the `REACT_APP_` prefix:

```bash
# .env.local
REACT_APP_API_URL=https://api.example.com
```

Access in code:

```javascript
const apiUrl = process.env.REACT_APP_API_URL;
```

### In Vercel Dashboard

Add variables with the correct prefix:

```
Key:   VITE_API_URL
Value: https://api.production.com
Environments: ✓ Production ✓ Preview
```

---

## Common Deployment Errors

### Error 1: Missing Build Command

```
Error: No build command found
```

**Fix:** Add build script to package.json:

```json
{
  "scripts": {
    "build": "vite build"
  }
}
```

### Error 2: Wrong Output Directory

```
Error: Could not find output directory
```

**Fix:** Check your output directory setting:

- Vite: `dist`
- CRA: `build`
- Custom: Check your build tool config

### Error 3: Dependency Installation Failed

```
Error: Cannot find module 'react'
```

**Fix:** Ensure all dependencies are in `package.json`:

```bash
npm install
git add package.json package-lock.json
git commit -m "Fix dependencies"
git push
```

### Error 4: Environment Variable Not Found

```
TypeError: Cannot read property 'VITE_API_URL' of undefined
```

**Fix:**

1. Check prefix (`VITE_` for Vite)
2. Add variable in Vercel dashboard
3. Redeploy

---

## Client-Side Routing

React apps often use React Router for navigation. For this to work, Vercel needs to know all routes should serve `index.html`.

### Create vercel.json

```json
{
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}
```

This ensures `/dashboard`, `/profile`, and other routes load your React app instead of returning 404.

---

## Build Optimization Tips

### 1. Analyze Bundle Size

```bash
# Add to package.json
"scripts": {
  "build": "vite build",
  "analyze": "vite build --mode analyze"
}
```

### 2. Code Splitting

```javascript
// Lazy load heavy components
const Dashboard = React.lazy(() => import("./Dashboard"));
```

### 3. Remove Unused Dependencies

```bash
# Check for unused packages
npx depcheck
```

### 4. Optimize Images

Use Vercel's Image Optimization or next/image for better performance.

---

## Maria's React Deployment

Maria deploys her Barangay Dashboard:

```bash
# Create production build locally first (optional)
npm run build

# Deploy to Vercel
vercel

# Output:
🔗 https://barangay-dashboard.vercel.app
```

The build process:

1. Vercel clones her repo
2. Runs `npm install`
3. Runs `npm run build`
4. Uploads `dist/` to global CDN
5. App is live worldwide

---

## Key Takeaways

✓ React apps must be built before deployment (`npm run build`)
✓ Vite outputs to `dist/`, Create React App to `build/`
✓ Vercel auto-detects React frameworks
✓ Use `VITE_` prefix for environment variables in Vite
✓ Add `vercel.json` rewrites for client-side routing
✓ Check build logs for common errors

**Next Lesson:** Deploying Next.js—the React framework with superpowers!
