# Connecting to Databases Activity

Serverless applications need databases. In this activity, you'll connect to Vercel Storage and external databases.

## Task for Students

### Part 1: Database Storage Quiz

**Question 1:** Which Vercel storage option is best for caching session data?

- A) Vercel Postgres
- B) Vercel KV
- C) Vercel Blob
- D) Edge Config

**Question 2:** What library provides type-safe SQL access with auto-completion?

- A) mysql2
- B) pg
- C) Prisma
- D) mongoose

**Question 3:** Why is connection pooling important in serverless?

- A) Faster queries
- B) Prevents exhausting database connections
- C) Reduces memory usage
- D) Enables caching

**Question 4:** Which storage option is best for file uploads?

- A) Vercel Postgres
- B) Vercel KV
- C) Vercel Blob
- D) Edge Config

**Question 5:** Which client works on Vercel Edge Functions?

- A) PrismaClient
- B) @vercel/postgres
- C) mongoose
- D) pg-pool

---

### Part 2: Set Up Vercel Postgres

**Step 1:** Create a database in Vercel Dashboard:

1. Go to Project → Storage → Create Database
2. Select Postgres
3. Choose region (Singapore for Philippines)
4. Note the auto-added environment variables

**Step 2:** Install the SDK:

```bash
npm install @vercel/postgres
```

**Step 3:** Create a setup endpoint:

```typescript
// app/api/setup/route.ts
import { sql } from "@vercel/postgres";

export async function GET() {
  try {
    await sql`
      CREATE TABLE IF NOT EXISTS residents (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        barangay VARCHAR(255) NOT NULL,
        age INTEGER,
        created_at TIMESTAMP DEFAULT NOW()
      )
    `;

    return Response.json({ message: "Table created successfully" });
  } catch (error) {
    return Response.json({ error: String(error) }, { status: 500 });
  }
}
```

**Step 4:** Visit `/api/setup` to create the table.

---

### Part 3: CRUD Operations

**Create** - Add a resident:

```typescript
// app/api/residents/route.ts
import { sql } from "@vercel/postgres";

export async function POST(request: Request) {
  const { name, barangay, age } = await request.json();

  if (!name || !barangay) {
    return Response.json(
      { error: "Name and barangay are required" },
      { status: 400 }
    );
  }

  const { rows } = await sql`
    INSERT INTO residents (name, barangay, age)
    VALUES (${name}, ${barangay}, ${age})
    RETURNING *
  `;

  return Response.json({ resident: rows[0] }, { status: 201 });
}
```

**Read** - Get all residents:

```typescript
export async function GET() {
  const { rows } = await sql`
    SELECT * FROM residents ORDER BY created_at DESC
  `;
  return Response.json({ residents: rows });
}
```

**Update** - Modify a resident:

```typescript
// app/api/residents/[id]/route.ts
import { sql } from "@vercel/postgres";

export async function PUT(
  request: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  const { name, barangay, age } = await request.json();

  const { rows } = await sql`
    UPDATE residents
    SET name = ${name}, barangay = ${barangay}, age = ${age}
    WHERE id = ${parseInt(id)}
    RETURNING *
  `;

  if (rows.length === 0) {
    return Response.json({ error: "Not found" }, { status: 404 });
  }

  return Response.json({ resident: rows[0] });
}
```

**Delete** - Remove a resident:

```typescript
export async function DELETE(
  request: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;

  const { rows } = await sql`
    DELETE FROM residents WHERE id = ${parseInt(id)} RETURNING id
  `;

  if (rows.length === 0) {
    return Response.json({ error: "Not found" }, { status: 404 });
  }

  return new Response(null, { status: 204 });
}
```

---

### Part 4: Add Caching with Vercel KV

**Step 1:** Create KV store in dashboard and install SDK:

```bash
npm install @vercel/kv
```

**Step 2:** Add caching to your GET endpoint:

```typescript
// app/api/residents/route.ts
import { sql } from "@vercel/postgres";
import { kv } from "@vercel/kv";

export async function GET(request: Request) {
  const cacheKey = "residents:all";

  // Check cache first
  const cached = await kv.get<object[]>(cacheKey);
  if (cached) {
    console.log("Cache hit!");
    return Response.json({
      residents: cached,
      cached: true,
    });
  }

  // Cache miss - query database
  console.log("Cache miss - querying database");
  const { rows } = await sql`
    SELECT * FROM residents ORDER BY created_at DESC
  `;

  // Cache for 5 minutes
  await kv.set(cacheKey, rows, { ex: 300 });

  return Response.json({
    residents: rows,
    cached: false,
  });
}

export async function POST(request: Request) {
  // ... insert logic ...

  // Invalidate cache after insert
  await kv.del("residents:all");

  return Response.json({ resident: rows[0] }, { status: 201 });
}
```

---

### Part 5: File Uploads with Vercel Blob

**Step 1:** Install the SDK:

```bash
npm install @vercel/blob
```

**Step 2:** Create upload endpoint:

```typescript
// app/api/upload/route.ts
import { put } from "@vercel/blob";

export async function POST(request: Request) {
  const formData = await request.formData();
  const file = formData.get("file") as File;

  if (!file) {
    return Response.json({ error: "No file provided" }, { status: 400 });
  }

  // Upload to Vercel Blob
  const blob = await put(file.name, file, {
    access: "public",
  });

  return Response.json({
    url: blob.url,
    pathname: blob.pathname,
    contentType: blob.contentType,
    size: file.size,
  });
}
```

**Step 3:** Test the upload:

```bash
curl -X POST http://localhost:3000/api/upload \
  -F "file=@./test-image.jpg"
```

---

### Part 6: Using Prisma ORM

**Step 1:** Initialize Prisma:

```bash
npm install prisma @prisma/client
npx prisma init
```

**Step 2:** Define schema (prisma/schema.prisma):

```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model Resident {
  id        Int      @id @default(autoincrement())
  name      String
  barangay  String
  age       Int?
  createdAt DateTime @default(now()) @map("created_at")

  @@map("residents")
}
```

**Step 3:** Generate client:

```bash
npx prisma generate
npx prisma db push
```

**Step 4:** Create Prisma client singleton:

```typescript
// lib/prisma.ts
import { PrismaClient } from "@prisma/client";

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined;
};

export const prisma = globalForPrisma.prisma ?? new PrismaClient();

if (process.env.NODE_ENV !== "production") {
  globalForPrisma.prisma = prisma;
}
```

**Step 5:** Use in API routes:

```typescript
// app/api/residents-prisma/route.ts
import { prisma } from "@/lib/prisma";

export async function GET() {
  const residents = await prisma.resident.findMany({
    orderBy: { createdAt: "desc" },
  });
  return Response.json({ residents });
}

export async function POST(request: Request) {
  const data = await request.json();

  const resident = await prisma.resident.create({
    data: {
      name: data.name,
      barangay: data.barangay,
      age: data.age,
    },
  });

  return Response.json({ resident }, { status: 201 });
}
```

---

### Part 7: Rate Limiting Exercise

**Task:** Implement rate limiting using Vercel KV.

```typescript
// app/api/limited/route.ts
import { kv } from "@vercel/kv";

export async function GET(request: Request) {
  const ip = request.headers.get("x-forwarded-for") || "unknown";
  const key = `ratelimit:${ip}`;

  // Get current count
  const current = await kv.incr(key);

  // Set expiry on first request (60 second window)
  if (current === 1) {
    await kv.expire(key, 60);
  }

  const limit = 10;
  const remaining = Math.max(0, limit - current);

  if (current > limit) {
    return Response.json(
      {
        error: "Too many requests",
        retryAfter: 60,
      },
      {
        status: 429,
        headers: {
          "X-RateLimit-Limit": String(limit),
          "X-RateLimit-Remaining": "0",
          "Retry-After": "60",
        },
      }
    );
  }

  return Response.json(
    { message: "Success", remaining },
    {
      headers: {
        "X-RateLimit-Limit": String(limit),
        "X-RateLimit-Remaining": String(remaining),
      },
    }
  );
}
```

---

### Part 8: Match Storage to Use Case

Match each scenario to the best Vercel storage option:

| Scenario                                   | Storage Option |
| ------------------------------------------ | -------------- |
| Store user profile images                  | \_\_\_         |
| Cache API responses for 5 minutes          | \_\_\_         |
| Store relational data with complex queries | \_\_\_         |
| Session tokens with 1-hour expiry          | \_\_\_         |
| Feature flags with ultra-low latency       | \_\_\_         |
| Page view counters                         | \_\_\_         |

Options: Postgres, KV, Blob, Edge Config

---

### What You Learned

✓ Vercel Postgres for SQL databases
✓ CRUD operations with parameterized queries
✓ Caching with Vercel KV and TTL
✓ File uploads with Vercel Blob
✓ Type-safe database access with Prisma
✓ Rate limiting patterns with KV
✓ Cache invalidation strategies

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-B, 4-C, 5-B

Part 8:

- User profile images → Blob
- Cache API responses → KV
- Relational data with complex queries → Postgres
- Session tokens with 1-hour expiry → KV
- Feature flags with ultra-low latency → Edge Config
- Page view counters → KV
