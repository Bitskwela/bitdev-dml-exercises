# Le 06: Environment Variables – Secrets and Configuration

![Environment Variables](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/env-variables.png)

## Background Story

Maria's Barangay Blockchain dashboard is growing. She's adding a feature to fetch real-time exchange rates from CoinGecko's API.

"I got the API key!" she tells Marco excitedly, typing it directly into her code:

```javascript
const API_KEY = "cg-1234567890abcdef";
const response = await fetch(
  `https://api.coingecko.com/v3/...?x_cg_api_key=${API_KEY}`
);
```

Marco's face goes pale. "Maria... your code is on GitHub."

"Yeah, so?"

"That means everyone can see your API key. Bots scan GitHub for exposed keys. They'll find yours in minutes and abuse it."

Maria's eyes widen. "So how do I use the key without putting it in my code?"

"Environment variables," Marco says. "Let me show you."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What are environment variables?
- Why secrets should never be in code
- Setting environment variables in Vercel
- Development vs Preview vs Production
- Accessing variables in your code
- Common patterns and best practices

---

## What Are Environment Variables?

**Environment variables** are key-value pairs that exist outside your code but are accessible to your application at runtime.

```
Traditional (DANGEROUS):
const API_KEY = "cg-1234567890abcdef";  // ❌ In code, visible to everyone

Environment Variable (SAFE):
const API_KEY = process.env.API_KEY;    // ✅ Loaded from environment
```

Think of environment variables as secret notes passed to your application—they're never written in the codebase itself.

---

## Why Not Hardcode Secrets?

When you put secrets in your code:

| Problem                   | Consequence                                |
| ------------------------- | ------------------------------------------ |
| Visible on GitHub         | Bots scrape keys within minutes            |
| In git history forever    | Even if you delete it, it's in old commits |
| Same for all environments | Dev and production use the same key        |
| Hard to rotate            | Changing a key requires code changes       |

When you use environment variables:

| Benefit         | Result                              |
| --------------- | ----------------------------------- |
| Not in code     | Nothing sensitive on GitHub         |
| Per-environment | Different keys for dev/staging/prod |
| Easy to rotate  | Change in dashboard, no code change |
| Secure storage  | Encrypted by Vercel                 |

---

## Common Secrets That Need Protection

```
API keys:        COINGECKO_API_KEY, STRIPE_SECRET_KEY
Database URLs:   DATABASE_URL, MONGODB_URI
Authentication:  JWT_SECRET, SESSION_SECRET
Third-party:     SENDGRID_API_KEY, TWILIO_AUTH_TOKEN
Feature flags:   ENABLE_BETA_FEATURES, MAINTENANCE_MODE
```

Rule: **If it's sensitive or changes between environments, use an environment variable.**

---

## Setting Environment Variables in Vercel

### Step 1: Navigate to Settings

1. Go to your Vercel dashboard
2. Select your project
3. Click **Settings** → **Environment Variables**

### Step 2: Add a Variable

```
Key:   API_KEY
Value: cg-1234567890abcdef
```

### Step 3: Choose Environments

Vercel lets you set different values for each environment:

| Environment     | When It's Used                  |
| --------------- | ------------------------------- |
| **Production**  | Your live site (main branch)    |
| **Preview**     | Branch deployments, PR previews |
| **Development** | Local development (vercel dev)  |

You might set:

```
Production:  API_KEY = real-production-key
Preview:     API_KEY = test-sandbox-key
Development: API_KEY = local-dev-key
```

### Step 4: Redeploy

After adding environment variables, you must **redeploy** for changes to take effect.

---

## Accessing Environment Variables in Code

### JavaScript / Node.js

```javascript
// Access with process.env
const apiKey = process.env.API_KEY;
const databaseUrl = process.env.DATABASE_URL;

// Use in your code
const response = await fetch(`https://api.example.com/data?key=${apiKey}`);
```

### Next.js (App Router)

```javascript
// Server Components (access directly)
const apiKey = process.env.API_KEY;

// Client Components (must use NEXT_PUBLIC_ prefix)
const publicKey = process.env.NEXT_PUBLIC_ANALYTICS_ID;
```

**Important:** In Next.js, only variables prefixed with `NEXT_PUBLIC_` are exposed to the browser. Others are server-only.

### React (Vite)

```javascript
// Must use VITE_ prefix
const apiKey = import.meta.env.VITE_API_KEY;
```

### Vue (Vite)

```javascript
// Must use VITE_ prefix
const apiKey = import.meta.env.VITE_API_KEY;
```

---

## Local Development with .env Files

During local development, you don't connect to Vercel's environment variables. Instead, use `.env` files:

### Create .env.local

```bash
# .env.local (in your project root)
API_KEY=local-development-key
DATABASE_URL=postgresql://localhost:5432/mydb
```

### Add to .gitignore

```bash
# .gitignore
.env
.env.local
.env*.local
```

**Never commit .env files to git!**

### The .env File Hierarchy

```
.env                 # Loaded in all environments
.env.local           # Loaded in all environments, ignored by git
.env.development     # Only in development
.env.production      # Only in production
```

---

## Vercel CLI: Local Development

Use `vercel dev` to run locally with Vercel's environment variables:

```bash
# Pull environment variables from Vercel
vercel env pull .env.local

# Run development server with Vercel's env vars
vercel dev
```

This syncs your local environment with what's configured in Vercel.

---

## Environment Variable Patterns

### Pattern 1: API Keys

```javascript
// .env.local
STRIPE_SECRET_KEY = sk_test_xxx;
STRIPE_PUBLIC_KEY = pk_test_xxx;

// In code
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY);
```

### Pattern 2: Feature Flags

```javascript
// .env.local
ENABLE_DARK_MODE = true;
MAINTENANCE_MODE = false;

// In code
if (process.env.ENABLE_DARK_MODE === "true") {
  enableDarkMode();
}
```

### Pattern 3: URLs That Change Per Environment

```javascript
// Production
API_URL=https://api.production.com

// Preview
API_URL=https://api.staging.com

// Development
API_URL=http://localhost:3001
```

---

## Security Best Practices

### DO ✅

```
✅ Use environment variables for all secrets
✅ Use different values per environment
✅ Add .env.local to .gitignore
✅ Rotate keys regularly
✅ Use NEXT_PUBLIC_ prefix only for truly public values
```

### DON'T ❌

```
❌ Commit .env files to git
❌ Log environment variables (console.log(process.env))
❌ Expose server secrets to the client
❌ Share production keys with developers
❌ Use the same key for dev and production
```

---

## Vercel's Secret Encryption

When you add environment variables to Vercel:

1. Values are encrypted at rest
2. Only decrypted during build/runtime
3. Not visible in build logs
4. Team members with access can view/edit

For extra-sensitive values, Vercel offers **Sensitive Environment Variables** that are completely hidden after creation.

---

## Maria's Fix

Maria refactors her code:

**Before (dangerous):**

```javascript
const API_KEY = "cg-1234567890abcdef";
```

**After (secure):**

```javascript
const API_KEY = process.env.COINGECKO_API_KEY;
```

**In Vercel Dashboard:**

```
Key:   COINGECKO_API_KEY
Value: cg-1234567890abcdef
Environments: ✓ Production ✓ Preview ✓ Development
```

**In .env.local:**

```
COINGECKO_API_KEY=cg-test-key-for-development
```

Now her API key is:

- Not in her code
- Not on GitHub
- Secure and encrypted
- Easy to rotate if compromised

---

## Key Takeaways

✓ Environment variables store configuration outside your code
✓ Never hardcode secrets—they'll be exposed on GitHub
✓ Vercel supports different values for Production/Preview/Development
✓ Use `.env.local` for local development (add to .gitignore)
✓ In Next.js, only `NEXT_PUBLIC_` vars are exposed to the browser
✓ Use `vercel env pull` to sync environment variables locally

**Next Lesson:** Deploying React applications with optimal build settings!
