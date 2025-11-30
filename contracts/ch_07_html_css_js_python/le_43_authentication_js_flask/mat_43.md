## Background Story

The Barangay Complaint System had been live for exactly one week. Residents were using it enthusiastically—over 50 complaints submitted in just seven days. The digital transformation was working.

Then, on Monday morning, Ms. Reyes called Tian urgently. "We have a problem."

Tian rushed to the barangay hall. Ms. Reyes showed him the complaints list. "Look at this one—submitted by 'Juan Dela Cruz,' complaining that 'Maria Santos is too noisy.' Then look at this one, also from 'Juan Dela Cruz,' saying 'Pedro Reyes stole my chicken.' And this one, 'Juan Dela Cruz' again, with a vulgar complaint about the barangay captain."

She pulled up the barangay records. "There are THREE residents named Juan Dela Cruz in our barangay. But none of them submitted these complaints. Someone is using their names to post fake complaints. We have no way to verify who actually submitted what."

Captain Cruz joined them, clearly frustrated. "This is a serious problem. If people can submit complaints anonymously or using fake names, the system loses credibility. We need to know: Who submitted this complaint? Are they really a resident of this barangay? Can we contact them?"

Tian felt his stomach sink. He'd built a perfectly functional complaint system—create, read, update, delete—pero he'd completely overlooked **identity verification**. Anyone could type any name and submit anything. There was no accountability, no way to prevent abuse.

Rhea Joy, who'd joined the emergency meeting, pointed out another issue: "And look—anyone can delete anyone's complaints. I accidentally clicked 'Delete' on someone else's complaint yesterday. There's no concept of 'ownership.' No way to say 'you can only edit or delete YOUR OWN complaints.'"

Ms. Reyes added, "We need residents to register accounts, log in, and then only see and manage their own submissions. Staff and admin should see everything, pero regular residents should only access their own data."

Captain Cruz was firm: "Until we fix this security problem, I can't trust the system for official use. We'll keep using paper forms until the digital system has proper authentication."

Tian felt devastated. He'd worked so hard on the complaint system, but he'd missed a fundamental requirement: **security and authentication**.

They immediately video called Kuya Miguel. "Kuya, our complaint system works perfectly, pero we have zero security. Anyone can submit using any name. Anyone can delete anyone's complaints. How do we fix this?"

Miguel had anticipated this moment. "You've discovered why every real web application needs authentication. Facebook doesn't let you post as someone else. Gmail doesn't let you read someone else's emails. Twitter doesn't let you delete other people's tweets. Every application needs to answer two questions:

1. **Authentication**: Who are you? (Prove your identity)
2. **Authorization**: What are you allowed to do? (Check permissions)

Your complaint system is missing both."

He shared his screen showing a login page. "Authentication means users register accounts with usernames and passwords. When they log in, the system verifies their credentials. Once authenticated, the system knows WHO is making each request—viewing, creating, editing, deleting. You can enforce rules: users can only edit their own complaints, only admins can change status, only the submitter or admin can delete."

Tian understood the architecture immediately: "So instead of just submitting complaints with a name field, users first register and log in. Then when they submit a complaint, we associate it with their user account. When they view complaints, we only show THEIR complaints unless they're admin. When they try to delete, we check: does this complaint belong to you?"

"Exactly," Miguel confirmed. "That's how every web application works. The system tracks WHO you are and WHAT you're allowed to do."

Rhea Joy had a critical question: "But passwords are sensitive. How do we store them safely?"

Miguel's expression turned serious. "This is crucial. NEVER store passwords in plain text. If your database is compromised, all passwords are exposed. You must use **password hashing**—one-way encryption. When a user registers, you hash their password using bcrypt or Werkzeug. You store the hash, not the password. When they log in, you hash what they entered and compare hashes. If someone steals your database, they get useless hash strings, not actual passwords."

He demonstrated:

```python
from werkzeug.security import generate_password_hash, check_password_hash

# User registers with password "secret123"
hashed = generate_password_hash("secret123")
# Stored in database: "pbkdf2:sha256:260000$xT4..."

# User logs in with password "secret123"
check_password_hash(hashed, "secret123")  # Returns True
check_password_hash(hashed, "wrong")      # Returns False
```

"Even as the developer, you can't see users' passwords," Miguel explained. "That's proper security."

Tian thought about the implementation plan: "So we need:

1. **Users table**: id, username, email, hashed_password, role (resident/staff/admin)
2. **Register endpoint**: Create new user, hash password, save to database
3. **Login endpoint**: Check credentials, create session, return success
4. **Session management**: Track who's logged in using Flask sessions
5. **Protected routes**: Check if user is logged in before allowing actions
6. **Authorization**: Check if user owns the complaint before allowing edit/delete
7. **Frontend**: Login/register forms, logout button, display username"

Rhea Joy added the user experience flow: "When users visit the site, they see the login page. New users click 'Register,' create account with username, email, password. After registering, they're automatically logged in. They see 'Welcome, [username]' at the top with a logout button. They can submit complaints, which are tied to their account. They see only THEIR complaints unless they're admin. They can edit/delete only their own. Log out, and they're back to the login page."

"Perfect understanding," Miguel said. "And here's the security mindset you need: always assume users will try to do things they shouldn't. They'll try to delete other people's complaints by guessing IDs. They'll try to access admin features by manipulating URLs. Your backend must verify EVERY request: Is this user logged in? Do they have permission for this action? Never trust the frontend alone."

Captain Cruz, listening intently, asked, "How long will this take to implement?"

Tian thought carefully. "We need to restructure the entire application. Add user management, modify the database schema, add authentication endpoints, implement sessions, update all existing endpoints to check permissions, modify the frontend to handle login state. Maybe... three days?"

Miguel interrupted, "Take your time and do it right. Security isn't something you rush. One vulnerability can compromise the entire system. Better to take a week and build it securely than take two days and leave holes."

Ms. Reyes was supportive. "We'll continue with paper forms until the secure version is ready. Take the time you need. We'd rather wait and get a secure system than rush and have problems."

Tian felt the weight of responsibility. "This isn't just adding features. This is security. People's data. Their trust. We need to do this perfectly."

Rhea Joy pulled up authentication tutorials and Flask-Login documentation. "Let's learn properly. Password hashing with Werkzeug. Session management with Flask. Login required decorators. Permission checks. CSRF protection. Everything."

Miguel gave them a comprehensive checklist:

**Authentication Implementation Checklist:**
☐ Create users table in database
☐ Implement register endpoint with password hashing
☐ Implement login endpoint with credential verification
☐ Set up Flask sessions for tracking logged-in users
☐ Add logout functionality
☐ Protect all API routes with login_required decorator
☐ Modify complaints table to include user_id foreign key
☐ Update create complaint to associate with logged-in user
☐ Update get complaints to filter by user (unless admin)
☐ Update edit/delete to check ownership
☐ Build register/login frontend forms
☐ Handle login state in JavaScript
☐ Store session token in localStorage
☐ Add logout button and functionality
☐ Test all authentication flows thoroughly
☐ Test authorization rules (can users access what they shouldn't?)
☐ Review for security vulnerabilities

"Work through this checklist methodically," Miguel advised. "Test each piece before moving to the next. Security is layers—authentication, session management, authorization, input validation, password hashing. Get each layer right."

Tian opened his code, ready for the major refactoring. "We built a functional system. Now we're making it secure. From anyone-can-do-anything to properly authenticated and authorized. This is what professional applications require."

Rhea Joy was already sketching the login page design. "Clean, professional login form. Clear error messages. Registration with password confirmation. 'Forgot password?' link for future implementation. User-friendly security."

Captain Cruz stood to leave. "I trust you both. When this is done, we'll have a system that's not just functional, but secure. Residents can trust that their complaints are protected, their identities verified, their data safe. That's the standard we need."

As he left, Tian turned to Miguel's video call. "Kuya, this is the most important lesson yet. We've learned how to build features. Now we're learning how to build them securely. That's the difference between amateur and professional development."

Miguel nodded with pride. "You're thinking like a professional developer now. Security isn't an afterthought—it's foundational. Let's build authentication the right way."

---

## Theory & Lecture Content

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

_Next up: Lesson 44 - Environment Variables + Deployment Config!_
