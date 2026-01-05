# Le 30: Production Checklist – Ensuring Your Deployment is Ready for Users

![Production Ready](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/production-checklist.png)

## Background Story

Maria's barangay dashboard has come a long way. It's been through development, testing, and preview deployments. Now it's time for the real launch.

"Are we ready for production?" Maria asks nervously.

"Let's go through the checklist," Marco says. "If everything checks out, you're ready to go live."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Pre-launch checklist
- Performance optimization
- Security hardening
- SEO and accessibility
- Monitoring and alerts
- Documentation
- Launch day preparation

---

## The Production Mindset

### Development vs Production

| Development      | Production        |
| ---------------- | ----------------- |
| Fast iteration   | Stability first   |
| Debug tools on   | Debug tools off   |
| Local data       | Real user data    |
| You are the user | Real users        |
| Errors expected  | Errors = problems |

---

## Pre-Launch Checklist Overview

```
□ Performance
□ Security
□ SEO & Accessibility
□ Monitoring
□ Error Handling
□ Environment Variables
□ Domain & SSL
□ Documentation
□ Team Preparation
```

---

## Performance Checklist

### Core Web Vitals

| Metric | Good    | Needs Work | Poor    |
| ------ | ------- | ---------- | ------- |
| LCP    | < 2.5s  | 2.5-4s     | > 4s    |
| INP    | < 200ms | 200-500ms  | > 500ms |
| CLS    | < 0.1   | 0.1-0.25   | > 0.25  |

### Performance Tasks

```markdown
□ Run Lighthouse audit (score > 90)
□ Check all Core Web Vitals pass
□ Images optimized (WebP, proper sizing)
□ JavaScript bundle size acceptable
□ CSS optimized (no unused styles)
□ Fonts optimized (preload, subset)
□ Third-party scripts minimal
□ Caching headers configured
□ CDN working correctly
```

### Vercel Speed Insights

```javascript
// Ensure Speed Insights is enabled
// vercel.json
{
  "analytics": true
}
```

---

## Security Checklist

### Authentication & Authorization

```markdown
□ Authentication working correctly
□ Protected routes secured
□ API routes require authentication where needed
□ CORS configured properly
□ CSRF protection enabled
□ Session management secure
□ Password requirements enforced
```

### Security Headers

```json
// vercel.json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "X-Frame-Options", "value": "DENY" },
        { "key": "X-Content-Type-Options", "value": "nosniff" },
        { "key": "X-XSS-Protection", "value": "1; mode=block" },
        {
          "key": "Referrer-Policy",
          "value": "strict-origin-when-cross-origin"
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

### Environment Variables

```markdown
□ All secrets in Vercel environment variables
□ No secrets in code or .env committed
□ Production values different from development
□ API keys restricted to domains
□ Sensitive vars not exposed to client
```

---

## SEO Checklist

### Meta Tags

```tsx
// app/layout.tsx
export const metadata = {
  title: "Barangay Dashboard",
  description: "Official dashboard for barangay services",
  keywords: ["barangay", "services", "community"],
  openGraph: {
    title: "Barangay Dashboard",
    description: "Access community services online",
    images: ["/og-image.png"],
  },
  twitter: {
    card: "summary_large_image",
  },
};
```

### SEO Tasks

```markdown
□ Unique title for each page
□ Meta descriptions present
□ Open Graph tags configured
□ robots.txt allows crawling
□ sitemap.xml generated
□ Canonical URLs set
□ Structured data (JSON-LD) added
□ 404 page customized
□ Redirects configured for old URLs
```

### Robots.txt

```txt
# public/robots.txt
User-agent: *
Allow: /

Sitemap: https://barangay-dashboard.vercel.app/sitemap.xml
```

---

## Accessibility Checklist

### A11y Requirements

```markdown
□ All images have alt text
□ Form labels properly associated
□ Color contrast meets WCAG 2.1 AA
□ Keyboard navigation works
□ Focus indicators visible
□ Skip to main content link
□ Proper heading hierarchy
□ ARIA labels where needed
□ Screen reader tested
```

### Automated Testing

```bash
# Run accessibility audit
npx pa11y https://your-site.vercel.app

# Or use Lighthouse
lighthouse https://your-site.vercel.app --only-categories=accessibility
```

---

## Error Handling Checklist

### User-Facing Errors

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
    <div className="error-page">
      <h2>Something went wrong</h2>
      <p>We apologize for the inconvenience.</p>
      <button onClick={reset}>Try again</button>
      <a href="/">Go home</a>
    </div>
  );
}
```

### Error Tasks

```markdown
□ Global error boundary implemented
□ 404 page customized
□ 500 error page designed
□ API errors return proper status codes
□ User-friendly error messages
□ Error logging configured
□ Sentry or similar integrated
```

---

## Monitoring Checklist

### Vercel Monitoring

```markdown
□ Vercel Analytics enabled
□ Speed Insights configured
□ Log drains set up
□ Alert thresholds configured
□ Status page ready
```

### External Monitoring

```markdown
□ Uptime monitoring (UptimeRobot, etc.)
□ Error tracking (Sentry)
□ Performance monitoring (Datadog, etc.)
□ Alert channels configured (Slack, email)
```

### Health Endpoint

```typescript
// app/api/health/route.ts
export async function GET() {
  try {
    // Check database
    await db.query("SELECT 1");

    // Check external services
    await fetch("https://api.external.com/health");

    return Response.json({
      status: "healthy",
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    return Response.json(
      { status: "unhealthy", error: error.message },
      { status: 503 }
    );
  }
}
```

---

## Domain & SSL Checklist

### Domain Configuration

```markdown
□ Custom domain added in Vercel
□ DNS records configured correctly
□ www redirect configured
□ SSL certificate valid
□ HSTS enabled
□ Old domain redirects working
```

### Vercel Domain Setup

1. Go to Project Settings → Domains
2. Add your domain
3. Configure DNS at registrar
4. Wait for propagation
5. Verify SSL working

---

## Documentation Checklist

### For Users

```markdown
□ User guide/documentation
□ FAQ page
□ Contact/support information
□ Terms of service
□ Privacy policy
□ Cookie policy (if applicable)
```

### For Developers

```markdown
□ README updated
□ API documentation
□ Environment setup guide
□ Deployment process documented
□ Rollback procedure documented
□ Runbooks for common issues
```

---

## Team Preparation

### Communication

```markdown
□ Launch announcement ready
□ Stakeholders informed
□ Support team briefed
□ Escalation path defined
□ On-call schedule set
```

### Rollback Plan

```markdown
□ Previous deployment identified
□ Rollback procedure documented
□ Team knows how to rollback
□ Rollback tested in staging
```

---

## Launch Day Checklist

### Before Launch

```markdown
□ Final code review complete
□ All automated tests passing
□ Preview deployment thoroughly tested
□ Database backed up
□ Team on standby
```

### Launch

```markdown
□ Deploy to production
□ Verify deployment succeeded
□ Check health endpoint
□ Test critical paths manually
□ Monitor error rates
□ Monitor performance
```

### After Launch

```markdown
□ Announce launch
□ Monitor for first hour closely
□ Check user feedback channels
□ Be ready to rollback
□ Document any issues
```

---

## Maria's Final Checklist

Maria goes through her production checklist:

```markdown
# Barangay Dashboard Production Checklist

## Performance ✓

- [x] Lighthouse score: 95
- [x] LCP: 1.8s ✓
- [x] INP: 150ms ✓
- [x] CLS: 0.05 ✓
- [x] Images optimized with next/image

## Security ✓

- [x] All security headers configured
- [x] Admin routes protected by IP
- [x] Rate limiting on login
- [x] Bot protection enabled
- [x] All secrets in env variables

## SEO ✓

- [x] Meta tags on all pages
- [x] sitemap.xml generated
- [x] robots.txt configured
- [x] Open Graph images ready

## Monitoring ✓

- [x] Vercel Analytics enabled
- [x] Speed Insights configured
- [x] Sentry integrated
- [x] Uptime monitoring active
- [x] Slack alerts configured

## Domain ✓

- [x] barangay-dashboard.ph configured
- [x] SSL verified
- [x] www redirect working

## Ready for Launch! 🚀
```

---

## Post-Launch Routine

### Daily Checks

```markdown
□ Review error logs
□ Check performance metrics
□ Review user feedback
□ Check security alerts
```

### Weekly Reviews

```markdown
□ Analyze traffic patterns
□ Review performance trends
□ Check for dependency updates
□ Review security advisories
```

### Monthly Tasks

```markdown
□ Comprehensive security audit
□ Performance optimization review
□ Cost optimization review
□ Documentation updates
```

---

## Key Takeaways

✓ Use a comprehensive checklist before every production launch
✓ Performance, security, and accessibility are non-negotiable
✓ Monitoring should be set up BEFORE launch
✓ Have a rollback plan ready
✓ Document everything
✓ Stay vigilant after launch

**Congratulations!** You've completed the Vercel Deployment course. You now have the skills to deploy, manage, and maintain production applications on Vercel.

🎉 **Course Complete!**
