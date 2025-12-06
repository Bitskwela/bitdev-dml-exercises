# Activity 1: JavaScript Fetch to Flask API

In this activity, you'll learn how to send data from your JavaScript frontend to a Flask backend using the Fetch API. You'll build a system where JavaScript communicates with Flask endpoints.

---

## Activity 1: Understanding Frontend-Backend Communication

**Goal:** Understand how JavaScript talks to Flask.

**The Flow:**
1. User interacts with webpage (clicks button, submits form)
2. JavaScript captures the action
3. JavaScript sends HTTP request to Flask (using Fetch)
4. Flask processes the request
5. Flask sends response back
6. JavaScript receives response and updates the page

**Communication Methods:**
- **GET** - Retrieve data from server
- **POST** - Send new data to server
- **PUT** - Update existing data
- **DELETE** - Remove data from server

---

## Activity 2: Setting Up Flask API Endpoints

**Goal:** Create Flask endpoints that JavaScript can call.

**Create:** `app.py`

```python
from flask import Flask, request, jsonify
from flask_cors import CORS
import json
from datetime import datetime

app = Flask(__name__)
CORS(app)  # Allow JavaScript to communicate with Flask

# In-memory data storage (temporary)
residents = []

# GET endpoint - Retrieve all residents
@app.route('/api/residents', methods=['GET'])
def get_residents():
    """Return all residents as JSON"""
    return jsonify(residents), 200

# GET endpoint - Retrieve single resident by ID
@app.route('/api/residents/<int:resident_id>', methods=['GET'])
def get_resident(resident_id):
    """Return specific resident"""
    resident = next((r for r in residents if r['id'] == resident_id), None)
    
    if resident:
        return jsonify(resident), 200
    else:
        return jsonify({'error': 'Resident not found'}), 404

# POST endpoint - Add new resident
@app.route('/api/residents', methods=['POST'])
def add_resident():
    """Add a new resident"""
    try:
        data = request.get_json()
        
        # Validate data
        if not data.get('name') or not data.get('age'):
            return jsonify({'error': 'Name and age are required'}), 400
        
        # Create new resident
        new_resident = {
            'id': len(residents) + 1,
            'name': data['name'],
            'age': int(data['age']),
            'address': data.get('address', ''),
            'clearanceType': data.get('clearanceType', 'Barangay Clearance'),
            'dateAdded': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        
        residents.append(new_resident)
        
        return jsonify({
            'message': 'Resident added successfully',
            'resident': new_resident
        }), 201
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Run Flask app
if __name__ == '__main__':
    app.run(debug=True, port=5000)
```

**Install requirements:**
```bash
pip install flask flask-cors
```

---

## Activity 3: JavaScript GET Request to Flask

**Goal:** Fetch data from Flask API using JavaScript.

**Create:** `index.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JS Fetch to Flask</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        button {
            padding: 12px 24px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin: 10px 5px;
        }
        
        button:hover {
            background: #2980b9;
        }
        
        .resident-list {
            margin-top: 20px;
        }
        
        .resident-card {
            background: #f8f9fa;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 5px;
            border-left: 4px solid #3498db;
        }
        
        .resident-card h3 {
            color: #2c3e50;
            margin-bottom: 8px;
        }
        
        .resident-card p {
            color: #666;
            margin: 4px 0;
        }
        
        .loading {
            text-align: center;
            padding: 20px;
            color: #3498db;
            font-style: italic;
        }
        
        .error {
            background: #ffe6e6;
            color: #c0392b;
            padding: 15px;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏘️ Barangay Resident System</h1>
        <p>Fetching data from Flask API</p>
        
        <div>
            <button id="fetchBtn">Fetch All Residents</button>
            <button id="fetchOneBtn">Fetch Resident #1</button>
        </div>
        
        <div id="residentList" class="resident-list"></div>
    </div>

    <script>
        const API_URL = 'http://localhost:5000/api';
        
        // Fetch all residents (GET request)
        async function fetchAllResidents() {
            const listDiv = document.getElementById('residentList');
            
            try {
                // Show loading
                listDiv.innerHTML = '<div class="loading">Loading residents...</div>';
                
                // Make GET request to Flask
                const response = await fetch(`${API_URL}/residents`);
                
                // Check if request was successful
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                
                // Parse JSON response
                const residents = await response.json();
                
                // Display residents
                if (residents.length === 0) {
                    listDiv.innerHTML = '<p style="color: #999;">No residents found. Add some first!</p>';
                } else {
                    displayResidents(residents);
                }
                
            } catch (error) {
                console.error('Error:', error);
                listDiv.innerHTML = `<div class="error">Error fetching residents: ${error.message}</div>`;
            }
        }
        
        // Fetch single resident by ID
        async function fetchSingleResident(id) {
            const listDiv = document.getElementById('residentList');
            
            try {
                listDiv.innerHTML = '<div class="loading">Loading resident...</div>';
                
                const response = await fetch(`${API_URL}/residents/${id}`);
                
                if (!response.ok) {
                    throw new Error(`Resident not found`);
                }
                
                const resident = await response.json();
                displayResidents([resident]);
                
            } catch (error) {
                console.error('Error:', error);
                listDiv.innerHTML = `<div class="error">Error: ${error.message}</div>`;
            }
        }
        
        // Display residents in UI
        function displayResidents(residents) {
            const listDiv = document.getElementById('residentList');
            
            const html = residents.map(resident => `
                <div class="resident-card">
                    <h3>${resident.name}</h3>
                    <p><strong>ID:</strong> ${resident.id}</p>
                    <p><strong>Age:</strong> ${resident.age} years old</p>
                    <p><strong>Address:</strong> ${resident.address || 'N/A'}</p>
                    <p><strong>Clearance:</strong> ${resident.clearanceType}</p>
                    <p><strong>Date Added:</strong> ${resident.dateAdded}</p>
                </div>
            `).join('');
            
            listDiv.innerHTML = html;
        }
        
        // Event listeners
        document.getElementById('fetchBtn').addEventListener('click', fetchAllResidents);
        document.getElementById('fetchOneBtn').addEventListener('click', () => fetchSingleResident(1));
        
        // Auto-fetch on page load
        fetchAllResidents();
    </script>
</body>
</html>
```

**Test:**
1. Run Flask: `python app.py`
2. Open `index.html` in browser
3. Click "Fetch All Residents"

---

## Activity 4: JavaScript POST Request to Flask

**Goal:** Send data from JavaScript form to Flask.

**Add to `index.html`** (inside container div):

```html
<section style="margin-top: 30px; padding-top: 30px; border-top: 2px solid #eee;">
    <h2>Add New Resident</h2>
    
    <form id="addResidentForm">
        <div style="margin-bottom: 15px;">
            <label for="name" style="display: block; margin-bottom: 5px;">Name:</label>
            <input type="text" id="name" required 
                   style="width: 100%; padding: 8px; border: 2px solid #ddd; border-radius: 5px;">
        </div>
        
        <div style="margin-bottom: 15px;">
            <label for="age" style="display: block; margin-bottom: 5px;">Age:</label>
            <input type="number" id="age" required min="18" max="150"
                   style="width: 100%; padding: 8px; border: 2px solid #ddd; border-radius: 5px;">
        </div>
        
        <div style="margin-bottom: 15px;">
            <label for="address" style="display: block; margin-bottom: 5px;">Address:</label>
            <input type="text" id="address"
                   style="width: 100%; padding: 8px; border: 2px solid #ddd; border-radius: 5px;">
        </div>
        
        <div style="margin-bottom: 15px;">
            <label for="clearanceType" style="display: block; margin-bottom: 5px;">Clearance Type:</label>
            <select id="clearanceType"
                    style="width: 100%; padding: 8px; border: 2px solid #ddd; border-radius: 5px;">
                <option value="Barangay Clearance">Barangay Clearance</option>
                <option value="Business Permit">Business Permit</option>
                <option value="Barangay ID">Barangay ID</option>
            </select>
        </div>
        
        <button type="submit" style="background: #27ae60;">Add Resident</button>
    </form>
    
    <div id="formResult"></div>
</section>
```

**Add JavaScript function** (inside script tag):

```javascript
// POST request - Add new resident
async function addResident(residentData) {
    const resultDiv = document.getElementById('formResult');
    
    try {
        // Show loading
        resultDiv.innerHTML = '<div class="loading">Adding resident...</div>';
        
        // Make POST request to Flask
        const response = await fetch(`${API_URL}/residents`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(residentData)
        });
        
        // Parse response
        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.error || 'Failed to add resident');
        }
        
        // Show success message
        resultDiv.innerHTML = `
            <div style="background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-top: 10px;">
                ✅ Resident added successfully!<br>
                ID: ${data.resident.id}<br>
                Name: ${data.resident.name}
            </div>
        `;
        
        // Refresh the list
        fetchAllResidents();
        
        // Clear form
        document.getElementById('addResidentForm').reset();
        
    } catch (error) {
        console.error('Error:', error);
        resultDiv.innerHTML = `<div class="error">Error: ${error.message}</div>`;
    }
}

// Handle form submission
document.getElementById('addResidentForm').addEventListener('submit', (event) => {
    event.preventDefault();
    
    const residentData = {
        name: document.getElementById('name').value,
        age: parseInt(document.getElementById('age').value),
        address: document.getElementById('address').value,
        clearanceType: document.getElementById('clearanceType').value
    };
    
    addResident(residentData);
});
```

---

## Activity 5: Understanding Request/Response

**Request Structure:**

```javascript
// GET request - Simple
fetch('http://localhost:5000/api/residents')

// POST request - With body
fetch('http://localhost:5000/api/residents', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'  // Tell server we're sending JSON
    },
    body: JSON.stringify({                  // Convert JS object to JSON string
        name: "Juan",
        age: 65
    })
})
```

**Response Handling:**

```javascript
const response = await fetch(url);

// Check if successful (status 200-299)
if (!response.ok) {
    throw new Error(`HTTP error! Status: ${response.status}`);
}

// Parse JSON response
const data = await response.json();

// Use the data
console.log(data);
```

---

## Activity 6: Error Handling Best Practices

**Goal:** Handle different types of errors properly.

```javascript
async function fetchWithErrorHandling() {
    try {
        // Network request
        const response = await fetch(`${API_URL}/residents`);
        
        // HTTP error (404, 500, etc.)
        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || `HTTP ${response.status}`);
        }
        
        // Parse JSON
        const data = await response.json();
        return data;
        
    } catch (error) {
        // Network error (no internet, server down)
        if (error instanceof TypeError) {
            console.error('Network error:', error);
            alert('Cannot connect to server. Is Flask running?');
        } else {
            // HTTP or application error
            console.error('Error:', error);
            alert(`Error: ${error.message}`);
        }
        
        throw error;  // Re-throw if needed
    }
}
```

---

## Activity 7: Complete Example with All HTTP Methods

**Goal:** Add PUT and DELETE methods.

**Update `app.py`** with new endpoints:

```python
# PUT endpoint - Update resident
@app.route('/api/residents/<int:resident_id>', methods=['PUT'])
def update_resident(resident_id):
    """Update existing resident"""
    try:
        data = request.get_json()
        resident = next((r for r in residents if r['id'] == resident_id), None)
        
        if not resident:
            return jsonify({'error': 'Resident not found'}), 404
        
        # Update fields
        resident['name'] = data.get('name', resident['name'])
        resident['age'] = int(data.get('age', resident['age']))
        resident['address'] = data.get('address', resident['address'])
        resident['clearanceType'] = data.get('clearanceType', resident['clearanceType'])
        
        return jsonify({
            'message': 'Resident updated successfully',
            'resident': resident
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# DELETE endpoint - Remove resident
@app.route('/api/residents/<int:resident_id>', methods=['DELETE'])
def delete_resident(resident_id):
    """Delete resident"""
    global residents
    
    resident = next((r for r in residents if r['id'] == resident_id), None)
    
    if not resident:
        return jsonify({'error': 'Resident not found'}), 404
    
    residents = [r for r in residents if r['id'] != resident_id]
    
    return jsonify({
        'message': 'Resident deleted successfully',
        'deletedId': resident_id
    }), 200
```

**JavaScript functions for PUT and DELETE:**

```javascript
// UPDATE resident (PUT)
async function updateResident(id, updatedData) {
    try {
        const response = await fetch(`${API_URL}/residents/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedData)
        });
        
        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.error);
        }
        
        alert('Resident updated successfully!');
        fetchAllResidents();
        
    } catch (error) {
        alert(`Error: ${error.message}`);
    }
}

// DELETE resident
async function deleteResident(id) {
    if (!confirm('Are you sure you want to delete this resident?')) {
        return;
    }
    
    try {
        const response = await fetch(`${API_URL}/residents/${id}`, {
            method: 'DELETE'
        });
        
        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.error);
        }
        
        alert('Resident deleted successfully!');
        fetchAllResidents();
        
    } catch (error) {
        alert(`Error: ${error.message}`);
    }
}
```

---

## 📚 Key Takeaways

1. **Fetch API** makes HTTP requests from JavaScript to Flask
2. **GET** retrieves data, **POST** creates, **PUT** updates, **DELETE** removes
3. Always use `async/await` for cleaner asynchronous code
4. Check `response.ok` before parsing JSON
5. Handle errors with try/catch blocks
6. **CORS** must be enabled in Flask for JavaScript to communicate
7. Send JSON data with `Content-Type: application/json` header
8. Convert JavaScript objects to JSON with `JSON.stringify()`

---

## 🚀 Challenge

Enhance the system:
1. Add search functionality (GET with query parameters)
2. Add pagination (limit, offset)
3. Add loading spinners during requests
4. Add toast notifications for success/error
5. Implement form validation before sending
6. Add request timeout handling
7. Cache responses for better performance

Great job connecting JavaScript to Flask!