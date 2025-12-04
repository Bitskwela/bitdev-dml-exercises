# Lesson 2 Activities: How Websites Work

## Understanding Client-Server Architecture

Now that you understand the internet infrastructure, let's explore how websites actually load and communicate. These activities reveal the request-response cycle in action!

---

## Activity 1: Inspect HTTP Request-Response

**Goal:** See the actual HTTP communication using browser DevTools.

**Instructions:**
1. Open Chrome/Edge browser
2. Visit any website (e.g., `facebook.com`)
3. Press `F12` to open DevTools
4. Click **Network** tab
5. Refresh the page (`Ctrl+R`)
6. Click on the first request (usually the HTML document)
7. Examine **Headers**, **Response**, **Timing** tabs

**Questions to Answer:**
1. What is the **Request Method**? (GET, POST, etc.)
2. What is the **Status Code**? (200, 301, 404, etc.)
3. How long did the request take? (Check **Timing**)
4. What is the **Content-Type** of the response?
5. How many total requests were made to load the page?

**Screenshot Required:**
Take a screenshot showing the Network tab with all requests visible.

---

## Activity 2: Decode HTTP Status Codes

**Goal:** Understand what different status codes mean.

**Instructions:**
Test these URLs and record the status code:

1. `https://www.google.com` → Status: ____
2. `https://www.google.com/404pagenotfound` → Status: ____
3. `https://github.com/nonexistentrepo12345` → Status: ____
4. `http://httpstat.us/500` (intentional server error) → Status: ____
5. `http://httpstat.us/301` (redirect) → Status: ____

**Match Status Codes to Meanings:**

| Status Code | Meaning | When It Happens |
|-------------|---------|-----------------|
| 200 | | |
| 301 | | |
| 404 | | |
| 500 | | |
| 503 | | |

**Real-World Scenarios:**
- You visit a deleted Facebook post → Status: ____
- You try accessing admin panel without login → Status: ____
- Website server crashes → Status: ____

---

## Activity 3: DNS Lookup Race

**Goal:** Measure DNS resolution time for different websites.

**Instructions:**
Use online tool: `https://www.whatsmydns.net/dns-lookup` or Command Prompt

Test these domains and record DNS lookup time:

1. `google.com` → IP: ____ | Time: ____ ms
2. `facebook.com` → IP: ____ | Time: ____ ms
3. `deped.gov.ph` → IP: ____ | Time: ____ ms
4. `youtube.com` → IP: ____ | Time: ____ ms
5. Your school website (if applicable) → IP: ____ | Time: ____ ms

**Questions:**
1. Which website resolved fastest?
2. Which was slowest?
3. Why do some DNS lookups take longer?
4. What is DNS caching, and how does it help?

**Advanced:**
Run `nslookup` twice on the same domain. Is the second lookup faster? Why?

---

## Activity 4: Static vs Dynamic Website Comparison

**Goal:** Identify whether websites are static or dynamic.

**Classify these websites:**

| Website | Static or Dynamic? | Evidence |
|---------|-------------------|----------|
| Personal blog (no login) | | |
| Facebook | | |
| Wikipedia | | |
| Company "About Us" page | | |
| Gmail | | |
| Online shopping (Shopee) | | |
| Government info page | | |

**Evidence Checklist:**
- [ ] Has user accounts/login?
- [ ] Content changes per user?
- [ ] Has database?
- [ ] Real-time updates?
- [ ] User-generated content?

**Questions:**
1. Which type is easier to build?
2. Which type costs more to host?
3. Give 3 examples of static websites.
4. Give 3 examples of dynamic websites.

---

## Activity 5: Web Hosting Research

**Goal:** Understand where websites are stored.

**Research Task:**
Find 3 Philippine web hosting providers and compare:

| Provider | Shared Hosting Price | Features | Free Trial? |
|----------|---------------------|----------|-------------|
| | ₱____/month | | |
| | ₱____/month | | |
| | ₱____/month | | |

**Questions:**
1. What is the cheapest hosting option you found?
2. What's included in basic hosting (storage, bandwidth, etc.)?
3. What's the difference between shared hosting and VPS?
4. Why do some companies use cloud hosting (AWS, Google Cloud)?

**Free Hosting Options (for students):**
List 3 free hosting platforms suitable for learning:
1. __________ → Best for: __________
2. __________ → Best for: __________
3. __________ → Best for: __________

---

## Activity 6: Domain Name Investigation

**Goal:** Understand domain registration and pricing.

**Research Philippine domains:**

Visit domain registrars (e.g., GoDaddy, Namecheap, Dot.PH) and check prices:

| Domain Extension | Price per Year | Best For |
|-----------------|----------------|----------|
| .com | ₱____ | |
| .ph | ₱____ | |
| .com.ph | ₱____ | |
| .net | ₱____ | |
| .org | ₱____ | |

**Questions:**
1. Which domain extension is most popular globally?
2. Which is most popular in the Philippines?
3. Can anyone register a `.gov.ph` domain? Why or why not?
4. What happens if the domain name you want is taken?

**Activity:**
Check if your name is available as a domain:
- `yourname.com` → Available? ____
- `yourname.ph` → Available? ____

---

## Activity 7: Trace a Full Website Load

**Goal:** Document every step from typing URL to displaying page.

**Instructions:**
Create a flowchart or step-by-step list showing the complete journey:

**Starting Point:** User types `facebook.com` and presses Enter

**Your Documentation Should Include:**
1. URL parsing
2. DNS lookup
3. TCP connection
4. HTTP request
5. Server processing
6. HTTP response
7. Browser rendering

**For Each Step, Include:**
- What happens
- How long it typically takes (approximate)
- What could go wrong

**Example Format:**
```
Step 1: User types facebook.com
↓
Step 2: Browser checks DNS cache
- If cached: 0ms
- If not cached: 20-100ms lookup
↓
Step 3: ...
```

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: Expected Results

**Typical HTTP Request:**
- Request Method: `GET` (retrieving data)
- Status Code: `200 OK` (success)
- Time: 100-500ms (depends on connection)
- Content-Type: `text/html` (HTML document)
- Total Requests: 20-100+ (HTML, CSS, JS, images, fonts)

**Understanding Waterfall:**
First request: HTML document → Triggers additional requests for CSS/JS/images → All load in parallel (browser optimization)

## Activity 2: Status Code Answers

**Status Code Meanings:**

| Status Code | Meaning | When It Happens |
|-------------|---------|-----------------|
| 200 | OK - Success | Page loaded successfully |
| 301 | Moved Permanently | Page redirected to new URL |
| 404 | Not Found | Page doesn't exist |
| 500 | Server Error | Server crashed/error |
| 503 | Service Unavailable | Server down/maintenance |

**Real-World Scenarios:**
- Deleted Facebook post → **404 Not Found**
- Admin panel without login → **401 Unauthorized** or **403 Forbidden**
- Website server crashes → **500 Internal Server Error**

**Additional Codes:**
- 302: Temporary Redirect
- 400: Bad Request (client error)
- 429: Too Many Requests (rate limiting)

## Activity 3: DNS Lookup Results

**Typical Results (from Philippines):**
- `google.com` → `142.250.x.x` | ~20-50ms
- `facebook.com` → `157.240.x.x` | ~30-60ms
- `deped.gov.ph` → Varies | ~50-150ms
- `youtube.com` → `142.250.x.x` (Google-owned) | ~20-50ms

**Why Some Are Slower:**
- Server location (farther = slower)
- DNS server load
- Network routing complexity
- ISP DNS server performance

**DNS Caching:**
Second lookup is nearly instant (~1ms) because browser/OS cached the IP address. Cache typically lasts 1-24 hours.

## Activity 4: Static vs Dynamic Classification

| Website | Type | Evidence |
|---------|------|----------|
| Personal blog | Static | No login, same content for everyone |
| Facebook | Dynamic | User accounts, personalized feed, database |
| Wikipedia | Dynamic | User edits, database of articles |
| Company "About Us" | Static | Fixed information, no personalization |
| Gmail | Dynamic | Personal email accounts, real-time updates |
| Shopee | Dynamic | Shopping cart, user accounts, inventory |
| Government info page | Usually Static | Informational content only |

**Key Indicators:**
- **Static:** Same HTML served to everyone, no database needed
- **Dynamic:** Content generated based on user/data, requires database

## Activity 5: Philippine Hosting Options

**Typical Pricing (2024):**

**Shared Hosting:**
- Hosting.ph: ₱100-300/month
- Web.com.ph: ₱150-400/month
- ServerFreak PH: ₱200-500/month

**Features Included:**
- 1-10 GB storage
- Unlimited or limited bandwidth
- Email accounts
- SSL certificate (usually free)
- cPanel control panel

**Free Options for Students:**
1. **GitHub Pages** → Static websites, free SSL, custom domain support
2. **Netlify** → Modern web apps, free tier generous, CI/CD
3. **Vercel** → Frontend frameworks, free for personal projects
4. **Render** → Full-stack apps, free tier available
5. **Railway** → Databases + hosting, free starter plan

## Activity 6: Domain Pricing (2024 Philippine Context)

**Typical Prices:**
- `.com` → ₱600-800/year
- `.ph` → ₱800-2,000/year
- `.com.ph` → ₱800-1,500/year
- `.net` → ₱700-900/year
- `.org` → ₱700-900/year

**Domain Rules:**
- `.gov.ph` → Government only (requires proof)
- `.edu.ph` → Educational institutions only
- Anyone can register `.com`, `.net`, `.org`, `.ph`

**If Name Taken:**
- Try different extension (`.ph` instead of `.com`)
- Add prefix/suffix (`myname.com`, `theofficialname.com`)
- Use domain marketplace (buy from current owner, expensive)

## Activity 7: Complete Website Load Timeline

**Step-by-Step Breakdown:**

```
1. User types "facebook.com" + Enter (0ms)
   ↓
2. Browser checks URL cache (1ms)
   ↓
3. DNS Lookup (20-100ms)
   - Check browser cache
   - Check OS cache
   - Query DNS server
   - Return IP: 157.240.2.35
   ↓
4. TCP 3-way Handshake (50-150ms)
   - SYN →
   - ← SYN-ACK
   - ACK →
   Connection established
   ↓
5. TLS/SSL Handshake (50-200ms) [for HTTPS]
   - Certificate exchange
   - Encryption keys agreed
   ↓
6. HTTP Request sent (1-5ms)
   GET / HTTP/1.1
   Host: facebook.com
   ↓
7. Server Processing (50-300ms)
   - Route request
   - Check authentication
   - Query database
   - Generate HTML
   ↓
8. HTTP Response sent (10-100ms)
   200 OK
   Content-Type: text/html
   [HTML content]
   ↓
9. Browser Receives HTML (instant)
   ↓
10. Browser Parses HTML (10-50ms)
    - Identifies additional resources
    - CSS files
    - JavaScript files
    - Images, fonts
    ↓
11. Browser Requests Resources (parallel, 100-1000ms)
    - Multiple simultaneous requests
    - Downloads CSS, JS, images
    ↓
12. Browser Renders Page (100-500ms)
    - Construct DOM tree
    - Apply CSS styles
    - Execute JavaScript
    - Paint pixels on screen
    ↓
TOTAL TIME: 500ms - 3000ms (typical)
```

**What Could Go Wrong:**

| Step | Potential Issue | Result |
|------|----------------|--------|
| DNS Lookup | DNS server down | Cannot resolve domain |
| TCP Connection | Network congestion | Timeout error |
| TLS Handshake | Invalid SSL certificate | "Not Secure" warning |
| HTTP Request | Server down | 503 Service Unavailable |
| Server Processing | Database error | 500 Internal Server Error |
| Response | Large file size | Slow loading |
| Rendering | Heavy JavaScript | Page freezes/lag |

</details>

---

**Excellent work!** You've explored the complete client-server communication cycle. You understand HTTP, status codes, DNS, hosting, and the full website loading process!

**Next:** Frontend vs Backend—choosing your development path!
