## Background Story

The database was connected, but Tian's SQL queries from Python were crude and dangerous. He was building queries with string concatenation: `query = "SELECT * FROM students WHERE name = '" + user_input + "'"`. Rhea Joy tried searching for a student named "O'Brien" and the system crashed with a syntax error. Worse, she read online about SQL injection attacks where malicious users could destroy entire databases through cleverly crafted inputs.

"We can't just smash strings together to build queries," Rhea Joy warned. "What if someone searches for `'; DROP TABLE students; --`? We'd delete our entire database!" Tian felt his stomach drop. "So how are we supposed to build dynamic queries? We can't hardcode every possible search combination. Users need to filter by different fields, sort by different columns, search with different criteria."

Kuya Miguel shared his screen to demonstrate proper query execution. "Use parameterized queries—placeholders for values that the database driver handles safely. Never concatenate user input directly into SQL. For complex queries with optional filters, build query parts conditionally using lists and joins. Use ORMs like SQLAlchemy if you want to avoid raw SQL altogether. These aren't just best practices; they're security fundamentals."

They refactored all database interactions: replaced string concatenation with parameterized queries using `?` placeholders for SQLite or `%s` for MySQL, built dynamic WHERE clauses safely by collecting conditions in lists, implemented proper JOIN queries to fetch related data efficiently, added input validation before queries even reached the database. The system became both more powerful and more secure. The scholarship system was becoming SQL-injection-proof, one parameterized query at a time.

---

## Theory & Lecture Content

### 1. Dynamic WHERE Clauses
```python
age_min = 18
query = "SELECT * FROM residents WHERE age >= ?"
cursor.execute(query, (age_min,))
```

### 2. Multiple Parameters
```python
cursor.execute(
    "SELECT * FROM residents WHERE age >= ? AND barangay_id = ?",
    (18, 3)
)
```

### 3. JOIN Queries
```python
cursor.execute("""
SELECT residents.name, barangays.name AS barangay
FROM residents
JOIN barangays ON residents.barangay_id = barangays.id
""")
```

### 4. Aggregation (COUNT, SUM, AVG)
```python
cursor.execute("SELECT COUNT(*) FROM residents WHERE age >= 18")
count = cursor.fetchone()[0]
print(f"Adults: {count}")
```

### 5. ORDER BY, LIMIT
```python
cursor.execute("SELECT * FROM residents ORDER BY age DESC LIMIT 5")
```

### 6. Transactions (Explicit Control)
```python
try:
    cursor.execute("UPDATE ...")
    cursor.execute("INSERT ...")
    conn.commit()
except:
    conn.rollback()
```

### 7. Bulk Insert (executemany)
```python
data = [("Ana", 21), ("Ben", 19), ("Clara", 22)]
cursor.executemany("INSERT INTO residents (name, age) VALUES (?, ?)", data)
conn.commit()
```

### 8. Avoiding SQL Injection (Never String Formatting)
```python
# WRONG:
query = f"SELECT * FROM residents WHERE name='{name}'"
# RIGHT:
cursor.execute("SELECT * FROM residents WHERE name=?", (name,))
```

### 9. Handling NULL
```python
cursor.execute("SELECT * FROM residents WHERE email IS NULL")
```

### 10. Returning Inserted ID
```python
cursor.execute("INSERT INTO residents (name) VALUES (?)", ("Dana",))
new_id = cursor.lastrowid
```

### 11. Story Thread
Tian builds /api/residents?min_age=18&barangay=3 endpoint with dynamic SQL.

---

## Closing Story

The scholarship system had basic CRUD operations. Now Tian needed complex queries: filtering, joining, aggregating.

"Time to unlock SQL's full power from Python," Kuya Miguel announced.

**Challenge 1: Dynamic Filtering**

The API needed flexible search:

```python
@app.route("/api/residents/search")
def search_residents():
    # /api/residents/search?min_age=18&barangay=3&status=Approved
    
    min_age = request.args.get("min_age")
    barangay_id = request.args.get("barangay")
    status = request.args.get("status")
    
    # Build query dynamically
    query = "SELECT * FROM residents WHERE 1=1"
    params = []
    
    if min_age:
        query += " AND age >= ?"
        params.append(int(min_age))
    
    if barangay_id:
        query += " AND barangay_id = ?"
        params.append(int(barangay_id))
    
    if status:
        query += " AND status = ?"
        params.append(status)
    
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute(query, params)
    results = cursor.fetchall()
    conn.close()
    
    return jsonify([dict(row) for row in results])
```

"Always use parameterized queries," Kuya Miguel emphasized. "Never f-strings or string concatenation."

**Challenge 2: JOIN Queries**

Rhea Joy needed a dashboard showing residents with their barangay names:

```python
@app.route("/api/dashboard")
def dashboard():
    conn = get_db()
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT 
            residents.id,
            residents.name,
            residents.age,
            barangays.name AS barangay_name,
            barangays.captain
        FROM residents
        JOIN barangays ON residents.barangay_id = barangays.id
        ORDER BY residents.name
    """)
    
    residents = cursor.fetchall()
    conn.close()
    
    return jsonify([dict(row) for row in residents])
```

**Output:**
```json
[
  {"id": 1, "name": "Ana Cruz", "age": 19, "barangay_name": "Brgy Iloilo", "captain": "Capt. Santos"},
  {"id": 2, "name": "Ben Reyes", "age": 21, "barangay_name": "Brgy Bacolod", "captain": "Capt. Lim"}
]
```

**Challenge 3: Aggregation Reports**

Tian built a report showing approval counts by barangay:

```python
@app.route("/api/reports/approvals")
def approval_report():
    conn = get_db()
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT 
            barangays.name AS barangay,
            COUNT(applications.id) AS total_applications,
            SUM(CASE WHEN applications.status = 'Approved' THEN 1 ELSE 0 END) AS approved,
            SUM(CASE WHEN applications.status = 'Pending' THEN 1 ELSE 0 END) AS pending
        FROM barangays
        LEFT JOIN residents ON residents.barangay_id = barangays.id
        LEFT JOIN applications ON applications.resident_id = residents.id
        GROUP BY barangays.id
        ORDER BY approved DESC
    """)
    
    report = cursor.fetchall()
    conn.close()
    
    return jsonify([dict(row) for row in report])
```

**Output:**
```json
[
  {"barangay": "Brgy Iloilo", "total_applications": 45, "approved": 32, "pending": 13},
  {"barangay": "Brgy Bacolod", "total_applications": 38, "approved": 25, "pending": 13}
]
```

**Challenge 4: Bulk Operations**

Rhea Joy imported 100 residents from CSV:

```python
import csv

def import_residents_from_csv(filepath):
    conn = get_db()
    cursor = conn.cursor()
    
    with open(filepath, "r") as f:
        reader = csv.DictReader(f)
        residents = [(row["name"], int(row["age"]), int(row["barangay_id"])) 
                     for row in reader]
    
    # Bulk insert - much faster than individual inserts
    cursor.executemany(
        "INSERT INTO residents (name, age, barangay_id) VALUES (?, ?, ?)",
        residents
    )
    conn.commit()
    conn.close()
    
    print(f"✓ Imported {len(residents)} residents")
```

**Challenge 5: Transactions**

Tian implemented approval workflow with rollback:

```python
@app.route("/api/applications/<int:app_id>/approve", methods=["POST"])
def approve_application(app_id):
    conn = get_db()
    cursor = conn.cursor()
    
    try:
        # Start transaction
        cursor.execute("BEGIN")
        
        # Update application status
        cursor.execute(
            "UPDATE applications SET status = 'Approved' WHERE id = ?",
            (app_id,)
        )
        
        # Deduct from budget
        cursor.execute(
            "UPDATE budget SET remaining = remaining - (SELECT amount FROM applications WHERE id = ?)",
            (app_id,)
        )
        
        # Log the action
        cursor.execute(
            "INSERT INTO audit_log (action, application_id, timestamp) VALUES (?, ?, ?)",
            ("APPROVED", app_id, datetime.now())
        )
        
        # Commit all changes
        conn.commit()
        return jsonify({"message": "Approved"}), 200
        
    except sqlite3.IntegrityError as e:
        # Rollback on error
        conn.rollback()
        return jsonify({"error": "Insufficient budget"}), 400
    
    finally:
        conn.close()
```

"All three operations succeed, or none do," Kuya Miguel explained. "That's atomicity."

**Challenge 6: Preventing SQL Injection**

Kuya Miguel showed the danger:

```python
# WRONG - Vulnerable to SQL injection
name = request.args.get("name")  # User input: "'; DROP TABLE residents; --"
query = f"SELECT * FROM residents WHERE name = '{name}'"  # DANGEROUS!
cursor.execute(query)  # Could delete entire table!

# RIGHT - Safe parameterization
name = request.args.get("name")
cursor.execute("SELECT * FROM residents WHERE name = ?", (name,))  # Safe
```

"Never trust user input," Kuya Miguel warned. "Always use `?` placeholders."

Tian refactored all queries to use parameterization:

```python
# Before (vulnerable)
query = f"SELECT * FROM residents WHERE age > {min_age}"

# After (safe)
query = "SELECT * FROM residents WHERE age > ?"
params = (min_age,)
cursor.execute(query, params)
```

Rhea Joy tested the complete system:

```python
# Complex query with JOIN, WHERE, GROUP BY, ORDER BY
cursor.execute("""
    SELECT 
        b.name AS barangay,
        COUNT(DISTINCT r.id) AS total_residents,
        AVG(r.age) AS avg_age,
        COUNT(DISTINCT a.id) AS total_applications
    FROM barangays b
    LEFT JOIN residents r ON r.barangay_id = b.id
    LEFT JOIN applications a ON a.resident_id = r.id
    WHERE r.age >= ?
    GROUP BY b.id
    HAVING COUNT(DISTINCT a.id) > ?
    ORDER BY total_applications DESC
", (18, 5))

results = cursor.fetchall()
```

The scholarship system now had:
- ✅ Dynamic filtering with safe parameterization
- ✅ Complex JOINs for related data
- ✅ Aggregation reports (COUNT, SUM, AVG)
- ✅ Bulk operations with `executemany`
- ✅ Transactions with rollback
- ✅ Protection against SQL injection

"From basic SELECT to production-grade queries," Rhea Joy marveled. "This is database mastery."

The barangay officers could now generate any report they needed: approvals by month, budget allocation per program, demographic breakdowns.

Python + SQL = Unlimited analytical power.

_Next up: Capstone Database-Driven Application!_ 🎯

**Next:** Quiz then exercises.