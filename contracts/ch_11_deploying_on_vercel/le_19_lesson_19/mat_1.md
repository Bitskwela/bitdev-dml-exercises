# Le 19: Monorepo Deployments – One Repo, Many Projects

![Monorepo Deployments](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/monorepo-deployments.png)

## Background Story

Maria's barangay system has grown. What started as one dashboard is now three projects: a public website, an admin panel, and a shared component library.

"Managing three separate repositories is a headache," Maria sighs. "Every time I update a component, I have to update it in three places."

Marco has the solution. "Let's consolidate into a monorepo. One repository, multiple projects, shared code—and Vercel handles the deployments beautifully."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What is a monorepo
- Monorepo benefits and structure
- Turborepo setup and usage
- Configuring Vercel for monorepos
- Root Directory and Build settings
- Shared packages and libraries
- Caching and build optimization

---

## What is a Monorepo?

A monorepo (monolithic repository) is a single repository containing multiple projects:

```
Traditional Multi-Repo:
├── barangay-website/      (separate repo)
├── barangay-admin/        (separate repo)
└── barangay-components/   (separate repo)

Monorepo:
└── barangay-system/       (one repo)
    ├── apps/
    │   ├── website/       (deployable app)
    │   └── admin/         (deployable app)
    └── packages/
        └── ui/            (shared library)
```

---

## Why Use a Monorepo?

| Benefit                 | Description                               |
| ----------------------- | ----------------------------------------- |
| Code Sharing            | Share components, utilities, and types    |
| Atomic Changes          | Update shared code and consumers together |
| Consistent Tooling      | Same linting, testing, and build config   |
| Simplified Dependencies | One `node_modules`, coordinated versions  |
| Better Collaboration    | All code visible in one place             |

---

## Monorepo Structure

A typical Turborepo structure:

```
my-monorepo/
├── apps/
│   ├── web/               # Next.js website
│   │   ├── package.json
│   │   └── next.config.js
│   ├── admin/             # Next.js admin panel
│   │   ├── package.json
│   │   └── next.config.js
│   └── docs/              # Documentation site
│       └── package.json
├── packages/
│   ├── ui/                # Shared UI components
│   │   ├── package.json
│   │   └── src/
│   ├── config/            # Shared configs
│   │   ├── eslint/
│   │   └── typescript/
│   └── utils/             # Shared utilities
│       └── package.json
├── package.json           # Root package.json
├── turbo.json             # Turborepo config
└── pnpm-workspace.yaml    # Workspace config
```

---

## Setting Up Turborepo

### Create a New Monorepo

```bash
npx create-turbo@latest barangay-system
cd barangay-system
```

This creates:

- `apps/web` - Next.js app
- `apps/docs` - Another Next.js app
- `packages/ui` - Shared React components
- `packages/eslint-config` - ESLint configs
- `packages/typescript-config` - TypeScript configs

### Root package.json

```json
{
  "name": "barangay-system",
  "private": true,
  "scripts": {
    "build": "turbo build",
    "dev": "turbo dev",
    "lint": "turbo lint"
  },
  "devDependencies": {
    "turbo": "^2.0.0"
  },
  "packageManager": "pnpm@8.15.0"
}
```

### turbo.json

```json
{
  "$schema": "https://turbo.build/schema.json",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**", "dist/**"]
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

### pnpm-workspace.yaml

```yaml
packages:
  - "apps/*"
  - "packages/*"
```

---

## Using Shared Packages

### Creating a Shared UI Package

```typescript
// packages/ui/src/button.tsx
import React from "react";

interface ButtonProps {
  children: React.ReactNode;
  variant?: "primary" | "secondary";
  onClick?: () => void;
}

export function Button({
  children,
  variant = "primary",
  onClick,
}: ButtonProps) {
  const className =
    variant === "primary"
      ? "bg-blue-500 text-white"
      : "bg-gray-200 text-gray-800";

  return (
    <button className={`px-4 py-2 rounded ${className}`} onClick={onClick}>
      {children}
    </button>
  );
}
```

```typescript
// packages/ui/src/index.ts
export { Button } from "./button";
export { Card } from "./card";
export { Input } from "./input";
```

```json
// packages/ui/package.json
{
  "name": "@barangay/ui",
  "version": "0.0.1",
  "main": "./src/index.ts",
  "types": "./src/index.ts",
  "exports": {
    ".": "./src/index.ts"
  }
}
```

### Using Shared Package in Apps

```json
// apps/web/package.json
{
  "name": "web",
  "dependencies": {
    "@barangay/ui": "workspace:*"
  }
}
```

```typescript
// apps/web/app/page.tsx
import { Button, Card } from "@barangay/ui";

export default function Home() {
  return (
    <Card>
      <h1>Barangay Portal</h1>
      <Button onClick={() => alert("Clicked!")}>Get Started</Button>
    </Card>
  );
}
```

---

## Deploying Monorepos on Vercel

### Method 1: Multiple Projects (Recommended)

Create a separate Vercel project for each app:

**Project 1: barangay-website**

- Repository: `org/barangay-system`
- Root Directory: `apps/web`
- Framework: Next.js (auto-detected)

**Project 2: barangay-admin**

- Repository: `org/barangay-system`
- Root Directory: `apps/admin`
- Framework: Next.js (auto-detected)

### Configuring Root Directory

In Vercel Dashboard:

1. Project Settings → General
2. Root Directory: `apps/web`
3. Build Command: `cd ../.. && pnpm turbo build --filter=web`
4. Install Command: `pnpm install`

### Using vercel.json per App

```json
// apps/web/vercel.json
{
  "buildCommand": "cd ../.. && pnpm turbo build --filter=web",
  "installCommand": "pnpm install",
  "framework": "nextjs"
}
```

---

## Turborepo + Vercel Remote Caching

Vercel provides free remote caching for Turborepo builds:

### Enable Remote Caching

```bash
npx turbo login
npx turbo link
```

This:

1. Authenticates with Vercel
2. Links your repo to Vercel Remote Cache
3. Shares build cache across team and CI

### Benefits

```
First Build:
web: cache miss - building (45s)
admin: cache miss - building (40s)
ui: cache miss - building (10s)
Total: 95s

Second Build (with cache):
web: cache hit - restored from cache (0.5s)
admin: cache hit - restored from cache (0.5s)
ui: cache hit - restored from cache (0.5s)
Total: 1.5s (98% faster!)
```

---

## Filtering Builds

Only build what changed:

### Using --filter

```bash
# Build only the web app
pnpm turbo build --filter=web

# Build web and its dependencies
pnpm turbo build --filter=web...

# Build everything that changed since main
pnpm turbo build --filter=...[origin/main]
```

### Configuring Ignored Build Step

```bash
# In Vercel: Ignored Build Step
npx turbo-ignore web
```

This skips rebuilding if only unrelated apps changed.

---

## Shared Configuration Packages

### TypeScript Config

```json
// packages/typescript-config/base.json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["DOM", "DOM.Iterable", "ES2020"],
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "moduleResolution": "bundler"
  }
}
```

```json
// apps/web/tsconfig.json
{
  "extends": "@barangay/typescript-config/nextjs.json",
  "compilerOptions": {
    "baseUrl": "."
  },
  "include": ["**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
```

### ESLint Config

```javascript
// packages/eslint-config/next.js
module.exports = {
  extends: ["next/core-web-vitals", "turbo", "prettier"],
  rules: {
    "@next/next/no-html-link-for-pages": "off",
  },
};
```

---

## Running Development

```bash
# Run all apps in dev mode
pnpm dev

# Run specific app
pnpm dev --filter=web

# Run multiple apps
pnpm dev --filter=web --filter=admin
```

---

## Adding a New App

```bash
# From monorepo root
cd apps
npx create-next-app@latest api-docs
```

Update `apps/api-docs/package.json`:

```json
{
  "name": "api-docs",
  "dependencies": {
    "@barangay/ui": "workspace:*"
  }
}
```

Install dependencies:

```bash
pnpm install
```

---

## Maria's Monorepo

Maria consolidates her barangay projects:

```
barangay-system/
├── apps/
│   ├── portal/           # Public-facing website
│   ├── admin/            # Admin dashboard
│   └── api/              # Shared API
├── packages/
│   ├── ui/               # Shared components
│   ├── database/         # Database utilities
│   └── config/           # Shared configs
├── turbo.json
└── package.json
```

She creates three Vercel projects, each pointing to the same repo but different root directories.

---

## Key Takeaways

✓ Monorepos consolidate multiple projects in one repository
✓ Turborepo orchestrates builds with caching and parallelization
✓ Shared packages enable code reuse across apps
✓ Configure Root Directory in Vercel for each app
✓ Remote caching speeds up builds by 90%+
✓ Use --filter to build only what's needed

**Next Lesson:** Multi-Project Workspaces—linking projects and cross-project deployments!
