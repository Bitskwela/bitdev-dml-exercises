# Edge Functions Activity

Edge Functions bring your code closer to users worldwide. In this activity, you'll create and deploy Edge Functions with geolocation features.

## Task for Students

### Part 1: Edge Concepts Quiz

**Question 1:** Where do Edge Functions run?

- A) In one central server
- B) In data centers globally, close to users
- C) Only in the user's browser
- D) On the user's mobile device

**Question 2:** What is the main advantage of Edge Functions over Serverless Functions?

- A) They support more npm packages
- B) They have longer execution times
- C) They have lower latency globally
- D) They are cheaper

**Question 3:** How do you make a Next.js API route an Edge Function?

- A) Rename the file to `.edge.ts`
- B) Add `export const runtime = 'edge'`
- C) Add `edge: true` to package.json
- D) Deploy to a different URL

**Question 4:** Which header provides the user's country on Vercel Edge?

- A) `x-country`
- B) `user-country`
- C) `x-vercel-ip-country`
- D) `geo-country`

**Question 5:** Edge Functions have a size limit of:

- A) 1 MB
- B) 4 MB
- C) 50 MB
- D) No limit

---

### Part 2: Create Your First Edge Function

**Step 1:** Create an Edge API route:

```typescript
// app/api/edge/route.ts
export const runtime = "edge";

export async function GET() {
  const now = new Date().toISOString();

  return Response.json({
    message: "Hello from the Edge!",
    timestamp: now,
    runtime: "edge",
  });
}
```

**Step 2:** Create a Serverless version for comparison:

```typescript
// app/api/serverless/route.ts
// No runtime export = defaults to serverless

export async function GET() {
  const now = new Date().toISOString();

  return Response.json({
    message: "Hello from Serverless!",
    timestamp: now,
    runtime: "nodejs",
  });
}
```

**Step 3:** Deploy and compare response times:

```bash
vercel
```

**Step 4:** Test both endpoints and note the response times in browser DevTools:

- `/api/edge` - Edge Function
- `/api/serverless` - Serverless Function

---

### Part 3: Geolocation Exercise

**Task:** Create an Edge Function that detects the user's location.

```typescript
// app/api/location/route.ts
export const runtime = "edge";

export async function GET(request: Request) {
  const geo = {
    country: request.headers.get("x-vercel-ip-country"),
    countryRegion: request.headers.get("x-vercel-ip-country-region"),
    city: request.headers.get("x-vercel-ip-city"),
    latitude: request.headers.get("x-vercel-ip-latitude"),
    longitude: request.headers.get("x-vercel-ip-longitude"),
  };

  return Response.json({
    location: geo,
    message: `Hello from ${geo.city || "Unknown City"}, ${
      geo.country || "Unknown Country"
    }!`,
  });
}
```

**Questions to Answer:**

1. Deploy and visit the endpoint. What location is detected?
2. Does the location change if you use a VPN?
3. What fields are null when testing locally?

---

### Part 4: Location-Based Content

**Task:** Create an Edge Function that returns different content based on country.

```typescript
// app/api/localized/route.ts
export const runtime = "edge";

interface LocalizedContent {
  greeting: string;
  currency: string;
  language: string;
}

const content: Record<string, LocalizedContent> = {
  PH: {
    greeting: "Mabuhay!",
    currency: "PHP",
    language: "Filipino",
  },
  US: {
    greeting: "Hello!",
    currency: "USD",
    language: "English",
  },
  JP: {
    greeting: "こんにちは!",
    currency: "JPY",
    language: "Japanese",
  },
  SG: {
    greeting: "Hello!",
    currency: "SGD",
    language: "English",
  },
};

const defaultContent: LocalizedContent = {
  greeting: "Hello!",
  currency: "USD",
  language: "English",
};

export async function GET(request: Request) {
  const country = request.headers.get("x-vercel-ip-country") || "US";
  const localized = content[country] || defaultContent;

  return Response.json({
    country,
    ...localized,
  });
}
```

---

### Part 5: Feature Flags at the Edge

**Task:** Implement a simple feature flag system.

```typescript
// app/api/features/route.ts
export const runtime = "edge";

export async function GET(request: Request) {
  // Get user identifier from cookie or header
  const userId = request.headers.get("x-user-id") || "anonymous";

  // Simple hash-based feature rollout
  const hash = hashString(userId);
  const percentage = hash % 100;

  const features = {
    newUI: percentage < 20, // 20% rollout
    darkMode: true, // 100% rollout
    betaFeatures: percentage < 5, // 5% rollout
    experimentalAPI: percentage < 1, // 1% rollout
  };

  return Response.json({
    userId,
    rolloutPercentage: percentage,
    features,
  });
}

function hashString(str: string): number {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = (hash << 5) - hash + char;
    hash = hash & hash; // Convert to 32bit integer
  }
  return Math.abs(hash);
}
```

**Test:**

```bash
# Different user IDs get different features
curl -H "x-user-id: user123" https://your-app.vercel.app/api/features
curl -H "x-user-id: user456" https://your-app.vercel.app/api/features
```

---

### Part 6: Edge Limitations Exercise

Try to identify which code works on Edge:

**Code A:**

```typescript
import fs from "fs";
export const runtime = "edge";

export async function GET() {
  const data = fs.readFileSync("./data.json");
  return Response.json(JSON.parse(data));
}
```

Works on Edge? **\_** (Yes/No)

**Code B:**

```typescript
export const runtime = "edge";

export async function GET() {
  const response = await fetch("https://api.example.com/data");
  const data = await response.json();
  return Response.json(data);
}
```

Works on Edge? **\_** (Yes/No)

**Code C:**

```typescript
import { Pool } from "pg";
export const runtime = "edge";

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

export async function GET() {
  const result = await pool.query("SELECT * FROM users");
  return Response.json(result.rows);
}
```

Works on Edge? **\_** (Yes/No)

---

### Part 7: Performance Measurement

**Task:** Measure the difference between Edge and Serverless.

1. Open browser DevTools → Network tab
2. Visit `/api/edge` multiple times
3. Note the Time (ms) for each request
4. Visit `/api/serverless` multiple times
5. Compare the average times

| Request  | Edge (ms) | Serverless (ms) |
| -------- | --------- | --------------- |
| 1 (cold) | \_\_\_    | \_\_\_          |
| 2 (warm) | \_\_\_    | \_\_\_          |
| 3 (warm) | \_\_\_    | \_\_\_          |
| Average  | \_\_\_    | \_\_\_          |

---

### What You Learned

✓ Edge Functions run globally, close to users
✓ Add `export const runtime = 'edge'` to enable
✓ Access geolocation via `x-vercel-ip-*` headers
✓ Edge is ideal for feature flags, A/B tests, personalization
✓ Some Node.js APIs don't work on Edge
✓ Edge Functions have faster cold starts than Serverless

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-B, 4-C, 5-B

Part 6:

- Code A: No (fs module not available on Edge)
- Code B: Yes (fetch is a Web API, works on Edge)
- Code C: No (pg uses native Node.js modules)
