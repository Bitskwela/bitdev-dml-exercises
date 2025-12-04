# Lesson 3 Activities: Frontend vs Backend

## Exploring Both Sides of Web Development

Understanding the difference between frontend and backend is crucial for choosing your development path. These activities help you experience both worlds!

---

## Activity 1: Frontend Technology Identification

**Goal:** Identify what makes a website's frontend.

**Instructions:**
Visit 5 different websites and analyze their frontend elements:

| Website | Visual Elements | Interactive Features | Technologies Spotted |
|---------|----------------|---------------------|---------------------|
| Facebook | | | |
| YouTube | | | |
| Shopee | | | |
| DepEd site | | | |
| Personal blog | | | |

**For each site, identify:**
- Navigation menu
- Buttons and forms
- Images and icons
- Animations/transitions
- Color scheme
- Responsive design (check on mobile view)

**Questions:**
1. Which website has the best visual design?
2. Which has the smoothest animations?
3. Which is most user-friendly?
4. Can you tell what frontend framework they might be using? (Hint: Check page source or use Wappalyzer extension)

---

## Activity 2: Backend Logic Scenarios

**Goal:** Identify where backend processing is needed.

**Analyze these scenarios—does it need backend?**

| Scenario | Frontend Only? | Backend Needed? | Why? |
|----------|----------------|----------------|------|
| Display "Hello World" text | | | |
| User login system | | | |
| Calculator (2+2=4) | | | |
| Show your name from database | | | |
| Change button color on click | | | |
| Save form data permanently | | | |
| Show current time | | | |
| Search through 1M products | | | |

**Questions:**
1. What tasks can frontend handle alone?
2. When do you absolutely need a backend?
3. Why can't passwords be stored in frontend code?
4. Can JavaScript alone power an entire website?

---

## Activity 3: Technology Stack Research

**Goal:** Research popular frontend and backend technologies.

**Create comparison tables:**

**Frontend Frameworks:**

| Framework | Created By | Used By | Learning Difficulty | Job Demand (PH) |
|-----------|-----------|---------|-------------------|-----------------|
| React | | | | |
| Vue.js | | | | |
| Angular | | | | |

**Backend Languages:**

| Language | Popular Frameworks | Used By | Learning Difficulty | Job Demand (PH) |
|----------|-------------------|---------|---------------------|-----------------|
| JavaScript (Node.js) | | | | |
| Python | | | | |
| PHP | | | | |
| Java | | | | |

**Research Sources:**
- StackOverflow Developer Survey
- GitHub trends
- Philippine job sites (JobStreet, LinkedIn)

---

## Activity 4: Inspect Frontend Code

**Goal:** See actual HTML, CSS, and JavaScript in action.

**Instructions:**
1. Visit any website (try `github.com`)
2. Right-click → **View Page Source** (or press `Ctrl+U`)
3. Find examples of:
   - HTML tags (`<div>`, `<button>`, `<img>`)
   - CSS code (look for `<style>` tags or `.css` files)
   - JavaScript code (`<script>` tags or `.js` files)

**Questions:**
1. How much of the code can you understand?
2. Can you find where colors are defined? (CSS)
3. Can you find button click handlers? (JavaScript)
4. Is the code readable or "minified" (compressed)?

**Try Editing:**
1. Open DevTools (F12)
2. Go to **Elements** tab
3. Double-click on text in the HTML
4. Edit it and see changes immediately!

*Note: Changes are temporary—refresh to restore.*

---

## Activity 5: Backend API Exploration

**Goal:** See how frontend communicates with backend.

**Instructions:**
1. Open DevTools (F12) on any dynamic site (Facebook, Twitter, etc.)
2. Go to **Network** tab
3. Filter by **XHR** or **Fetch** (API calls)
4. Scroll through the page or click buttons
5. Watch API requests appear in real-time

**Record API Calls:**

| API Endpoint | Method | Response Type | Data Returned |
|--------------|--------|---------------|---------------|
| /api/users/me | | | |
| /api/posts | | | |
| /api/notifications | | | |

**Questions:**
1. What format is data returned in? (Hint: Usually JSON)
2. Can you see authentication tokens in headers?
3. What HTTP methods are used? (GET, POST, PUT, DELETE?)
4. How fast are the responses? (Check timing)

---

## Activity 6: Career Path Decision

**Goal:** Reflect on your interests and choose a specialization direction.

**Self-Assessment Quiz:**

Rate your interest (1-5, 5=most interested):

| Skill/Interest | Rating |
|----------------|--------|
| Visual design and aesthetics | __/5 |
| User experience and usability | __/5 |
| Animations and interactions | __/5 |
| Logic and problem-solving | __/5 |
| Databases and data structures | __/5 |
| Security and authentication | __/5 |
| Math and algorithms | __/5 |
| Making things look beautiful | __/5 |
| Making things work efficiently | __/5 |

**Interpretation:**
- **Frontend-leaning:** High scores on visual, UX, animations, aesthetics
- **Backend-leaning:** High scores on logic, databases, security, algorithms
- **Fullstack:** Balanced scores across all categories

**Reflection Questions:**
1. Based on your scores, which path interests you more?
2. Do you prefer seeing immediate visual results or solving complex logic?
3. Are you comfortable not understanding the "other side" initially?
4. Would you eventually want to learn both (fullstack)?

---

## Activity 7: Build a Mini Project Comparison

**Goal:** Experience both frontend and backend work.

**Part A: Frontend-Only Task**

Create a simple HTML page with:
- A heading
- A button
- JavaScript that changes text when button is clicked

```html
<!DOCTYPE html>
<html>
<head>
    <title>Frontend Demo</title>
</head>
<body>
    <h1 id="message">Hello!</h1>
    <button onclick="changeMessage()">Click Me</button>
    
    <script>
        function changeMessage() {
            document.getElementById('message').innerText = 'Button clicked!';
        }
    </script>
</body>
</html>
```

**Part B: Backend Simulation**

Imagine you need to:
1. Check if username is already taken (requires database query)
2. Hash a password securely
3. Send confirmation email
4. Store user data permanently

**Questions:**
1. Can Part A's JavaScript do any of Part B's tasks permanently?
2. Why do we need a server for Part B?
3. Where would you store millions of user accounts?
4. How does frontend "talk" to backend to check username availability?

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: Frontend Analysis

**Typical Findings:**

**Facebook:**
- Visual: Blue theme, card layouts, news feed
- Interactive: Like button, comment forms, infinite scroll
- Tech: React (likely), CSS-in-JS, responsive design

**YouTube:**
- Visual: Video grid, thumbnails, clean layout
- Interactive: Video player, autoplay, recommended sidebar
- Tech: Polymer (custom), Material Design

**Shopee:**
- Visual: Product cards, orange theme, banners
- Interactive: Add to cart, filters, search
- Tech: Vue.js or React, mobile-first design

**Best Practices Observed:**
- Consistent color scheme
- Clear navigation
- Fast loading times
- Mobile responsiveness
- Intuitive button placement

## Activity 2: Backend Requirements

| Scenario | Frontend Only? | Backend Needed? | Explanation |
|----------|---------------|----------------|-------------|
| Display "Hello World" | ✅ Yes | ❌ No | Static text, no data processing |
| User login | ❌ No | ✅ Yes | Need to verify against database |
| Calculator (2+2=4) | ✅ Yes | ❌ No | Simple math, no storage needed |
| Show name from database | ❌ No | ✅ Yes | Data must be fetched from server |
| Change button color | ✅ Yes | ❌ No | Pure CSS/JS, no data persistence |
| Save form data permanently | ❌ No | ✅ Yes | Need database to store |
| Show current time | ✅ Yes | ❌ No | JavaScript `Date()` works |
| Search 1M products | ❌ No | ✅ Yes | Need database indexing, too much data for client |

**Key Principle:**
- Frontend = Display, interaction, temporary state
- Backend = Storage, security, heavy processing, business logic

## Activity 3: Technology Comparison

**Frontend Frameworks:**

| Framework | Created By | Used By | Difficulty | PH Demand |
|-----------|-----------|---------|-----------|-----------|
| React | Facebook/Meta | Facebook, Instagram, Netflix | Medium | ⭐⭐⭐⭐⭐ Highest |
| Vue.js | Evan You (indie) | Alibaba, GitLab | Easy | ⭐⭐⭐⭐ Growing |
| Angular | Google | Google, Microsoft | Hard | ⭐⭐⭐ Enterprise |

**Backend Languages/Frameworks:**

| Language | Frameworks | Used By | Difficulty | PH Demand |
|----------|-----------|---------|-----------|-----------|
| JavaScript (Node.js) | Express, NestJS | LinkedIn, Uber | Medium | ⭐⭐⭐⭐⭐ Highest |
| Python | Django, Flask | Instagram, Spotify | Easy | ⭐⭐⭐⭐ High |
| PHP | Laravel, WordPress | Facebook (legacy), WordPress | Easy | ⭐⭐⭐⭐ Still high |
| Java | Spring | Banks, enterprises | Hard | ⭐⭐⭐ Enterprise |

**Philippine Market (2024):**
- **Most in-demand:** React + Node.js (MERN stack)
- **Easiest to start:** HTML/CSS/JS → Vue.js → Python/Flask
- **Best for freelancing:** React, WordPress (PHP)

## Activity 4: Code Inspection Findings

**Readable Code Example:**
```html
<div class="header">
  <h1>Welcome</h1>
  <button class="btn-primary">Click Me</button>
</div>
```

**Minified Code Example:**
```html
<div class="hdr"><h1>Welcome</h1><button class="btn-pri">Click</button></div>
```
Or even more compressed:
```javascript
function a(b){return b*2}// becomes: function a(b){return 2*b}
```

**Why Minification:**
- Smaller file size
- Faster download
- Harder to copy (slight obfuscation)
- Production sites almost always minified

**Developer Tip:**
- Use "Pretty Print" in DevTools to make minified code readable
- Look for `.min.js` or `.min.css` files = minified versions

## Activity 5: API Communication

**Common API Patterns:**

**GET Request (Fetch Data):**
```
GET /api/users/123
Response: { "id": 123, "name": "Juan", "email": "juan@example.com" }
```

**POST Request (Create Data):**
```
POST /api/posts
Body: { "title": "My Post", "content": "Hello world" }
Response: { "id": 456, "status": "created" }
```

**Data Format (JSON):**
```json
{
  "user": {
    "id": 123,
    "name": "Juan Dela Cruz",
    "posts": [
      { "id": 1, "title": "First Post" },
      { "id": 2, "title": "Second Post" }
    ]
  }
}
```

**Authentication:**
Usually in **Headers**:
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**Response Times:**
- Fast API: 20-100ms
- Average: 100-300ms
- Slow: 500ms+

## Activity 6: Career Path Guidance

**If you scored high on:**

**Frontend (Visual/UX):**
- Learn: HTML, CSS, JavaScript deeply
- Then: React or Vue.js
- Focus: Design systems, animations, responsive design
- Tools: Figma, CSS frameworks
- Career: Frontend Developer, UI Developer

**Backend (Logic/Data):**
- Learn: One backend language well (Python or Node.js)
- Then: Databases (SQL), APIs, authentication
- Focus: Algorithms, security, scalability
- Tools: Postman, Docker, databases
- Career: Backend Developer, API Developer

**Balanced (Fullstack):**
- Learn: Both frontend and backend
- Start with one, add the other
- Focus: End-to-end application development
- Tools: Full stack (React + Node.js, Django + Vue, etc.)
- Career: Fullstack Developer, Product Engineer

**Reality Check:**
- Many developers start with one and learn the other later
- Specialization often pays more than generalization
- But understanding both makes you better at either
- Philippine startups prefer fullstack, enterprises prefer specialists

## Activity 7: Project Comparison

**Part A Analysis:**
- Frontend-only task completed
- Changes are temporary (refresh = lost)
- No data saved anywhere
- Works offline
- Fast, no server needed

**Part B Requirements:**

**1. Check Username Availability:**
```javascript
// Frontend sends request
fetch('/api/check-username', {
  method: 'POST',
  body: JSON.stringify({ username: 'juan123' })
})
.then(response => response.json())
.then(data => {
  if (data.available) {
    alert('Username available!');
  } else {
    alert('Username taken!');
  }
});

// Backend checks database
// SELECT * FROM users WHERE username = 'juan123'
// Returns: { available: true/false }
```

**2. Password Hashing:**
```python
# Backend (Python example)
import bcrypt

password = "mypassword123"
hashed = bcrypt.hashpw(password.encode(), bcrypt.gensalt())
# Result: $2b$12$KIXQw... (secure, irreversible hash)
```
**Cannot** be done in frontend (security risk!).

**3. Send Email:**
Requires backend email service (SMTP, SendGrid, etc.). Frontend cannot send emails directly.

**4. Store Data:**
Requires database (MySQL, PostgreSQL, MongoDB). Frontend can only use temporary storage (localStorage = lost if cleared).

**Why Backend Necessary:**
- **Security:** Password hashing, authentication, authorization
- **Persistence:** Database storage survives server restarts
- **Heavy processing:** Database queries, calculations
- **Secrets:** API keys, database credentials (never in frontend)
- **Business logic:** Payment processing, email sending

</details>

---

**Fantastic exploration!** You've experienced both frontend and backend worlds. You understand their roles, tools, and when each is needed. Ready to specialize or go fullstack!

**Next:** How browsers actually interpret and render HTML, CSS, and JavaScript!
