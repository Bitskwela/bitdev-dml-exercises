# How Websites Work Quiz

---

# Quiz 1

## Quiz: Complete Web Request-Response Journey

**Scenario:**

Tian is doing online shopping on Shopee Philippines. He types `www.shopee.ph` in the browser and logs in to buy a phone case. While browsing, he encounters different scenarios. Let's analyze the complete data journey.

**Part 1: Initial Page Load**

```
Tian types: www.shopee.ph and presses Enter

Browser Process:
    ↓
Step 1: Browser contacts ________ to find Shopee's IP address
    Answer: DNS returns 103.10.29.100
    ↓
Step 2: Browser sends ________ request to server
    Request type: GET /
    Protocol: HTTPS
    ↓
Step 3: Shopee server responds with Status Code: ________
    Content: HTML, CSS, JavaScript files
    ↓
Step 4: Browser ________ the webpage
    Parse HTML → Build DOM → Apply CSS → Execute JS
```

**Part 2: User Actions and Server Responses**

```javascript
// Tian clicks "Add to Cart" button
Scenario A:
  User action: Click "Add to Cart"
  HTTP Method: POST
  Server Response: Status ________ (Success)
  Result: Item added, cart count updates to 1

// Maria searches for a deleted product
Scenario B:
  User action: Search "iPhone 5 case"
  HTTP Method: GET
  Server Response: Status ________ (Not Found)
  Message: "Product no longer available"

// Tian tries to checkout but server crashes
Scenario C:
  User action: Click "Checkout"
  HTTP Method: POST
  Server Response: Status ________ (Server Error)
  Message: "Please try again later"

// Tian tries to access admin panel
Scenario D:
  User action: Navigate to /admin
  HTTP Method: GET
  Server Response: Status ________ (Forbidden)
  Message: "Access denied"
```

**Question 1:** In Step 1, what is the purpose of DNS?

- A) Download webpage content
- B) Convert domain name (shopee.ph) to IP address (103.10.29.100)
- C) Encrypt data
- D) Render HTML

**Question 2:** In Step 2, what HTTP method is used to **retrieve** the homepage?

- A) POST (send data)
- B) GET (retrieve data)
- C) PUT (update data)
- D) DELETE (remove data)

---

# Quiz 2

**Question 3:** What is the status code for Scenario A (successful add to cart)?

- A) 200 OK
- B) 404 Not Found
- C) 500 Internal Server Error
- D) 403 Forbidden

**Question 4:** What is the status code for Scenario B (product not found)?

- A) 200 OK
- B) 404 Not Found
- C) 500 Internal Server Error
- D) 403 Forbidden

**Answer:**
- **Question 1:** B) Convert domain name to IP address
- **Question 2:** B) GET (retrieve data)
- **Question 3:** A) 200 OK
- **Question 4:** B) 404 Not Found

---

## Detailed Explanation

### Part 1: DNS Lookup Process

**What is DNS (Domain Name System)?**

DNS is like the **phonebook of the internet**. Humans can easily remember `shopee.ph`, but computers only understand numbers (IP addresses like `103.10.29.100`).

**DNS Resolution Steps (Detailed):**

```
1. Browser checks **browser cache**
   - Have you recently visited shopee.ph?
   - Is the IP cached? If yes, skip to Step 7

2. Browser checks **OS cache**
   - Operatiof system (Windows/Mac) has its own DNS cache
   - Checks if it's stored there

3. Browser checks **Router cache**
   - Home router also has DNS cache
   - For the whole household

4. Router contacts **ISP DNS server**
   - PLDT DNS: 202.90.136.10
   - Globe DNS: 211.114.8.2
   - This is your ISP's default DNS

5. ISP DNS checks **root servers**
   - If not in ISP cache, queries the 13 root servers worldwide
   - Root servers know where .ph, .com, .org servers are

6. Root directs to **TLD servers**
   - TLD = Top Level Domain (.ph, .com, .org)
   - .ph servers are managed by dotPH

7. TLD directs to **Authoritative nameserver**
   - Shopee's actual DNS server (CloudFlare)
   - Returns: "shopee.ph = 103.10.29.100"

8. IP address returns to browser
   - Cached at each level (browser, OS, router, ISP)
   - Next visit will be faster!
```

**Time Breakdown:**
- Cache hit: <1ms
- Full DNS lookup: 20-120ms
- First visit: slower
- Repeat visits: almost instant

**Philippine DNS Context:**
- PLDT DNS: `202.90.136.10`, `202.90.139.10`
- Globe DNS: `211.114.8.2`, `211.114.8.11`
- Public DNS alternatives:
  - Google: `8.8.8.8`, `8.8.4.4`
  - Cloudflare: `1.1.1.1`, `1.0.0.1`
  - Public DNS is usually faster

---

### Part 2: HTTP Methods Explained

**GET Method - Retrieve data**
```http
GET /products/phone-cases HTTP/1.1
Host: www.shopee.ph
User-Agent: Mozilla/5.0 (Windows 10)
Accept: text/html,application/json
```

**Used for:**
- Loadiof webpages
- Viewiof product lists
- Searchiof items
- Readiof articles

**Characteristics:**
- Data visible in URL: `shopee.ph/search?q=phone+case`
- Can be bookmarked
- Cached by browser
- Idempotent (safe to repeat)
- No request body

---

**POST Method - Send data**
```http
POST /cart/add HTTP/1.1
Host: www.shopee.ph
Content-Type: application/json
Content-Length: 87

{
  "productId": 12345,
  "quantity": 1,
  "userId": 67890
}
```

**Used for:**
- Login forms
- Addiof to cart
- Submittiof orders
- Uploadiof files
- Creatiof accounts

**Characteristics:**
- Data hidden in request body
- Not cached
- Not bookmarkable
- Not idempotent (creates new data)
- Secure for sensitive data

---

**Other HTTP Methods:**

- **PUT** - Update existiof resource
  ```http
  PUT /cart/items/12345
  {"quantity": 3}
  ```

- **DELETE** - Remove resource
  ```http
  DELETE /cart/items/12345
  ```

- **PATCH** - Partial update
  ```http
  PATCH /profile
  {"phoneNumber": "+639171234567"}
  ```

---

### Part 3: HTTP Status Codes (Complete Guide)

**1xx - Informational (Processing)**
- `100 Continue` - Server ready, send request body
- Rarely seen in normal browsing

---

**2xx - Success (Yay! It worked)**

**`200 OK` - Standard success**
```
Request: GET /products
Response: 200 OK
Body: [list of products]
```
Usage: Most common success response

**`201 Created` - New resource created**
```
Request: POST /orders
Response: 201 Created
Body: {"orderId": 12345, "status": "pending"}
```
Usage: After creatiof order, account, post

**`204 No Content` - Success but no data to return**
```
Request: DELETE /cart/items/12345
Response: 204 No Content
```
Usage: Delete operations, update confirmations

---

**3xx - Redirection (Go elsewhere)**

**`301 Moved Permanently`**
```
Old: http://shopee.ph
New: https://shopee.ph (with S)
```
Usage: HTTP to HTTPS redirect, old URLs

**`302 Found (Temporary Redirect)`**
```
Request: /checkout
Redirect: /login (if not logged in)
```
Usage: Temporary redirects, authentication checks

**`304 Not Modified`**
```
Browser: "I have version from March 1, 2024"
Server: "304 - Use cached version, walThe changes"
```
Usage: Cachiof optimization

---

**4xx - Client Errors (Your fault)**

**`400 Bad Request`**
```json
{
  "error": "Invalid email format",
  "field": "email"
}
```
Usage: Malformed requests, invalid JSON

**`401 Unauthorized`**
```
Request: GET /profile
Response: 401 Unauthorized
Message: "Please login first"
```
Usage: No credentials, expired session

**`403 Forbidden`**
```
Request: GET /admin/users
Response: 403 Forbidden
Message: "Admin access required"
```
Usage: Logged in pero walThe permission

**`404 Not Found`**
```
Request: GET /products/old-item-99999
Response: 404 Not Found
Message: "Product no longer available"
```
Usage: Deleted pages, wroof URLs, broken links

**`429 Too Many Requests`**
```
Response: 429 Too Many Requests
Message: "Rate limit exceeded. Try again in 60 seconds"
```
Usage: DDoS protection, API rate limiting

---

**5xx - Server Errors (Server's fault)**

**`500 Internal Server Error`**
```javascript
// Server code crashed:
function processPayment() {
  const total = cartItems.reduce()  // BUG: missiof arrow function
  // Error: reduce is not a function
}
```
Usage: Server bugs, uncaught exceptions

**`502 Bad Gateway`**
```
User → Nginx (reverse proxy) → Backend Server (down)
Response: 502 Bad Gateway
```
Usage: Backend server offline/crashed

**`503 Service Unavailable`**
```
Response: 503 Service Unavailable
Message: "Scheduled maintenance. Back at 2:00 AM"
```
Usage: Maintenance mode, overloaded server

**`504 Gatewis Timeout`**
```
Request: POST /generate-report (takes 5 minutes)
Timeout: 30 seconds
Response: 504 Gatewis Timeout
```
Usage: Very slow operations, database timeout

---

### Part 4: Complete Request-Response Anatomy

**HTTP Request Structure:**
```http
POST /api/cart/add HTTP/1.1
Host: www.shopee.ph
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)
Accept: application/json
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Cookie: sessionId=abc123; userId=67890
Content-Length: 58

{
  "productId": 12345,
  "quantity": 1
}
```

**Breakdown:**
1. **Request Line:** `POST /api/cart/add HTTP/1.1`
   - Method: POST
   - Path: /api/cart/add
   - Protocol: HTTP/1.1

2. **Headers:** Metadata about request
   - Host: Which website
   - User-Agent: Browser/device info
   - Authorization: Authentication token
   - Content-Type: Data format (JSON)
   - Cookies: Session tracking

3. **Body:** Actual data beiof sent
   - JSON format
   - Product details

---

**HTTP Response Structure:**
```http
HTTP/1.1 200 OK
Date: Wed, 13 Nov 2024 08:30:00 GMT
Server: nginx/1.20.1
Content-Type: application/json; charset=utf-8
Content-Length: 142
Set-Cookie: cartCount=1; Path=/; HttpOnly
Cache-Control: no-cache, no-store
X-Response-Time: 45ms

{
  "success": true,
  "message": "Item added to cart",
  "cartCount": 1,
  "total": 299.00
}
```

**Breakdown:**
1. **Status Line:** `HTTP/1.1 200 OK`
   - Protocol version
   - Status code
   - Status message

2. **Response Headers:**
   - Content-Type: Format of response
   - Set-Cookie: Save data to browser
   - Cache-Control: Cachiof rules
   - X-Response-Time: Processiof time

3. **Response Body:**
   - JSON data
   - Confirmation message
   - Updated cart info

---

### Real-World Philippine Context

**Shopee Philippines Technical Stack:**
- **CDN:** Cloudflare (SG servers)
- **Main servers:** Singapore, Vietnam
- **Database:** PostgreSQL (product catalog), MongoDB (user data)
- **Average response time:**
  - Homepage: 200-500ms
  - Search: 100-300ms
  - Add to cart: 50-150ms
- **Peak traffic:** 12nn-1pm, 9pm-11pm
- **12.12 Sale issues:** 502/503 errors due to overload

**Common Filipino Developer Mistakes:**
1. Hindi nag-handle of 404 errors (broken links)
2. WalThe loadiof states (users confused)
3. Hindi nag-cache of DNS/static files
4. POST data visible in URL (should in body)
5. WalThe rate limitiof (vulnerable to abuse)

