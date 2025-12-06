# Activity 1: Authentication with JavaScript and Flask

In this activity, you'll learn how to implement user authentication in your web application. You'll create a login system with session management, password security, and protected routes.

---

## Activity 1: Understanding Authentication

**Authentication** = Verifying who a user is (login)  
**Authorization** = Determining what a user can access (permissions)

**Authentication Flow:**
1. User submits username/password
2. Server validates credentials
3. Server creates session/token
4. Client stores session/token
5. Client includes token in future requests
6. Server verifies token for protected routes

---

## Activity 2: Setting Up Flask Authentication

**Install requirements:**
```bash
pip install flask flask-cors bcrypt pyjwt
```

**Flask backend with authentication** (`app.py`):

```python
from flask import Flask, request, jsonify, session
from flask_cors import CORS
import bcrypt
import jwt
import json
import os
from datetime import datetime, timedelta
from functools import wraps

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key-change-this'  # Change in production!
CORS(app, supports_credentials=True)

# Data files
USERS_FILE = 'users.json'
COMPLAINTS_FILE = 'complaints.json'

# Initialize files
for file in [USERS_FILE, COMPLAINTS_FILE]:
    if not os.path.exists(file):
        with open(file, 'w') as f:
            json.dump([], f)

# Helper functions
def read_users():
    """Read users from file"""
    try:
        with open(USERS_FILE, 'r') as f:
            return json.load(f)
    except:
        return []

def write_users(users):
    """Write users to file"""
    with open(USERS_FILE, 'w') as f:
        json.dump(users, f, indent=2)

def hash_password(password):
    """Hash password with bcrypt"""
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

def verify_password(password, hashed):
    """Verify password against hash"""
    return bcrypt.checkpw(password.encode('utf-8'), hashed.encode('utf-8'))

def generate_token(user_id, username):
    """Generate JWT token"""
    payload = {
        'user_id': user_id,
        'username': username,
        'exp': datetime.utcnow() + timedelta(hours=24)  # Expires in 24 hours
    }
    return jwt.encode(payload, app.config['SECRET_KEY'], algorithm='HS256')

def verify_token(token):
    """Verify JWT token"""
    try:
        payload = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        return payload
    except jwt.ExpiredSignatureError:
        return None
    except jwt.InvalidTokenError:
        return None

# Decorator for protected routes
def token_required(f):
    """Decorator to protect routes"""
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.headers.get('Authorization')
        
        if not token:
            return jsonify({
                'success': False,
                'error': 'Token is missing'
            }), 401
        
        try:
            # Remove 'Bearer ' prefix if present
            if token.startswith('Bearer '):
                token = token[7:]
            
            payload = verify_token(token)
            
            if not payload:
                return jsonify({
                    'success': False,
                    'error': 'Token is invalid or expired'
                }), 401
            
            # Add user info to request
            request.current_user = payload
            
        except Exception as e:
            return jsonify({
                'success': False,
                'error': 'Token verification failed'
            }), 401
        
        return f(*args, **kwargs)
    
    return decorated

# Authentication routes
@app.route('/api/auth/register', methods=['POST'])
def register():
    """Register new user"""
    try:
        data = request.get_json()
        
        # Validate required fields
        if not data.get('username') or not data.get('password'):
            return jsonify({
                'success': False,
                'error': 'Username and password are required'
            }), 400
        
        username = data['username'].strip()
        password = data['password']
        email = data.get('email', '').strip()
        
        # Validate password length
        if len(password) < 6:
            return jsonify({
                'success': False,
                'error': 'Password must be at least 6 characters'
            }), 400
        
        # Read existing users
        users = read_users()
        
        # Check if username exists
        if any(u['username'] == username for u in users):
            return jsonify({
                'success': False,
                'error': 'Username already exists'
            }), 400
        
        # Create new user
        new_user = {
            'id': len(users) + 1,
            'username': username,
            'email': email,
            'password': hash_password(password),
            'role': 'user',  # Default role
            'dateCreated': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        
        users.append(new_user)
        write_users(users)
        
        # Generate token
        token = generate_token(new_user['id'], new_user['username'])
        
        return jsonify({
            'success': True,
            'message': 'User registered successfully',
            'token': token,
            'user': {
                'id': new_user['id'],
                'username': new_user['username'],
                'email': new_user['email'],
                'role': new_user['role']
            }
        }), 201
        
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/api/auth/login', methods=['POST'])
def login():
    """Login user"""
    try:
        data = request.get_json()
        
        username = data.get('username', '').strip()
        password = data.get('password', '')
        
        if not username or not password:
            return jsonify({
                'success': False,
                'error': 'Username and password are required'
            }), 400
        
        # Find user
        users = read_users()
        user = next((u for u in users if u['username'] == username), None)
        
        if not user:
            return jsonify({
                'success': False,
                'error': 'Invalid username or password'
            }), 401
        
        # Verify password
        if not verify_password(password, user['password']):
            return jsonify({
                'success': False,
                'error': 'Invalid username or password'
            }), 401
        
        # Generate token
        token = generate_token(user['id'], user['username'])
        
        return jsonify({
            'success': True,
            'message': 'Login successful',
            'token': token,
            'user': {
                'id': user['id'],
                'username': user['username'],
                'email': user['email'],
                'role': user['role']
            }
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/api/auth/verify', methods=['GET'])
@token_required
def verify():
    """Verify token and get current user"""
    try:
        return jsonify({
            'success': True,
            'user': request.current_user
        }), 200
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/api/auth/logout', methods=['POST'])
@token_required
def logout():
    """Logout user (client-side token removal)"""
    return jsonify({
        'success': True,
        'message': 'Logout successful'
    }), 200

# Protected route example
@app.route('/api/protected/complaints', methods=['GET'])
@token_required
def get_user_complaints():
    """Get complaints for current user (protected route)"""
    try:
        user = request.current_user
        
        # Implementation here...
        
        return jsonify({
            'success': True,
            'user': user['username'],
            'complaints': []
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

if __name__ == '__main__':
    app.run(debug=True, port=5000)
```

---

## Activity 3: Frontend Authentication

**HTML Login/Register Form:**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authentication System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .auth-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            max-width: 400px;
            width: 100%;
        }
        
        h2 {
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }
        
        input {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
        }
        
        input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        
        .btn:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        
        .switch-form {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .switch-form a {
            color: #667eea;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
        }
        
        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .message.success {
            background: #d4edda;
            color: #155724;
        }
        
        .message.error {
            background: #f8d7da;
            color: #721c24;
        }
        
        .hidden {
            display: none;
        }
        
        .dashboard {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            max-width: 600px;
            width: 100%;
        }
        
        .user-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Login/Register Forms -->
    <div id="authContainer" class="auth-container">
        <div id="messageDiv"></div>
        
        <!-- Login Form -->
        <div id="loginForm">
            <h2>🔐 Login</h2>
            <form onsubmit="handleLogin(event)">
                <div class="form-group">
                    <label for="loginUsername">Username</label>
                    <input type="text" id="loginUsername" required>
                </div>
                
                <div class="form-group">
                    <label for="loginPassword">Password</label>
                    <input type="password" id="loginPassword" required>
                </div>
                
                <button type="submit" class="btn" id="loginBtn">Login</button>
            </form>
            
            <div class="switch-form">
                Don't have an account? <a onclick="showRegisterForm()">Register</a>
            </div>
        </div>
        
        <!-- Register Form -->
        <div id="registerForm" class="hidden">
            <h2>📝 Register</h2>
            <form onsubmit="handleRegister(event)">
                <div class="form-group">
                    <label for="registerUsername">Username</label>
                    <input type="text" id="registerUsername" required>
                </div>
                
                <div class="form-group">
                    <label for="registerEmail">Email</label>
                    <input type="email" id="registerEmail">
                </div>
                
                <div class="form-group">
                    <label for="registerPassword">Password</label>
                    <input type="password" id="registerPassword" required minlength="6">
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" required>
                </div>
                
                <button type="submit" class="btn" id="registerBtn">Register</button>
            </form>
            
            <div class="switch-form">
                Already have an account? <a onclick="showLoginForm()">Login</a>
            </div>
        </div>
    </div>
    
    <!-- Dashboard (shown after login) -->
    <div id="dashboard" class="dashboard hidden">
        <h2>✅ Welcome to Dashboard</h2>
        
        <div class="user-info" id="userInfo">
            <!-- User info will be displayed here -->
        </div>
        
        <button class="btn" onclick="handleLogout()">Logout</button>
    </div>

    <script>
        const API_URL = 'http://localhost:5000/api';
        
        // Check if user is already logged in
        document.addEventListener('DOMContentLoaded', () => {
            const token = localStorage.getItem('authToken');
            if (token) {
                verifyToken(token);
            }
        });
        
        // Show/hide forms
        function showLoginForm() {
            document.getElementById('loginForm').classList.remove('hidden');
            document.getElementById('registerForm').classList.add('hidden');
            clearMessage();
        }
        
        function showRegisterForm() {
            document.getElementById('loginForm').classList.add('hidden');
            document.getElementById('registerForm').classList.remove('hidden');
            clearMessage();
        }
        
        // Handle login
        async function handleLogin(event) {
            event.preventDefault();
            
            const username = document.getElementById('loginUsername').value;
            const password = document.getElementById('loginPassword').value;
            const btn = document.getElementById('loginBtn');
            
            try {
                btn.disabled = true;
                btn.textContent = 'Logging in...';
                
                const response = await fetch(`${API_URL}/auth/login`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, password })
                });
                
                const data = await response.json();
                
                if (!response.ok) {
                    throw new Error(data.error || 'Login failed');
                }
                
                // Store token
                localStorage.setItem('authToken', data.token);
                localStorage.setItem('user', JSON.stringify(data.user));
                
                showMessage('✅ Login successful!', 'success');
                
                setTimeout(() => {
                    showDashboard(data.user);
                }, 1000);
                
            } catch (error) {
                showMessage('❌ ' + error.message, 'error');
            } finally {
                btn.disabled = false;
                btn.textContent = 'Login';
            }
        }
        
        // Handle register
        async function handleRegister(event) {
            event.preventDefault();
            
            const username = document.getElementById('registerUsername').value;
            const email = document.getElementById('registerEmail').value;
            const password = document.getElementById('registerPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const btn = document.getElementById('registerBtn');
            
            // Check passwords match
            if (password !== confirmPassword) {
                showMessage('❌ Passwords do not match', 'error');
                return;
            }
            
            try {
                btn.disabled = true;
                btn.textContent = 'Registering...';
                
                const response = await fetch(`${API_URL}/auth/register`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, email, password })
                });
                
                const data = await response.json();
                
                if (!response.ok) {
                    throw new Error(data.error || 'Registration failed');
                }
                
                // Store token
                localStorage.setItem('authToken', data.token);
                localStorage.setItem('user', JSON.stringify(data.user));
                
                showMessage('✅ Registration successful!', 'success');
                
                setTimeout(() => {
                    showDashboard(data.user);
                }, 1000);
                
            } catch (error) {
                showMessage('❌ ' + error.message, 'error');
            } finally {
                btn.disabled = false;
                btn.textContent = 'Register';
            }
        }
        
        // Verify token
        async function verifyToken(token) {
            try {
                const response = await fetch(`${API_URL}/auth/verify`, {
                    headers: {
                        'Authorization': `Bearer ${token}`
                    }
                });
                
                const data = await response.json();
                
                if (data.success) {
                    const user = JSON.parse(localStorage.getItem('user'));
                    showDashboard(user);
                } else {
                    // Token invalid, clear storage
                    localStorage.clear();
                }
                
            } catch (error) {
                console.error('Token verification failed:', error);
                localStorage.clear();
            }
        }
        
        // Show dashboard
        function showDashboard(user) {
            document.getElementById('authContainer').classList.add('hidden');
            document.getElementById('dashboard').classList.remove('hidden');
            
            document.getElementById('userInfo').innerHTML = `
                <h3>User Information</h3>
                <p><strong>Username:</strong> ${user.username}</p>
                <p><strong>Email:</strong> ${user.email || 'Not provided'}</p>
                <p><strong>Role:</strong> ${user.role}</p>
                <p><strong>User ID:</strong> ${user.id}</p>
            `;
        }
        
        // Handle logout
        async function handleLogout() {
            const token = localStorage.getItem('authToken');
            
            try {
                await fetch(`${API_URL}/auth/logout`, {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${token}`
                    }
                });
            } catch (error) {
                console.error('Logout error:', error);
            } finally {
                // Clear storage
                localStorage.clear();
                
                // Show login form
                document.getElementById('dashboard').classList.add('hidden');
                document.getElementById('authContainer').classList.remove('hidden');
                showLoginForm();
            }
        }
        
        // Show message
        function showMessage(message, type) {
            const messageDiv = document.getElementById('messageDiv');
            messageDiv.innerHTML = `<div class="message ${type}">${message}</div>`;
            
            setTimeout(clearMessage, 5000);
        }
        
        // Clear message
        function clearMessage() {
            document.getElementById('messageDiv').innerHTML = '';
        }
        
        // Helper function to make authenticated requests
        async function authenticatedFetch(url, options = {}) {
            const token = localStorage.getItem('authToken');
            
            if (!token) {
                throw new Error('Not authenticated');
            }
            
            options.headers = {
                ...options.headers,
                'Authorization': `Bearer ${token}`
            };
            
            const response = await fetch(url, options);
            
            // If unauthorized, logout
            if (response.status === 401) {
                handleLogout();
                throw new Error('Session expired. Please login again.');
            }
            
            return response;
        }
    </script>
</body>
</html>
```

---

## 📚 Key Concepts

1. **Password Hashing** - Never store plain text passwords
2. **JWT Tokens** - Stateless authentication
3. **Protected Routes** - Require authentication
4. **Token Storage** - localStorage or sessionStorage
5. **Token Verification** - Check on every protected request
6. **Session Expiry** - Tokens expire after set time
7. **Logout** - Clear token from client

---

## 🚀 Enhancements

1. Remember me functionality
2. Password reset via email
3. Two-factor authentication (2FA)
4. OAuth (Google, Facebook login)
5. Role-based access control
6. Refresh tokens
7. Account activation via email

Great job implementing authentication!