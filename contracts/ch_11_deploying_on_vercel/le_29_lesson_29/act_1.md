# Rollbacks & Instant Rollback Activity

Learn to recover from failed deployments. In this activity, you'll practice rollback strategies.

## Task for Students

### Part 1: Rollback Concepts Quiz

**Question 1:** What is a rollback?

- A) Deploying new code
- B) Reverting to a previous deployment
- C) Restarting the server
- D) Clearing the cache

**Question 2:** Why is Vercel's rollback "instant"?

- A) It rebuilds faster
- B) Previous deployments are saved and just re-routed
- C) It uses faster servers
- D) It skips tests

**Question 3:** What does NOT get rolled back?

- A) Application code
- B) Static assets
- C) Database changes
- D) Serverless functions

**Question 4:** When should you rollback?

- A) For any bug
- B) Only on Fridays
- C) When critical functionality is broken
- D) After every deployment

**Question 5:** What command rolls back via CLI?

- A) `vercel undo`
- B) `vercel revert`
- C) `vercel rollback`
- D) `vercel restore`

---

### Part 2: Rollback via CLI

**Task:** Practice CLI rollback commands:

```bash
# 1. List all deployments
vercel ls

# Output:
# url                                  state  age
# my-app-abc123.vercel.app            READY  5m   ← Current (broken)
# my-app-def456.vercel.app            READY  2h   ← Previous (working)
# my-app-ghi789.vercel.app            READY  1d

# 2. Rollback to previous
vercel rollback

# 3. Or rollback to specific deployment
vercel rollback my-app-def456.vercel.app
```

**Exercise:** What commands would you run to:

1. See all deployments: \_\_\_
2. Rollback to immediately previous: \_\_\_
3. Rollback to deployment from 1 day ago: \_\_\_

---

### Part 3: Health Check Implementation

**Task:** Implement automated health checking:

```yaml
# .github/workflows/deploy.yml
deploy:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4

    - name: Deploy to production
      id: deploy
      run: |
        url=$(vercel deploy --prod --token=${{ secrets.VERCEL_TOKEN }})
        echo "url=$url" >> $GITHUB_OUTPUT

    - name: Wait for deployment
      run: sleep 30

    - name: Health check
      run: |
        url="${{ steps.deploy.outputs.url }}"

        # Check homepage
        if ! curl -sf "$url" > /dev/null; then
          echo "Homepage check failed"
          exit 1
        fi

        # Check API
        if ! curl -sf "$url/api/health" > /dev/null; then
          echo "API check failed"
          exit 1
        fi

        echo "All health checks passed"
```

**Questions:**

1. What does `-sf` do in curl? \_\_\_

2. Why wait 30 seconds before health check? \_\_\_

3. What endpoints should you check? \_\_\_

---

### Part 4: Automatic Rollback

**Task:** Add automatic rollback on failure:

```yaml
- name: Health check
  id: health
  continue-on-error: true
  run: |
    response=$(curl -s -o /dev/null -w "%{http_code}" ${{ steps.deploy.outputs.url }})
    if [ "$response" != "200" ]; then
      echo "Health check failed with status $response"
      exit 1
    fi

- name: Rollback if health check failed
  if: steps.health.outcome == 'failure'
  run: |
    echo "Rolling back to previous deployment..."
    vercel rollback --token=${{ secrets.VERCEL_TOKEN }}

    # Notify team
    curl -X POST ${{ secrets.SLACK_WEBHOOK }} \
      -H "Content-Type: application/json" \
      -d '{"text":"⚠️ Production deployment failed and was rolled back!"}'

- name: Fail the workflow
  if: steps.health.outcome == 'failure'
  run: exit 1
```

**Exercise:** Why use `continue-on-error: true` on the health check step? \_\_\_

---

### Part 5: Database Migration Safety

**Scenario:** You're adding a new feature that requires database changes:

```
Current schema:
users: id, name, email

New feature needs:
users: id, name, email, phone
```

**Task:** Design a safe migration strategy:

**Step 1:** Add column (backward compatible)

```sql
ALTER TABLE users ADD COLUMN phone VARCHAR(20);
```

**Step 2:** Deploy code that writes to phone

```javascript
// New code writes to phone, but doesn't require it
user.phone = formData.phone || null;
```

**Step 3:** Backfill existing data

```sql
UPDATE users SET phone = 'Unknown' WHERE phone IS NULL;
```

**Step 4:** Deploy code that requires phone

```javascript
// Now safe to require phone
if (!user.phone) throw new Error("Phone required");
```

**Questions:**

1. Why not add column and require it in one deploy? \_\_\_

2. What happens if you rollback after Step 2? \_\_\_

3. When is it safe to make phone NOT NULL in the database? \_\_\_

---

### Part 6: Feature Flags

**Task:** Implement a feature flag system:

```javascript
// lib/featureFlags.js
const flags = {
  newDashboard: process.env.FEATURE_NEW_DASHBOARD === "true",
  darkMode: process.env.FEATURE_DARK_MODE === "true",
  betaApi: process.env.FEATURE_BETA_API === "true",
};

export function isEnabled(flag) {
  return flags[flag] ?? false;
}
```

**Usage:**

```javascript
import { isEnabled } from "@/lib/featureFlags";

export default function Dashboard() {
  if (isEnabled("newDashboard")) {
    return <NewDashboard />;
  }
  return <LegacyDashboard />;
}
```

**Exercise:** How would you:

1. Enable the new dashboard for production? \_\_\_

2. Roll back the feature without deploying? \_\_\_

3. Enable for only some users? \_\_\_

---

### Part 7: Rollback Decision Tree

**Task:** Complete the decision tree:

```
Is the site completely down?
├─ Yes → _______________
└─ No
   └─ Is a critical feature broken?
      ├─ Yes → _______________
      └─ No
         └─ Can it be hotfixed in < 15 min?
            ├─ Yes → _______________
            └─ No → _______________
```

---

### Part 8: Rollback Communication

**Task:** Create a rollback runbook:

```markdown
# Rollback Runbook

## When to Rollback

- [ ] Site is down or error rate > 5%
- [ ] Critical functionality broken
- [ ] Security vulnerability discovered

## Rollback Steps

1. ******\_\_\_****** (notify team)
2. ******\_\_\_****** (execute rollback)
3. ******\_\_\_****** (verify site)
4. ******\_\_\_****** (update status)
5. ******\_\_\_****** (post-mortem)

## Notification Template

Subject: [INCIDENT] Production Rollback Executed

What happened: ******\_\_\_******
Impact: ******\_\_\_******
Resolution: ******\_\_\_******
Next steps: ******\_\_\_******
```

---

### Part 9: Simulate Rollback Scenario

**Scenario:** You deployed at 2:00 PM. At 2:15 PM, you see:

```
Error logs:
- TypeError: Cannot read property 'map' of undefined
- 500 errors: 150 in last 5 minutes
- User reports: "Dashboard won't load"
```

**Exercise:** Write the steps you would take:

1. Time 2:15: ******\_\_\_******

2. Time 2:16: ******\_\_\_******

3. Time 2:17: ******\_\_\_******

4. Time 2:20: ******\_\_\_******

5. Time 2:30: ******\_\_\_******

---

### Part 10: Prevention Checklist

**Task:** Create a pre-deployment checklist:

```markdown
# Pre-Deployment Checklist

## Automated Checks

- [ ] All tests passing
- [ ] Linting clean
- [ ] Type checking passes
- [ ] Build succeeds
- [ ] E2E tests on preview

## Manual Checks

- [ ] Preview deployment reviewed
- [ ] Critical paths tested manually
- [ ] Performance acceptable
- [ ] No console errors

## Deployment Safety

- [ ] Database migrations backward compatible
- [ ] Feature flags in place for risky features
- [ ] Rollback plan documented
- [ ] Team aware of deployment

## Post-Deployment

- [ ] Health check passes
- [ ] Monitor error rates
- [ ] Monitor performance
- [ ] Check user feedback channels
```

---

### What You Learned

✓ Executing rollbacks via dashboard and CLI
✓ Implementing automated health checks
✓ Setting up automatic rollback on failure
✓ Safe database migration strategies
✓ Using feature flags to reduce risk
✓ Creating rollback runbooks

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-C, 4-C, 5-C

Part 2:

1. `vercel ls`
2. `vercel rollback`
3. `vercel rollback my-app-ghi789.vercel.app`

Part 3:

1. `-s` silent, `-f` fail silently on HTTP errors
2. Deployment needs time to propagate to edge network
3. Homepage, critical API endpoints, health endpoint

Part 4: Allows the rollback step to run even if health check fails

Part 5:

1. If you rollback, code wouldn't work with required column
2. Works fine - column exists but isn't required
3. After Step 4 has been stable and you're sure no rollback needed

Part 6:

1. Set `FEATURE_NEW_DASHBOARD=true` in Vercel environment variables
2. Set `FEATURE_NEW_DASHBOARD=false` - instant "rollback" without deploy
3. Use user-based flags: `isEnabled('newDashboard') && user.isBeta`

Part 7:

- Yes (site down) → Rollback immediately
- Yes (critical broken) → Rollback immediately
- Yes (can hotfix) → Attempt hotfix
- No (can't hotfix quickly) → Rollback then fix

Part 9 (Example):

1. 2:15: Alert team in Slack, investigate
2. 2:16: Confirm issue, decide to rollback
3. 2:17: Execute `vercel rollback`, verify site
4. 2:20: Update status page, notify stakeholders
5. 2:30: Begin debugging in preview environment
