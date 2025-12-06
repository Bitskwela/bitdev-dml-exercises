# Quiz: JavaScript Forms + Flask Setup

---

## Quiz 1

**1. What is Flask?**

a) A JavaScript library  
b) A Python web framework  
c) A database  
d) A CSS framework

**Answer: b**

Flask is a lightweight Python web framework for building web applications and APIs.

---

**2. How do you create a Flask route?**

a) `@app.route('/path')`  
b) `app.get('/path')`  
c) `route('/path')`  
d) `flask.route('/path')`

**Answer: a**

Use the `@app.route('/path')` decorator to create a route in Flask.

---

**3. What does `request.get_json()` do in Flask?**

a) Sends JSON to client  
b) Gets JSON data from request body  
c) Validates JSON  
d) Creates JSON file

**Answer: b**

`request.get_json()` extracts and parses JSON data from the request body.

---

**4. How do you return JSON from Flask?**

a) `return json`  
b) `return jsonify(data)`  
c) `return JSON.stringify(data)`  
d) `return data.toJSON()`

**Answer: b**

Use `jsonify(data)` to convert Python data to JSON response with proper headers.

---

**5. What does `render_template()` do?**

a) Creates CSS  
b) Renders HTML template file  
c) Returns JSON  
d) Validates forms

**Answer: b**

`render_template()` renders an HTML template file from the templates folder.

---

## Quiz 2

**6. What HTTP method should you use to submit form data?**

a) GET  
b) POST  
c) PUT  
d) DELETE

**Answer: b**

Use POST method to submit form data securely (data not in URL).

---

**7. What does `debug=True` do in `app.run(debug=True)`?**

a) Breaks the app  
b) Shows detailed errors and auto-reloads on code changes  
c) Runs faster  
d) Required for production

**Answer: b**

`debug=True` shows detailed error messages and automatically reloads the server when code changes. Only use in development.

---

**8. Where should templates be stored in Flask?**

a) Root directory  
b) `templates/` folder  
c) `static/` folder  
d) Anywhere

**Answer: b**

Flask looks for HTML templates in the `templates/` folder by default.

---

**9. How do you handle errors in Flask routes?**

a) Try/catch  
b) Try/except  
c) If/else only  
d) Errors can't be handled

**Answer: b**

Use `try/except` blocks in Python (Flask) to handle errors gracefully.

---

**10. What's the difference between static files and templates?**

a) No difference  
b) Static (CSS/JS), Templates (HTML with dynamic content)  
c) Static is faster  
d) Templates are deprecated

**Answer: b**

Static files (CSS/JS/images) don't change; templates (HTML) contain dynamic content rendered by Flask.

---

## Detailed Explanations

### Question 1: What is Flask?

**Correct Answer: b) A Python web framework**

Flask is a lightweight Python framework for building web applications and APIs.

```python
# Flask basics
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return '<h1>Hello from Flask!</h1>'

if __name__ == '__main__':
    app.run(debug=True)
```

**Barangay example:**
```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/services')
def get_services():
    services = [
        {'name': 'Clearance', 'fee': 50},
        {'name': 'ID', 'fee': 30}
    ]
    return jsonify(services)

app.run(debug=True)
```

---

### Question 2: Creating Routes

**Correct Answer: a) `@app.route('/path')`**

```python
@app.route('/')
def home():
    return 'Homepage'

@app.route('/about')
def about():
    return 'About Page'

# Dynamic route
@app.route('/service/<int:id>')
def service_detail(id):
    return f'Service ID: {id}'

# Multiple methods
@app.route('/submit', methods=['GET', 'POST'])
def submit():
    if request.method == 'POST':
        return 'Form submitted'
    return 'Show form'
```

**Barangay example:**
```python
@app.route('/api/residents')
def residents():
    return jsonify(resident_list)

@app.route('/api/applications', methods=['POST'])
def create_application():
    data = request.get_json()
    # Process application
    return jsonify({'message': 'Created'})

@app.route('/api/applications/<int:app_id>')
def get_application(app_id):
    app = find_application(app_id)
    return jsonify(app)
```

---

### Question 3: request.get_json()

**Correct Answer: b) Gets JSON data from request body**

```python
from flask import request, jsonify

@app.route('/api/submit', methods=['POST'])
def submit():
    # Get JSON from request body
    data = request.get_json()
    
    name = data.get('name')
    age = data.get('age')
    
    return jsonify({'message': f'Hello {name}, age {age}'})
```

**JavaScript sending data:**
```javascript
const data = {name: 'Juan', age: 30};

await fetch('/api/submit', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
});
```

**Barangay example:**
```python
@app.route('/api/applications', methods=['POST'])
def create_application():
    # Get form data from JavaScript
    data = request.get_json()
    
    application = {
        'id': generate_id(),
        'resident': data.get('name'),
        'service': data.get('service'),
        'date': datetime.now().isoformat()
    }
    
    save_to_database(application)
    
    return jsonify({
        'message': 'Application submitted',
        'id': application['id']
    }), 201
```

---

### Question 4: Return JSON

**Correct Answer: b) `return jsonify(data)`**

```python
from flask import jsonify

@app.route('/api/data')
def get_data():
    data = {
        'name': 'Juan',
        'age': 30,
        'city': 'Manila'
    }
    
    # Convert to JSON response
    return jsonify(data)
```

**Why jsonify?**
- Sets `Content-Type: application/json` header
- Converts Python dict to JSON string
- Handles datetime and other types

**Barangay example:**
```python
@app.route('/api/services')
def services():
    services = [
        {'id': 1, 'name': 'Clearance', 'fee': 50},
        {'id': 2, 'name': 'ID', 'fee': 30}
    ]
    return jsonify(services)

@app.route('/api/applications/<int:id>')
def application_detail(id):
    app = {
        'id': id,
        'applicant': 'Maria Santos',
        'service': 'Clearance',
        'status': 'pending',
        'date': '2024-01-15'
    }
    return jsonify(app)
```

---

### Question 5: render_template()

**Correct Answer: b) Renders HTML template file**

```python
from flask import render_template

@app.route('/')
def home():
    return render_template('index.html')

# Pass data to template
@app.route('/services')
def services():
    services_list = [
        {'name': 'Clearance', 'fee': 50},
        {'name': 'ID', 'fee': 30}
    ]
    return render_template('services.html', services=services_list)
```

**templates/services.html (Jinja2):**
```html
<h1>Services</h1>
<ul>
{% for service in services %}
    <li>{{ service.name }} - ₱{{ service.fee }}</li>
{% endfor %}
</ul>
```

**Barangay example:**
```python
@app.route('/dashboard')
def dashboard():
    stats = {
        'total_residents': 1500,
        'pending_apps': 25,
        'revenue': 15000
    }
    return render_template('dashboard.html', stats=stats)
```

---

### Questions 6-10: Rapid Explanations

**Q6: POST for Forms** - POST sends data in body (not URL), secure for sensitive data:
```python
@app.route('/submit', methods=['POST'])
def submit():
    data = request.get_json()
    return jsonify({'success': True})
```

**Q7: Debug Mode** - Auto-reloads on code changes, shows detailed errors:
```python
if __name__ == '__main__':
    app.run(debug=True)  # Development only!
    # app.run()  # Production (debug=False)
```

**Q8: Templates Folder** - Flask looks in `templates/` by default:
```
project/
├── app.py
├── templates/
│   ├── index.html
│   └── services.html
└── static/
    ├── css/
    └── js/
```

**Q9: Error Handling** - Use try/except:
```python
@app.route('/api/data', methods=['POST'])
def handle_data():
    try:
        data = request.get_json()
        # Process data
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'error': str(e)}), 500
```

**Q10: Static vs Templates** - Static files don't change, templates have dynamic content:
```python
# Static: CSS, JS, images (no processing)
# Access: /static/css/style.css

# Templates: HTML with Jinja2 (dynamic rendering)
return render_template('index.html', data=data)
```

---
