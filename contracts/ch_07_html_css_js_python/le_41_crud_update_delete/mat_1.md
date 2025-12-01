## Background Story

Ms. Reyes from the barangay hall was testing the application system Tian and Rhea Joy had built. She submitted a test clearance application: "Maria Santos, 28, Barangay Clearance, Employment Purpose." The application saved successfully and appeared in the list with status "pending."

But then she noticed a problem. "Wait, I typed the wrong age. Maria is 29, not 28. How do I fix this?"

Tian stared at the screen, suddenly realizing they hadn't built an edit feature. "Uh... you'd have to submit a new application with the correct information?"

Ms. Reyes frowned. "So now there are two applications for Maria Santos—one with the wrong age and one with the right age? That's confusing. Can't we just edit the existing one?"

Tian and Rhea Joy looked at each other, embarrassed. They'd built CREATE to add new applications and READ to view them, pero they hadn't considered that users would need to modify existing data.

Ms. Reyes continued: "And look at this test application I submitted yesterday with the name 'Test Test'. How do I remove it? It's cluttering the real applications list."

Another missing feature: DELETE.

"I'll fix these issues," Tian said quickly, though he wasn't entirely sure how.

After Ms. Reyes left, Rhea Joy pulled up a list of real-world scenarios they hadn't accounted for:

"What if:
- Someone makes a typo in their application
- The barangay staff needs to change an application status from 'pending' to 'approved'
- A resident moves and needs to update their address
- An application is submitted by mistake and needs to be removed
- Duplicate entries need to be cleaned up
- Test data needs to be deleted before going live"

Tian realized their application was only half-functional. "We can add data and view data, pero we can't modify or remove data. Real applications need full data management capability."

They called Kuya Miguel to explain the problem. "Kuya, users can submit applications, but if they make a mistake, there's no way to fix it. And there's no way to delete test data. We only have CREATE and READ, pero we need UPDATE and DELETE."

Miguel had anticipated this moment. "You've discovered why CRUD is a complete set—all four operations are necessary for full data management. CREATE and READ let you add and view data, pero UPDATE and DELETE let you modify and remove data. Without all four, your application is incomplete."

He shared his screen showing a professional barangay portal with full CRUD functionality. Next to each application was an "Edit" button and a "Delete" button. Miguel clicked "Edit" on an application, changed the status from "pending" to "approved," clicked "Save," and the change appeared instantly—no page refresh, just a smooth update.

Then he clicked "Delete" on a test entry. A confirmation dialog appeared: "Are you sure you want to delete this application? This action cannot be undone." Miguel clicked "Yes," and the application disappeared from the list.

"That's full CRUD," Miguel said. "Users can create, read, update, and delete. Full control over their data."

Tian understood the technical challenge immediately. "For UPDATE, we need:
1. An Edit button that loads the existing data into a form
2. The user modifies whatever fields need changing
3. JavaScript sends a PUT request to Flask with the updated data
4. Flask runs an SQL UPDATE query to modify the database record
5. Flask sends back the updated record
6. JavaScript refreshes the display"

Rhea Joy added the DELETE flow: "For DELETE:
1. A Delete button next to each entry
2. User clicks Delete
3. JavaScript shows a confirmation dialog
4. If confirmed, JavaScript sends a DELETE request to Flask
5. Flask runs an SQL DELETE query
6. Flask sends back success message
7. JavaScript removes the element from the page"

"Perfect understanding," Miguel confirmed. "But there's an important difference between UPDATE and DELETE: UPDATE modifies, DELETE is permanent. That's why DELETE always needs confirmation. You don't want users accidentally erasing data."

He showed them the Flask endpoints:

**UPDATE endpoint:**
```python
@app.route('/api/applications/<int:app_id>', methods=['PUT'])
def update_application(app_id):
    data = request.get_json()
    
    conn = sqlite3.connect('barangay.db')
    cursor = conn.cursor()
    
    cursor.execute('''
        UPDATE applications
        SET name=?, service=?, purpose=?, status=?
        WHERE id=?
    ''', (data['name'], data['service'], data['purpose'], 
          data['status'], app_id))
    
    conn.commit()
    conn.close()
    
    return jsonify({'message': 'Updated successfully'})
```

**DELETE endpoint:**
```python
@app.route('/api/applications/<int:app_id>', methods=['DELETE'])
def delete_application(app_id):
    conn = sqlite3.connect('barangay.db')
    cursor = conn.cursor()
    
    cursor.execute('DELETE FROM applications WHERE id=?', (app_id,))
    
    conn.commit()
    conn.close()
    
    return jsonify({'message': 'Deleted successfully'})
```

"Notice the endpoints use `<int:app_id>` in the URL," Miguel explained. "That's how you identify WHICH application to update or delete. The URL becomes `/api/applications/5` to modify application #5."

Tian was already planning the frontend implementation: "So we need Edit and Delete buttons for each application. Each button needs to know the application's ID. When clicked, we send PUT or DELETE requests to `/api/applications/{id}`."

Rhea Joy was thinking about user experience. "For Edit, should we open a modal with the form? Or make the fields editable inline? And for Delete, we definitely need a confirmation dialog—we can use `confirm()` in JavaScript."

Miguel showed them a clean pattern:

```javascript
// UPDATE: Edit application
async function updateApplication(appId, updatedData) {
    const response = await fetch(`/api/applications/${appId}`, {
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(updatedData)
    });
    
    if (response.ok) {
        alert('Application updated!');
        loadApplications();  // Refresh list
    }
}

// DELETE: Remove application
async function deleteApplication(appId) {
    // ALWAYS confirm before deleting
    const confirmed = confirm('Are you sure you want to delete this application?');
    
    if (!confirmed) return;  // User cancelled
    
    const response = await fetch(`/api/applications/${appId}`, {
        method: 'DELETE'
    });
    
    if (response.ok) {
        alert('Application deleted!');
        loadApplications();  // Refresh list
    }
}
```

"The DELETE confirmation is critical," Miguel emphasized. "Professional applications always confirm destructive actions. Some even require typing 'DELETE' or the item name to confirm. You don't want users accidentally deleting important data."

Tian thought about security implications. "But wait—if anyone can send DELETE requests, can't someone delete all applications? Don't we need permission checks?"

"Excellent security awareness!" Miguel said. "Yes, in production you'd add authentication: check if the user is logged in, check if they have permission to edit/delete this specific record. We'll cover authentication in upcoming lessons. For now, focus on the mechanics of UPDATE and DELETE."

Rhea Joy was excited to add this functionality. "Once we have full CRUD, our application is feature-complete. Users can:
- CREATE applications (submit new)
- READ applications (view list)
- UPDATE applications (fix mistakes, change status)
- DELETE applications (remove test data or mistakes)

That's everything you need for data management!"

Miguel gave them a practical challenge: "Add Edit and Delete buttons to your barangay application system. Implement the Flask UPDATE and DELETE endpoints. Test thoroughly: update an application's status, edit someone's name, delete a test entry. Make sure the database changes persist—refresh the page and verify changes are still there."

Tian opened his code, ready to complete the CRUD cycle. "We'll add edit modals for UPDATE and confirmation dialogs for DELETE. Professional, safe, complete data management."

Rhea Joy had one more question: "What about batch operations? Like, deleting multiple applications at once?"

Miguel smiled. "That's an advanced pattern—you'd send an array of IDs to delete. But master single-record CRUD first. Once you're comfortable with these operations, batch operations are just loops."

Over the next few hours, Tian and Rhea Joy implemented full CRUD. When they tested the complete system—creating an application, editing it to fix a typo, updating its status to approved, and deleting a test entry—everything worked seamlessly.

Ms. Reyes tested it the next day and was thrilled. "Now I can fix mistakes without creating duplicates, and I can clean up test data. This is actually usable now!"

Tian felt a surge of pride. "We didn't just build a demo—we built a complete, functional data management system with all four CRUD operations. This is production-ready."

Miguel's voice came through the video call: "Congratulations. You've mastered CRUD—the foundation of virtually every web application ever built. CREATE, READ, UPDATE, DELETE. Four operations that power billions of websites. Now you can build anything."

---

## Theory & Lecture Content

## CRUD: UPDATE and DELETE

We've covered **CREATE** and **READ**. Now: **UPDATE** and **DELETE**.

**UPDATE**: Modify existing records
**DELETE**: Remove records permanently

---

## UPDATE Operation (Modify Records)

### Flask Backend - UPDATE Endpoint

**app.py:**
```python
from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

# In-memory storage
applications = []
next_id = 1

@app.route('/api/applications/<int:app_id>', methods=['PUT'])
def update_application(app_id):
    # Find application by ID
    application = next((app for app in applications if app['id'] == app_id), None)
    
    if not application:
        return jsonify({'error': 'Application not found'}), 404
    
    # Get updated data
    data = request.get_json()
    
    # Validate input
    if not data.get('name'):
        return jsonify({'error': 'Name is required'}), 400
    
    # Update fields
    application['name'] = data['name']
    application['age'] = data.get('age', application['age'])
    application['service'] = data.get('service', application['service'])
    application['status'] = data.get('status', application['status'])
    application['updated_at'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    return jsonify({
        'message': 'Application updated successfully',
        'application': application
    })
```

**Key Points:**
- `methods=['PUT']` - HTTP PUT for updates
- URL parameter `<int:app_id>` - Identify which record to update
- Check if record exists before updating
- Return updated record

---

### JavaScript Frontend - UPDATE Function

**script.js:**
```javascript
async function updateApplication(id, updatedData) {
    try {
        const response = await fetch(`/api/applications/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedData)
        });
        
        if (!response.ok) {
            throw new Error('Failed to update application');
        }
        
        const result = await response.json();
        return result;
        
    } catch (error) {
        console.error('Error:', error);
        throw error;
    }
}

// Usage
const updated = await updateApplication(1, {
    name: 'Juan P. Dela Cruz',
    age: 31,
    service: 'Business Permit',
    status: 'approved'
});

console.log(updated.message); // "Application updated successfully"
```

---

## Complete Edit Form Example

**HTML (with edit modal):**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Applications</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Barangay Applications</h1>
        
        <div id="applicationsList"></div>
        
        <!-- Edit Modal -->
        <div id="editModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h2>Edit Application</h2>
                
                <form id="editForm">
                    <input type="hidden" id="editId">
                    
                    <div class="form-group">
                        <label for="editName">Full Name:</label>
                        <input type="text" id="editName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="editAge">Age:</label>
                        <input type="number" id="editAge" min="1" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="editService">Service:</label>
                        <select id="editService" required>
                            <option value="Barangay Clearance">Barangay Clearance</option>
                            <option value="Certificate of Residency">Certificate of Residency</option>
                            <option value="Certificate of Indigency">Certificate of Indigency</option>
                            <option value="Business Permit">Business Permit</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="editStatus">Status:</label>
                        <select id="editStatus" required>
                            <option value="pending">Pending</option>
                            <option value="approved">Approved</option>
                            <option value="rejected">Rejected</option>
                        </select>
                    </div>
                    
                    <button type="submit">Save Changes</button>
                </form>
            </div>
        </div>
    </div>
    
    <script src="script.js"></script>
</body>
</html>
```

**JavaScript - Edit Functionality:**
```javascript
const editModal = document.querySelector('#editModal');
const editForm = document.querySelector('#editForm');
const closeBtn = document.querySelector('.close');

// Display applications with Edit buttons
function displayApplications(applications) {
    const container = document.querySelector('#applicationsList');
    
    container.innerHTML = applications.map(app => `
        <div class="application-card">
            <h3>${app.name}</h3>
            <p><strong>Age:</strong> ${app.age}</p>
            <p><strong>Service:</strong> ${app.service}</p>
            <p><strong>Status:</strong> <span class="badge ${app.status}">${app.status}</span></p>
            <div class="actions">
                <button onclick="openEditModal(${app.id})" class="btn-edit">Edit</button>
                <button onclick="deleteApplication(${app.id})" class="btn-delete">Delete</button>
            </div>
        </div>
    `).join('');
}

// Open edit modal and populate with current data
async function openEditModal(id) {
    try {
        const response = await fetch(`/api/applications/${id}`);
        const app = await response.json();
        
        // Populate form
        document.querySelector('#editId').value = app.id;
        document.querySelector('#editName').value = app.name;
        document.querySelector('#editAge').value = app.age;
        document.querySelector('#editService').value = app.service;
        document.querySelector('#editStatus').value = app.status;
        
        // Show modal
        editModal.style.display = 'block';
        
    } catch (error) {
        console.error('Error loading application:', error);
    }
}

// Close modal
closeBtn.onclick = function() {
    editModal.style.display = 'none';
}

// Handle form submission
editForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const id = parseInt(document.querySelector('#editId').value);
    const updatedData = {
        name: document.querySelector('#editName').value,
        age: parseInt(document.querySelector('#editAge').value),
        service: document.querySelector('#editService').value,
        status: document.querySelector('#editStatus').value
    };
    
    try {
        const response = await fetch(`/api/applications/${id}`, {
            method: 'PUT',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(updatedData)
        });
        
        const result = await response.json();
        
        if (response.ok) {
            alert(result.message);
            editModal.style.display = 'none';
            loadApplications(); // Reload list
        } else {
            alert('Error: ' + result.error);
        }
        
    } catch (error) {
        alert('Network error: ' + error.message);
    }
});
```

---

## DELETE Operation (Remove Records)

### Flask Backend - DELETE Endpoint

**app.py:**
```python
@app.route('/api/applications/<int:app_id>', methods=['DELETE'])
def delete_application(app_id):
    global applications
    
    # Find application
    application = next((app for app in applications if app['id'] == app_id), None)
    
    if not application:
        return jsonify({'error': 'Application not found'}), 404
    
    # Remove from list
    applications = [app for app in applications if app['id'] != app_id]
    
    return jsonify({
        'message': 'Application deleted successfully',
        'deleted_id': app_id
    })
```

**Key Points:**
- `methods=['DELETE']` - HTTP DELETE for removal
- Always check if record exists
- Return confirmation message
- DELETE is permanent

---

### JavaScript Frontend - DELETE Function

**script.js:**
```javascript
async function deleteApplication(id) {
    // Confirmation dialog
    const confirmed = confirm('Are you sure you want to delete this application? This cannot be undone.');
    
    if (!confirmed) {
        return; // User cancelled
    }
    
    try {
        const response = await fetch(`/api/applications/${id}`, {
            method: 'DELETE'
        });
        
        if (!response.ok) {
            throw new Error('Failed to delete application');
        }
        
        const result = await response.json();
        alert(result.message);
        
        // Reload applications
        loadApplications();
        
    } catch (error) {
        console.error('Error:', error);
        alert('Failed to delete application');
    }
}
```

**IMPORTANT**: Always confirm before deleting!

---

## Complete CRUD Implementation

**Flask Backend - All CRUD Routes:**
```python
from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

applications = []
next_id = 1

# CREATE
@app.route('/api/applications', methods=['POST'])
def create_application():
    global next_id
    data = request.get_json()
    
    if not data.get('name') or not data.get('service'):
        return jsonify({'error': 'Name and service are required'}), 400
    
    application = {
        'id': next_id,
        'name': data['name'],
        'age': data.get('age', 0),
        'service': data['service'],
        'status': 'pending',
        'created_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    }
    
    applications.append(application)
    next_id += 1
    
    return jsonify({'message': 'Created successfully', 'application': application}), 201

# READ ALL
@app.route('/api/applications', methods=['GET'])
def get_all_applications():
    return jsonify(applications)

# READ ONE
@app.route('/api/applications/<int:app_id>', methods=['GET'])
def get_application(app_id):
    application = next((app for app in applications if app['id'] == app_id), None)
    
    if application:
        return jsonify(application)
    return jsonify({'error': 'Not found'}), 404

# UPDATE
@app.route('/api/applications/<int:app_id>', methods=['PUT'])
def update_application(app_id):
    application = next((app for app in applications if app['id'] == app_id), None)
    
    if not application:
        return jsonify({'error': 'Not found'}), 404
    
    data = request.get_json()
    
    application['name'] = data.get('name', application['name'])
    application['age'] = data.get('age', application['age'])
    application['service'] = data.get('service', application['service'])
    application['status'] = data.get('status', application['status'])
    application['updated_at'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    return jsonify({'message': 'Updated successfully', 'application': application})

# DELETE
@app.route('/api/applications/<int:app_id>', methods=['DELETE'])
def delete_application(app_id):
    global applications
    
    application = next((app for app in applications if app['id'] == app_id), None)
    
    if not application:
        return jsonify({'error': 'Not found'}), 404
    
    applications = [app for app in applications if app['id'] != app_id]
    
    return jsonify({'message': 'Deleted successfully', 'deleted_id': app_id})

if __name__ == '__main__':
    app.run(debug=True)
```

---

## Status Update Feature

**Quick status change without full edit:**

**Flask:**
```python
@app.route('/api/applications/<int:app_id>/status', methods=['PATCH'])
def update_status(app_id):
    application = next((app for app in applications if app['id'] == app_id), None)
    
    if not application:
        return jsonify({'error': 'Not found'}), 404
    
    data = request.get_json()
    new_status = data.get('status')
    
    if new_status not in ['pending', 'approved', 'rejected']:
        return jsonify({'error': 'Invalid status'}), 400
    
    application['status'] = new_status
    application['updated_at'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    return jsonify({'message': 'Status updated', 'application': application})
```

**JavaScript:**
```javascript
async function updateStatus(id, newStatus) {
    const response = await fetch(`/api/applications/${id}/status`, {
        method: 'PATCH',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({ status: newStatus })
    });
    
    const result = await response.json();
    
    if (response.ok) {
        loadApplications();
    } else {
        alert(result.error);
    }
}

// Usage in HTML
<select onchange="updateStatus(${app.id}, this.value)">
    <option value="pending">Pending</option>
    <option value="approved">Approved</option>
    <option value="rejected">Rejected</option>
</select>
```

---

## CSS for Modals and Buttons

**style.css:**
```css
/* Action Buttons */
.actions {
    margin-top: 15px;
}

.btn-edit {
    background: #4CAF50;
    color: white;
    padding: 8px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-right: 10px;
}

.btn-edit:hover {
    background: #45a049;
}

.btn-delete {
    background: #f44336;
    color: white;
    padding: 8px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.btn-delete:hover {
    background: #da190b;
}

/* Modal Styles */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
}

.modal-content {
    background-color: white;
    margin: 10% auto;
    padding: 30px;
    border-radius: 10px;
    width: 90%;
    max-width: 500px;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover {
    color: black;
}
```

---

## Best Practices

1. **Always confirm DELETE operations**
2. **Validate data on UPDATE**
3. **Check if record exists before UPDATE/DELETE**
4. **Use proper HTTP methods** (PUT for UPDATE, DELETE for DELETE)
5. **Return meaningful error messages**
6. **Reload data after UPDATE/DELETE**
7. **Use modals for edit forms**
8. **Consider using PATCH for partial updates**

---

## Summary

**UPDATE Pattern:**
```javascript
const response = await fetch(`/api/resource/${id}`, {
    method: 'PUT',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(updatedData)
});
```

**DELETE Pattern:**
```javascript
if (confirm('Are you sure?')) {
    const response = await fetch(`/api/resource/${id}`, {
        method: 'DELETE'
    });
}
```

---

---

## Closing Story

Tian added Edit and Delete buttons to each application card. Clicked "Edit" on one. A modal appeared with the current data. Changed the status to "Approved." Clicked "Save." The modal closed, and the card updated instantly.

Then clicked "Delete" on a test entry. A confirmation dialog appeared: "Are you sure?" Confirmed. The card vanished.

"That's the complete CRUD cycle," Kuya Miguel said. "Create, Read, Update, Delete. You can now build any data-driven application."

Rhea Joy tested the features. Edited names, changed statuses, deleted duplicates. Everything worked smoothly. "This feels like a real admin panel!"

Tian felt the power. Full control over data. Full control over the application. The barangay portal was coming alive.

_Next up: Complete project integration - Barangay Complaint System!_