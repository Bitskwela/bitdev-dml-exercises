# Le 12: Framework Detection – How Vercel Knows What to Build

![Framework Detection](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/framework-detection.png)

## Background Story

Maria is helping a friend deploy their project. "Just run `vercel` and it handles everything," she explains.

"But how does it know what framework I'm using?" her friend asks.

Marco overhears the question. "Great question! Vercel has automatic framework detection. Let me show you how it works—and when you might need to override it."

**Time Allotment**: 45 minutes

**Topics Covered**:

- How Vercel detects frameworks
- Supported frameworks list
- Overriding detection settings
- Custom build configurations
- Troubleshooting detection issues

---

## How Framework Detection Works

When you deploy to Vercel, it analyzes your repository:

```
Detection Order:
1. Check vercel.json for explicit settings
2. Examine package.json dependencies
3. Look for configuration files
4. Analyze project structure
```

### Detection Signals

| Framework    | Detection Signal                             |
| ------------ | -------------------------------------------- |
| Next.js      | `next` in dependencies + `next.config.js`    |
| React (Vite) | `react` + `vite` in dependencies             |
| Vue (Vite)   | `vue` + `vite` in dependencies               |
| Nuxt         | `nuxt` in dependencies + `nuxt.config.ts`    |
| SvelteKit    | `@sveltejs/kit` + `svelte.config.js`         |
| Astro        | `astro` in dependencies + `astro.config.mjs` |
| Remix        | `@remix-run/react` in dependencies           |
| Gatsby       | `gatsby` in dependencies                     |

---

## Supported Frameworks (2026)

Vercel supports 35+ frameworks with zero configuration:

### React Ecosystem

- Next.js (first-class support)
- Create React App
- Vite + React
- Remix
- Gatsby

### Vue Ecosystem

- Nuxt 3
- Vite + Vue
- VuePress
- VitePress

### Other Frameworks

- Svelte / SvelteKit
- Astro
- Angular
- Solid.js
- Qwik
- Ember.js

### Static Generators

- Hugo
- Jekyll
- Eleventy (11ty)
- Docusaurus
- MkDocs

---

## Viewing Detected Settings

### In Vercel Dashboard

1. Go to Project → Settings → General
2. Find "Build & Development Settings"
3. You'll see:
   - Framework Preset
   - Build Command
   - Output Directory
   - Install Command

### Via CLI

```bash
vercel
# During setup, you'll see:
# ? Detected Next.js. Override settings? (y/N)
```

---

## Overriding Framework Detection

Sometimes you need to override the defaults:

### Method 1: Vercel Dashboard

1. Go to Project → Settings → General
2. Under "Build & Development Settings"
3. Toggle "Override" for any setting
4. Enter your custom value

### Method 2: vercel.json

Create `vercel.json` in your project root:

```json
{
  "framework": "nextjs",
  "buildCommand": "npm run build:production",
  "outputDirectory": "out",
  "installCommand": "npm ci"
}
```

### Method 3: Environment Variables

```bash
# Set in Vercel dashboard
VERCEL_FORCE_NO_BUILD_CACHE=1
```

---

## Common Override Scenarios

### Scenario 1: Monorepo with Multiple Frameworks

```json
// vercel.json
{
  "framework": "nextjs",
  "buildCommand": "cd packages/web && npm run build",
  "outputDirectory": "packages/web/.next"
}
```

### Scenario 2: Custom Build Script

```json
{
  "buildCommand": "npm run build:vercel"
}
```

In `package.json`:

```json
{
  "scripts": {
    "build": "next build",
    "build:vercel": "npm run pre-build && next build && npm run post-build"
  }
}
```

### Scenario 3: Non-Standard Output Directory

```json
{
  "outputDirectory": "public_html"
}
```

### Scenario 4: Static Export from Next.js

```json
{
  "framework": "nextjs",
  "outputDirectory": "out"
}
```

With `next.config.js`:

```javascript
const nextConfig = {
  output: "export",
};
export default nextConfig;
```

---

## Build Command Reference

### Standard Build Commands

| Framework | Default Build Command |
| --------- | --------------------- |
| Next.js   | `next build`          |
| Vite      | `vite build`          |
| Nuxt      | `nuxt build`          |
| SvelteKit | `vite build`          |
| Astro     | `astro build`         |
| CRA       | `react-scripts build` |

### Custom Build Commands

```json
{
  "buildCommand": "npm run custom-build"
}
```

Or use shell commands:

```json
{
  "buildCommand": "npm run build && cp -r static/* dist/"
}
```

---

## Output Directory Reference

| Framework        | Default Output |
| ---------------- | -------------- |
| Next.js          | `.next`        |
| Next.js (export) | `out`          |
| Vite             | `dist`         |
| Nuxt             | `.output`      |
| SvelteKit        | `.svelte-kit`  |
| Astro            | `dist`         |
| CRA              | `build`        |

---

## Install Command Options

### Default

```bash
npm install
# or
yarn install
# or
pnpm install
```

### Custom Install Commands

```json
{
  "installCommand": "npm ci --legacy-peer-deps"
}
```

### Skip Install

```json
{
  "installCommand": "echo 'Skipping install'"
}
```

---

## Node.js Version

Specify the Node.js version for builds:

### In Vercel Dashboard

Project → Settings → General → Node.js Version

### In package.json

```json
{
  "engines": {
    "node": "20.x"
  }
}
```

### Available Versions (2026)

- 18.x (LTS)
- 20.x (LTS, recommended)
- 22.x (Current)

---

## Root Directory Setting

For monorepos or nested projects:

```json
// vercel.json
{
  "rootDirectory": "packages/frontend"
}
```

Or in dashboard:
Project → Settings → General → Root Directory

---

## Ignoring the Build

Skip builds for certain commits:

### Using Commit Message

```bash
git commit -m "Update README [skip ci]"
```

### Using vercel.json

```json
{
  "ignoreCommand": "bash ignore-build.sh"
}
```

Create `ignore-build.sh`:

```bash
#!/bin/bash
# Exit 0 to skip build, exit 1 to continue
if [[ "$VERCEL_GIT_COMMIT_MESSAGE" == *"[skip-build]"* ]]; then
  exit 0
fi
exit 1
```

---

## Troubleshooting Detection

### Issue 1: Wrong Framework Detected

```
Detected: Create React App
Actual: Vite + React
```

**Fix:** Set explicitly in vercel.json:

```json
{
  "framework": "vite"
}
```

### Issue 2: No Framework Detected

```
No framework detected. Defaulting to static.
```

**Causes:**

- Missing dependencies in package.json
- package.json not in root
- Unusual project structure

**Fix:** Check package.json location or set framework explicitly.

### Issue 3: Build Command Not Found

```
Error: npm run build not found
```

**Fix:** Ensure build script exists in package.json:

```json
{
  "scripts": {
    "build": "your-build-command"
  }
}
```

---

## Best Practices

### DO ✅

```
✅ Let Vercel auto-detect when possible
✅ Use vercel.json for complex setups
✅ Specify Node.js version for consistency
✅ Test builds locally before pushing
✅ Use CI skip flags for documentation-only changes
```

### DON'T ❌

```
❌ Override without understanding defaults
❌ Hardcode paths that differ locally vs Vercel
❌ Forget to update settings when changing frameworks
❌ Ignore build errors in logs
```

---

## Key Takeaways

✓ Vercel auto-detects frameworks from package.json and config files
✓ 35+ frameworks are supported with zero config
✓ Override settings via dashboard or vercel.json
✓ Root Directory setting is key for monorepos
✓ Specify Node.js version for consistent builds
✓ Check build logs when detection fails

**Next Lesson:** Serverless Functions—backend without servers!
