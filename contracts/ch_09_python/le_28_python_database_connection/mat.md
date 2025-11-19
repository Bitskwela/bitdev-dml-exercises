## Lesson 28: Python + Database Connection

Story: Flask app needs persistent storage. Tian connects Python to SQLite/MySQL: "Code meets data."

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

**Next:** Quiz then exercises.