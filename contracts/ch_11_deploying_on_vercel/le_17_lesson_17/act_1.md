# API Routes Best Practices Activity

Production-ready APIs need proper error handling, validation, and performance optimizations. In this activity, you'll apply best practices to build robust endpoints.

## Task for Students

### Part 1: API Best Practices Quiz

**Question 1:** Which HTTP status code indicates a validation error?

- A) 200
- B) 400
- C) 401
- D) 500

**Question 2:** What is the Vercel serverless function timeout for Hobby plans?

- A) 5 seconds
- B) 10 seconds
- C) 30 seconds
- D) 60 seconds

**Question 3:** Which library is commonly used for request validation in TypeScript?

- A) lodash
- B) axios
- C) zod
- D) moment

**Question 4:** What status code should you return when rate limiting is triggered?

- A) 401
- B) 403
- C) 429
- D) 503

**Question 5:** What is NDJSON used for?

- A) Encrypting JSON
- B) Compressing JSON
- C) Streaming JSON line by line
- D) Validating JSON

---

### Part 2: Implement Error Handling

**Task:** Improve this API route with proper error handling.

**Before (Bad):**

```typescript
export async function POST(request: Request) {
  const data = await request.json();
  const result = await saveToDatabase(data);
  return Response.json(result);
}
```

**Your Task:** Rewrite with proper error handling:

```typescript
// app/api/residents/route.ts
export async function POST(request: Request) {
  // TODO: Parse JSON with try/catch
  // TODO: Validate required fields
  // TODO: Handle database errors
  // TODO: Return structured responses
}
```

**Expected error response format:**

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "details": {}
  }
}
```

---

### Part 3: Add Zod Validation

**Step 1:** Install Zod:

```bash
npm install zod
```

**Step 2:** Create a validated endpoint:

```typescript
// app/api/register/route.ts
import { z } from "zod";

// Define schema
const RegistrationSchema = z.object({
  name: z.string().min(2, "Name must be at least 2 characters"),
  email: z.string().email("Invalid email format"),
  age: z.number().int().min(18, "Must be 18 or older"),
  barangay: z.string(),
});

type RegistrationInput = z.infer<typeof RegistrationSchema>;

export async function POST(request: Request) {
  // Parse JSON
  let body: unknown;
  try {
    body = await request.json();
  } catch {
    return Response.json(
      {
        success: false,
        error: {
          code: "INVALID_JSON",
          message: "Request body must be valid JSON",
        },
      },
      { status: 400 }
    );
  }

  // Validate
  const result = RegistrationSchema.safeParse(body);

  if (!result.success) {
    return Response.json(
      {
        success: false,
        error: {
          code: "VALIDATION_ERROR",
          message: "Invalid input",
          details: result.error.flatten().fieldErrors,
        },
      },
      { status: 400 }
    );
  }

  // Process valid data
  console.log("Valid registration:", result.data);

  return Response.json(
    {
      success: true,
      data: {
        message: "Registration successful",
        registered: result.data,
      },
    },
    { status: 201 }
  );
}
```

**Step 3:** Test with valid data:

```bash
curl -X POST http://localhost:3000/api/register \
  -H "Content-Type: application/json" \
  -d '{"name": "Maria", "email": "maria@barangay.gov.ph", "age": 25, "barangay": "San Miguel"}'
```

**Step 4:** Test with invalid data:

```bash
curl -X POST http://localhost:3000/api/register \
  -H "Content-Type: application/json" \
  -d '{"name": "M", "email": "invalid", "age": 15}'
```

---

### Part 4: Implement Timeout Handling

**Task:** Create an endpoint that handles timeouts gracefully.

```typescript
// app/api/external-data/route.ts
export async function GET() {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), 8000);

  try {
    // Simulate slow external API
    const response = await fetch("https://httpbin.org/delay/10", {
      signal: controller.signal,
    });

    clearTimeout(timeoutId);
    const data = await response.json();

    return Response.json({
      success: true,
      data,
    });
  } catch (error) {
    clearTimeout(timeoutId);

    if (error instanceof Error && error.name === "AbortError") {
      return Response.json(
        {
          success: false,
          error: {
            code: "TIMEOUT",
            message: "External API did not respond in time",
          },
        },
        { status: 504 }
      );
    }

    return Response.json(
      {
        success: false,
        error: {
          code: "FETCH_ERROR",
          message: "Failed to fetch external data",
        },
      },
      { status: 500 }
    );
  }
}
```

---

### Part 5: Create a Streaming Response

**Task:** Stream a large response instead of buffering.

```typescript
// app/api/stream/route.ts
export async function GET() {
  const encoder = new TextEncoder();

  const stream = new ReadableStream({
    async start(controller) {
      const items = [
        "Loading...",
        "Processing item 1",
        "Processing item 2",
        "Processing item 3",
        "Done!",
      ];

      for (const item of items) {
        controller.enqueue(encoder.encode(item + "\n"));
        await new Promise((r) => setTimeout(r, 1000));
      }

      controller.close();
    },
  });

  return new Response(stream, {
    headers: {
      "Content-Type": "text/plain; charset=utf-8",
      "Cache-Control": "no-cache",
    },
  });
}
```

**Test it:**

```bash
curl http://localhost:3000/api/stream
```

You should see each line appear one second apart.

---

### Part 6: Rate Limiting Exercise

**Task:** Fill in the missing code for rate limiting.

```typescript
// Simple rate limit implementation
const rateLimit = new Map<string, { count: number; resetTime: number }>();

function checkRateLimit(ip: string, maxRequests: number, windowMs: number) {
  const now = Date.now();
  const record = rateLimit.get(ip);

  // TODO: If no record or window expired, create new record
  // TODO: If over limit, return { allowed: false, retryAfter: ... }
  // TODO: Otherwise increment and return { allowed: true, remaining: ... }
}

export async function GET(request: Request) {
  const ip = request.headers.get("x-forwarded-for") || "unknown";
  const result = checkRateLimit(ip, 10, 60000); // 10 requests per minute

  if (!result.allowed) {
    return Response.json(
      {
        error: { code: "RATE_LIMIT", message: "Too many requests" },
      },
      {
        status: 429,
        headers: { "Retry-After": String(result.retryAfter) },
      }
    );
  }

  return Response.json({ message: "Success", remaining: result.remaining });
}
```

---

### Part 7: Build a Complete Production Endpoint

**Task:** Combine all best practices in one endpoint.

```typescript
// app/api/residents/[id]/route.ts
import { z } from "zod";

const UpdateSchema = z.object({
  name: z.string().min(2).optional(),
  email: z.string().email().optional(),
  address: z.string().optional(),
});

export async function PATCH(
  request: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const requestId = crypto.randomUUID();
  const startTime = Date.now();
  const { id } = await params;

  // Log request start
  console.log(
    JSON.stringify({
      requestId,
      method: "PATCH",
      path: `/api/residents/${id}`,
    })
  );

  try {
    // Parse body
    let body: unknown;
    try {
      body = await request.json();
    } catch {
      return Response.json(
        {
          success: false,
          error: { code: "INVALID_JSON", message: "Invalid JSON" },
        },
        { status: 400 }
      );
    }

    // Validate
    const result = UpdateSchema.safeParse(body);
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

    // Simulate database update
    const updated = { id, ...result.data, updatedAt: new Date().toISOString() };

    // Log success
    console.log(
      JSON.stringify({
        requestId,
        duration: Date.now() - startTime,
        status: 200,
      })
    );

    return Response.json(
      {
        success: true,
        data: updated,
      },
      {
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

### Part 8: Match Status Codes

Match the scenario to the correct HTTP status code:

| Scenario                     | Status |
| ---------------------------- | ------ |
| User not logged in           | \_\_\_ |
| Invalid email format         | \_\_\_ |
| Resource created             | \_\_\_ |
| Resource deleted             | \_\_\_ |
| User logged in but not admin | \_\_\_ |
| Rate limit exceeded          | \_\_\_ |
| Database connection failed   | \_\_\_ |

---

### What You Learned

✓ Structured error responses with codes and details
✓ Input validation with Zod schemas
✓ Timeout handling with AbortController
✓ Response streaming for large data
✓ Rate limiting to prevent abuse
✓ Structured logging for debugging
✓ Consistent response formats

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-C, 4-C, 5-C

Part 6 Solution:

```typescript
function checkRateLimit(ip: string, maxRequests: number, windowMs: number) {
  const now = Date.now();
  const record = rateLimit.get(ip);

  if (!record || now > record.resetTime) {
    rateLimit.set(ip, { count: 1, resetTime: now + windowMs });
    return { allowed: true, remaining: maxRequests - 1 };
  }

  if (record.count >= maxRequests) {
    return {
      allowed: false,
      retryAfter: Math.ceil((record.resetTime - now) / 1000),
    };
  }

  record.count++;
  return { allowed: true, remaining: maxRequests - record.count };
}
```

Part 8:

- User not logged in → 401
- Invalid email format → 400
- Resource created → 201
- Resource deleted → 204
- User logged in but not admin → 403
- Rate limit exceeded → 429
- Database connection failed → 503
