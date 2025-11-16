# Frontend vs Backend Quiz

---

# Quiz 1

## Quiz: Building a Complete E-Wallet Application (GCash-like)

**Scenario:**

Tian is a web developer building an e-wallet app similar to GCash for his thesis project. Let's examine Tian's app architecture and code to understand frontend vs backend.

**App Features:**
- User registration and login
- View wallet balance
- Send money to other users
- Transaction history
- QR code payment

**System Architecture:**

```
┌─────────────────────────────────────┐
│         FRONTEND (React)            │
│  - User Interface                   │
│  - Forms, Buttons, Displays         │
│  - Client-side validation           │
│  - Runs in: Browser                 │
└──────────────┬──────────────────────┘
               │ HTTP/HTTPS
               │ JSON Data
               ↓
┌─────────────────────────────────────┐
│      API LAYER (REST APIs)          │
│  - /api/register                    │
│  - /api/login                       │
│  - /api/balance                     │
│  - /api/send-money                  │
│  - /api/transactions                │
└──────────────┬──────────────────────┘
               │
               ↓
┌─────────────────────────────────────┐
│      BACKEND (Node.js + Express)    │
│  - Business Logic                   │
│  - Authentication                   │
│  - Security/Validation              │
│  - Database Operations              │
│  - Runs in: Server                  │
└──────────────┬──────────────────────┘
               │
               ↓
┌─────────────────────────────────────┐
│     DATABASE (MongoDB)              │
│  - User accounts                    │
│  - Wallet balances                  │
│  - Transaction records              │
│  - Stored in: Database Server       │
└─────────────────────────────────────┘
```

**Code Analysis:**

### Code Snippet A: Send Money Button
```html
<!-- SendMoney.jsx -->
<div className="send-money-form">
  <input 
    type="text" 
    placeholder="Enter phone number"
    value={recipientPhone}
    onChange={(e) => setRecipientPhone(e.target.value)}
  />
  <input 
    type="number" 
    placeholder="Amount"
    value={amount}
    onChange={(e) => setAmount(e.target.value)}
  />
  <button onClick={handleSendMoney}>
    Send ₱{amount}
  </button>
</div>
```

### Code Snippet B: API Request
```javascript
// frontend/services/api.js
async function sendMoney(recipientPhone, amount) {
  const response = await fetch('https://api.ewallet.ph/send-money', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${userToken}`
    },
    body: JSON.stringify({
      recipientPhone: recipientPhone,
      amount: amount
    })
  });
  
  return await response.json();
}
```

### Code Snippet C: Backend Processing
```javascript
// backend/controllers/transactionController.js
async function processSendMoney(req, res) {
  const { recipientPhone, amount } = req.body;
  const senderId = req.user.id; // From JWT token
  
  // 1. Validate inputs
  if (!recipientPhone || !amount) {
    return res.status(400).json({ error: "Missing fields" });
  }
  
  // 2. Check sender balance
  const sender = await User.findById(senderId);
  if (sender.balance < amount) {
    return res.status(400).json({ error: "Insufficient balance" });
  }
  
  // 3. Find recipient
  const recipient = await User.findOne({ phone: recipientPhone });
  if (!recipient) {
    return res.status(404).json({ error: "Recipient not found" });
  }
  
  // 4. Perform transaction (CRITICAL: Database transaction)
  await mongoose.startSession();
  try {
    // Deduct from sender
    sender.balance -= amount;
    await sender.save();
    
    // Add to recipient
    recipient.balance += amount;
    await recipient.save();
    
    // Log transaction
    await Transaction.create({
      from: senderId,
      to: recipient._id,
      amount: amount,
      timestamp: new Date()
    });
    
    res.status(200).json({ 
      success: true, 
      newBalance: sender.balance 
    });
  } catch (error) {
    // Rollback if error
    await session.abortTransaction();
    res.status(500).json({ error: "Transaction failed" });
  }
}
```

### Code Snippet D: Styling
```css
/* styles/SendMoney.css */
.send-money-form {
  background: linear-gradient(135deg, #007bff, #00d4ff);
  padding: 30px;
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}

.send-money-form input {
  width: 100%;
  padding: 15px;
  margin: 10px 0;
  border: none;
  border-radius: 8px;
  font-size: 16px;
}

.send-money-form button {
  width: 100%;
  padding: 15px;
  background-color: #28a745;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 18px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.send-money-form button:hover {
  background-color: #218838;
  transform: translateY(-2px);
}
```

---

**Tanong 1:** Snippets A at D (HTML forms at CSS styling) ay bahagi ng anong layer?

- A) Backend - server-side processing
- B) Frontend - user interface at visual design
- C) Database - data storage
- D) API - data transmission

**Tanong 2:** Snippet C (processSendMoney function) ay tumatakbo saan?

- A) Sa browser ng user (frontend)
- B) Sa server/backend (Node.js)
- C) Sa database directly
- D) Sa user's phone

---

# Quiz 2

**Tanong 3:** Bakit **kailangan** ng backend validation kahit may frontend validation na?

- A) Para mas mabilis ang app
- B) Security - users can bypass frontend, directly call API
- C) Para maganda lang tingnan
- D) Hindi naman kailangan, frontend validation lang okay na

**Tanong 4:** Sa Snippet B, ano ang HTTP method ginagamit at bakit?

- A) GET - kasi kukunin ang data
- B) POST - kasi magpapadala ng sensitive data (amount, recipient)
- C) PUT - kasi mag-update ng balance
- D) DELETE - kasi mababawasan ang balance

**Sagot:**
- **Tanong 1:** B) Frontend - user interface at visual design
- **Tanong 2:** B) Sa server/backend (Node.js)
- **Tanong 3:** B) Security - users can bypass frontend, directly call API
- **Tanong 4:** B) POST - kasi magpapadala ng sensitive data

---

## Detailed Explanation

### Frontend Layer (Client-Side)

**Ano ang Frontend?**

Ang frontend ay lahat ng nakikita at na-i-interact ng user directly sa browser. Ito ay composed ng tatlong main technologies:

**1. HTML (HyperText Markup Language)** - Structure
```html
<!-- Structure ng Send Money form -->
<div class="container">
  <h1>Send Money</h1>
  <form>
    <input type="text" id="phone" placeholder="Phone Number" />
    <input type="number" id="amount" placeholder="Amount" />
    <button type="submit">Send</button>
  </form>
</div>
```
- Defines content at structure
- `<div>`, `<input>`, `<button>` = HTML elements
- Semantic meaning (forms, headings, paragraphs)

**2. CSS (Cascading Style Sheets)** - Styling
```css
/* Visual design */
.container {
  max-width: 500px;
  margin: 0 auto;
  background: white;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

input {
  border: 2px solid #007bff;
  padding: 12px;
  font-size: 16px;
}

button {
  background: #28a745;
  color: white;
  padding: 15px 30px;
}
```
- Colors, fonts, spacing, layout
- Responsive design (mobile, tablet, desktop)
- Animations at transitions

**3. JavaScript** - Interactivity
```javascript
// Handle user interactions
function handleSendMoney() {
  const phone = document.getElementById('phone').value;
  const amount = document.getElementById('amount').value;
  
  // Frontend validation
  if (!phone || phone.length !== 11) {
    alert('Invalid phone number');
    return;
  }
  
  if (amount < 1 || amount > 50000) {
    alert('Amount must be ₱1 to ₱50,000');
    return;
  }
  
  // Call API
  sendMoneyAPI(phone, amount);
}
```
- Event handling (clicks, typing, scrolling)
- DOM manipulation (update content without reload)
- Client-side validation
- API calls to backend

**Modern Frontend Frameworks:**
- **React** (by Facebook) - Most popular in PH
- **Vue.js** - Easier to learn
- **Angular** - Enterprise applications

---

### Backend Layer (Server-Side)

**Ano ang Backend?**

Ang backend ay hidden sa users. Ito ay tumatakbo sa server at responsible for:

**1. Business Logic**
```javascript
// Backend validates and processes
async function processSendMoney(senderId, recipientPhone, amount) {
  // Business rules enforcement
  
  // Rule 1: Maximum ₱50,000 per transaction
  if (amount > 50000) {
    throw new Error('Maximum ₱50,000 per transaction');
  }
  
  // Rule 2: Check daily limit
  const todayTransactions = await getTodayTransactions(senderId);
  const totalToday = todayTransactions.reduce((sum, t) => sum + t.amount, 0);
  
  if (totalToday + amount > 100000) {
    throw new Error('Daily limit of ₱100,000 exceeded');
  }
  
  // Rule 3: Check if recipient is verified
  const recipient = await User.findOne({ phone: recipientPhone });
  if (!recipient.isVerified) {
    throw new Error('Recipient is not verified');
  }
  
  // Proceed with transaction...
}
```

**2. Database Operations**
```javascript
// CRUD operations (Create, Read, Update, Delete)

// CREATE - New user
await User.create({
  name: "Juan Dela Cruz",
  phone: "09171234567",
  email: "juan@email.com",
  balance: 0
});

// READ - Get user balance
const user = await User.findById(userId);
console.log(user.balance);

// UPDATE - Update balance
user.balance += 1000;
await user.save();

// DELETE - Remove transaction
await Transaction.findByIdAndDelete(transactionId);
```

**3. Authentication & Authorization**
```javascript
// JWT (JSON Web Token) authentication

// Login process
async function login(phone, password) {
  // 1. Find user
  const user = await User.findOne({ phone });
  
  // 2. Verify password (hashed with bcrypt)
  const isValid = await bcrypt.compare(password, user.passwordHash);
  if (!isValid) {
    throw new Error('Invalid credentials');
  }
  
  // 3. Generate JWT token
  const token = jwt.sign(
    { userId: user._id, phone: user.phone },
    process.env.JWT_SECRET,
    { expiresIn: '7d' }
  );
  
  return token;
}

// Protected routes (require authentication)
function requireAuth(req, res, next) {
  const token = req.headers.authorization?.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }
  
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next(); // Proceed to actual route handler
  } catch (error) {
    return res.status(401).json({ error: 'Invalid token' });
  }
}

// Usage:
app.post('/api/send-money', requireAuth, processSendMoney);
```

**4. Security**
```javascript
// Input sanitization
const phone = sanitize(req.body.phone);
const amount = parseFloat(req.body.amount);

// SQL Injection prevention (using ORM like Mongoose)
// BAD (vulnerable):
db.query(`SELECT * FROM users WHERE phone = '${phone}'`);

// GOOD (safe):
await User.findOne({ phone: phone });

// Rate limiting (prevent abuse)
const rateLimit = require('express-rate-limit');
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests, please try again later'
});

app.use('/api/', limiter);
```

---

### API Layer (Bridge between Frontend & Backend)

**REST API Endpoints:**

```javascript
// Backend API Routes
const express = require('express');
const router = express.Router();

// User Management
router.post('/api/register', registerController);
router.post('/api/login', loginController);
router.get('/api/profile', requireAuth, getProfileController);
router.put('/api/profile', requireAuth, updateProfileController);

// Wallet Operations
router.get('/api/balance', requireAuth, getBalanceController);
router.post('/api/send-money', requireAuth, sendMoneyController);
router.post('/api/cash-in', requireAuth, cashInController);

// Transactions
router.get('/api/transactions', requireAuth, getTransactionsController);
router.get('/api/transactions/:id', requireAuth, getTransactionDetailController);

// Admin (requires admin role)
router.get('/api/admin/users', requireAuth, requireAdmin, getAllUsersController);
router.put('/api/admin/verify/:userId', requireAuth, requireAdmin, verifyUserController);
```

**Request-Response Example:**

**Frontend Request:**
```javascript
// User clicks "Send ₱500" button
const response = await fetch('https://api.ewallet.ph/send-money', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
  },
  body: JSON.stringify({
    recipientPhone: '09171234567',
    amount: 500
  })
});

const data = await response.json();
console.log(data);
```

**Backend Response:**
```json
{
  "success": true,
  "message": "Money sent successfully",
  "transaction": {
    "id": "txn_1234567890",
    "from": "09187654321",
    "to": "09171234567",
    "amount": 500,
    "timestamp": "2024-11-13T08:30:00.000Z",
    "status": "completed"
  },
  "newBalance": 4500
}
```

---

### Database Layer

**MongoDB Schema Example:**

```javascript
// User Schema
const UserSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  phone: {
    type: String,
    required: true,
    unique: true,
    match: /^09\d{9}$/  // Philippine mobile format
  },
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true
  },
  passwordHash: {
    type: String,
    required: true
  },
  balance: {
    type: Number,
    default: 0,
    min: 0
  },
  isVerified: {
    type: Boolean,
    default: false
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

// Transaction Schema
const TransactionSchema = new mongoose.Schema({
  from: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  to: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  amount: {
    type: Number,
    required: true,
    min: 1
  },
  type: {
    type: String,
    enum: ['send_money', 'cash_in', 'cash_out', 'payment'],
    required: true
  },
  status: {
    type: String,
    enum: ['pending', 'completed', 'failed'],
    default: 'pending'
  },
  timestamp: {
    type: Date,
    default: Date.now
  }
});
```

---

### Fullstack Flow (Complete Journey)

**Scenario: Carlo sends ₱500 to Maria**

```
1. FRONTEND (Browser)
   Carlo clicks "Send ₱500" button
   ↓
   React component calls sendMoney() function
   ↓
   Client-side validation:
   - Is phone number valid? ✓
   - Is amount positive? ✓
   ↓

2. API REQUEST (HTTP)
   POST https://api.ewallet.ph/send-money
   Headers: Authorization token
   Body: { recipientPhone: "09171234567", amount: 500 }
   ↓

3. BACKEND (Server)
   Express route handler receives request
   ↓
   requireAuth middleware validates JWT token ✓
   ↓
   processSendMoney() controller:
   - Server-side validation (CRITICAL)
   - Check Carlo's balance: ₱5,000 ✓
   - Find Maria by phone ✓
   - Business rules check ✓
   ↓

4. DATABASE (MongoDB)
   Start transaction (atomic operation):
   ↓
   a) Update Carlo's balance: ₱5,000 → ₱4,500
   b) Update Maria's balance: ₱3,000 → ₱3,500
   c) Create transaction record
   ↓
   Commit transaction ✓
   ↓

5. BACKEND RESPONSE
   Status: 200 OK
   Body: {
     success: true,
     newBalance: 4500,
     transaction: {...}
   }
   ↓

6. FRONTEND UPDATE
   React updates UI:
   - Carlo's new balance: ₱4,500
   - Success notification: "Sent ₱500 to Maria"
   - Transaction appears in history
```

**Time Breakdown:**
- Frontend render: 10-20ms
- API request (PH → SG): 50-100ms
- Backend processing: 50-150ms
- Database operation: 20-50ms
- API response: 50-100ms
- Frontend update: 10-20ms
- **Total: 200-450ms** (less than half a second!)

---

### Security Considerations

**Why Backend Validation is CRITICAL:**

**Scenario: Malicious user tries to bypass frontend**

```javascript
// ATTACK: Hacker opens browser console
fetch('https://api.ewallet.ph/send-money', {
  method: 'POST',
  headers: {
    'Authorization': 'Bearer stolen_token_12345'
  },
  body: JSON.stringify({
    recipientPhone: '09991234567', // Hacker's phone
    amount: 999999999  // ₱999 MILLION! 💰
  })
});
```

**Backend Protection:**

```javascript
// Backend validation catches this
async function processSendMoney(req, res) {
  const { amount } = req.body;
  const user = req.user; // From JWT token
  
  // Check 1: Reasonable amount
  if (amount > 50000) {
    return res.status(400).json({ 
      error: 'Maximum ₱50,000 per transaction' 
    });
  }
  
  // Check 2: Sufficient balance
  if (user.balance < amount) {
    return res.status(400).json({ 
      error: 'Insufficient balance' 
    });
  }
  
  // Check 3: Daily limit
  const dailyTotal = await getTodayTransactions(user.id);
  if (dailyTotal + amount > 100000) {
    return res.status(400).json({ 
      error: 'Daily limit exceeded' 
    });
  }
  
  // Proceed only if all checks pass
}
```

**Result:** Attack blocked! Backend always validates everything.

---

### Philippine Job Market Context

**Frontend Developer (₱25,000 - ₱60,000/month)**

**Required Skills:**
- HTML, CSS, JavaScript (ES6+)
- React.js or Vue.js
- Responsive design (mobile-first)
- Git version control
- REST API integration

**Typical Job:**
- Create UI components
- Implement designs from Figma
- Ensure cross-browser compatibility
- Optimize performance
- Collaborate with UX designers

**Companies Hiring:**
- Accenture, IBM, Globe Telecom
- Shopee, Lazada, GCash
- Startups (many!)

---

**Backend Developer (₱30,000 - ₱80,000/month)**

**Required Skills:**
- Node.js or Python (Django/Flask) or PHP (Laravel)
- Database design (SQL/NoSQL)
- API development (REST/GraphQL)
- Authentication (JWT, OAuth)
- Security best practices
- Cloud deployment (AWS, Azure)

**Typical Job:**
- Build APIs
- Database optimization
- Server maintenance
- Security implementation
- Performance tuning

**Companies Hiring:**
- Banks (BPI, BDO, UnionBank)
- FinTech (PayMaya, GCash, Coins.ph)
- E-commerce platforms

---

**Fullstack Developer (₱40,000 - ₱100,000/month)**

**Required Skills:**
- Frontend + Backend skills
- DevOps basics (Docker, CI/CD)
- System architecture
- Problem-solving

**Typical Job:**
- End-to-end feature development
- Technical leadership
- Mentoring junior developers
- System design

**Companies Hiring:**
- Tech startups (preferred)
- Product companies
- Consulting firms

---

## Key Takeaways

**Frontend:**
- ✅ Visible to users
- ✅ Runs in browser
- ✅ HTML + CSS + JavaScript
- ✅ User experience focused
- ❌ Cannot be trusted for security
- ❌ Code is publicly visible

**Backend:**
- ✅ Hidden from users
- ✅ Runs on server
- ✅ Business logic enforcement
- ✅ Security gatekeeper
- ✅ Database access
- ❌ Users cannot see or modify

**Why Both Matter:**
Frontend without backend = Pretty but powerless
Backend without frontend = Powerful but unusable
Frontend + Backend = Complete, secure application! 🚀
