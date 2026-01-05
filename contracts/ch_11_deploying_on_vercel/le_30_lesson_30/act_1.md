# Production Checklist Activity

Prepare for launch! In this final activity, you'll create and validate a comprehensive production checklist.

## Task for Students

### Part 1: Production Readiness Quiz

**Question 1:** What is the good threshold for LCP (Largest Contentful Paint)?

- A) < 1 second
- B) < 2.5 seconds
- C) < 5 seconds
- D) < 10 seconds

**Question 2:** Which is NOT a security header?

- A) X-Frame-Options
- B) Content-Security-Policy
- C) X-Robots-Tag
- D) Strict-Transport-Security

**Question 3:** What should a health endpoint check?

- A) Only database
- B) Database and critical external services
- C) Nothing, just return 200
- D) User authentication

**Question 4:** When should you set up monitoring?

- A) After launch when you have users
- B) Before launch
- C) Only if you have problems
- D) Monthly

**Question 5:** What is the first thing to do if production breaks?

- A) Debug the code
- B) Rollback to previous deployment
- C) Write a post-mortem
- D) Blame the developer

---

### Part 2: Performance Audit

**Task:** Evaluate these Lighthouse scores:

| Metric         | Score | Status |
| -------------- | ----- | ------ |
| Performance    | 72    | \_\_\_ |
| Accessibility  | 95    | \_\_\_ |
| Best Practices | 88    | \_\_\_ |
| SEO            | 100   | \_\_\_ |

**Questions:**

1. Which metric needs the most work? \_\_\_

2. What might cause a low performance score? \_\_\_

3. What's an acceptable minimum for each metric? \_\_\_

---

### Part 3: Security Headers Configuration

**Task:** Add security headers to your Vercel configuration:

```json
// vercel.json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "Referrer-Policy",
          "value": "strict-origin-when-cross-origin"
        },
        {
          "key": "Content-Security-Policy",
          "value": "default-src 'self'; img-src 'self' https://images.example.com; script-src 'self'"
        },
        {
          "key": "Permissions-Policy",
          "value": "camera=(), microphone=(), geolocation=()"
        },
        {
          "key": "Strict-Transport-Security",
          "value": "max-age=31536000; includeSubDomains"
        }
      ]
    }
  ]
}
```

**Exercise:** Explain what each header does:

| Header                    | Purpose |
| ------------------------- | ------- |
| X-Frame-Options           | \_\_\_  |
| X-Content-Type-Options    | \_\_\_  |
| Content-Security-Policy   | \_\_\_  |
| Strict-Transport-Security | \_\_\_  |

---

### Part 4: Create Health Endpoint

**Task:** Implement a comprehensive health check:

```typescript
// app/api/health/route.ts
import { NextResponse } from "next/server";

export async function GET() {
  const checks = {
    database: false,
    redis: false,
    externalApi: false,
  };

  // Check database
  try {
    await db.query("SELECT 1");
    checks.database = true;
  } catch (e) {
    console.error("Database check failed:", e);
  }

  // Check Redis cache
  try {
    await redis.ping();
    checks.redis = true;
  } catch (e) {
    console.error("Redis check failed:", e);
  }

  // Check external API
  try {
    const res = await fetch("https://api.external.com/health");
    checks.externalApi = res.ok;
  } catch (e) {
    console.error("External API check failed:", e);
  }

  const allHealthy = Object.values(checks).every(Boolean);

  return NextResponse.json(
    {
      status: allHealthy ? "healthy" : "unhealthy",
      checks,
      timestamp: new Date().toISOString(),
    },
    { status: allHealthy ? 200 : 503 }
  );
}
```

**Questions:**

1. Why return 503 when unhealthy? \_\_\_

2. What other services might you check? \_\_\_

3. How would monitoring tools use this endpoint? \_\_\_

---

### Part 5: SEO Configuration

**Task:** Configure SEO for your application:

```tsx
// app/layout.tsx
import { Metadata } from "next";

export const metadata: Metadata = {
  metadataBase: new URL("https://barangay-dashboard.ph"),
  title: {
    template: "%s | Barangay Dashboard",
    default: "Barangay Dashboard",
  },
  description: "Official digital services portal for our barangay",
  keywords: ["barangay", "services", "community", "government"],
  authors: [{ name: "Barangay Tech Team" }],
  openGraph: {
    type: "website",
    locale: "en_PH",
    url: "https://barangay-dashboard.ph",
    siteName: "Barangay Dashboard",
    images: [
      {
        url: "/og-image.png",
        width: 1200,
        height: 630,
        alt: "Barangay Dashboard",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    creator: "@barangay_ph",
  },
  robots: {
    index: true,
    follow: true,
  },
};
```

**Exercise:** Create the sitemap:

```typescript
// app/sitemap.ts
import { MetadataRoute } from "next";

export default function sitemap(): MetadataRoute.Sitemap {
  return [
    {
      url: "https://barangay-dashboard.ph",
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 1,
    },
    {
      url: "https://barangay-dashboard.ph/services",
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 0.8,
    },
    // Add more pages...
  ];
}
```

---

### Part 6: Error Pages

**Task:** Create custom error pages:

**404 Page:**

```tsx
// app/not-found.tsx
export default function NotFound() {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen">
      <h1 className="text-6xl font-bold text-gray-300">404</h1>
      <h2 className="text-2xl mt-4">Page Not Found</h2>
      <p className="mt-2 text-gray-600">
        The page you're looking for doesn't exist.
      </p>
      <a href="/" className="mt-6 px-6 py-3 bg-blue-600 text-white rounded-lg">
        Go Home
      </a>
    </div>
  );
}
```

**Error Page:**

```tsx
// app/error.tsx
"use client";

export default function Error({
  error,
  reset,
}: {
  error: Error;
  reset: () => void;
}) {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen">
      <h1 className="text-4xl font-bold">Something went wrong</h1>
      <p className="mt-2 text-gray-600">
        We're sorry, but something unexpected happened.
      </p>
      <div className="mt-6 space-x-4">
        <button
          onClick={reset}
          className="px-6 py-3 bg-blue-600 text-white rounded-lg"
        >
          Try Again
        </button>
        <a href="/" className="px-6 py-3 bg-gray-200 rounded-lg">
          Go Home
        </a>
      </div>
    </div>
  );
}
```

---

### Part 7: Monitoring Setup

**Task:** Configure monitoring alerts:

```typescript
// lib/monitoring.ts
export async function trackError(error: Error, context?: object) {
  // Log to console in development
  console.error("Error:", error.message, context);

  // Send to error tracking service
  if (process.env.SENTRY_DSN) {
    Sentry.captureException(error, { extra: context });
  }
}

export async function trackMetric(name: string, value: number) {
  // Send to analytics
  await fetch("/api/metrics", {
    method: "POST",
    body: JSON.stringify({ name, value, timestamp: Date.now() }),
  });
}
```

**Exercise:** What metrics would you track?

| Metric               | Why Important |
| -------------------- | ------------- |
| Response time        | \_\_\_        |
| Error rate           | \_\_\_        |
| Active users         | \_\_\_        |
| Database connections | \_\_\_        |

---

### Part 8: Pre-Launch Checklist

**Task:** Complete this checklist for your project:

```markdown
# Pre-Launch Checklist

## Code Quality

- [ ] All tests passing
- [ ] No TypeScript errors
- [ ] No ESLint warnings
- [ ] Code reviewed

## Performance

- [ ] Lighthouse score > 90
- [ ] Core Web Vitals passing
- [ ] Images optimized
- [ ] Bundle size acceptable (<200KB JS)

## Security

- [ ] Security headers configured
- [ ] Authentication tested
- [ ] API routes protected
- [ ] Rate limiting enabled
- [ ] No secrets in code

## SEO & Accessibility

- [ ] Meta tags on all pages
- [ ] sitemap.xml working
- [ ] robots.txt configured
- [ ] Alt text on images
- [ ] Color contrast passing

## Infrastructure

- [ ] Custom domain configured
- [ ] SSL certificate valid
- [ ] Environment variables set
- [ ] Monitoring enabled
- [ ] Alerting configured

## Documentation

- [ ] README updated
- [ ] Deployment documented
- [ ] Runbooks created
- [ ] Privacy policy added

## Launch Preparation

- [ ] Rollback plan ready
- [ ] Team on standby
- [ ] Communication ready
```

---

### Part 9: Launch Day Runbook

**Task:** Create a launch day runbook:

```markdown
# Launch Day Runbook

## T-1 Hour: Final Preparations

1. [ ] Team check-in on Slack
2. [ ] Verify all automated checks passing
3. [ ] Final review of preview deployment
4. [ ] Confirm rollback procedure
5. [ ] Database backup completed

## T-0: Launch

1. [ ] Execute: `vercel deploy --prod`
2. [ ] Verify deployment succeeded
3. [ ] Check health endpoint: `curl https://app.com/api/health`
4. [ ] Test critical user paths:
   - [ ] Homepage loads
   - [ ] Login works
   - [ ] Main feature works
5. [ ] Monitor error dashboard

## T+15 Minutes: Initial Monitoring

1. [ ] Check error rates (should be < 0.1%)
2. [ ] Check response times (should be < 500ms)
3. [ ] Review any user reports
4. [ ] If issues: decide on rollback

## T+1 Hour: Stabilization

1. [ ] Confirm metrics are stable
2. [ ] Send launch announcement
3. [ ] Reduce team to normal on-call
4. [ ] Document any issues encountered

## Rollback Procedure

If critical issues:

1. Run: `vercel rollback`
2. Verify site is working
3. Notify team
4. Investigate root cause
```

---

### Part 10: Post-Launch Maintenance Plan

**Task:** Create a maintenance schedule:

| Frequency | Task                            | Owner  |
| --------- | ------------------------------- | ------ |
| Daily     | Check error logs                | \_\_\_ |
| Daily     | Review performance metrics      | \_\_\_ |
| Weekly    | Dependency security scan        | \_\_\_ |
| Weekly    | Review user feedback            | \_\_\_ |
| Monthly   | Full security audit             | \_\_\_ |
| Monthly   | Performance optimization review | \_\_\_ |
| Quarterly | Disaster recovery test          | \_\_\_ |

---

### What You Learned

✓ Creating comprehensive production checklists
✓ Configuring security headers
✓ Implementing health endpoints
✓ Setting up SEO and accessibility
✓ Creating error pages
✓ Planning for launch day

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-B, 4-B, 5-B

Part 2:

1. Performance (72)
2. Large images, heavy JavaScript, no caching, slow API
3. 90+ for all is ideal; 80+ minimum for production

Part 3:

- X-Frame-Options: Prevents page from being embedded in iframes (clickjacking)
- X-Content-Type-Options: Prevents MIME type sniffing
- Content-Security-Policy: Controls which resources can load
- Strict-Transport-Security: Forces HTTPS connections

Part 4:

1. 503 = Service Unavailable, tells load balancers to route elsewhere
2. Authentication service, payment gateway, storage service, email service
3. Poll every 30-60 seconds, alert if unhealthy

Part 7:

- Response time: Slow responses = poor UX
- Error rate: High errors = broken functionality
- Active users: Usage patterns, capacity planning
- Database connections: Prevent exhaustion, scale accordingly

**🎉 Congratulations on completing the course!**
