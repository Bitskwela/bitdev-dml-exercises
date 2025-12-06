# Activity 1: CRUD - Update and Delete Operations

In this activity, you'll complete the CRUD operations by implementing **Update** (editing existing data) and **Delete** (removing data). These operations allow full data management.

---

## Activity 1: Understanding UPDATE and DELETE

**Recap CRUD:**
- ✅ **Create** (POST) - Adding new data
- ✅ **Read** (GET) - Viewing data
- 🎯 **Update** (PUT/PATCH) - Editing existing data
- 🎯 **Delete** (DELETE) - Removing data

**HTTP Methods:**
- **PUT** - Replace entire resource (update all fields)
- **PATCH** - Update specific fields only
- **DELETE** - Remove resource

---

## Activity 2: UPDATE - Edit Resident Information

**Goal:** Allow users to edit existing resident data.

**Flask endpoint** (`app.py`):

```python
@app.route('/api/residents/<int:resident_id>', methods=['PUT'])
def update_resident(resident_id):
    """Update existing resident"""
    try:
        # Get data from request
        data = request.get_json()
        
        # Read residents
        residents = read_residents()
        
        # Find resident
        resident = next((r for r in residents if r['id'] == resident_id), None)
        
        if not resident:
            return jsonify({
                'success': False,
                'error': 'Resident not found'
            }), 404
        
        # Validate required fields
        if 'name' in data and not data['name'].strip():
            return jsonify({
                'success': False,
                'error': 'Name cannot be empty'
            }), 400
        
        if 'age' in data:
            age = int(data['age'])
            if age < 18 or age > 150:
                return jsonify({
                    'success': False,
                    'error': 'Age must be between 18 and 150'
                }), 400
        
        # Update fields
        resident['name'] = data.get('name', resident['name']).strip()
        resident['age'] = int(data.get('age', resident['age']))
        resident['address'] = data.get('address', resident['address']).strip()
        resident['clearanceType'] = data.get('clearanceType', resident['clearanceType'])
        resident['status'] = data.get('status', resident['status'])
        resident['dateUpdated'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        # Save to file
        write_residents(residents)
        
        return jsonify({
            'success': True,
            'message': 'Resident updated successfully',
            'resident': resident
        }), 200
        
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
```

---

## Activity 3: DELETE - Remove Resident

**Flask endpoint:**

```python
@app.route('/api/residents/<int:resident_id>', methods=['DELETE'])
def delete_resident(resident_id):
    """Delete resident"""
    try:
        # Read residents
        residents = read_residents()
        
        # Find resident
        resident = next((r for r in residents if r['id'] == resident_id), None)
        
        if not resident:
            return jsonify({
                'success': False,
                'error': 'Resident not found'
            }), 404
        
        # Remove resident
        residents = [r for r in residents if r['id'] != resident_id]
        
        # Save to file
        write_residents(residents)
        
        return jsonify({
            'success': True,
            'message': 'Resident deleted successfully',
            'deletedResident': resident
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500
```

---

## Activity 4: Complete CRUD HTML Interface

**Full HTML with all CRUD operations:**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete CRUD System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        h1 {
            color: white;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        
        h2 {
            color: #2c3e50;
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
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
        }
        
        .btn-primary:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        .btn-success {
            background: #27ae60;
            color: white;
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
        
        .btn-cancel {
            background: #95a5a6;
            color: white;
            padding: 8px 16px;
            font-size: 14px;
        }
        
        #residentList {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }
        
        .resident-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #3498db;
            position: relative;
            animation: fadeIn 0.5s;
        }
        
        .resident-card.editing {
            border-left-color: #f39c12;
            background: #fff9e6;
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
        
        .resident-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #dee2e6;
        }
        
        .success-message, .error-message {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            animation: slideIn 0.5s;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
        }
        
        @keyframes slideIn {
            from { transform: translateX(-100%); }
            to { transform: translateX(0); }
        }
        
        .loading {
            text-align: center;
            padding: 40px;
            color: #3498db;
        }
        
        .spinner {
            display: inline-block;
            width: 30px;
            height: 30px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.7);
            z-index: 1000;
        }
        
        .modal-content {
            background: white;
            max-width: 500px;
            margin: 100px auto;
            padding: 30px;
            border-radius: 10px;
            animation: slideDown 0.3s;
        }
        
        @keyframes slideDown {
            from { transform: translateY(-100px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏘️ Complete CRUD System</h1>
        
        <!-- Form Section -->
        <section class="section">
            <h2 id="formTitle">➕ Add New Resident</h2>
            
            <form id="residentForm">
                <input type="hidden" id="editingId">
                
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
                    
                    <div class="form-group">
                        <label for="status">Status:</label>
                        <select id="status">
                            <option value="pending">Pending</option>
                            <option value="active">Active</option>
                        </select>
                    </div>
                </div>
                
                <div style="display: flex; gap: 10px;">
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        Add Resident
                    </button>
                    <button type="button" class="btn btn-cancel" id="cancelBtn" style="display: none;" onclick="cancelEdit()">
                        Cancel
                    </button>
                </div>
            </form>
            
            <div id="formMessage"></div>
        </section>
        
        <!-- Residents List -->
        <section class="section">
            <h2>📋 Resident List</h2>
            <button class="btn btn-primary" onclick="loadResidents()">🔄 Refresh</button>
            <div id="residentList" style="margin-top: 20px;"></div>
        </section>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h2>⚠️ Confirm Delete</h2>
            <p>Are you sure you want to delete this resident?</p>
            <p id="deleteResidentInfo" style="margin: 15px 0; font-weight: bold;"></p>
            <div style="display: flex; gap: 10px; margin-top: 20px;">
                <button class="btn btn-delete" onclick="confirmDelete()">Yes, Delete</button>
                <button class="btn btn-cancel" onclick="closeDeleteModal()">Cancel</button>
            </div>
        </div>
    </div>

    <script>
        const API_URL = 'http://localhost:5000/api';
        let deleteResidentId = null;
        
        // Load residents on page load
        document.addEventListener('DOMContentLoaded', () => {
            loadResidents();
        });
        
        // Handle form submission (CREATE or UPDATE)
        document.getElementById('residentForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const editingId = document.getElementById('editingId').value;
            
            if (editingId) {
                await updateResident(editingId);
            } else {
                await createResident();
            }
        });
        
        // CREATE: Add new resident
        async function createResident() {
            const messageDiv = document.getElementById('formMessage');
            const submitBtn = document.getElementById('submitBtn');
            
            const residentData = {
                name: document.getElementById('name').value,
                age: parseInt(document.getElementById('age').value),
                address: document.getElementById('address').value,
                clearanceType: document.getElementById('clearanceType').value,
                status: document.getElementById('status').value
            };
            
            try {
                submitBtn.disabled = true;
                submitBtn.textContent = 'Adding...';
                
                const response = await fetch(`${API_URL}/residents`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(residentData)
                });
                
                const data = await response.json();
                
                if (!response.ok) {
                    throw new Error(data.error);
                }
                
                showMessage('success', `✅ ${data.message}`);
                document.getElementById('residentForm').reset();
                loadResidents();
                
            } catch (error) {
                showMessage('error', `❌ Error: ${error.message}`);
            } finally {
                submitBtn.disabled = false;
                submitBtn.textContent = 'Add Resident';
            }
        }
        
        // UPDATE: Edit existing resident
        async function updateResident(id) {
            const messageDiv = document.getElementById('formMessage');
            const submitBtn = document.getElementById('submitBtn');
            
            const residentData = {
                name: document.getElementById('name').value,
                age: parseInt(document.getElementById('age').value),
                address: document.getElementById('address').value,
                clearanceType: document.getElementById('clearanceType').value,
                status: document.getElementById('status').value
            };
            
            try {
                submitBtn.disabled = true;
                submitBtn.textContent = 'Updating...';
                
                const response = await fetch(`${API_URL}/residents/${id}`, {
                    method: 'PUT',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(residentData)
                });
                
                const data = await response.json();
                
                if (!response.ok) {
                    throw new Error(data.error);
                }
                
                showMessage('success', `✅ ${data.message}`);
                cancelEdit();
                loadResidents();
                
            } catch (error) {
                showMessage('error', `❌ Error: ${error.message}`);
            } finally {
                submitBtn.disabled = false;
                submitBtn.textContent = 'Update Resident';
            }
        }
        
        // Load resident data for editing
        async function editResident(id) {
            try {
                const response = await fetch(`${API_URL}/residents/${id}`);
                const data = await response.json();
                
                if (!response.ok) {
                    throw new Error(data.error);
                }
                
                const resident = data.resident;
                
                // Populate form
                document.getElementById('editingId').value = resident.id;
                document.getElementById('name').value = resident.name;
                document.getElementById('age').value = resident.age;
                document.getElementById('address').value = resident.address;
                document.getElementById('clearanceType').value = resident.clearanceType;
                document.getElementById('status').value = resident.status;
                
                // Update UI
                document.getElementById('formTitle').textContent = `✏️ Edit Resident #${resident.id}`;
                document.getElementById('submitBtn').textContent = 'Update Resident';
                document.getElementById('submitBtn').className = 'btn btn-success';
                document.getElementById('cancelBtn').style.display = 'inline-block';
                
                // Scroll to form
                window.scrollTo({ top: 0, behavior: 'smooth' });
                
                // Highlight editing card
                document.querySelectorAll('.resident-card').forEach(card => {
                    card.classList.remove('editing');
                });
                document.querySelector(`[data-id="${id}"]`).classList.add('editing');
                
            } catch (error) {
                showMessage('error', `❌ Error: ${error.message}`);
            }
        }
        
        // Cancel editing
        function cancelEdit() {
            document.getElementById('residentForm').reset();
            document.getElementById('editingId').value = '';
            document.getElementById('formTitle').textContent = '➕ Add New Resident';
            document.getElementById('submitBtn').textContent = 'Add Resident';
            document.getElementById('submitBtn').className = 'btn btn-primary';
            document.getElementById('cancelBtn').style.display = 'none';
            document.getElementById('formMessage').innerHTML = '';
            
            document.querySelectorAll('.resident-card').forEach(card => {
                card.classList.remove('editing');
            });
        }
        
        // Show delete confirmation modal
        function deleteResident(id, name) {
            deleteResidentId = id;
            document.getElementById('deleteResidentInfo').textContent = name;
            document.getElementById('deleteModal').style.display = 'block';
        }
        
        // Close delete modal
        function closeDeleteModal() {
            deleteResidentId = null;
            document.getElementById('deleteModal').style.display = 'none';
        }
        
        // DELETE: Confirm and delete resident
        async function confirmDelete() {
            if (!deleteResidentId) return;
            
            try {
                const response = await fetch(`${API_URL}/residents/${deleteResidentId}`, {
                    method: 'DELETE'
                });
                
                const data = await response.json();
                
                if (!response.ok) {
                    throw new Error(data.error);
                }
                
                showMessage('success', `✅ ${data.message}`);
                closeDeleteModal();
                loadResidents();
                
            } catch (error) {
                showMessage('error', `❌ Error: ${error.message}`);
                closeDeleteModal();
            }
        }
        
        // READ: Load all residents
        async function loadResidents() {
            const listContainer = document.getElementById('residentList');
            
            try {
                listContainer.innerHTML = '<div class="loading"><div class="spinner"></div><p>Loading...</p></div>';
                
                const response = await fetch(`${API_URL}/residents`);
                const data = await response.json();
                
                if (!response.ok) {
                    throw new Error(data.error);
                }
                
                if (data.residents.length === 0) {
                    listContainer.innerHTML = '<p style="text-align: center; color: #999; padding: 40px;">No residents found. Add one above!</p>';
                } else {
                    displayResidents(data.residents);
                }
                
            } catch (error) {
                listContainer.innerHTML = `<div class="error-message">Error: ${error.message}</div>`;
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
                    <div class="resident-actions">
                        <button class="btn btn-edit" onclick="editResident(${resident.id})">
                            ✏️ Edit
                        </button>
                        <button class="btn btn-delete" onclick="deleteResident(${resident.id}, '${resident.name}')">
                            🗑️ Delete
                        </button>
                    </div>
                </div>
            `).join('');
            
            listContainer.innerHTML = html;
        }
        
        // Show message
        function showMessage(type, message) {
            const messageDiv = document.getElementById('formMessage');
            messageDiv.innerHTML = `<div class="${type}-message">${message}</div>`;
            
            setTimeout(() => {
                messageDiv.innerHTML = '';
            }, 5000);
        }
    </script>
</body>
</html>
```

---

## 📚 Key Takeaways

1. **UPDATE (PUT)** - Edit existing data with validation
2. **DELETE** - Remove data with confirmation
3. Always confirm before deleting (use modals)
4. Provide clear feedback for all operations
5. Handle editing state properly (cancel button, form reset)
6. Reload data after changes to keep UI in sync
7. Use proper HTTP status codes and error messages

---

## 🚀 Challenge

Enhance the system:
1. Add undo delete (soft delete with restore)
2. Add bulk delete (select multiple)
3. Add inline editing (edit directly in card)
4. Add change history/audit log
5. Add confirmation for unsaved changes
6. Add keyboard shortcuts (Escape to cancel)
7. Add optimistic UI updates

Complete CRUD system done!