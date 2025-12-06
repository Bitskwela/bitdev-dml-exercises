# Quiz: JavaScript Fetch to Flask API (Lesson 38)

Test your understanding of connecting JavaScript frontend to Flask backend!

---

## Question 1
What is the `fetch()` function used for?

A) To style HTML elements
B) To send HTTP requests from JavaScript to a server
C) To create Flask routes
D) To manipulate the DOM

**Answer: B**
`fetch()` is JavaScript's built-in function for making HTTP requests to servers (like Flask backends).

---

## Question 2
What is the correct syntax for a simple GET request using fetch?

A) `fetch('GET /api/data')`
B) `fetch('/api/data')`
C) `get('/api/data')`
D) `request('/api/data')`

**Answer: B**
By default, `fetch()` uses GET method, so you only need to provide the URL: `fetch('/api/data')`

---

## Question 3
How do you make a POST request with fetch?

A)
```javascript
fetch('/api/data', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
});
```

B)
```javascript
fetch('POST /api/data', data);
```

C)
```javascript
post('/api/data', data);
```

D)
```javascript
fetch('/api/data', data);
```

**Answer: A**
POST requests require method, headers, and body. Body must be stringified JSON.

---

## Question 4
What does `await response.json()` do?

A) Sends JSON to the server
B) Parses the response body as JSON
C) Creates a JSON file
D) Validates JSON data

**Answer: B**
`.json()` parses the response body as JSON and returns a JavaScript object.

---

## Question 5
How does Flask receive JSON data from JavaScript?

A) `request.data()`
B) `request.get_json()`
C) `request.json`
D) `get_json(request)`

**Answer: B**
`request.get_json()` parses the JSON body from the request and returns a Python dictionary.

---

## Question 6
How does Flask send JSON data back to JavaScript?

A) `return data`
B) `send_json(data)`
C) `jsonify(data)`
D) `json.dumps(data)`

**Answer: C**
`jsonify(data)` converts Python objects to JSON and sets the correct Content-Type header.

---

## Question 7
What does CORS stand for?

A) Cross-Origin Request System
B) Cross-Origin Resource Sharing
C) Common Origin Request Standard
D) Content Origin Resource Sharing

**Answer: B**
CORS = Cross-Origin Resource Sharing, a security feature to control which origins can access your API.

---

## Question 8
How do you enable CORS in Flask?

A)
```python
from flask_cors import CORS
CORS(app)
```

B)
```python
app.enable_cors = True
```

C)
```python
@app.cors('/api')
```

D)
```python
cors.enable()
```

**Answer: A**
Install flask-cors and apply it to your app: `CORS(app)`

---

## Question 9
What HTTP status code means "Created successfully"?

A) 200
B) 201
C) 400
D) 500

**Answer: B**
201 Created indicates a resource was successfully created.

---

## Question 10
What is the correct Flask route for a POST endpoint?

A)
```python
@app.route('/api/data', methods=['POST'])
def create_data():
    pass
```

B)
```python
@app.post('/api/data')
def create_data():
    pass
```

C)
```python
@app.route('/api/data', method='POST')
def create_data():
    pass
```

D)
```python
@app.route_post('/api/data')
def create_data():
    pass
```

**Answer: A**
Use `methods=['POST']` to specify HTTP methods. Note: `methods` is plural and takes a list.

---

## Question 11
How do you handle errors in fetch requests?

A) Use if statements only
B) Use try/catch blocks
C) Errors are automatic
D) Use catch() method only

**Answer: B**
Use try/catch blocks with async/await or .catch() with promises to handle errors.

---

## Question 12
What does `async/await` do in JavaScript?

A) Makes code run faster
B) Makes asynchronous code look synchronous
C) Creates multiple threads
D) Delays code execution

**Answer: B**
`async/await` makes asynchronous code (like fetch) easier to read by making it look synchronous.

---

## Question 13
How do you check if a fetch request was successful?

A) Check if response exists
B) Check `response.ok` or `response.status`
C) Check `response.success`
D) Fetch always succeeds

**Answer: B**
Check `response.ok` (true if status 200-299) or check specific `response.status` codes.

---

## Question 14
What is the correct way to send form data to Flask?

A)
```javascript
const formData = new FormData(form);
fetch('/api/submit', {
    method: 'POST',
    body: formData
});
```

B)
```javascript
const data = {name: form.name.value};
fetch('/api/submit', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
});
```

C) Both A and B are correct
D) Neither is correct

**Answer: C**
Both FormData (for files) and JSON (for simple data) are valid approaches.

---

## Question 15
What happens if you forget `JSON.stringify()` in fetch body?

A) Nothing, it works fine
B) The data is sent as [object Object]
C) Flask can't parse the data properly
D) Both B and C

**Answer: D**
Without stringify, JavaScript sends "[object Object]" string, and Flask can't parse it as JSON.

---

## Practical Challenge

Build a simple barangay application form that:
1. Has name, age, and service fields
2. Submits data to Flask `/api/applications` (POST)
3. Flask validates the data
4. Flask returns success/error response
5. JavaScript displays the response

**Flask endpoint:**
```python
@app.route('/api/applications', methods=['POST'])
def create_application():
    data = request.get_json()
    
    if not data.get('name'):
        return jsonify({'error': 'Name required'}), 400
    
    application = {
        'id': 1,
        'name': data['name'],
        'age': data.get('age'),
        'service': data.get('service'),
        'status': 'pending'
    }
    
    return jsonify({'message': 'Application created', 'data': application}), 201
```

Can you write the JavaScript fetch code to submit this form?

---

## Summary

Key Concepts:
- **fetch()**: JavaScript function for HTTP requests
- **async/await**: Makes asynchronous code easier
- **GET**: Fetch data (default method)
- **POST**: Send data (requires method, headers, body)
- **request.get_json()**: Flask gets JSON data
- **jsonify()**: Flask sends JSON response
- **CORS**: Enable cross-origin requests
- **Status Codes**: 200 OK, 201 Created, 400 Bad Request, 404 Not Found
- **Error Handling**: Use try/catch blocks
- **JSON.stringify()**: Convert JS objects to JSON string

Next: Learn how to display fetched data dynamically!

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
