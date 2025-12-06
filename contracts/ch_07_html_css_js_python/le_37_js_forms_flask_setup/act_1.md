# Activity 1: JavaScript Forms and Flask Setup

In this activity, you'll learn how to set up a **Flask backend server** to work with your JavaScript frontend forms. You'll create a complete form submission system where JavaScript sends data to Flask and receives responses.

---

## Activity 1: Understanding the Frontend-Backend Connection

**Frontend (JavaScript):** Handles user interface, form validation, display
**Backend (Flask/Python):** Processes data, stores information, business logic

**Flow:**
1. User fills out form in browser
2. JavaScript validates input
3. JavaScript sends data to Flask (using Fetch API)
4. Flask processes data and responds
5. JavaScript displays the result

---

## Activity 2: Setting Up Flask

First, install Flask and create the basic server structure.

### Installation:

```bash
# Create a virtual environment (recommended)
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# Mac/Linux:
source venv/bin/activate

# Install Flask
pip install Flask flask-cors
```

### Project Structure:

```
barangay-system/
├── app.py              # Flask application
├── static/
│   ├── index.html      # Frontend HTML
│   ├── styles.css      # CSS
│   └── script.js       # JavaScript
├── templates/          # Flask templates (optional)
└── data/
    └── residents.json  # Data storage (temporary)
```

---

## Activity 3: Creating the Flask Application

### app.py (Basic Flask Server):

```python
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import json
import os
from datetime import datetime

app = Flask(__name__, static_folder='static')
CORS(app)  # Enable Cross-Origin Resource Sharing

# Path to data file
DATA_FILE = 'data/residents.json'

# Ensure data directory exists
os.makedirs('data', exist_ok=True)

# Initialize data file if it doesn't exist
if not os.path.exists(DATA_FILE):
    with open(DATA_FILE, 'w') as f:
        json.dump([], f)


# Helper function to read data
def read_data():
    """Read residents data from JSON file"""
    try:
        with open(DATA_FILE, 'r') as f:
            return json.load(f)
    except:
        return []


# Helper function to write data
def write_data(data):
    """Write residents data to JSON file"""
    with open(DATA_FILE, 'w') as f:
        json.dump(data, f, indent=2)


# Serve the main HTML page
@app.route('/')
def index():
    return send_from_directory('static', 'index.html')


# API endpoint to get all residents
@app.route('/api/residents', methods=['GET'])
def get_residents():
    """Get all residents"""
    residents = read_data()
    return jsonify(residents), 200


# API endpoint to add a new resident
@app.route('/api/residents', methods=['POST'])
def add_resident():
    """Add a new resident"""
    try:
        # Get data from request
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['name', 'age', 'address', 'clearanceType']
        for field in required_fields:
            if field not in data or not data[field]:
                return jsonify({'error': f'{field} is required'}), 400
        
        # Validate age
        age = int(data['age'])
        if age < 18 or age > 150:
            return jsonify({'error': 'Age must be between 18 and 150'}), 400
        
        # Read existing residents
        residents = read_data()
        
        # Create new resident
        new_resident = {
            'id': len(residents) + 1,
            'name': data['name'],
            'age': age,
            'address': data['address'],
            'clearanceType': data['clearanceType'],
            'purpose': data.get('purpose', ''),
            'fee': calculate_fee(data['clearanceType'], age),
            'status': 'pending',
            'dateApplied': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        
        # Add to list
        residents.append(new_resident)
        
        # Save to file
        write_data(residents)
        
        return jsonify({
            'message': 'Resident added successfully',
            'resident': new_resident
        }), 201
        
    except ValueError as e:
        return jsonify({'error': 'Invalid age value'}), 400
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# Helper function to calculate fee
def calculate_fee(clearance_type, age):
    """Calculate fee based on clearance type and age"""
    fees = {
        'Barangay Clearance': 50,
        'Police Clearance': 100,
        'Business Permit': 150,
        'Barangay ID': 30
    }
    
    base_fee = fees.get(clearance_type, 50)
    
    # Senior citizen discount (20% off for 60+)
    if age >= 60:
        base_fee = base_fee * 0.8
    
    return base_fee


# Run the app
if __name__ == '__main__':
    app.run(debug=True, port=5000)
```

---

## Activity 4: Creating the Frontend HTML Form

### static/index.html:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Clearance System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🏘️ Barangay Clearance Application System</h1>
            <p>Submit your clearance application online</p>
        </header>

        <!-- Application Form -->
        <section class="form-section">
            <h2>New Application</h2>
            <form id="applicationForm">
                <div class="form-group">
                    <label for="name">Full Name: <span class="required">*</span></label>
                    <input type="text" id="name" name="name" required>
                    <span class="error-message" id="nameError"></span>
                </div>

                <div class="form-group">
                    <label for="age">Age: <span class="required">*</span></label>
                    <input type="number" id="age" name="age" min="18" max="150" required>
                    <span class="error-message" id="ageError"></span>
                </div>

                <div class="form-group">
                    <label for="address">Address: <span class="required">*</span></label>
                    <input type="text" id="address" name="address" required>
                    <span class="error-message" id="addressError"></span>
                </div>

                <div class="form-group">
                    <label for="clearanceType">Clearance Type: <span class="required">*</span></label>
                    <select id="clearanceType" name="clearanceType" required>
                        <option value="">-- Select Type --</option>
                        <option value="Barangay Clearance">Barangay Clearance (₱50)</option>
                        <option value="Police Clearance">Police Clearance (₱100)</option>
                        <option value="Business Permit">Business Permit (₱150)</option>
                        <option value="Barangay ID">Barangay ID (₱30)</option>
                    </select>
                    <span class="error-message" id="clearanceError"></span>
                </div>

                <div class="form-group">
                    <label for="purpose">Purpose:</label>
                    <textarea id="purpose" name="purpose" rows="3"></textarea>
                </div>

                <div class="fee-preview" id="feePreview">
                    <p>Estimated Fee: <strong id="estimatedFee">₱0</strong></p>
                    <p id="discountInfo"></p>
                </div>

                <button type="submit" class="btn btn-primary" id="submitBtn">
                    Submit Application
                </button>
            </form>
        </section>

        <!-- Result Display -->
        <section id="resultSection" class="result-section" style="display: none;">
            <h2>Application Result</h2>
            <div id="resultContent"></div>
        </section>

        <!-- Residents List -->
        <section class="residents-section">
            <h2>Recent Applications</h2>
            <button class="btn btn-secondary" id="refreshBtn">Refresh List</button>
            <div id="residentsList"></div>
        </section>
    </div>

    <!-- Loading Overlay -->
    <div id="loadingOverlay" class="loading-overlay">
        <div class="spinner"></div>
        <p>Processing...</p>
    </div>

    <script src="script.js"></script>
</body>
</html>
```

---

## Activity 5: Styling the Form

### static/styles.css:

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
}

.container {
    max-width: 900px;
    margin: 0 auto;
}

header {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    text-align: center;
    margin-bottom: 2rem;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

header h1 {
    color: #2c3e50;
    margin-bottom: 0.5rem;
}

header p {
    color: #666;
}

.form-section,
.result-section,
.residents-section {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    margin-bottom: 2rem;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

h2 {
    color: #2c3e50;
    margin-bottom: 1.5rem;
}

.form-group {
    margin-bottom: 1.5rem;
}

label {
    display: block;
    margin-bottom: 0.5rem;
    color: #333;
    font-weight: 500;
}

.required {
    color: #e74c3c;
}

input,
select,
textarea {
    width: 100%;
    padding: 0.75rem;
    border: 2px solid #ddd;
    border-radius: 5px;
    font-size: 1rem;
    transition: border-color 0.3s;
}

input:focus,
select:focus,
textarea:focus {
    border-color: #667eea;
    outline: none;
}

.error-message {
    display: block;
    color: #e74c3c;
    font-size: 0.875rem;
    margin-top: 0.25rem;
    min-height: 1.2rem;
}

.fee-preview {
    background: #e8f5e9;
    padding: 1rem;
    border-radius: 5px;
    margin: 1.5rem 0;
}

.fee-preview p {
    margin: 0.25rem 0;
    color: #2e7d32;
}

.fee-preview strong {
    font-size: 1.2rem;
}

.btn {
    padding: 0.75rem 2rem;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
    transition: transform 0.2s, box-shadow 0.2s;
}

.btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    width: 100%;
}

.btn-secondary {
    background: #3498db;
    color: white;
    margin-bottom: 1rem;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.btn:disabled {
    background: #ccc;
    cursor: not-allowed;
    transform: none;
}

.result-section {
    animation: slideIn 0.5s;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

#resultContent {
    background: #e8f5e9;
    padding: 1.5rem;
    border-radius: 5px;
    border-left: 4px solid #4caf50;
}

#resultContent h3 {
    color: #2e7d32;
    margin-bottom: 1rem;
}

#resultContent p {
    margin: 0.5rem 0;
    color: #333;
}

.resident-card {
    background: #f9f9f9;
    padding: 1rem;
    border-radius: 5px;
    margin-bottom: 1rem;
    border-left: 4px solid #667eea;
}

.resident-card h3 {
    color: #2c3e50;
    margin-bottom: 0.5rem;
}

.resident-card p {
    margin: 0.25rem 0;
    color: #666;
}

.status-badge {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    border-radius: 15px;
    font-size: 0.875rem;
    font-weight: 500;
}

.status-pending {
    background: #fff3cd;
    color: #856404;
}

.status-approved {
    background: #d4edda;
    color: #155724;
}

.loading-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.7);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.loading-overlay.show {
    display: flex;
}

.spinner {
    width: 50px;
    height: 50px;
    border: 5px solid rgba(255,255,255,0.3);
    border-top-color: white;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

.loading-overlay p {
    color: white;
    margin-top: 1rem;
    font-size: 1.2rem;
}

@media (max-width: 768px) {
    body {
        padding: 10px;
    }
    
    header,
    .form-section,
    .result-section,
    .residents-section {
        padding: 1.5rem;
    }
}
```

---

## Activity 6: JavaScript Integration with Flask

### static/script.js:

```javascript
// API Base URL
const API_URL = 'http://localhost:5000/api';

// DOM Elements
const form = document.getElementById('applicationForm');
const submitBtn = document.getElementById('submitBtn');
const resultSection = document.getElementById('resultSection');
const resultContent = document.getElementById('resultContent');
const residentsList = document.getElementById('residentsList');
const refreshBtn = document.getElementById('refreshBtn');
const loadingOverlay = document.getElementById('loadingOverlay');
const estimatedFee = document.getElementById('estimatedFee');
const discountInfo = document.getElementById('discountInfo');

// Form inputs
const nameInput = document.getElementById('name');
const ageInput = document.getElementById('age');
const addressInput = document.getElementById('address');
const clearanceTypeInput = document.getElementById('clearanceType');
const purposeInput = document.getElementById('purpose');

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    loadResidents();
    setupEventListeners();
});

// Setup event listeners
function setupEventListeners() {
    // Form submission
    form.addEventListener('submit', handleSubmit);
    
    // Refresh button
    refreshBtn.addEventListener('click', loadResidents);
    
    // Fee calculation on input change
    ageInput.addEventListener('input', calculateFeePreview);
    clearanceTypeInput.addEventListener('change', calculateFeePreview);
}

// Calculate and display fee preview
function calculateFeePreview() {
    const age = parseInt(ageInput.value) || 0;
    const clearanceType = clearanceTypeInput.value;
    
    if (!clearanceType || age < 18) {
        estimatedFee.textContent = '₱0';
        discountInfo.textContent = '';
        return;
    }
    
    const fees = {
        'Barangay Clearance': 50,
        'Police Clearance': 100,
        'Business Permit': 150,
        'Barangay ID': 30
    };
    
    let fee = fees[clearanceType] || 0;
    
    if (age >= 60) {
        const discount = fee * 0.2;
        fee = fee - discount;
        discountInfo.textContent = `🎉 Senior Citizen Discount Applied! (20% off)`;
    } else {
        discountInfo.textContent = '';
    }
    
    estimatedFee.textContent = `₱${fee}`;
}

// Handle form submission
async function handleSubmit(event) {
    event.preventDefault();
    
    // Clear previous errors
    clearErrors();
    
    // Validate form
    if (!validateForm()) {
        return;
    }
    
    // Get form data
    const formData = {
        name: nameInput.value.trim(),
        age: parseInt(ageInput.value),
        address: addressInput.value.trim(),
        clearanceType: clearanceTypeInput.value,
        purpose: purposeInput.value.trim()
    };
    
    try {
        // Show loading
        showLoading();
        
        // Send POST request to Flask
        const response = await fetch(`${API_URL}/residents`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        });
        
        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.error || 'Failed to submit application');
        }
        
        // Show success result
        displayResult(data);
        
        // Reset form
        form.reset();
        calculateFeePreview();
        
        // Reload residents list
        loadResidents();
        
    } catch (error) {
        console.error('Error:', error);
        showError(error.message);
    } finally {
        hideLoading();
    }
}

// Validate form
function validateForm() {
    let isValid = true;
    
    // Name validation
    if (nameInput.value.trim().length < 2) {
        showFieldError('nameError', 'Name must be at least 2 characters');
        isValid = false;
    }
    
    // Age validation
    const age = parseInt(ageInput.value);
    if (isNaN(age) || age < 18 || age > 150) {
        showFieldError('ageError', 'Age must be between 18 and 150');
        isValid = false;
    }
    
    // Address validation
    if (addressInput.value.trim().length < 5) {
        showFieldError('addressError', 'Please enter a valid address');
        isValid = false;
    }
    
    // Clearance type validation
    if (!clearanceTypeInput.value) {
        showFieldError('clearanceError', 'Please select a clearance type');
        isValid = false;
    }
    
    return isValid;
}

// Show field error
function showFieldError(elementId, message) {
    const errorElement = document.getElementById(elementId);
    if (errorElement) {
        errorElement.textContent = message;
    }
}

// Clear all errors
function clearErrors() {
    const errorElements = document.querySelectorAll('.error-message');
    errorElements.forEach(element => {
        element.textContent = '';
    });
}

// Display result
function displayResult(data) {
    const resident = data.resident;
    
    resultContent.innerHTML = `
        <h3>✅ Application Submitted Successfully!</h3>
        <p><strong>Application ID:</strong> ${resident.id}</p>
        <p><strong>Name:</strong> ${resident.name}</p>
        <p><strong>Age:</strong> ${resident.age} years old</p>
        <p><strong>Type:</strong> ${resident.clearanceType}</p>
        <p><strong>Total Fee:</strong> ₱${resident.fee}</p>
        <p><strong>Status:</strong> <span class="status-badge status-${resident.status}">${resident.status}</span></p>
        <p><strong>Date Applied:</strong> ${resident.dateApplied}</p>
        <p style="margin-top: 1rem; color: #2e7d32;">
            Please proceed to the Barangay Office for payment and processing.
        </p>
    `;
    
    resultSection.style.display = 'block';
    resultSection.scrollIntoView({ behavior: 'smooth' });
}

// Load residents from Flask API
async function loadResidents() {
    try {
        showLoading();
        
        const response = await fetch(`${API_URL}/residents`);
        
        if (!response.ok) {
            throw new Error('Failed to load residents');
        }
        
        const residents = await response.json();
        displayResidents(residents);
        
    } catch (error) {
        console.error('Error loading residents:', error);
        residentsList.innerHTML = `<p style="color: #e74c3c;">Error loading applications: ${error.message}</p>`;
    } finally {
        hideLoading();
    }
}

// Display residents
function displayResidents(residents) {
    if (residents.length === 0) {
        residentsList.innerHTML = '<p style="color: #999;">No applications yet</p>';
        return;
    }
    
    // Sort by date (newest first)
    const sorted = residents.sort((a, b) => 
        new Date(b.dateApplied) - new Date(a.dateApplied)
    );
    
    const html = sorted.slice(0, 10).map(resident => `
        <div class="resident-card">
            <h3>${resident.name}</h3>
            <p><strong>Age:</strong> ${resident.age} | <strong>Type:</strong> ${resident.clearanceType}</p>
            <p><strong>Fee:</strong> ₱${resident.fee} | 
               <strong>Status:</strong> <span class="status-badge status-${resident.status}">${resident.status}</span>
            </p>
            <p><strong>Applied:</strong> ${resident.dateApplied}</p>
        </div>
    `).join('');
    
    residentsList.innerHTML = html;
}

// Show loading overlay
function showLoading() {
    loadingOverlay.classList.add('show');
    submitBtn.disabled = true;
}

// Hide loading overlay
function hideLoading() {
    loadingOverlay.classList.remove('show');
    submitBtn.disabled = false;
}

// Show error notification
function showError(message) {
    const errorDiv = document.createElement('div');
    errorDiv.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: #e74c3c;
        color: white;
        padding: 1rem 2rem;
        border-radius: 5px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        z-index: 2000;
        animation: slideIn 0.3s;
    `;
    errorDiv.textContent = `❌ ${message}`;
    document.body.appendChild(errorDiv);
    
    setTimeout(() => {
        errorDiv.remove();
    }, 5000);
}
```

---

## Activity 7: Running the Application

### Step-by-Step:

1. **Create all files** in the project structure
2. **Activate virtual environment:**
   ```bash
   venv\Scripts\activate
   ```
3. **Run Flask server:**
   ```bash
   python app.py
   ```
4. **Open browser:**
   - Navigate to `http://localhost:5000`
5. **Test the application:**
   - Fill out form
   - Submit application
   - View results
   - Check residents list

---

## 📚 Key Takeaways

1. **Flask setup** - Creating routes and handling requests
2. **CORS** - Enabling frontend-backend communication
3. **JSON data** - Reading and writing to files
4. **API endpoints** - GET and POST methods
5. **Fetch API** - Sending data from JavaScript to Flask
6. **Error handling** - Both frontend and backend
7. **Form validation** - Client-side and server-side

---

## 🚀 Next Steps

In the next lesson, you'll learn:
- More complex API endpoints
- Database integration
- CRUD operations
- Authentication
- File uploads

Great job setting up your first Flask backend! 🎉
