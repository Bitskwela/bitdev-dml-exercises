# Templates, Forms, and POST Requests Activity

Practice building interactive web forms.

### Task 1: Variable Interpolation
```html
<!-- templates/welcome.html -->
<h1>{{ title }}</h1>
<p>Welcome, {{ username }}!</p>
```

```python
from flask import render_template

# Your code: render template with variables

```

### Task 2: Loop in Template
```html
<!-- templates/applicants.html -->
<ul>
{% for applicant in applicants %}
    <li>{{ applicant }}</li>
{% endfor %}
</ul>
```

```python
# Your code: render with list of names

```

### Task 3: POST Handler
```html
<!-- templates/apply.html -->
<form method="POST">
    <input type="text" name="name" required>
    <button type="submit">Submit</button>
</form>
```

```python
from flask import request

# Your code: handle POST and print form data

```

### Task 4: Redirect After POST
```python
from flask import redirect, url_for

# Your code: redirect to success page after POST

```

## Reflection
**Two benefits of separating templates:**
1. _[Frontend/backend developers work independently]_
2. _[Easier to maintain and update UI]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# Task 1
@app.route('/')
def welcome():
    return render_template('welcome.html', 
                          title="Scholarship Portal", 
                          username="Ana")

# Task 2
@app.route('/applicants')
def applicants():
    names = ["Ana Cruz", "Ben Reyes", "Carla Santos"]
    return render_template('applicants.html', applicants=names)

# Task 3
@app.route('/apply', methods=['GET', 'POST'])
def apply():
    if request.method == 'POST':
        name = request.form['name']
        print(f"Received application from: {name}")
        return f"Thank you, {name}!"
    return render_template('apply.html')

# Task 4
@app.route('/submit', methods=['POST'])
def submit():
    # Process form...
    return redirect(url_for('success'))

@app.route('/success')
def success():
    return "Application submitted successfully!"

if __name__ == '__main__':
    app.run(debug=True)
```

**Reflection:** Separation benefits: (1) HTML designers work without Python knowledge, (2) Change UI without touching logic, (3) Reuse templates across routes, (4) Cleaner code organization

</details>
