# Le 13: Serverless Functions Basics – Backend Without Servers

![Serverless Functions](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/serverless-functions.png)

## Background Story

Maria's Barangay Dashboard needs to fetch data from a database and send emails. "Do I need to set up a whole backend server?" she asks, remembering the complexity of her old PHP days.

"Not anymore," Marco reassures her. "With Serverless Functions, you write a function, deploy it, and Vercel handles everything else—scaling, uptime, security."

"So I can have a backend without managing servers?"

"Exactly. That's the promise of serverless."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What are Serverless Functions
- How they work on Vercel
- Creating your first API endpoint
- Request and response handling
- Common use cases
- Cold starts and optimization

---

## What Are Serverless Functions?

Serverless Functions are backend code that runs on-demand:

| Traditional Server | Serverless Functions  |
| ------------------ | --------------------- |
| Always running     | Run only when called  |
| You manage uptime  | Vercel manages uptime |
| Pay for 24/7       | Pay per execution     |
| Scale manually     | Scale automatically   |
| One big server     | Many small functions  |

```
Traditional:
Your Code → Your Server (24/7) → Response

Serverless:
Your Code → Vercel (on-demand) → Response
```

---

## How Serverless Works on Vercel

When a request hits your API:

1. Vercel receives the request
2. Spins up a function instance (if needed)
3. Runs your code
4. Returns the response
5. Keeps instance warm for a few minutes
6. Shuts down if idle

```
Request → [Cold Start?] → Function Executes → Response
                ↓
        (Instance stays warm for ~15 min)
```

---

## Creating Serverless Functions

### Next.js (App Router)

```typescript
// app/api/hello/route.ts
export async function GET(request: Request) {
  return Response.json({ message: "Hello from Vercel!" });
}

export async function POST(request: Request) {
  const body = await request.json();
  return Response.json({ received: body });
}
```

### Next.js (Pages Router)

```typescript
// pages/api/hello.ts
import type { NextApiRequest, NextApiResponse } from "next";

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  res.status(200).json({ message: "Hello!" });
}
```

### Nuxt 3

```typescript
// server/api/hello.ts
export default defineEventHandler((event) => {
  return { message: "Hello from Nuxt!" };
});
```

### SvelteKit

```typescript
// src/routes/api/hello/+server.ts
export function GET() {
  return new Response(JSON.stringify({ message: "Hello!" }), {
    headers: { "Content-Type": "application/json" },
  });
}
```

---

## Handling HTTP Methods

```typescript
// app/api/users/route.ts

// GET /api/users - List users
export async function GET() {
  const users = await getUsers();
  return Response.json(users);
}

// POST /api/users - Create user
export async function POST(request: Request) {
  const data = await request.json();
  const user = await createUser(data);
  return Response.json(user, { status: 201 });
}

// PUT /api/users - Update user
export async function PUT(request: Request) {
  const data = await request.json();
  const user = await updateUser(data);
  return Response.json(user);
}

// DELETE /api/users - Delete user
export async function DELETE(request: Request) {
  const { searchParams } = new URL(request.url);
  const id = searchParams.get("id");
  await deleteUser(id);
  return new Response(null, { status: 204 });
}
```

---

## Reading Request Data

### Query Parameters

```typescript
// GET /api/search?q=blockchain
export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const query = searchParams.get("q");

  return Response.json({ query });
}
```

### Request Body

```typescript
// POST /api/submit
export async function POST(request: Request) {
  const body = await request.json();

  return Response.json({
    received: body,
    timestamp: new Date().toISOString(),
  });
}
```

### Headers

```typescript
export async function GET(request: Request) {
  const authHeader = request.headers.get("Authorization");

  if (!authHeader) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }

  return Response.json({ authenticated: true });
}
```

---

## Dynamic Routes

Create dynamic API endpoints with folder structure:

```
app/api/
├── users/
│   ├── route.ts           → /api/users
│   └── [id]/
│       └── route.ts       → /api/users/123
```

```typescript
// app/api/users/[id]/route.ts
export async function GET(
  request: Request,
  { params }: { params: { id: string } }
) {
  const user = await getUser(params.id);

  if (!user) {
    return Response.json({ error: "Not found" }, { status: 404 });
  }

  return Response.json(user);
}
```

---

## Common Use Cases

### 1. Database Operations

```typescript
// app/api/residents/route.ts
import { db } from "@/lib/database";

export async function GET() {
  const residents = await db.query("SELECT * FROM residents");
  return Response.json(residents);
}
```

### 2. Third-Party API Calls

```typescript
// app/api/weather/route.ts
export async function GET() {
  const apiKey = process.env.WEATHER_API_KEY;
  const response = await fetch(
    `https://api.weather.com/v1/current?key=${apiKey}&city=Manila`
  );
  const data = await response.json();
  return Response.json(data);
}
```

### 3. Form Submissions

```typescript
// app/api/contact/route.ts
export async function POST(request: Request) {
  const { name, email, message } = await request.json();

  // Send email
  await sendEmail({
    to: "barangay@example.com",
    subject: `Contact from ${name}`,
    body: message,
  });

  return Response.json({ success: true });
}
```

### 4. Authentication

```typescript
// app/api/auth/login/route.ts
export async function POST(request: Request) {
  const { email, password } = await request.json();

  const user = await authenticate(email, password);

  if (!user) {
    return Response.json({ error: "Invalid credentials" }, { status: 401 });
  }

  const token = await createToken(user);
  return Response.json({ token });
}
```

---

## Environment Variables

Access secrets in your functions:

```typescript
export async function GET() {
  const dbUrl = process.env.DATABASE_URL;
  const apiKey = process.env.API_SECRET_KEY;

  // Use these for database connections, API calls, etc.
}
```

**Important:** Server-side environment variables don't need a prefix. They're automatically available in Serverless Functions.

---

## Cold Starts

A **cold start** happens when a function instance needs to be created:

```
First request:  Cold Start (100-500ms) → Execution → Response
Second request: Warm (0ms)            → Execution → Response
...
After 15 min:   Cold Start again
```

### Minimizing Cold Starts

1. **Keep functions small**

   ```typescript
   // ❌ Importing entire library
   import aws from "aws-sdk";

   // ✅ Import only what you need
   import { S3 } from "@aws-sdk/client-s3";
   ```

2. **Lazy load heavy dependencies**

   ```typescript
   export async function GET() {
     const { analyzeImage } = await import("@/lib/ai");
     // Only loads when function is called
   }
   ```

3. **Use Edge Functions for ultra-low latency** (next lesson)

---

## Function Limits

Vercel Serverless Function limits:

| Limit                 | Hobby      | Pro        |
| --------------------- | ---------- | ---------- |
| Max Duration          | 10 seconds | 60 seconds |
| Memory                | 1024 MB    | 3008 MB    |
| Payload Size          | 4.5 MB     | 4.5 MB     |
| Concurrent Executions | 10         | 1000       |

---

## Error Handling

```typescript
export async function GET() {
  try {
    const data = await fetchData();
    return Response.json(data);
  } catch (error) {
    console.error("Error fetching data:", error);

    return Response.json({ error: "Internal server error" }, { status: 500 });
  }
}
```

---

## Testing Locally

### Next.js

```bash
npm run dev
# API available at http://localhost:3000/api/hello
```

### Vercel CLI

```bash
vercel dev
# Simulates Vercel's serverless environment
```

---

## Maria's First API

Maria creates an API to fetch barangay announcements:

```typescript
// app/api/announcements/route.ts
import { db } from "@/lib/database";

export async function GET() {
  const announcements = await db.query(`
    SELECT * FROM announcements 
    ORDER BY created_at DESC 
    LIMIT 10
  `);

  return Response.json(announcements);
}

export async function POST(request: Request) {
  const { title, content } = await request.json();

  await db.query(
    `
    INSERT INTO announcements (title, content) 
    VALUES ($1, $2)
  `,
    [title, content]
  );

  return Response.json({ success: true }, { status: 201 });
}
```

---

## Key Takeaways

✓ Serverless Functions run on-demand—no server management
✓ Each HTTP method (GET, POST, etc.) is a separate export
✓ Access environment variables with `process.env`
✓ Cold starts add latency on first request
✓ Keep functions small and dependencies minimal
✓ Use try/catch for proper error handling

**Next Lesson:** Edge Functions—serverless at the edge of the world!
