# Le 27: Vercel Firewall – Protecting Your Application from Threats

![Vercel Firewall](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/firewall.png)

## Background Story

Maria's barangay dashboard is live. But she notices suspicious activity—bots scraping data and strange login attempts.

"Look at this," Maria shows Marco. "Hundreds of requests from the same IP."

"Time to set up the firewall," Marco says. "Vercel's WAF will protect you."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Understanding web security threats
- Vercel Web Application Firewall (WAF)
- IP blocking and allowlisting
- Rate limiting
- Bot protection
- DDoS mitigation
- Custom firewall rules

---

## Web Security Threats

### Common Attack Types

| Attack        | Description           | Impact           |
| ------------- | --------------------- | ---------------- |
| DDoS          | Flood of requests     | Site down        |
| SQL Injection | Malicious SQL queries | Data breach      |
| XSS           | Malicious scripts     | User data theft  |
| Brute Force   | Password guessing     | Account takeover |
| Bot Scraping  | Automated data theft  | IP/content theft |

### Attack Examples

```
DDoS Attack:
- 10,000 requests/second
- From distributed sources
- Overwhelms server

Brute Force:
- Automated login attempts
- Tries common passwords
- Targets admin accounts
```

---

## Vercel Web Application Firewall

### What WAF Does

```
User Request → Vercel Edge → WAF Check → Your App

WAF filters:
- Malicious requests blocked
- Rate limits enforced
- Bot traffic identified
- Geographic restrictions applied
```

### Enabling Firewall

1. Go to Project Settings → Security
2. Enable Firewall
3. Configure rules
4. Monitor blocked requests

---

## IP Blocking

### Block Specific IPs

```json
// vercel.json
{
  "firewall": {
    "rules": [
      {
        "type": "ip",
        "action": "deny",
        "ip": ["192.168.1.100", "10.0.0.50"]
      }
    ]
  }
}
```

### Block IP Ranges (CIDR)

```json
{
  "firewall": {
    "rules": [
      {
        "type": "ip",
        "action": "deny",
        "ip": ["192.168.0.0/16", "10.0.0.0/8"]
      }
    ]
  }
}
```

---

## IP Allowlisting

### Allow Only Specific IPs

```json
// vercel.json
{
  "firewall": {
    "rules": [
      {
        "type": "ip",
        "action": "allow",
        "ip": ["203.0.113.0/24"] // Office network
      },
      {
        "type": "default",
        "action": "deny"
      }
    ]
  }
}
```

### Use Cases

- Internal dashboards
- Staging environments
- Admin panels
- Development access

---

## Rate Limiting

### Configure Rate Limits

```json
// vercel.json
{
  "firewall": {
    "rateLimit": {
      "requests": 100,
      "window": 60, // seconds
      "action": "deny"
    }
  }
}
```

### Per-Route Rate Limits

```json
{
  "firewall": {
    "rules": [
      {
        "type": "path",
        "path": "/api/login",
        "rateLimit": {
          "requests": 5,
          "window": 60
        }
      },
      {
        "type": "path",
        "path": "/api/*",
        "rateLimit": {
          "requests": 50,
          "window": 60
        }
      }
    ]
  }
}
```

---

## Bot Protection

### Enable Bot Protection

```json
// vercel.json
{
  "firewall": {
    "botProtection": {
      "enabled": true,
      "mode": "challenge" // or "block"
    }
  }
}
```

### Bot Detection Modes

| Mode        | Behavior                       |
| ----------- | ------------------------------ |
| `monitor`   | Log bot traffic only           |
| `challenge` | Show CAPTCHA to suspected bots |
| `block`     | Block all bot traffic          |

### Allow Good Bots

```json
{
  "firewall": {
    "botProtection": {
      "enabled": true,
      "allowedBots": ["googlebot", "bingbot", "facebookexternalhit"]
    }
  }
}
```

---

## Geographic Restrictions

### Block by Country

```json
// vercel.json
{
  "firewall": {
    "rules": [
      {
        "type": "geo",
        "action": "deny",
        "country": ["XX", "YY"] // Country codes
      }
    ]
  }
}
```

### Allow Only Specific Countries

```json
{
  "firewall": {
    "rules": [
      {
        "type": "geo",
        "action": "allow",
        "country": ["PH", "US", "SG"]
      },
      {
        "type": "default",
        "action": "deny"
      }
    ]
  }
}
```

---

## Path-Based Rules

### Protect Sensitive Routes

```json
// vercel.json
{
  "firewall": {
    "rules": [
      {
        "type": "path",
        "path": "/admin/*",
        "ip": ["office-ip"],
        "action": "allow"
      },
      {
        "type": "path",
        "path": "/admin/*",
        "action": "deny"
      }
    ]
  }
}
```

### API Protection

```json
{
  "firewall": {
    "rules": [
      {
        "type": "path",
        "path": "/api/internal/*",
        "headers": {
          "x-api-key": "secret-key"
        },
        "action": "allow"
      },
      {
        "type": "path",
        "path": "/api/internal/*",
        "action": "deny"
      }
    ]
  }
}
```

---

## Custom Rules

### Header-Based Rules

```json
{
  "firewall": {
    "rules": [
      {
        "type": "header",
        "header": "User-Agent",
        "pattern": ".*curl.*",
        "action": "deny"
      }
    ]
  }
}
```

### Combined Rules

```json
{
  "firewall": {
    "rules": [
      {
        "type": "combined",
        "conditions": {
          "path": "/api/*",
          "method": "POST",
          "country": ["XX"]
        },
        "action": "deny"
      }
    ]
  }
}
```

---

## DDoS Protection

### Automatic Protection

Vercel provides automatic DDoS protection:

- Edge network absorbs traffic
- Automatic rate limiting
- Geographic distribution
- Traffic analysis

### Enhanced Protection

```json
// vercel.json
{
  "firewall": {
    "ddos": {
      "mode": "high",
      "threshold": 1000 // requests per second
    }
  }
}
```

---

## Monitoring Blocked Requests

### Dashboard View

1. Go to Project → Analytics → Security
2. View blocked requests
3. Analyze attack patterns
4. Adjust rules as needed

### Log Format

```json
{
  "timestamp": "2026-01-15T10:30:00Z",
  "action": "blocked",
  "rule": "rate-limit",
  "ip": "192.168.1.100",
  "path": "/api/login",
  "country": "XX",
  "userAgent": "curl/7.68.0"
}
```

---

## Security Headers

### Configure Headers

```json
// vercel.json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "Strict-Transport-Security",
          "value": "max-age=31536000; includeSubDomains"
        },
        {
          "key": "Content-Security-Policy",
          "value": "default-src 'self'"
        }
      ]
    }
  ]
}
```

### Security Header Reference

| Header                 | Purpose                  |
| ---------------------- | ------------------------ |
| X-Frame-Options        | Prevent clickjacking     |
| X-Content-Type-Options | Prevent MIME sniffing    |
| HSTS                   | Force HTTPS              |
| CSP                    | Control resource loading |

---

## Maria's Security Setup

Maria configures her barangay dashboard:

```json
// vercel.json
{
  "firewall": {
    "rules": [
      {
        "type": "path",
        "path": "/admin/*",
        "ip": ["barangay-office-ip"],
        "action": "allow"
      },
      {
        "type": "path",
        "path": "/admin/*",
        "action": "deny"
      },
      {
        "type": "path",
        "path": "/api/login",
        "rateLimit": {
          "requests": 5,
          "window": 60
        }
      }
    ],
    "botProtection": {
      "enabled": true,
      "mode": "challenge",
      "allowedBots": ["googlebot"]
    }
  }
}
```

**Results:**

- Brute force attacks stopped
- Bot scraping blocked
- Admin panel secured
- Good SEO bots allowed

---

## Key Takeaways

✓ Use WAF to protect against common attacks
✓ Block suspicious IPs and ranges
✓ Rate limit sensitive endpoints
✓ Enable bot protection for public sites
✓ Add security headers for defense in depth
✓ Monitor blocked requests to tune rules

**Next Lesson:** CI/CD Best Practices—automating your deployment workflow!
