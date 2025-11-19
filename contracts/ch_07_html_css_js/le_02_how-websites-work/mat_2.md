````markdown
# Lesson 2: How Websites Work

## Background Story

After understanding the Internet, Tian asked Kuya Miguel, "So now that I know how everything is connected, how do websites actually work? Why is it that when I type Facebook.com, the page appears?"

"Great question!" said Kuya Miguel. "Let me show you the **client-server model** and the whole process from typing a URL to seeing the webpage. This is fundamental that you need to understand!"

## The Client-Server Model

### What is Client-Server Architecture?

The **client-server model** is the foundation of how the web works. It's a two-way communication system:

- **Client** = Your device (computer, phone, tablet) with a browser
- **Server** = A powerful computer somewhere that stores website files

**Simple analogy:** Think of it like ordering food at a restaurant:
- **You (Client)** = Customer who makes requests
- **Waiter** = The Internet (delivers your request)
- **Kitchen (Server)** = Prepares what you ordered
- **Food delivered back** = The webpage shown to you

### The Request-Response Cycle

Every time you visit a website, this happens:

```
1. CLIENT (You) → types URL → BROWSER
2. BROWSER → sends REQUEST → INTERNET
3. INTERNET → routes request → SERVER
4. SERVER → processes request → finds files
5. SERVER → sends RESPONSE → back through INTERNET
6. BROWSER → receives files → RENDERS webpage
```

This cycle happens in **milliseconds** for most websites!

## What Happens When You Type a URL?

Let's break down what happens when you type `www.facebook.com` and press Enter:

### Step 1: URL Parsing

**URL (Uniform Resource Locator)** structure:
```
https://www.facebook.com/profile/user123
│      │   │            │    │
│      │   │            │    └─ Path (specific page)
│      │   │            └────── Domain name
│      │   └─────────────────── Subdomain (www)
│      └─────────────────────── Top-level domain (.com)
└────────────────────────────── Protocol (https)
```

Your browser reads and understands each part.

### Step 2: DNS Lookup (Domain Name System)

**The Problem:** Computers don't understand "facebook.com" — they only understand IP addresses (like `157.240.2.35`)

**DNS (Domain Name System)** = The phonebook of the Internet

**What happens:**
1. Browser checks if it already knows Facebook's IP (cache)
2. If not, it asks your DNS server (usually your ISP's DNS)
3. DNS server looks up "facebook.com" → finds IP address `157.240.2.35`
4. DNS returns the IP address to your browser

**Analogy:** It's like looking up someone's phone number in a phonebook. You know their name (facebook.com), but you need their number (IP address) to call them.

**Time:** 20-120 milliseconds

### Step 3: TCP Connection (Handshake)

Before sending your request, your browser establishes a connection with the server using **TCP/IP protocol**.

This is called the **TCP 3-way handshake**:

```
1. CLIENT: "Hi, can I connect?" (SYN)
2. SERVER: "Yes, you can!" (SYN-ACK)
3. CLIENT: "Great, I'm ready!" (ACK)
```

Now the connection is established and secure.

**Time:** 50-150 milliseconds

### Step 4: HTTP/HTTPS Request

Your browser sends an **HTTP Request** to the server.

**Example HTTP Request:**
```
GET /index.html HTTP/1.1
Host: www.facebook.com
User-Agent: Mozilla/5.0 (Chrome)
Accept: text/html
Accept-Language: en-US, tl
```

**Key parts:**
- **GET** = Request method (I want to GET/retrieve something)
- **/index.html** = What file I want
- **Host** = Which website
- **User-Agent** = What browser I'm using
- **Accept** = What types of files I can handle

**Other request methods:**
- **POST** = Send data to server (like submitting a form)
- **PUT** = Update existing data
- **DELETE** = Remove data
- **PATCH** = Partially update data

**Time:** 1-5 milliseconds to send

### Step 5: Server Processing

The **server** receives your request and:

1. **Reads the request** — What does the client want?
2. **Finds the files** — Locates HTML, CSS, JS, images
3. **Processes logic** — If needed (e.g., check if user is logged in, fetch data from database)
4. **Prepares response** — Bundles everything together

For simple static websites: Very fast (10-50ms)  
For complex dynamic websites (like Facebook): Can take longer (100-500ms)

### Step 6: HTTP Response

The server sends back an **HTTP Response**.

**Example HTTP Response:**
```
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 1234
Date: Wed, 13 Nov 2024 10:30:00 GMT

<!DOCTYPE html>
<html>
<head>
  <title>Facebook</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <h1>Welcome to Facebook!</h1>
  ...
</body>
</html>
```

**Key parts:**
- **200 OK** = Success! (status code)
- **Content-Type** = What type of data (HTML, JSON, image, etc.)
- **Content-Length** = How big is the response
- **Body** = The actual HTML content

**HTTP Status Codes:**
- **200** = Success
- **301/302** = Redirect (moved to another URL)
- **400** = Bad request (client error)
- **401** = Unauthorized (need to log in)
- **403** = Forbidden (no permission)
- **404** = Not Found (page doesn't exist)
- **500** = Server Error (something broke on server)
- **503** = Service Unavailable (server is down)

**Time:** 50-500 milliseconds depending on file size and internet speed

### Step 7: Browser Rendering

Your browser receives the HTML and:

1. **Parses HTML** → Builds DOM (Document Object Model)
2. **Downloads CSS** → Parses and applies styles
3. **Downloads JavaScript** → Executes code
4. **Downloads Images** → Displays them
5. **Renders the page** → You see the final webpage!

(We'll learn more about this in Lesson 4: How Browsers Work)

**Time:** 100-3000 milliseconds (1-3 seconds) depending on page complexity

### Total Time

From typing URL to seeing the webpage:

- **Fast website:** 200-500 milliseconds (less than 1 second)
- **Average website:** 1-3 seconds
- **Slow website:** 5-10+ seconds (bad internet or poor optimization)

In the Philippines with typical home internet: 2-5 seconds average

## Types of Websites

### 1. Static Websites

**Definition:** Websites where content doesn't change unless manually updated by a developer.

**Characteristics:**
- Same content for everyone
- No database needed
- Fast loading
- Simple to host

**Example:** Company "About Us" page, portfolios, documentation sites

**How it works:**
```
Client → Request → Server → Returns pre-made HTML file → Client displays
```

**Advantages:**
- Very fast
- Cheap hosting
- Secure (fewer attack vectors)
- Simple to deploy

**Disadvantages:**
- Can't personalize content
- No user accounts or interactions
- Must manually update content

### 2. Dynamic Websites

**Definition:** Websites where content changes based on user, time, data, or interactions.

**Characteristics:**
- Different content for different users
- Uses a database
- Server-side processing
- User authentication

**Examples:** Facebook, YouTube, Shopee, Gmail, online banking

**How it works:**
```
Client → Request → Server → Queries Database → Generates HTML → Returns to Client
```

**Advantages:**
- Personalized experiences
- User accounts and authentication
- Real-time updates
- Interactive features

**Disadvantages:**
- Slower (more processing)
- More expensive hosting
- More complex to build
- Security considerations

## Web Hosting: Where Websites Live

### What is Web Hosting?

**Web hosting** is the service of storing website files on a server connected to the internet 24/7.

**Analogy:** If your website is a store, web hosting is the land and building where your store is located.

### Types of Hosting

#### 1. Shared Hosting

**Description:** Your website shares server resources with many other websites.

**Philippine examples:** HostGator PH, Hosting.ph, Web.com.ph

**Price:** ₱100-500/month

**Best for:** Small personal websites, blogs, portfolios

**Pros:** Cheap, easy to use  
**Cons:** Slow if other sites use too much resources, limited control

#### 2. VPS (Virtual Private Server)

**Description:** You get a dedicated portion of a server.

**Price:** ₱1,000-5,000/month

**Best for:** Medium-sized businesses, growing websites

**Pros:** Better performance, more control  
**Cons:** More expensive, requires technical knowledge

#### 3. Dedicated Hosting

**Description:** You rent an entire physical server just for your website.

**Price:** ₱10,000+/month

**Best for:** Large companies, high-traffic websites

**Pros:** Maximum performance and control  
**Cons:** Very expensive, requires IT expertise

#### 4. Cloud Hosting

**Description:** Your website runs on multiple interconnected servers in the cloud.

**Examples:** AWS, Google Cloud, Microsoft Azure, DigitalOcean

**Price:** Pay-as-you-go (varies widely)

**Best for:** Scalable websites, startups, developers

**Pros:** Flexible, scalable, reliable  
**Cons:** Can get expensive, complex pricing

### Free Hosting Options (For Students)

1. **GitHub Pages** — Free hosting for static websites
2. **Netlify** — Free for small projects
3. **Vercel** — Free tier for frontend projects
4. **Render** — Free tier available
5. **Railway** — Free starter plan

Perfect for learning and personal projects!

## Domain Names

### What is a Domain Name?

Your website's address on the internet (e.g., `facebook.com`, `google.com`)

**Structure:**
```
www.example.com.ph
│   │       │   │
│   │       │   └─ Country code (.ph for Philippines)
│   │       └───── Top-level domain (.com)
│   └───────────── Second-level domain (your name)
└───────────────── Subdomain (optional)
```

### Popular Domain Extensions

- **.com** — Most common, commercial
- **.ph** — Philippines-specific
- **.net** — Network-related
- **.org** — Organizations
- **.edu.ph** — Philippine educational institutions
- **.gov.ph** — Philippine government
- **.io** — Popular for tech startups
- **.dev** — For developers

### Registering a Domain in the Philippines

**Philippine domain (.ph):**
- Register through **Dot.PH** (official .ph registry)
- Price: ₱500-2,000/year
- Requires Philippine presence (business or individual)

**International domains (.com, .net, etc.):**
- Registrars: GoDaddy, Namecheap, Google Domains
- Price: ₱500-1,500/year

**Free domain options (for students):**
- Use subdomain: `yourname.github.io` (GitHub Pages)
- Use subdomain: `yoursite.netlify.app` (Netlify)
- Register free .tk, .ml, .ga domains (Freenom) — but not recommended for professional use

## Security: HTTP vs HTTPS

### HTTP (HyperText Transfer Protocol)

**Description:** Original web protocol, data sent in plain text.

**Problem:** Anyone can intercept and read your data (passwords, credit cards, personal info).

**URL:** `http://example.com`

### HTTPS (HTTP Secure)

**Description:** Encrypted version of HTTP using SSL/TLS certificates.

**Security:** Data is encrypted — hackers can't read it even if intercepted.

**URL:** `https://example.com` (note the padlock icon in browser)

**Important:** NEVER enter sensitive information on HTTP sites!

### SSL/TLS Certificates

**SSL Certificate** = Digital certificate that proves website identity and enables HTTPS

**Where to get:**
- Free: Let's Encrypt (most popular)
- Paid: DigiCert, Sectigo, GoDaddy (₱2,000-20,000/year)

**Modern requirement:** Most hosting providers include free SSL certificates. Google Chrome now marks HTTP sites as "Not Secure."

## Real-World Philippine Context

### Philippine Internet Infrastructure

**Challenge:** Philippines ranks low in global internet speed rankings

**Average speed (2024):**
- Mobile: 25-35 Mbps
- Fixed broadband: 40-60 Mbps

Compare to:
- Singapore: 200+ Mbps
- South Korea: 150+ Mbps

**Why websites sometimes load slow:**
1. Server location (US/Europe servers vs local PH servers)
2. Submarine cable capacity
3. Last-mile infrastructure
4. ISP congestion during peak hours (6-11 PM)

### Content Delivery Networks (CDN)

**Problem:** Facebook's servers are in the US. Data takes longer to reach Philippines.

**Solution:** **CDN (Content Delivery Network)**

**How it works:**
- CDN stores copies of website files on servers worldwide
- When you access Facebook, you connect to nearest server (likely in Singapore or Hong Kong)
- Much faster!

**Popular CDNs:**
- Cloudflare (used by millions of sites)
- Amazon CloudFront
- Google Cloud CDN
- Fastly

**Impact:** Can reduce load time by 50-70% for Filipino users

### Local Philippine Hosting

**Advantages of PH-based hosting:**
- Faster for Filipino visitors
- Lower latency
- Sometimes cheaper than international
- Localized support (Tagalog customer service)

**Examples:**
- ServerFreak Philippines
- Web.com.ph
- Hosting.ph
- Cloudstaff

## Common Student Misconceptions

### WRONG: "The website lives in my computer"
**CORRECT:** The website lives on a server. Your browser just displays a copy.

### WRONG: "Closing the browser deletes the website"
**CORRECT:** The website stays on the server. Closing browser just closes your view of it.

### WRONG: "My website will work without hosting"
**CORRECT:** You need a server (hosting) for others to access your site on the internet. You can view HTML files locally (file:///), but no one else can access them.

### WRONG: "Domain and hosting are the same"
**CORRECT:**
- **Domain** = Your address (like street address)
- **Hosting** = Your land and building (where files are stored)
- You need BOTH for a public website

### WRONG: "HTTP and HTTPS are the same"
**CORRECT:** HTTPS is encrypted and secure. HTTP is not. Always use HTTPS, especially for sites with user login or payment.

## Summary

**How Websites Work:**
1. You type URL → Browser sends request
2. DNS converts domain to IP address
3. Browser establishes TCP connection
4. Browser sends HTTP request to server
5. Server processes and sends HTTP response
6. Browser renders HTML/CSS/JS into webpage

**Key Concepts:**
- **Client-Server Model** — Two-way communication
- **Static vs Dynamic** — Pre-made vs generated content
- **Web Hosting** — Where website files are stored
- **Domain Name** — Your website's address
- **HTTP vs HTTPS** — Unsecured vs secured connection
- **Status Codes** — 200 (success), 404 (not found), 500 (server error)

**Philippines Context:**
- Average load time: 2-5 seconds
- Use local hosting when possible
- CDNs improve performance significantly
- Free hosting options great for students (GitHub Pages, Netlify)

Next lesson: Let's explore the difference between Frontend and Backend — the two sides of web development!
````
