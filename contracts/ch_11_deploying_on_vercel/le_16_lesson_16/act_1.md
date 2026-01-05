# Cron Jobs Activity

Scheduled tasks run automatically without manual intervention. In this activity, you'll create and configure cron jobs on Vercel.

## Task for Students

### Part 1: Cron Expression Quiz

**Question 1:** What does `0 8 * * *` mean?

- A) Every 8 minutes
- B) Every day at 8:00 AM
- C) Every 8 hours
- D) On the 8th of every month

**Question 2:** What does `*/15 * * * *` mean?

- A) At 15 minutes past every hour
- B) Every 15 minutes
- C) Every 15 hours
- D) On the 15th of every month

**Question 3:** What does `0 0 * * 0` mean?

- A) Every day at midnight
- B) Every Sunday at midnight
- C) Every month on day 0
- D) Never runs

**Question 4:** Cron schedules on Vercel run in which timezone?

- A) Your local timezone
- B) UTC
- C) PST
- D) Vercel auto-detects

**Question 5:** How many cron jobs can a Hobby plan have?

- A) 1
- B) 2
- C) 10
- D) Unlimited

---

### Part 2: Cron Expression Practice

Write the cron expression for each schedule:

1. Every day at 6:00 AM UTC

   - Expression: ******\_\_\_******

2. Every Monday at 9:00 AM UTC

   - Expression: ******\_\_\_******

3. First day of every month at midnight

   - Expression: ******\_\_\_******

4. Every 30 minutes

   - Expression: ******\_\_\_******

5. Every weekday (Mon-Fri) at 5:00 PM UTC
   - Expression: ******\_\_\_******

---

### Part 3: Create a Cron Endpoint

**Step 1:** Create the API route:

```typescript
// app/api/cron/test/route.ts
export async function GET(request: Request) {
  // Security check
  const authHeader = request.headers.get("authorization");
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return new Response("Unauthorized", { status: 401 });
  }

  // Log the execution
  const now = new Date().toISOString();
  console.log(`Cron job executed at: ${now}`);

  // Simulate some work
  const result = {
    success: true,
    message: "Cron job completed successfully",
    executedAt: now,
    environment: process.env.NODE_ENV,
  };

  return Response.json(result);
}
```

**Step 2:** Add environment variable:

In `.env.local`:

```
CRON_SECRET=my-super-secret-cron-key
```

**Step 3:** Test locally:

```bash
curl http://localhost:3000/api/cron/test \
  -H "Authorization: Bearer my-super-secret-cron-key"
```

---

### Part 4: Configure vercel.json

**Step 1:** Create `vercel.json`:

```json
{
  "crons": [
    {
      "path": "/api/cron/test",
      "schedule": "0 0 * * *"
    }
  ]
}
```

**Step 2:** Add CRON_SECRET to Vercel:

1. Go to Project Settings → Environment Variables
2. Add `CRON_SECRET` with a secure random value

**Step 3:** Deploy:

```bash
vercel
```

**Step 4:** Verify in dashboard:

1. Go to Project Settings → Cron Jobs
2. You should see your cron listed
3. Click "Trigger" to test

---

### Part 5: Build a Practical Cron Job

**Task:** Create a cron job that generates a daily stats report.

```typescript
// app/api/cron/daily-stats/route.ts
interface DailyStats {
  date: string;
  pageViews: number;
  uniqueVisitors: number;
  topPages: string[];
}

export async function GET(request: Request) {
  // Security
  const authHeader = request.headers.get("authorization");
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return new Response("Unauthorized", { status: 401 });
  }

  try {
    // Simulate fetching stats (replace with real data)
    const stats: DailyStats = {
      date: new Date().toISOString().split("T")[0],
      pageViews: Math.floor(Math.random() * 1000) + 100,
      uniqueVisitors: Math.floor(Math.random() * 500) + 50,
      topPages: ["/home", "/about", "/dashboard"],
    };

    // Simulate saving to database or sending email
    console.log("Daily Stats:", JSON.stringify(stats, null, 2));

    // In real app: await saveToDatabase(stats);
    // In real app: await sendEmailReport(stats);

    return Response.json({
      success: true,
      stats,
    });
  } catch (error) {
    console.error("Daily stats cron failed:", error);
    return Response.json(
      { success: false, error: "Failed to generate stats" },
      { status: 500 }
    );
  }
}
```

Update `vercel.json`:

```json
{
  "crons": [
    {
      "path": "/api/cron/daily-stats",
      "schedule": "0 0 * * *"
    }
  ]
}
```

---

### Part 6: Timezone Conversion

**Task:** Schedule a cron for 8:00 AM Manila time.

Manila (PHT) = UTC + 8 hours

**Question:** If you want to run at 8:00 AM Manila time, what UTC time is that?

- 8:00 AM - 8 hours = 12:00 AM (midnight) UTC

**Cron expression for 8 AM Manila:**

```
0 0 * * *
```

**Now calculate for these scenarios:**

1. 6:00 PM Manila time = **\_** UTC

   - Cron expression: ******\_\_\_******

2. 9:00 AM Tokyo (UTC+9) = **\_** UTC

   - Cron expression: ******\_\_\_******

3. 3:00 PM London (UTC+0 in winter) = **\_** UTC
   - Cron expression: ******\_\_\_******

---

### Part 7: Error Handling

**Task:** Add robust error handling to your cron job.

```typescript
// app/api/cron/robust/route.ts
export async function GET(request: Request) {
  const startTime = Date.now();

  // Security
  if (
    request.headers.get("authorization") !== `Bearer ${process.env.CRON_SECRET}`
  ) {
    return new Response("Unauthorized", { status: 401 });
  }

  try {
    // Simulate task that might fail
    const success = Math.random() > 0.3; // 70% success rate

    if (!success) {
      throw new Error("Random failure for demo");
    }

    const duration = Date.now() - startTime;

    return Response.json({
      success: true,
      duration: `${duration}ms`,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    const duration = Date.now() - startTime;

    // Log error with context
    console.error("Cron job failed:", {
      error: String(error),
      duration: `${duration}ms`,
      timestamp: new Date().toISOString(),
    });

    // In production: send alert to Slack/email
    // await sendAlert('Cron job failed!');

    return Response.json(
      {
        success: false,
        error: "Task failed",
        duration: `${duration}ms`,
      },
      { status: 500 }
    );
  }
}
```

---

### Part 8: Multiple Cron Jobs

**Task:** Set up multiple cron jobs for different purposes.

```json
{
  "crons": [
    {
      "path": "/api/cron/hourly-sync",
      "schedule": "0 * * * *"
    },
    {
      "path": "/api/cron/daily-report",
      "schedule": "0 0 * * *"
    }
  ]
}
```

**Note for Hobby plan:** You're limited to 2 cron jobs with daily minimum frequency.

---

### What You Learned

✓ Cron expressions: minute hour day-of-month month day-of-week
✓ Define crons in vercel.json
✓ Always secure endpoints with CRON_SECRET
✓ Schedules run in UTC—convert from local time
✓ Hobby plan: 2 crons max, daily frequency minimum
✓ Add error handling and logging for observability

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-B, 4-B, 5-B

Part 2:

1. `0 6 * * *`
2. `0 9 * * 1`
3. `0 0 1 * *`
4. `*/30 * * * *`
5. `0 17 * * 1-5`

Part 6:

1. 6:00 PM Manila = 10:00 AM UTC → `0 10 * * *`
2. 9:00 AM Tokyo = 12:00 AM UTC → `0 0 * * *`
3. 3:00 PM London = 3:00 PM UTC → `0 15 * * *`
