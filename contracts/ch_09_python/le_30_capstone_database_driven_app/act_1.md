# Capstone: Database-Driven App Activity

Build a complete barangay scholarship management system.

## Project Requirements

Build a Flask web application with SQLite backend for managing scholarship applications.

### Core Features (Required)

1. **CRUD Operations for Applicants**
   - Create: Registration form
   - Read: List all applicants
   - Update: Edit applicant info
   - Delete: Remove applicant

2. **Database Schema**
   ```sql
   barangays (id, name, captain)
   applicants (id, name, age, email, barangay_id)
   scholarships (id, name, amount, deadline)
   applications (id, applicant_id, scholarship_id, status, submission_date)
   ```

3. **Validation Rules**
   - Age: 18-25
   - Email: unique, valid format
   - Barangay: must exist

4. **Dashboard with JOIN**
   - Display: applicant name, scholarship name, status, barangay

5. **Reports with Aggregation**
   - COUNT applications by barangay
   - SUM scholarship amounts by status

### Testing Checklist

- [ ] Create 3 barangays
- [ ] Register 5 applicants (test validation)
- [ ] Submit applications for 2 scholarships
- [ ] Update applicant email
- [ ] Delete test applicant
- [ ] View dashboard (verify JOIN)
- [ ] Generate approval report

### Stretch Goals (Optional)

- [ ] Pagination (20 per page)
- [ ] Search by name/barangay
- [ ] Export CSV report
- [ ] User authentication
- [ ] Deploy to cloud

## Implementation Tasks

### Task 1: Database Setup
```python
# schema.py
import sqlite3

def init_db():
    # Your code: create all tables
    pass
```

### Task 2: CRUD for Applicants
```python
# app.py
from flask import Flask, render_template, request, redirect

@app.route('/applicants/create', methods=['GET', 'POST'])
def create_applicant():
    # Your code
    pass

# TODO: read, update, delete routes
```

### Task 3: Validation
```python
def validate_applicant(data):
    errors = []
    # Your code: check age, email format, uniqueness
    return errors
```

### Task 4: Dashboard JOIN
```python
@app.route('/dashboard')
def dashboard():
    # Your code: JOIN query
    pass
```

### Task 5: Error Handling
```python
try:
    cursor.execute("INSERT INTO ...")
    conn.commit()
except sqlite3.IntegrityError:
    conn.rollback()
    # Your code: handle error
```

## Reflection
**Describe three technical decisions and trade-offs:**

1. **Decision:** 
   **Trade-off:** 

2. **Decision:** 
   **Trade-off:** 

3. **Decision:** 
   **Trade-off:** 

<details>
<summary><strong>Answer Key & Starter Code</strong></summary>

### Complete Implementation

**schema.py:**
```python
import sqlite3

def init_db():
    conn = sqlite3.connect('scholarship.db')
    cursor = conn.cursor()
    
    cursor.executescript('''
        CREATE TABLE IF NOT EXISTS barangays (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE NOT NULL,
            captain TEXT
        );
        
        CREATE TABLE IF NOT EXISTS applicants (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            age INTEGER NOT NULL,
            email TEXT UNIQUE NOT NULL,
            barangay_id INTEGER,
            FOREIGN KEY (barangay_id) REFERENCES barangays(id)
        );
        
        CREATE TABLE IF NOT EXISTS scholarships (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            amount INTEGER NOT NULL,
            deadline DATE
        );
        
        CREATE TABLE IF NOT EXISTS applications (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            applicant_id INTEGER,
            scholarship_id INTEGER,
            status TEXT DEFAULT 'pending',
            submission_date DATE DEFAULT CURRENT_DATE,
            FOREIGN KEY (applicant_id) REFERENCES applicants(id),
            FOREIGN KEY (scholarship_id) REFERENCES scholarships(id)
        );
    ''')
    
    conn.commit()
    conn.close()

if __name__ == '__main__':
    init_db()
    print("Database initialized!")
```

**app.py:**
```python
from flask import Flask, render_template, request, redirect, url_for, flash
import sqlite3
import re

app = Flask(__name__)
app.secret_key = 'your-secret-key'

def get_db():
    conn = sqlite3.connect('scholarship.db')
    conn.row_factory = sqlite3.Row
    return conn

def validate_applicant(name, age, email):
    errors = []
    
    if not name or len(name) < 2:
        errors.append("Name must be at least 2 characters")
    
    if not (18 <= age <= 25):
        errors.append("Age must be between 18 and 25")
    
    if not re.match(r'^[\w\.-]+@[\w\.-]+\.\w+$', email):
        errors.append("Invalid email format")
    
    return errors

# CREATE
@app.route('/applicants/create', methods=['GET', 'POST'])
def create_applicant():
    if request.method == 'POST':
        name = request.form['name']
        age = int(request.form['age'])
        email = request.form['email']
        barangay_id = request.form['barangay_id']
        
        errors = validate_applicant(name, age, email)
        if errors:
            for error in errors:
                flash(error, 'error')
            return redirect(url_for('create_applicant'))
        
        try:
            conn = get_db()
            cursor = conn.cursor()
            cursor.execute('''
                INSERT INTO applicants (name, age, email, barangay_id)
                VALUES (?, ?, ?, ?)
            ''', (name, age, email, barangay_id))
            conn.commit()
            conn.close()
            flash('Applicant created successfully!', 'success')
            return redirect(url_for('list_applicants'))
        except sqlite3.IntegrityError:
            flash('Email already exists!', 'error')
            return redirect(url_for('create_applicant'))
    
    conn = get_db()
    barangays = conn.execute('SELECT * FROM barangays').fetchall()
    conn.close()
    return render_template('create_applicant.html', barangays=barangays)

# READ
@app.route('/applicants')
def list_applicants():
    conn = get_db()
    applicants = conn.execute('''
        SELECT a.*, b.name AS barangay_name
        FROM applicants a
        LEFT JOIN barangays b ON a.barangay_id = b.id
        ORDER BY a.name
    ''').fetchall()
    conn.close()
    return render_template('list_applicants.html', applicants=applicants)

# UPDATE
@app.route('/applicants/<int:id>/edit', methods=['GET', 'POST'])
def edit_applicant(id):
    conn = get_db()
    
    if request.method == 'POST':
        name = request.form['name']
        age = int(request.form['age'])
        email = request.form['email']
        
        errors = validate_applicant(name, age, email)
        if errors:
            for error in errors:
                flash(error, 'error')
            return redirect(url_for('edit_applicant', id=id))
        
        try:
            cursor = conn.cursor()
            cursor.execute('''
                UPDATE applicants 
                SET name = ?, age = ?, email = ?
                WHERE id = ?
            ''', (name, age, email, id))
            conn.commit()
            flash('Applicant updated!', 'success')
            return redirect(url_for('list_applicants'))
        except sqlite3.IntegrityError:
            flash('Email already exists!', 'error')
        finally:
            conn.close()
    
    applicant = conn.execute('SELECT * FROM applicants WHERE id = ?', (id,)).fetchone()
    conn.close()
    return render_template('edit_applicant.html', applicant=applicant)

# DELETE
@app.route('/applicants/<int:id>/delete', methods=['POST'])
def delete_applicant(id):
    conn = get_db()
    conn.execute('DELETE FROM applicants WHERE id = ?', (id,))
    conn.commit()
    conn.close()
    flash('Applicant deleted!', 'success')
    return redirect(url_for('list_applicants'))

# DASHBOARD with JOIN
@app.route('/dashboard')
def dashboard():
    conn = get_db()
    data = conn.execute('''
        SELECT 
            a.name AS applicant_name,
            s.name AS scholarship_name,
            app.status,
            app.submission_date,
            b.name AS barangay_name
        FROM applications app
        JOIN applicants a ON app.applicant_id = a.id
        JOIN scholarships s ON app.scholarship_id = s.id
        JOIN barangays b ON a.barangay_id = b.id
        ORDER BY app.submission_date DESC
    ''').fetchall()
    conn.close()
    return render_template('dashboard.html', applications=data)

# REPORT with Aggregation
@app.route('/report')
def report():
    conn = get_db()
    
    by_barangay = conn.execute('''
        SELECT b.name, COUNT(app.id) AS count
        FROM barangays b
        LEFT JOIN applicants a ON b.id = a.barangay_id
        LEFT JOIN applications app ON a.id = app.applicant_id
        GROUP BY b.id, b.name
        ORDER BY count DESC
    ''').fetchall()
    
    by_status = conn.execute('''
        SELECT 
            app.status,
            COUNT(*) AS count,
            SUM(s.amount) AS total_amount
        FROM applications app
        JOIN scholarships s ON app.scholarship_id = s.id
        GROUP BY app.status
    ''').fetchall()
    
    conn.close()
    return render_template('report.html', 
                          by_barangay=by_barangay, 
                          by_status=by_status)

if __name__ == '__main__':
    app.run(debug=True)
```

**templates/list_applicants.html:**
```html
<!DOCTYPE html>
<html>
<head><title>Applicants</title></head>
<body>
    <h1>Scholarship Applicants</h1>
    <a href="{{ url_for('create_applicant') }}">Add New</a>
    
    {% with messages = get_flashed_messages(with_categories=true) %}
        {% for category, message in messages %}
            <p class="{{ category }}">{{ message }}</p>
        {% endfor %}
    {% endwith %}
    
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Email</th>
            <th>Barangay</th>
            <th>Actions</th>
        </tr>
        {% for applicant in applicants %}
        <tr>
            <td>{{ applicant.name }}</td>
            <td>{{ applicant.age }}</td>
            <td>{{ applicant.email }}</td>
            <td>{{ applicant.barangay_name }}</td>
            <td>
                <a href="{{ url_for('edit_applicant', id=applicant.id) }}">Edit</a>
                <form method="POST" action="{{ url_for('delete_applicant', id=applicant.id) }}" style="display:inline">
                    <button type="submit" onclick="return confirm('Delete?')">Delete</button>
                </form>
            </td>
        </tr>
        {% endfor %}
    </table>
</body>
</html>
```

### Technical Decisions & Trade-offs:

1. **SQLite vs PostgreSQL**
   - **Decision:** Used SQLite for simplicity
   - **Trade-off:** Easy setup, file-based, but limited concurrency. Would use PostgreSQL for production with multiple users.

2. **Server-side validation**
   - **Decision:** Python validation + database constraints
   - **Trade-off:** More secure, but slower UX. Could add JavaScript validation for immediate feedback.

3. **Denormalized dashboard**
   - **Decision:** JOIN query on every load
   - **Trade-off:** Always current data, but slower for large datasets. Could cache results or use materialized view.

</details>
