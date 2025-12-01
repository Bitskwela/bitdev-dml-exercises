## Background Story

The barangay clearance application system was beautiful. Tian and Rhea Joy had spent weeks perfecting every detail:

- Clean, responsive HTML structure
- Polished CSS with professional styling
- Interactive JavaScript with form validation
- DOM manipulation that updated the UI dynamically
- Event handlers that responded to every user action

Residents could fill out the form, select document types, enter personal information, and click "Submit Application." The form validation checked everything—required fields, proper email format, valid phone numbers, age requirements.

But when someone clicked Submit, the data disappeared into the void.

There was no database to store it. No server to process it. No way to retrieve submitted applications later. The JavaScript validated and displayed the data on screen, but as soon as you refreshed the page, everything vanished. It was a beautiful, functional interface connected to nothing.

The barangay secretary, Ms. Reyes, had come to test the system. She filled out an application for a resident, submitted it successfully, and saw the confirmation message appear.

"Great!" she said. "Now where can I see all the submitted applications?"

Tian and Rhea Joy exchanged uncomfortable glances.

"Um... there's no database yet," Tian admitted. "The data only exists in the browser. If you refresh the page, it's gone."

Ms. Reyes frowned. "So this is just a demo? It's not actually storing anything? How will we track applications, update their status, generate reports, or retrieve resident information?"

"We... haven't built the backend yet," Rhea Joy said quietly.

"What's a backend?"

And that was the moment Tian and Rhea Joy realized they'd built an impressive facade with no foundation underneath. A restaurant with no kitchen. A car with no engine. A beautiful website that couldn't actually do the one thing it was supposed to do: persist and manage data.

That evening, both of them were on a call with Kuya Miguel, explaining the situation.

"We built everything frontend-related," Tian said. "HTML, CSS, JavaScript, DOM manipulation, event handling, form validation. The user experience is perfect. But it's useless because we can't save data. Ms. Reyes asked where the submitted applications are stored, and we had to admit there's no storage at all."

Miguel nodded knowingly. "You've hit the wall that every frontend developer hits—the realization that beautiful interfaces mean nothing without backend systems to support them. You need a server. A database. Business logic. APIs for your JavaScript to communicate with. You need the backend."

"We've been learning JavaScript," Rhea Joy said. "Do we need to learn a completely different language now?"

"Good news," Miguel said. "You can use Python—a language that's easier and more readable than JavaScript in many ways. And we'll use Flask, a lightweight Python web framework that's perfect for beginners and powerful enough for production applications. Flask will let you build a server that receives form submissions from your JavaScript frontend, stores data in a database, queries that data, and sends responses back to the browser."

"So JavaScript handles the frontend, Python handles the backend, and they communicate through... what?"

"HTTP requests. Your JavaScript uses `fetch()` to send data to Flask API endpoints. Flask processes the request, interacts with the database, and returns JSON responses. Your JavaScript receives those responses and updates the DOM. That's modern web development—frontend and backend working together."

Miguel continued, "Today, we're setting up the complete stack. You'll install Python and Flask, create your first Flask server, define API endpoints, connect your JavaScript frontend to those endpoints, and finally see data flow from the browser to the server and back. By the end of tonight, your barangay application system will actually save data. For real."

Tian and Rhea Joy looked at each other, equal parts nervous and excited. This was the leap from frontend developer to full-stack developer. The moment when everything would finally connect.

---

## Theory & Lecture Content

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

---

## Closing Story

Tian installed Flask, created a Python virtual environment, wrote the first backend route: `@app.route('/submit', methods=['POST'])`. The server started. JavaScript could now talk to Python. Frontend met backend.

"This is the bridge," Kuya Miguel explained. "JavaScript sends data. Flask receives, processes, stores, responds. This is full-stack development."

Tian submitted a form from the browser. Flask logged the data. The connection worked. Client and server, working together. The web was whole.

_Next up: JS Fetch to Flask APIreal communication!_