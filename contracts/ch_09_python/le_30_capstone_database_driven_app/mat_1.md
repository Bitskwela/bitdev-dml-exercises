## Background Story

After months of learning, building, and refining, the moment had arrived: Tian and Rhea Joy were presenting their complete scholarship management system to the municipal mayor and education board. Everything they'd learned—databases, Python, web development, data analysis, security—was integrated into this one comprehensive platform. The pressure was intense. If approved, the system would be deployed across all 15 barangays in the municipality, serving thousands of students.

The night before the presentation, doubt crept in. "Kuya, are we really ready for this?" Rhea Joy asked, reviewing their codebase. "This isn't just a school project anymore. Real students' futures depend on this system working correctly." Tian understood her anxiety. They'd come so far from that chaotic day surrounded by paper files in the barangay hall. But were they truly ready for production deployment?

Kuya Miguel gave them a pep talk via video call. "You've built a proper database-driven application: normalized schema, indexed queries, RESTful API, secure authentication, data validation, error handling, responsive web interface, comprehensive reporting. You've followed industry best practices at every step. Most importantly, you've tested it with real data and real users. You're ready. Tomorrow, show them what grassroots tech innovation looks like."

The presentation went brilliantly. They demonstrated the full system: students checking application status on their phones, administrators processing applications through the web portal, automated reports generating insights for budget planning, secure data backups ensuring nothing was lost, integration APIs ready for future expansion. The mayor asked tough technical questions about scalability, security, and disaster recovery—questions they answered confidently. The system was approved for municipal-wide deployment. As they left the municipal hall, Tian and Rhea Joy realized they were no longer just students learning to code—they were engineers who'd built something real that would impact their community. The scholarship system was complete, one capstone project transforming into production reality.

---

## Theory & Lecture Content

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

---

## Closing Story

The journey began with a question: *"What is a database?"*

Now, 30 lessons later, Tian deployed the complete Barangay Scholarship Management System to production.

**The Stack:**
- **Backend:** Python Flask + SQLite
- **Database:** Normalized schema (3NF) with indexes
- **API:** RESTful endpoints for CRUD operations
- **Frontend:** Jinja2 templates + HTML/CSS forms
- **Validation:** Age constraints, unique emails, foreign key integrity

**The Schema:**

```sql
-- Three normalized tables with relationships
CREATE TABLE barangays (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    captain TEXT
);

CREATE TABLE residents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER CHECK(age >= 18),
    barangay_id INTEGER,
    email TEXT UNIQUE,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(barangay_id) REFERENCES barangays(id)
);

CREATE TABLE applications (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    resident_id INTEGER,
    program TEXT NOT NULL,
    status TEXT DEFAULT 'Pending',
    amount REAL,
    date TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(resident_id) REFERENCES residents(id)
);

-- Indexes for performance
CREATE INDEX idx_barangay_id ON residents(barangay_id);
CREATE INDEX idx_status ON applications(status);
CREATE INDEX idx_resident_id ON applications(resident_id);
```

**The Application:**

```python
from flask import Flask, request, jsonify, render_template
import sqlite3
from datetime import datetime

app = Flask(__name__)
DATABASE = "scholarship.db"

def get_db():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    conn = get_db()
    cursor = conn.cursor()
    # Execute schema creation (tables + indexes)
    conn.commit()
    conn.close()

# API: List all residents
@app.route("/api/residents", methods=["GET"])
def api_list_residents():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT 
            r.id, r.name, r.age, r.email, 
            b.name AS barangay_name
        FROM residents r
        LEFT JOIN barangays b ON r.barangay_id = b.id
        ORDER BY r.created_at DESC
    """)
    residents = [dict(row) for row in cursor.fetchall()]
    conn.close()
    return jsonify(residents)

# API: Create resident
@app.route("/api/residents", methods=["POST"])
def api_create_resident():
    data = request.get_json()
    
    # Validation
    if not data.get("name") or not data.get("age"):
        return jsonify({"error": "Name and age required"}), 400
    
    if data["age"] < 18:
        return jsonify({"error": "Age must be 18 or older"}), 400
    
    conn = get_db()
    cursor = conn.cursor()
    
    try:
        cursor.execute(
            "INSERT INTO residents (name, age, barangay_id, email) VALUES (?, ?, ?, ?)",
            (data["name"], data["age"], data.get("barangay_id"), data.get("email"))
        )
        conn.commit()
        new_id = cursor.lastrowid
        conn.close()
        return jsonify({"id": new_id, "message": "Resident created"}), 201
    
    except sqlite3.IntegrityError as e:
        conn.rollback()
        conn.close()
        return jsonify({"error": "Email already exists or invalid barangay"}), 400

# API: Update resident
@app.route("/api/residents/<int:resident_id>", methods=["PUT"])
def api_update_resident(resident_id):
    data = request.get_json()
    conn = get_db()
    cursor = conn.cursor()
    
    cursor.execute(
        "UPDATE residents SET email = ? WHERE id = ?",
        (data["email"], resident_id)
    )
    conn.commit()
    conn.close()
    return jsonify({"message": "Updated"})

# API: Delete resident
@app.route("/api/residents/<int:resident_id>", methods=["DELETE"])
def api_delete_resident(resident_id):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM residents WHERE id = ?", (resident_id,))
    conn.commit()
    conn.close()
    return jsonify({"message": "Deleted"})

# Dashboard: View all residents (HTML)
@app.route("/dashboard")
def dashboard():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT 
            r.id, r.name, r.age, r.email,
            b.name AS barangay
        FROM residents r
        LEFT JOIN barangays b ON r.barangay_id = b.id
        ORDER BY r.name
    """)
    residents = cursor.fetchall()
    conn.close()
    return render_template("dashboard.html", residents=residents)

# Report: Approvals by barangay
@app.route("/reports/approvals")
def report_approvals():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT 
            b.name AS barangay,
            COUNT(a.id) AS total_applications,
            SUM(CASE WHEN a.status = 'Approved' THEN 1 ELSE 0 END) AS approved,
            SUM(CASE WHEN a.status = 'Approved' THEN a.amount ELSE 0 END) AS total_disbursed
        FROM barangays b
        LEFT JOIN residents r ON r.barangay_id = b.id
        LEFT JOIN applications a ON a.resident_id = r.id
        GROUP BY b.id
        ORDER BY approved DESC
    """)
    report = cursor.fetchall()
    conn.close()
    return jsonify([dict(row) for row in report])

if __name__ == "__main__":
    init_db()
    app.run(debug=True)
```

**Testing the System:**

Rhea Joy ran the complete test suite:

```python
# Test 1: Create barangays
barangays = [
    {"name": "Brgy Iloilo", "captain": "Capt. Santos"},
    {"name": "Brgy Bacolod", "captain": "Capt. Lim"},
    {"name": "Brgy Cebu", "captain": "Capt. Torres"}
]
# POST to /api/barangays for each

# Test 2: Create residents (valid)
residents = [
    {"name": "Ana Cruz", "age": 19, "barangay_id": 1, "email": "ana@example.com"},
    {"name": "Ben Reyes", "age": 21, "barangay_id": 2, "email": "ben@example.com"}
]
# POST to /api/residents for each → Status 201

# Test 3: Create resident (invalid age)
invalid = {"name": "Minor", "age": 16, "barangay_id": 1, "email": "minor@example.com"}
# POST to /api/residents → Status 400: "Age must be 18 or older"

# Test 4: Update resident email
# PUT /api/residents/1 with {"email": "ana_new@example.com"} → Status 200

# Test 5: Create applications
applications = [
    {"resident_id": 1, "program": "College Scholarship", "amount": 5000, "status": "Approved"},
    {"resident_id": 2, "program": "Skills Training", "amount": 3000, "status": "Pending"}
]
# POST to /api/applications for each

# Test 6: View dashboard
# GET /dashboard → HTML table with residents + barangays (JOIN)

# Test 7: Generate approval report
# GET /reports/approvals → JSON:
# [
#   {"barangay": "Brgy Iloilo", "total_applications": 1, "approved": 1, "total_disbursed": 5000},
#   {"barangay": "Brgy Bacolod", "total_applications": 1, "approved": 0, "total_disbursed": 0}
# ]

# Test 8: Delete resident
# DELETE /api/residents/2 → Status 200
```

All tests passed. ✅

**Deployment Day:**

<details>
<summary><strong>Click here to view local deployment guide (Optional)</strong></summary>

Tian configured the production environment for local deployment:

```bash
# Install dependencies (for local setup)
pip install flask gunicorn

# Initialize database
python init_db.py

# Run with Gunicorn (production server)
gunicorn -w 4 -b 0.0.0.0:8000 app:app
```

**Note:** This course uses in-browser coding environments. The deployment steps above are for reference if you want to run the system locally.

</details>

The system went live. Barangay officials logged in. Within the first week:
- 150 residents registered
- 87 scholarship applications submitted
- 52 applications approved
- ₱234,000 disbursed

**The Barangay Captain's Speech:**

"Before this system, we used paper forms and Excel sheets. Applications got lost. We couldn't track budgets. Residents waited weeks for updates.

Now? Real-time dashboard. Automatic reports. Email notifications. Transparent audit trail. This is digital governance."

**Lessons Learned:**

Kuya Miguel reflected with Tian and Rhea Joy:

**1. Database Design Matters**
- "We started with one giant table. Normalization saved us from update anomalies and data inconsistency."

**2. Indexes Are Performance Game-Changers**
- "800ms → 15ms on filtered queries. Users notice speed."

**3. Validation at Multiple Layers**
- "Database constraints (CHECK, UNIQUE, FOREIGN KEY) + application validation = robust system."

**4. Parameterized Queries Prevent Disasters**
- "Never trust user input. One SQL injection could delete everything."

**5. Transactions Ensure Data Integrity**
- "Approval workflow updates 3 tables. All succeed or none do. No partial states."

**6. Start Simple, Scale Gradually**
- "SQLite for MVP. Migrate to PostgreSQL when scaling. Don't over-engineer early."

**The Journey:**

From `Lesson 1: What is a Database?` to `Lesson 30: Production-Ready Application`, the path covered:

1. **Database Fundamentals** (L1-3): SQL vs NoSQL, tables, keys, relationships
2. **Python Basics** (L4-12): Data structures, functions, error handling, control flow
3. **Data Science** (L13-18): NumPy, Pandas, statistics, regression, simulation
4. **File Operations** (L19-21): I/O, CSV, JSON, modules
5. **Web Development** (L22-25): Flask, templates, REST APIs, ER diagrams
6. **Database Optimization** (L26-29): Normalization, indexing, queries, connections
7. **Integration** (L30): Full-stack application

**What Tian Built:**
- Normalized database schema with 3 tables
- RESTful API with 10+ endpoints
- Web dashboard with Jinja2 templates
- Complex SQL queries (JOIN, GROUP BY, aggregation)
- Validation and error handling
- Transaction management with rollback
- Indexed queries for performance
- Production deployment with Gunicorn

**The Result:**

A complete, production-ready, database-driven web application serving real users, solving real problems, with real impact.

"From zero to deployed," Rhea Joy marveled. "This is what software engineering looks like."

Kuya Miguel smiled. "You didn't just learn databases. You learned systems thinking. You can now design, build, and deploy full-stack applications. The barangay scholarship system is just the beginning."

Tian looked at the live dashboard, watching real-time data flow in. The application that started as `print("Hello, World")` now served a community.

**TechStack Mastered:**
- ✅ Python programming
- ✅ Database design (SQL, normalization, indexing)
- ✅ Web development (Flask, REST APIs)
- ✅ Data science (NumPy, Pandas, visualization)
- ✅ Production deployment

**Ready for:**
- Building SaaS applications
- Data engineering pipelines
- Machine learning systems
- Enterprise software
- Startup MVPs

The scholarship portal hummed quietly on the server. 150 residents registered. 87 applications processed. Countless lives impacted.

One database at a time. 🚀

---

**Congratulations on completing the Python + Database Course!**

*"You are now a full-stack developer. Go build something amazing."*

**Next:** Quiz then capstone exercises.