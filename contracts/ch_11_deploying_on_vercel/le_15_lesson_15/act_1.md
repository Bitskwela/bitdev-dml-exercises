# Edge Middleware Activity

Middleware intercepts requests before they reach your pages. In this activity, you'll create authentication and routing middleware.

## Task for Students

### Part 1: Middleware Concepts Quiz

**Question 1:** When does middleware run?

- A) After the page loads
- B) Before the request reaches the page
- C) Only on the server
- D) Only in the browser

**Question 2:** Where does Next.js middleware run?

- A) In the browser
- B) On a single server
- C) At the Edge (globally)
- D) In the database

**Question 3:** What is the purpose of the `matcher` config?

- A) To define URL patterns that trigger middleware
- B) To match request body content
- C) To match database records
- D) To define CSS classes

**Question 4:** What's the difference between redirect and rewrite?

- A) There is no difference
- B) Redirect changes the URL; rewrite serves different content at the same URL
- C) Rewrite is faster
- D) Redirect only works locally

**Question 5:** Where do you put the middleware file in Next.js?

- A) `/pages/middleware.ts`
- B) `/src/middleware.ts` or `/middleware.ts` at project root
- C) `/api/middleware.ts`
- D) `/public/middleware.ts`

---

### Part 2: Create Basic Middleware

**Step 1:** Create `middleware.ts` at the project root:

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  console.log("Request to:", request.nextUrl.pathname);

  // Add a custom header to all responses
  const response = NextResponse.next();
  response.headers.set("X-Middleware-Demo", "active");

  return response;
}
```

**Step 2:** Test locally:

```bash
npm run dev
# Visit any page and check response headers in DevTools
```

**Step 3:** Check for the custom header:

- Open DevTools → Network tab
- Click on any request
- Look for `X-Middleware-Demo` in Response Headers

---

### Part 3: Path Matching

**Task:** Create middleware that only runs on specific paths.

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  console.log("Protected path accessed:", pathname);

  return NextResponse.next();
}

export const config = {
  matcher: ["/dashboard/:path*", "/admin/:path*", "/api/protected/:path*"],
};
```

**Test:**

- Visit `/` - middleware should NOT run
- Visit `/dashboard` - middleware SHOULD run
- Visit `/admin/users` - middleware SHOULD run

---

### Part 4: Authentication Middleware

**Task:** Protect dashboard pages with authentication.

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Check for auth token in cookies
  const token = request.cookies.get("auth-token")?.value;

  // If no token and accessing protected page, redirect to login
  if (!token) {
    const loginUrl = new URL("/login", request.url);
    loginUrl.searchParams.set("redirect", pathname);
    return NextResponse.redirect(loginUrl);
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/dashboard/:path*"],
};
```

**Test:**

1. Clear cookies
2. Visit `/dashboard` - should redirect to `/login?redirect=/dashboard`
3. Set a cookie named `auth-token` with any value
4. Visit `/dashboard` - should load normally

---

### Part 5: Redirect Exercise

**Task:** Create redirects for old URLs.

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const redirects: Record<string, string> = {
  "/old-about": "/about",
  "/old-contact": "/contact",
  "/blog": "/news",
  "/team": "/about#team",
};

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Check if this path needs redirecting
  if (redirects[pathname]) {
    return NextResponse.redirect(new URL(redirects[pathname], request.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: Object.keys(redirects),
};
```

**Questions:**

1. What status code does `NextResponse.redirect` use by default? (Hint: 307)
2. How would you change it to a permanent redirect (301)?

---

### Part 6: Geolocation Routing

**Task:** Route users based on their country.

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Only check for root path
  if (pathname !== "/") {
    return NextResponse.next();
  }

  const country = request.headers.get("x-vercel-ip-country");

  // Country-specific redirects
  const countryRoutes: Record<string, string> = {
    JP: "/ja",
    PH: "/ph",
    US: "/en",
  };

  const redirectPath = countryRoutes[country || ""];

  if (redirectPath) {
    return NextResponse.redirect(new URL(redirectPath, request.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/"],
};
```

---

### Part 7: A/B Testing Middleware

**Task:** Split traffic between two variants.

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  if (pathname === "/landing") {
    // Check for existing variant
    let variant = request.cookies.get("variant")?.value;

    if (!variant) {
      // Assign random variant (50/50)
      variant = Math.random() < 0.5 ? "a" : "b";
    }

    // Rewrite to variant page (URL stays /landing)
    const response = NextResponse.rewrite(
      new URL(`/landing-${variant}`, request.url)
    );

    // Store variant in cookie
    response.cookies.set("variant", variant, {
      maxAge: 60 * 60 * 24 * 7, // 1 week
      path: "/",
    });

    return response;
  }

  return NextResponse.next();
}
```

**Required pages:**

- Create `/landing-a` page (variant A design)
- Create `/landing-b` page (variant B design)

**Test:**

1. Visit `/landing` in incognito - note which variant
2. Clear cookies, visit again - might see different variant
3. With cookie set, should always see same variant

---

### Part 8: Security Headers

**Task:** Add security headers to all responses.

```typescript
// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const response = NextResponse.next();

  // Security headers
  response.headers.set("X-Frame-Options", "DENY");
  response.headers.set("X-Content-Type-Options", "nosniff");
  response.headers.set("X-XSS-Protection", "1; mode=block");
  response.headers.set("Referrer-Policy", "strict-origin-when-cross-origin");
  response.headers.set(
    "Permissions-Policy",
    "camera=(), microphone=(), geolocation=()"
  );

  return response;
}
```

---

### What You Learned

✓ Middleware runs before requests reach your pages
✓ Create `middleware.ts` at project root
✓ Use `matcher` config to specify which paths trigger middleware
✓ Redirects change the URL; rewrites serve different content at same URL
✓ Perfect for auth, geo-routing, A/B testing, and security headers
✓ Keep middleware lightweight for performance

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-A, 4-B, 5-B

Part 5 Answers:

1. Default redirect status code is 307 (Temporary Redirect)
2. For permanent: `NextResponse.redirect(url, 301)` or `NextResponse.redirect(url, { status: 301 })`
