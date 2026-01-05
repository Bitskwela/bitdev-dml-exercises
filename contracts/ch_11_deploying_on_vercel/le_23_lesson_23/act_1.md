# Speed Insights Activity

Measuring real-world performance helps you optimize for actual users. In this activity, you'll enable Speed Insights and analyze metrics.

## Task for Students

### Part 1: Core Web Vitals Quiz

**Question 1:** What does LCP measure?

- A) How fast JavaScript loads
- B) Time until the largest visible element loads
- C) Total page size
- D) Number of HTTP requests

**Question 2:** What is a good LCP score?

- A) Less than 1 second
- B) Less than 2.5 seconds
- C) Less than 5 seconds
- D) Less than 10 seconds

**Question 3:** What does CLS measure?

- A) Page load time
- B) JavaScript execution time
- C) Unexpected layout shifts
- D) Image load time

**Question 4:** What percentile does Vercel Speed Insights report?

- A) P50 (median)
- B) P75 (75th percentile)
- C) P90 (90th percentile)
- D) P99 (99th percentile)

**Question 5:** What causes high CLS?

- A) Slow server response
- B) Images without dimensions
- C) Too many API calls
- D) Large JavaScript bundles

---

### Part 2: Enable Speed Insights

**Step 1:** Install the package:

```bash
npm install @vercel/speed-insights
```

**Step 2:** Add to your Next.js app:

```tsx
// app/layout.tsx
import { SpeedInsights } from "@vercel/speed-insights/next";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        {children}
        <SpeedInsights />
      </body>
    </html>
  );
}
```

**Step 3:** Deploy to Vercel:

```bash
vercel
```

**Step 4:** Generate traffic by visiting your site multiple times

**Step 5:** Check Speed Insights tab in Vercel Dashboard (data appears after a few minutes)

---

### Part 3: Read the Dashboard

**Scenario:** You see these metrics in Speed Insights:

```
Score: 68/100

LCP:  3.2s   ⚠️ Needs Improvement
FID:  45ms   ✅ Good
INP:  280ms  ⚠️ Needs Improvement
CLS:  0.22   ⚠️ Needs Improvement
```

**Questions:**

1. Which metric is the biggest problem? ******\_\_\_******

2. What might cause the LCP issue? ******\_\_\_******

3. What might cause the CLS issue? ******\_\_\_******

4. Is FID acceptable? ******\_\_\_******

---

### Part 4: Analyze Per-Page Performance

**Given this data:**

| Page       | LCP  | CLS  | INP   | Views |
| ---------- | ---- | ---- | ----- | ----- |
| /          | 1.8s | 0.02 | 100ms | 5,000 |
| /about     | 2.0s | 0.05 | 120ms | 1,200 |
| /dashboard | 4.5s | 0.18 | 350ms | 3,800 |
| /residents | 5.2s | 0.25 | 400ms | 2,500 |

**Questions:**

1. Which page needs the most attention? ******\_\_\_******

2. Why does /dashboard matter more than /about? ******\_\_\_******

3. What's the likely cause of /residents poor LCP? ******\_\_\_******

---

### Part 5: Optimize LCP

**Task:** Improve LCP for a page with a large hero image.

**Before:**

```tsx
// page.tsx
export default function Home() {
  return (
    <div>
      <img src="/hero.jpg" alt="Hero" />
      <h1>Welcome to Barangay Dashboard</h1>
    </div>
  );
}
```

**After (optimized):**

```tsx
// page.tsx
import Image from "next/image";

export default function Home() {
  return (
    <div>
      <Image
        src="/hero.jpg"
        alt="Hero"
        width={1200}
        height={600}
        priority // Preload for LCP
        placeholder="blur"
        blurDataURL="data:image/jpeg;base64,..."
      />
      <h1>Welcome to Barangay Dashboard</h1>
    </div>
  );
}
```

**What optimizations were made?**

1. ***
2. ***
3. ***

---

### Part 6: Optimize CLS

**Problem:** This layout causes CLS:

```tsx
export default function Page() {
  const [loaded, setLoaded] = useState(false);

  return (
    <div>
      <Header />
      {loaded && <Banner />} {/* Causes layout shift! */}
      <MainContent />
    </div>
  );
}
```

**Task:** Fix the CLS issue:

```tsx
export default function Page() {
  const [loaded, setLoaded] = useState(false);

  return (
    <div>
      <Header />
      {/* TODO: Reserve space for banner */}
      <MainContent />
    </div>
  );
}
```

**Solution approach:** ******\_\_\_******

---

### Part 7: Optimize INP

**Problem:** This handler causes high INP:

```tsx
function handleClick() {
  // Expensive computation
  const result = heavyCalculation(data); // Takes 500ms
  setResult(result);
}
```

**Task:** Improve INP using React transitions:

```tsx
import { useState, useTransition } from "react";

function Component() {
  const [result, setResult] = useState(null);
  const [isPending, startTransition] = useTransition();

  function handleClick() {
    startTransition(() => {
      const result = heavyCalculation(data);
      setResult(result);
    });
  }

  return (
    <button onClick={handleClick}>
      {isPending ? "Calculating..." : "Calculate"}
    </button>
  );
}
```

**Why does this help?** ******\_\_\_******

---

### Part 8: Geographic Performance Analysis

**Given this data:**

| Region    | LCP  | Score |
| --------- | ---- | ----- |
| Manila    | 3.5s | 65    |
| Cebu      | 3.8s | 60    |
| Singapore | 1.2s | 95    |
| US West   | 1.5s | 90    |

**Questions:**

1. Where is your server likely located? ******\_\_\_******

2. How can you improve Philippine performance? ******\_\_\_******

3. What Vercel feature would help? ******\_\_\_******

---

### Part 9: Device Performance Comparison

**Data:**

| Device  | LCP  | INP   | % of Users |
| ------- | ---- | ----- | ---------- |
| Desktop | 1.5s | 80ms  | 30%        |
| Mobile  | 3.8s | 280ms | 70%        |

**Questions:**

1. Which device type should you prioritize? ******\_\_\_******

2. What causes the LCP difference? ******\_\_\_******

3. What causes the INP difference? ******\_\_\_******

---

### Part 10: Performance Budget Check

**Your budget:**

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

**Current metrics:**

```
LCP: 2.8s   (budget: 2.5s)
CLS: 0.08   (budget: 0.1)
INP: 180ms  (budget: 200ms)
```

**Questions:**

1. Which metric exceeds the budget? ******\_\_\_******

2. Is this deployment acceptable? ******\_\_\_******

3. What action should you take? ******\_\_\_******

---

### What You Learned

✓ Core Web Vitals: LCP, FID, INP, CLS
✓ Enabling Speed Insights in Next.js
✓ Reading and interpreting the dashboard
✓ Optimizing LCP with Next.js Image
✓ Fixing CLS with reserved space
✓ Improving INP with React transitions

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-C, 4-B, 5-B

Part 3:

1. LCP (3.2s is the furthest from "good")
2. Large images, slow server response, render-blocking resources
3. Images without dimensions, dynamic content insertion
4. Yes, 45ms is well under 100ms threshold

Part 4:

1. /residents (worst metrics)
2. Higher traffic (3,800 vs 1,200 views)
3. Probably loading many images or large data table

Part 5:

1. Used Next.js Image component
2. Added priority for preloading
3. Added placeholder for perceived speed

Part 6:
Reserve space with CSS: `<div style={{ minHeight: '100px' }}>{loaded && <Banner />}</div>`

Part 7:
startTransition marks the update as non-urgent, allowing the browser to respond to interactions first before processing the heavy calculation.

Part 8:

1. Singapore or US (lowest LCP)
2. Use Edge Functions or caching
3. Edge Functions or Edge Caching

Part 9:

1. Mobile (70% of users)
2. Slower networks, smaller cache, less powerful CPUs
3. Less powerful processors, touch delay

Part 10:

1. LCP (2.8s > 2.5s budget)
2. No, LCP exceeds budget
3. Investigate LCP causes, optimize before releasing
