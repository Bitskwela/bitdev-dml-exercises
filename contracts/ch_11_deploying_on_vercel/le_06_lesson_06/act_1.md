# Environment Variables Activity

Maria almost exposed her API key on GitHub! In this activity, you'll practice the safe way to handle secrets and configuration using environment variables.

## Task for Students

### Part 1: Security Quiz

**Question 1:** Why is hardcoding API keys in your code dangerous?

- A) It makes the code run slower
- B) Bots scan GitHub and can steal exposed keys
- C) It uses more memory
- D) It breaks the build process

**Question 2:** Which file should you use for local development secrets?

- A) `config.js`
- B) `secrets.json`
- C) `.env.local`
- D) `api-keys.txt`

**Question 3:** In Next.js, which prefix exposes a variable to the browser?

- A) `PUBLIC_`
- B) `NEXT_PUBLIC_`
- C) `CLIENT_`
- D) `BROWSER_`

**Question 4:** After adding environment variables in Vercel, what must you do?

- A) Restart your computer
- B) Redeploy the application
- C) Clear the CDN cache
- D) Nothing, it's automatic

**Question 5:** Which of these should be an environment variable?

- A) The app's title
- B) A database password
- C) CSS colors
- D) HTML content

---

### Part 2: Local Setup Exercise

**Step 1: Create a .env.local file**

In your project root, create `.env.local`:

```
# .env.local
MY_SECRET_KEY=local-test-key-12345
NEXT_PUBLIC_APP_NAME=Barangay Dashboard
```

**Step 2: Verify .gitignore**

Check that your `.gitignore` includes:

```
.env
.env.local
.env*.local
```

If not, add these lines to prevent accidental commits.

**Step 3: Access in Code**

Create or modify a file to access these variables:

```javascript
// pages/index.js or app/page.js

// Server-side only (not exposed to browser)
console.log("Secret:", process.env.MY_SECRET_KEY);

// Public (available in browser)
console.log("App Name:", process.env.NEXT_PUBLIC_APP_NAME);
```

**Step 4: Test Locally**

Run your development server and check the console output.

---

### Part 3: Vercel Dashboard Exercise

**Step 1: Navigate to Environment Variables**

1. Go to [vercel.com/dashboard](https://vercel.com/dashboard)
2. Select your project
3. Go to **Settings** → **Environment Variables**

**Step 2: Add a Variable**

```
Key:   TEST_API_KEY
Value: my-test-value-12345
```

**Step 3: Select Environments**

- ✓ Production
- ✓ Preview
- ✓ Development

**Step 4: Save and Redeploy**

1. Click "Save"
2. Go to "Deployments"
3. Click the three dots on the latest deployment
4. Select "Redeploy"

---

### Part 4: Different Values Per Environment

Create environment variables with different values:

| Key       | Production             | Preview                   | Development             |
| --------- | ---------------------- | ------------------------- | ----------------------- |
| `API_URL` | `https://api.prod.com` | `https://api.staging.com` | `http://localhost:3001` |

**Why This Matters:**

- Development: Test with local or sandbox APIs
- Preview: Test with staging/sandbox APIs
- Production: Use real, production APIs

---

### Part 5: Reflection Questions

Answer these questions:

1. **Why do we use different API keys for development and production?**

   _Your answer:_ ******\_\_\_******

2. **What would happen if you console.log() your database password in production?**

   _Your answer:_ ******\_\_\_******

3. **How would you share environment variable values with a new team member?**

   _Your answer:_ ******\_\_\_******

---

### What You Learned

✓ Environment variables keep secrets out of your code
✓ `.env.local` is for local development and must be in `.gitignore`
✓ `NEXT_PUBLIC_` prefix exposes variables to the browser
✓ Vercel supports different values for Production/Preview/Development
✓ Always redeploy after adding or changing environment variables

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-B, 4-B, 5-B

Part 5 Sample Answers:

1. Development keys are for testing/sandbox; production keys have real access and billing. If a dev key leaks, damage is limited.
2. The password would appear in logs that anyone with Vercel access could see—a security breach.
3. Securely share via password manager or encrypted message. Never via email, Slack, or git commits.
