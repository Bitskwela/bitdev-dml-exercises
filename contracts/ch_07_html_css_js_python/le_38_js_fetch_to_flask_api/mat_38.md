# Lesson 38-42: Full-Stack JavaScript + Flask - Complete Guide

---

## **Lesson 38: JavaScript Fetch to Flask API**

### Sending Requests from JavaScript to Flask

**Flask Backend (app.py):**
```python
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/api/services', methods=['GET'])
def get_services():
    services = [
        {'id': 1, 'name': 'Clearance', 'fee': 50},
        {'id': 2, 'name': 'ID', 'fee': 30}
    ]
    return jsonify(services)

@app.route('/api/applications', methods=['POST'])
def create_application():
    data = request.get_json()
    
    # Validate
    if not data.get('name'):
        return jsonify({'error': 'Name required'}), 400
    
    # Create record
    application = {
        'id': 1,
        'name': data['name'],
        'service': data['service'],
        'status': 'pending'
    }
    
    return jsonify({'message': 'Created', 'data': application}), 201

app.run(debug=True)
```

**JavaScript Frontend:**
```javascript
// GET request
async function loadServices() {
    const response = await fetch('http://localhost:5000/api/services');
    const services = await response.json();
    console.log(services);
}

// POST request
async function submitApplication(data) {
    const response = await fetch('http://localhost:5000/api/applications', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(data)
    });
    
    const result = await response.json();
    console.log(result);
}

// Usage
submitApplication({name: 'Juan', service: 'Clearance'});
```

---

## **Lesson 39: DOM Updates from Flask**

### Displaying Flask Data Dynamically

**Flask:**
```python
@app.route('/api/applications')
def get_applications():
    apps = [
        {'id': 1, 'name': 'Juan', 'service': 'Clearance', 'status': 'approved'},
        {'id': 2, 'name': 'Maria', 'service': 'ID', 'status': 'pending'}
    ]
    return jsonify(apps)
```

**JavaScript:**
```javascript
async function displayApplications() {
    const response = await fetch('/api/applications');
    const apps = await response.json();
    
    const container = document.querySelector('#appsList');
    
    container.innerHTML = apps.map(app => `
        <div class="app-card">
            <h3>${app.name}</h3>
            <p>Service: ${app.service}</p>
            <p>Status: <span class="status-${app.status}">${app.status}</span></p>
        </div>
    `).join('');
}

displayApplications();
```

---

## **Lesson 40: CRUD - Create and Read**

### Building Complete CRUD Operations

**Flask (app.py):**
```python
from flask import Flask, request, jsonify

app = Flask(__name__)

applications = []
next_id = 1

# CREATE
@app.route('/api/applications', methods=['POST'])
def create():
    global next_id
    data = request.get_json()
    
    app = {
        'id': next_id,
        'name': data['name'],
        'service': data['service'],
        'status': 'pending'
    }
    
    applications.append(app)
    next_id += 1
    
    return jsonify(app), 201

# READ ALL
@app.route('/api/applications', methods=['GET'])
def read_all():
    return jsonify(applications)

# READ ONE
@app.route('/api/applications/<int:id>', methods=['GET'])
def read_one(id):
    app = next((a for a in applications if a['id'] == id), None)
    if app:
        return jsonify(app)
    return jsonify({'error': 'Not found'}), 404

app.run(debug=True)
```

**JavaScript:**
```javascript
// CREATE
async function createApplication(data) {
    const response = await fetch('/api/applications', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(data)
    });
    return await response.json();
}

// READ ALL
async function getAllApplications() {
    const response = await fetch('/api/applications');
    return await response.json();
}

// READ ONE
async function getApplication(id) {
    const response = await fetch(`/api/applications/${id}`);
    return await response.json();
}

// Usage
await createApplication({name: 'Juan', service: 'Clearance'});
const all = await getAllApplications();
const one = await getApplication(1);
```

---

## **Lesson 41: CRUD - Update and Delete**

**Flask:**
```python
# UPDATE
@app.route('/api/applications/<int:id>', methods=['PUT'])
def update(id):
    app = next((a for a in applications if a['id'] == id), None)
    
    if not app:
        return jsonify({'error': 'Not found'}), 404
    
    data = request.get_json()
    app['name'] = data.get('name', app['name'])
    app['service'] = data.get('service', app['service'])
    app['status'] = data.get('status', app['status'])
    
    return jsonify(app)

# DELETE
@app.route('/api/applications/<int:id>', methods=['DELETE'])
def delete(id):
    global applications
    app = next((a for a in applications if a['id'] == id), None)
    
    if not app:
        return jsonify({'error': 'Not found'}), 404
    
    applications = [a for a in applications if a['id'] != id]
    return jsonify({'message': 'Deleted'})
```

**JavaScript:**
```javascript
// UPDATE
async function updateApplication(id, data) {
    const response = await fetch(`/api/applications/${id}`, {
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(data)
    });
    return await response.json();
}

// DELETE
async function deleteApplication(id) {
    const response = await fetch(`/api/applications/${id}`, {
        method: 'DELETE'
    });
    return await response.json();
}

// Usage
await updateApplication(1, {status: 'approved'});
await deleteApplication(2);
```

---

## **Lesson 42: Final Project - Barangay Complaint System**

### Complete Full-Stack Application

**Flask Backend (app.py):**
```python
from flask import Flask, render_template, request, jsonify
from datetime import datetime

app = Flask(__name__)

complaints = []
next_id = 1

@app.route('/')
def home():
    return render_template('index.html')

# CREATE
@app.route('/api/complaints', methods=['POST'])
def create_complaint():
    global next_id
    data = request.get_json()
    
    complaint = {
        'id': next_id,
        'name': data['name'],
        'category': data['category'],
        'description': data['description'],
        'status': 'pending',
        'date': datetime.now().isoformat()
    }
    
    complaints.append(complaint)
    next_id += 1
    
    return jsonify(complaint), 201

# READ ALL
@app.route('/api/complaints', methods=['GET'])
def get_complaints():
    return jsonify(complaints)

# UPDATE STATUS
@app.route('/api/complaints/<int:id>', methods=['PUT'])
def update_complaint(id):
    complaint = next((c for c in complaints if c['id'] == id), None)
    
    if not complaint:
        return jsonify({'error': 'Not found'}), 404
    
    data = request.get_json()
    complaint['status'] = data.get('status', complaint['status'])
    
    return jsonify(complaint)

# DELETE
@app.route('/api/complaints/<int:id>', methods=['DELETE'])
def delete_complaint(id):
    global complaints
    complaint = next((c for c in complaints if c['id'] == id), None)
    
    if not complaint:
        return jsonify({'error': 'Not found'}), 404
    
    complaints = [c for c in complaints if c['id'] != id]
    return jsonify({'message': 'Deleted'})

if __name__ == '__main__':
    app.run(debug=True)
```

**HTML (templates/index.html):**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Complaint System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; padding: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; }
        h1 { color: #333; margin-bottom: 30px; }
        .form-section { background: white; padding: 30px; border-radius: 10px; margin-bottom: 30px; }
        input, select, textarea, button { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ddd; border-radius: 5px; font-size: 1rem; }
        button { background: #007bff; color: white; border: none; cursor: pointer; }
        button:hover { background: #0056b3; }
        .complaints-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .complaint-card { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .status { display: inline-block; padding: 5px 15px; border-radius: 20px; font-size: 0.9rem; font-weight: bold; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-resolved { background: #d4edda; color: #155724; }
        .actions { margin-top: 15px; }
        .actions button { width: auto; padding: 8px 15px; margin: 0 5px; font-size: 0.9rem; }
        .btn-resolve { background: #28a745; }
        .btn-delete { background: #dc3545; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏛️ Barangay Complaint System</h1>
        
        <div class="form-section">
            <h2>Submit a Complaint</h2>
            <form id="complaintForm">
                <input type="text" id="name" placeholder="Your Name" required>
                <select id="category" required>
                    <option value="">Select Category</option>
                    <option value="noise">Noise Complaint</option>
                    <option value="garbage">Garbage/Sanitation</option>
                    <option value="infrastructure">Infrastructure</option>
                    <option value="security">Security/Safety</option>
                    <option value="other">Other</option>
                </select>
                <textarea id="description" rows="4" placeholder="Describe your complaint..." required></textarea>
                <button type="submit">Submit Complaint</button>
            </form>
            <div id="message"></div>
        </div>
        
        <div>
            <h2>All Complaints</h2>
            <div id="complaintsList" class="complaints-grid"></div>
        </div>
    </div>
    
    <script>
        const form = document.querySelector('#complaintForm');
        const message = document.querySelector('#message');
        const complaintsList = document.querySelector('#complaintsList');
        
        // Submit complaint
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const data = {
                name: document.querySelector('#name').value,
                category: document.querySelector('#category').value,
                description: document.querySelector('#description').value
            };
            
            try {
                const response = await fetch('/api/complaints', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                });
                
                const result = await response.json();
                
                message.innerHTML = '<p style="color: green;">Complaint submitted successfully!</p>';
                form.reset();
                
                loadComplaints();
                
            } catch (error) {
                message.innerHTML = '<p style="color: red;">Error: ' + error.message + '</p>';
            }
        });
        
        // Load complaints
        async function loadComplaints() {
            try {
                const response = await fetch('/api/complaints');
                const complaints = await response.json();
                
                displayComplaints(complaints);
                
            } catch (error) {
                complaintsList.innerHTML = '<p>Error loading complaints</p>';
            }
        }
        
        // Display complaints
        function displayComplaints(complaints) {
            if (complaints.length === 0) {
                complaintsList.innerHTML = '<p>No complaints found</p>';
                return;
            }
            
            complaintsList.innerHTML = complaints.map(complaint => `
                <div class="complaint-card">
                    <h3>Complaint #${complaint.id}</h3>
                    <p><strong>Name:</strong> ${complaint.name}</p>
                    <p><strong>Category:</strong> ${complaint.category}</p>
                    <p><strong>Description:</strong> ${complaint.description}</p>
                    <p><span class="status status-${complaint.status}">${complaint.status.toUpperCase()}</span></p>
                    <div class="actions">
                        ${complaint.status === 'pending' ? 
                            `<button class="btn-resolve" onclick="resolveComplaint(${complaint.id})">Mark Resolved</button>` : 
                            ''}
                        <button class="btn-delete" onclick="deleteComplaint(${complaint.id})">Delete</button>
                    </div>
                </div>
            `).join('');
        }
        
        // Resolve complaint
        async function resolveComplaint(id) {
            try {
                await fetch(`/api/complaints/${id}`, {
                    method: 'PUT',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({status: 'resolved'})
                });
                
                loadComplaints();
                
            } catch (error) {
                alert('Error resolving complaint');
            }
        }
        
        // Delete complaint
        async function deleteComplaint(id) {
            if (!confirm('Delete this complaint?')) return;
            
            try {
                await fetch(`/api/complaints/${id}`, {
                    method: 'DELETE'
                });
                
                loadComplaints();
                
            } catch (error) {
                alert('Error deleting complaint');
            }
        }
        
        // Initial load
        loadComplaints();
    </script>
</body>
</html>
```

---

## Summary - Full Course Complete!

**You've learned:**
- ✅ Flask basics (routes, templates, JSON)
- ✅ JavaScript Fetch API (GET, POST, PUT, DELETE)
- ✅ Full CRUD operations
- ✅ DOM updates from backend data
- ✅ Complete full-stack applications

**Technologies mastered:**
- Frontend: HTML, CSS, JavaScript (ES6+)
- Backend: Python, Flask
- API: REST principles
- Database: In-memory (ready for SQL/MongoDB)

**Next steps:**
1. Add SQLite/PostgreSQL database
2. Implement user authentication
3. Deploy to cloud (Heroku, Railway, Render)
4. Add real-time features (WebSockets)

**Congratulations on completing the full web development curriculum! 🎉**

---

---

## Closing Story

Tian wrote a `fetch()` request from JavaScript to Flask API. Sent JSON data. Flask processed it. Sent JSON response. JavaScript received and displayed it. Full-circle communication.

"This is how modern web apps work," Kuya Miguel noted. "Frontend and backend are separate but connected. RESTful APIs. JSON communication. Industry standard."

Tian tested various endpoints: `/residents`, `/announcements`, `/events`. All working. The barangay portal was becoming a real web application.

_Next up: DOM Updates from Flask Responsesdynamic rendering!_