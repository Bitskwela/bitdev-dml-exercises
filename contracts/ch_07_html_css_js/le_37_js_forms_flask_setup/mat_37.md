# Lesson 37: JavaScript Forms + Flask Setup - Connecting Front and Back

---

## Welcome to Full-Stack Development

"Kuya Miguel, we've built amazing frontends with JavaScript. But where does the data actually go?" Tian asked.

Rhea Joy added, "How do we save form submissions, store resident data, and build real systems with databases?"

Kuya Miguel smiled. "Time to learn **backend development with Flask**! You'll connect your JavaScript frontend to a Python Flask server, handle form submissions, work with databases, and build complete web applications!"

---

## What is Flask?

**Flask** is a lightweight Python web framework for building web applications and APIs.

**Features:**
- Write server-side code in Python
- Handle HTTP requests (GET, POST, PUT, DELETE)
- Connect to databases
- Render HTML templates
- Build REST APIs

---

## Installing Flask

```bash
# Install Flask
pip install flask

# Install additional tools
pip install flask-cors  # For cross-origin requests
```

---

## Basic Flask App

**app.py:**
```python
from flask import Flask, render_template, request, jsonify

app = Flask(__name__)

# Route: Homepage
@app.route('/')
def home():
    return render_template('index.html')

# Route: API endpoint
@app.route('/api/hello', methods=['GET'])
def hello():
    return jsonify({'message': 'Hello from Flask!'})

# Run server
if __name__ == '__main__':
    app.run(debug=True, port=5000)
```

**Run the server:**
```bash
python app.py
```

Visit: `http://localhost:5000`

---

## Flask Project Structure

```
barangay-system/
├── app.py              # Flask application
├── templates/          # HTML files
│   ├── index.html
│   └── services.html
├── static/             # Static files
│   ├── css/
│   │   └── style.css
│   └── js/
│       └── app.js
└── database.db         # SQLite database
```

---

## Flask Routes

**Routes handle different URLs:**

```python
from flask import Flask, render_template

app = Flask(__name__)

# Homepage
@app.route('/')
def home():
    return render_template('index.html')

# Services page
@app.route('/services')
def services():
    return render_template('services.html')

# About page
@app.route('/about')
def about():
    return '<h1>About Barangay San Antonio</h1>'

# Dynamic route (with parameter)
@app.route('/service/<int:service_id>')
def service_detail(service_id):
    return f'<h1>Service ID: {service_id}</h1>'

if __name__ == '__main__':
    app.run(debug=True)
```

---

## Handling Form Submissions

### Frontend (HTML + JavaScript)

**templates/index.html:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Application Form</title>
</head>
<body>
    <h1>Barangay Clearance Application</h1>
    
    <form id="applicationForm">
        <label>
            Full Name:
            <input type="text" name="name" required>
        </label>
        <br><br>
        
        <label>
            Age:
            <input type="number" name="age" required>
        </label>
        <br><br>
        
        <label>
            Service:
            <select name="service">
                <option value="clearance">Barangay Clearance</option>
                <option value="id">Barangay ID</option>
                <option value="certificate">Certificate of Residency</option>
            </select>
        </label>
        <br><br>
        
        <button type="submit">Submit Application</button>
    </form>
    
    <div id="message"></div>
    
    <script>
        const form = document.querySelector('#applicationForm');
        const message = document.querySelector('#message');
        
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            // Get form data
            const formData = {
                name: form.name.value,
                age: parseInt(form.age.value),
                service: form.service.value
            };
            
            try {
                // Send to Flask backend
                const response = await fetch('/api/submit', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(formData)
                });
                
                const result = await response.json();
                
                if (response.ok) {
                    message.innerHTML = `<p style="color: green;">${result.message}</p>`;
                    form.reset();
                } else {
                    message.innerHTML = `<p style="color: red;">Error: ${result.error}</p>`;
                }
                
            } catch (error) {
                message.innerHTML = `<p style="color: red;">Network error: ${error.message}</p>`;
            }
        });
    </script>
</body>
</html>
```

---

### Backend (Flask)

**app.py:**
```python
from flask import Flask, render_template, request, jsonify
from datetime import datetime

app = Flask(__name__)

# In-memory storage (temporary)
applications = []

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/submit', methods=['POST'])
def submit_application():
    try:
        # Get JSON data from request
        data = request.get_json()
        
        # Validate data
        if not data.get('name'):
            return jsonify({'error': 'Name is required'}), 400
        
        if not data.get('age') or data['age'] < 1:
            return jsonify({'error': 'Valid age is required'}), 400
        
        if not data.get('service'):
            return jsonify({'error': 'Service is required'}), 400
        
        # Create application record
        application = {
            'id': len(applications) + 1,
            'name': data['name'],
            'age': data['age'],
            'service': data['service'],
            'date': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            'status': 'pending'
        }
        
        # Save to storage
        applications.append(application)
        
        # Return success response
        return jsonify({
            'message': 'Application submitted successfully!',
            'application_id': application['id']
        }), 201
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Get all applications
@app.route('/api/applications', methods=['GET'])
def get_applications():
    return jsonify(applications)

# Get specific application
@app.route('/api/applications/<int:app_id>', methods=['GET'])
def get_application(app_id):
    application = next((app for app in applications if app['id'] == app_id), None)
    
    if application:
        return jsonify(application)
    else:
        return jsonify({'error': 'Application not found'}), 404

if __name__ == '__main__':
    app.run(debug=True)
```

---

## Flask with Templates (Jinja2)

**Pass data to templates:**

```python
@app.route('/services')
def services():
    barangay_services = [
        {'name': 'Barangay Clearance', 'fee': 50},
        {'name': 'Barangay ID', 'fee': 30},
        {'name': 'Certificate of Residency', 'fee': 40}
    ]
    
    return render_template('services.html', services=barangay_services)
```

**templates/services.html:**
```html
<!DOCTYPE html>
<html>
<head>
    <title>Barangay Services</title>
</head>
<body>
    <h1>Available Services</h1>
    
    <ul>
    {% for service in services %}
        <li>{{ service.name }} - ₱{{ service.fee }}</li>
    {% endfor %}
    </ul>
</body>
</html>
```

---

## Complete Barangay System Example

**app.py:**
```python
from flask import Flask, render_template, request, jsonify
from datetime import datetime

app = Flask(__name__)

# Sample data
services = [
    {'id': 1, 'name': 'Barangay Clearance', 'fee': 50, 'available': True},
    {'id': 2, 'name': 'Barangay ID', 'fee': 30, 'available': True},
    {'id': 3, 'name': 'Certificate of Residency', 'fee': 40, 'available': True},
    {'id': 4, 'name': 'Business Permit', 'fee': 200, 'available': False}
]

applications = []

@app.route('/')
def home():
    return render_template('index.html')

# API: Get all services
@app.route('/api/services', methods=['GET'])
def get_services():
    return jsonify(services)

# API: Submit application
@app.route('/api/applications', methods=['POST'])
def create_application():
    data = request.get_json()
    
    application = {
        'id': len(applications) + 1,
        'name': data['name'],
        'age': data['age'],
        'service_id': data['service_id'],
        'date': datetime.now().isoformat(),
        'status': 'pending'
    }
    
    applications.append(application)
    
    return jsonify({
        'message': 'Application submitted!',
        'application': application
    }), 201

# API: Get all applications
@app.route('/api/applications', methods=['GET'])
def get_applications():
    return jsonify(applications)

# API: Get single application
@app.route('/api/applications/<int:app_id>', methods=['GET'])
def get_application(app_id):
    app = next((a for a in applications if a['id'] == app_id), None)
    
    if app:
        return jsonify(app)
    else:
        return jsonify({'error': 'Not found'}), 404

if __name__ == '__main__':
    app.run(debug=True)
```

**templates/index.html:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay System</title>
</head>
<body>
    <h1>Barangay Service Application</h1>
    
    <div>
        <h2>Available Services</h2>
        <div id="servicesList"></div>
    </div>
    
    <br>
    
    <div>
        <h2>Apply for Service</h2>
        <form id="appForm">
            <input type="text" id="name" placeholder="Full Name" required><br><br>
            <input type="number" id="age" placeholder="Age" required><br><br>
            <select id="service" required>
                <option value="">Select Service</option>
            </select><br><br>
            <button type="submit">Submit Application</button>
        </form>
        <div id="message"></div>
    </div>
    
    <br>
    
    <div>
        <h2>All Applications</h2>
        <button id="loadApps">Load Applications</button>
        <div id="appsList"></div>
    </div>
    
    <script>
        // Load services
        async function loadServices() {
            const response = await fetch('/api/services');
            const services = await response.json();
            
            const list = document.querySelector('#servicesList');
            list.innerHTML = services.map(s => 
                `<div>${s.name} - ₱${s.fee} (${s.available ? 'Available' : 'Unavailable'})</div>`
            ).join('');
            
            const select = document.querySelector('#service');
            select.innerHTML = '<option value="">Select Service</option>' +
                services.map(s => `<option value="${s.id}">${s.name}</option>`).join('');
        }
        
        // Submit application
        document.querySelector('#appForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const data = {
                name: document.querySelector('#name').value,
                age: parseInt(document.querySelector('#age').value),
                service_id: parseInt(document.querySelector('#service').value)
            };
            
            const response = await fetch('/api/applications', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            });
            
            const result = await response.json();
            
            document.querySelector('#message').innerHTML = 
                `<p style="color: green;">${result.message}</p>`;
            
            e.target.reset();
        });
        
        // Load applications
        document.querySelector('#loadApps').addEventListener('click', async () => {
            const response = await fetch('/api/applications');
            const apps = await response.json();
            
            const list = document.querySelector('#appsList');
            list.innerHTML = apps.map(app => 
                `<div>ID: ${app.id} | ${app.name} (Age ${app.age}) - Service ID: ${app.service_id} - Status: ${app.status}</div>`
            ).join('');
        });
        
        // Initial load
        loadServices();
    </script>
</body>
</html>
```

---

## Summary

**Flask basics:**
```python
from flask import Flask, render_template, request, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/data', methods=['POST'])
def handle_data():
    data = request.get_json()
    return jsonify({'message': 'Success'})

app.run(debug=True)
```

**JavaScript fetch to Flask:**
```javascript
const response = await fetch('/api/submit', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
});

const result = await response.json();
```

---

## What's Next?

In the next lesson, you'll learn **JavaScript Fetch to Flask API**—sending GET/POST requests, handling responses, and building interactive full-stack features!

---
