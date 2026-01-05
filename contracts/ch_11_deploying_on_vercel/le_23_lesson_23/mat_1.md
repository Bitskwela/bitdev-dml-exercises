# Le 23: Speed Insights – Measuring Real-World Performance

![Speed Insights](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/speed-insights.png)

## Background Story

Maria's barangay dashboard is deployed and working, but residents complain it feels slow on mobile.

"How do I know if it's actually slow?" Maria asks.

"With Speed Insights," Marco replies. "It measures real user performance—not lab tests, but actual loading times from real devices."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What is Speed Insights
- Core Web Vitals explained
- Enabling Speed Insights
- Reading the dashboard
- Optimizing based on metrics
- Real User Monitoring (RUM)

---

## What Is Speed Insights?

Speed Insights is Vercel's Real User Monitoring (RUM) tool:

```
Lab Testing (Lighthouse):
- Simulated conditions
- Controlled environment
- Same every time

Real User Monitoring (Speed Insights):
- Actual user devices
- Real network conditions
- Varies by user location
```

---

## Core Web Vitals

Google's essential performance metrics:

### LCP - Largest Contentful Paint

**What:** Time until the largest visible element loads

**Good:** < 2.5 seconds
**Needs Improvement:** 2.5 - 4.0 seconds
**Poor:** > 4.0 seconds

```
Timeline:
[----Loading----][---LCP---]
0s               2.5s
```

### FID - First Input Delay

**What:** Time from first interaction to browser response

**Good:** < 100ms
**Needs Improvement:** 100 - 300ms
**Poor:** > 300ms

### INP - Interaction to Next Paint

**What:** Time for the page to respond to any interaction

**Good:** < 200ms
**Needs Improvement:** 200 - 500ms
**Poor:** > 500ms

### CLS - Cumulative Layout Shift

**What:** How much the page layout shifts unexpectedly

**Good:** < 0.1
**Needs Improvement:** 0.1 - 0.25
**Poor:** > 0.25

---

## Enabling Speed Insights

### For Next.js

**Step 1:** Install the package:

```bash
npm install @vercel/speed-insights
```

**Step 2:** Add to your app:

```tsx
// app/layout.tsx
import { SpeedInsights } from "@vercel/speed-insights/next";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html>
      <body>
        {children}
        <SpeedInsights />
      </body>
    </html>
  );
}
```

### For Other Frameworks

```tsx
// React
import { SpeedInsights } from "@vercel/speed-insights/react";

// Vanilla JS
import { injectSpeedInsights } from "@vercel/speed-insights";
injectSpeedInsights();
```

---

## Speed Insights Dashboard

### Accessing the Dashboard

1. Vercel Dashboard → Project
2. Click "Speed Insights" tab
3. View real-time metrics

### Dashboard Sections

| Section    | Shows                 |
| ---------- | --------------------- |
| Overview   | Score summary (0-100) |
| Web Vitals | LCP, FID, INP, CLS    |
| Pages      | Per-page performance  |
| Geography  | Performance by region |
| Devices    | Desktop vs Mobile     |

---

## Understanding the Metrics

### Score Breakdown

```
Speed Insights Score: 85/100

LCP:  2.1s   ✅ Good
FID:  50ms   ✅ Good
INP:  180ms  ✅ Good
CLS:  0.15   ⚠️ Needs Improvement
```

### Percentiles

Vercel shows 75th percentile (P75):

- 75% of users have this experience or better
- More realistic than averages

```
LCP Distribution:
P50: 1.8s   ← Median user
P75: 2.1s   ← Reported score
P90: 3.2s   ← Slowest 10%
P99: 5.1s   ← Worst case
```

---

## Per-Page Analysis

Speed Insights breaks down by page:

| Page       | LCP  | CLS  | INP   |
| ---------- | ---- | ---- | ----- |
| /          | 1.8s | 0.05 | 120ms |
| /dashboard | 3.2s | 0.08 | 180ms |
| /residents | 4.1s | 0.22 | 250ms |

**Insight:** The residents page needs optimization!

---

## Geographic Analysis

Performance varies by location:

| Region      | LCP  | Score |
| ----------- | ---- | ----- |
| Philippines | 2.8s | 72    |
| Singapore   | 1.2s | 95    |
| USA         | 1.5s | 90    |

**Insight:** Consider caching for PH users or using Edge Functions.

---

## Device Analysis

Mobile vs Desktop performance:

| Device  | LCP  | INP   |
| ------- | ---- | ----- |
| Desktop | 1.5s | 80ms  |
| Mobile  | 3.2s | 220ms |

**Insight:** Mobile needs optimization—focus on image optimization and JavaScript reduction.

---

## Common Optimization Strategies

### Improve LCP

1. **Optimize images:**

```tsx
import Image from "next/image";

<Image
  src="/hero.jpg"
  alt="Hero"
  width={1200}
  height={600}
  priority // Preload above-fold images
/>;
```

2. **Preload critical resources:**

```html
<link rel="preload" href="/fonts/main.woff2" as="font" crossorigin />
```

3. **Use server-side rendering:**

```tsx
// Page will SSR, LCP element available immediately
export default async function Page() {
  const data = await fetchData();
  return <LargestElement data={data} />;
}
```

### Improve CLS

1. **Set image dimensions:**

```tsx
// Always specify width/height
<Image src="/photo.jpg" width={400} height={300} />
```

2. **Reserve space for dynamic content:**

```css
.ad-container {
  min-height: 250px;
}
```

3. **Avoid inserting content above existing content:**

```tsx
// Bad: Banner inserted at top
// Good: Banner has reserved space
```

### Improve INP

1. **Reduce JavaScript:**

```tsx
// Use dynamic imports
const HeavyComponent = dynamic(() => import("./HeavyComponent"));
```

2. **Debounce handlers:**

```tsx
const handleInput = debounce((value) => {
  // Process input
}, 200);
```

3. **Use transitions API:**

```tsx
import { startTransition } from "react";

startTransition(() => {
  setExpensiveState(newValue);
});
```

---

## Setting Performance Budgets

Create alerts for performance regressions:

### In vercel.json

```json
{
  "speedInsights": {
    "budget": {
      "lcp": 2500,
      "cls": 0.1,
      "inp": 200
    }
  }
}
```

### Dashboard Alerts

1. Speed Insights → Settings
2. Set thresholds for each metric
3. Configure notification channels

---

## Comparing Deployments

Track performance across deployments:

```
Deployment: abc123
  LCP: 2.1s (↓ 0.3s from previous)
  CLS: 0.08 (↑ 0.02 from previous)

Deployment: def456
  LCP: 2.4s (baseline)
  CLS: 0.06 (baseline)
```

Identify which changes affected performance.

---

## Integration with Analytics

### Combine with Vercel Analytics

```tsx
// app/layout.tsx
import { SpeedInsights } from "@vercel/speed-insights/next";
import { Analytics } from "@vercel/analytics/react";

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <SpeedInsights />
        <Analytics />
      </body>
    </html>
  );
}
```

### Custom Events

```tsx
import { track } from "@vercel/speed-insights";

track("button-clicked", {
  location: "header",
  variant: "primary",
});
```

---

## Maria's Performance Optimization

Maria analyzes her dashboard:

**Before optimization:**

```
LCP: 4.2s   ❌ Poor
CLS: 0.18   ⚠️ Needs Improvement
INP: 320ms  ⚠️ Needs Improvement
```

**Actions taken:**

1. Added `priority` to hero image
2. Set explicit dimensions on all images
3. Used dynamic imports for charts

**After optimization:**

```
LCP: 2.1s   ✅ Good
CLS: 0.04   ✅ Good
INP: 150ms  ✅ Good
```

---

## Key Takeaways

✓ Speed Insights measures real user performance
✓ Core Web Vitals: LCP, FID, INP, CLS
✓ P75 (75th percentile) is the reported score
✓ Analyze by page, geography, and device
✓ Set performance budgets for regressions
✓ Optimize based on specific metrics

**Next Lesson:** Analytics Dashboard—understanding user behavior and traffic!
