## Lesson 30: Capstone – Database-Driven Scholarship Portal

Story: Final integration. Tian builds full scholarship portal: Flask + SQLite, CRUD API, data validation, reports.

### 1. Project Overview
Web application managing scholarship applicants:
- Residents table: id, name, age, barangay_id, email
- Barangays table: id, name, captain
- Applications table: id, resident_id, program, status, date

### 2. Objectives
- RESTful API (GET, POST, PUT, DELETE)
- Data validation (age >= 18, email unique)
- JOIN queries (resident + barangay info)
- Aggregation reports (approved per barangay)
- Template rendering (admin dashboard)
- Error handling (try/except, rollback)

### 3. Tech Stack
- Flask (routes, templates)
- SQLite (persistence)
- Jinja2 (HTML templates)
- Bootstrap (optional styling)

### 4. Core Features
1. **List Residents**: GET /api/residents
2. **Create Resident**: POST /api/residents (validate age, email)
3. **Get One**: GET /api/residents/<id>
4. **Update**: PUT /api/residents/<id>
5. **Delete**: DELETE /api/residents/<id>
6. **Applications**: CRUD for applications
7. **Report**: GET /reports/approvals (COUNT by barangay)
8. **Dashboard**: HTML page listing residents with barangay names (JOIN)

### 5. Database Schema (3NF)
```sql
CREATE TABLE barangays (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    captain TEXT
);

CREATE TABLE residents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER CHECK(age >= 18),
    barangay_id INTEGER,
    email TEXT UNIQUE,
    FOREIGN KEY(barangay_id) REFERENCES barangays(id)
);

CREATE TABLE applications (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    resident_id INTEGER,
    program TEXT,
    status TEXT DEFAULT 'Pending',
    date TEXT,
    FOREIGN KEY(resident_id) REFERENCES residents(id)
);
```

### 6. Validation Example
```python
@app.route("/api/residents", methods=["POST"])
def create_resident():
    data = request.get_json()
    if data["age"] < 18:
        return jsonify({"error":"Age must be >= 18"}), 400
    # Insert...
```

### 7. JOIN for Dashboard
```python
@app.route("/dashboard")
def dashboard():
    cursor.execute("""
    SELECT residents.name, residents.age, barangays.name AS barangay
    FROM residents
    JOIN barangays ON residents.barangay_id = barangays.id
    """)
    residents = cursor.fetchall()
    return render_template("dashboard.html", residents=residents)
```

### 8. Aggregation Report
```python
@app.route("/reports/approvals")
def report():
    cursor.execute("""
    SELECT barangays.name, COUNT(*) AS approved
    FROM applications
    JOIN residents ON applications.resident_id = residents.id
    JOIN barangays ON residents.barangay_id = barangays.id
    WHERE applications.status = 'Approved'
    GROUP BY barangays.id
    """)
    return jsonify(cursor.fetchall())
```

### 9. Error Handling
```python
try:
    cursor.execute(...)
    conn.commit()
except sqlite3.IntegrityError as e:
    conn.rollback()
    return jsonify({"error": str(e)}), 400
```

### 10. Testing Checklist
- [ ] Create 3 barangays
- [ ] Create 5 residents (valid + invalid age)
- [ ] Update resident email
- [ ] Delete resident
- [ ] Create applications
- [ ] View dashboard (JOIN)
- [ ] Generate approval report

### 11. Story Thread
Tian deploys portal. Rhea Joy: "All concepts unified—Python, databases, web, validation. Scholarship system live."

### 12. Practice Prompts
1. Implement full CRUD for residents.
2. Add validation: age >= 18, email unique.
3. JOIN query for dashboard.
4. Aggregation report: COUNT approvals by barangay.
5. Error handling with rollback.

### 13. Stretch Goals
- Pagination for large lists
- Search/filter by name or barangay
- Export report as CSV
- Authentication (login/logout)
- Deploy to cloud (Heroku, PythonAnywhere)

### 14. Reflection
Describe three technical decisions and trade-offs in your implementation.

**Next:** Quiz then capstone exercises.