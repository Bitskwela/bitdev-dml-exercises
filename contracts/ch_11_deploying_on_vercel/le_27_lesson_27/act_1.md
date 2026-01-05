# Vercel Firewall Activity

Protect your application from threats. In this activity, you'll configure firewall rules and security settings.

## Task for Students

### Part 1: Security Threats Quiz

**Question 1:** What does WAF stand for?

- A) Web Application Framework
- B) Web Application Firewall
- C) Wide Area Firewall
- D) Web Access Filter

**Question 2:** Which attack floods a server with requests?

- A) SQL Injection
- B) XSS
- C) DDoS
- D) Brute Force

**Question 3:** What is rate limiting used for?

- A) Limiting file sizes
- B) Limiting requests per time window
- C) Limiting bandwidth
- D) Limiting users

**Question 4:** Which header prevents clickjacking?

- A) X-Content-Type-Options
- B) X-Frame-Options
- C) Content-Security-Policy
- D) Strict-Transport-Security

**Question 5:** What is CIDR notation used for?

- A) Country codes
- B) IP address ranges
- C) Rate limits
- D) User agents

---

### Part 2: Block Malicious IPs

**Task:** Configure IP blocking:

```json
// vercel.json
{
  "firewall": {
    "rules": [
      {
        "type": "ip",
        "action": "deny",
        "ip": [
          "192.168.1.100", // Single IP
          "10.0.0.0/8", // Private range
          "203.0.113.0/24" // Suspicious network
        ]
      }
    ]
  }
}
```

**Exercise:** Add rules to block:

1. IP address 45.33.32.156
2. The range 198.51.100.0/24
3. Multiple IPs: 172.16.0.1, 172.16.0.2

---

### Part 3: Create IP Allowlist

**Task:** Restrict admin access to office IPs only:

```json
// vercel.json
{
  "firewall": {
    "rules": [
      {
        "type": "path",
        "path": "/admin/*",
        "ip": ["103.25.200.50", "103.25.200.51"],
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

**Questions:**

1. Why is the order of rules important? \_\_\_

2. What happens if someone from a different IP accesses /admin? \_\_\_

3. How would you add a VPN IP to the allowlist? \_\_\_

---

### Part 4: Configure Rate Limiting

**Task:** Add rate limits to protect your API:

```json
// vercel.json
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
        "path": "/api/register",
        "rateLimit": {
          "requests": 3,
          "window": 300
        }
      },
      {
        "type": "path",
        "path": "/api/*",
        "rateLimit": {
          "requests": 100,
          "window": 60
        }
      }
    ]
  }
}
```

**Exercise:** What are the limits for:

| Endpoint      | Requests | Per (seconds) |
| ------------- | -------- | ------------- |
| /api/login    | \_\_\_   | \_\_\_        |
| /api/register | \_\_\_   | \_\_\_        |
| /api/users    | \_\_\_   | \_\_\_        |
| /api/data     | \_\_\_   | \_\_\_        |

---

### Part 5: Enable Bot Protection

**Task:** Configure bot protection:

```json
// vercel.json
{
  "firewall": {
    "botProtection": {
      "enabled": true,
      "mode": "challenge",
      "allowedBots": [
        "googlebot",
        "bingbot",
        "facebookexternalhit",
        "twitterbot"
      ]
    }
  }
}
```

**Questions:**

1. What's the difference between "challenge" and "block" mode? \_\_\_

2. Why allow googlebot? \_\_\_

3. When would you use "block" mode? \_\_\_

---

### Part 6: Geographic Restrictions

**Task:** Configure country-based access:

**Scenario 1:** Block specific countries

```json
{
  "firewall": {
    "rules": [
      {
        "type": "geo",
        "action": "deny",
        "country": ["XX", "YY", "ZZ"]
      }
    ]
  }
}
```

**Scenario 2:** Allow only specific countries

```json
{
  "firewall": {
    "rules": [
      {
        "type": "geo",
        "action": "allow",
        "country": ["PH", "US", "SG", "JP"]
      },
      {
        "type": "default",
        "action": "deny"
      }
    ]
  }
}
```

**Exercise:** Configure access for a Philippines-only service:

```json
{
  "firewall": {
    "rules": [
      // Your rule here
    ]
  }
}
```

---

### Part 7: Security Headers

**Task:** Add security headers:

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
          "key": "Referrer-Policy",
          "value": "strict-origin-when-cross-origin"
        },
        {
          "key": "Permissions-Policy",
          "value": "camera=(), microphone=(), geolocation=()"
        }
      ]
    }
  ]
}
```

**Match the header to its purpose:**

| Header                 | Purpose |
| ---------------------- | ------- |
| X-Frame-Options        | \_\_\_  |
| X-Content-Type-Options | \_\_\_  |
| Referrer-Policy        | \_\_\_  |
| Permissions-Policy     | \_\_\_  |

**Options:**
A. Controls browser feature access
B. Prevents page from being embedded
C. Prevents MIME type sniffing
D. Controls referrer information

---

### Part 8: Complete Security Configuration

**Task:** Create a comprehensive security setup:

```json
// vercel.json
{
  "firewall": {
    "rules": [
      // Admin access
      {
        "type": "path",
        "path": "/admin/*",
        "ip": ["office-ip-1", "office-ip-2"],
        "action": "allow"
      },
      {
        "type": "path",
        "path": "/admin/*",
        "action": "deny"
      },

      // Rate limiting
      {
        "type": "path",
        "path": "/api/auth/*",
        "rateLimit": { "requests": 10, "window": 60 }
      },

      // Block suspicious IPs
      {
        "type": "ip",
        "action": "deny",
        "ip": ["known-bad-ip"]
      }
    ],

    "botProtection": {
      "enabled": true,
      "mode": "challenge",
      "allowedBots": ["googlebot", "bingbot"]
    }
  },

  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "X-Frame-Options", "value": "DENY" },
        { "key": "X-Content-Type-Options", "value": "nosniff" }
      ]
    }
  ]
}
```

---

### Part 9: Analyze Attack Patterns

**Scenario:** You see these logs:

```
10:00:00 - 192.168.1.50 - POST /api/login - 5 requests
10:00:01 - 192.168.1.50 - POST /api/login - 15 requests
10:00:02 - 192.168.1.50 - POST /api/login - 50 requests
10:00:03 - 192.168.1.50 - POST /api/login - 100 requests
```

**Questions:**

1. What type of attack is this? \_\_\_

2. What rule would stop it? \_\_\_

3. Write the firewall rule:

```json
{
  "firewall": {
    "rules": [
      // Your answer
    ]
  }
}
```

---

### Part 10: Security Audit Checklist

**Review your deployment for:**

| Check                            | Status |
| -------------------------------- | ------ |
| HTTPS enforced?                  | ☐      |
| Rate limiting on auth endpoints? | ☐      |
| Admin routes protected?          | ☐      |
| Bot protection enabled?          | ☐      |
| Security headers configured?     | ☐      |
| Known bad IPs blocked?           | ☐      |
| Sensitive env vars secured?      | ☐      |

---

### What You Learned

✓ Configuring Vercel WAF rules
✓ Blocking and allowlisting IPs
✓ Setting up rate limiting
✓ Enabling bot protection
✓ Adding security headers

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-B, 4-B, 5-B

Part 3:

1. Rules are evaluated in order; first match wins
2. They are denied access
3. Add VPN IP to the ip array in the allow rule

Part 4:

- /api/login: 5 requests per 60 seconds
- /api/register: 3 requests per 300 seconds
- /api/users: 100 requests per 60 seconds (matches /api/\*)
- /api/data: 100 requests per 60 seconds (matches /api/\*)

Part 5:

1. Challenge shows CAPTCHA; block immediately denies
2. For SEO - Google needs to crawl the site
3. Internal tools or APIs with no public access needed

Part 6 (Philippines-only):

```json
{
  "firewall": {
    "rules": [
      { "type": "geo", "action": "allow", "country": ["PH"] },
      { "type": "default", "action": "deny" }
    ]
  }
}
```

Part 7:

- X-Frame-Options: B (Prevents embedding)
- X-Content-Type-Options: C (Prevents MIME sniffing)
- Referrer-Policy: D (Controls referrer info)
- Permissions-Policy: A (Controls browser features)

Part 9:

1. Brute force attack on login
2. Rate limiting on /api/login
3. `{ "type": "path", "path": "/api/login", "rateLimit": { "requests": 5, "window": 60 } }`
