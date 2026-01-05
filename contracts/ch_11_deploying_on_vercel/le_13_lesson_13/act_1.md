# Serverless Functions Activity

Serverless Functions let you build a backend without managing servers. In this activity, you'll create and deploy your first API endpoints.

## Task for Students

### Part 1: Serverless Concepts Quiz

**Question 1:** What does "serverless" mean?

- A) There are no servers involved
- B) You don't manage the servers—the platform does
- C) It only works offline
- D) It's slower than traditional servers

**Question 2:** When do Serverless Functions run?

- A) 24/7 constantly
- B) Only when a request comes in
- C) Once per hour
- D) Only during business hours

**Question 3:** What is a "cold start"?

- A) When the server freezes
- B) Starting a function instance that was idle
- C) A deployment error
- D) A security feature

**Question 4:** In Next.js App Router, how do you handle a POST request?

- A) `function POST(req, res)`
- B) `export async function POST(request)`
- C) `router.post('/api/...')`
- D) `app.post('/api/...')`

**Question 5:** What is the maximum execution time for a Hobby plan function?

- A) 5 seconds
- B) 10 seconds
- C) 30 seconds
- D) 60 seconds

---

### Part 2: Create Your First API

**Step 1:** Create a Next.js project (or use existing):

```bash
npx create-next-app@latest my-api-project
cd my-api-project
```

**Step 2:** Create a simple API route:

```typescript
// app/api/hello/route.ts
export async function GET() {
  return Response.json({
    message: "Hello from Serverless!",
    timestamp: new Date().toISOString(),
  });
}
```

**Step 3:** Test locally:

```bash
npm run dev
# Visit http://localhost:3000/api/hello
```

**Step 4:** Deploy to Vercel:

```bash
vercel
```

**Step 5:** Test the deployed API:

Visit `https://your-project.vercel.app/api/hello`

---

### Part 3: Handle Multiple HTTP Methods

**Task:** Create an API that handles GET, POST, and DELETE requests.

```typescript
// app/api/items/route.ts

// In-memory storage (for demo purposes)
let items: { id: number; name: string }[] = [
  { id: 1, name: "Item 1" },
  { id: 2, name: "Item 2" },
];

// GET - List all items
export async function GET() {
  return Response.json(items);
}

// POST - Add new item
export async function POST(request: Request) {
  const { name } = await request.json();
  const newItem = {
    id: items.length + 1,
    name,
  };
  items.push(newItem);
  return Response.json(newItem, { status: 201 });
}

// DELETE - Remove an item
export async function DELETE(request: Request) {
  const { searchParams } = new URL(request.url);
  const id = parseInt(searchParams.get("id") || "0");

  items = items.filter((item) => item.id !== id);

  return new Response(null, { status: 204 });
}
```

**Test with curl or Postman:**

```bash
# GET all items
curl https://your-project.vercel.app/api/items

# POST new item
curl -X POST https://your-project.vercel.app/api/items \
  -H "Content-Type: application/json" \
  -d '{"name": "New Item"}'

# DELETE an item
curl -X DELETE "https://your-project.vercel.app/api/items?id=1"
```

---

### Part 4: Dynamic Routes

**Task:** Create a dynamic API route for individual items.

Create the file structure:

```
app/api/items/[id]/route.ts
```

```typescript
// app/api/items/[id]/route.ts
export async function GET(
  request: Request,
  { params }: { params: { id: string } }
) {
  const itemId = parseInt(params.id);

  // Simulated data
  const items = [
    { id: 1, name: "Blockchain Node" },
    { id: 2, name: "Smart Contract" },
    { id: 3, name: "DApp Frontend" },
  ];

  const item = items.find((i) => i.id === itemId);

  if (!item) {
    return Response.json({ error: "Item not found" }, { status: 404 });
  }

  return Response.json(item);
}
```

**Test:**

- `GET /api/items/1` → Returns item 1
- `GET /api/items/999` → Returns 404

---

### Part 5: Using Environment Variables

**Step 1:** Add an environment variable locally:

```bash
# .env.local
SECRET_API_KEY=my-super-secret-key
```

**Step 2:** Create an API that uses it:

```typescript
// app/api/secret/route.ts
export async function GET(request: Request) {
  const authHeader = request.headers.get("Authorization");
  const expectedKey = process.env.SECRET_API_KEY;

  if (authHeader !== `Bearer ${expectedKey}`) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }

  return Response.json({
    message: "Access granted!",
    secret: "The treasure is in Barangay Hall",
  });
}
```

**Step 3:** Add the variable in Vercel dashboard

**Step 4:** Test:

```bash
# Without auth - should fail
curl https://your-project.vercel.app/api/secret

# With auth - should succeed
curl https://your-project.vercel.app/api/secret \
  -H "Authorization: Bearer my-super-secret-key"
```

---

### Part 6: Error Handling

**Task:** Add proper error handling to your API:

```typescript
// app/api/safe/route.ts
export async function GET() {
  try {
    // Simulate potential failure
    const random = Math.random();

    if (random < 0.3) {
      throw new Error("Random failure for demo");
    }

    return Response.json({
      success: true,
      value: random,
    });
  } catch (error) {
    console.error("API Error:", error);

    return Response.json({ error: "Something went wrong" }, { status: 500 });
  }
}
```

---

### Part 7: Debugging Exercise

Your API returns an error. How do you debug it?

**Step 1:** Check Vercel dashboard

- Go to Project → Deployments → Latest
- Click "Functions" tab
- View function logs

**Step 2:** Add logging

```typescript
export async function GET() {
  console.log("Function called at:", new Date().toISOString());
  console.log("Environment:", process.env.NODE_ENV);

  // Your logic here
}
```

**Step 3:** Check Runtime Logs in Vercel dashboard

---

### What You Learned

✓ Serverless Functions run on-demand without server management
✓ Export different functions for each HTTP method
✓ Use dynamic routes with `[id]` folder syntax
✓ Access environment variables with `process.env`
✓ Always implement error handling with try/catch
✓ View function logs in Vercel dashboard

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-B, 4-B, 5-B
