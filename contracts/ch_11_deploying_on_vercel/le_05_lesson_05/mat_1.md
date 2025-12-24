# Le 05: Custom Domain Setup

![Custom Domain](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/vercel-domain.png)

## Background Story

Neri's bakery website is live at `neris-bakery.vercel.app`. It works perfectly. But when Neri shows customers, they're confused.

"What's vercel?" one customer asks. "Is this really your bakery?"

"I want `nerisbakery.com`," Neri tells Maria. "Something people can remember. Something that looks professional."

A `.vercel.app` subdomain is great for development and learning. But for a real business, you need a custom domain—your own piece of internet real estate.

Maria researches domain registration, DNS configuration, SSL certificates. It sounds complicated. But with Vercel, connecting a custom domain takes about 10 minutes.

**Time Allotment**: 40 minutes

**Topics Covered**:

- Why custom domains matter
- Buying a domain
- Connecting domain to Vercel
- DNS configuration
- SSL/HTTPS setup
- Subdomain configuration

---

## Why Custom Domains Matter

### Professionalism

```
❌ neris-bakery.vercel.app
   "What's Vercel? Is this legit?"

✅ nerisbakery.com
   "This looks like a real business"
```

### Memorability

```
❌ "Visit my site at neris-bakery-xyz123.vercel.app"
❌ Customer: "What was that URL again?"

✅ "Visit nerisbakery.com"
✅ Customer: "Got it!"
```

### Brand Control

With a custom domain:

- You own the URL
- It works even if you change hosting
- Builds trust and credibility

## Step 1: Buy a Domain

### Where to Buy

Popular domain registrars:

| Registrar      | .com Price | Notes             |
| -------------- | ---------- | ----------------- |
| Namecheap      | ~$10/year  | Budget-friendly   |
| Google Domains | ~$12/year  | Clean interface   |
| GoDaddy        | ~$12/year  | Lots of upselling |
| Cloudflare     | ~$9/year   | At-cost pricing   |

### Choosing a Domain

```
nerisbakery.com         ← Ideal if available
neris-bakery.com        ← With hyphen
nerisbakeryphl.com      ← With location
nerisbakeryph.com       ← Philippines extension
```

### The Purchase Process

1. Go to registrar (e.g., namecheap.com)
2. Search for your domain
3. Add to cart
4. Create account
5. Complete purchase
6. Domain is yours!

```
🎉 Congratulations!
You now own: nerisbakery.com
Expires: December 2025
```

## Step 2: Add Domain to Vercel

### Via Dashboard

1. Go to [vercel.com/dashboard](https://vercel.com/dashboard)
2. Select your project (neris-bakery)
3. Go to Settings → Domains
4. Click "Add Domain"
5. Enter your domain: `nerisbakery.com`
6. Click "Add"

### Via CLI

```bash
vercel domains add nerisbakery.com
```

Vercel shows DNS configuration instructions.

## Step 3: Configure DNS

Vercel provides two configuration options:

### Option A: Vercel Nameservers (Recommended)

Transfer DNS control to Vercel for automatic configuration.

At your registrar:

1. Find "Nameservers" or "DNS Settings"
2. Change nameservers to:
   ```
   ns1.vercel-dns.com
   ns2.vercel-dns.com
   ```
3. Save changes

Wait 24-48 hours for propagation (usually faster).

### Option B: Add DNS Records

Keep your current DNS provider, add records manually.

```
Type: A
Name: @
Value: 76.76.21.21

Type: CNAME
Name: www
Value: cname.vercel-dns.com
```

| Record Type | Name | Value                |
| ----------- | ---- | -------------------- |
| A           | @    | 76.76.21.21          |
| CNAME       | www  | cname.vercel-dns.com |

## Step 4: Verify Configuration

Back in Vercel:

1. Go to Settings → Domains
2. Check domain status

```
nerisbakery.com        ✅ Valid Configuration
www.nerisbakery.com    ✅ Valid Configuration
```

If you see warnings, DNS hasn't propagated yet. Wait and refresh.

### Check DNS Propagation

```bash
# Check DNS records
dig nerisbakery.com

# Or use online tools:
# https://dnschecker.org
```

## Step 5: SSL Certificate (Automatic!)

Vercel automatically:

1. Detects your domain is configured
2. Requests SSL certificate from Let's Encrypt
3. Installs and renews it

```
🔒 https://nerisbakery.com
   SSL Certificate: Valid
   Issued by: Let's Encrypt
   Auto-renews: Yes
```

You get HTTPS for free, automatically. No configuration needed.

## Domain Configuration Options

### Root Domain vs WWW

```
nerisbakery.com       ← Root domain (apex)
www.nerisbakery.com   ← WWW subdomain
```

Best practice: Add both and redirect one to the other.

In Vercel Settings → Domains:

```
nerisbakery.com       ✅ Primary
www.nerisbakery.com   ↪️ Redirects to nerisbakery.com
```

### Subdomains

Add subdomains for different purposes:

```
nerisbakery.com           ← Main site
blog.nerisbakery.com      ← Blog
menu.nerisbakery.com      ← Menu page
order.nerisbakery.com     ← Ordering system
```

Add each subdomain in Vercel:

1. Settings → Domains → Add Domain
2. Enter: `blog.nerisbakery.com`
3. Add DNS record at registrar:
   ```
   Type: CNAME
   Name: blog
   Value: cname.vercel-dns.com
   ```

## Multiple Domains

You can point multiple domains to the same project:

```
nerisbakery.com          ← Primary
nerisbakery.ph           ← Philippines TLD
neri-bakery.com          ← Alternative spelling
```

Configure redirects so one is primary:

```json
// vercel.json
{
  "redirects": [
    {
      "source": "/:path*",
      "destination": "https://nerisbakery.com/:path*",
      "has": [
        {
          "type": "host",
          "value": "neri-bakery.com"
        }
      ],
      "permanent": true
    }
  ]
}
```

## Environment-Specific Domains

Different domains for different environments:

```
Production:
  nerisbakery.com → main branch

Staging:
  staging.nerisbakery.com → develop branch

Preview:
  *.vercel.app → feature branches
```

Configure in Settings → Domains → Production/Preview settings.

## Troubleshooting

### Domain Not Resolving

```
Error: DNS_PROBE_FINISHED_NXDOMAIN
```

**Solution:** DNS hasn't propagated. Wait 24-48 hours.

### SSL Certificate Error

```
Error: SSL certificate not valid
```

**Solution:** Ensure domain points to Vercel. Certificate auto-generates.

### Wrong Site Loading

**Solution:** Check which project the domain is attached to in Vercel.

### Redirect Loop

```
Error: Too many redirects
```

**Solution:** Check for conflicting redirects in vercel.json and registrar settings.

## Domain Cost Considerations

### Registration Costs

```
.com: $10-15/year
.ph: $30-50/year (Philippines)
.io: $30-50/year (Tech-focused)
.dev: $15-20/year (Developer)
```

### Free Alternatives

If you're learning and don't want to buy:

```
yourname.vercel.app     ← Always free
project.vercel.app      ← Always free
```

Buy a domain when you're ready for production.

## Why This Matters: Beyond the Islands

With a custom domain:

**Local Impact:**

- `nerisbakery.com` looks professional to San Juan customers
- Easy to print on business cards and flyers
- Builds trust in the community

**Global Reach:**

- International tourists can find and remember the URL
- Food bloggers can link with a professional domain
- Franchise partners see a legitimate business

The domain is your address on the internet. Just like a physical address matters for a brick-and-mortar store, a digital address matters for an online presence.

## Key Takeaways

✓ Custom domains add professionalism and trust
✓ Buy domains from registrars (~$10-15/year)
✓ Connect to Vercel via nameservers or DNS records
✓ SSL certificates are automatic and free
✓ Configure www redirect for consistency
✓ Add subdomains for different purposes
✓ Multiple domains can point to one project

**Next Lesson:** Deploying React applications—modern JavaScript in production!
