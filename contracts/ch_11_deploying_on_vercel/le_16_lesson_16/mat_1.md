# Le 16: Cron Jobs – Scheduled Tasks That Run Automatically

![Cron Jobs](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/cron-jobs.png)

## Background Story

Maria's Barangay Dashboard needs to send daily email summaries to officials and weekly reports to the Kapitan.

"Do I have to manually run these every day?" Maria asks.

"Nope," Marco replies. "With Cron Jobs, you can schedule functions to run automatically—every hour, every day, or on any schedule you define."

**Time Allotment**: 45 minutes

**Topics Covered**:

- What are Cron Jobs
- Cron expression syntax
- Creating scheduled functions on Vercel
- Common scheduling patterns
- Handling time zones
- Best practices and limitations

---

## What Are Cron Jobs?

A Cron Job is a scheduled task that runs automatically at specified times:

```
Manual Execution:
You → Remember to run → Function → Result

Cron Job:
Schedule (e.g., "every day at 8 AM") → Vercel triggers → Function → Result
```

Use cases:

- Daily email reports
- Hourly data sync
- Weekly database cleanup
- Monthly billing
- Periodic health checks

---

## Cron Expression Syntax

Cron uses a five-field format:

```
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of week (0 - 6) (Sunday = 0)
│ │ │ │ │
* * * * *
```

### Common Patterns

| Expression       | Description                  |
| ---------------- | ---------------------------- |
| `* * * * *`      | Every minute                 |
| `0 * * * *`      | Every hour (at minute 0)     |
| `0 0 * * *`      | Every day at midnight        |
| `0 8 * * *`      | Every day at 8:00 AM         |
| `0 8 * * 1`      | Every Monday at 8:00 AM      |
| `0 0 1 * *`      | First day of every month     |
| `0 */6 * * *`    | Every 6 hours                |
| `0 9-17 * * 1-5` | Hourly, 9 AM - 5 PM, Mon-Fri |

### Special Characters

- `*` - Any value
- `,` - List (e.g., `1,15` = 1st and 15th)
- `-` - Range (e.g., `1-5` = Mon through Fri)
- `/` - Step (e.g., `*/15` = every 15 minutes)

---

## Creating Cron Jobs on Vercel

### Step 1: Create the API Route

```typescript
// app/api/cron/daily-report/route.ts
export async function GET(request: Request) {
  // Verify the request is from Vercel Cron
  const authHeader = request.headers.get("authorization");
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return new Response("Unauthorized", { status: 401 });
  }

  try {
    // Your scheduled task logic
    await sendDailyReport();

    return Response.json({
      success: true,
      message: "Daily report sent",
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    console.error("Cron error:", error);
    return Response.json({ error: "Failed to send report" }, { status: 500 });
  }
}

async function sendDailyReport() {
  // Fetch data, generate report, send email, etc.
  console.log("Sending daily report...");
}
```

### Step 2: Create vercel.json

```json
{
  "crons": [
    {
      "path": "/api/cron/daily-report",
      "schedule": "0 8 * * *"
    }
  ]
}
```

### Step 3: Add CRON_SECRET

In Vercel Dashboard → Settings → Environment Variables:

```
CRON_SECRET=your-secure-random-string
```

### Step 4: Deploy

```bash
vercel
```

---

## Securing Cron Endpoints

**Important:** Always secure your cron endpoints! Without security, anyone could trigger them.

### Method 1: CRON_SECRET (Recommended)

```typescript
export async function GET(request: Request) {
  const authHeader = request.headers.get("authorization");

  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return new Response("Unauthorized", { status: 401 });
  }

  // ... cron logic
}
```

Vercel automatically sends this header when triggering cron jobs.

### Method 2: Check for Vercel Cron Header

```typescript
export async function GET(request: Request) {
  // Vercel adds this header to cron requests
  const isVercelCron = request.headers.get("x-vercel-cron");

  if (!isVercelCron) {
    return new Response("Not a cron request", { status: 403 });
  }

  // ... cron logic
}
```

---

## Common Cron Patterns

### Daily Email Summary

```typescript
// app/api/cron/daily-summary/route.ts
export async function GET(request: Request) {
  // Security check...

  const users = await getActiveUsers();

  for (const user of users) {
    const summary = await generateDailySummary(user.id);
    await sendEmail({
      to: user.email,
      subject: "Your Daily Barangay Update",
      body: summary,
    });
  }

  return Response.json({
    success: true,
    usersNotified: users.length,
  });
}
```

### Weekly Database Cleanup

```json
{
  "crons": [
    {
      "path": "/api/cron/cleanup",
      "schedule": "0 3 * * 0"
    }
  ]
}
```

```typescript
// app/api/cron/cleanup/route.ts
export async function GET(request: Request) {
  // Delete records older than 30 days
  const deletedCount = await db.query(`
    DELETE FROM logs 
    WHERE created_at < NOW() - INTERVAL '30 days'
  `);

  return Response.json({
    success: true,
    deleted: deletedCount,
  });
}
```

### Hourly Data Sync

```json
{
  "crons": [
    {
      "path": "/api/cron/sync",
      "schedule": "0 * * * *"
    }
  ]
}
```

### Health Check Every 15 Minutes

```json
{
  "crons": [
    {
      "path": "/api/cron/health",
      "schedule": "*/15 * * * *"
    }
  ]
}
```

---

## Time Zones

Cron schedules run in **UTC** by default. To schedule for a specific timezone:

### Convert Local Time to UTC

Manila (PHT) is UTC+8:

- 8:00 AM Manila = 0:00 UTC
- 5:00 PM Manila = 9:00 UTC

```json
{
  "crons": [
    {
      "path": "/api/cron/morning-report",
      "schedule": "0 0 * * *"
    }
  ]
}
```

This runs at midnight UTC = 8:00 AM Manila.

### Handle Timezone in Code

```typescript
export async function GET(request: Request) {
  const now = new Date();
  const manilaTime = new Date(
    now.toLocaleString("en-US", { timeZone: "Asia/Manila" })
  );

  console.log("Running at:", manilaTime.toISOString());

  // ... rest of logic
}
```

---

## Multiple Cron Jobs

```json
{
  "crons": [
    {
      "path": "/api/cron/hourly-sync",
      "schedule": "0 * * * *"
    },
    {
      "path": "/api/cron/daily-report",
      "schedule": "0 8 * * *"
    },
    {
      "path": "/api/cron/weekly-cleanup",
      "schedule": "0 3 * * 0"
    },
    {
      "path": "/api/cron/monthly-billing",
      "schedule": "0 0 1 * *"
    }
  ]
}
```

---

## Vercel Cron Limits

| Plan       | Cron Jobs | Minimum Interval | Max Duration |
| ---------- | --------- | ---------------- | ------------ |
| Hobby      | 2         | Daily (once/day) | 10 seconds   |
| Pro        | 40        | Every minute     | 60 seconds   |
| Enterprise | Unlimited | Every minute     | 900 seconds  |

**Hobby Plan Limitation:** Only daily or less frequent crons allowed.

---

## Error Handling and Retries

Vercel does NOT automatically retry failed cron jobs. Handle errors yourself:

```typescript
export async function GET(request: Request) {
  try {
    await performTask();
    return Response.json({ success: true });
  } catch (error) {
    // Log the error
    console.error("Cron job failed:", error);

    // Optionally: Send alert
    await sendSlackNotification("Cron job failed!");

    // Return error status
    return Response.json(
      { success: false, error: "Task failed" },
      { status: 500 }
    );
  }
}
```

---

## Testing Cron Jobs

### Locally

```bash
# Test the endpoint directly
curl http://localhost:3000/api/cron/daily-report \
  -H "Authorization: Bearer your-cron-secret"
```

### On Vercel

1. Go to Dashboard → Project → Settings → Cron Jobs
2. Click "Trigger" to manually run a cron job
3. Check logs for output

---

## Monitoring Cron Jobs

### View Logs

1. Go to Vercel Dashboard → Project → Logs
2. Filter by function name
3. Check for cron executions

### Add Observability

```typescript
export async function GET(request: Request) {
  const startTime = Date.now();

  try {
    await performTask();

    const duration = Date.now() - startTime;
    console.log(`Cron completed in ${duration}ms`);

    // Optional: Log to external service
    await logToDatadog({
      event: "cron.success",
      duration,
    });

    return Response.json({ success: true, duration });
  } catch (error) {
    console.error("Cron failed:", error);

    await logToDatadog({
      event: "cron.failure",
      error: String(error),
    });

    return Response.json({ success: false }, { status: 500 });
  }
}
```

---

## Maria's Scheduled Reports

Maria sets up automated reports for the barangay:

```json
// vercel.json
{
  "crons": [
    {
      "path": "/api/cron/morning-summary",
      "schedule": "0 0 * * *"
    },
    {
      "path": "/api/cron/weekly-report",
      "schedule": "0 1 * * 1"
    }
  ]
}
```

```typescript
// app/api/cron/morning-summary/route.ts
export async function GET(request: Request) {
  if (
    request.headers.get("authorization") !== `Bearer ${process.env.CRON_SECRET}`
  ) {
    return new Response("Unauthorized", { status: 401 });
  }

  const yesterday = await getYesterdayStats();

  await sendEmail({
    to: "kapitan@barangay.gov.ph",
    subject: "Daily Barangay Summary",
    body: `
      Yesterday's Stats:
      - Visitors: ${yesterday.visitors}
      - New Registrations: ${yesterday.registrations}
      - Issues Reported: ${yesterday.issues}
    `,
  });

  return Response.json({ success: true });
}
```

---

## Key Takeaways

✓ Cron jobs are scheduled functions that run automatically
✓ Use cron expression syntax: minute hour day month weekday
✓ Define crons in `vercel.json`
✓ Always secure endpoints with CRON_SECRET
✓ Schedules run in UTC—convert from local time
✓ Hobby plan: 2 crons, daily minimum; Pro: 40 crons, per-minute

**Next Lesson:** API Routes Best Practices—error handling, timeouts, and streaming!
