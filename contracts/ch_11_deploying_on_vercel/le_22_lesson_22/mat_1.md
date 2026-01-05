# Le 22: Deployment Protection – Passwords, Authentication, and Trusted IPs

![Deployment Protection](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/deployment-protection.png)

## Background Story

Maria's staging environment contains sensitive data. She doesn't want anyone stumbling upon preview URLs.

"Can I add a password to preview deployments?" Maria asks.

"Absolutely," Marco replies. "Vercel offers multiple protection layers—passwords, authentication, trusted IPs, and more."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Password protection for deployments
- Vercel Authentication
- Trusted IP allowlists
- Protection by environment
- Bypass options for automation
- Combining protection methods

---

## Deployment Protection Overview

Vercel offers several protection mechanisms:

| Protection Type       | Best For                  |
| --------------------- | ------------------------- |
| Password              | Simple access control     |
| Vercel Authentication | Team-only access          |
| Trusted IPs           | Office/VPN-only access    |
| Deployment Approval   | Manual gate before deploy |
| Protection Bypass     | CI/CD and automation      |

---

## Password Protection

Add a password to your deployments:

### Enable Password Protection

1. Project Settings → Deployment Protection
2. Enable "Password Protection"
3. Set a password
4. Choose which environments to protect

### Password Settings

```
Password Protection:
- Enabled: ✅
- Password: ********
- Apply to: Preview Deployments
- Remember password: 7 days
```

### How It Works

1. User visits protected deployment
2. Password prompt appears
3. Correct password → Access granted (cookie stored)
4. Wrong password → Access denied

---

## Vercel Authentication

Require visitors to log in with Vercel:

### Enable Vercel Auth

1. Project Settings → Deployment Protection
2. Enable "Vercel Authentication"
3. Select scope (Team members only)

### Authentication Options

| Option            | Who Can Access               |
| ----------------- | ---------------------------- |
| Only Team Members | Your Vercel team members     |
| All Vercel Users  | Anyone with a Vercel account |
| Specific Users    | Invited email addresses      |

### Benefits

- No passwords to share
- Automatic access for team
- Easy to revoke access
- Audit trail of who accessed

---

## Trusted IPs

Restrict access to specific IP addresses:

### Configure IP Allowlist

1. Project Settings → Deployment Protection
2. Enable "Trusted IPs"
3. Add IP addresses or CIDR ranges

### Example Configuration

```
Trusted IPs:
- 203.0.113.0/24    # Office network
- 10.0.0.0/8        # VPN range
- 192.168.1.100     # Developer home
```

### Use Cases

- Office-only access
- VPN-only access
- Specific client IPs
- Testing environments

---

## Environment-Specific Protection

Apply different protection per environment:

### Configuration Matrix

| Environment | Protection             |
| ----------- | ---------------------- |
| Production  | None (public)          |
| Preview     | Vercel Authentication  |
| Development | Password + Trusted IPs |

### Configure in Dashboard

1. Project Settings → Deployment Protection
2. Toggle protection per environment:
   - Production
   - Preview
   - Development

---

## Protection Bypass

Allow automated tools to bypass protection:

### Protection Bypass Token

1. Project Settings → Deployment Protection
2. Generate "Protection Bypass Token"
3. Add to your automation

### Using the Bypass Token

```bash
# Add header to requests
curl -H "x-vercel-protection-bypass: your-token" https://preview.example.com

# Or as query parameter
curl "https://preview.example.com?x-vercel-protection-bypass=your-token"
```

### Use Cases

- E2E testing (Playwright, Cypress)
- Health checks from monitoring tools
- API clients
- CI/CD pipelines

---

## Deployment Approval

Require manual approval before deployment:

### Enable Approval

1. Project Settings → Deployment Protection
2. Enable "Deployment Approval"
3. Configure approvers

### Approval Workflow

```
1. Code merged to main
2. Build completes
3. Deployment queued (waiting approval)
4. Approver receives notification
5. Approver reviews and approves
6. Deployment goes live
```

### Configuring Approvers

```
Approvers:
- Maria (Owner)
- Juan (Member)

Settings:
- Required approvals: 1
- Auto-approve after: Never
```

---

## Bypass for Automation

### Playwright/Cypress E2E Tests

```javascript
// playwright.config.ts
export default {
  use: {
    extraHTTPHeaders: {
      "x-vercel-protection-bypass": process.env.VERCEL_BYPASS_TOKEN,
    },
  },
};
```

### GitHub Actions

```yaml
# .github/workflows/e2e.yml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Run E2E Tests
        env:
          VERCEL_BYPASS_TOKEN: ${{ secrets.VERCEL_BYPASS_TOKEN }}
        run: npx playwright test
```

---

## Combining Protection Methods

Stack multiple protection methods:

### Example: High-Security Preview

```
Preview Deployment Protection:
├── Vercel Authentication: ✅ (team only)
├── Trusted IPs: ✅ (office + VPN)
├── Password: ✅ (additional layer)
└── Deployment Approval: ❌ (preview only)
```

**Access Requirements:**

1. Must be on trusted IP (office/VPN)
2. Must authenticate with Vercel
3. Must enter password

### Example: Sensitive Production

```
Production Protection:
├── Vercel Authentication: ❌ (public site)
├── Trusted IPs: ❌ (public access)
├── Password: ❌ (public site)
└── Deployment Approval: ✅ (require approval)
```

---

## Secret Links

Share temporary access without full authentication:

### Generate Secret Link

1. Deployment → Share
2. Generate secret link
3. Set expiration (1 hour, 1 day, 1 week)
4. Share with reviewer

### Secret Link Format

```
https://your-deployment.vercel.app?_vercel_token=abc123
```

**Note:** Secret links bypass password protection but not IP restrictions.

---

## Automation Integration

### Vercel CLI Bypass

```bash
# The CLI uses your authentication automatically
vercel
```

### API Bypass

```bash
curl -H "Authorization: Bearer your-vercel-token" \
  https://api.vercel.com/v1/deployments
```

### Monitoring Tools

For uptime monitoring (Datadog, Pingdom):

1. Generate bypass token
2. Add to monitoring service
3. Monitor protected endpoints

---

## Security Best Practices

### Rotate Tokens Regularly

```bash
# Generate new bypass token
vercel secrets add bypass-token "new-token-value"
```

### Use Environment-Specific Passwords

| Environment | Password          |
| ----------- | ----------------- |
| Preview     | preview-pass-2026 |
| Staging     | staging-pass-2026 |
| Demo        | demo-client-2026  |

### Audit Access

1. Check audit logs regularly
2. Review who accessed protected deployments
3. Remove unused bypass tokens

---

## Maria's Protection Setup

Maria configures protection for her projects:

**Dashboard (Public Site):**

```
Production: No protection
Preview: Vercel Authentication (team only)
```

**Admin Panel:**

```
Production: Trusted IPs (office only) + Vercel Auth
Preview: Vercel Authentication + Password
```

**API:**

```
Production: No protection (API is authenticated)
Preview: Bypass token for E2E tests
```

---

## Key Takeaways

✓ Use password protection for simple access control
✓ Vercel Authentication for team-only access
✓ Trusted IPs for network-based restrictions
✓ Deployment Approval for production safety
✓ Bypass tokens for automation and testing
✓ Combine methods for layered security

**Next Lesson:** Speed Insights—measuring and optimizing real-world performance!
