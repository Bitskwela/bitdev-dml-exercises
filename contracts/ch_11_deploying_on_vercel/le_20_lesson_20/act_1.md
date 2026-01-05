# Multi-Project Workspaces Activity

Managing dependencies across multiple projects requires careful configuration. In this activity, you'll link packages and manage dependencies in a monorepo.

## Task for Students

### Part 1: Workspace Concepts Quiz

**Question 1:** What does `workspace:*` mean in package.json?

- A) Install from npm
- B) Use the local workspace package
- C) Skip installation
- D) Install the latest version

**Question 2:** What does `^build` mean in turbo.json?

- A) Build this package only
- B) Build dependencies first, then this package
- C) Skip the build step
- D) Build in parallel

**Question 3:** Where should shared TypeScript configurations go?

- A) Root package.json
- B) Each app's tsconfig.json
- C) A dedicated config package
- D) vercel.json

**Question 4:** What is the purpose of package exports?

- A) To export environment variables
- B) To define which files can be imported and how
- C) To export to npm
- D) To define build outputs

**Question 5:** In a monorepo, where should common dev dependencies like TypeScript go?

- A) Each package individually
- B) Root package.json
- C) Only in the main app
- D) vercel.json

---

### Part 2: Create a Shared Package

**Step 1:** Create a utils package:

```bash
mkdir -p packages/utils/src
```

**Step 2:** Create package.json:

```json
// packages/utils/package.json
{
  "name": "@barangay/utils",
  "version": "0.0.0",
  "private": true,
  "main": "./src/index.ts",
  "types": "./src/index.ts",
  "exports": {
    ".": "./src/index.ts",
    "./dates": "./src/dates.ts",
    "./strings": "./src/strings.ts"
  }
}
```

**Step 3:** Create utility modules:

```typescript
// packages/utils/src/dates.ts
export function formatDate(date: Date): string {
  return date.toLocaleDateString("en-PH", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}

export function isToday(date: Date): boolean {
  const today = new Date();
  return date.toDateString() === today.toDateString();
}
```

```typescript
// packages/utils/src/strings.ts
export function capitalize(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

export function slugify(str: string): string {
  return str.toLowerCase().replace(/\s+/g, "-");
}
```

```typescript
// packages/utils/src/index.ts
export * from "./dates";
export * from "./strings";
```

---

### Part 3: Link Package to App

**Step 1:** Add dependency to app:

```json
// apps/web/package.json
{
  "dependencies": {
    "@barangay/utils": "workspace:*"
  }
}
```

**Step 2:** Install dependencies:

```bash
pnpm install
```

**Step 3:** Use in your app:

```tsx
// apps/web/app/page.tsx
import { formatDate, capitalize } from "@barangay/utils";
// Or import from subpath:
import { formatDate } from "@barangay/utils/dates";

export default function Page() {
  return (
    <div>
      <p>Today: {formatDate(new Date())}</p>
      <p>{capitalize("hello world")}</p>
    </div>
  );
}
```

---

### Part 4: Create Shared Types Package

**Step 1:** Create types package:

```bash
mkdir -p packages/types/src
```

**Step 2:** Create package.json:

```json
// packages/types/package.json
{
  "name": "@barangay/types",
  "version": "0.0.0",
  "private": true,
  "main": "./src/index.ts",
  "types": "./src/index.ts"
}
```

**Step 3:** Define shared types:

```typescript
// packages/types/src/index.ts
export interface Resident {
  id: number;
  name: string;
  barangay: string;
  age?: number;
  createdAt: Date;
}

export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: {
    code: string;
    message: string;
  };
}

export type ResidentCreateInput = Omit<Resident, "id" | "createdAt">;
```

**Step 4:** Use in apps:

```typescript
// apps/web/app/api/residents/route.ts
import type { Resident, ApiResponse } from "@barangay/types";

export async function GET() {
  const residents: Resident[] = []; // fetch from db
  const response: ApiResponse<Resident[]> = {
    success: true,
    data: residents,
  };
  return Response.json(response);
}
```

---

### Part 5: Shared TypeScript Config

**Step 1:** Create config package:

```bash
mkdir packages/typescript-config
```

**Step 2:** Create base config:

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
    "isolatedModules": true,
    "declaration": true,
    "declarationMap": true
  }
}
```

**Step 3:** Create Next.js config:

```json
// packages/typescript-config/nextjs.json
{
  "extends": "./base.json",
  "compilerOptions": {
    "jsx": "preserve",
    "noEmit": true,
    "plugins": [{ "name": "next" }]
  }
}
```

**Step 4:** Create package.json:

```json
// packages/typescript-config/package.json
{
  "name": "@barangay/typescript-config",
  "version": "0.0.0",
  "private": true,
  "files": ["base.json", "nextjs.json"]
}
```

**Step 5:** Extend in app:

```json
// apps/web/tsconfig.json
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

### Part 6: Configure Turbo Dependencies

**Task:** Update turbo.json to properly order builds:

```json
// turbo.json
{
  "$schema": "https://turbo.build/schema.json",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**", "dist/**"]
    },
    "lint": {
      "dependsOn": ["^lint"]
    },
    "typecheck": {
      "dependsOn": ["^typecheck"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    }
  }
}
```

**Test the build order:**

```bash
pnpm turbo run build --graph
```

This shows the dependency graph visually.

---

### Part 7: Package Exports Exercise

**Task:** Configure exports for a UI package with multiple components:

```
packages/ui/
├── src/
│   ├── button.tsx
│   ├── card.tsx
│   ├── modal.tsx
│   └── index.ts
└── package.json
```

**Fill in the package.json exports:**

```json
{
  "name": "@barangay/ui",
  "exports": {
    // TODO: Add exports for:
    // - Main entry (all components)
    // - Individual button, card, modal
  }
}
```

---

### Part 8: Dependency Graph Exercise

**Given this structure:**

```
apps/dashboard depends on: @barangay/ui, @barangay/utils
apps/admin depends on: @barangay/ui
packages/ui depends on: @barangay/utils
packages/utils has no internal deps
```

**Question:** In what order will Turborepo build these packages?

List the build order (first to last):

1. ***
2. ***
3. ***
4. ***

---

### Part 9: Fix the Workspace Reference

**Find and fix the error:**

```json
// apps/web/package.json
{
  "dependencies": {
    "@barangay/ui": "^1.0.0",
    "react": "^18.2.0"
  }
}
```

**What's wrong?** ******\_\_\_******

**How to fix?** ******\_\_\_******

---

### What You Learned

✓ Creating and configuring shared packages
✓ Using workspace:\* for internal dependencies
✓ Setting up package exports for flexible imports
✓ Sharing TypeScript and ESLint configurations
✓ Understanding Turborepo dependency ordering
✓ Cross-project type sharing

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-C, 4-B, 5-B

Part 7:

```json
{
  "name": "@barangay/ui",
  "exports": {
    ".": "./src/index.ts",
    "./button": "./src/button.tsx",
    "./card": "./src/card.tsx",
    "./modal": "./src/modal.tsx"
  }
}
```

Part 8:

1. packages/utils (no deps)
2. packages/ui (depends on utils)
3. apps/dashboard (depends on ui, utils)
4. apps/admin (depends on ui)

Note: Steps 3 and 4 can run in parallel since they don't depend on each other.

Part 9:

- **What's wrong?** Using npm version `^1.0.0` instead of workspace reference
- **How to fix?** Change to `"@barangay/ui": "workspace:*"`
