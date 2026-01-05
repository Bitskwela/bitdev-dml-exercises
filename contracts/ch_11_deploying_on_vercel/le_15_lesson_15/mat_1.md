# Le 15: Edge Middleware – Intercept Every Request

![Edge Middleware](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/middleware.png)

## Background Story

Maria's Barangay Dashboard is growing. Some pages should only be accessible to logged-in users. Some should redirect based on the user's role.

"I could add authentication checks to every page," Maria says, "but that seems repetitive."

"There's a better way," Marco explains. "With Middleware, you can intercept every request before it reaches your page. It runs at the Edge, so it's fast and runs on every request."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What is Middleware
- How Middleware works
- Creating middleware.ts
- Common middleware patterns
- Matchers and conditional logic
- Authentication and redirects

---

## What is Middleware?

Middleware is code that runs **before** a request reaches your page or API:

```
Without Middleware:
Request ──────────────────────> Page

With Middleware:
Request ───> Middleware ───> Page
                  ↓
            (can redirect, rewrite, or block)
```

Middleware runs at the **Edge**, so it's globally distributed and fast.

---

## How Middleware Works

```
1. User requests /dashboard
2. Middleware runs first (at Edge)
3. Middleware can:
   - Allow the request to continue
   - Redirect to a different URL
   - Rewrite to a different page
   - Add/modify headers
   - Return a custom response
4. If allowed, the page loads
```

---

## Creating Middleware

In Next.js, create `middleware.ts` at the project root:

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  console.log("Middleware running for:", request.nextUrl.pathname);

  // Allow the request to continue
  return NextResponse.next();
}
```

Middleware runs on **every request** by default.

---

## Matching Specific Paths

Use the `matcher` config to limit which paths trigger middleware:

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  // Only runs for matched paths
  return NextResponse.next();
}

export const config = {
  matcher: [
    "/dashboard/:path*", // /dashboard and all subpaths
    "/admin/:path*", // /admin and all subpaths
    "/api/protected/:path*",
  ],
};
```

### Matcher Patterns

```typescript
export const config = {
  matcher: [
    // Specific path
    "/about",

    // Path with dynamic segment
    "/user/:id",

    // All subpaths
    "/dashboard/:path*",

    // Multiple paths
    "/dashboard/:path*",
    "/admin/:path*",

    // Regex (advanced)
    "/((?!api|_next/static|_next/image|favicon.ico).*)",
  ],
};
```

---

## Redirects

Redirect users to different pages:

```typescript
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Redirect old URLs to new ones
  if (pathname === "/old-page") {
    return NextResponse.redirect(new URL("/new-page", request.url));
  }

  // Redirect to login if not authenticated
  const token = request.cookies.get("auth-token");
  if (!token && pathname.startsWith("/dashboard")) {
    return NextResponse.redirect(new URL("/login", request.url));
  }

  return NextResponse.next();
}
```

---

## Rewrites

Serve a different page without changing the URL:

```typescript
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Rewrite /blog/123 to /posts/123 internally
  if (pathname.startsWith("/blog/")) {
    const newUrl = pathname.replace("/blog/", "/posts/");
    return NextResponse.rewrite(new URL(newUrl, request.url));
  }

  return NextResponse.next();
}
```

**Redirect vs Rewrite:**

- **Redirect:** URL changes in browser, new HTTP request
- **Rewrite:** URL stays the same, different content served

---

## Authentication Middleware

Common pattern: protect pages that require login:

```typescript
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const protectedPaths = ["/dashboard", "/admin", "/settings"];
const publicPaths = ["/", "/login", "/register", "/about"];

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Check if path is protected
  const isProtected = protectedPaths.some((path) => pathname.startsWith(path));

  if (!isProtected) {
    return NextResponse.next();
  }

  // Check for authentication token
  const token = request.cookies.get("auth-token")?.value;

  if (!token) {
    // Redirect to login with return URL
    const loginUrl = new URL("/login", request.url);
    loginUrl.searchParams.set("from", pathname);
    return NextResponse.redirect(loginUrl);
  }

  // Optionally verify token here
  // (but keep it simple - Edge has limitations)

  return NextResponse.next();
}

export const config = {
  matcher: ["/dashboard/:path*", "/admin/:path*", "/settings/:path*"],
};
```

---

## Role-Based Access Control

```typescript
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Get user role from cookie (set during login)
  const role = request.cookies.get("user-role")?.value;

  // Admin-only pages
  if (pathname.startsWith("/admin")) {
    if (role !== "admin") {
      return NextResponse.redirect(new URL("/unauthorized", request.url));
    }
  }

  // Staff or admin pages
  if (pathname.startsWith("/staff")) {
    if (role !== "admin" && role !== "staff") {
      return NextResponse.redirect(new URL("/unauthorized", request.url));
    }
  }

  return NextResponse.next();
}
```

---

## Geolocation-Based Routing

```typescript
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const country = request.headers.get("x-vercel-ip-country") || "US";
  const { pathname } = request.nextUrl;

  // Redirect to country-specific version
  if (pathname === "/") {
    if (country === "JP") {
      return NextResponse.redirect(new URL("/ja", request.url));
    }
    if (country === "PH") {
      return NextResponse.redirect(new URL("/ph", request.url));
    }
  }

  return NextResponse.next();
}
```

---

## Adding Headers

Add security or custom headers to responses:

```typescript
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const response = NextResponse.next();

  // Security headers
  response.headers.set("X-Frame-Options", "DENY");
  response.headers.set("X-Content-Type-Options", "nosniff");
  response.headers.set("Referrer-Policy", "strict-origin-when-cross-origin");

  // Custom headers
  response.headers.set("X-Served-By", "Vercel Edge");

  return response;
}
```

---

## Blocking Requests

Block suspicious or unauthorized requests:

```typescript
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const blockedCountries = ["XX", "YY"]; // Example country codes
const blockedIPs = ["1.2.3.4", "5.6.7.8"];

export function middleware(request: NextRequest) {
  const country = request.headers.get("x-vercel-ip-country");
  const ip = request.headers.get("x-forwarded-for")?.split(",")[0];

  // Block by country
  if (country && blockedCountries.includes(country)) {
    return new NextResponse("Access denied", { status: 403 });
  }

  // Block by IP
  if (ip && blockedIPs.includes(ip)) {
    return new NextResponse("Access denied", { status: 403 });
  }

  return NextResponse.next();
}
```

---

## A/B Testing

Route users to different versions:

```typescript
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  if (pathname === "/landing") {
    // Check for existing variant cookie
    let variant = request.cookies.get("ab-variant")?.value;

    if (!variant) {
      // Assign random variant
      variant = Math.random() < 0.5 ? "a" : "b";
    }

    // Rewrite to variant page
    const response = NextResponse.rewrite(
      new URL(`/landing-${variant}`, request.url)
    );

    // Set cookie for consistency
    response.cookies.set("ab-variant", variant, {
      maxAge: 60 * 60 * 24 * 7, // 1 week
    });

    return response;
  }

  return NextResponse.next();
}
```

---

## Middleware Best Practices

### DO ✅

```
✅ Keep middleware lightweight
✅ Use matchers to limit scope
✅ Handle errors gracefully
✅ Test locally with vercel dev
✅ Log important events
```

### DON'T ❌

```
❌ Perform heavy computation
❌ Make slow API calls
❌ Access databases directly
❌ Process large payloads
❌ Run middleware on static assets
```

---

## Maria's Auth Middleware

Maria protects her dashboard:

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const token = request.cookies.get("session")?.value;
  const { pathname } = request.nextUrl;

  // Redirect to login if accessing protected pages without auth
  if (!token) {
    const url = new URL("/login", request.url);
    url.searchParams.set("redirect", pathname);
    return NextResponse.redirect(url);
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/dashboard/:path*", "/residents/:path*", "/reports/:path*"],
};
```

Now users are automatically redirected to login if they try to access protected pages!

---

## Key Takeaways

✓ Middleware runs before every matched request
✓ It runs at the Edge for low latency
✓ Use `matcher` to limit which paths trigger middleware
✓ Can redirect, rewrite, add headers, or block requests
✓ Perfect for auth, A/B testing, and geolocation
✓ Keep middleware lightweight—no heavy processing

**Next Lesson:** Cron Jobs—scheduled tasks that run automatically!
