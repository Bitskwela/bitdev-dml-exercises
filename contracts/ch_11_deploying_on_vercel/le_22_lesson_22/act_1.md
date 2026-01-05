# Deployment Protection Activity

Protecting your deployments from unauthorized access is crucial. In this activity, you'll configure various protection methods.

## Task for Students

### Part 1: Protection Concepts Quiz

**Question 1:** Which protection method requires visitors to log in with Vercel?

- A) Password Protection
- B) Vercel Authentication
- C) Trusted IPs
- D) Secret Links

**Question 2:** What is a Protection Bypass Token used for?

- A) Resetting passwords
- B) Allowing automated tools to access protected deployments
- C) Encrypting data
- D) Speeding up deployments

**Question 3:** Which protection is best for "office only" access?

- A) Password Protection
- B) Vercel Authentication
- C) Trusted IPs
- D) Secret Links

**Question 4:** What happens when Deployment Approval is enabled?

- A) Deployments are faster
- B) Deployments wait for manual approval before going live
- C) Passwords are required
- D) Only owners can deploy

**Question 5:** How do you share temporary access without sharing a password?

- A) Trusted IPs
- B) Vercel Authentication
- C) Secret Links
- D) Bypass Token

---

### Part 2: Configure Password Protection

**Step 1:** Navigate to Project Settings → Deployment Protection

**Step 2:** Enable Password Protection:

```yaml
Password Protection:
  Enabled: Yes
  Password: secure-preview-pass-2026
  Apply to: Preview Deployments only
  Remember for: 7 days
```

**Step 3:** Test the protection:

1. Open a preview deployment URL
2. You should see a password prompt
3. Enter the correct password
4. Access granted!

**Verification questions:**

- Does production require a password? \_\_\_
- How long before the password must be re-entered? \_\_\_

---

### Part 3: Configure Vercel Authentication

**Step 1:** In Project Settings → Deployment Protection:

```yaml
Vercel Authentication:
  Enabled: Yes
  Scope: Team Members Only
  Apply to: Preview Deployments
```

**Step 2:** Understand the flow:

```
User visits preview URL
  → Redirect to Vercel login
    → User logs in with Vercel
      → Vercel checks team membership
        → If member: Access granted
        → If not member: Access denied
```

**Question:** What's the advantage of Vercel Auth over passwords?

Answer: ******\_\_\_******

---

### Part 4: Configure Trusted IPs

**Step 1:** In Project Settings → Deployment Protection:

**Step 2:** Add trusted IP ranges:

```yaml
Trusted IPs:
  - 203.0.113.0/24 # Office network
  - 192.168.1.0/24 # VPN range
```

**Step 3:** Understand CIDR notation:

| CIDR            | Range                       |
| --------------- | --------------------------- |
| 192.168.1.0/24  | 192.168.1.0 - 192.168.1.255 |
| 10.0.0.0/8      | 10.0.0.0 - 10.255.255.255   |
| 203.0.113.50/32 | Single IP: 203.0.113.50     |

**Exercise:** What CIDR would allow only 10.0.1.0 to 10.0.1.255?

Answer: ******\_\_\_******

---

### Part 5: Set Up Protection Bypass

**Step 1:** Generate a bypass token:

Project Settings → Deployment Protection → Protection Bypass

**Step 2:** Store the token securely:

```bash
# In CI/CD secrets
VERCEL_BYPASS_TOKEN=abc123xyz789
```

**Step 3:** Use in Playwright tests:

```typescript
// playwright.config.ts
import { defineConfig } from "@playwright/test";

export default defineConfig({
  use: {
    extraHTTPHeaders: {
      "x-vercel-protection-bypass": process.env.VERCEL_BYPASS_TOKEN || "",
    },
  },
});
```

**Step 4:** Use in API calls:

```bash
# With header
curl -H "x-vercel-protection-bypass: $TOKEN" https://preview.example.com

# With query param
curl "https://preview.example.com?x-vercel-protection-bypass=$TOKEN"
```

---

### Part 6: Configure Deployment Approval

**Step 1:** In Project Settings → Deployment Protection:

```yaml
Deployment Approval:
  Enabled: Yes
  Required for: Production
  Approvers:
    - maria@barangay.gov.ph
    - juan@barangay.gov.ph
  Required approvals: 1
```

**Step 2:** Understand the workflow:

1. Developer merges to main
2. Build completes successfully
3. Status: "Awaiting Approval"
4. Approver receives Slack/Email notification
5. Approver clicks "Approve" in dashboard
6. Deployment goes live

**Question:** Why is deployment approval important for production?

Answer: ******\_\_\_******

---

### Part 7: Environment Protection Matrix

**Task:** Design protection for each environment:

| Environment              | Password | Vercel Auth | Trusted IP | Approval |
| ------------------------ | -------- | ----------- | ---------- | -------- |
| Production (public site) |          |             |            |          |
| Preview (dev team)       |          |             |            |          |
| Staging (QA team)        |          |             |            |          |
| Demo (client preview)    |          |             |            |          |

**Fill in with Yes/No based on these requirements:**

- Production: Public website, but require approval before deploy
- Preview: Team members only
- Staging: Team + QA testers (not on Vercel team)
- Demo: Password-protected for client review

---

### Part 8: Combining Protections

**Scenario:** You need a high-security staging environment with:

1. Only office network can access
2. Must be a team member
3. Additional password layer

**Task:** Write the configuration:

```yaml
Staging Protection:
  Password:
    Enabled: ___
    Password: ___

  Vercel Authentication:
    Enabled: ___
    Scope: ___

  Trusted IPs:
    Enabled: ___
    Ranges:
      - ___
```

---

### Part 9: Secret Link Exercise

**Scenario:** A client needs to preview a deployment but:

- They're not on your Vercel team
- They're not on a trusted IP
- You don't want to share the password

**Solution:** Generate a secret link

**Step 1:** Go to the deployment
**Step 2:** Click "Share"
**Step 3:** Generate secret link with 24-hour expiration
**Step 4:** Send to client

**Questions:**

1. What happens after 24 hours? ******\_\_\_******
2. Does the secret link bypass IP restrictions? ******\_\_\_******
3. Does it bypass Vercel Authentication? ******\_\_\_******

---

### Part 10: Security Audit Checklist

Review your protection setup:

- [ ] Production has appropriate protection
- [ ] Preview deployments are not publicly accessible
- [ ] Bypass tokens are stored securely
- [ ] Bypass tokens are rotated quarterly
- [ ] Team members have Vercel accounts
- [ ] Trusted IP list is up-to-date
- [ ] Old secret links are expired
- [ ] Deployment approval has multiple approvers

---

### What You Learned

✓ Password protection for simple access control
✓ Vercel Authentication for team-only access
✓ Trusted IP allowlists for network-based security
✓ Bypass tokens for CI/CD and testing
✓ Deployment approval for production safety
✓ Secret links for temporary access

---

**Instructor Answers:**

Part 1: 1-B, 2-B, 3-C, 4-B, 5-C

Part 2:

- Does production require a password? No (Preview only)
- How long before re-entering? 7 days

Part 3:

- Advantage: No password to share, automatic access for team, easy to revoke, audit trail

Part 4:

- CIDR for 10.0.1.0-255: 10.0.1.0/24

Part 6:

- Why approval is important: Prevents accidental production deployments, adds review gate, creates accountability

Part 7:
| Environment | Password | Vercel Auth | Trusted IP | Approval |
|-------------|----------|-------------|------------|----------|
| Production | No | No | No | Yes |
| Preview | No | Yes | No | No |
| Staging | Yes | Yes | No | No |
| Demo | Yes | No | No | No |

Part 8:

```yaml
Staging Protection:
  Password:
    Enabled: Yes
    Password: staging-secure-2026
  Vercel Authentication:
    Enabled: Yes
    Scope: Team Members Only
  Trusted IPs:
    Enabled: Yes
    Ranges:
      - 203.0.113.0/24
```

Part 9:

1. Link expires and no longer works
2. No, IP restrictions still apply
3. Yes, it bypasses Vercel Auth
