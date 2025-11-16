## Lesson 23: Templates, Forms, and POST Requests

Story: Plain text responses lack structure. Rhea Joy: "Use Jinja2 templates for HTML; handle forms with POST."

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

**Next:** Quiz then exercises.