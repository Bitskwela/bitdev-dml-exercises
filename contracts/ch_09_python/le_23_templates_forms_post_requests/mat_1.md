## Background Story

The initial scholarship web portal worked, but it was ugly. Really ugly. Plain white background, black Times New Roman text, no formatting, no style—just raw information dumped onto the screen. A barangay council member took one look and said, "This looks like a website from 1995. Students will think it's a scam or a joke. Can't you make it look... professional?"

Tian tried embedding HTML directly in his Python code: `return "<html><body><h1>" + status + "</h1></body></html>"`. It quickly became a nightmare of string concatenation and escaped quotes. Mixing presentation and logic made the code unreadable and unmaintainable. Plus, they still needed a way for users to submit data—right now, students had to manually edit URLs to search for their applications.

Rhea Joy discovered Jinja2 templates while browsing Flask documentation. "Look, Kuya! We can separate HTML from Python. Templates handle presentation, Python handles logic. And Flask can render forms that let users submit data properly." Kuya Miguel approved: "Exactly right. Templates are like mail merge—you design the structure once, then inject dynamic data. Forms let users send data via POST requests instead of messy URL parameters. This is how professional web applications work."

They rebuilt the interface: created HTML templates with proper structure and Bootstrap styling, embedded dynamic data using Jinja2 syntax like `{{ student.name }}`, built forms for searching and submitting applications with proper POST handling. The portal transformed from amateur to professional-looking. Students could now submit applications directly through beautiful web forms. The scholarship system was becoming user-friendly, one template at a time.

---

## Theory & Lecture Content

### 1. Jinja2 Template Engine
Built into Flask; separates presentation from logic.

### 2. Project Structure
```
project/
    app.py
    templates/
        index.html
        result.html
```

### 3. Render Template
```python
from flask import render_template
@app.route("/")
def home():
    return render_template("index.html", title="Home")
```

### 4. Template Syntax (Jinja2)
```html
<!DOCTYPE html>
<html>
<head><title>{{ title }}</title></head>
<body><h1>{{ title }}</h1></body>
</html>
```

### 5. Passing Data
```python
@app.route("/user/<name>")
def user(name):
    return render_template("user.html", name=name)
```

### 6. Loops in Template
```html
{% for item in items %}
<li>{{ item }}</li>
{% endfor %}
```

### 7. Conditionals
```html
{% if user.is_approved %}
<p>Approved</p>
{% else %}
<p>Pending</p>
{% endif %}
```

### 8. HTML Form
```html
<form method="post" action="/apply">
<input name="name" required>
<button type="submit">Submit</button>
</form>
```

### 9. Handling POST
```python
from flask import request
@app.route("/apply", methods=["GET","POST"])
def apply():
    if request.method == "POST":
        name = request.form["name"]
        return f"Application received: {name}"
    return render_template("form.html")
```

### 10. Redirect After POST
```python
from flask import redirect, url_for
return redirect(url_for("success"))
```

### 11. Flash Messages
```python
from flask import flash
flash("Submitted successfully")
```

### 12. Story Thread
Build form: name, age, barangay. POST handler validates; displays confirmation page.

### 13. Practice Prompts
1. Create template with variable interpolation.
2. Loop through list in template.
3. Form accepting input; POST handler prints form data.
4. Redirect after successful POST.

### 14. Reflection
Two benefits of separating HTML templates from Python logic.

---

## Closing Story

The Flask API was working, but returning JSON wasn't user-friendly for barangay staff. They needed actual web pages with forms.

"Time to add templates," Kuya Miguel said. "Flask uses Jinja2—HTML with Python-like syntax embedded."

Tian created the first template:

**templates/index.html:**
```html
<!DOCTYPE html>
<html>
<head>
    <title>{{ title }}</title>
</head>
<body>
    <h1>{{ title }}</h1>
    <p>Welcome, {{ user_name }}!</p>
    
    <h2>Recent Applicants</h2>
    <ul>
    {% for applicant in applicants %}
        <li>{{ applicant.name }} - {{ applicant.status }}</li>
    {% endfor %}
    </ul>
</body>
</html>
```

**app.py:**
```python
from flask import Flask, render_template, request, redirect, url_for, flash

app = Flask(__name__)
app.secret_key = "secret"

applicants = []

@app.route("/")
def index():
    return render_template("index.html", 
                         title="Scholarship Portal",
                         user_name="Admin",
                         applicants=applicants)

@app.route("/apply", methods=["GET", "POST"])
def apply():
    if request.method == "POST":
        name = request.form["name"]
        age = request.form["age"]
        barangay = request.form["barangay"]
        
        applicants.append({
            "name": name,
            "age": age,
            "barangay": barangay,
            "status": "Pending"
        })
        
        flash(f"Application submitted for {name}!")
        return redirect(url_for("index"))
    
    return render_template("apply.html")
```

**templates/apply.html:**
```html
<h1>Scholarship Application</h1>
<form method="post">
    <label>Name: <input name="name" required></label><br>
    <label>Age: <input name="age" type="number" required></label><br>
    <label>Barangay: <input name="barangay" required></label><br>
    <button type="submit">Submit Application</button>
</form>
```

Rhea Joy tested the form. Type name, age, barangay. Submit. Redirect to home page. Application appears in the list.

"Now it feels like a real website," she said, clicking through the pages.

Kuya Miguel explained the pattern: "GET request shows the form. POST request processes it. Redirect after POST prevents duplicate submissions if user refreshes."

Tian added validation and flash messages:

```python
if int(age) < 17:
    flash("Applicant must be at least 17 years old", "error")
    return redirect(url_for("apply"))

flash("Application submitted successfully!", "success")
```

**templates/base.html:**
```html
{% with messages = get_flashed_messages(with_categories=true) %}
    {% for category, message in messages %}
        <div class="alert-{{ category }}">{{ message }}</div>
    {% endfor %}
{% endwith %}
```

The scholarship portal was now complete:
- Homepage listing applicants
- Application form with validation
- Flash messages for feedback
- Clean separation: Python for logic, HTML for presentation

"Templates are how web apps communicate with humans," Kuya Miguel said. "APIs are for machines. Templates are for people."

The barangay staff loved it. No more command line. Just click, type, submit—like any other website.

_Next up: REST APIs and Building API Endpoints!_ 🔌

**Next:** Quiz then exercises.