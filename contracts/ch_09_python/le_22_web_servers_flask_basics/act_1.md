# Web Servers and Flask Basics Activity

Practice creating a simple web server with Flask.

### Task 1: Home Route
```python
from flask import Flask

app = Flask(__name__)

# Your code: create @app.route('/') returning welcome message


if __name__ == '__main__':
    app.run(debug=True)
```

### Task 2: Dynamic Route
```python
# Your code: /greet/<name> returns personalized greeting

```

### Task 3: Query Parameters
```python
from flask import request

# Your code: /add?a=5&b=3 returns sum as text

```

### Task 4: JSON Endpoint
```python
from flask import jsonify

# Your code: /api/info returns dict as JSON

```

## Reflection
**Two advantages of web interface:**
1. _[Accessible from any device with browser]_
2. _[No installation needed for users]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
from flask import Flask, request, jsonify

app = Flask(__name__)

# Task 1
@app.route('/')
def home():
    return "Welcome to Barangay Scholarship Portal!"

# Task 2
@app.route('/greet/<name>')
def greet(name):
    return f"Hello, {name}! Welcome to our system."

# Task 3
@app.route('/add')
def add():
    a = int(request.args.get('a', 0))
    b = int(request.args.get('b', 0))
    return f"Sum: {a + b}"

# Task 4
@app.route('/api/info')
def api_info():
    return jsonify({
        "system": "Barangay Scholarship",
        "version": "1.0",
        "status": "running"
    })

if __name__ == '__main__':
    app.run(debug=True)
```

**Test URLs:**
- `http://localhost:5000/`
- `http://localhost:5000/greet/Ana`
- `http://localhost:5000/add?a=5&b=3`
- `http://localhost:5000/api/info`

**Reflection:** Web interfaces: (1) Cross-platform accessibility, (2) No installation barrier, (3) Easy updates (server-side), (4) Better for collaboration

</details>
