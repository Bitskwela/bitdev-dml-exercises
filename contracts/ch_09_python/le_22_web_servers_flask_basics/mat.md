## Background Story

The scholarship system worked beautifully on Tian's laptop, but there was a problem: only Tian could use it. Students had to physically come to the barangay hall during office hours to check their application status. Parents couldn't view updates from home. The system that was supposed to increase accessibility was still limited by physical presence and office hours.

"We need a web portal," Captain Cruz declared at a council meeting. "Students should be able to check their status from their phones at midnight if they want. Parents should be able to view information without traveling to the hall. This needs to be on the internet." Tian panicked. "I don't know how to build websites! I only know Python!"

Rhea Joy had been researching web frameworks. "Kuya, what if we don't need to learn a completely new language? Flask is a Python web framework. We can turn our Python functions into web pages." Tian looked skeptical until Kuya Miguel confirmed it: "Flask is exactly what you need. It's lightweight, Python-based, and perfect for turning your backend logic into HTTP endpoints. Routes map URLs to Python functions. Templates turn your data into HTML. You're not starting over—you're extending what you already know."

They started simple: installed Flask, created a basic route that returned "Hello, Barangay!" in a browser, then gradually added real functionality—a homepage showing statistics, a search page accepting application IDs, a results page displaying status. Within a week, they had a functioning web portal. Students could check their status from any device with internet. The scholarship system was becoming accessible, one HTTP endpoint at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

The scholarship data was trapped in Python scripts. To check an applicant's status, you had to run a command-line program. The barangay staff weren't programmers—they needed something simpler.

"Let's build a web interface," Kuya Miguel suggested. "Flask makes it easy."

Tian installed Flask and created the first route:

```python
from flask import Flask, jsonify, request

app = Flask(__name__)

# Sample data
applicants = {
    "001": {"name": "Rhea Joy Santos", "status": "Approved"},
    "002": {"name": "Juan Dela Cruz", "status": "Pending"},
    "003": {"name": "Maria Garcia", "status": "Rejected"}
}

@app.route("/")
def home():
    return "<h1>Barangay Scholarship System</h1><p>API is running</p>"

@app.route("/status/<applicant_id>")
def check_status(applicant_id):
    applicant = applicants.get(applicant_id)
    if applicant:
        return jsonify(applicant)
    return jsonify({"error": "Applicant not found"}), 404

@app.route("/search")
def search():
    name = request.args.get("name", "")
    results = [a for a in applicants.values() if name.lower() in a["name"].lower()]
    return jsonify(results)

if __name__ == "__main__":
    app.run(debug=True)
```

Tian ran the server:

```bash
python app.py
# * Running on http://127.0.0.1:5000
```

Rhea Joy opened a browser and visited:
- `http://localhost:5000/` → Home page appeared
- `http://localhost:5000/status/001` → `{"name": "Rhea Joy Santos", "status": "Approved"}`
- `http://localhost:5000/search?name=Juan` → Found Juan Dela Cruz

"This is magic!" she exclaimed. "The same Python code, but now accessible from any browser."

Kuya Miguel explained: "Flask is a web framework. It handles HTTP requests, routes them to your Python functions, and returns responses. You focus on the logic—Flask handles the web part."

Tian added more routes:

```python
@app.route("/api/stats")
def stats():
    total = len(applicants)
    approved = sum(1 for a in applicants.values() if a["status"] == "Approved")
    return jsonify({
        "total": total,
        "approved": approved,
        "approval_rate": f"{(approved/total)*100:.1f}%"
    })
```

The barangay staff could now:
1. Check applicant status by ID (URL parameter)
2. Search by name (query parameter)
3. View statistics (JSON API)

No command line needed. Just a browser.

"From local scripts to web services," Tian marveled. "The internet is the interface now."

_Next up: Templates, Forms, and Building Full Web Apps!_ 🌐

**Next:** Quiz then exercises.