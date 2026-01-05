# Le 20: Multi-Project Workspaces – Linking and Managing Dependencies

![Multi-Project Workspaces](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/multi-project-workspaces.png)

## Background Story

Maria's barangay platform now has three apps deployed from her monorepo. But managing dependencies between them is getting complex.

"How do I make sure the dashboard uses the latest version of my shared components?" Maria asks.

"Let's explore workspace dependencies," Marco replies. "We'll link your packages properly so changes propagate automatically."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Workspace dependency management
- Internal vs external packages
- Version syncing strategies
- Build order and dependency graphs
- Cross-project imports
- Managing shared TypeScript configurations

---

## Understanding Workspace Dependencies

In a monorepo, you have two types of dependencies:

### External Dependencies

Packages from npm:

```json
{
  "dependencies": {
    "react": "^18.2.0",
    "next": "^14.0.0"
  }
}
```

### Internal/Workspace Dependencies

Packages from your monorepo:

```json
{
  "dependencies": {
    "@barangay/ui": "workspace:*",
    "@barangay/utils": "workspace:*"
  }
}
```

---

## Workspace Protocol

### pnpm

```json
{
  "dependencies": {
    "@barangay/ui": "workspace:*"
  }
}
```

Variants:

- `workspace:*` - Any version (most common)
- `workspace:^` - Compatible versions
- `workspace:~` - Patch versions only

### npm/yarn

```json
{
  "dependencies": {
    "@barangay/ui": "*"
  }
}
```

With npm workspaces, just use `*` and npm resolves from the workspace.

---

## Dependency Graph

Turborepo builds a dependency graph automatically:

```
apps/dashboard
  └── depends on @barangay/ui
  └── depends on @barangay/utils

apps/admin
  └── depends on @barangay/ui

packages/ui
  └── depends on @barangay/utils

packages/utils
  └── no internal dependencies
```

Build order:

1. `packages/utils` (no deps)
2. `packages/ui` (depends on utils)
3. `apps/dashboard` and `apps/admin` (depend on ui)

---

## Configuring Package Exports

### Modern Package Exports

```json
// packages/ui/package.json
{
  "name": "@barangay/ui",
  "version": "0.0.0",
  "private": true,
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "import": "./dist/index.mjs",
      "require": "./dist/index.js"
    },
    "./button": {
      "types": "./dist/button.d.ts",
      "import": "./dist/button.mjs"
    },
    "./card": {
      "types": "./dist/card.d.ts",
      "import": "./dist/card.mjs"
    }
  }
}
```

### For Development (No Build Step)

```json
// packages/ui/package.json
{
  "name": "@barangay/ui",
  "version": "0.0.0",
  "private": true,
  "main": "./src/index.ts",
  "types": "./src/index.ts",
  "exports": {
    ".": "./src/index.ts",
    "./button": "./src/button.tsx"
  }
}
```

---

## Importing Internal Packages

### Standard Import

```tsx
// apps/dashboard/app/page.tsx
import { Button, Card } from "@barangay/ui";
import { formatDate } from "@barangay/utils";
```

### Subpath Imports

```tsx
// Import specific components
import { Button } from "@barangay/ui/button";
import { Card } from "@barangay/ui/card";
```

### TypeScript Configuration

Apps need to understand internal packages:

```json
// apps/dashboard/tsconfig.json
{
  "compilerOptions": {
    "paths": {
      "@barangay/ui": ["../../packages/ui/src"],
      "@barangay/ui/*": ["../../packages/ui/src/*"]
    }
  }
}
```

Or use TypeScript project references.

---

## Shared TypeScript Configuration

### Create Base Config

```json
// packages/typescript-config/base.json
{
  "$schema": "https://json.schemastore.org/tsconfig",
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "resolveJsonModule": true,
    "isolatedModules": true
  }
}
```

### Create Next.js Config

```json
// packages/typescript-config/nextjs.json
{
  "$schema": "https://json.schemastore.org/tsconfig",
  "extends": "./base.json",
  "compilerOptions": {
    "jsx": "preserve",
    "noEmit": true,
    "plugins": [{ "name": "next" }]
  }
}
```

### Use in Apps

```json
// apps/dashboard/tsconfig.json
{
  "extends": "@barangay/typescript-config/nextjs.json",
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
```

---

## Shared ESLint Configuration

### Create Config Package

```javascript
// packages/eslint-config/next.js
module.exports = {
  extends: ["next", "next/core-web-vitals", "prettier"],
  rules: {
    "@next/next/no-html-link-for-pages": "off",
  },
};
```

### Use in Apps

```javascript
// apps/dashboard/.eslintrc.js
module.exports = {
  root: true,
  extends: ["@barangay/eslint-config/next"],
};
```

---

## Version Syncing

### Option 1: All Same Version

Keep all packages at the same version:

```json
// packages/ui/package.json
{ "version": "1.0.0" }

// packages/utils/package.json
{ "version": "1.0.0" }
```

### Option 2: Independent Versions

Each package has its own version:

```json
// packages/ui/package.json
{ "version": "2.3.1" }

// packages/utils/package.json
{ "version": "1.5.0" }
```

### Tools for Version Management

- **Changesets**: `npx changeset init`
- **Lerna**: `npx lerna version`

---

## Turborepo Task Dependencies

### turbo.json Configuration

```json
{
  "$schema": "https://turbo.build/schema.json",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "dist/**"]
    },
    "lint": {
      "dependsOn": ["^lint"]
    },
    "test": {
      "dependsOn": ["build"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    }
  }
}
```

### Task Dependency Symbols

| Symbol    | Meaning                         |
| --------- | ------------------------------- |
| `^build`  | Run build in dependencies first |
| `build`   | Run build in this package       |
| `//build` | Run build in root package       |

---

## Cross-Project Type Sharing

### Create Types Package

```typescript
// packages/types/src/index.ts
export interface Resident {
  id: number;
  name: string;
  barangay: string;
  age?: number;
}

export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: string;
}
```

### Use Across Apps

```typescript
// apps/dashboard/app/api/residents/route.ts
import type { Resident, ApiResponse } from "@barangay/types";

export async function GET(): Promise<Response> {
  const residents: Resident[] = await fetchResidents();
  const response: ApiResponse<Resident[]> = {
    success: true,
    data: residents,
  };
  return Response.json(response);
}
```

---

## Managing External Dependencies

### Hoist Common Dependencies

```json
// package.json (root)
{
  "devDependencies": {
    "typescript": "^5.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0"
  }
}
```

### Per-Package Dependencies

```json
// apps/dashboard/package.json
{
  "dependencies": {
    "next": "^14.0.0",
    "react": "^18.2.0"
  }
}
```

---

## Maria's Workspace Structure

Maria's final monorepo structure:

```
barangay-platform/
├── apps/
│   ├── dashboard/
│   │   ├── package.json (depends on ui, utils, types)
│   │   └── ...
│   ├── admin/
│   │   ├── package.json (depends on ui, utils, types)
│   │   └── ...
│   └── api/
│       ├── package.json (depends on types, database)
│       └── ...
├── packages/
│   ├── ui/                    # Shared components
│   ├── utils/                 # Utility functions
│   ├── types/                 # Shared TypeScript types
│   ├── database/              # Prisma schema & client
│   ├── eslint-config/         # ESLint configurations
│   └── typescript-config/     # TypeScript configurations
├── package.json
├── pnpm-workspace.yaml
└── turbo.json
```

---

## Key Takeaways

✓ Use `workspace:*` to reference internal packages
✓ Configure package exports for proper imports
✓ Share TypeScript and ESLint configs across apps
✓ Use `^build` in turbo.json to build dependencies first
✓ Create a types package for cross-project type sharing
✓ Hoist common dependencies to root package.json

**Next Lesson:** Team Collaboration—access control, roles, and team workflows!
