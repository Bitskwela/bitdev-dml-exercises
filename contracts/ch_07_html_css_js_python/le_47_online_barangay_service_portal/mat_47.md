# Lesson 47: Online Barangay Service Portal - Final Project

**Course 14: Advanced Web App Development**  
**Project Type:** Full-Stack Web Application  
**Difficulty:** Advanced  
**Estimated Time:** 8-12 hours

---

## Background Story: The Final Challenge

Buwan ng Disyembre. Malamig na simoy ng hangin sa Batangas, pero mainit ang puso ni Tian. For the past 46 lessons, from learning what the internet is to deploying apps on the cloud, he has come so far.

"Tian, pwede ba kausapin kita?" Captain Cruz calls him to the barangay hall.

Tian enters nervously. Captain Cruz has that serious look again.

"Tingnan mo 'to," Captain Cruz opens a laptop showing the deployed barangay portal. "Your demo works perfectly. The residents have been asking when they can start using it."

Tian's heart races. "So... gusto na nila gamitin?"

"Hindi lang 'gusto,' Tian. They **need** it." Captain Cruz pulls up a list of handwritten requests. "Ang dami na naming backlog. Complaints, document requests, announcements na hindi naaabot sa lahat. This system you built — this could change everything."

Kuya Miguel, standing in the corner with a proud smile, speaks up. "Tian, you've learned all the fundamentals. Now it's time to put it all together. Build the **complete** Barangay Service Portal — authentication, multiple modules, resident profiles, everything."

Captain Cruz nods. "We need it to handle complaints, announcements, document requests, and resident records. Can you do it?"

Tian takes a deep breath. This is it. His final project. Everything he learned from Lesson 1 to Lesson 46 will be used here.

"Yes, Captain. I'll build it."

---

## What You'll Build

### The Complete Online Barangay Service Portal

A **full-featured web application** that serves the entire barangay with these modules:

1. **User Authentication System**
   - Registration and login
   - Role-based access (Admin, Staff, Resident)
   - Password recovery

2. **Complaints Module**
   - Residents can file complaints
   - Track complaint status
   - Admin can assign staff and update status

3. **Announcements Module**
   - Admin posts barangay announcements
   - Residents view announcements on homepage
   - Categories (Health, Safety, Events, etc.)

4. **Document Request Module**
   - Residents request barangay documents (Barangay Clearance, Indigency, etc.)
   - Track request status
   - Admin can approve/reject requests

5. **Resident Profile Module**
   - Complete profile information
   - Household members
   - Contact details

6. **Dashboard**
   - Admin: Overview of all activities
   - Resident: Their complaints, requests, and announcements

---

## Project Requirements

### Core Features (Must Have)

**1. User Authentication**
- Registration with email verification (optional, but recommended)
- Login/Logout
- Password hashing with werkzeug
- Session management
- Protected routes

**2. Database Models**
- User (id, username, email, password_hash, role, created_at)
- Complaint (id, user_id, category, description, status, created_at, updated_at)
- Announcement (id, title, content, category, author_id, created_at)
- DocumentRequest (id, user_id, document_type, purpose, status, created_at)
- ResidentProfile (id, user_id, full_name, address, phone, birthdate)

**3. CRUD Operations**
- Create, Read, Update, Delete for all modules
- Forms with validation
- Error handling

**4. Role-Based Access**
- **Admin:** Full access, manage all modules
- **Staff:** View and update complaints/requests
- **Resident:** View own data, file complaints/requests

**5. Responsive Design**
- Mobile-friendly layout
- Works on phone, tablet, desktop
- Clean and modern UI

**6. Deployment**
- Deployed on Render (backend)
- Environment variables properly configured
- PostgreSQL database
- HTTPS enabled

---

## Project Structure

```
barangay_portal/
│
├── app.py                    # Main Flask application
├── models.py                 # Database models
├── forms.py                  # WTForms for validation
├── config.py                 # Configuration classes
├── requirements.txt          # Dependencies
├── Procfile                  # For Render deployment
├── runtime.txt               # Python version
├── .env                      # Environment variables (DO NOT COMMIT)
├── .gitignore                # Ignore sensitive files
│
├── templates/
│   ├── base.html             # Base template with navbar
│   ├── index.html            # Homepage
│   ├── login.html
│   ├── register.html
│   ├── dashboard.html
│   ├── complaints/
│   │   ├── list.html
│   │   ├── create.html
│   │   ├── detail.html
│   ├── announcements/
│   │   ├── list.html
│   │   ├── create.html
│   ├── documents/
│   │   ├── list.html
│   │   ├── request.html
│   └── profile/
│       ├── view.html
│       └── edit.html
│
├── static/
│   ├── css/
│   │   └── style.css         # Custom styles
│   ├── js/
│   │   └── main.js           # Custom JavaScript
│   └── images/
│       └── logo.png
│
└── migrations/               # Database migrations (Flask-Migrate)
```

---

## Step-by-Step Implementation

### Phase 1: Project Setup (1 hour)

**1. Create Virtual Environment**
```bash
python -m venv venv
venv\Scripts\activate  # Windows
```

**2. Install Dependencies**
```bash
pip install flask flask-sqlalchemy flask-login flask-wtf flask-migrate python-dotenv gunicorn psycopg2-binary
```

**3. Create Project Structure**
Create all folders and files as shown above.

**4. Setup Environment Variables (.env)**
```
SECRET_KEY=your-super-secret-key-here
DATABASE_URL=sqlite:///barangay.db
FLASK_ENV=development
```

---

### Phase 2: Database Models (2 hours)

**models.py**
```python
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

db = SQLAlchemy()

class User(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)
    role = db.Column(db.String(20), default='resident')  # admin, staff, resident
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    complaints = db.relationship('Complaint', backref='author', lazy=True)
    document_requests = db.relationship('DocumentRequest', backref='requester', lazy=True)
    profile = db.relationship('ResidentProfile', backref='user', uselist=False)
    
    def set_password(self, password):
        self.password_hash = generate_password_hash(password)
    
    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

class Complaint(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    category = db.Column(db.String(50), nullable=False)
    title = db.Column(db.String(200), nullable=False)
    description = db.Column(db.Text, nullable=False)
    status = db.Column(db.String(20), default='pending')  # pending, in_progress, resolved
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

class Announcement(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    content = db.Column(db.Text, nullable=False)
    category = db.Column(db.String(50), nullable=False)
    author_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

class DocumentRequest(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    document_type = db.Column(db.String(100), nullable=False)
    purpose = db.Column(db.Text, nullable=False)
    status = db.Column(db.String(20), default='pending')  # pending, approved, rejected, ready
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

class ResidentProfile(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    full_name = db.Column(db.String(200), nullable=False)
    address = db.Column(db.String(300), nullable=False)
    phone = db.Column(db.String(20))
    birthdate = db.Column(db.Date)
```

---

### Phase 3: Authentication System (2 hours)

**app.py (Authentication Routes)**
```python
from flask import Flask, render_template, request, redirect, url_for, flash
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from models import db, User
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        
        # Check if user exists
        if User.query.filter_by(username=username).first():
            flash('Username already exists')
            return redirect(url_for('register'))
        
        # Create new user
        user = User(username=username, email=email)
        user.set_password(password)
        db.session.add(user)
        db.session.commit()
        
        flash('Registration successful! Please login.')
        return redirect(url_for('login'))
    
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        
        user = User.query.filter_by(username=username).first()
        
        if user and user.check_password(password):
            login_user(user)
            flash('Login successful!')
            return redirect(url_for('dashboard'))
        else:
            flash('Invalid username or password')
    
    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('You have been logged out.')
    return redirect(url_for('index'))

@app.route('/dashboard')
@login_required
def dashboard():
    return render_template('dashboard.html')

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
```

---

### Phase 4: Complaints Module (2 hours)

**Complaints Routes in app.py**
```python
from models import Complaint

@app.route('/complaints')
@login_required
def complaints_list():
    if current_user.role == 'admin' or current_user.role == 'staff':
        complaints = Complaint.query.all()
    else:
        complaints = Complaint.query.filter_by(user_id=current_user.id).all()
    return render_template('complaints/list.html', complaints=complaints)

@app.route('/complaints/create', methods=['GET', 'POST'])
@login_required
def create_complaint():
    if request.method == 'POST':
        title = request.form['title']
        category = request.form['category']
        description = request.form['description']
        
        complaint = Complaint(
            user_id=current_user.id,
            title=title,
            category=category,
            description=description
        )
        db.session.add(complaint)
        db.session.commit()
        
        flash('Complaint filed successfully!')
        return redirect(url_for('complaints_list'))
    
    return render_template('complaints/create.html')

@app.route('/complaints/<int:id>')
@login_required
def complaint_detail(id):
    complaint = Complaint.query.get_or_404(id)
    
    # Check if user has access
    if current_user.role not in ['admin', 'staff'] and complaint.user_id != current_user.id:
        flash('Access denied')
        return redirect(url_for('complaints_list'))
    
    return render_template('complaints/detail.html', complaint=complaint)

@app.route('/complaints/<int:id>/update', methods=['POST'])
@login_required
def update_complaint_status(id):
    if current_user.role not in ['admin', 'staff']:
        flash('Access denied')
        return redirect(url_for('complaints_list'))
    
    complaint = Complaint.query.get_or_404(id)
    complaint.status = request.form['status']
    db.session.commit()
    
    flash('Complaint status updated!')
    return redirect(url_for('complaint_detail', id=id))
```

**templates/complaints/list.html**
```html
{% extends 'base.html' %}

{% block content %}
<div class="container">
    <h1>Complaints</h1>
    <a href="{{ url_for('create_complaint') }}" class="btn btn-primary">File New Complaint</a>
    
    <div class="complaints-list">
        {% for complaint in complaints %}
        <div class="complaint-card">
            <h3>{{ complaint.title }}</h3>
            <p><strong>Category:</strong> {{ complaint.category }}</p>
            <p><strong>Status:</strong> 
                <span class="badge badge-{{ 'success' if complaint.status == 'resolved' else 'warning' }}">
                    {{ complaint.status }}
                </span>
            </p>
            <p><small>Filed on {{ complaint.created_at.strftime('%B %d, %Y') }}</small></p>
            <a href="{{ url_for('complaint_detail', id=complaint.id) }}" class="btn btn-sm btn-info">View Details</a>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock %}
```

---

### Phase 5: Announcements Module (1.5 hours)

**Announcements Routes**
```python
from models import Announcement

@app.route('/announcements')
def announcements_list():
    announcements = Announcement.query.order_by(Announcement.created_at.desc()).all()
    return render_template('announcements/list.html', announcements=announcements)

@app.route('/announcements/create', methods=['GET', 'POST'])
@login_required
def create_announcement():
    if current_user.role != 'admin':
        flash('Only admins can create announcements')
        return redirect(url_for('announcements_list'))
    
    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']
        category = request.form['category']
        
        announcement = Announcement(
            title=title,
            content=content,
            category=category,
            author_id=current_user.id
        )
        db.session.add(announcement)
        db.session.commit()
        
        flash('Announcement posted!')
        return redirect(url_for('announcements_list'))
    
    return render_template('announcements/create.html')
```

---

### Phase 6: Document Requests Module (1.5 hours)

**Document Request Routes**
```python
from models import DocumentRequest

@app.route('/documents')
@login_required
def documents_list():
    if current_user.role in ['admin', 'staff']:
        requests = DocumentRequest.query.all()
    else:
        requests = DocumentRequest.query.filter_by(user_id=current_user.id).all()
    return render_template('documents/list.html', requests=requests)

@app.route('/documents/request', methods=['GET', 'POST'])
@login_required
def request_document():
    if request.method == 'POST':
        document_type = request.form['document_type']
        purpose = request.form['purpose']
        
        doc_request = DocumentRequest(
            user_id=current_user.id,
            document_type=document_type,
            purpose=purpose
        )
        db.session.add(doc_request)
        db.session.commit()
        
        flash('Document request submitted!')
        return redirect(url_for('documents_list'))
    
    return render_template('documents/request.html')

@app.route('/documents/<int:id>/update', methods=['POST'])
@login_required
def update_document_status(id):
    if current_user.role not in ['admin', 'staff']:
        flash('Access denied')
        return redirect(url_for('documents_list'))
    
    doc_request = DocumentRequest.query.get_or_404(id)
    doc_request.status = request.form['status']
    db.session.commit()
    
    flash('Document request status updated!')
    return redirect(url_for('documents_list'))
```

---

### Phase 7: Resident Profile (1 hour)

**Profile Routes**
```python
from models import ResidentProfile

@app.route('/profile')
@login_required
def view_profile():
    profile = ResidentProfile.query.filter_by(user_id=current_user.id).first()
    return render_template('profile/view.html', profile=profile)

@app.route('/profile/edit', methods=['GET', 'POST'])
@login_required
def edit_profile():
    profile = ResidentProfile.query.filter_by(user_id=current_user.id).first()
    
    if request.method == 'POST':
        if not profile:
            profile = ResidentProfile(user_id=current_user.id)
        
        profile.full_name = request.form['full_name']
        profile.address = request.form['address']
        profile.phone = request.form['phone']
        profile.birthdate = datetime.strptime(request.form['birthdate'], '%Y-%m-%d').date()
        
        db.session.add(profile)
        db.session.commit()
        
        flash('Profile updated!')
        return redirect(url_for('view_profile'))
    
    return render_template('profile/edit.html', profile=profile)
```

---

### Phase 8: Dashboard with Statistics (1 hour)

**Enhanced Dashboard**
```python
@app.route('/dashboard')
@login_required
def dashboard():
    if current_user.role == 'admin':
        total_users = User.query.count()
        total_complaints = Complaint.query.count()
        pending_complaints = Complaint.query.filter_by(status='pending').count()
        total_doc_requests = DocumentRequest.query.count()
        pending_requests = DocumentRequest.query.filter_by(status='pending').count()
        
        stats = {
            'total_users': total_users,
            'total_complaints': total_complaints,
            'pending_complaints': pending_complaints,
            'total_doc_requests': total_doc_requests,
            'pending_requests': pending_requests
        }
        return render_template('dashboard.html', stats=stats)
    
    else:
        my_complaints = Complaint.query.filter_by(user_id=current_user.id).all()
        my_requests = DocumentRequest.query.filter_by(user_id=current_user.id).all()
        return render_template('dashboard.html', 
                             complaints=my_complaints, 
                             requests=my_requests)
```

---

### Phase 9: Responsive Frontend (2 hours)

**base.html Template**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}Barangay Service Portal{% endblock %}</title>
    <link rel="stylesheet" href="{{ url_for('static', filename='css/style.css') }}">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="{{ url_for('index') }}" class="logo">🏘️ Barangay Portal</a>
            <ul class="nav-links">
                <li><a href="{{ url_for('index') }}">Home</a></li>
                <li><a href="{{ url_for('announcements_list') }}">Announcements</a></li>
                {% if current_user.is_authenticated %}
                    <li><a href="{{ url_for('dashboard') }}">Dashboard</a></li>
                    <li><a href="{{ url_for('complaints_list') }}">Complaints</a></li>
                    <li><a href="{{ url_for('documents_list') }}">Documents</a></li>
                    <li><a href="{{ url_for('view_profile') }}">Profile</a></li>
                    <li><a href="{{ url_for('logout') }}">Logout</a></li>
                {% else %}
                    <li><a href="{{ url_for('login') }}">Login</a></li>
                    <li><a href="{{ url_for('register') }}">Register</a></li>
                {% endif %}
            </ul>
        </div>
    </nav>

    <main>
        {% with messages = get_flashed_messages() %}
            {% if messages %}
                <div class="flash-messages">
                    {% for message in messages %}
                        <div class="alert">{{ message }}</div>
                    {% endfor %}
                </div>
            {% endif %}
        {% endwith %}
        
        {% block content %}{% endblock %}
    </main>

    <footer>
        <p>&copy; 2025 Barangay Service Portal. Made with 💙 by Tian</p>
    </footer>

    <script src="{{ url_for('static', filename='js/main.js') }}"></script>
</body>
</html>
```

**static/css/style.css**
```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #f5f5f5;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

/* Navbar */
.navbar {
    background: #1a73e8;
    color: white;
    padding: 1rem 0;
}

.navbar .container {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
    color: white;
    text-decoration: none;
}

.nav-links {
    list-style: none;
    display: flex;
    gap: 20px;
}

.nav-links a {
    color: white;
    text-decoration: none;
    padding: 5px 10px;
    border-radius: 5px;
    transition: background 0.3s;
}

.nav-links a:hover {
    background: rgba(255, 255, 255, 0.2);
}

/* Cards */
.complaint-card, .announcement-card, .request-card {
    background: white;
    padding: 20px;
    margin: 15px 0;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

/* Buttons */
.btn {
    padding: 10px 20px;
    background: #1a73e8;
    color: white;
    border: none;
    border-radius: 5px;
    text-decoration: none;
    display: inline-block;
    cursor: pointer;
}

.btn:hover {
    background: #1557b0;
}

/* Forms */
form {
    background: white;
    padding: 30px;
    border-radius: 8px;
    max-width: 600px;
}

input, textarea, select {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
}

/* Responsive */
@media (max-width: 768px) {
    .nav-links {
        flex-direction: column;
    }
    
    .navbar .container {
        flex-direction: column;
    }
}
```

---

### Phase 10: Deployment to Render (1 hour)

**1. Create requirements.txt**
```
Flask==2.3.0
Flask-SQLAlchemy==3.0.5
Flask-Login==0.6.2
Flask-WTF==1.1.1
Flask-Migrate==4.0.4
python-dotenv==1.0.0
gunicorn==21.2.0
psycopg2-binary==2.9.6
```

**2. Create Procfile**
```
web: gunicorn app:app
```

**3. Create runtime.txt**
```
python-3.11.0
```

**4. Update app.py for Production**
```python
import os

# ... existing code ...

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
```

**5. Deploy to Render**
- Push code to GitHub
- Create new Web Service on Render
- Connect GitHub repository
- Add environment variables (SECRET_KEY, DATABASE_URL)
- Add PostgreSQL database
- Deploy!

---

## Testing Checklist

Before submitting, test all features:

- [ ] User can register
- [ ] User can login/logout
- [ ] Admin can see all complaints
- [ ] Resident can only see their own complaints
- [ ] User can file a complaint
- [ ] Admin can update complaint status
- [ ] Admin can create announcements
- [ ] All users can view announcements
- [ ] User can request documents
- [ ] Admin can update document request status
- [ ] User can view and edit their profile
- [ ] Dashboard shows correct statistics
- [ ] All pages are responsive (test on phone)
- [ ] Flash messages appear correctly
- [ ] All forms validate input
- [ ] Database persists data correctly
- [ ] Deployed app works on Render
- [ ] HTTPS is enabled

---

## Enhancement Ideas (Optional)

Want to level up your project? Add these features:

1. **Email Notifications** - Send email when complaint is resolved
2. **SMS Notifications** - Using Twilio or Semaphore API
3. **File Uploads** - Attach photos to complaints
4. **Search and Filter** - Search complaints by category or status
5. **Analytics Dashboard** - Charts showing complaint trends
6. **Multi-language Support** - Tagalog and English
7. **Real-time Updates** - Using WebSockets or AJAX
8. **Export to PDF** - Download barangay clearance as PDF
9. **QR Code Verification** - For document authenticity
10. **Mobile App** - Using React Native or Flutter

---

## Common Issues and Solutions

### Issue 1: Database Not Found
**Error:** `sqlalchemy.exc.OperationalError: no such table`

**Solution:**
```python
with app.app_context():
    db.create_all()
```

### Issue 2: User Not Logging In
**Error:** `Unauthorized` or redirects to login repeatedly

**Solution:** Check if `login_manager.login_view` is set:
```python
login_manager.login_view = 'login'
```

### Issue 3: CORS Errors in Production
**Error:** `Access-Control-Allow-Origin` error

**Solution:** Install Flask-CORS:
```bash
pip install flask-cors
```
```python
from flask_cors import CORS
CORS(app)
```

### Issue 4: Environment Variables Not Loading
**Solution:** Make sure `.env` is in the root directory and `python-dotenv` is installed.

### Issue 5: Static Files Not Loading in Production
**Solution:** Check static file paths use `url_for('static', filename='...')`

---

## Submission Requirements

Submit the following:

1. **GitHub Repository Link** - Public repo with all code
2. **Deployed App URL** - Working link to your Render deployment
3. **Admin Credentials** - Username and password to test admin features
4. **Demo Video** (Optional) - 5-minute walkthrough of features
5. **README.md** - Project description, features, setup instructions

**README.md Template:**
```markdown
# Barangay Service Portal

A full-stack web application for barangay management and resident services.

## Features
- User authentication and role-based access
- Complaints management system
- Announcements module
- Document request processing
- Resident profiles

## Tech Stack
- Backend: Flask (Python)
- Database: PostgreSQL
- Frontend: HTML, CSS, JavaScript
- Deployment: Render

## Setup Instructions
1. Clone the repository
2. Create virtual environment: `python -m venv venv`
3. Activate: `venv\Scripts\activate`
4. Install dependencies: `pip install -r requirements.txt`
5. Create `.env` file with SECRET_KEY and DATABASE_URL
6. Run: `python app.py`

## Live Demo
[https://barangay-portal.onrender.com](https://barangay-portal.onrender.com)

## Admin Credentials
- Username: admin
- Password: (provided separately)

## Author
Tian - Grade 10 Student, Batangas
```

---

## Grading Rubric (100 Points) 

| Category | Points | Criteria |
|----------|--------|----------|
| **Functionality** | 40 | All modules work correctly, no major bugs |
| **Code Quality** | 20 | Clean code, proper structure, comments |
| **Design** | 15 | Responsive, user-friendly UI |
| **Security** | 10 | Password hashing, input validation, protected routes |
| **Deployment** | 10 | Successfully deployed and accessible |
| **Documentation** | 5 | Clear README with setup instructions |

**Bonus Points (up to +10):**
- Email/SMS notifications (+3)
- File uploads (+3)
- Real-time updates (+2)
- Charts/Analytics (+2)

---

## Resources

**Official Documentation:**
- Flask: https://flask.palletsprojects.com/
- SQLAlchemy: https://www.sqlalchemy.org/
- Flask-Login: https://flask-login.readthedocs.io/
- Render: https://render.com/docs

**Tutorials:**
- Flask Mega-Tutorial: https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-i-hello-world
- Real Python Flask: https://realpython.com/tutorials/flask/

**Design Inspiration:**
- Bootstrap: https://getbootstrap.com/
- Tailwind CSS: https://tailwindcss.com/

---

## Tips for Success

1. **Start Small** - Build one module at a time, test thoroughly
2. **Commit Often** - Push to GitHub after each working feature
3. **Test on Multiple Devices** - Phone, tablet, desktop
4. **Ask for Help** - Use Stack Overflow, GitHub Discussions, or ask Kuya Miguel
5. **Read Error Messages** - They tell you exactly what's wrong
6. **Use Browser DevTools** - Inspect elements, check console for errors
7. **Keep Learning** - This is just the beginning!

---

## Final Thoughts

This project represents everything you've learned from Lesson 1 to Lesson 46:

- **Lesson 1-5:** How the internet works (you're deploying on it!)
- **Lesson 6-11:** HTML structure (all your templates)
- **Lesson 12-18:** CSS styling (beautiful UI)
- **Lesson 19-22:** Responsive design (mobile-friendly)
- **Lesson 23-29:** JavaScript logic (interactivity)
- **Lesson 30-36:** Modern JS, APIs (fetch requests)
- **Lesson 37-42:** Flask, CRUD operations (full backend)
- **Lesson 43:** Authentication (secure login system)
- **Lesson 44:** Environment variables (production config)
- **Lesson 45:** Local storage (user preferences)
- **Lesson 46:** Deployment (live on the internet!)

You've come so far. This final project is your chance to show what you can build.

**Build something amazing. Build something useful. Build something that matters.** 🚀

---

## Closing Story: The Launch Day

Three weeks later. January 15, 2025.

Tian sits nervously in the barangay hall. Captain Cruz has called a meeting with all the barangay officials, kagawads, and even some residents. There's a projector screen set up.

"Maupo na kayo," Captain Cruz begins. "Today, we're launching something that will change how our barangay operates."

Tian's hands are shaking. He built this. He actually built this.

Captain Cruz clicks the projector. The screen lights up showing the homepage of the **Online Barangay Service Portal**, proudly displaying "barangay-santacruz-batangas.ph" in the address bar.

"This system," Captain Cruz continues, "was built by one of our own residents. Tian, a Grade 10 student, spent months learning web development and created this portal for us."

The room murmurs in amazement.

Captain Cruz demonstrates the features:
- "Residents can now file complaints online — no more handwritten forms."
- "They can request barangay clearance and track the status — no more coming back multiple times."
- "We post announcements here — no more missed notices."

He shows a real example. Mrs. Santos' streetlight complaint from three days ago, now marked as "Resolved" with a photo of the fixed light.

"Grabe naman, Tian!" one kagawad exclaims. "Parang professional app!"

Tian blushes. Kuya Miguel, standing at the back, gives him a proud thumbs up.

Captain Cruz turns to Tian. "Stand up, Tian."

Tian stands, feeling the weight of everyone's eyes.

"You didn't just learn web development. You built something that serves our community. You took a problem and created a solution. That's what real developers do."

The room erupts in applause. Tian's eyes water a bit.

After the presentation, residents crowd around him:
- "Pwede ba lagyan ng feature for garbage collection schedule?"
- "Can we report potholes through this?"
- "I want to learn this too! Can you teach me?"

That evening, Tian sits on their terrace with Kuya Miguel, watching the sun set over Batangas. The deployed portal is live, and he's already received 23 new user registrations and 5 complaints filed.

"Kuya, nung nag-start tayo sa Lesson 1, HTML lang ang alam ko. Ngayon, buong system na nagawa ko," Tian says in disbelief.

Kuya Miguel grins. "That's the power of learning step by step. From `<h1>Hello World</h1>` to a full-stack deployed application. You did that."

"Pero 'di ko pa alam lahat, Kuya. Marami pa akong hindi alam," Tian admits.

"And that's okay. Real developers don't know everything. They know how to learn, how to solve problems, and how to build things that matter. You've proven you can do all three."

Tian opens his laptop. In his browser:
- **Tab 1:** Render Dashboard (showing 147 requests to the portal today)
- **Tab 2:** GitHub Repository (37 commits, 2 stars already)
- **Tab 3:** Stack Overflow (still learning, still asking questions)
- **Tab 4:** A new blank file: `mobile_app_ideas.md`

Because one deployment isn't the end. It's just the beginning.

"Kuya, next ko gagawin... mobile app version ng portal," Tian says with determination.

Kuya Miguel laughs. "There's the Tian I know. Always ready for the next challenge."

As the stars appear over Batangas, the portal's server logs continue scrolling:
```
[INFO] User registered: maria_santos
[INFO] Complaint filed: Street flooding in Purok 3
[INFO] Document requested: Barangay Clearance
[INFO] Announcement viewed: 142 times
```

Each log line represents a resident whose life is a little easier because a Grade 10 student decided to learn web development.

**The internet isn't just for browsing anymore. It's for building. It's for solving. It's for serving.**

And Tian? He's no longer just learning. He's creating.

---

## Congratulations!

**You've completed Course 14: Advanced Web App Development**  
**You've completed the entire HTML/CSS/JS/Python curriculum (Lesson 1-47)**

**You are now a full-stack web developer.**

From understanding how the internet works, to writing your first HTML tag, to styling with CSS, to adding interactivity with JavaScript, to building backends with Flask, to deploying production applications — you've done it all.

**This is not the end. This is where the real journey begins.**

The world needs builders. The world needs problem-solvers. The world needs people like you.

**Go build something amazing.**

---

_Salamat sa lahat ng nag-aral kasama natin. Kayo ang pag-asa ng digital future ng Pilipinas!_ 🇵🇭

**— End of Course 14 —**  
**— End of HTML/CSS/JS/Python Curriculum —**

---
The future is bright. Keep building. Keep learning. Keep shipping.