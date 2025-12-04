# Activity 1: CRUD - Create and Read Operations

In this activity, you'll implement the first two CRUD operations: **Create** (adding new data) and **Read** (retrieving and displaying data). These are the foundation of any data management system.

---

## Activity 1: Understanding CRUD

**CRUD** stands for the four basic operations you can perform on data:

| Operation | HTTP Method | Purpose | Example |
|-----------|-------------|---------|---------|
| **Create** | POST | Add new data | Add new resident |
| **Read** | GET | Retrieve data | View resident list |
| **Update** | PUT/PATCH | Modify existing data | Edit resident info |
| **Delete** | DELETE | Remove data | Delete resident |

**Today's focus:** Create (POST) and Read (GET)

---

## Activity 2: Setting Up the Database Structure

**Goal:** Create a proper data storage system.

**Option 1: JSON File Storage** (`app.py`):

```python
from flask import Flask, request, jsonify
from flask_cors import CORS
import json
import os
from datetime import datetime

app = Flask(__name__)
CORS(app)

# Data file path
DATA_FILE = 'residents.json'

# Initialize file if doesn't exist
if not os.path.exists(DATA_FILE):
    with open(DATA_FILE, 'w') as f:
        json.dump([], f)

# Helper: Read data from file
def read_residents():
    """Read all residents from JSON file"""
    try:
        with open(DATA_FILE, 'r') as f:
            return json.load(f)
    except:
        return []

# Helper: Write data to file
def write_residents(residents):
    """Write residents to JSON file"""
    with open(DATA_FILE, 'w') as f:
        json.dump(residents, f, indent=2)

# Helper: Generate unique ID
def generate_id(residents):
    """Generate next available ID"""
    if not residents:
        return 1
    return max(r['id'] for r in residents) + 1
```

---

## Activity 3: READ - Get All Residents

**Goal:** Implement GET endpoint to retrieve all residents.

**Flask endpoint:**

```python
@app.route('/api/residents', methods=['GET'])
def get_all_residents():
    """Get all residents"""
    try:
        residents = read_residents()
        return jsonify({
            'success': True,
            'count': len(residents),
            'residents': residents
        }), 200
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500
```

**JavaScript implementation:**

```javascript
const API_URL = 'http://localhost:5000/api';

// READ: Fetch all residents
async function loadAllResidents() {
    const listContainer = document.getElementById('residentList');
    
    try {
        // Show loading state
        listContainer.innerHTML = '<div class="loading">Loading residents...</div>';
        
        // Make GET request
        const response = await fetch(`${API_URL}/residents`);
        
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
        
        const data = await response.json();
        
        // Display residents
        if (data.residents.length === 0) {
            listContainer.innerHTML = '<p class="empty-message">No residents found. Add one below!</p>';
        } else {
            displayResidents(data.residents);
        }
        
    } catch (error) {
        console.error('Error loading residents:', error);
        listContainer.innerHTML = `<div class="error">Error: ${error.message}</div>`;
    }
}

// Display residents in UI
function displayResidents(residents) {
    const listContainer = document.getElementById('residentList');
    
    const html = residents.map(resident => `
        <div class="resident-card" data-id="${resident.id}">
            <div class="resident-header">
                <h3>${resident.name}</h3>
                <span class="resident-id">#${resident.id}</span>
            </div>
            <div class="resident-details">
                <p><strong>Age:</strong> ${resident.age} years old</p>
                <p><strong>Address:</strong> ${resident.address}</p>
                <p><strong>Clearance:</strong> ${resident.clearanceType}</p>
                <p><strong>Status:</strong> <span class="status-badge status-${resident.status}">${resident.status}</span></p>
            </div>
            <div class="resident-meta">
                <small>Added: ${resident.dateAdded}</small>
            </div>
            <div class="resident-actions">
                <button class="btn btn-edit" onclick="editResident(${resident.id})">Edit</button>
                <button class="btn btn-delete" onclick="deleteResident(${resident.id})">Delete</button>
            </div>
        </div>
    `).join('');
    
    listContainer.innerHTML = html;
}
```

---

## Activity 4: READ - Get Single Resident by ID

**Flask endpoint:**

```python
@app.route('/api/residents/<int:resident_id>', methods=['GET'])
def get_resident_by_id(resident_id):
    """Get specific resident by ID"""
    try:
        residents = read_residents()
        resident = next((r for r in residents if r['id'] == resident_id), None)
        
        if resident:
            return jsonify({
                'success': True,
                'resident': resident
            }), 200
        else:
            return jsonify({
                'success': False,
                'error': 'Resident not found'
            }), 404
            
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500
```

**JavaScript:**

```javascript
// READ: Get single resident
async function getResidentById(id) {
    try {
        const response = await fetch(`${API_URL}/residents/${id}`);
        
        if (!response.ok) {
            throw new Error('Resident not found');
        }
        
        const data = await response.json();
        return data.resident;
        
    } catch (error) {
        console.error('Error:', error);
        throw error;
    }
}
```

---

## Activity 5: CREATE - Add New Resident

**Flask endpoint:**

```python
@app.route('/api/residents', methods=['POST'])
def create_resident():
    """Create new resident"""
    try:
        # Get data from request
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['name', 'age', 'address', 'clearanceType']
        for field in required_fields:
            if field not in data or not data[field]:
                return jsonify({
                    'success': False,
                    'error': f'{field} is required'
                }), 400
        
        # Validate age
        age = int(data['age'])
        if age < 18 or age > 150:
            return jsonify({
                'success': False,
                'error': 'Age must be between 18 and 150'
            }), 400
        
        # Read existing residents
        residents = read_residents()
        
        # Create new resident
        new_resident = {
            'id': generate_id(residents),
            'name': data['name'].strip(),
            'age': age,
            'address': data['address'].strip(),
            'clearanceType': data['clearanceType'],
            'status': 'pending',
            'dateAdded': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        
        # Add to list
        residents.append(new_resident)
        
        # Save to file
        write_residents(residents)
        
        return jsonify({
            'success': True,
            'message': 'Resident created successfully',
            'resident': new_resident
        }), 201
        
    except ValueError:
        return jsonify({
            'success': False,
            'error': 'Invalid age value'
        }), 400
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

if __name__ == '__main__':
    app.run(debug=True, port=5000)
```

**HTML Form:**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD - Create & Read</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background: #f5f5f5;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h2 {
            color: #34495e;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        label {
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        
        input, select {
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #3498db;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
        }
        
        .btn-primary:hover {
            background: #2980b9;
        }
        
        .btn-edit {
            background: #f39c12;
            color: white;
            padding: 8px 16px;
            font-size: 14px;
        }
        
        .btn-delete {
            background: #e74c3c;
            color: white;
            padding: 8px 16px;
            font-size: 14px;
        }
        
        #residentList {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .resident-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #3498db;
            animation: fadeIn 0.5s;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .resident-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .resident-header h3 {
            color: #2c3e50;
            font-size: 1.2rem;
        }
        
        .resident-id {
            background: #3498db;
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.875rem;
        }
        
        .resident-details p {
            margin: 8px 0;
            color: #555;
        }
        
        .status-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 0.875rem;
            font-weight: bold;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .resident-meta {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #dee2e6;
        }
        
        .resident-meta small {
            color: #999;
        }
        
        .resident-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        
        .loading {
            text-align: center;
            padding: 40px;
            color: #3498db;
            font-size: 18px;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        
        .empty-message {
            text-align: center;
            color: #999;
            padding: 40px;
            font-style: italic;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            animation: slideIn 0.5s;
        }
        
        @keyframes slideIn {
            from { transform: translateX(-100%); }
            to { transform: translateX(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏘️ Barangay Resident Management</h1>
        <p>CRUD Operations: Create & Read</p>
        
        <!-- CREATE Section -->
        <section class="section">
            <h2>➕ Add New Resident</h2>
            
            <form id="addResidentForm">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="name">Full Name: *</label>
                        <input type="text" id="name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="age">Age: *</label>
                        <input type="number" id="age" required min="18" max="150">
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address: *</label>
                        <input type="text" id="address" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="clearanceType">Clearance Type: *</label>
                        <select id="clearanceType" required>
                            <option value="">-- Select Type --</option>
                            <option value="Barangay Clearance">Barangay Clearance</option>
                            <option value="Business Permit">Business Permit</option>
                            <option value="Barangay ID">Barangay ID</option>
                            <option value="Police Clearance">Police Clearance</option>
                        </select>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary">Add Resident</button>
            </form>
            
            <div id="formMessage"></div>
        </section>
        
        <!-- READ Section -->
        <section class="section">
            <h2>📋 Resident List</h2>
            <button class="btn btn-primary" onclick="loadAllResidents()">🔄 Refresh List</button>
            <div id="residentList" style="margin-top: 20px;"></div>
        </section>
    </div>

    <script>
        const API_URL = 'http://localhost:5000/api';
        
        // Load residents on page load
        document.addEventListener('DOMContentLoaded', () => {
            loadAllResidents();
        });
        
        // CREATE: Add new resident
        document.getElementById('addResidentForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const messageDiv = document.getElementById('formMessage');
            const submitBtn = e.target.querySelector('button[type="submit"]');
            
            // Get form data
            const residentData = {
                name: document.getElementById('name').value,
                age: parseInt(document.getElementById('age').value),
                address: document.getElementById('address').value,
                clearanceType: document.getElementById('clearanceType').value
            };
            
            try {
                // Disable button
                submitBtn.disabled = true;
                submitBtn.textContent = 'Adding...';
                
                // Send POST request
                const response = await fetch(`${API_URL}/residents`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(residentData)
                });
                
                const data = await response.json();
                
                if (!response.ok) {
                    throw new Error(data.error || 'Failed to add resident');
                }
                
                // Show success message
                messageDiv.innerHTML = `
                    <div class="success-message">
                        ✅ ${data.message}<br>
                        <strong>${data.resident.name}</strong> has been added successfully!
                    </div>
                `;
                
                // Clear form
                e.target.reset();
                
                // Reload residents
                loadAllResidents();
                
                // Clear message after 5 seconds
                setTimeout(() => {
                    messageDiv.innerHTML = '';
                }, 5000);
                
            } catch (error) {
                console.error('Error:', error);
                messageDiv.innerHTML = `<div class="error">❌ Error: ${error.message}</div>`;
            } finally {
                submitBtn.disabled = false;
                submitBtn.textContent = 'Add Resident';
            }
        });
        
        // READ: Load all residents
        async function loadAllResidents() {
            const listContainer = document.getElementById('residentList');
            
            try {
                listContainer.innerHTML = '<div class="loading">Loading residents...</div>';
                
                const response = await fetch(`${API_URL}/residents`);
                
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                
                const data = await response.json();
                
                if (data.residents.length === 0) {
                    listContainer.innerHTML = '<p class="empty-message">No residents found. Add one above!</p>';
                } else {
                    displayResidents(data.residents);
                }
                
            } catch (error) {
                console.error('Error:', error);
                listContainer.innerHTML = `<div class="error">Error loading residents: ${error.message}</div>`;
            }
        }
        
        // Display residents
        function displayResidents(residents) {
            const listContainer = document.getElementById('residentList');
            
            const html = residents.map(resident => `
                <div class="resident-card" data-id="${resident.id}">
                    <div class="resident-header">
                        <h3>${resident.name}</h3>
                        <span class="resident-id">#${resident.id}</span>
                    </div>
                    <div class="resident-details">
                        <p><strong>Age:</strong> ${resident.age} years old</p>
                        <p><strong>Address:</strong> ${resident.address}</p>
                        <p><strong>Clearance:</strong> ${resident.clearanceType}</p>
                        <p><strong>Status:</strong> <span class="status-badge status-${resident.status}">${resident.status}</span></p>
                    </div>
                    <div class="resident-meta">
                        <small>Added: ${resident.dateAdded}</small>
                    </div>
                    <div class="resident-actions">
                        <button class="btn btn-edit" onclick="editResident(${resident.id})">Edit</button>
                        <button class="btn btn-delete" onclick="deleteResident(${resident.id})">Delete</button>
                    </div>
                </div>
            `).join('');
            
            listContainer.innerHTML = html;
        }
        
        // Placeholder functions (will implement in next lesson)
        function editResident(id) {
            alert(`Edit functionality coming in next lesson! Resident ID: ${id}`);
        }
        
        function deleteResident(id) {
            alert(`Delete functionality coming in next lesson! Resident ID: ${id}`);
        }
    </script>
</body>
</html>
```

---

## Activity 6: Search and Filter

**Goal:** Add search functionality to READ operation.

**Flask endpoint:**

```python
@app.route('/api/residents/search', methods=['GET'])
def search_residents():
    """Search residents by name or address"""
    try:
        query = request.args.get('q', '').lower()
        
        if not query:
            return jsonify({
                'success': False,
                'error': 'Search query is required'
            }), 400
        
        residents = read_residents()
        
        # Filter residents
        results = [
            r for r in residents
            if query in r['name'].lower() or query in r['address'].lower()
        ]
        
        return jsonify({
            'success': True,
            'count': len(results),
            'results': results
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500
```

**JavaScript:**

```javascript
// Add search functionality
async function searchResidents(query) {
    if (!query.trim()) {
        loadAllResidents();
        return;
    }
    
    try {
        const response = await fetch(`${API_URL}/residents/search?q=${encodeURIComponent(query)}`);
        const data = await response.json();
        
        if (data.results.length === 0) {
            document.getElementById('residentList').innerHTML = 
                '<p class="empty-message">No residents found matching your search.</p>';
        } else {
            displayResidents(data.results);
        }
        
    } catch (error) {
        console.error('Error:', error);
    }
}

// Add search input to HTML
// <input type="text" id="searchInput" placeholder="Search residents..." 
//        oninput="searchResidents(this.value)">
```

---

## 📚 Key Takeaways

1. **CREATE (POST)** - Add new data with validation
2. **READ (GET)** - Retrieve and display data
3. Store data persistently (JSON file or database)
4. Validate input on both frontend and backend
5. Provide user feedback (loading, success, error messages)
6. Use proper HTTP status codes (200, 201, 400, 404, 500)
7. Handle errors gracefully

---

## 🚀 Challenge

Enhance the system:
1. Add pagination (10 residents per page)
2. Sort residents by name, age, or date
3. Filter by clearance type
4. Add resident count statistics
5. Export residents to CSV
6. Bulk import from file
7. Add form validation with error messages

Next lesson: **UPDATE and DELETE operations!** 🎉

