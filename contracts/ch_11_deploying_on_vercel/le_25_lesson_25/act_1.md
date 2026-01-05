# Logs & Observability Activity

Debugging production issues requires good logging and observability. In this activity, you'll implement effective logging and learn to debug issues.

## Task for Students

### Part 1: Logging Concepts Quiz

**Question 1:** Which console method should you use for errors?

- A) console.log
- B) console.info
- C) console.warn
- D) console.error

**Question 2:** What is a log drain?

- A) A way to delete old logs
- B) Sending logs to external services
- C) A memory leak in logging
- D) Filtering sensitive data

**Question 3:** Why should you include request IDs in logs?

- A) For billing purposes
- B) To trace requests across functions
- C) For SEO optimization
- D) To reduce log size

**Question 4:** What should you NOT log?

- A) Request timestamps
- B) Error messages
- C) Passwords and tokens
- D) Function duration

**Question 5:** What is structured logging?

- A) Logging in alphabetical order
- B) JSON-formatted log entries
- C) Logging to multiple files
- D) Encrypted logs

---

### Part 2: Implement Basic Logging

**Task:** Add logging to this API route:

```typescript
// app/api/residents/route.ts
export async function POST(request: Request) {
  const data = await request.json();
  const resident = await createResident(data);
  return Response.json({ resident }, { status: 201 });
}
```

**Your implementation:**

```typescript
// app/api/residents/route.ts
export async function POST(request: Request) {
  const requestId = crypto.randomUUID();
  const startTime = Date.now();

  console.log(`[${requestId}] POST /api/residents - Started`);

  try {
    const data = await request.json();
    console.log(`[${requestId}] Received data for: ${data.name}`);

    const resident = await createResident(data);
    console.log(`[${requestId}] Created resident: ${resident.id}`);

    const duration = Date.now() - startTime;
    console.log(`[${requestId}] Completed in ${duration}ms`);

    return Response.json({ resident }, { status: 201 });
  } catch (error) {
    const duration = Date.now() - startTime;
    console.error(`[${requestId}] Error after ${duration}ms:`, error);

    return Response.json(
      { error: "Failed to create resident" },
      { status: 500 }
    );
  }
}
```

---

### Part 3: Implement Structured Logging

**Task:** Create a structured logging utility:

```typescript
// lib/logger.ts
type LogLevel = "debug" | "info" | "warn" | "error";

interface LogContext {
  requestId?: string;
  userId?: string;
  path?: string;
  [key: string]: unknown;
}

export function log(level: LogLevel, message: string, context?: LogContext) {
  const entry = {
    timestamp: new Date().toISOString(),
    level,
    message,
    ...context,
  };

  const logMethod =
    level === "error"
      ? console.error
      : level === "warn"
      ? console.warn
      : console.log;

  logMethod(JSON.stringify(entry));
}

// Convenience methods
export const logger = {
  debug: (msg: string, ctx?: LogContext) => log("debug", msg, ctx),
  info: (msg: string, ctx?: LogContext) => log("info", msg, ctx),
  warn: (msg: string, ctx?: LogContext) => log("warn", msg, ctx),
  error: (msg: string, ctx?: LogContext) => log("error", msg, ctx),
};
```

**Usage:**

```typescript
import { logger } from "@/lib/logger";

export async function GET(request: Request) {
  const requestId = crypto.randomUUID();

  logger.info("Request started", {
    requestId,
    path: "/api/residents",
  });

  // ... rest of handler
}
```

---

### Part 4: View Logs in CLI

**Step 1:** Stream logs in real-time:

```bash
vercel logs --follow
```

**Step 2:** Filter by error level:

```bash
vercel logs --level error
```

**Step 3:** Filter by function:

```bash
vercel logs --func api/residents
```

**Step 4:** View last hour:

```bash
vercel logs --since 1h
```

---

### Part 5: Debug a Production Error

**Scenario:** You see this error in logs:

```
[error] {
  "timestamp": "2026-01-15T10:30:00Z",
  "level": "error",
  "message": "Database connection failed",
  "requestId": "abc123",
  "error": "ECONNREFUSED 10.0.0.5:5432"
}
```

**Questions:**

1. What is the error? ******\_\_\_******

2. What is the likely cause? ******\_\_\_******

3. What should you check first? ******\_\_\_******

4. How would you fix this? ******\_\_\_******

---

### Part 6: Request Tracing

**Task:** Implement request tracing across middleware and API routes:

**Middleware:**

```typescript
// middleware.ts
import { NextResponse } from "next/server";

export function middleware(request: Request) {
  const requestId = crypto.randomUUID();
  const response = NextResponse.next();

  // Add request ID to response headers
  response.headers.set("x-request-id", requestId);

  console.log(
    JSON.stringify({
      timestamp: new Date().toISOString(),
      level: "info",
      message: "Request received",
      requestId,
      method: request.method,
      path: new URL(request.url).pathname,
    })
  );

  return response;
}
```

**API Route:**

```typescript
// app/api/residents/route.ts
export async function GET(request: Request) {
  const requestId = request.headers.get("x-request-id") || "unknown";

  console.log(
    JSON.stringify({
      timestamp: new Date().toISOString(),
      level: "info",
      message: "Fetching residents",
      requestId,
    })
  );

  // ... rest of handler
}
```

---

### Part 7: Log Analysis Exercise

**Given these logs:**

```
{"timestamp":"10:30:00","level":"info","message":"Request started","requestId":"abc","path":"/api/users"}
{"timestamp":"10:30:01","level":"info","message":"DB query started","requestId":"abc"}
{"timestamp":"10:30:04","level":"info","message":"DB query completed","requestId":"abc","rows":1500}
{"timestamp":"10:30:04","level":"info","message":"Response sent","requestId":"abc","duration":"4000ms"}
```

**Questions:**

1. How long did the request take? \_\_\_

2. Which operation was slowest? \_\_\_

3. What might be causing the slowness? \_\_\_

4. How would you optimize? \_\_\_

---

### Part 8: Error Tracking Setup

**Task:** Add Sentry for error tracking:

**Step 1:** Install:

```bash
npm install @sentry/nextjs
npx @sentry/wizard@latest -i nextjs
```

**Step 2:** Configure:

```typescript
// sentry.client.config.ts
import * as Sentry from "@sentry/nextjs";

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  tracesSampleRate: 1.0,
  environment: process.env.VERCEL_ENV,
});
```

**Step 3:** Capture errors:

```typescript
import * as Sentry from "@sentry/nextjs";

export async function GET() {
  try {
    return Response.json(await getData());
  } catch (error) {
    Sentry.captureException(error, {
      tags: { endpoint: "/api/data" },
      extra: { timestamp: new Date().toISOString() },
    });

    console.error("Error:", error);
    return Response.json({ error: "Failed" }, { status: 500 });
  }
}
```

---

### Part 9: Log Security Audit

**Review this code for logging issues:**

```typescript
export async function POST(request: Request) {
  const data = await request.json();
  console.log("Login attempt:", data);
  // data contains { username, password }

  const user = await authenticate(data.username, data.password);
  console.log("Token generated:", user.token);

  return Response.json({ user });
}
```

**Issues found:**

1. ***
2. ***
3. ***

**Corrected version:**

```typescript
export async function POST(request: Request) {
  const requestId = crypto.randomUUID();
  const data = await request.json();

  // Log without sensitive data
  console.log(
    JSON.stringify({
      level: "info",
      message: "Login attempt",
      requestId,
      username: data.username,
      // Never log password!
    })
  );

  const user = await authenticate(data.username, data.password);

  console.log(
    JSON.stringify({
      level: "info",
      message: "Login successful",
      requestId,
      userId: user.id,
      // Never log token!
    })
  );

  return Response.json({ user });
}
```

---

### Part 10: Log Drain Configuration

**Task:** Set up a log drain to an external service.

**Step 1:** Go to Project Settings → Log Drains

**Step 2:** Choose destination:

- Datadog (for APM)
- Papertrail (for log search)
- HTTP endpoint (custom)

**Step 3:** Configure:

```yaml
Destination: HTTP
URL: https://logs.example.com/ingest
Headers:
  Authorization: Bearer $LOG_SECRET
Filters:
  - Level: error
  - Level: warn
```

**Questions:**

1. Why use log drains? ******\_\_\_******

2. What filters would you set for production? ******\_\_\_******

---

### What You Learned

✓ Implementing structured logging
✓ Using log levels appropriately
✓ Adding request IDs for tracing
✓ Viewing and filtering logs with CLI
✓ Debugging production issues
✓ Setting up error tracking with Sentry

---

**Instructor Answers:**

Part 1: 1-D, 2-B, 3-B, 4-C, 5-B

Part 5:

1. Database connection refused
2. Wrong DB host, firewall, or DB is down
3. Environment variables, DB status, network/firewall
4. Update DB_HOST env var or fix network connectivity

Part 7:

1. 4 seconds (4000ms)
2. Database query (3 seconds)
3. Returning too many rows (1500), slow query
4. Add pagination, index the query, reduce returned columns

Part 9 Issues:

1. Logging password in data object
2. Logging authentication token
3. Not using structured logging

Part 10:

1. Long-term storage, advanced search, alerting, retention
2. Error and warn levels for production alerts
