## Background Story

Tian had successfully built the frontend-backend bridge: his JavaScript could fetch data from Flask, and Flask could send JSON responses back. He'd displayed dynamic lists of applications fetched from Flask, with beautiful cards rendering automatically. But there was one massive limitation he discovered when he tested the system with fresh eyes.

He filled out a barangay clearance application form with his own test data:
- Name: Tian Rodriguez
- Age: 16
- Service: Barangay Clearance
- Purpose: School Requirement

He clicked "Submit." JavaScript collected the form data, sent it via fetch to Flask as a POST request. Flask received it and sent back: `{message: 'Application received'}`. Success!

But then he refreshed the page.

Gone. The application vanished. When he clicked "View Applications," the list was empty. All the data he'd submitted existed only in JavaScript memory for those few seconds, then disappeared forever when the page refreshed.

"This is useless," Tian said, frustrated. "Real applications don't disappear when you refresh the page. Facebook posts stay. Twitter tweets stay. GCash transactions stay. Our data just... vanishes."

Rhea Joy had the same realization when testing the resident registration system. She'd "registered" five test residents, clicked "View Residents," saw them beautifully displayed... then accidentally closed the browser tab. When she reopened it: empty. All five residents gone.

"We need **persistence**," she said. "Data needs to survive page refreshes, browser closures, even computer restarts. That's what databases are for, right?"

They called Miguel, explaining the ephemeral data problem. "Kuya, our applications work for the current session, but the moment we refresh, everything's gone. How do we make data permanent?"

Miguel nodded. "You've discovered why databases exist. Right now, you're storing data in Python variables or JavaScript arrays—which live in RAM. When the program stops, RAM clears. You need **persistent storage**—a database that saves data to disk."

He shared his screen showing a real barangay portal connected to a SQLite database. "Watch what happens when I submit an application."

Miguel filled out a form: Juan Dela Cruz, 45, Indigency Certificate. Clicked Submit. A success message appeared. He refreshed the page. Then closed and reopened the browser. Then even restarted the Flask server.

When he loaded "View Applications," Juan Dela Cruz was still there.

"That's persistence," Miguel explained. "The data was saved to a database file on disk. Flask wrote it when you submitted. Flask reads it when you view. The data survives everything."

Tian understood the missing piece immediately. "So our current Flask code receives the POST request, pero it doesn't save anywhere. We need to add database operations—INSERT to save new records, SELECT to retrieve them."

"Exactly," Miguel confirmed. "That's called **CRUD operations**: Create, Read, Update, Delete. These four operations cover almost every interaction users have with data."

He wrote them out:

```
CREATE - Add new records (INSERT in SQL)
READ   - Retrieve records (SELECT in SQL)
UPDATE - Modify records (UPDATE in SQL)
DELETE - Remove records (DELETE in SQL)
```

"Today we'll master CREATE and READ—the foundation of data-driven applications," Miguel said.

Rhea Joy thought about real-world examples: "When I sign up for Facebook, that's CREATE—adding my profile to their users database. When I view my profile, that's READ—retrieving my data. When I edit my profile, that's UPDATE. When I delete my account, that's DELETE."

"Every single interaction on every website is a CRUD operation," Miguel confirmed. "Tweet? CREATE. View tweets? READ. Edit tweet? UPDATE. Delete tweet? DELETE. Online shopping cart? CREATE items. View cart? READ items. It's universal."

Tian was ready to implement it. "Show us the full flow for our barangay application system."

Miguel diagrammed the CREATE flow:

```
1. User fills form on frontend
2. JavaScript collects form data
3. JavaScript fetch() sends POST request to Flask
4. Flask receives data via request.get_json()
5. Flask validates the data
6. Flask INSERT into database
7. Flask sends success response
8. JavaScript displays success message
```

And the READ flow:

```
1. User clicks "View Applications"
2. JavaScript sends GET request to Flask
3. Flask SELECT * from database
4. Flask converts database rows to JSON
5. Flask sends JSON array response
6. JavaScript receives array
7. JavaScript creates DOM elements for each item
8. User sees list of applications
```

"Two flows, working together, giving you full CRUD capability," Miguel said.

Tian studied the code Miguel provided:

**Flask CREATE endpoint:**
```python
@app.route('/api/applications', methods=['POST'])
def create_application():
    data = request.get_json()
    
    # Validate
    if not data.get('name'):
        return jsonify({'error': 'Name required'}), 400
    
    # INSERT into database
    conn = sqlite3.connect('barangay.db')
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO applications (name, service, purpose, status)
        VALUES (?, ?, ?, ?)
    ''', (data['name'], data['service'], data['purpose'], 'pending'))
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    
    return jsonify({'message': 'Created!', 'id': new_id}), 201
```

**Flask READ endpoint:**
```python
@app.route('/api/applications', methods=['GET'])
def get_applications():
    # SELECT from database
    conn = sqlite3.connect('barangay.db')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM applications')
    rows = cursor.fetchall()
    conn.close()
    
    # Convert to JSON format
    applications = []
    for row in rows:
        applications.append({
            'id': row[0],
            'name': row[1],
            'service': row[2],
            'purpose': row[3],
            'status': row[4]
        })
    
    return jsonify(applications)
```

Rhea Joy traced the flow: "So when I submit a form, Flask takes the JSON data and uses SQL INSERT to add it to the database. The data is now permanently stored. When I view applications, Flask uses SQL SELECT to retrieve all rows, converts them to JSON, and sends them to JavaScript. The full cycle!"

"And because it's in a database file, the data persists forever," Miguel emphasized. "You can submit an application, close your computer, come back three days later, and it's still there."

Tian was excited to implement it. "So first we need to create the database schema—define the table structure with columns for id, name, service, purpose, status, date. Then implement the CREATE endpoint to insert. Then implement the READ endpoint to retrieve. Then connect the frontend to both."

"Perfect plan," Miguel said. "I'll give you the database schema:"

```sql
CREATE TABLE applications (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    service TEXT NOT NULL,
    purpose TEXT,
    status TEXT DEFAULT 'pending',
    date_submitted DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

"This defines your data structure. Every application has these fields. Flask will INSERT rows following this structure. Flask will SELECT rows with these columns."

Rhea Joy started writing the frontend JavaScript:

```javascript
// CREATE: Submit new application
async function submitApplication(formData) {
    const response = await fetch('/api/applications', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(formData)
    });
    
    const result = await response.json();
    
    if (response.ok) {
        alert('Application submitted successfully!');
        loadApplications();  // Refresh list
    } else {
        alert('Error: ' + result.error);
    }
}

// READ: Load all applications
async function loadApplications() {
    const response = await fetch('/api/applications');
    const applications = await response.json();
    displayApplications(applications);
}
```

"The cycle is complete," she said. "CREATE adds to database. READ retrieves from database. Both use fetch to communicate with Flask. Flask handles all database operations. The frontend just sends and receives JSON."

Miguel gave them the final challenge: "Build the complete barangay application system. CREATE endpoint that validates and saves. READ endpoint that retrieves and formats. Frontend forms that collect data. Frontend displays that show data. Test it thoroughly: submit multiple applications, refresh the page, close the browser, restart Flask—the data should persist through everything."

Tian and Rhea Joy spent the next two hours implementing the full CRUD create/read system. When Tian submitted a test application, refreshed the page, and saw it still there, he felt a profound sense of accomplishment.

"This is real now," he said. "Before, we were building toys that forgot everything. Now we're building actual data-driven applications with permanent storage. This is what makes software useful—data that persists."

Rhea Joy tested the resident registration system she'd built. Registered five residents. Closed browser. Reopened. All five were there. "We can actually deploy this to the barangay hall now. Ms. Reyes can use it to register real residents, and the data won't disappear."

Miguel smiled through the video call. "You've graduated from temporary experiments to permanent systems. CREATE and READ are your foundation. Next, we'll add UPDATE and DELETE to give users full control over their data. But today, celebrate—you've built persistent, database-backed web applications. That's a major milestone."

---

## Theory & Lecture Content

## CRUD Operations Overview

**CRUD** stands for:
- **C**reate - Add new records
- **R**ead - Retrieve existing records
- **U**pdate - Modify existing records
- **D**elete - Remove records

Today: **CREATE and READ**

---

## CREATE Operation (Add New Records)

### Flask Backend - CREATE Endpoint

**app.py:**
```python
from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

# In-memory storage (in production, use a real database)
applications = []
next_id = 1

@app.route('/api/applications', methods=['POST'])
def create_application():
    global next_id
    
    # Get JSON data from request
    data = request.get_json()
    
    # Validate required fields
    if not data.get('name'):
        return jsonify({'error': 'Name is required'}), 400
    
    if not data.get('service'):
        return jsonify({'error': 'Service is required'}), 400
    
    # Create new application
    application = {
        'id': next_id,
        'name': data['name'],
        'age': data.get('age', 0),
        'service': data['service'],
        'status': 'pending',
        'date': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    }
    
    # Save to storage
    applications.append(application)
    next_id += 1
    
    # Return success response
    return jsonify({
        'message': 'Application created successfully',
        'application': application
    }), 201
```

**Key Points:**
- `methods=['POST']` - Only accept POST requests
- `request.get_json()` - Get JSON data from request body
- Validate input before saving
- Return `201` status code (Created)

---

### JavaScript Frontend - CREATE Function

**script.js:**
```javascript
async function createApplication(applicationData) {
    try {
        const response = await fetch('/api/applications', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(applicationData)
        });
        
        if (!response.ok) {
            throw new Error('Failed to create application');
        }
        
        const result = await response.json();
        return result;
        
    } catch (error) {
        console.error('Error:', error);
        throw error;
    }
}

// Usage
const newApplication = {
    name: 'Juan Dela Cruz',
    age: 30,
    service: 'Barangay Clearance'
};

const result = await createApplication(newApplication);
console.log(result.message); // "Application created successfully"
```

---

## Complete Form Example - CREATE

**HTML (index.html):**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Application Form</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Service Application</h1>
        
        <!-- Application Form -->
        <form id="applicationForm">
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" required>
            </div>
            
            <div class="form-group">
                <label for="age">Age:</label>
                <input type="number" id="age" min="1" required>
            </div>
            
            <div class="form-group">
                <label for="service">Service:</label>
                <select id="service" required>
                    <option value="">Select Service</option>
                    <option value="Barangay Clearance">Barangay Clearance</option>
                    <option value="Certificate of Residency">Certificate of Residency</option>
                    <option value="Certificate of Indigency">Certificate of Indigency</option>
                    <option value="Business Permit">Business Permit</option>
                </select>
            </div>
            
            <button type="submit">Submit Application</button>
        </form>
        
        <div id="message"></div>
        
        <!-- Applications List -->
        <h2>All Applications</h2>
        <div id="applicationsList"></div>
    </div>
    
    <script src="script.js"></script>
</body>
</html>
```

**JavaScript (script.js):**
```javascript
const form = document.querySelector('#applicationForm');
const message = document.querySelector('#message');

// Handle form submission
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    // Get form data
    const applicationData = {
        name: document.querySelector('#name').value,
        age: parseInt(document.querySelector('#age').value),
        service: document.querySelector('#service').value
    };
    
    try {
        // Create application
        const response = await fetch('/api/applications', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(applicationData)
        });
        
        const result = await response.json();
        
        if (response.ok) {
            // Show success message
            message.innerHTML = `<p class="success">${result.message}</p>`;
            
            // Clear form
            form.reset();
            
            // Reload applications list
            loadApplications();
            
        } else {
            // Show error message
            message.innerHTML = `<p class="error">${result.error}</p>`;
        }
        
    } catch (error) {
        message.innerHTML = `<p class="error">Network error: ${error.message}</p>`;
    }
});

// Load applications on page load
window.addEventListener('DOMContentLoaded', loadApplications);
```

---

## READ Operation (Retrieve Records)

### Flask Backend - READ Endpoints

**Read All Applications:**
```python
@app.route('/api/applications', methods=['GET'])
def get_all_applications():
    return jsonify(applications)
```

**Read One Application by ID:**
```python
@app.route('/api/applications/<int:app_id>', methods=['GET'])
def get_application(app_id):
    # Find application by ID
    application = next((app for app in applications if app['id'] == app_id), None)
    
    if application:
        return jsonify(application)
    else:
        return jsonify({'error': 'Application not found'}), 404
```

---

### JavaScript Frontend - READ Functions

**Read All:**
```javascript
async function loadApplications() {
    try {
        const response = await fetch('/api/applications');
        const applications = await response.json();
        
        displayApplications(applications);
        
    } catch (error) {
        console.error('Error loading applications:', error);
    }
}

function displayApplications(applications) {
    const container = document.querySelector('#applicationsList');
    
    if (applications.length === 0) {
        container.innerHTML = '<p>No applications yet.</p>';
        return;
    }
    
    container.innerHTML = applications.map(app => `
        <div class="application-card">
            <h3>${app.name}</h3>
            <p><strong>Age:</strong> ${app.age}</p>
            <p><strong>Service:</strong> ${app.service}</p>
            <p><strong>Status:</strong> <span class="badge ${app.status}">${app.status}</span></p>
            <p><small>Applied on: ${app.date}</small></p>
        </div>
    `).join('');
}
```

**Read One by ID:**
```javascript
async function getApplicationById(id) {
    try {
        const response = await fetch(`/api/applications/${id}`);
        
        if (!response.ok) {
            throw new Error('Application not found');
        }
        
        const application = await response.json();
        return application;
        
    } catch (error) {
        console.error('Error:', error);
        throw error;
    }
}

// Usage
const app = await getApplicationById(1);
console.log(app.name); // "Juan Dela Cruz"
```

---

## Complete Example with Validation

**Flask with Better Validation:**
```python
@app.route('/api/applications', methods=['POST'])
def create_application():
    global next_id
    
    data = request.get_json()
    
    # Validation
    errors = []
    
    if not data.get('name') or len(data.get('name', '').strip()) == 0:
        errors.append('Name is required')
    
    if not data.get('age') or data.get('age') < 1:
        errors.append('Valid age is required')
    
    if not data.get('service'):
        errors.append('Service is required')
    
    if errors:
        return jsonify({'errors': errors}), 400
    
    # Create application
    application = {
        'id': next_id,
        'name': data['name'].strip(),
        'age': data['age'],
        'service': data['service'],
        'status': 'pending',
        'date': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    }
    
    applications.append(application)
    next_id += 1
    
    return jsonify({
        'message': 'Application created successfully',
        'application': application
    }), 201
```

**JavaScript with Error Display:**
```javascript
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const applicationData = {
        name: document.querySelector('#name').value.trim(),
        age: parseInt(document.querySelector('#age').value),
        service: document.querySelector('#service').value
    };
    
    try {
        const response = await fetch('/api/applications', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(applicationData)
        });
        
        const result = await response.json();
        
        if (response.ok) {
            message.innerHTML = `<p class="success">${result.message}</p>`;
            form.reset();
            loadApplications();
        } else {
            // Display validation errors
            if (result.errors) {
                const errorList = result.errors.map(err => `<li>${err}</li>`).join('');
                message.innerHTML = `<div class="error"><ul>${errorList}</ul></div>`;
            } else {
                message.innerHTML = `<p class="error">${result.error}</p>`;
            }
        }
        
    } catch (error) {
        message.innerHTML = `<p class="error">Network error: ${error.message}</p>`;
    }
});
```

---

## Search and Filter

**Flask - Search by Name:**
```python
@app.route('/api/applications/search', methods=['GET'])
def search_applications():
    query = request.args.get('q', '').lower()
    
    if not query:
        return jsonify(applications)
    
    results = [app for app in applications if query in app['name'].lower()]
    return jsonify(results)
```

**JavaScript - Search Feature:**
```javascript
const searchInput = document.querySelector('#search');

searchInput.addEventListener('input', async (e) => {
    const query = e.target.value;
    
    const response = await fetch(`/api/applications/search?q=${query}`);
    const results = await response.json();
    
    displayApplications(results);
});
```

---

## Filter by Status

**Flask - Filter Endpoint:**
```python
@app.route('/api/applications/filter', methods=['GET'])
def filter_applications():
    status = request.args.get('status')
    
    if not status:
        return jsonify(applications)
    
    filtered = [app for app in applications if app['status'] == status]
    return jsonify(filtered)
```

**JavaScript - Filter Buttons:**
```javascript
function filterByStatus(status) {
    if (status === 'all') {
        loadApplications();
    } else {
        fetch(`/api/applications/filter?status=${status}`)
            .then(response => response.json())
            .then(applications => displayApplications(applications));
    }
}
```

**HTML:**
```html
<div class="filter-buttons">
    <button onclick="filterByStatus('all')">All</button>
    <button onclick="filterByStatus('pending')">Pending</button>
    <button onclick="filterByStatus('approved')">Approved</button>
    <button onclick="filterByStatus('rejected')">Rejected</button>
</div>
```

---

## CSS Styling

**style.css:**
```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #f5f5f5;
    padding: 20px;
}

.container {
    max-width: 800px;
    margin: 0 auto;
}

h1, h2 {
    color: #333;
    margin-bottom: 20px;
}

/* Form Styles */
.form-group {
    margin-bottom: 15px;
}

label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
}

input, select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
}

button {
    background: #1a73e8;
    color: white;
    padding: 12px 30px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
}

button:hover {
    background: #1557b0;
}

/* Message Styles */
.success {
    background: #d4edda;
    color: #155724;
    padding: 15px;
    border-radius: 5px;
    margin: 20px 0;
}

.error {
    background: #f8d7da;
    color: #721c24;
    padding: 15px;
    border-radius: 5px;
    margin: 20px 0;
}

/* Application Card Styles */
.application-card {
    background: white;
    padding: 20px;
    margin: 15px 0;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.application-card h3 {
    color: #1a73e8;
    margin-bottom: 10px;
}

.badge {
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 14px;
    font-weight: bold;
}

.badge.pending {
    background: #fff3cd;
    color: #856404;
}

.badge.approved {
    background: #d4edda;
    color: #155724;
}

.badge.rejected {
    background: #f8d7da;
    color: #721c24;
}
```

---

## Best Practices

1. **Validate on both frontend and backend**
2. **Use proper HTTP status codes** (200, 201, 400, 404)
3. **Show user-friendly error messages**
4. **Clear form after successful submission**
5. **Reload data after CREATE operations**
6. **Handle network errors gracefully**

---

## Summary

**CREATE Pattern:**
```javascript
// Send POST request with data
const response = await fetch('/api/resource', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
});
```

**READ Pattern:**
```javascript
// Send GET request
const response = await fetch('/api/resource');
const data = await response.json();
```

---

---

## Closing Story

Tian typed a name into the form: "Juan Dela Cruz, Age 30, Barangay Clearance." Clicked "Submit." The form sent a POST request to Flask. Flask validated the data, saved it to the database, and returned a success response.

Instantly, the new application appeared in the list below. No page refresh. Just smooth, real-time updates.

"That's CREATE," Kuya Miguel said. "You just saved data to a database through an API."

Rhea Joy tested it on her phone. Added three more applications. Each one appeared immediately. "This is exactly how real apps work!"

Tian grinned. The barangay portal was becoming functional. Real data. Real operations. Real power.

_Next up: CRUD Part 2 - Update and Delete operations!_