# Monorepo Deployments Activity

Monorepos let you manage multiple projects in one repository. In this activity, you'll set up and deploy a monorepo to Vercel.

## Task for Students

### Part 1: Monorepo Concepts Quiz

**Question 1:** What is a monorepo?

- A) A repository with only one project
- B) A single repository containing multiple projects
- C) A repository for MongoDB
- D) A private repository

**Question 2:** Which tool orchestrates monorepo builds with caching?

- A) Webpack
- B) Vite
- C) Turborepo
- D) Babel

**Question 3:** Where are shared packages typically stored in a Turborepo?

- A) /shared
- B) /packages
- C) /libs
- D) /common

**Question 4:** What Vercel setting specifies which app to build?

- A) Build Path
- B) Output Directory
- C) Root Directory
- D) Source Folder

**Question 5:** What does `workspace:*` mean in package.json?

- A) Install from npm
- B) Install from local workspace
- C) Install latest version
- D) Install globally

---

### Part 2: Create a Monorepo

**Step 1:** Create new monorepo:

```bash
npx create-turbo@latest my-monorepo
cd my-monorepo
```

**Step 2:** Explore the structure:

```bash
# List all workspaces
ls apps/
ls packages/
```

**Step 3:** Examine turbo.json:

```json
{
  "$schema": "https://turbo.build/schema.json",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "lint": {
      "dependsOn": ["^lint"]
    }
  }
}
```

**Step 4:** Run development:

```bash
pnpm dev
```

Visit http://localhost:3000 (web) and http://localhost:3001 (docs).

---

### Part 3: Create a Shared Package

**Step 1:** Create a new shared package:

```bash
mkdir -p packages/utils/src
```

**Step 2:** Create package.json:

```json
// packages/utils/package.json
{
  "name": "@repo/utils",
  "version": "0.0.1",
  "main": "./src/index.ts",
  "types": "./src/index.ts",
  "exports": {
    ".": "./src/index.ts"
  }
}
```

**Step 3:** Add utility functions:

```typescript
// packages/utils/src/index.ts
export function formatDate(date: Date): string {
  return date.toLocaleDateString("en-PH", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}

export function formatCurrency(amount: number): string {
  return new Intl.NumberFormat("en-PH", {
    style: "currency",
    currency: "PHP",
  }).format(amount);
}

export function slugify(text: string): string {
  return text
    .toLowerCase()
    .replace(/\s+/g, "-")
    .replace(/[^\w-]/g, "");
}
```

**Step 4:** Use in an app:

```json
// apps/web/package.json
{
  "dependencies": {
    "@repo/utils": "workspace:*"
  }
}
```

```bash
pnpm install
```

```typescript
// apps/web/app/page.tsx
import { formatDate, formatCurrency } from "@repo/utils";

export default function Home() {
  return (
    <div>
      <p>Today: {formatDate(new Date())}</p>
      <p>Price: {formatCurrency(1500)}</p>
    </div>
  );
}
```

---

### Part 4: Configure Vercel Deployment

**Scenario:** Deploy the `web` app from your monorepo.

**Step 1:** Push to GitHub:

```bash
git init
git add .
git commit -m "Initial monorepo"
git remote add origin https://github.com/your-username/my-monorepo.git
git push -u origin main
```

**Step 2:** Import to Vercel:

1. Go to vercel.com → Import Project
2. Select your monorepo repository
3. Configure settings:
   - **Root Directory:** `apps/web`
   - **Framework:** Next.js (auto-detected)
   - **Build Command:** `cd ../.. && pnpm turbo build --filter=web`
   - **Install Command:** `pnpm install`

**Step 3:** Deploy!

---

### Part 5: vercel.json Configuration

**Task:** Create vercel.json for each app:

```json
// apps/web/vercel.json
{
  "buildCommand": "cd ../.. && pnpm turbo build --filter=web",
  "installCommand": "pnpm install",
  "framework": "nextjs"
}
```

```json
// apps/docs/vercel.json
{
  "buildCommand": "cd ../.. && pnpm turbo build --filter=docs",
  "installCommand": "pnpm install",
  "framework": "nextjs"
}
```

---

### Part 6: Enable Remote Caching

**Step 1:** Login to Vercel:

```bash
npx turbo login
```

**Step 2:** Link your repo:

```bash
npx turbo link
```

**Step 3:** Test caching:

```bash
# First build
pnpm build

# Second build (should be cached)
pnpm build
```

You should see "FULL TURBO" for cached tasks.

---

### Part 7: Filtering Builds

**Task:** Practice using Turborepo filters.

```bash
# Build only web app
pnpm turbo build --filter=web

# Build web and all its dependencies
pnpm turbo build --filter=web...

# Build everything that depends on @repo/ui
pnpm turbo build --filter=...@repo/ui

# Dry run to see what would build
pnpm turbo build --filter=web --dry-run
```

**Question:** If you change a file in `packages/ui`, which command builds all affected apps?

---

### Part 8: Adding a New App

**Task:** Add a new admin app to the monorepo.

**Step 1:** Create the app:

```bash
cd apps
npx create-next-app@latest admin --typescript --tailwind --app
```

**Step 2:** Update package.json:

```json
// apps/admin/package.json
{
  "name": "admin",
  "dependencies": {
    "@repo/ui": "workspace:*",
    "@repo/utils": "workspace:*"
  }
}
```

**Step 3:** Install and run:

```bash
cd ../..
pnpm install
pnpm dev --filter=admin
```

**Step 4:** Create another Vercel project for admin:

- Root Directory: `apps/admin`
- Same build configuration pattern

---

### Part 9: Match the Concept

Match each monorepo concept to its description:

| Concept           | Description |
| ----------------- | ----------- |
| `workspace:*`     | \_\_\_      |
| `--filter=app...` | \_\_\_      |
| `^build`          | \_\_\_      |
| Remote caching    | \_\_\_      |
| Root Directory    | \_\_\_      |

Options:
A. Build app and its dependencies
B. Tells Vercel which folder contains the app
C. Link to local package in monorepo
D. Share build cache across machines
E. Build dependencies first

---

### What You Learned

✓ Create a monorepo with Turborepo
✓ Structure apps and packages correctly
✓ Create and use shared packages
✓ Configure Vercel for monorepo deployments
✓ Enable remote caching for faster builds
✓ Use filters to build specific apps

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-B, 4-C, 5-B

Part 7: `pnpm turbo build --filter=...@repo/ui`

Part 9:

- `workspace:*` → C
- `--filter=app...` → A
- `^build` → E
- Remote caching → D
- Root Directory → B
