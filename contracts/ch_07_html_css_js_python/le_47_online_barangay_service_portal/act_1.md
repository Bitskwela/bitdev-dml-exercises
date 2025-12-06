# Activity 1: Online Barangay Service Portal - Final Project

**Final Capstone Project: Build a complete Online Barangay Service Portal**

This is your culminating project that integrates everything you've learned: HTML, CSS, JavaScript, Flask, CRUD operations, authentication, local storage, and deployment.

---

## Project Overview

**Build an Online Barangay Service Portal with:**

✅ User authentication (Register, Login, Logout)  
✅ Multiple user roles (Resident, Barangay Staff, Admin)  
✅ Service request system (Barangay Clearance, Certificate, Business Permit)  
✅ Document tracking with status updates  
✅ Admin dashboard with analytics  
✅ Responsive design for mobile and desktop  
✅ Local storage for offline support  
✅ Deployed to production  

---

## Activity 1: Project Structure

```
barangay-portal/
├── app.py                      # Flask backend
├── requirements.txt
├── .env                        # Environment variables
├── data/
│   ├── users.json
│   ├── requests.json
│   └── announcements.json
├── static/
│   ├── index.html             # Landing page
│   ├── login.html             # Login page
│   ├── register.html          # Registration page
│   ├── dashboard.html         # User dashboard
│   ├── admin.html             # Admin dashboard
│   ├── css/
│   │   ├── styles.css         # Main styles
│   │   └── admin.css          # Admin styles
│   ├── js/
│   │   ├── config.js          # Configuration
│   │   ├── auth.js            # Authentication
│   │   ├── api.js             # API calls
│   │   ├── dashboard.js       # User dashboard
│   │   └── admin.js           # Admin panel
│   └── images/
│       └── logo.png
└── README.md
```

---

## Activity 2: Backend - Flask API (`app.py`)

```python
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
from datetime import datetime, timedelta
import json
import os
import bcrypt
import jwt
from functools import wraps

app = Flask(__name__, static_folder='static')

# Configuration
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')
app.config['DEBUG'] = os.environ.get('FLASK_ENV') == 'development'

# CORS configuration
CORS(app, origins=['http://localhost:5000', 'https://your-domain.com'], 
     supports_credentials=True)

# Data files
DATA_DIR = 'data'
USERS_FILE = os.path.join(DATA_DIR, 'users.json')
REQUESTS_FILE = os.path.join(DATA_DIR, 'requests.json')
ANNOUNCEMENTS_FILE = os.path.join(DATA_DIR, 'announcements.json')

# Ensure data directory exists
os.makedirs(DATA_DIR, exist_ok=True)

# Initialize data files if they don't exist
for file in [USERS_FILE, REQUESTS_FILE, ANNOUNCEMENTS_FILE]:
    if not os.path.exists(file):
        with open(file, 'w') as f:
            json.dump([], f)

# Helper functions
def read_json(filename):
    with open(filename, 'r') as f:
        return json.load(f)

def write_json(filename, data):
    with open(filename, 'w') as f:
        json.dump(data, f, indent=2)

def generate_token(user_id, role):
    payload = {
        'user_id': user_id,
        'role': role,
        'exp': datetime.utcnow() + timedelta(days=7)
    }
    return jwt.encode(payload, app.config['SECRET_KEY'], algorithm='HS256')

def verify_token(token):
    try:
        payload = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        return payload
    except jwt.ExpiredSignatureError:
        return None
    except jwt.InvalidTokenError:
        return None

# Auth decorator
def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.headers.get('Authorization')
        
        if not token:
            return jsonify({'error': 'Token is missing'}), 401
        
        if token.startswith('Bearer '):
            token = token[7:]
        
        payload = verify_token(token)
        
        if not payload:
            return jsonify({'error': 'Invalid or expired token'}), 401
        
        return f(payload, *args, **kwargs)
    
    return decorated

# Admin required decorator
def admin_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.headers.get('Authorization')
        
        if not token:
            return jsonify({'error': 'Token is missing'}), 401
        
        if token.startswith('Bearer '):
            token = token[7:]
        
        payload = verify_token(token)
        
        if not payload or payload.get('role') != 'admin':
            return jsonify({'error': 'Admin access required'}), 403
        
        return f(payload, *args, **kwargs)
    
    return decorated

# Serve static files
@app.route('/')
def index():
    return send_from_directory('static', 'index.html')

@app.route('/<path:path>')
def serve_static(path):
    return send_from_directory('static', path)

# Auth endpoints
@app.route('/api/register', methods=['POST'])
def register():
    data = request.json
    
    # Validate input
    required_fields = ['username', 'email', 'password', 'fullname']
    if not all(field in data for field in required_fields):
        return jsonify({'error': 'Missing required fields'}), 400
    
    users = read_json(USERS_FILE)
    
    # Check if username or email exists
    if any(u['username'] == data['username'] for u in users):
        return jsonify({'error': 'Username already exists'}), 400
    
    if any(u['email'] == data['email'] for u in users):
        return jsonify({'error': 'Email already exists'}), 400
    
    # Hash password
    password_hash = bcrypt.hashpw(data['password'].encode('utf-8'), bcrypt.gensalt())
    
    # Create user
    user = {
        'id': len(users) + 1,
        'username': data['username'],
        'email': data['email'],
        'password': password_hash.decode('utf-8'),
        'fullname': data['fullname'],
        'role': 'resident',  # Default role
        'created_at': datetime.now().isoformat()
    }
    
    users.append(user)
    write_json(USERS_FILE, users)
    
    # Generate token
    token = generate_token(user['id'], user['role'])
    
    return jsonify({
        'message': 'Registration successful',
        'token': token,
        'user': {
            'id': user['id'],
            'username': user['username'],
            'email': user['email'],
            'fullname': user['fullname'],
            'role': user['role']
        }
    }), 201

@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    
    if not data.get('username') or not data.get('password'):
        return jsonify({'error': 'Username and password required'}), 400
    
    users = read_json(USERS_FILE)
    
    # Find user
    user = next((u for u in users if u['username'] == data['username']), None)
    
    if not user:
        return jsonify({'error': 'Invalid credentials'}), 401
    
    # Check password
    if not bcrypt.checkpw(data['password'].encode('utf-8'), user['password'].encode('utf-8')):
        return jsonify({'error': 'Invalid credentials'}), 401
    
    # Generate token
    token = generate_token(user['id'], user['role'])
    
    return jsonify({
        'message': 'Login successful',
        'token': token,
        'user': {
            'id': user['id'],
            'username': user['username'],
            'email': user['email'],
            'fullname': user['fullname'],
            'role': user['role']
        }
    })

@app.route('/api/me', methods=['GET'])
@token_required
def get_current_user(payload):
    users = read_json(USERS_FILE)
    user = next((u for u in users if u['id'] == payload['user_id']), None)
    
    if not user:
        return jsonify({'error': 'User not found'}), 404
    
    return jsonify({
        'id': user['id'],
        'username': user['username'],
        'email': user['email'],
        'fullname': user['fullname'],
        'role': user['role']
    })

# Service request endpoints
@app.route('/api/requests', methods=['GET'])
@token_required
def get_requests(payload):
    requests_data = read_json(REQUESTS_FILE)
    
    # Filter by user if not admin
    if payload['role'] != 'admin':
        requests_data = [r for r in requests_data if r['user_id'] == payload['user_id']]
    
    return jsonify(requests_data)

@app.route('/api/requests', methods=['POST'])
@token_required
def create_request(payload):
    data = request.json
    
    required_fields = ['service_type', 'purpose']
    if not all(field in data for field in required_fields):
        return jsonify({'error': 'Missing required fields'}), 400
    
    requests_data = read_json(REQUESTS_FILE)
    
    # Generate tracking number
    tracking_number = f"BRG-{datetime.now().year}-{len(requests_data) + 1:05d}"
    
    new_request = {
        'id': len(requests_data) + 1,
        'tracking_number': tracking_number,
        'user_id': payload['user_id'],
        'service_type': data['service_type'],
        'purpose': data['purpose'],
        'status': 'pending',
        'created_at': datetime.now().isoformat(),
        'updated_at': datetime.now().isoformat()
    }
    
    requests_data.append(new_request)
    write_json(REQUESTS_FILE, requests_data)
    
    return jsonify({
        'message': 'Request submitted successfully',
        'request': new_request
    }), 201

@app.route('/api/requests/<int:request_id>', methods=['PUT'])
@admin_required
def update_request(payload, request_id):
    data = request.json
    requests_data = read_json(REQUESTS_FILE)
    
    request_item = next((r for r in requests_data if r['id'] == request_id), None)
    
    if not request_item:
        return jsonify({'error': 'Request not found'}), 404
    
    # Update status
    if 'status' in data:
        request_item['status'] = data['status']
    
    request_item['updated_at'] = datetime.now().isoformat()
    
    write_json(REQUESTS_FILE, requests_data)
    
    return jsonify({
        'message': 'Request updated successfully',
        'request': request_item
    })

@app.route('/api/requests/<int:request_id>', methods=['DELETE'])
@admin_required
def delete_request(payload, request_id):
    requests_data = read_json(REQUESTS_FILE)
    
    requests_data = [r for r in requests_data if r['id'] != request_id]
    
    write_json(REQUESTS_FILE, requests_data)
    
    return jsonify({'message': 'Request deleted successfully'})

# Admin analytics
@app.route('/api/admin/stats', methods=['GET'])
@admin_required
def get_stats(payload):
    users = read_json(USERS_FILE)
    requests_data = read_json(REQUESTS_FILE)
    
    stats = {
        'total_users': len(users),
        'total_requests': len(requests_data),
        'pending_requests': len([r for r in requests_data if r['status'] == 'pending']),
        'approved_requests': len([r for r in requests_data if r['status'] == 'approved']),
        'processing_requests': len([r for r in requests_data if r['status'] == 'processing']),
        'completed_requests': len([r for r in requests_data if r['status'] == 'completed']),
        'rejected_requests': len([r for r in requests_data if r['status'] == 'rejected'])
    }
    
    return jsonify(stats)

# Announcements
@app.route('/api/announcements', methods=['GET'])
def get_announcements():
    announcements = read_json(ANNOUNCEMENTS_FILE)
    return jsonify(announcements)

@app.route('/api/announcements', methods=['POST'])
@admin_required
def create_announcement(payload):
    data = request.json
    
    if not data.get('title') or not data.get('content'):
        return jsonify({'error': 'Title and content required'}), 400
    
    announcements = read_json(ANNOUNCEMENTS_FILE)
    
    announcement = {
        'id': len(announcements) + 1,
        'title': data['title'],
        'content': data['content'],
        'created_at': datetime.now().isoformat()
    }
    
    announcements.append(announcement)
    write_json(ANNOUNCEMENTS_FILE, announcements)
    
    return jsonify({
        'message': 'Announcement created',
        'announcement': announcement
    }), 201

# Health check
@app.route('/api/health')
def health_check():
    return jsonify({
        'status': 'healthy',
        'environment': os.environ.get('FLASK_ENV', 'production'),
        'timestamp': datetime.now().isoformat()
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=app.config['DEBUG'])
```

---

## Activity 3: Frontend - Landing Page (`static/index.html`)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Service Portal</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <nav>
            <div class="nav-container">
                <div class="logo">
                    <h1>🏛️ Barangay Portal</h1>
                </div>
                <ul class="nav-links">
                    <li><a href="#services">Services</a></li>
                    <li><a href="#about">About</a></li>
                    <li><a href="login.html" class="btn-login">Login</a></li>
                    <li><a href="register.html" class="btn-register">Register</a></li>
                </ul>
            </div>
        </nav>
    </header>

    <section class="hero">
        <div class="hero-content">
            <h1>Welcome to Online Barangay Service Portal</h1>
            <p>Request barangay documents online. Fast, easy, and convenient.</p>
            <a href="register.html" class="btn-primary">Get Started</a>
        </div>
    </section>

    <section id="services" class="services">
        <h2>Available Services</h2>
        <div class="service-grid">
            <div class="service-card">
                <div class="service-icon">📄</div>
                <h3>Barangay Clearance</h3>
                <p>Get your barangay clearance for various purposes</p>
            </div>
            <div class="service-card">
                <div class="service-icon">📋</div>
                <h3>Certificate of Residency</h3>
                <p>Proof of residency in the barangay</p>
            </div>
            <div class="service-card">
                <div class="service-icon">💼</div>
                <h3>Business Permit</h3>
                <p>Apply for barangay business permit</p>
            </div>
            <div class="service-card">
                <div class="service-icon">🏠</div>
                <h3>Certificate of Indigency</h3>
                <p>For financial assistance applications</p>
            </div>
            <div class="service-card">
                <div class="service-icon">👥</div>
                <h3>Barangay ID</h3>
                <p>Official barangay identification card</p>
            </div>
            <div class="service-card">
                <div class="service-icon">📝</div>
                <h3>Complaint Services</h3>
                <p>File barangay complaints online</p>
            </div>
        </div>
    </section>

    <section id="about" class="about">
        <h2>How It Works</h2>
        <div class="steps">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Register</h3>
                <p>Create your account</p>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <h3>Request</h3>
                <p>Submit your document request</p>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <h3>Track</h3>
                <p>Monitor your request status</p>
            </div>
            <div class="step">
                <div class="step-number">4</div>
                <h3>Receive</h3>
                <p>Get your documents</p>
            </div>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 Barangay Service Portal. All rights reserved.</p>
    </footer>

    <script src="js/config.js"></script>
</body>
</html>
```

---

## Activity 4: Authentication System (`static/js/auth.js`)

```javascript
// Authentication manager
const AuthManager = {
    // Check if logged in
    isLoggedIn() {
        return !!localStorage.getItem('authToken');
    },
    
    // Get token
    getToken() {
        return localStorage.getItem('authToken');
    },
    
    // Save token
    saveToken(token) {
        localStorage.setItem('authToken', token);
    },
    
    // Get user
    getUser() {
        const user = localStorage.getItem('currentUser');
        return user ? JSON.parse(user) : null;
    },
    
    // Save user
    saveUser(user) {
        localStorage.setItem('currentUser', JSON.stringify(user));
    },
    
    // Logout
    logout() {
        localStorage.removeItem('authToken');
        localStorage.removeItem('currentUser');
        window.location.href = '/login.html';
    },
    
    // Register
    async register(userData) {
        try {
            const response = await fetch(`${window.APP_CONFIG.API_URL}/api/register`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(userData)
            });
            
            const data = await response.json();
            
            if (!response.ok) {
                throw new Error(data.error || 'Registration failed');
            }
            
            // Save token and user
            this.saveToken(data.token);
            this.saveUser(data.user);
            
            return data;
            
        } catch (error) {
            throw error;
        }
    },
    
    // Login
    async login(username, password) {
        try {
            const response = await fetch(`${window.APP_CONFIG.API_URL}/api/login`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username, password })
            });
            
            const data = await response.json();
            
            if (!response.ok) {
                throw new Error(data.error || 'Login failed');
            }
            
            // Save token and user
            this.saveToken(data.token);
            this.saveUser(data.user);
            
            return data;
            
        } catch (error) {
            throw error;
        }
    },
    
    // Fetch with auth
    async fetchWithAuth(url, options = {}) {
        const token = this.getToken();
        
        if (!token) {
            throw new Error('Not authenticated');
        }
        
        options.headers = {
            ...options.headers,
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
        };
        
        const response = await fetch(url, options);
        
        // If unauthorized, logout
        if (response.status === 401) {
            this.logout();
            throw new Error('Session expired');
        }
        
        return response;
    },
    
    // Protect page (redirect if not logged in)
    protectPage() {
        if (!this.isLoggedIn()) {
            window.location.href = '/login.html';
        }
    },
    
    // Admin only
    requireAdmin() {
        this.protectPage();
        
        const user = this.getUser();
        if (!user || user.role !== 'admin') {
            alert('Access denied: Admin only');
            window.location.href = '/dashboard.html';
        }
    }
};
```

---

## Activity 5: Dashboard Implementation

**Create complete user dashboard with:**
- Service request form
- Request tracking table
- Status updates
- Document download

**Create complete admin dashboard with:**
- Analytics cards
- Request management
- User management
- Status update controls

---

## Activity 6: Deployment Checklist

**Before deploying:**

- [ ] Test all features locally
- [ ] Create `requirements.txt`
- [ ] Set up `.env` file
- [ ] Configure CORS for production domain
- [ ] Set `DEBUG=False`
- [ ] Test with production config
- [ ] Set up PostgreSQL (if using database)
- [ ] Create `render.yaml` or `vercel.json`
- [ ] Push to GitHub
- [ ] Deploy to Render/Vercel
- [ ] Test production deployment
- [ ] Configure custom domain (optional)

---

## 🎯 Project Requirements

**Must Have:**
1. ✅ User registration and login
2. ✅ Service request submission
3. ✅ Request tracking with status
4. ✅ Admin dashboard
5. ✅ Responsive design
6. ✅ Local storage integration
7. ✅ Deployed to production

**Nice to Have:**
- File upload for supporting documents
- Email notifications
- PDF generation for certificates
- Payment integration
- Real-time updates with WebSockets
- Multi-language support (English/Filipino)

---

## 🚀 Next Steps After Completion

1. **Add more features** - Payment, notifications, file uploads
2. **Improve UX** - Better animations, loading states
3. **Optimize performance** - Caching, lazy loading
4. **Add testing** - Unit tests, integration tests
5. **Monitor** - Set up error tracking (Sentry)
6. **Scale** - Load balancing, CDN
7. **Mobile app** - React Native or Flutter version

---

Congratulations on completing the HTML, CSS, JavaScript, and Python (Flask) course! 🎉

You now have the skills to build full-stack web applications from scratch and deploy them to production.

**Happy coding!**