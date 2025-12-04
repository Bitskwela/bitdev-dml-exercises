# Activity 1: DOM Updates from Flask Responses

In this activity, you'll learn how to dynamically update your webpage based on responses from Flask. You'll create a fully interactive system where Flask data controls what users see in real-time.

---

## Activity 1: Understanding DOM Updates

**Goal:** Learn how to update the DOM based on Flask responses.

**The Process:**
1. JavaScript sends request to Flask
2. Flask processes and sends back data
3. JavaScript receives response
4. JavaScript updates the DOM (add, remove, modify elements)
5. User sees changes instantly (no page reload!)

**DOM Manipulation Methods:**
```javascript
// Create element
const div = document.createElement('div');

// Set content
div.textContent = 'Hello';
div.innerHTML = '<strong>Bold text</strong>';

// Add to page
document.getElementById('container').appendChild(div);

// Remove element
element.remove();

// Update existing element
document.getElementById('status').textContent = 'Updated!';
```

---

## Activity 2: Real-Time Status Updates

**Goal:** Show real-time processing status from Flask.

**Flask endpoint** (`app.py`):

```python
from flask import Flask, jsonify
from flask_cors import CORS
import time
import random

app = Flask(__name__)
CORS(app)

@app.route('/api/process-clearance', methods=['POST'])
def process_clearance():
    """Simulate clearance processing"""
    # Simulate processing time
    time.sleep(2)
    
    # Random approval
    approved = random.random() > 0.3  # 70% approval rate
    
    if approved:
        return jsonify({
            'status': 'approved',
            'message': 'Your clearance has been approved!',
            'referenceNumber': f'CLR-{random.randint(10000, 99999)}',
            'approvedBy': 'Barangay Captain',
            'dateApproved': time.strftime('%Y-%m-%d %H:%M:%S')
        }), 200
    else:
        return jsonify({
            'status': 'pending',
            'message': 'Your application needs additional review',
            'reason': 'Missing documents',
            'nextSteps': 'Please submit valid ID'
        }), 200

if __name__ == '__main__':
    app.run(debug=True, port=5000)
```

**HTML + JavaScript:**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DOM Updates from Flask</title>
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
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        button {
            width: 100%;
            padding: 15px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 20px;
        }
        
        button:hover {
            background: #2980b9;
        }
        
        button:disabled {
            background: #95a5a6;
            cursor: not-allowed;
        }
        
        #statusContainer {
            margin-top: 30px;
            min-height: 100px;
        }
        
        .status-card {
            padding: 20px;
            border-radius: 8px;
            animation: slideIn 0.5s;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .status-loading {
            background: #fff3cd;
            color: #856404;
            text-align: center;
        }
        
        .status-approved {
            background: #d4edda;
            color: #155724;
            border-left: 5px solid #28a745;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
            border-left: 5px solid #ffc107;
        }
        
        .status-card h2 {
            margin-bottom: 15px;
        }
        
        .status-card p {
            margin: 8px 0;
            line-height: 1.6;
        }
        
        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(0,0,0,0.1);
            border-top-color: #856404;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 10px;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏛️ Barangay Clearance System</h1>
        <p>Click the button to process your clearance application</p>
        
        <button id="processBtn">Process Clearance</button>
        
        <div id="statusContainer"></div>
    </div>

    <script>
        const API_URL = 'http://localhost:5000/api';
        const processBtn = document.getElementById('processBtn');
        const statusContainer = document.getElementById('statusContainer');
        
        // Process clearance request
        async function processClearance() {
            try {
                // Disable button
                processBtn.disabled = true;
                processBtn.textContent = 'Processing...';
                
                // Show loading status
                updateStatus('loading', {
                    message: 'Processing your clearance application...'
                });
                
                // Send request to Flask
                const response = await fetch(`${API_URL}/process-clearance`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        applicant: 'Juan Dela Cruz',
                        type: 'Barangay Clearance'
                    })
                });
                
                const data = await response.json();
                
                // Update DOM based on response
                if (data.status === 'approved') {
                    updateStatus('approved', data);
                } else {
                    updateStatus('pending', data);
                }
                
            } catch (error) {
                console.error('Error:', error);
                updateStatus('error', {
                    message: 'Failed to process application',
                    error: error.message
                });
            } finally {
                // Re-enable button
                processBtn.disabled = false;
                processBtn.textContent = 'Process Clearance';
            }
        }
        
        // Update status display
        function updateStatus(status, data) {
            // Clear previous content
            statusContainer.innerHTML = '';
            
            // Create status card
            const card = document.createElement('div');
            card.className = `status-card status-${status}`;
            
            if (status === 'loading') {
                card.innerHTML = `
                    <div style="text-align: center;">
                        <div class="spinner"></div>
                        <span>${data.message}</span>
                    </div>
                `;
            } else if (status === 'approved') {
                card.innerHTML = `
                    <h2>✅ ${data.message}</h2>
                    <p><strong>Reference Number:</strong> ${data.referenceNumber}</p>
                    <p><strong>Approved By:</strong> ${data.approvedBy}</p>
                    <p><strong>Date Approved:</strong> ${data.dateApproved}</p>
                    <p style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #c3e6cb;">
                        Please proceed to the Barangay Office to claim your clearance.
                    </p>
                `;
            } else if (status === 'pending') {
                card.innerHTML = `
                    <h2>⏳ ${data.message}</h2>
                    <p><strong>Reason:</strong> ${data.reason}</p>
                    <p><strong>Next Steps:</strong> ${data.nextSteps}</p>
                    <p style="margin-top: 15px;">
                        Please address the issues above and resubmit your application.
                    </p>
                `;
            } else if (status === 'error') {
                card.className = 'status-card status-error';
                card.style.background = '#f8d7da';
                card.style.color = '#721c24';
                card.style.borderLeft = '5px solid #dc3545';
                card.innerHTML = `
                    <h2>❌ ${data.message}</h2>
                    <p>${data.error}</p>
                `;
            }
            
            // Add to container
            statusContainer.appendChild(card);
        }
        
        // Event listener
        processBtn.addEventListener('click', processClearance);
    </script>
</body>
</html>
```

---

## Activity 3: Dynamic List Updates

**Goal:** Add, update, and remove items from a list based on Flask responses.

**Flask endpoints:**

```python
residents = []

@app.route('/api/residents', methods=['GET'])
def get_residents():
    return jsonify(residents), 200

@app.route('/api/residents', methods=['POST'])
def add_resident():
    data = request.get_json()
    new_resident = {
        'id': len(residents) + 1,
        'name': data['name'],
        'age': data['age'],
        'status': 'active'
    }
    residents.append(new_resident)
    return jsonify(new_resident), 201

@app.route('/api/residents/<int:resident_id>', methods=['DELETE'])
def delete_resident(resident_id):
    global residents
    residents = [r for r in residents if r['id'] != resident_id]
    return jsonify({'message': 'Deleted successfully'}), 200
```

**HTML + JavaScript:**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dynamic List Updates</title>
    <style>
        .resident-list {
            margin-top: 20px;
        }
        
        .resident-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
            margin-bottom: 10px;
            animation: fadeIn 0.5s;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }
        
        .resident-item.removing {
            animation: fadeOut 0.5s;
        }
        
        @keyframes fadeOut {
            from { opacity: 1; transform: translateX(0); }
            to { opacity: 0; transform: translateX(20px); }
        }
        
        .delete-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .delete-btn:hover {
            background: #c82333;
        }
        
        form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        input {
            flex: 1;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
        }
        
        button[type="submit"] {
            padding: 10px 20px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>👥 Resident Management</h1>
        
        <form id="addForm">
            <input type="text" id="nameInput" placeholder="Name" required>
            <input type="number" id="ageInput" placeholder="Age" required min="18">
            <button type="submit">Add Resident</button>
        </form>
        
        <div id="residentList" class="resident-list"></div>
    </div>

    <script>
        const API_URL = 'http://localhost:5000/api';
        const form = document.getElementById('addForm');
        const residentList = document.getElementById('residentList');
        
        // Load residents on page load
        loadResidents();
        
        // Load and display residents
        async function loadResidents() {
            try {
                const response = await fetch(`${API_URL}/residents`);
                const residents = await response.json();
                displayResidents(residents);
            } catch (error) {
                console.error('Error loading residents:', error);
            }
        }
        
        // Display residents in DOM
        function displayResidents(residents) {
            if (residents.length === 0) {
                residentList.innerHTML = '<p style="color: #999;">No residents yet. Add one above!</p>';
                return;
            }
            
            residentList.innerHTML = '';
            
            residents.forEach(resident => {
                const item = createResidentElement(resident);
                residentList.appendChild(item);
            });
        }
        
        // Create resident DOM element
        function createResidentElement(resident) {
            const div = document.createElement('div');
            div.className = 'resident-item';
            div.setAttribute('data-id', resident.id);
            
            div.innerHTML = `
                <div>
                    <strong>${resident.name}</strong> (${resident.age} years old)
                </div>
                <button class="delete-btn" onclick="deleteResident(${resident.id})">
                    Delete
                </button>
            `;
            
            return div;
        }
        
        // Add resident
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const residentData = {
                name: document.getElementById('nameInput').value,
                age: parseInt(document.getElementById('ageInput').value)
            };
            
            try {
                const response = await fetch(`${API_URL}/residents`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(residentData)
                });
                
                const newResident = await response.json();
                
                // Add to DOM without reloading entire list
                const newElement = createResidentElement(newResident);
                residentList.appendChild(newElement);
                
                // Clear form
                form.reset();
                
            } catch (error) {
                alert('Error adding resident: ' + error.message);
            }
        });
        
        // Delete resident
        async function deleteResident(id) {
            if (!confirm('Delete this resident?')) return;
            
            try {
                // Find element
                const element = document.querySelector(`[data-id="${id}"]`);
                
                // Animate removal
                element.classList.add('removing');
                
                // Send delete request
                await fetch(`${API_URL}/residents/${id}`, {
                    method: 'DELETE'
                });
                
                // Remove from DOM after animation
                setTimeout(() => {
                    element.remove();
                    
                    // Check if list is empty
                    if (residentList.children.length === 0) {
                        residentList.innerHTML = '<p style="color: #999;">No residents yet.</p>';
                    }
                }, 500);
                
            } catch (error) {
                alert('Error deleting resident: ' + error.message);
            }
        }
    </script>
</body>
</html>
```

---

## Activity 4: Form Updates Based on Flask Data

**Goal:** Populate form fields with data from Flask.

```javascript
// Load resident data into form for editing
async function loadResidentForEdit(id) {
    try {
        const response = await fetch(`${API_URL}/residents/${id}`);
        const resident = await response.json();
        
        // Populate form fields
        document.getElementById('nameInput').value = resident.name;
        document.getElementById('ageInput').value = resident.age;
        document.getElementById('addressInput').value = resident.address;
        
        // Change button to "Update"
        const submitBtn = document.querySelector('button[type="submit"]');
        submitBtn.textContent = 'Update Resident';
        submitBtn.setAttribute('data-editing-id', id);
        
    } catch (error) {
        alert('Error loading resident: ' + error.message);
    }
}

// Handle form submission (add or update)
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const editingId = e.target.querySelector('button[type="submit"]').getAttribute('data-editing-id');
    
    if (editingId) {
        // Update existing
        await updateResident(editingId, formData);
    } else {
        // Add new
        await addResident(formData);
    }
});
```

---

## Activity 5: Real-Time Notifications

**Goal:** Show toast notifications for Flask responses.

```javascript
// Toast notification system
function showToast(message, type = 'success') {
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.textContent = message;
    
    toast.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 25px;
        border-radius: 5px;
        color: white;
        font-weight: bold;
        z-index: 1000;
        animation: slideInRight 0.5s, slideOutRight 0.5s 2.5s;
    `;
    
    if (type === 'success') {
        toast.style.background = '#28a745';
    } else if (type === 'error') {
        toast.style.background = '#dc3545';
    } else if (type === 'info') {
        toast.style.background = '#17a2b8';
    }
    
    document.body.appendChild(toast);
    
    setTimeout(() => {
        toast.remove();
    }, 3000);
}

// Use in API calls
async function addResident(data) {
    try {
        const response = await fetch(`${API_URL}/residents`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
        
        const result = await response.json();
        
        showToast('✅ Resident added successfully!', 'success');
        loadResidents();
        
    } catch (error) {
        showToast('❌ Error: ' + error.message, 'error');
    }
}
```

Add CSS animations:

```css
@keyframes slideInRight {
    from {
        transform: translateX(400px);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}

@keyframes slideOutRight {
    from {
        transform: translateX(0);
        opacity: 1;
    }
    to {
        transform: translateX(400px);
        opacity: 0;
    }
}
```

---

## Activity 6: Progress Indicators

**Goal:** Show progress during long-running Flask operations.

```javascript
// Progress bar component
function showProgressBar() {
    const progressContainer = document.createElement('div');
    progressContainer.id = 'progressContainer';
    progressContainer.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: #e0e0e0;
        z-index: 9999;
    `;
    
    const progressBar = document.createElement('div');
    progressBar.id = 'progressBar';
    progressBar.style.cssText = `
        height: 100%;
        width: 0%;
        background: #3498db;
        transition: width 0.3s;
    `;
    
    progressContainer.appendChild(progressBar);
    document.body.appendChild(progressContainer);
    
    return progressBar;
}

function updateProgress(percent) {
    const bar = document.getElementById('progressBar');
    if (bar) {
        bar.style.width = `${percent}%`;
    }
}

function hideProgressBar() {
    const container = document.getElementById('progressContainer');
    if (container) {
        container.remove();
    }
}

// Use in API calls
async function processLongOperation() {
    const progressBar = showProgressBar();
    
    try {
        updateProgress(20);
        const response = await fetch(`${API_URL}/process`);
        
        updateProgress(60);
        const data = await response.json();
        
        updateProgress(100);
        
        setTimeout(() => {
            hideProgressBar();
            displayResults(data);
        }, 300);
        
    } catch (error) {
        hideProgressBar();
        showToast('Error: ' + error.message, 'error');
    }
}
```

---

## 📚 Key Takeaways

1. **DOM updates** make pages interactive without reload
2. Use `createElement()` to build elements dynamically
3. Use `innerHTML` for simple content, DOM methods for complex structures
4. Add **animations** for smooth transitions
5. **Toast notifications** provide user feedback
6. **Progress indicators** show operation status
7. Always **handle errors** and show appropriate messages
8. Update DOM **incrementally** for better performance

---

## 🚀 Challenge

Build a complete Barangay Dashboard:
1. Real-time resident counter
2. Live status updates from Flask
3. Animated charts using Chart.js
4. Toast notifications for all actions
5. Progress bars for file uploads
6. Auto-refresh data every 30 seconds
7. Error recovery with retry button

Great work on DOM manipulation!