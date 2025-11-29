# Lesson 43: Authentication with JS + Flask

## Background Story

The barangay complaint system was live and working perfectly. But Captain Cruz raised an important concern during the monthly meeting: "Tian, anyone can submit complaints pretending to be someone else. We need a way to verify who's really submitting."

Kuya Miguel nodded through the video call. "That's authentication—proving you are who you say you are. Time to add user accounts, login, and session management."

Tian felt a mix of excitement and nervousness. This was security territory. Real user data. Real passwords. Real responsibility.

"Don't worry," Miguel reassured. "We'll do it right. Hashed passwords, secure sessions, proper validation. By the end of this lesson, your app will be production-secure."

## What is Authentication?

**Authentication** is the process of verifying the identity of a user. It answers the question: "Are you really who you claim to be?"

### Authentication vs Authorization

**Authentication**: Who are you?  
**Authorization**: What are you allowed to do?

**Example:**
- **Authentication**: Logging in with username + password
- **Authorization**: Checking if you're an admin before allowing delete operations

### Common Authentication Methods

1. **Username + Password** (most common)
2. **Email + Password**
3. **OAuth** (Login with Google/Facebook)
4. **Biometric** (Fingerprint, Face ID)
5. **Two-Factor Authentication (2FA)** (Password + SMS code)

For this lesson, we'll implement **username + password** authentication.

## Security Fundamentals

### Never Store Plain Text Passwords!

**WRONG:**
```python
# DON'T DO THIS!
password = "mypassword123"
# Store directly in database
```

**Why it's dangerous:**
- If database is compromised, all passwords are exposed
- Admins can see user passwords
- If user reuses passwords, other accounts are at risk

### Password Hashing

**Hashing** = One-way encryption. You can't reverse it.

```python
from werkzeug.security import generate_password_hash, check_password_hash

# When user registers
hashed = generate_password_hash("mypassword123")
# Stores: "pbkdf2:sha256:260000$xT9..."

# When user logs in
is_correct = check_password_hash(hashed, "mypassword123")  # True
is_correct = check_password_hash(hashed, "wrongpassword")  # False
```

**Key properties of good hashing:**
- **One-way**: Can't reverse from hash to password
- **Deterministic**: Same password always produces same hash
- **Unique**: Different passwords produce different hashes
- **Salted**: Random data added to prevent rainbow table attacks

## Building Authentication System

### Step 1: User Model (Database)

```python
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

db = SQLAlchemy()

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)
    
    def set_password(self, password):
        """Hash and store password"""
        self.password_hash = generate_password_hash(password)
    
    def check_password(self, password):
        """Verify password"""
        return check_password_hash(self.password_hash, password)
```

### Step 2: Registration Endpoint

```python
from flask import Flask, request, jsonify

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.db'
db.init_app(app)

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    
    # Validation
    username = data.get('username')
    email = data.get('email')
    password = data.get('password')
    
    if not username or not email or not password:
        return jsonify({'error': 'All fields required'}), 400
    
    # Check if user exists
    if User.query.filter_by(username=username).first():
        return jsonify({'error': 'Username already taken'}), 400
    
    if User.query.filter_by(email=email).first():
        return jsonify({'error': 'Email already registered'}), 400
    
    # Create new user
    user = User(username=username, email=email)
    user.set_password(password)
    
    db.session.add(user)
    db.session.commit()
    
    return jsonify({
        'message': 'User registered successfully',
        'user_id': user.id
    }), 201
```

### Step 3: Login Endpoint

```python
from flask import session

app.secret_key = 'your-secret-key-here'  # Change in production!

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    
    username = data.get('username')
    password = data.get('password')
    
    if not username or not password:
        return jsonify({'error': 'Username and password required'}), 400
    
    # Find user
    user = User.query.filter_by(username=username).first()
    
    if not user or not user.check_password(password):
        return jsonify({'error': 'Invalid username or password'}), 401
    
    # Create session
    session['user_id'] = user.id
    session['username'] = user.username
    
    return jsonify({
        'message': 'Login successful',
        'user': {
            'id': user.id,
            'username': user.username,
            'email': user.email
        }
    }), 200
```

### Step 4: Logout Endpoint

```python
@app.route('/logout', methods=['POST'])
def logout():
    session.clear()
    return jsonify({'message': 'Logged out successfully'}), 200
```

### Step 5: Check Auth Status

```python
@app.route('/me', methods=['GET'])
def get_current_user():
    """Get currently logged-in user"""
    user_id = session.get('user_id')
    
    if not user_id:
        return jsonify({'error': 'Not authenticated'}), 401
    
    user = User.query.get(user_id)
    
    if not user:
        return jsonify({'error': 'User not found'}), 404
    
    return jsonify({
        'id': user.id,
        'username': user.username,
        'email': user.email
    }), 200
```

## Frontend: JavaScript Registration

```html
<!-- register.html -->
<form id="register-form">
    <input type="text" id="username" placeholder="Username" required>
    <input type="email" id="email" placeholder="Email" required>
    <input type="password" id="password" placeholder="Password" required>
    <button type="submit">Register</button>
</form>
<div id="message"></div>

<script>
document.getElementById('register-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const username = document.getElementById('username').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    
    try {
        const response = await fetch('/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username, email, password })
        });
        
        const data = await response.json();
        
        if (response.ok) {
            document.getElementById('message').textContent = 'Registration successful! Please login.';
            document.getElementById('message').style.color = 'green';
            // Redirect to login
            setTimeout(() => window.location.href = '/login.html', 2000);
        } else {
            document.getElementById('message').textContent = data.error;
            document.getElementById('message').style.color = 'red';
        }
    } catch (error) {
        console.error('Error:', error);
        document.getElementById('message').textContent = 'Registration failed. Please try again.';
    }
});
</script>
```

## Frontend: JavaScript Login

```html
<!-- login.html -->
<form id="login-form">
    <input type="text" id="username" placeholder="Username" required>
    <input type="password" id="password" placeholder="Password" required>
    <button type="submit">Login</button>
</form>
<div id="message"></div>

<script>
document.getElementById('login-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    
    try {
        const response = await fetch('/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include',  // Important: Include cookies/session
            body: JSON.stringify({ username, password })
        });
        
        const data = await response.json();
        
        if (response.ok) {
            document.getElementById('message').textContent = 'Login successful!';
            document.getElementById('message').style.color = 'green';
            // Store user info
            localStorage.setItem('username', data.user.username);
            // Redirect to dashboard
            setTimeout(() => window.location.href = '/dashboard.html', 1000);
        } else {
            document.getElementById('message').textContent = data.error;
            document.getElementById('message').style.color = 'red';
        }
    } catch (error) {
        console.error('Error:', error);
        document.getElementById('message').textContent = 'Login failed. Please try again.';
    }
});
</script>
```

## Protecting Routes (Backend)

```python
from functools import wraps

def login_required(f):
    """Decorator to protect routes"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            return jsonify({'error': 'Authentication required'}), 401
        return f(*args, **kwargs)
    return decorated_function

# Use decorator on protected routes
@app.route('/complaints', methods=['POST'])
@login_required
def create_complaint():
    user_id = session['user_id']
    data = request.get_json()
    
    # Only authenticated users can create complaints
    complaint = Complaint(
        user_id=user_id,
        description=data['description'],
        location=data['location']
    )
    
    db.session.add(complaint)
    db.session.commit()
    
    return jsonify({'message': 'Complaint submitted'}), 201
```

## Protecting Routes (Frontend)

```javascript
// auth.js - Check if user is logged in
async function checkAuth() {
    try {
        const response = await fetch('/me', {
            credentials: 'include'
        });
        
        if (!response.ok) {
            // Not authenticated - redirect to login
            window.location.href = '/login.html';
            return null;
        }
        
        const user = await response.json();
        return user;
    } catch (error) {
        console.error('Auth check failed:', error);
        window.location.href = '/login.html';
        return null;
    }
}

// Use on protected pages
document.addEventListener('DOMContentLoaded', async () => {
    const user = await checkAuth();
    
    if (user) {
        document.getElementById('username-display').textContent = user.username;
        // Load page content
    }
});
```

## Session Management

### What is a Session?

A **session** is server-side storage of user state. When you login, the server creates a session and sends a session ID (cookie) to your browser.

```python
# Flask automatically handles sessions
from flask import session

# Set session data
session['user_id'] = 123
session['username'] = 'tian'

# Get session data
user_id = session.get('user_id')

# Clear session
session.clear()
```

### Session Security

```python
# config.py
app.config['SECRET_KEY'] = 'your-very-secret-key'  # Change this!
app.config['SESSION_COOKIE_SECURE'] = True  # HTTPS only
app.config['SESSION_COOKIE_HTTPONLY'] = True  # JavaScript can't access
app.config['SESSION_COOKIE_SAMESITE'] = 'Lax'  # CSRF protection
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(hours=24)  # Session expires after 24h
```

## Common Security Issues

### 1. SQL Injection

**WRONG:**
```python
query = f"SELECT * FROM users WHERE username = '{username}'"
```

**CORRECT (use ORM):**
```python
user = User.query.filter_by(username=username).first()
```

### 2. Cross-Site Scripting (XSS)

**Frontend validation:**
```javascript
function sanitizeInput(input) {
    const div = document.createElement('div');
    div.textContent = input;
    return div.innerHTML;
}
```

### 3. Cross-Site Request Forgery (CSRF)

Use Flask-WTF or implement CSRF tokens:
```python
from flask_wtf.csrf import CSRFProtect

csrf = CSRFProtect(app)
```

## Best Practices

### Password Requirements

```javascript
function validatePassword(password) {
    if (password.length < 8) {
        return 'Password must be at least 8 characters';
    }
    if (!/[A-Z]/.test(password)) {
        return 'Password must contain uppercase letter';
    }
    if (!/[a-z]/.test(password)) {
        return 'Password must contain lowercase letter';
    }
    if (!/[0-9]/.test(password)) {
        return 'Password must contain a number';
    }
    return null;  // Valid
}
```

### Rate Limiting

```python
from flask_limiter import Limiter

limiter = Limiter(app, key_func=lambda: request.remote_addr)

@app.route('/login', methods=['POST'])
@limiter.limit("5 per minute")  # Max 5 login attempts per minute
def login():
    # ... login logic
```

### Email Verification

```python
# Send verification email after registration
import secrets

def send_verification_email(user):
    token = secrets.token_urlsafe(32)
    user.verification_token = token
    db.session.commit()
    
    # Send email with link: /verify?token=...
    # (Use Flask-Mail or SendGrid)
```

## Real-World Philippine Context

### Data Privacy Act Compliance

In the Philippines, you must comply with **RA 10173 (Data Privacy Act of 2012)**:

1. **Consent**: Get user consent before collecting data
2. **Purpose**: Only collect data needed for your purpose
3. **Security**: Implement proper security measures
4. **Rights**: Allow users to access/delete their data

### Sample Privacy Policy

```html
<form id="register-form">
    <!-- ... fields ... -->
    <label>
        <input type="checkbox" id="terms" required>
        I agree to the <a href="/privacy-policy">Privacy Policy</a> and <a href="/terms">Terms of Service</a>
    </label>
    <button type="submit">Register</button>
</form>
```

## Testing Authentication

```python
import unittest

class AuthTestCase(unittest.TestCase):
    def test_registration(self):
        response = self.client.post('/register', json={
            'username': 'testuser',
            'email': 'test@example.com',
            'password': 'Test123!'
        })
        self.assertEqual(response.status_code, 201)
    
    def test_login_success(self):
        # First register
        self.client.post('/register', json={
            'username': 'testuser',
            'email': 'test@example.com',
            'password': 'Test123!'
        })
        
        # Then login
        response = self.client.post('/login', json={
            'username': 'testuser',
            'password': 'Test123!'
        })
        self.assertEqual(response.status_code, 200)
    
    def test_login_wrong_password(self):
        response = self.client.post('/login', json={
            'username': 'testuser',
            'password': 'WrongPassword'
        })
        self.assertEqual(response.status_code, 401)
```

## Summary

**Authentication** is verifying user identity through:
- **Registration**: Create account with hashed password
- **Login**: Verify credentials and create session
- **Session**: Maintain logged-in state
- **Protection**: Require authentication for sensitive routes

**Key Security Principles:**
- Never store plain text passwords
- Use secure hashing (bcrypt, pbkdf2)
- Implement session management
- Validate all inputs
- Rate limit login attempts
- Comply with data privacy laws

**Flask + JS Flow:**
1. User registers → Password hashed → Stored in database
2. User logs in → Password verified → Session created
3. Session cookie sent to browser
4. Protected routes check session
5. User logs out → Session cleared

Next lesson: Environment variables and deployment configuration for production security!

---

## Closing Story

Tian finished implementing the authentication system and tested it thoroughly. Register. Login. Logout. Protected routes. Everything worked perfectly.

Captain Cruz tested it himself. "So now, every complaint is tied to a real user account. No more anonymous troublemakers!"

Kuya Miguel reviewed the code during their video call. "Hashed passwords. Session management. Input validation. You've built a secure authentication system. I'm impressed."

But then Miguel's expression turned serious. "One problem though. I can see your database password in the code. And your secret key. If you push this to GitHub, anyone can see it."

Tian's eyes widened. "Oh no. How do I hide that?"

"Environment variables," Miguel smiled. "That's our next lesson. Time to prepare this app for production deployment."

That night, Tian realized something profound: Building features was one thing. Building them *securely* was another. Real developers didn't just make things work—they made things work *safely*.

The barangay portal now had user accounts. Residents could register, login, and submit complaints under their real identities. Trust was built into the system.

Tomorrow? Environment variables, deployment configuration, and production readiness. The app was almost ready for the world.

_Next up: Lesson 44—Environment Variables + Deployment Config!_ 🔐
