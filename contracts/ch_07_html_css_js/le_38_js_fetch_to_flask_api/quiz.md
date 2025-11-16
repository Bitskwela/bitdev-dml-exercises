# Combined Quiz: Lessons 38-42 - Full-Stack Development

---

## Lesson 38: JavaScript Fetch to Flask API

**1. How do you make a POST request to Flask from JavaScript?**
```javascript
fetch('/api/data', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
});
```

**2. How do you handle CORS errors between JavaScript and Flask?**
```python
from flask_cors import CORS
app = Flask(__name__)
CORS(app)
```

---

## Lesson 39: DOM Updates from Flask

**3. How do you dynamically display Flask data?**
```javascript
const response = await fetch('/api/data');
const data = await response.json();

container.innerHTML = data.map(item => `
    <div>${item.name}</div>
`).join('');
```

**4. Best practice for updating DOM after fetch?**
- Clear container first: `container.innerHTML = ''`
- Show loading state while fetching
- Handle empty results gracefully

---

## Lesson 40: CRUD - Create and Read

**5. Flask CREATE endpoint:**
```python
@app.route('/api/items', methods=['POST'])
def create():
    data = request.get_json()
    item = {'id': 1, 'name': data['name']}
    items.append(item)
    return jsonify(item), 201
```

**6. JavaScript CREATE request:**
```javascript
await fetch('/api/items', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({name: 'New Item'})
});
```

**7. Flask READ ALL endpoint:**
```python
@app.route('/api/items', methods=['GET'])
def read_all():
    return jsonify(items)
```

**8. Flask READ ONE endpoint:**
```python
@app.route('/api/items/<int:id>', methods=['GET'])
def read_one(id):
    item = next((i for i in items if i['id'] == id), None)
    if item:
        return jsonify(item)
    return jsonify({'error': 'Not found'}), 404
```

---

## Lesson 41: CRUD - Update and Delete

**9. Flask UPDATE endpoint:**
```python
@app.route('/api/items/<int:id>', methods=['PUT'])
def update(id):
    item = find_item(id)
    data = request.get_json()
    item['name'] = data.get('name', item['name'])
    return jsonify(item)
```

**10. JavaScript UPDATE request:**
```javascript
await fetch(`/api/items/${id}`, {
    method: 'PUT',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({name: 'Updated Name'})
});
```

**11. Flask DELETE endpoint:**
```python
@app.route('/api/items/<int:id>', methods=['DELETE'])
def delete(id):
    global items
    items = [i for i in items if i['id'] != id]
    return jsonify({'message': 'Deleted'})
```

**12. JavaScript DELETE request:**
```javascript
await fetch(`/api/items/${id}`, {
    method: 'DELETE'
});
```

---

## Lesson 42: Final Project - Barangay Complaint System

**13. Complete CRUD workflow:**
1. Create complaint form (JavaScript)
2. Submit to Flask POST endpoint
3. Store in list/database
4. Display all complaints (GET)
5. Update status (PUT)
6. Delete complaint (DELETE)

**14. Key features to implement:**
- Form validation
- Loading states
- Error handling
- Status indicators
- Confirmation dialogs

**15. Full-stack best practices:**
- Validate on both frontend and backend
- Use try/catch for error handling
- Return proper HTTP status codes (200, 201, 400, 404, 500)
- Keep code organized (separate files for routes/models)
- Use consistent naming conventions

---

## Answers Summary

**Lesson 38:**
1. Use fetch with POST method, headers, and JSON body
2. Install flask-cors and apply to app

**Lesson 39:**
3. Fetch data, parse JSON, map to HTML, update innerHTML
4. Clear first, show loading, handle empty results

**Lesson 40:**
5-8. CRUD CREATE (POST) and READ (GET) endpoints

**Lesson 41:**
9-12. CRUD UPDATE (PUT) and DELETE endpoints

**Lesson 42:**
13-15. Complete application integration with all CRUD operations

---

## Final Project Checklist

✅ Flask backend with all CRUD routes  
✅ JavaScript frontend with fetch requests  
✅ Form submission and validation  
✅ Dynamic display of data  
✅ Update and delete functionality  
✅ Error handling and loading states  
✅ Responsive design  
✅ User confirmation for destructive actions  

---

## Detailed Code Examples

### Complete Flask Backend Structure
```python
from flask import Flask, render_template, request, jsonify
from datetime import datetime

app = Flask(__name__)

# Data storage
items = []
next_id = 1

# Routes
@app.route('/')
def home():
    return render_template('index.html')

# CREATE
@app.route('/api/items', methods=['POST'])
def create():
    global next_id
    data = request.get_json()
    
    if not data.get('name'):
        return jsonify({'error': 'Name required'}), 400
    
    item = {
        'id': next_id,
        'name': data['name'],
        'created': datetime.now().isoformat()
    }
    
    items.append(item)
    next_id += 1
    
    return jsonify(item), 201

# READ ALL
@app.route('/api/items', methods=['GET'])
def read_all():
    return jsonify(items)

# READ ONE
@app.route('/api/items/<int:id>', methods=['GET'])
def read_one(id):
    item = next((i for i in items if i['id'] == id), None)
    if item:
        return jsonify(item)
    return jsonify({'error': 'Not found'}), 404

# UPDATE
@app.route('/api/items/<int:id>', methods=['PUT'])
def update(id):
    item = next((i for i in items if i['id'] == id), None)
    
    if not item:
        return jsonify({'error': 'Not found'}), 404
    
    data = request.get_json()
    item['name'] = data.get('name', item['name'])
    
    return jsonify(item)

# DELETE
@app.route('/api/items/<int:id>', methods=['DELETE'])
def delete(id):
    global items
    item = next((i for i in items if i['id'] == id), None)
    
    if not item:
        return jsonify({'error': 'Not found'}), 404
    
    items = [i for i in items if i['id'] != id]
    return jsonify({'message': 'Deleted'})

if __name__ == '__main__':
    app.run(debug=True)
```

### Complete JavaScript Frontend
```javascript
// CREATE
async function createItem(name) {
    try {
        const response = await fetch('/api/items', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({name})
        });
        
        if (!response.ok) {
            throw new Error('Failed to create');
        }
        
        const item = await response.json();
        return item;
    } catch (error) {
        console.error('Error:', error);
        throw error;
    }
}

// READ ALL
async function getAllItems() {
    const response = await fetch('/api/items');
    return await response.json();
}

// READ ONE
async function getItem(id) {
    const response = await fetch(`/api/items/${id}`);
    return await response.json();
}

// UPDATE
async function updateItem(id, name) {
    const response = await fetch(`/api/items/${id}`, {
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({name})
    });
    return await response.json();
}

// DELETE
async function deleteItem(id) {
    const response = await fetch(`/api/items/${id}`, {
        method: 'DELETE'
    });
    return await response.json();
}

// Display items
async function displayItems() {
    const items = await getAllItems();
    
    const container = document.querySelector('#itemsList');
    
    container.innerHTML = items.map(item => `
        <div class="item-card">
            <h3>${item.name}</h3>
            <p>ID: ${item.id}</p>
            <button onclick="editItem(${item.id})">Edit</button>
            <button onclick="removeItem(${item.id})">Delete</button>
        </div>
    `).join('');
}

// Form submission
document.querySelector('#itemForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const name = document.querySelector('#name').value;
    
    try {
        await createItem(name);
        alert('Item created!');
        e.target.reset();
        displayItems();
    } catch (error) {
        alert('Error: ' + error.message);
    }
});

// Edit item
async function editItem(id) {
    const newName = prompt('Enter new name:');
    if (newName) {
        await updateItem(id, newName);
        displayItems();
    }
}

// Remove item
async function removeItem(id) {
    if (confirm('Delete this item?')) {
        await deleteItem(id);
        displayItems();
    }
}

// Initial load
displayItems();
```

---

## Congratulations! 🎉

You've completed the **Full Web Development Curriculum**:
- ✅ HTML structure
- ✅ CSS styling
- ✅ JavaScript programming
- ✅ DOM manipulation
- ✅ Event handling
- ✅ Modern ES6+ features
- ✅ APIs and Fetch
- ✅ Flask backend
- ✅ Full CRUD operations
- ✅ Complete full-stack applications

**You're now ready to build production-ready web applications!**

---
