# Lesson 42: Final Project - Barangay Complaint System

---

## Building Your Complete Full-Stack Application

"Kuya Miguel, we've learned all the pieces—HTML, CSS, JavaScript, DOM, events, APIs, Flask, CRUD. Can we build something real now?" Tian asked eagerly.

Rhea Joy nodded. "Something that actually works—a complete system residents can use!"

Kuya Miguel smiled proudly. "Absolutely! Let's build the **Barangay Complaint System**—a full-stack application where residents can submit complaints, view all submissions, update statuses, and delete resolved cases. This is your capstone project!"

---

## Project Overview

**Features:**
1. **Submit Complaints** - Form with name, category, description
2. **View All Complaints** - Dynamic list with live updates
3. **Update Status** - Mark complaints as resolved
4. **Delete Complaints** - Remove completed cases
5. **Responsive Design** - Works on all devices
6. **Error Handling** - Graceful failures with user feedback

**Tech Stack:**
- **Backend:** Python Flask (REST API)
- **Frontend:** HTML, CSS, JavaScript (ES6+)
- **Data:** In-memory storage (ready for database)
- **API:** Full CRUD operations

---

## Complete Implementation

### Flask Backend (app.py)

```python
from flask import Flask, render_template, request, jsonify
from datetime import datetime

app = Flask(__name__)

# Data storage
complaints = []
next_id = 1

@app.route('/')
def home():
    """Serve the main application page"""
    return render_template('index.html')

# CREATE - Submit new complaint
@app.route('/api/complaints', methods=['POST'])
def create_complaint():
    """
    POST /api/complaints
    Body: {name, category, description}
    Returns: Created complaint object
    """
    global next_id
    
    try:
        data = request.get_json()
        
        # Validate required fields
        if not data.get('name'):
            return jsonify({'error': 'Name is required'}), 400
        if not data.get('category'):
            return jsonify({'error': 'Category is required'}), 400
        if not data.get('description'):
            return jsonify({'error': 'Description is required'}), 400
        
        # Create complaint record
        complaint = {
            'id': next_id,
            'name': data['name'],
            'category': data['category'],
            'description': data['description'],
            'status': 'pending',
            'date': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        
        complaints.append(complaint)
        next_id += 1
        
        return jsonify(complaint), 201
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# READ - Get all complaints
@app.route('/api/complaints', methods=['GET'])
def get_complaints():
    """
    GET /api/complaints
    Returns: List of all complaints
    """
    return jsonify(complaints)

# READ - Get single complaint
@app.route('/api/complaints/<int:complaint_id>', methods=['GET'])
def get_complaint(complaint_id):
    """
    GET /api/complaints/:id
    Returns: Single complaint or 404
    """
    complaint = next((c for c in complaints if c['id'] == complaint_id), None)
    
    if complaint:
        return jsonify(complaint)
    else:
        return jsonify({'error': 'Complaint not found'}), 404

# UPDATE - Change complaint status
@app.route('/api/complaints/<int:complaint_id>', methods=['PUT'])
def update_complaint(complaint_id):
    """
    PUT /api/complaints/:id
    Body: {status}
    Returns: Updated complaint or 404
    """
    complaint = next((c for c in complaints if c['id'] == complaint_id), None)
    
    if not complaint:
        return jsonify({'error': 'Complaint not found'}), 404
    
    data = request.get_json()
    
    # Update status
    if 'status' in data:
        complaint['status'] = data['status']
    
    return jsonify(complaint)

# DELETE - Remove complaint
@app.route('/api/complaints/<int:complaint_id>', methods=['DELETE'])
def delete_complaint(complaint_id):
    """
    DELETE /api/complaints/:id
    Returns: Success message or 404
    """
    global complaints
    
    complaint = next((c for c in complaints if c['id'] == complaint_id), None)
    
    if not complaint:
        return jsonify({'error': 'Complaint not found'}), 404
    
    complaints = [c for c in complaints if c['id'] != complaint_id]
    
    return jsonify({'message': 'Complaint deleted successfully'})

if __name__ == '__main__':
    app.run(debug=True, port=5000)
```

---

### Frontend HTML (templates/index.html)

See Lesson 38 mat_38.md for the complete HTML implementation including:
- Form structure with validation
- Dynamic complaints display grid
- Status indicators and action buttons
- Responsive CSS styling
- Complete JavaScript integration

**Key sections:**
1. **Form Section** - Submit new complaints
2. **Display Section** - Show all complaints in cards
3. **Styling** - Professional responsive design
4. **JavaScript** - Full CRUD functionality

---

## JavaScript Frontend Logic

```javascript
// Global state
let complaints = [];

// DOM Elements
const form = document.querySelector('#complaintForm');
const nameInput = document.querySelector('#name');
const categorySelect = document.querySelector('#category');
const descriptionTextarea = document.querySelector('#description');
const messageDiv = document.querySelector('#message');
const complaintsContainer = document.querySelector('#complaintsList');

// Initialize app
document.addEventListener('DOMContentLoaded', () => {
    loadComplaints();
    setupEventListeners();
});

// Setup event listeners
function setupEventListeners() {
    form.addEventListener('submit', handleSubmit);
}

// Handle form submission
async function handleSubmit(e) {
    e.preventDefault();
    
    // Collect form data
    const complaintData = {
        name: nameInput.value.trim(),
        category: categorySelect.value,
        description: descriptionTextarea.value.trim()
    };
    
    // Validate
    if (!complaintData.name || !complaintData.category || !complaintData.description) {
        showMessage('Please fill all fields', 'error');
        return;
    }
    
    try {
        // Send to backend
        const response = await fetch('/api/complaints', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(complaintData)
        });
        
        if (!response.ok) {
            const error = await response.json();
            throw new Error(error.error || 'Failed to submit complaint');
        }
        
        const result = await response.json();
        
        // Success
        showMessage('Complaint submitted successfully!', 'success');
        form.reset();
        
        // Reload complaints
        await loadComplaints();
        
    } catch (error) {
        showMessage('Error: ' + error.message, 'error');
    }
}

// Load all complaints
async function loadComplaints() {
    try {
        const response = await fetch('/api/complaints');
        
        if (!response.ok) {
            throw new Error('Failed to load complaints');
        }
        
        complaints = await response.json();
        displayComplaints();
        
    } catch (error) {
        complaintsContainer.innerHTML = `
            <div class="error">
                <p>Error loading complaints: ${error.message}</p>
                <button onclick="loadComplaints()">Retry</button>
            </div>
        `;
    }
}

// Display complaints in UI
function displayComplaints() {
    if (complaints.length === 0) {
        complaintsContainer.innerHTML = `
            <div class="empty-state">
                <p>No complaints submitted yet.</p>
                <p>Be the first to submit a complaint!</p>
            </div>
        `;
        return;
    }
    
    // Sort by date (newest first)
    const sorted = [...complaints].sort((a, b) => 
        new Date(b.date) - new Date(a.date)
    );
    
    complaintsContainer.innerHTML = sorted.map(complaint => `
        <div class="complaint-card" data-id="${complaint.id}">
            <div class="complaint-header">
                <h3>Complaint #${complaint.id}</h3>
                <span class="status status-${complaint.status}">
                    ${complaint.status.toUpperCase()}
                </span>
            </div>
            
            <div class="complaint-body">
                <p><strong>Name:</strong> ${complaint.name}</p>
                <p><strong>Category:</strong> ${getCategoryLabel(complaint.category)}</p>
                <p><strong>Description:</strong> ${complaint.description}</p>
                <p class="date"><strong>Submitted:</strong> ${formatDate(complaint.date)}</p>
            </div>
            
            <div class="complaint-actions">
                ${complaint.status === 'pending' ? `
                    <button class="btn btn-resolve" onclick="resolveComplaint(${complaint.id})">
                        ✓ Mark Resolved
                    </button>
                ` : `
                    <button class="btn btn-reopen" onclick="reopenComplaint(${complaint.id})">
                        ↻ Reopen
                    </button>
                `}
                <button class="btn btn-delete" onclick="deleteComplaint(${complaint.id})">
                    🗑 Delete
                </button>
            </div>
        </div>
    `).join('');
}

// Resolve complaint
async function resolveComplaint(id) {
    try {
        const response = await fetch(`/api/complaints/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({status: 'resolved'})
        });
        
        if (!response.ok) {
            throw new Error('Failed to resolve complaint');
        }
        
        showMessage('Complaint marked as resolved', 'success');
        await loadComplaints();
        
    } catch (error) {
        showMessage('Error: ' + error.message, 'error');
    }
}

// Reopen complaint
async function reopenComplaint(id) {
    try {
        const response = await fetch(`/api/complaints/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({status: 'pending'})
        });
        
        if (!response.ok) {
            throw new Error('Failed to reopen complaint');
        }
        
        showMessage('Complaint reopened', 'success');
        await loadComplaints();
        
    } catch (error) {
        showMessage('Error: ' + error.message, 'error');
    }
}

// Delete complaint
async function deleteComplaint(id) {
    // Confirm deletion
    if (!confirm('Are you sure you want to delete this complaint? This action cannot be undone.')) {
        return;
    }
    
    try {
        const response = await fetch(`/api/complaints/${id}`, {
            method: 'DELETE'
        });
        
        if (!response.ok) {
            throw new Error('Failed to delete complaint');
        }
        
        showMessage('Complaint deleted successfully', 'success');
        await loadComplaints();
        
    } catch (error) {
        showMessage('Error: ' + error.message, 'error');
    }
}

// Helper: Show message
function showMessage(text, type) {
    messageDiv.className = `message message-${type}`;
    messageDiv.textContent = text;
    messageDiv.style.display = 'block';
    
    // Auto-hide after 5 seconds
    setTimeout(() => {
        messageDiv.style.display = 'none';
    }, 5000);
}

// Helper: Get category label
function getCategoryLabel(category) {
    const labels = {
        'noise': '🔊 Noise Complaint',
        'garbage': '🗑 Garbage/Sanitation',
        'infrastructure': '🏗 Infrastructure',
        'security': '🚨 Security/Safety',
        'other': '📋 Other'
    };
    return labels[category] || category;
}

// Helper: Format date
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}
```

---

## Project Features Breakdown

### 1. Form Validation
```javascript
// Client-side validation
if (!name || !category || !description) {
    showMessage('Please fill all fields', 'error');
    return;
}

// Server-side validation (Flask)
if not data.get('name'):
    return jsonify({'error': 'Name is required'}), 400
```

### 2. Error Handling
```javascript
try {
    const response = await fetch(url, options);
    if (!response.ok) {
        throw new Error('Request failed');
    }
    // Success
} catch (error) {
    showMessage('Error: ' + error.message, 'error');
}
```

### 3. Loading States
```javascript
async function loadComplaints() {
    showLoading(true);
    try {
        // Fetch data
    } finally {
        showLoading(false);
    }
}
```

### 4. Confirmation Dialogs
```javascript
if (!confirm('Delete this complaint?')) {
    return; // User cancelled
}
```

---

## Running the Project

**1. Install dependencies:**
```bash
pip install flask
```

**2. Run Flask server:**
```bash
python app.py
```

**3. Open browser:**
```
http://localhost:5000
```

**4. Test all features:**
- Submit complaints
- View complaints
- Resolve/reopen
- Delete complaints

---

## Extending the Project

**1. Add Database (SQLite):**
```python
import sqlite3

conn = sqlite3.connect('complaints.db')
cursor = conn.cursor()

cursor.execute('''
    CREATE TABLE IF NOT EXISTS complaints (
        id INTEGER PRIMARY KEY,
        name TEXT,
        category TEXT,
        description TEXT,
        status TEXT,
        date TEXT
    )
''')
```

**2. Add Authentication:**
```python
from flask_login import LoginManager, login_required

@app.route('/api/complaints', methods=['POST'])
@login_required
def create_complaint():
    # Only logged-in users can submit
    pass
```

**3. Add Email Notifications:**
```python
from flask_mail import Mail, Message

def notify_admin(complaint):
    msg = Message('New Complaint', recipients=['admin@barangay.gov'])
    mail.send(msg)
```

**4. Deploy to Production:**
```bash
# Heroku
heroku create barangay-complaints
git push heroku main

# Railway
railway init
railway up
```

---

## Congratulations! 🎉

You've completed the **Full Web Development Curriculum**!

**What you've mastered:**
- ✅ HTML structure and semantics
- ✅ CSS styling and responsive design
- ✅ JavaScript programming (ES6+)
- ✅ DOM manipulation and event handling
- ✅ Modern JavaScript features
- ✅ APIs and Fetch
- ✅ Flask backend development
- ✅ Full CRUD operations
- ✅ Complete full-stack applications

**You're now ready to:**
- Build production-ready web applications
- Work as a full-stack developer
- Continue learning advanced topics (databases, authentication, deployment)
- Build your own projects and portfolio

---

## Final Challenge

Enhance your Barangay Complaint System with:
1. User authentication (login/register)
2. SQLite database integration
3. File upload for evidence
4. Admin dashboard with statistics
5. Search and filter functionality
6. Export complaints to PDF
7. Deploy to cloud platform

**Keep coding, keep learning, and build amazing things! 🚀**

---

---

## Closing Story

Tian built the final project: a comprehensive barangay complaint management system. Residents submit complaints via form. Admins view, update status, assign to kagawads. Full CRUD. Full authentication. Full functionality.

Kuya Miguel tested every feature. It worked flawlessly.

"You did it," Miguel said, voice filled with pride. "From zero to full-stack developer. You built something real. Something useful. Something that helps your community."

Tian deployed the system to a free hosting service. Shared the link with the barangay. Within days, residents were using it. Complaints logged. Issues tracked. Problems solved.

The principal who first announced internet access to the school? She used the system to report a broken streetlight. It got fixed within 48 hours.

Tian stared at the analytics dashboard. Real users. Real data. Real impact.

This wasn't just a coding exercise. This was community service through technology. This was Bayanihan in the digital age.

Kuya Miguel sent one final message: "Remember why you started. Not to get a job. Not to flex skills. To help. To build. To serve. That's the true mark of a great developer."

Tian smiled, closed the laptop, and walked outside. The neighborhood looked different now. Every house, every person, every problemall potential opportunities for technology to make life better.

The journey from curious student to community developer was complete. But the mission? Just beginning.

_Course Complete: Digital Bayan to Web App DevelopmentCongratulations!_

---

## Closing Story

Tian built the final project: a comprehensive barangay complaint management system. Residents submit complaints via form. Admins view, update status, assign to kagawads. Full CRUD. Full authentication. Full functionality.

Kuya Miguel tested every feature. It worked flawlessly.

"You did it," Miguel said, voice filled with pride. "From zero to full-stack developer. You built something real. Something useful. Something that helps your community."

Tian deployed the system to a free hosting service. Shared the link with the barangay. Within days, residents were using it. Complaints logged. Issues tracked. Problems solved.

The principal who first announced internet access to the school? She used the system to report a broken streetlight. It got fixed within 48 hours.

Tian stared at the analytics dashboard. Real users. Real data. Real impact.

This wasn't just a coding exercise. This was community service through technology. This was Bayanihan in the digital age.

Kuya Miguel sent one final message: "Remember why you started. Not to get a job. Not to flex skills. To help. To build. To serve. That's the true mark of a great developer."

Tian smiled, closed the laptop, and walked outside. The neighborhood looked different now. Every house, every person, every problemall potential opportunities for technology to make life better.

The journey from curious student to community developer was complete. But the mission? Just beginning.

_Course Complete: Digital Bayan to Web App DevelopmentCongratulations!_