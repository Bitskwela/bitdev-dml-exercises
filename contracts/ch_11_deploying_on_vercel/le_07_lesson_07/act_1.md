# React Deployment Activity

Maria's React app works beautifully on localhost. Now it's time to share it with the world! In this activity, you'll deploy a React application to Vercel.

## Task for Students

### Part 1: Pre-Deployment Quiz

**Question 1:** What command creates a production-ready React build?

- A) `npm start`
- B) `npm run build`
- C) `npm run deploy`
- D) `npm run production`

**Question 2:** What is the default output directory for Vite projects?

- A) `build/`
- B) `public/`
- C) `dist/`
- D) `out/`

**Question 3:** Which prefix must environment variables use in Vite?

- A) `REACT_APP_`
- B) `VITE_`
- C) `PUBLIC_`
- D) `ENV_`

**Question 4:** Why is Vite recommended over Create React App in 2026?

- A) It's older and more stable
- B) It's faster and actively maintained
- C) It has more features
- D) It's the only option that works

---

### Part 2: Deployment Exercise

**Option A: If you have a React project**

1. Ensure your project has a build script in `package.json`:

   ```json
   "scripts": {
     "build": "vite build"
   }
   ```

2. Test the build locally:

   ```bash
   npm run build
   ```

3. Verify the output directory (`dist/` or `build/`) exists

4. Deploy to Vercel:
   - **Via Git:** Push to GitHub, import in Vercel
   - **Via CLI:** Run `vercel` in your project folder

**Option B: If you need to create a project**

1. Create a new Vite React project:

   ```bash
   npm create vite@latest my-react-app -- --template react
   cd my-react-app
   npm install
   ```

2. Test locally:

   ```bash
   npm run dev
   ```

3. Deploy to Vercel:
   ```bash
   vercel
   ```

---

### Part 3: Configuration Verification

After deployment, verify these settings in Vercel Dashboard:

**Check Project Settings → General → Build Settings:**

| Setting          | Expected Value                 |
| ---------------- | ------------------------------ |
| Framework Preset | Vite (or Create React App)     |
| Build Command    | `npm run build`                |
| Output Directory | `dist` (Vite) or `build` (CRA) |
| Install Command  | `npm install`                  |

---

### Part 4: Environment Variables Exercise

**Step 1:** Add an environment variable to your React app

Create `.env.local` in your project root:

```
VITE_APP_NAME=My Awesome App
```

**Step 2:** Use it in your code

```javascript
// In App.jsx
function App() {
  return <h1>{import.meta.env.VITE_APP_NAME}</h1>;
}
```

**Step 3:** Add to Vercel

1. Go to Project Settings → Environment Variables
2. Add `VITE_APP_NAME` with a different value for Production
3. Redeploy and verify the change

---

### Part 5: Client-Side Routing (Bonus)

If your React app uses React Router:

**Step 1:** Create `vercel.json` in your project root:

```json
{
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}
```

**Step 2:** Commit and push:

```bash
git add vercel.json
git commit -m "Add rewrites for client-side routing"
git push
```

**Step 3:** Test by navigating directly to a route (e.g., `/dashboard`)

---

### Part 6: Troubleshooting Quiz

**Question 1:** Your build fails with "Cannot find module 'react'". What's the likely cause?

- A) React is not installed
- B) Wrong Node.js version
- C) Missing package-lock.json
- D) All of the above could cause this

**Question 2:** Your deployed app shows a blank page. What should you check first?

- A) Browser console for JavaScript errors
- B) Vercel build logs
- C) Output directory setting
- D) All of the above

---

### What You Learned

✓ React apps require a build step before deployment
✓ Vite uses `dist/` output directory; CRA uses `build/`
✓ Environment variables need `VITE_` prefix in Vite projects
✓ Client-side routing requires `vercel.json` rewrites
✓ Vercel auto-detects React frameworks

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-B, 4-B

Part 6: 1-D, 2-D
