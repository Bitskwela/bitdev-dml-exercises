# Analytics Dashboard Activity

Understanding user behavior helps you make data-driven decisions. In this activity, you'll enable analytics and interpret the data.

## Task for Students

### Part 1: Analytics Concepts Quiz

**Question 1:** What makes Vercel Analytics privacy-focused?

- A) It uses cookies
- B) It doesn't collect any data
- C) It's cookie-free and doesn't store personal data
- D) It requires consent

**Question 2:** What is a "referrer" in analytics?

- A) A person who recommends the site
- B) The source that sent traffic to your site
- C) A returning visitor
- D) A page on your site

**Question 3:** How does Vercel count unique visitors without cookies?

- A) IP address tracking
- B) Browser cookies
- C) Anonymized fingerprinting
- D) User accounts

**Question 4:** Which metric tells you how engaged visitors are?

- A) Unique visitors
- B) Pages per visit
- C) Country distribution
- D) Browser type

**Question 5:** What do you need to do for GDPR compliance with Vercel Analytics?

- A) Add a consent banner
- B) Store user consent
- C) Nothing—it's compliant by default
- D) Get EU certification

---

### Part 2: Enable Vercel Analytics

**Step 1:** Install the package:

```bash
npm install @vercel/analytics
```

**Step 2:** Add to your Next.js layout:

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

**Step 3:** Deploy and generate some traffic:

```bash
vercel
```

**Step 4:** Visit the Analytics tab in Vercel Dashboard

---

### Part 3: Interpret Dashboard Data

**Scenario:** You see this data in your analytics:

```
This Week:
- Unique Visitors: 5,234
- Page Views: 15,702
- Pages per Visit: 3.0

Top Pages:
1. / (5,234 views)
2. /dashboard (4,567 views)
3. /residents (3,456 views)
4. /services (1,890 views)
5. /contact (555 views)
```

**Questions:**

1. What is the average pages per visit? \_\_\_

2. Which page might need a CTA to improve? \_\_\_

3. Is the engagement (pages/visit) good? \_\_\_

---

### Part 4: Traffic Source Analysis

**Data:**

| Source   | Visitors | Conversion |
| -------- | -------- | ---------- |
| Google   | 2,345    | 12%        |
| Direct   | 1,890    | 18%        |
| Facebook | 678      | 5%         |
| gov.ph   | 321      | 25%        |

**Questions:**

1. Which source brings the most visitors? \_\_\_

2. Which source has the best conversion rate? \_\_\_

3. Which source might you want to invest more in? \_\_\_

4. Why might direct traffic have high conversion? \_\_\_

---

### Part 5: Geographic Insights

**Data:**

| Country     | Visitors | Avg Session |
| ----------- | -------- | ----------- |
| Philippines | 4,123    | 4.5 min     |
| USA         | 567      | 2.1 min     |
| UAE         | 345      | 3.8 min     |
| Singapore   | 199      | 1.5 min     |

**Questions:**

1. Who is your primary audience? \_\_\_

2. Why might UAE users have longer sessions? \_\_\_

3. What optimization should you prioritize? \_\_\_

---

### Part 6: Device Analysis

**Data:**

| Device  | Visitors | Bounce Rate |
| ------- | -------- | ----------- |
| Mobile  | 3,678    | 45%         |
| Desktop | 1,345    | 25%         |
| Tablet  | 211      | 35%         |

**Questions:**

1. Which device has the highest bounce rate? \_\_\_

2. What might cause high mobile bounce rate? \_\_\_

3. What percentage of users are mobile? \_\_\_

---

### Part 7: Add Custom Events

**Task:** Track these user actions:

1. Button clicks:

```tsx
import { track } from "@vercel/analytics";

function ApplyButton() {
  return (
    <button
      onClick={() =>
        track("apply-clicked", {
          service: "permit",
          location: "services-page",
        })
      }
    >
      Apply Now
    </button>
  );
}
```

2. Form submissions:

```tsx
function ContactForm() {
  const handleSubmit = (e) => {
    e.preventDefault();

    track("form-submitted", {
      formType: "contact",
      fieldsCompleted: 5,
    });

    // Submit form...
  };

  return <form onSubmit={handleSubmit}>...</form>;
}
```

3. Downloads:

```tsx
function DownloadLink() {
  return (
    <a
      href="/forms/permit.pdf"
      onClick={() =>
        track("document-downloaded", {
          documentType: "permit-form",
          format: "pdf",
        })
      }
    >
      Download Form
    </a>
  );
}
```

---

### Part 8: Analyze Custom Events

**Scenario:** Your custom events show:

| Event          | Count | Conversion     |
| -------------- | ----- | -------------- |
| apply-clicked  | 890   | -              |
| form-started   | 567   | 64% of clicks  |
| form-submitted | 234   | 41% of started |

**Questions:**

1. What's the funnel drop-off at each step?

   - Click to form start: \_\_\_% drop
   - Form start to submit: \_\_\_% drop

2. Where should you focus optimization? \_\_\_

3. What might improve form-started → form-submitted? \_\_\_

---

### Part 9: Create an Analytics Report

**Task:** Create a weekly report template:

```markdown
# Weekly Analytics Report

Date: ******\_\_\_******

## Traffic Overview

- Total Visitors: \_\_\_
- Change vs Last Week: \_\_\_%
- Page Views: \_\_\_
- Pages/Visit: \_\_\_

## Top Pages

1. **_ (_**%)
2. **_ (_**%)
3. **_ (_**%)

## Traffic Sources

- Organic: \_\_\_%
- Direct: \_\_\_%
- Social: \_\_\_%
- Referral: \_\_\_%

## Device Split

- Mobile: \_\_\_%
- Desktop: \_\_\_%

## Key Insights

1. ***
2. ***
3. ***

## Actions for Next Week

1. ***
2. ***
```

---

### Part 10: Combine Analytics + Speed Insights

**Task:** Add both to your layout:

```tsx
// app/layout.tsx
import { Analytics } from "@vercel/analytics/react";
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
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}
```

**Combined analysis questions:**

Given this data:
| Page | Visitors | LCP |
|------|----------|-----|
| /dashboard | 4,567 | 3.8s |
| /about | 555 | 1.2s |

1. Which page should you optimize first? \_\_\_

2. Why? \_\_\_

---

### What You Learned

✓ Enabling Vercel Analytics
✓ Interpreting visitor and page view metrics
✓ Analyzing traffic sources and geography
✓ Understanding device distribution
✓ Tracking custom events
✓ Combining Analytics with Speed Insights

---

**Instructor Answers:**

Part 1: 1-C, 2-B, 3-C, 4-B, 5-C

Part 3:

1. 3.0 pages per visit
2. /contact (low views, might need better CTAs)
3. Yes, 3.0 pages/visit indicates good engagement

Part 4:

1. Google (2,345)
2. gov.ph (25%)
3. gov.ph (highest conversion) or Google (most volume)
4. Returning users who already know the service

Part 5:

1. Philippines (4,123 visitors)
2. OFWs who need to complete tasks remotely
3. Mobile optimization and PH network performance

Part 6:

1. Mobile (45%)
2. Slow load times, poor mobile UX, non-responsive design
3. 70% (3,678 / 5,234)

Part 8:

1. Click to form start: 36% drop; Form start to submit: 59% drop
2. Form completion (biggest drop)
3. Simplify form, add progress indicator, reduce required fields

Part 10:

1. /dashboard
2. High traffic (4,567) + poor performance (3.8s LCP) = biggest impact
