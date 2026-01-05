# Le 18: Connecting to Databases – Vercel Storage and Beyond

![Database Connections](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/database-connections.png)

## Background Story

Maria's barangay dashboard is growing. Hardcoded data won't cut it anymore—she needs a real database.

"Where should I store resident data?" Maria asks. "I don't want to manage servers."

Marco smiles. "Vercel offers several storage options—Postgres, KV, Blob, and you can also connect to external databases. Let's explore your options."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Vercel Storage options overview
- Vercel Postgres setup and usage
- Vercel KV (Redis) for caching
- Vercel Blob for file storage
- Connecting to external databases
- Connection pooling and best practices
- Edge-compatible database access

---

## Vercel Storage Overview

Vercel offers four built-in storage solutions:

| Storage            | Type              | Best For                         |
| ------------------ | ----------------- | -------------------------------- |
| Vercel Postgres    | SQL database      | Relational data, complex queries |
| Vercel KV          | Redis (key-value) | Caching, sessions, rate limiting |
| Vercel Blob        | Object storage    | Files, images, uploads           |
| Vercel Edge Config | Config store      | Feature flags, low-latency reads |

---

## Vercel Postgres

### Setting Up Vercel Postgres

**Step 1:** Create database in Vercel Dashboard:

1. Go to your project → Storage tab
2. Click "Create Database" → Select "Postgres"
3. Choose a region close to your serverless functions
4. Vercel automatically adds environment variables

**Step 2:** Install the SDK:

```bash
npm install @vercel/postgres
```

**Step 3:** Environment variables are auto-added:

```
POSTGRES_URL=postgres://...
POSTGRES_URL_NON_POOLING=postgres://...
POSTGRES_USER=...
POSTGRES_HOST=...
POSTGRES_PASSWORD=...
POSTGRES_DATABASE=...
```

### Using Vercel Postgres

```typescript
// app/api/residents/route.ts
import { sql } from "@vercel/postgres";

export async function GET() {
  const { rows } = await sql`SELECT * FROM residents ORDER BY created_at DESC`;
  return Response.json({ residents: rows });
}

export async function POST(request: Request) {
  const { name, barangay, age } = await request.json();

  const { rows } = await sql`
    INSERT INTO residents (name, barangay, age)
    VALUES (${name}, ${barangay}, ${age})
    RETURNING *
  `;

  return Response.json({ resident: rows[0] }, { status: 201 });
}
```

### Creating Tables

```typescript
// app/api/setup/route.ts
import { sql } from "@vercel/postgres";

export async function GET() {
  await sql`
    CREATE TABLE IF NOT EXISTS residents (
      id SERIAL PRIMARY KEY,
      name VARCHAR(255) NOT NULL,
      barangay VARCHAR(255) NOT NULL,
      age INTEGER,
      created_at TIMESTAMP DEFAULT NOW()
    )
  `;

  return Response.json({ message: "Table created" });
}
```

### Parameterized Queries (Prevents SQL Injection)

```typescript
// Safe: parameterized query
const { rows } = await sql`
  SELECT * FROM residents WHERE barangay = ${barangay}
`;

// NEVER do this (SQL injection risk):
// const { rows } = await sql`SELECT * FROM residents WHERE barangay = '${barangay}'`;
```

---

## Vercel KV (Redis)

Fast key-value storage for caching, sessions, and counters.

### Setting Up Vercel KV

**Step 1:** Create KV store in dashboard
**Step 2:** Install the SDK:

```bash
npm install @vercel/kv
```

### Basic KV Operations

```typescript
import { kv } from "@vercel/kv";

// String operations
await kv.set("user:123", JSON.stringify({ name: "Maria" }));
const user = await kv.get("user:123");

// With expiration (TTL in seconds)
await kv.set("session:abc", "data", { ex: 3600 }); // Expires in 1 hour

// Increment counters
await kv.incr("page:views");
const views = await kv.get("page:views");

// Hash operations
await kv.hset("resident:1", { name: "Maria", age: 25 });
const resident = await kv.hgetall("resident:1");

// Delete
await kv.del("key");
```

### Caching API Responses

```typescript
// app/api/cached-data/route.ts
import { kv } from "@vercel/kv";

export async function GET() {
  const cacheKey = "expensive:data";

  // Check cache first
  const cached = await kv.get(cacheKey);
  if (cached) {
    return Response.json({ data: cached, source: "cache" });
  }

  // Fetch fresh data
  const data = await fetchExpensiveData();

  // Cache for 5 minutes
  await kv.set(cacheKey, data, { ex: 300 });

  return Response.json({ data, source: "fresh" });
}
```

### Rate Limiting with KV

```typescript
// app/api/limited/route.ts
import { kv } from "@vercel/kv";

export async function GET(request: Request) {
  const ip = request.headers.get("x-forwarded-for") || "unknown";
  const key = `ratelimit:${ip}`;

  const current = await kv.incr(key);

  // Set expiry on first request
  if (current === 1) {
    await kv.expire(key, 60); // 60 second window
  }

  if (current > 10) {
    // 10 requests per minute
    return Response.json({ error: "Rate limit exceeded" }, { status: 429 });
  }

  return Response.json({ remaining: 10 - current });
}
```

---

## Vercel Blob

Object storage for files, images, and uploads.

### Setting Up Vercel Blob

```bash
npm install @vercel/blob
```

### Uploading Files

```typescript
// app/api/upload/route.ts
import { put } from "@vercel/blob";

export async function POST(request: Request) {
  const formData = await request.formData();
  const file = formData.get("file") as File;

  const blob = await put(file.name, file, {
    access: "public",
  });

  return Response.json({
    url: blob.url,
    pathname: blob.pathname,
    contentType: blob.contentType,
  });
}
```

### Listing and Deleting Blobs

```typescript
import { list, del } from "@vercel/blob";

// List all blobs
const { blobs } = await list();

// Delete a blob
await del("path/to/file.jpg");
```

---

## External Databases

### Connecting to Neon Postgres

```typescript
import { Pool } from "@neondatabase/serverless";

const pool = new Pool({
  connectionString: process.env.NEON_DATABASE_URL,
});

export async function GET() {
  const client = await pool.connect();
  try {
    const { rows } = await client.query("SELECT * FROM residents");
    return Response.json({ residents: rows });
  } finally {
    client.release();
  }
}
```

### Connecting to PlanetScale (MySQL)

```typescript
import { connect } from "@planetscale/database";

const conn = connect({
  host: process.env.PLANETSCALE_HOST,
  username: process.env.PLANETSCALE_USERNAME,
  password: process.env.PLANETSCALE_PASSWORD,
});

export async function GET() {
  const results = await conn.execute("SELECT * FROM residents");
  return Response.json({ residents: results.rows });
}
```

### Connecting to MongoDB

```typescript
import { MongoClient } from "mongodb";

const client = new MongoClient(process.env.MONGODB_URI!);

export async function GET() {
  await client.connect();
  const db = client.db("barangay");
  const residents = await db.collection("residents").find().toArray();
  return Response.json({ residents });
}
```

---

## Using Prisma ORM

Prisma provides type-safe database access.

### Setup

```bash
npm install prisma @prisma/client
npx prisma init
```

### Schema (prisma/schema.prisma)

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
  createdAt DateTime @default(now())
}
```

### Generate Client and Push Schema

```bash
npx prisma generate
npx prisma db push
```

### Using Prisma in API Routes

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

```typescript
// app/api/residents/route.ts
import { prisma } from "@/lib/prisma";

export async function GET() {
  const residents = await prisma.resident.findMany({
    orderBy: { createdAt: "desc" },
  });
  return Response.json({ residents });
}

export async function POST(request: Request) {
  const data = await request.json();
  const resident = await prisma.resident.create({ data });
  return Response.json({ resident }, { status: 201 });
}
```

---

## Using Drizzle ORM

A lightweight, TypeScript-first ORM.

### Setup

```bash
npm install drizzle-orm @vercel/postgres
npm install -D drizzle-kit
```

### Schema (db/schema.ts)

```typescript
import {
  pgTable,
  serial,
  varchar,
  integer,
  timestamp,
} from "drizzle-orm/pg-core";

export const residents = pgTable("residents", {
  id: serial("id").primaryKey(),
  name: varchar("name", { length: 255 }).notNull(),
  barangay: varchar("barangay", { length: 255 }).notNull(),
  age: integer("age"),
  createdAt: timestamp("created_at").defaultNow(),
});
```

### Using Drizzle

```typescript
// db/index.ts
import { drizzle } from "drizzle-orm/vercel-postgres";
import { sql } from "@vercel/postgres";
import * as schema from "./schema";

export const db = drizzle(sql, { schema });
```

```typescript
// app/api/residents/route.ts
import { db } from "@/db";
import { residents } from "@/db/schema";

export async function GET() {
  const allResidents = await db.select().from(residents);
  return Response.json({ residents: allResidents });
}
```

---

## Edge-Compatible Database Access

For Edge Functions, use edge-compatible clients:

```typescript
// Works on Edge
import { sql } from "@vercel/postgres"; // ✅
import { kv } from "@vercel/kv"; // ✅
import { neon } from "@neondatabase/serverless"; // ✅

// Does NOT work on Edge (Node.js only)
import { PrismaClient } from "@prisma/client"; // ❌
```

### Neon on Edge

```typescript
import { neon } from "@neondatabase/serverless";

export const runtime = "edge";

export async function GET() {
  const sql = neon(process.env.DATABASE_URL!);
  const residents = await sql`SELECT * FROM residents`;
  return Response.json({ residents });
}
```

---

## Connection Pooling

For serverless, connection pooling is essential to avoid exhausting database connections.

### Why Pooling Matters

```
Without Pooling:
- Each function invocation = new connection
- 100 concurrent requests = 100 connections
- Database max connections exceeded = errors

With Pooling:
- Connections are reused
- 100 requests share ~10 connections
- Database stays healthy
```

### Vercel Postgres Pooling

```typescript
import { sql } from "@vercel/postgres"; // Uses pooling automatically

// Or use the pooling URL explicitly
import { createPool } from "@vercel/postgres";
const pool = createPool({ connectionString: process.env.POSTGRES_URL });
```

---

## Environment Variable Setup

For any database, configure environment variables:

**Vercel Dashboard → Project Settings → Environment Variables**

```
DATABASE_URL=postgres://user:pass@host:5432/db
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/db
REDIS_URL=redis://user:pass@host:6379
```

**Different values per environment:**

- Production: Your production database
- Preview: Staging or dev database
- Development: Local database

---

## Maria's Database Setup

Maria connects her barangay dashboard to Vercel Postgres:

```typescript
// app/api/residents/route.ts
import { sql } from "@vercel/postgres";
import { kv } from "@vercel/kv";

export async function GET(request: Request) {
  const url = new URL(request.url);
  const barangay = url.searchParams.get("barangay");

  // Check cache first
  const cacheKey = `residents:${barangay || "all"}`;
  const cached = await kv.get(cacheKey);
  if (cached) {
    return Response.json({ residents: cached, cached: true });
  }

  // Query database
  let rows;
  if (barangay) {
    const result = await sql`
      SELECT * FROM residents 
      WHERE barangay = ${barangay}
      ORDER BY created_at DESC
    `;
    rows = result.rows;
  } else {
    const result = await sql`
      SELECT * FROM residents ORDER BY created_at DESC
    `;
    rows = result.rows;
  }

  // Cache for 5 minutes
  await kv.set(cacheKey, rows, { ex: 300 });

  return Response.json({ residents: rows, cached: false });
}
```

---

## Key Takeaways

✓ Vercel Postgres for SQL data, KV for caching, Blob for files
✓ Use parameterized queries to prevent SQL injection
✓ Consider Prisma or Drizzle for type-safe database access
✓ Use edge-compatible clients for Edge Functions
✓ Connection pooling is essential for serverless
✓ Cache frequently accessed data with Vercel KV

**Next Lesson:** Monorepo Deployments—managing multiple projects in one repository!
