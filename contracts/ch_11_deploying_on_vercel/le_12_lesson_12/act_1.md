# Framework Detection Activity

Vercel's automatic framework detection makes deployment seamless. In this activity, you'll explore how detection works and when to override it.

## Task for Students

### Part 1: Detection Knowledge Quiz

**Question 1:** What does Vercel check first when detecting your framework?

- A) The folder structure
- B) vercel.json settings
- C) package.json dependencies
- D) README.md content

**Question 2:** If Vercel can't detect a framework, what does it default to?

- A) Next.js
- B) Static site
- C) React
- D) Error

**Question 3:** Where do you override build settings in Vercel?

- A) Only in vercel.json
- B) Only in the dashboard
- C) Both vercel.json and dashboard
- D) In package.json only

**Question 4:** What is the default output directory for Vite projects?

- A) `build/`
- B) `public/`
- C) `dist/`
- D) `.vite/`

**Question 5:** How do you specify Node.js version for Vercel builds?

- A) In vercel.json only
- B) In package.json engines field
- C) In the dashboard only
- D) Both B and C

---

### Part 2: Detection Investigation

**Step 1:** Create a minimal package.json:

```json
{
  "name": "detection-test",
  "version": "1.0.0",
  "scripts": {
    "build": "echo 'Building...'"
  },
  "dependencies": {}
}
```

**Step 2:** Run `vercel` and observe:

- What framework does it detect?
- What build command does it use?
- What output directory does it expect?

**Step 3:** Add React as a dependency:

```json
{
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  }
}
```

**Step 4:** Run `vercel` again:

- Did the detected framework change?

---

### Part 3: Override Exercise

**Step 1:** Create a vercel.json file:

```json
{
  "framework": null,
  "buildCommand": "npm run custom-build",
  "outputDirectory": "public"
}
```

**Step 2:** Update package.json:

```json
{
  "scripts": {
    "custom-build": "mkdir -p public && echo '<h1>Hello Vercel!</h1>' > public/index.html"
  }
}
```

**Step 3:** Deploy and verify your custom build works

**Questions:**

- What happens when framework is set to null?
- Why might you need a custom build command?

---

### Part 4: Framework Identification Exercise

Look at each package.json snippet and identify the framework:

**Project A:**

```json
{
  "dependencies": {
    "next": "14.0.0",
    "react": "18.2.0"
  }
}
```

Framework: ******\_\_\_******

**Project B:**

```json
{
  "dependencies": {
    "nuxt": "3.8.0",
    "vue": "3.3.0"
  }
}
```

Framework: ******\_\_\_******

**Project C:**

```json
{
  "dependencies": {
    "astro": "4.0.0"
  }
}
```

Framework: ******\_\_\_******

**Project D:**

```json
{
  "devDependencies": {
    "@sveltejs/kit": "2.0.0",
    "svelte": "4.2.0"
  }
}
```

Framework: ******\_\_\_******

**Project E:**

```json
{
  "dependencies": {
    "react": "18.2.0",
    "vite": "5.0.0"
  }
}
```

Framework: ******\_\_\_******

---

### Part 5: Monorepo Configuration

For a monorepo structure:

```
my-monorepo/
├── package.json
├── packages/
│   ├── frontend/
│   │   ├── package.json
│   │   └── src/
│   └── backend/
│       └── package.json
```

**Task:** Write a vercel.json that deploys only the frontend:

```json
{
  // Your configuration here
}
```

**Answer:**

```json
{
  "framework": "vite",
  "rootDirectory": "packages/frontend"
}
```

---

### Part 6: Build Settings Reference Card

Fill in the table for each framework:

| Framework | Build Command      | Output Directory   |
| --------- | ------------------ | ------------------ |
| Next.js   | ******\_\_\_****** | ******\_\_\_****** |
| Vite      | ******\_\_\_****** | ******\_\_\_****** |
| Nuxt 3    | ******\_\_\_****** | ******\_\_\_****** |
| Astro     | ******\_\_\_****** | ******\_\_\_****** |
| CRA       | ******\_\_\_****** | ******\_\_\_****** |

---

### Part 7: Troubleshooting Scenarios

**Scenario 1:** Build fails with "npm run build not found"

What's the likely cause?

- A) Wrong Node.js version
- B) Missing build script in package.json
- C) Wrong framework detected
- D) Network error

**Scenario 2:** Your Vite React app is detected as Create React App

How do you fix this?

```json
// Write your vercel.json fix:
```

**Scenario 3:** Build succeeds but site shows 404

What should you check?

- A) Output directory setting
- B) Build command
- C) Root directory
- D) All of the above

---

### What You Learned

✓ Vercel detects frameworks from package.json and config files
✓ vercel.json allows explicit configuration
✓ Root Directory setting is essential for monorepos
✓ Each framework has specific build commands and output directories
✓ You can override any detection setting

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-C, 4-C, 5-D

Part 4:

- Project A: Next.js
- Project B: Nuxt 3
- Project C: Astro
- Project D: SvelteKit
- Project E: Vite (with React)

Part 6:
| Framework | Build Command | Output Directory |
|-----------|---------------|------------------|
| Next.js | `next build` | `.next` |
| Vite | `vite build` | `dist` |
| Nuxt 3 | `nuxt build` | `.output` |
| Astro | `astro build` | `dist` |
| CRA | `react-scripts build` | `build` |

Part 7:

- Scenario 1: B
- Scenario 2: `{ "framework": "vite" }`
- Scenario 3: D
