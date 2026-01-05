# Le 14: Edge Functions – Lightning-Fast Global Responses

![Edge Functions](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/edge-functions.png)

## Background Story

Maria notices something odd. Her API works great for users in Manila, but Neri's cousin in Japan complains about slow response times.

"The serverless function runs in Singapore," Marco explains. "For users in Tokyo, the request travels across the Pacific, then back. That adds latency."

"Can't we run the function closer to the users?"

"Yes! That's exactly what Edge Functions do. They run your code at the edge—in data centers around the world, close to your users."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What are Edge Functions
- Edge vs Serverless comparison
- Creating Edge Functions
- Edge Function limitations
- Use cases and best practices
- Global data patterns

---

## What Are Edge Functions?

Edge Functions run at the **edge of the network**—in data centers closest to your users:

```
Serverless (Regional):
User (Tokyo) ──────────────> Singapore ──────────────> Response
                                           ↑
                              (High latency: ~100ms)

Edge (Global):
User (Tokyo) ───> Tokyo Edge ───> Response
                        ↑
              (Low latency: ~10ms)
```

Vercel has edge locations in 30+ cities worldwide.

---

## Edge vs Serverless Comparison

| Feature      | Serverless  | Edge                   |
| ------------ | ----------- | ---------------------- |
| Location     | One region  | Global (30+ locations) |
| Cold Start   | 100-500ms   | <50ms                  |
| Runtime      | Node.js     | V8 (JavaScript)        |
| Max Duration | 60s (Pro)   | 30s                    |
| Max Size     | 50 MB       | 4 MB                   |
| Node.js APIs | Full access | Limited                |
| npm packages | Most work   | Some don't             |

---

## When to Use Edge Functions

### ✅ Perfect for Edge

- **Authentication checks** - Verify tokens quickly
- **A/B testing** - Route users to different versions
- **Personalization** - Customize content by location
- **Feature flags** - Enable/disable features
- **Geolocation** - Content based on user location
- **Header manipulation** - Add security headers
- **URL rewrites** - Redirect or rewrite URLs

### ❌ Not Ideal for Edge

- Database connections requiring persistent connections
- Heavy computation (image processing, ML)
- Large npm packages not compatible with Edge runtime
- Operations requiring full Node.js APIs

---

## Creating Edge Functions

### Next.js (App Router)

```typescript
// app/api/edge-hello/route.ts
export const runtime = "edge"; // This makes it an Edge Function

export async function GET(request: Request) {
  return Response.json({
    message: "Hello from the Edge!",
    location: request.headers.get("x-vercel-ip-country") || "Unknown",
  });
}
```

### Next.js (Pages Router)

```typescript
// pages/api/edge-hello.ts
import type { NextRequest } from "next/server";

export const config = {
  runtime: "edge",
};

export default function handler(request: NextRequest) {
  return Response.json({ message: "Hello from Edge!" });
}
```

### SvelteKit

```typescript
// src/routes/api/edge/+server.ts
export const config = {
  runtime: "edge",
};

export function GET() {
  return new Response(JSON.stringify({ message: "Edge!" }), {
    headers: { "Content-Type": "application/json" },
  });
}
```

---

## Geolocation with Edge

Access user location via request headers:

```typescript
export const runtime = "edge";

export async function GET(request: Request) {
  const country = request.headers.get("x-vercel-ip-country");
  const city = request.headers.get("x-vercel-ip-city");
  const region = request.headers.get("x-vercel-ip-country-region");
  const latitude = request.headers.get("x-vercel-ip-latitude");
  const longitude = request.headers.get("x-vercel-ip-longitude");

  return Response.json({
    country,
    city,
    region,
    coordinates: { latitude, longitude },
  });
}
```

### Location-Based Content

```typescript
export const runtime = "edge";

export async function GET(request: Request) {
  const country = request.headers.get("x-vercel-ip-country");

  let greeting;
  switch (country) {
    case "PH":
      greeting = "Mabuhay! Welcome from the Philippines!";
      break;
    case "JP":
      greeting = "ようこそ! Welcome from Japan!";
      break;
    case "US":
      greeting = "Hello! Welcome from the USA!";
      break;
    default:
      greeting = `Hello! Welcome from ${country}!`;
  }

  return Response.json({ greeting, country });
}
```

---

## Edge Function Patterns

### Pattern 1: Feature Flags

```typescript
export const runtime = "edge";

export async function GET(request: Request) {
  const userId = request.headers.get("x-user-id");

  // Simple percentage-based rollout
  const hash = simpleHash(userId || "anonymous");
  const betaEnabled = hash % 100 < 10; // 10% rollout

  return Response.json({
    features: {
      newDashboard: betaEnabled,
      darkMode: true,
      betaFeatures: betaEnabled,
    },
  });
}

function simpleHash(str: string): number {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = (hash << 5) - hash + str.charCodeAt(i);
    hash |= 0;
  }
  return Math.abs(hash);
}
```

### Pattern 2: A/B Testing

```typescript
export const runtime = "edge";

export async function GET(request: Request) {
  const cookie = request.headers.get("cookie") || "";
  let variant = getCookie(cookie, "ab-variant");

  if (!variant) {
    // Assign random variant
    variant = Math.random() < 0.5 ? "A" : "B";
  }

  return new Response(JSON.stringify({ variant }), {
    headers: {
      "Content-Type": "application/json",
      "Set-Cookie": `ab-variant=${variant}; Path=/; Max-Age=604800`,
    },
  });
}
```

### Pattern 3: Rate Limiting (Simple)

```typescript
export const runtime = "edge";

// Simple in-memory rate limiting (per edge location)
const requestCounts = new Map<string, { count: number; timestamp: number }>();

export async function GET(request: Request) {
  const ip = request.headers.get("x-forwarded-for") || "unknown";
  const now = Date.now();
  const windowMs = 60000; // 1 minute
  const maxRequests = 10;

  const record = requestCounts.get(ip);

  if (!record || now - record.timestamp > windowMs) {
    requestCounts.set(ip, { count: 1, timestamp: now });
  } else if (record.count >= maxRequests) {
    return Response.json({ error: "Too many requests" }, { status: 429 });
  } else {
    record.count++;
  }

  return Response.json({ message: "Request allowed" });
}
```

---

## Limitations and Workarounds

### No Native Node.js Modules

```typescript
// ❌ Won't work on Edge
import fs from "fs";
import path from "path";

// ✅ Use Web APIs instead
const response = await fetch("https://api.example.com/data");
```

### No Traditional Database Connections

```typescript
// ❌ Won't work - requires persistent connection
import { Pool } from "pg";

// ✅ Use HTTP-based databases
import { sql } from "@vercel/postgres";

export const runtime = "edge";

export async function GET() {
  const { rows } = await sql`SELECT * FROM users LIMIT 10`;
  return Response.json(rows);
}
```

### Limited npm Packages

Some packages don't work on Edge. Check compatibility:

```typescript
// ✅ Works on Edge
import { nanoid } from "nanoid";

// ❌ Might not work (check docs)
import sharp from "sharp"; // Uses native bindings
```

---

## Data at the Edge

### Vercel KV (Redis)

```typescript
import { kv } from "@vercel/kv";

export const runtime = "edge";

export async function GET() {
  const visits = await kv.incr("page-visits");
  return Response.json({ visits });
}
```

### Vercel Postgres (Edge-compatible)

```typescript
import { sql } from "@vercel/postgres";

export const runtime = "edge";

export async function GET() {
  const { rows } = await sql`SELECT * FROM announcements`;
  return Response.json(rows);
}
```

---

## Performance Comparison

A real-world comparison for a simple API:

| Metric                                 | Serverless | Edge |
| -------------------------------------- | ---------- | ---- |
| Cold Start (Singapore → Manila)        | 150ms      | 12ms |
| Cold Start (Singapore → Tokyo)         | 280ms      | 15ms |
| Cold Start (Singapore → San Francisco) | 400ms      | 18ms |
| Warm Response                          | 50ms       | 5ms  |

Edge Functions are **10-20x faster** for geographically distributed users.

---

## Debugging Edge Functions

### Local Testing

```bash
vercel dev
# Edge Functions run in Edge runtime locally
```

### Viewing Logs

1. Go to Vercel Dashboard → Project → Logs
2. Filter by "Edge" in the function type
3. View real-time logs

### Request Headers for Debugging

```typescript
export const runtime = "edge";

export async function GET(request: Request) {
  const headers: Record<string, string> = {};
  request.headers.forEach((value, key) => {
    headers[key] = value;
  });

  return Response.json({
    headers,
    url: request.url,
  });
}
```

---

## Maria's Edge-Optimized API

Maria adds an Edge Function for quick location-based greetings:

```typescript
// app/api/greeting/route.ts
export const runtime = "edge";

export async function GET(request: Request) {
  const country = request.headers.get("x-vercel-ip-country");
  const city = request.headers.get("x-vercel-ip-city");

  const greetings: Record<string, string> = {
    PH: "Mabuhay",
    JP: "こんにちは",
    US: "Hello",
    SG: "Hello",
  };

  return Response.json({
    greeting: greetings[country || ""] || "Hello",
    message: `Welcome from ${city || "somewhere on Earth"}!`,
    servedFrom: "Edge - closest to you!",
  });
}
```

Now Neri's cousin in Japan gets responses in ~15ms instead of ~300ms!

---

## Key Takeaways

✓ Edge Functions run globally, close to users
✓ Add `runtime = 'edge'` to enable Edge runtime
✓ Access geolocation via `x-vercel-ip-*` headers
✓ Edge has limitations: smaller size, limited Node.js APIs
✓ Use Edge for auth, personalization, and latency-sensitive operations
✓ Use Vercel KV or Postgres for Edge-compatible data

**Next Lesson:** Edge Middleware—intercept requests before they reach your app!
