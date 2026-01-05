# Le 25: Logs & Observability – Debugging Production Issues

![Logs and Observability](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/logs-observability.png)

## Background Story

Maria's dashboard is running smoothly—until it isn't. A resident reports an error, but Maria can't reproduce it.

"How do I see what happened?" Maria asks, frustrated.

"Logs," Marco says. "Vercel captures logs from your serverless functions. Combined with proper observability, you can debug any issue."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Vercel runtime logs
- Function logs
- Log levels and filtering
- Log drains
- Structured logging
- Debugging production issues
- Third-party observability tools

---

## Vercel Logs Overview

Vercel provides logs for serverless function execution:

```
Types of Logs:
├── Build Logs (deployment time)
├── Runtime Logs (execution time)
│   ├── Function invocations
│   ├── Edge function logs
│   └── Middleware logs
└── Edge Network Logs
```

---

## Accessing Logs

### Via Dashboard

1. Vercel Dashboard → Project
2. Click "Logs" tab
3. View real-time logs

### Via CLI

```bash
# Stream logs in real-time
vercel logs --follow

# View recent logs
vercel logs

# Filter by function
vercel logs --func api/users
```

---

## Understanding Log Entries

### Log Entry Structure

```json
{
  "id": "log_abc123",
  "timestamp": "2026-01-15T10:30:00.000Z",
  "requestId": "req_xyz789",
  "statusCode": 200,
  "message": "User created successfully",
  "source": "function",
  "path": "/api/users",
  "duration": 245,
  "region": "sin1"
}
```

### Log Levels

| Level   | Purpose             | Example                    |
| ------- | ------------------- | -------------------------- |
| `log`   | General information | User action completed      |
| `info`  | Informational       | Request received           |
| `warn`  | Warnings            | Deprecated API used        |
| `error` | Errors              | Database connection failed |

---

## Writing Effective Logs

### Basic Console Logging

```typescript
export async function POST(request: Request) {
  console.log("Creating user...");

  try {
    const data = await request.json();
    console.log("Received data:", JSON.stringify(data));

    const user = await createUser(data);
    console.log("User created:", user.id);

    return Response.json({ user });
  } catch (error) {
    console.error("Error creating user:", error);
    return Response.json({ error: "Failed" }, { status: 500 });
  }
}
```

### Structured Logging

```typescript
function log(level: string, message: string, context?: object) {
  console.log(
    JSON.stringify({
      timestamp: new Date().toISOString(),
      level,
      message,
      ...context,
    })
  );
}

export async function POST(request: Request) {
  const requestId = crypto.randomUUID();

  log("info", "Request started", { requestId, path: "/api/users" });

  try {
    const data = await request.json();
    log("info", "Data parsed", { requestId, fields: Object.keys(data) });

    const user = await createUser(data);
    log("info", "User created", { requestId, userId: user.id });

    return Response.json({ user });
  } catch (error) {
    log("error", "Request failed", {
      requestId,
      error: String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });
    return Response.json({ error: "Failed" }, { status: 500 });
  }
}
```

---

## Filtering Logs

### By Time

```bash
# Last hour
vercel logs --since 1h

# Last 24 hours
vercel logs --since 24h

# Specific date range
vercel logs --since 2026-01-15 --until 2026-01-16
```

### By Status

```bash
# Only errors (4xx, 5xx)
vercel logs --level error

# Filter by status code
vercel logs --status 500
```

### By Function

```bash
# Specific API route
vercel logs --func api/users

# All API routes
vercel logs --func api/*
```

---

## Real-Time Log Streaming

### CLI Streaming

```bash
# Follow logs in real-time
vercel logs --follow

# Follow with filters
vercel logs --follow --level error
```

### Use Cases

- Debugging live issues
- Monitoring deployments
- Watching for errors

---

## Log Drains

Send logs to external services for:

- Long-term storage
- Advanced search
- Alerting
- Correlation with other data

### Supported Destinations

| Service       | Type           | Use Case               |
| ------------- | -------------- | ---------------------- |
| Datadog       | APM            | Full observability     |
| New Relic     | APM            | Performance monitoring |
| Papertrail    | Log management | Searchable logs        |
| Logflare      | Log management | Real-time analytics    |
| HTTP endpoint | Custom         | Your own service       |

### Configuring Log Drains

1. Project Settings → Log Drains
2. Add Integration
3. Choose destination
4. Configure filters (optional)

### Example: Datadog Integration

```
Destination: Datadog
API Key: ********
Site: datadoghq.com
Environment Tag: production
```

---

## Debugging Common Issues

### Error: Function Timeout

```
Log:
[error] Function timed out after 10000ms

Debug steps:
1. Check function duration in logs
2. Look for slow database queries
3. Add timeout logging
```

```typescript
export async function GET() {
  const start = Date.now();

  console.log("Starting query...");
  const result = await db.query("SELECT...");
  console.log(`Query completed in ${Date.now() - start}ms`);

  return Response.json(result);
}
```

### Error: Cold Start Latency

```
Log:
Duration: 2500ms (includes cold start)

Optimization:
1. Reduce bundle size
2. Use edge functions for low latency
3. Implement warm-up
```

### Error: Database Connection Failed

```
Log:
[error] Connection refused: ECONNREFUSED

Debug steps:
1. Check environment variables
2. Verify IP allowlist
3. Check connection pool
```

```typescript
export async function GET() {
  try {
    await db.connect();
  } catch (error) {
    console.error("DB Connection failed:", {
      host: process.env.DB_HOST,
      error: String(error),
    });
    throw error;
  }
}
```

---

## Request Tracing

Track requests across functions:

### Request ID Pattern

```typescript
// middleware.ts
import { NextResponse } from "next/server";

export function middleware(request: Request) {
  const requestId = crypto.randomUUID();
  const response = NextResponse.next();

  response.headers.set("x-request-id", requestId);
  console.log(`[${requestId}] Request: ${request.url}`);

  return response;
}
```

```typescript
// app/api/users/route.ts
export async function GET(request: Request) {
  const requestId = request.headers.get("x-request-id") || "unknown";

  console.log(`[${requestId}] Fetching users...`);
  const users = await getUsers();
  console.log(`[${requestId}] Found ${users.length} users`);

  return Response.json({ users });
}
```

---

## Error Tracking Integration

### Sentry Integration

```bash
npm install @sentry/nextjs
```

```typescript
// sentry.client.config.ts
import * as Sentry from "@sentry/nextjs";

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  tracesSampleRate: 1.0,
  environment: process.env.VERCEL_ENV,
});
```

### Capturing Errors

```typescript
import * as Sentry from "@sentry/nextjs";

export async function GET() {
  try {
    return Response.json(await getData());
  } catch (error) {
    Sentry.captureException(error);
    console.error("Error:", error);
    return Response.json({ error: "Failed" }, { status: 500 });
  }
}
```

---

## Log Best Practices

### Do's

✅ Include request IDs for tracing
✅ Use structured JSON logging
✅ Log entry and exit points
✅ Include relevant context
✅ Log timing information
✅ Use appropriate log levels

### Don'ts

❌ Log sensitive data (passwords, tokens)
❌ Log entire request bodies
❌ Use console.log for errors (use console.error)
❌ Skip error stack traces
❌ Over-log (impacts performance)

---

## Maria's Debugging Session

Maria investigates a reported error:

**Step 1: Check Logs**

```bash
vercel logs --level error --since 1h
```

**Step 2: Find the Error**

```
[error] Database query failed
  requestId: abc123
  error: connection refused
  timestamp: 2026-01-15T10:30:00Z
```

**Step 3: Add More Logging**

```typescript
log("debug", "Attempting DB connection", {
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
});
```

**Step 4: Identify Issue**

- DB host changed but env var wasn't updated

**Step 5: Fix and Verify**

```bash
vercel env pull
vercel env add DB_HOST
vercel --prod
```

---

## Key Takeaways

✓ Access logs via Dashboard or CLI
✓ Use structured logging with JSON
✓ Include request IDs for tracing
✓ Filter logs by time, status, and function
✓ Set up log drains for long-term storage
✓ Integrate error tracking (Sentry, etc.)

**Next Lesson:** Image Optimization—faster loading with less bandwidth!
