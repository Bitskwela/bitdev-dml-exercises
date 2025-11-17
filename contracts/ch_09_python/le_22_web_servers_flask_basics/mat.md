## Lesson 22: Web Servers and Flask Basics

Story: Citizens need web portal to check scholarship status. Tian learns Flask: "Lightweight framework turning Python functions into HTTP endpoints."

### 1. What Is a Web Server?
Program listening on port, responding to HTTP requests.

### 2. Flask Introduction
Micro web framework for Python.

### 3. Install Flask
```bash
pip install Flask
```

### 4. Minimal Flask App
```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Welcome to Scholarship Portal"

if __name__ == "__main__":
    app.run(debug=True)
```

### 5. Running
```bash
python app.py
# Visit http://127.0.0.1:5000/
```

### 6. Routes
```python
@app.route("/about")
def about():
    return "Barangay Scholarship System v1.0"
```

### 7. Dynamic Routes
```python
@app.route("/user/<name>")
def user(name):
    return f"Hello {name}"
```

### 8. Request Methods
```python
@app.route("/apply", methods=["GET","POST"])
def apply():
    if request.method == "POST":
        return "Application submitted"
    return "Application form"
```

### 9. Query Parameters
```python
from flask import request
@app.route("/search")
def search():
    q = request.args.get("q", "")
    return f"Searching for: {q}"
```

### 10. JSON Response
```python
from flask import jsonify
@app.route("/api/status")
def status():
    return jsonify({"status":"OK","count":42})
```

### 11. Debug Mode
Auto-reloads on code change; shows detailed errors.

### 12. Story Thread
Tian builds /status/<applicant_id> route returning approval info.

### 13. Practice Prompts
1. Create Flask app with home route.
2. Add dynamic route /greet/<name>.
3. Query param route: /add?a=5&b=3.
4. JSON endpoint returning dict.

### 14. Reflection
Two advantages of web interface over command-line scripts.

**Next:** Quiz then exercises.