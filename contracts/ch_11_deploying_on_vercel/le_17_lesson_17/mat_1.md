# Le 17: API Routes Best Practices – Building Production-Ready APIs

![API Best Practices](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/api-best-practices.png)

## Background Story

Maria's API is growing. What started as a few endpoints now handles hundreds of requests per minute.

"Some requests are timing out," Maria reports. "And the error messages aren't helpful."

Marco nods. "Time to apply API best practices—proper error handling, timeouts, validation, and streaming. Let's make your API production-ready."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Error handling patterns
- Request validation
- Timeout management
- Response streaming
- Rate limiting strategies
- API versioning
- Documentation and typing

---

## Error Handling Patterns

### The Problem: Generic Errors

```typescript
// Bad: Unhelpful error response
export async function POST(request: Request) {
  try {
    const data = await request.json();
    await processData(data);
    return Response.json({ success: true });
  } catch {
    return Response.json({ error: "Error" }, { status: 500 });
  }
}
```

### The Solution: Structured Error Responses

```typescript
// Good: Structured, informative errors
interface ApiError {
  error: {
    code: string;
    message: string;
    details?: Record<string, string>;
  };
}

export async function POST(request: Request) {
  try {
    const data = await request.json();

    if (!data.name) {
      return Response.json<ApiError>(
        {
          error: {
            code: "VALIDATION_ERROR",
            message: "Missing required field",
            details: { field: "name", reason: "Name is required" },
          },
        },
        { status: 400 }
      );
    }

    const result = await processData(data);
    return Response.json({ success: true, data: result });
  } catch (error) {
    console.error("API Error:", error);

    if (error instanceof DatabaseError) {
      return Response.json<ApiError>(
        {
          error: {
            code: "DATABASE_ERROR",
            message: "Database operation failed",
          },
        },
        { status: 503 }
      );
    }

    return Response.json<ApiError>(
      {
        error: {
          code: "INTERNAL_ERROR",
          message: "An unexpected error occurred",
        },
      },
      { status: 500 }
    );
  }
}
```

### Standard HTTP Status Codes

| Code | Meaning             | When to Use                           |
| ---- | ------------------- | ------------------------------------- |
| 200  | OK                  | Successful GET, PUT                   |
| 201  | Created             | Successful POST that creates resource |
| 204  | No Content          | Successful DELETE                     |
| 400  | Bad Request         | Invalid input, validation errors      |
| 401  | Unauthorized        | Missing or invalid authentication     |
| 403  | Forbidden           | Valid auth, but no permission         |
| 404  | Not Found           | Resource doesn't exist                |
| 409  | Conflict            | Duplicate resource, version conflict  |
| 422  | Unprocessable       | Valid syntax but semantic errors      |
| 429  | Too Many Requests   | Rate limit exceeded                   |
| 500  | Internal Error      | Server-side unexpected errors         |
| 503  | Service Unavailable | Maintenance, overload                 |

---

## Request Validation

### Using Zod for Validation

```typescript
import { z } from "zod";

const CreateUserSchema = z.object({
  name: z.string().min(2).max(100),
  email: z.string().email(),
  age: z.number().int().min(18).optional(),
  role: z.enum(["admin", "user", "guest"]),
});

type CreateUserInput = z.infer<typeof CreateUserSchema>;

export async function POST(request: Request) {
  let body: unknown;

  try {
    body = await request.json();
  } catch {
    return Response.json(
      {
        error: { code: "INVALID_JSON", message: "Invalid JSON body" },
      },
      { status: 400 }
    );
  }

  const result = CreateUserSchema.safeParse(body);

  if (!result.success) {
    return Response.json(
      {
        error: {
          code: "VALIDATION_ERROR",
          message: "Invalid request body",
          details: result.error.flatten().fieldErrors,
        },
      },
      { status: 400 }
    );
  }

  // result.data is now typed as CreateUserInput
  const user = await createUser(result.data);

  return Response.json({ user }, { status: 201 });
}
```

### Query Parameter Validation

```typescript
import { z } from "zod";

const QuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  limit: z.coerce.number().int().min(1).max(100).default(20),
  sort: z.enum(["asc", "desc"]).default("desc"),
});

export async function GET(request: Request) {
  const url = new URL(request.url);
  const params = Object.fromEntries(url.searchParams);

  const result = QuerySchema.safeParse(params);

  if (!result.success) {
    return Response.json(
      {
        error: { code: "INVALID_PARAMS", details: result.error.issues },
      },
      { status: 400 }
    );
  }

  const { page, limit, sort } = result.data;
  const items = await fetchItems({ page, limit, sort });

  return Response.json({ items, page, limit });
}
```

---

## Timeout Management

Vercel has execution time limits. Handle them gracefully:

| Plan  | Serverless Limit | Edge Limit |
| ----- | ---------------- | ---------- |
| Hobby | 10 seconds       | 30 seconds |
| Pro   | 60 seconds       | 30 seconds |

### Using AbortController

```typescript
export async function GET() {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 8000);

  try {
    const response = await fetch("https://slow-api.example.com/data", {
      signal: controller.signal,
    });

    clearTimeout(timeout);
    return Response.json(await response.json());
  } catch (error) {
    if (error instanceof Error && error.name === "AbortError") {
      return Response.json(
        {
          error: { code: "TIMEOUT", message: "Request timed out" },
        },
        { status: 504 }
      );
    }
    throw error;
  }
}
```

### Promise.race for Timeouts

```typescript
async function withTimeout<T>(promise: Promise<T>, ms: number): Promise<T> {
  const timeout = new Promise<never>((_, reject) =>
    setTimeout(() => reject(new Error("TIMEOUT")), ms)
  );
  return Promise.race([promise, timeout]);
}

export async function GET() {
  try {
    const data = await withTimeout(fetchSlowData(), 8000);
    return Response.json(data);
  } catch (error) {
    if (error instanceof Error && error.message === "TIMEOUT") {
      return Response.json(
        {
          error: { code: "TIMEOUT", message: "Operation timed out" },
        },
        { status: 504 }
      );
    }
    throw error;
  }
}
```

---

## Response Streaming

Stream large responses instead of buffering everything:

### Basic Streaming

```typescript
export async function GET() {
  const encoder = new TextEncoder();

  const stream = new ReadableStream({
    async start(controller) {
      for (let i = 1; i <= 10; i++) {
        controller.enqueue(encoder.encode(`Processing item ${i}...\n`));
        await new Promise((r) => setTimeout(r, 500));
      }
      controller.enqueue(encoder.encode("Done!\n"));
      controller.close();
    },
  });

  return new Response(stream, {
    headers: {
      "Content-Type": "text/plain; charset=utf-8",
      "Transfer-Encoding": "chunked",
    },
  });
}
```

### JSON Streaming (NDJSON)

```typescript
export async function GET() {
  const encoder = new TextEncoder();

  const stream = new ReadableStream({
    async start(controller) {
      const items = await fetchLargeDataset();

      for (const item of items) {
        controller.enqueue(encoder.encode(JSON.stringify(item) + "\n"));
      }

      controller.close();
    },
  });

  return new Response(stream, {
    headers: { "Content-Type": "application/x-ndjson" },
  });
}
```

---

## Rate Limiting

Protect your API from abuse:

### Simple In-Memory Rate Limiting

```typescript
const rateLimitMap = new Map<string, { count: number; resetTime: number }>();

function rateLimit(ip: string, limit: number, windowMs: number) {
  const now = Date.now();
  const record = rateLimitMap.get(ip);

  if (!record || now > record.resetTime) {
    rateLimitMap.set(ip, { count: 1, resetTime: now + windowMs });
    return { allowed: true, remaining: limit - 1 };
  }

  if (record.count >= limit) {
    return { allowed: false, remaining: 0, retryAfter: record.resetTime - now };
  }

  record.count++;
  return { allowed: true, remaining: limit - record.count };
}

export async function GET(request: Request) {
  const ip = request.headers.get("x-forwarded-for") || "unknown";
  const { allowed, remaining, retryAfter } = rateLimit(ip, 100, 60000);

  if (!allowed) {
    return Response.json(
      { error: { code: "RATE_LIMIT", message: "Too many requests" } },
      {
        status: 429,
        headers: {
          "Retry-After": String(Math.ceil(retryAfter! / 1000)),
          "X-RateLimit-Remaining": "0",
        },
      }
    );
  }

  return Response.json(
    { data: "Success" },
    { headers: { "X-RateLimit-Remaining": String(remaining) } }
  );
}
```

**Note:** For production, use Redis or Upstash for distributed rate limiting.

---

## API Versioning

### URL Path Versioning

```
/api/v1/users
/api/v2/users
```

```typescript
// app/api/v1/users/route.ts
export async function GET() {
  return Response.json({ version: "v1", format: "old" });
}

// app/api/v2/users/route.ts
export async function GET() {
  return Response.json({ version: "v2", format: "new" });
}
```

### Header-Based Versioning

```typescript
export async function GET(request: Request) {
  const version = request.headers.get("X-API-Version") || "v1";

  if (version === "v2") {
    return Response.json({ format: "v2-format" });
  }

  return Response.json({ format: "v1-format" });
}
```

---

## Response Best Practices

### Consistent Response Format

```typescript
interface SuccessResponse<T> {
  success: true;
  data: T;
  meta?: {
    page?: number;
    totalPages?: number;
    totalItems?: number;
  };
}

interface ErrorResponse {
  success: false;
  error: {
    code: string;
    message: string;
    details?: unknown;
  };
}

type ApiResponse<T> = SuccessResponse<T> | ErrorResponse;

// Helper functions
function success<T>(data: T, meta?: SuccessResponse<T>["meta"]): Response {
  return Response.json<SuccessResponse<T>>({
    success: true,
    data,
    ...(meta && { meta }),
  });
}

function error(code: string, message: string, status = 500): Response {
  return Response.json<ErrorResponse>(
    {
      success: false,
      error: { code, message },
    },
    { status }
  );
}

// Usage
export async function GET() {
  try {
    const users = await getUsers();
    return success(users, { page: 1, totalItems: users.length });
  } catch {
    return error("FETCH_ERROR", "Failed to fetch users", 500);
  }
}
```

### Add Response Headers

```typescript
export async function GET() {
  return Response.json(data, {
    headers: {
      "Cache-Control": "public, max-age=3600",
      "X-Request-ID": crypto.randomUUID(),
      "X-Response-Time": `${responseTime}ms`,
    },
  });
}
```

---

## Logging and Monitoring

### Structured Logging

```typescript
function log(
  level: "info" | "warn" | "error",
  message: string,
  context?: object
) {
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
  const startTime = Date.now();

  log("info", "Request started", { requestId, path: "/api/users" });

  try {
    const result = await processRequest(request);

    log("info", "Request completed", {
      requestId,
      duration: Date.now() - startTime,
      status: 200,
    });

    return Response.json(result);
  } catch (error) {
    log("error", "Request failed", {
      requestId,
      duration: Date.now() - startTime,
      error: String(error),
    });

    return Response.json({ error: "Failed" }, { status: 500 });
  }
}
```

---

## Maria's Production-Ready API

Maria applies all best practices:

```typescript
// app/api/residents/route.ts
import { z } from "zod";

const ResidentSchema = z.object({
  name: z.string().min(2),
  barangay: z.string(),
  age: z.number().int().min(1).max(150),
});

export async function POST(request: Request) {
  const requestId = crypto.randomUUID();
  const startTime = Date.now();

  try {
    // Parse and validate
    const body = await request.json();
    const result = ResidentSchema.safeParse(body);

    if (!result.success) {
      return Response.json(
        {
          success: false,
          error: {
            code: "VALIDATION_ERROR",
            details: result.error.flatten(),
          },
        },
        { status: 400 }
      );
    }

    // Process
    const resident = await createResident(result.data);

    // Log success
    console.log(
      JSON.stringify({
        requestId,
        duration: Date.now() - startTime,
        status: 201,
      })
    );

    return Response.json(
      {
        success: true,
        data: resident,
      },
      {
        status: 201,
        headers: { "X-Request-ID": requestId },
      }
    );
  } catch (error) {
    console.error(
      JSON.stringify({
        requestId,
        error: String(error),
      })
    );

    return Response.json(
      {
        success: false,
        error: { code: "INTERNAL_ERROR", message: "Server error" },
      },
      { status: 500 }
    );
  }
}
```

---

## Key Takeaways

✓ Use structured error responses with error codes
✓ Validate all inputs with Zod or similar
✓ Handle timeouts gracefully with AbortController
✓ Stream large responses instead of buffering
✓ Implement rate limiting to prevent abuse
✓ Version your APIs for backward compatibility
✓ Add structured logging for observability

**Next Lesson:** Connecting to Databases—Vercel Postgres, KV, and external databases!
