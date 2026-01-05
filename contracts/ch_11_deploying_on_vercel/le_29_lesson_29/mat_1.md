# Le 29: Rollbacks & Instant Rollback – Recovering from Failed Deployments

![Rollback](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/rollback.png)

## Background Story

Maria just deployed a critical update to her barangay dashboard. Minutes later, residents report the site is broken.

"The homepage is showing an error!" a panicked resident calls.

"Don't worry," Marco assures her. "We can roll back instantly. That's the beauty of Vercel."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Understanding rollbacks
- Vercel Instant Rollback
- When to rollback
- Rollback via dashboard
- Rollback via CLI
- Automated rollback
- Preventing rollback situations

---

## What is a Rollback?

### Definition

```
Rollback = Reverting to a previous working deployment

Current (broken) → Previous (working)
```

### Why Rollbacks Matter

| Scenario            | Without Rollback         | With Rollback         |
| ------------------- | ------------------------ | --------------------- |
| Bug in production   | Fix and redeploy (hours) | Instant recovery      |
| API breaking change | Users affected           | Immediate restoration |
| Performance issue   | Slow site                | Quick recovery        |

---

## Vercel Instant Rollback

### How It Works

```
Every deployment is immutable and saved:

v1 (March 1) ← Current
v2 (March 5)
v3 (March 10)
v4 (March 15) ← Previous working
v5 (March 20) ← Broken (rolled back from)

Rollback to v4: Instant (no rebuild!)
```

### Why It's Instant

- No rebuild required
- Previous deployment still exists
- Just change traffic routing
- Takes seconds, not minutes

---

## When to Rollback

### Rollback Immediately If

✅ Site is completely broken
✅ Critical functionality missing
✅ Security vulnerability discovered
✅ Major performance degradation
✅ Data corruption risk

### Maybe Don't Rollback If

❌ Minor visual bug
❌ Non-critical feature issue
❌ Can be hotfixed quickly
❌ Only affects small user group

---

## Rollback via Dashboard

### Steps

1. Go to your Vercel project
2. Click "Deployments" tab
3. Find the working deployment
4. Click the three dots menu (⋯)
5. Select "Promote to Production"
6. Confirm the action

### Visual Guide

```
Deployments List:
┌────────────────────────────────────────┐
│ ● Current  abc123  3 min ago  [⋯]     │
│ ○ Previous def456  2 hours ago [⋯]    │ ← Click here
│ ○ Older    ghi789  1 day ago   [⋯]    │
└────────────────────────────────────────┘

Click [⋯] → "Promote to Production"
```

---

## Rollback via CLI

### Install Vercel CLI

```bash
npm install -g vercel
```

### Authenticate

```bash
vercel login
```

### List Deployments

```bash
vercel ls

# Output:
# > Deployments
# url                              state    age
# abc123.vercel.app                READY    3m
# def456.vercel.app                READY    2h
# ghi789.vercel.app                READY    1d
```

### Rollback to Previous

```bash
# Rollback to immediately previous deployment
vercel rollback

# Rollback to specific deployment
vercel rollback def456.vercel.app
```

---

## Promote a Deployment

### Via CLI

```bash
# Promote specific deployment to production
vercel promote [deployment-url]

# Example
vercel promote my-app-def456.vercel.app --prod
```

### Via API

```bash
curl -X POST "https://api.vercel.com/v6/deployments/dpl_xxx/promote" \
  -H "Authorization: Bearer $VERCEL_TOKEN" \
  -H "Content-Type: application/json"
```

---

## Automated Rollback

### Health Check Pattern

```yaml
# .github/workflows/deploy.yml
- name: Deploy
  id: deploy
  run: |
    url=$(vercel deploy --prod --token=${{ secrets.VERCEL_TOKEN }})
    echo "url=$url" >> $GITHUB_OUTPUT

- name: Health check
  id: health
  run: |
    for i in {1..5}; do
      status=$(curl -s -o /dev/null -w "%{http_code}" ${{ steps.deploy.outputs.url }})
      if [ "$status" = "200" ]; then
        echo "Health check passed"
        exit 0
      fi
      sleep 10
    done
    echo "Health check failed"
    exit 1

- name: Rollback on failure
  if: failure() && steps.health.outcome == 'failure'
  run: vercel rollback --token=${{ secrets.VERCEL_TOKEN }}
```

### Monitoring-Based Rollback

```javascript
// Example: Rollback if error rate spikes
import { Vercel } from "@vercel/sdk";

async function checkAndRollback() {
  const errorRate = await getErrorRate(); // From your monitoring

  if (errorRate > 5) {
    // More than 5% errors
    console.log("Error rate too high, rolling back");

    const vercel = new Vercel({ token: process.env.VERCEL_TOKEN });
    await vercel.deployments.rollback();
  }
}
```

---

## Rollback Considerations

### What Gets Rolled Back

✅ Application code
✅ Static assets
✅ Serverless functions
✅ Build output

### What Doesn't Get Rolled Back

❌ Environment variables
❌ Database changes
❌ External API state
❌ DNS settings

---

## Database Migrations

### The Challenge

```
v1: Database has columns A, B
v2: Migration adds column C
v3: Code uses column C

If you rollback to v1:
- Code doesn't use column C ✓
- Column C still exists in DB ✓
- Usually safe!

But if v2 removed column A:
- Rollback to v1 needs column A
- Column A is gone!
- PROBLEM!
```

### Best Practices

1. **Make migrations backward compatible**
2. **Separate deploy from migrate**
3. **Never drop columns immediately**
4. **Use feature flags**

### Safe Migration Pattern

```sql
-- Deploy 1: Add new column
ALTER TABLE users ADD COLUMN new_email VARCHAR(255);

-- Deploy 2: Migrate data (old and new code work)
UPDATE users SET new_email = email WHERE new_email IS NULL;

-- Deploy 3: Switch to new column
-- (now rollback to Deploy 2 is safe)

-- Deploy 4: Remove old column (after confirming)
ALTER TABLE users DROP COLUMN email;
```

---

## Feature Flags

### Why Use Feature Flags

```javascript
// Instead of deploying feature directly:
function Dashboard() {
  return <NewFeature />; // If broken, need rollback
}

// Use feature flag:
function Dashboard() {
  if (featureFlags.newDashboard) {
    return <NewFeature />;
  }
  return <OldFeature />; // Easy to disable flag
}
```

### Benefits

- Instant "rollback" without deploy
- Gradual rollouts
- A/B testing
- Quick disable

---

## Rollback History

### Viewing Rollback Events

```bash
# Via CLI
vercel logs --type=rollback

# Via Dashboard
Project → Activity → Filter by "Rollback"
```

### What's Logged

```json
{
  "event": "rollback",
  "timestamp": "2026-03-20T10:30:00Z",
  "from": "abc123",
  "to": "def456",
  "triggeredBy": "maria@barangay.ph",
  "reason": "manual"
}
```

---

## Preventing Rollback Situations

### Pre-Deployment Checklist

| Check             | How                   |
| ----------------- | --------------------- |
| Tests pass        | CI/CD                 |
| E2E tests         | Playwright on preview |
| Performance check | Lighthouse CI         |
| Security scan     | Automated tools       |
| Manual QA         | Preview deployment    |

### Gradual Rollout

```javascript
// vercel.json - split traffic
{
  "routes": [
    {
      "src": "/(.*)",
      "dest": "https://new-version.vercel.app",
      "headers": {
        "x-version": "new"
      },
      "continue": true,
      "has": [
        {
          "type": "cookie",
          "key": "beta",
          "value": "true"
        }
      ]
    }
  ]
}
```

---

## Maria's Recovery

Maria's site is broken. She acts fast:

```bash
# 1. Check current status
vercel ls

# 2. Find last working deployment
# See: def456.vercel.app from 2 hours ago

# 3. Instant rollback
vercel rollback def456.vercel.app

# 4. Verify site is working
curl https://barangay-dashboard.vercel.app

# Total time: 30 seconds
```

**Result:**

- Site restored in under a minute
- No data loss
- Residents can access dashboard
- Time to debug the issue calmly

---

## Key Takeaways

✓ Vercel keeps all deployments—rollback is instant
✓ Use dashboard or CLI to rollback
✓ Automate rollback with health checks
✓ Database migrations need special care
✓ Feature flags reduce rollback needs
✓ Prevention is better than rollback

**Next Lesson:** Production Checklist—ensuring your deployment is ready for users!
