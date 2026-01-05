# Custom Domain Activity

Maria's dashboard is live at `barangay-dashboard-abc123.vercel.app`, but Neri wants something more professional. "Can we get `barangay-dashboard.ph`?" she asks. In this activity, you'll learn how to connect a custom domain to your Vercel deployment.

## Task for Students

### Part 1: Domain Concepts Quiz

Answer the following questions about DNS and custom domains:

**Question 1:** What does DNS stand for?

- A) Domain Name System
- B) Digital Network Service
- C) Data Name Server
- D) Domain Network System

**Question 2:** Which DNS record type points a domain directly to an IP address?

- A) CNAME
- B) MX
- C) A Record
- D) TXT

**Question 3:** Which DNS record type creates an alias from one domain to another?

- A) A Record
- B) CNAME
- C) NS
- D) PTR

**Question 4:** What does SSL provide for your website?

- A) Faster loading
- B) Encrypted connection (https://)
- C) Better SEO
- D) All of the above

**Question 5:** How long can DNS propagation take?

- A) Instant
- B) Up to 24-48 hours
- C) One week
- D) One month

---

### Part 2: Configuration Walkthrough

Even if you don't have a custom domain yet, follow these steps to understand the process:

**Step 1: Access Domain Settings**

1. Go to your Vercel dashboard
2. Select your project
3. Click "Settings" → "Domains"
4. Note the current `.vercel.app` subdomain

**Step 2: Add a Custom Domain (Simulation)**

1. Click "Add Domain"
2. Enter a domain name (e.g., `myproject.com`)
3. Vercel displays the required DNS records:
   - **A Record**: `76.76.21.21` (Vercel's IP)
   - **CNAME**: `cname.vercel-dns.com`

**Step 3: Where to Configure DNS**
If you had a real domain, you would go to your domain registrar:

- Namecheap → Domain List → Manage → Advanced DNS
- GoDaddy → DNS Management
- Google Domains → DNS Settings
- Cloudflare → DNS

**Step 4: DNS Record Configuration**
For a root domain (`example.com`):

```
Type: A
Host: @
Value: 76.76.21.21
```

For a subdomain (`www.example.com`):

```
Type: CNAME
Host: www
Value: cname.vercel-dns.com
```

---

### Part 3: Verification Checklist

When your domain is properly connected, verify:

- [ ] Vercel shows "Valid Configuration" next to your domain
- [ ] The SSL certificate shows "Issued" (lock icon)
- [ ] Visiting `http://yourdomain.com` redirects to `https://`
- [ ] Both `yourdomain.com` and `www.yourdomain.com` work
- [ ] The site loads correctly (not a Vercel error page)

---

### Part 4: Troubleshooting Quiz

**Question 1:** Your domain shows "Pending Verification" for over an hour. What should you check first?

- A) Clear your browser cache
- B) Verify DNS records are correct at your registrar
- C) Restart your computer
- D) Delete and re-add the domain

**Question 2:** Your site works but shows "Not Secure" in the browser. What's the issue?

- A) DNS not configured
- B) SSL certificate not yet issued
- C) Wrong IP address
- D) Vercel is down

---

### What You Learned

✓ DNS translates domain names to IP addresses
✓ A Records point to IP addresses; CNAMEs create aliases
✓ Vercel automatically provisions SSL certificates
✓ DNS propagation can take up to 48 hours
✓ Both root domain and www subdomain should be configured

---

**Instructor Answers:**

Part 1: 1-A, 2-C, 3-B, 4-D, 5-B

Part 4: 1-B, 2-B
