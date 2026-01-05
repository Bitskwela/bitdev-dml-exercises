# Le 24: Analytics Dashboard – Understanding User Behavior and Traffic

![Analytics Dashboard](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/analytics-dashboard.png)

## Background Story

Maria's dashboard is optimized for performance. Now she wants to understand how residents are using it.

"Which pages are most popular? Where do visitors come from?" Maria wonders.

"Vercel Analytics gives you all that," Marco explains. "Privacy-focused, real-time visitor insights."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Vercel Analytics overview
- Enabling analytics
- Understanding metrics
- Traffic analysis
- Geographic insights
- Custom events
- Privacy and compliance

---

## What Is Vercel Analytics?

Vercel Analytics is a privacy-focused analytics tool:

| Feature               | Vercel Analytics | Traditional Analytics |
| --------------------- | ---------------- | --------------------- |
| Cookie-free           | ✅               | ❌                    |
| GDPR compliant        | ✅               | Varies                |
| Real-time data        | ✅               | Often delayed         |
| Impact on performance | Minimal          | Can be heavy          |
| Unique visitors       | ✅ (anonymous)   | ✅ (with cookies)     |

---

## Enabling Vercel Analytics

### For Next.js

**Step 1:** Install the package:

```bash
npm install @vercel/analytics
```

**Step 2:** Add to your app:

```tsx
// app/layout.tsx
import { Analytics } from "@vercel/analytics/react";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        {children}
        <Analytics />
      </body>
    </html>
  );
}
```

### For Other Frameworks

```tsx
// React (non-Next.js)
import { Analytics } from "@vercel/analytics/react";

function App() {
  return (
    <>
      <YourApp />
      <Analytics />
    </>
  );
}

// Vanilla JavaScript
import { inject } from "@vercel/analytics";
inject();
```

---

## Analytics Dashboard Overview

### Accessing Analytics

1. Vercel Dashboard → Your Project
2. Click "Analytics" tab
3. View real-time data

### Key Metrics

| Metric         | Description                 |
| -------------- | --------------------------- |
| **Visitors**   | Unique visitors (anonymous) |
| **Page Views** | Total page loads            |
| **Top Pages**  | Most visited pages          |
| **Referrers**  | Where traffic comes from    |
| **Countries**  | Geographic distribution     |
| **Devices**    | Desktop vs Mobile           |
| **Browsers**   | Chrome, Safari, etc.        |

---

## Understanding Visitor Metrics

### Unique Visitors

Vercel counts unique visitors without cookies:

- Uses anonymized fingerprinting
- Privacy-preserving
- Resets daily

```
Today:
- Unique Visitors: 1,234
- Page Views: 3,456
- Pages per Visit: 2.8
```

### Time-Based Analysis

| Period     | Visitors | Trend |
| ---------- | -------- | ----- |
| Today      | 1,234    | ↑ 15% |
| This Week  | 8,567    | ↑ 8%  |
| This Month | 35,890   | ↑ 22% |

---

## Page Views Analysis

### Top Pages

| Page       | Views  | % of Total |
| ---------- | ------ | ---------- |
| /          | 12,456 | 35%        |
| /dashboard | 8,234  | 23%        |
| /residents | 5,678  | 16%        |
| /about     | 2,345  | 7%         |
| /contact   | 1,890  | 5%         |

### Insights

- Homepage gets most traffic (expected)
- Dashboard is second—residents are engaged
- About page has low traffic—expected behavior

---

## Traffic Sources (Referrers)

### Where Visitors Come From

| Source   | Visitors | %   |
| -------- | -------- | --- |
| Direct   | 5,678    | 45% |
| Google   | 3,456    | 27% |
| Facebook | 1,234    | 10% |
| gov.ph   | 890      | 7%  |
| Other    | 1,234    | 10% |

### Understanding Sources

- **Direct:** Typed URL or bookmarked
- **Search engines:** Organic search traffic
- **Social:** Facebook, Twitter, etc.
- **Referral:** Links from other sites

---

## Geographic Analysis

### Visitors by Country

| Country        | Visitors | %   |
| -------------- | -------- | --- |
| Philippines 🇵🇭 | 28,456   | 79% |
| USA 🇺🇸         | 2,345    | 7%  |
| UAE 🇦🇪         | 1,890    | 5%  |
| Singapore 🇸🇬   | 1,234    | 3%  |
| Other          | 2,065    | 6%  |

### Insights

- Most users from Philippines (expected for barangay site)
- UAE traffic likely OFWs
- Consider optimizing for PH network conditions

---

## Device and Browser Analysis

### Device Breakdown

| Device  | Visitors | %   |
| ------- | -------- | --- |
| Mobile  | 25,678   | 72% |
| Desktop | 8,901    | 25% |
| Tablet  | 1,234    | 3%  |

### Browser Breakdown

| Browser          | Visitors | %   |
| ---------------- | -------- | --- |
| Chrome           | 21,456   | 60% |
| Safari           | 7,890    | 22% |
| Samsung Internet | 3,456    | 10% |
| Firefox          | 1,234    | 3%  |
| Other            | 1,754    | 5%  |

### Insights

- Mobile-first design is critical (72%)
- Chrome dominates—safe to use modern features
- Test on Samsung Internet for mobile users

---

## Custom Events

Track specific user actions:

### Tracking Events

```tsx
import { track } from "@vercel/analytics";

function Button() {
  return (
    <button onClick={() => track("cta-clicked", { location: "header" })}>
      Sign Up
    </button>
  );
}
```

### Event Parameters

```tsx
track("form-submitted", {
  formType: "registration",
  source: "homepage",
  duration: 45, // seconds to complete
});

track("document-downloaded", {
  documentType: "permit",
  fileSize: "2.5MB",
});
```

### Viewing Custom Events

1. Analytics → Events tab
2. Filter by event name
3. View event parameters

---

## Real-Time Analytics

See live visitor activity:

### Live View

```
Active Now: 23 visitors

Recent Page Views:
- /dashboard (2 seconds ago)
- / (5 seconds ago)
- /residents/123 (8 seconds ago)
- /about (12 seconds ago)
```

### Use Cases

- Monitor launch day traffic
- Watch campaign performance
- Debug issues in real-time

---

## Comparing Time Periods

### Week over Week

```
This Week: 8,567 visitors
Last Week: 7,890 visitors
Change: +8.6%
```

### Month over Month

```
This Month: 35,890 visitors
Last Month: 29,456 visitors
Change: +21.8%
```

---

## Filtering and Segmentation

### Filter Options

- **Date range:** Today, 7 days, 30 days, custom
- **Device:** Mobile, Desktop, Tablet
- **Country:** Specific countries
- **Browser:** Chrome, Safari, etc.
- **Page:** Specific pages

### Example: Mobile Users from Philippines

```
Filters:
- Device: Mobile
- Country: Philippines

Results:
- Visitors: 20,456
- Top Pages: /, /dashboard, /residents
- Avg Session: 3.2 minutes
```

---

## Privacy and Compliance

### Cookie-Free Tracking

- No cookies stored
- No personal data collected
- GDPR/CCPA compliant by default
- No consent banner needed

### Data Collection

What IS collected:

- Page URL
- Referrer
- Country (from IP, IP not stored)
- Device type
- Browser

What is NOT collected:

- Personal information
- IP addresses
- Cookies
- Fingerprints that persist

---

## Combining Analytics + Speed Insights

Use both together:

```tsx
// app/layout.tsx
import { Analytics } from "@vercel/analytics/react";
import { SpeedInsights } from "@vercel/speed-insights/next";

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}
```

### Combined Insights

- Analytics: What pages are visited
- Speed Insights: How fast those pages load
- Together: Prioritize optimizing high-traffic, slow pages

---

## Maria's Analytics Setup

Maria analyzes her dashboard usage:

**Key Findings:**

1. 72% mobile users → prioritize mobile optimization
2. /dashboard is 2nd most visited → optimize LCP
3. Most traffic from Philippines → consider local edge caching
4. High direct traffic → residents bookmark the site

**Actions:**

- Add custom events for permit applications
- Track form completion rates
- Monitor new feature adoption

---

## Key Takeaways

✓ Vercel Analytics is privacy-focused and cookie-free
✓ Track visitors, page views, sources, and geography
✓ Analyze device and browser distribution
✓ Use custom events to track specific actions
✓ Combine with Speed Insights for full picture
✓ No consent banner required

**Next Lesson:** Logs & Observability—debugging production issues!
