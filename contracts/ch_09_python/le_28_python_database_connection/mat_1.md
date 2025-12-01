## Background Story

The scholarship system had two separate worlds that didn't talk to each other: the Python Flask application handled web requests and business logic, while data lived in CSV files that were slow, hard to query, and offered no concurrent access control. When two users tried to submit applications simultaneously, one submission would overwrite the other. Data integrity was becoming a serious issue.

"We need a real database," Tian declared after losing an entire day's worth of applications due to a corrupted CSV file. "But how do we make Python talk to a database? They're completely different systems." Rhea Joy had researched the options: "SQLite for development and small deployments, MySQL or PostgreSQL for production. But we need a way to connect them to our Python code."

Kuya Miguel walked them through database connectivity. "Python has database adapters—libraries that implement a standard interface for talking to databases. `sqlite3` is built-in for SQLite. `mysql-connector-python` or `pymysql` for MySQL. `psycopg2` for PostgreSQL. They all follow the same pattern: establish a connection, create a cursor, execute SQL, fetch results, commit changes, close gracefully."

They migrated from CSV files to SQLite: established connections with proper error handling, used context managers to ensure connections closed even after errors, implemented connection pooling for web applications to reuse connections efficiently, added transaction management to ensure data consistency. The system immediately felt more robust: concurrent users worked without conflicts, queries were fast, data integrity was guaranteed. The scholarship system was becoming enterprise-grade, one database connection at a time.

---

## Theory & Lecture Content

### 1. Database Options
- SQLite: file-based, zero-config (development/small apps).
- MySQL/PostgreSQL: client-server (production).

### 2. SQLite in Python (Built-in)
```python
import sqlite3
conn = sqlite3.connect("barangay.db")
cursor = conn.cursor()
```

### 3. Create Table
```python
cursor.execute("""
CREATE TABLE IF NOT EXISTS residents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER
)
""")
conn.commit()
```

### 4. Insert Data
```python
cursor.execute("INSERT INTO residents (name, age) VALUES (?, ?)", ("Ana", 21))
conn.commit()
```

### 5. Query Data
```python
cursor.execute("SELECT * FROM residents")
rows = cursor.fetchall()
for row in rows:
    print(row)
```

### 6. Fetch Variants
- `fetchone()`: single row.
- `fetchall()`: all rows.
- `fetchmany(n)`: n rows.

### 7. Parameterized Queries (Prevent SQL Injection)
```python
name = "Ana"
cursor.execute("SELECT * FROM residents WHERE name=?", (name,))
```

### 8. Update/Delete
```python
cursor.execute("UPDATE residents SET age=? WHERE id=?", (22, 1))
cursor.execute("DELETE FROM residents WHERE id=?", (2,))
conn.commit()
```

### 9. Context Manager (Auto-Close)
```python
with sqlite3.connect("barangay.db") as conn:
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM residents")
```

### 10. MySQL Connector (Third-Party)
```python
import mysql.connector
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="pass",
    database="barangay"
)
```

### 11. Row Factory (Dict-Like Rows)
```python
conn.row_factory = sqlite3.Row
cursor = conn.cursor()
cursor.execute("SELECT * FROM residents")
for row in cursor:
    print(row["name"], row["age"])
```

### 12. Story Thread
Tian migrates Flask app from in-memory list to SQLite; persistent CRUD.

### 13. Practice Prompts
1. Connect to SQLite; create table.
2. Insert 3 rows; query and print.
3. Parameterized query by name.
4. Update row; verify change.

### 14. Reflection
Two advantages of database over in-memory Python list.

---

## Closing Story

The scholarship data lived in Python lists. Every time the Flask app restarted, all data disappeared. Applicants added during the day? Gone after server restart.

"Time to add persistence," Kuya Miguel said. "Connect Python to SQLite."

Tian created the database:

```python
import sqlite3

# Connect (creates file if doesn't exist)
conn = sqlite3.connect("scholarship.db")
cursor = conn.cursor()

# Create table
cursor.execute("""
CREATE TABLE IF NOT EXISTS applicants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    barangay TEXT NOT NULL,
    status TEXT DEFAULT 'Pending'
)
""")

conn.commit()
print("✓ Database initialized")
```

The `scholarship.db` file appeared in the project folder. Data now persists on disk.

Rhea Joy added CRUD operations:

```python
# CREATE - Insert new applicant
def add_applicant(name, age, barangay):
    cursor.execute(
        "INSERT INTO applicants (name, age, barangay) VALUES (?, ?, ?)",
        (name, age, barangay)
    )
    conn.commit()
    return cursor.lastrowid

# READ - Get all applicants
def get_all_applicants():
    cursor.execute("SELECT * FROM applicants")
    return cursor.fetchall()

# READ - Get one by ID
def get_applicant(applicant_id):
    cursor.execute("SELECT * FROM applicants WHERE id = ?", (applicant_id,))
    return cursor.fetchone()

# UPDATE - Change status
def update_status(applicant_id, new_status):
    cursor.execute(
        "UPDATE applicants SET status = ? WHERE id = ?",
        (new_status, applicant_id)
    )
    conn.commit()

# DELETE - Remove applicant
def delete_applicant(applicant_id):
    cursor.execute("DELETE FROM applicants WHERE id = ?", (applicant_id,))
    conn.commit()
```

Tian integrated with Flask:

```python
from flask import Flask, jsonify, request
import sqlite3

app = Flask(__name__)

def get_db():
    conn = sqlite3.connect("scholarship.db")
    conn.row_factory = sqlite3.Row  # Dict-like rows
    return conn

@app.route("/api/applicants", methods=["GET"])
def api_get_applicants():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM applicants")
    applicants = [dict(row) for row in cursor.fetchall()]
    conn.close()
    return jsonify(applicants)

@app.route("/api/applicants", methods=["POST"])
def api_add_applicant():
    data = request.get_json()
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO applicants (name, age, barangay) VALUES (?, ?, ?)",
        (data["name"], data["age"], data["barangay"])
    )
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    return jsonify({"id": new_id, "message": "Created"}), 201
```

Rhea Joy tested the transformation:

**Before (in-memory list):**
```python
applicants = []  # Lost on restart
```

**After (database):**
```python
# Data persists across restarts
# Multiple processes can access
# ACID transactions ensure consistency
```

They restarted the Flask server. The applicants remained. Added more data. Restarted again. Still there.

"This is production-ready," Kuya Miguel approved. "Data survives crashes, restarts, deployments."

Tian added error handling:

```python
try:
    conn = sqlite3.connect("scholarship.db")
    cursor = conn.cursor()
    # ... operations ...
    conn.commit()
except sqlite3.IntegrityError as e:
    print(f"Database constraint violation: {e}")
    conn.rollback()
except sqlite3.Error as e:
    print(f"Database error: {e}")
finally:
    conn.close()
```

Or better, use context manager:

```python
with sqlite3.connect("scholarship.db") as conn:
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM applicants")
    applicants = cursor.fetchall()
# Auto-closes connection
```

The scholarship system now had persistent storage:
- Data survives restarts
- CRUD operations work reliably
- SQL injection prevented with parameterized queries
- Transactions ensure data integrity

"From volatile memory to durable storage," Rhea Joy marveled. "This is how real applications work."

The barangay could now trust the system. Applications submitted today would still be there tomorrow, next week, next year.

_Next up: Executing Complex Queries from Python!_ 📊

**Next:** Quiz then exercises.