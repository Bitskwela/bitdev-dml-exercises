# Python Database Connection Activity

Practice connecting Python to SQLite database.

### Task 1: Connect and Create Table
```python
import sqlite3

# Your code: connect, create applicants table
conn = sqlite3.connect('scholarship.db')
cursor = conn.cursor()

# Table: id, name, age
cursor.execute('''
    CREATE TABLE IF NOT EXISTS applicants (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER
    )
''')
conn.commit()
```

### Task 2: Insert and Query
```python
# Your code: insert 3 applicants
applicants = [
    ('Ana Cruz', 20),
    ('Ben Reyes', 22),
    ('Carla Santos', 19)
]
cursor.executemany('INSERT INTO applicants (name, age) VALUES (?, ?)', applicants)
conn.commit()

# Query all and print
cursor.execute('SELECT * FROM applicants')
for row in cursor.fetchall():
    print(f"ID: {row[0]}, Name: {row[1]}, Age: {row[2]}")
```

### Task 3: Parameterized Query
```python
# Your code: query by name (parameterized)
name = "Ana Cruz"
cursor.execute('SELECT * FROM applicants WHERE name = ?', (name,))
result = cursor.fetchone()
if result:
    print(f"Found: {result}")
```

### Task 4: Update Row
```python
# Your code: update age for specific applicant
cursor.execute('UPDATE applicants SET age = ? WHERE name = ?', (21, 'Ana Cruz'))
conn.commit()

# Verify change
cursor.execute('SELECT * FROM applicants WHERE name = ?', ('Ana Cruz',))
print(f"Updated: {cursor.fetchone()}")

conn.close()
```

## Reflection
**Two advantages of database over list:**
1. _[Persistence across program runs]_
2. _[Concurrent access from multiple processes]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
import sqlite3

# Task 1: Connect and Create
conn = sqlite3.connect('scholarship.db')
cursor = conn.cursor()

cursor.execute('''
    CREATE TABLE IF NOT EXISTS applicants (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER
    )
''')
conn.commit()

# Task 2: Insert and Query
applicants = [
    ('Ana Cruz', 20),
    ('Ben Reyes', 22),
    ('Carla Santos', 19)
]

cursor.executemany('INSERT INTO applicants (name, age) VALUES (?, ?)', applicants)
conn.commit()

cursor.execute('SELECT * FROM applicants')
for row in cursor.fetchall():
    print(f"ID: {row[0]}, Name: {row[1]}, Age: {row[2]}")

# Task 3: Parameterized Query
name = "Ana Cruz"
cursor.execute('SELECT * FROM applicants WHERE name = ?', (name,))
result = cursor.fetchone()
if result:
    print(f"Found: {result}")

# Task 4: Update Row
cursor.execute('UPDATE applicants SET age = ? WHERE name = ?', (21, 'Ana Cruz'))
conn.commit()

# Verify
cursor.execute('SELECT * FROM applicants WHERE name = ?', ('Ana Cruz',))
print(f"Updated: {cursor.fetchone()}")

conn.close()
```

**Best Practices:**
1. **Always use parameterized queries** to prevent SQL injection
2. **Commit after writes** (INSERT, UPDATE, DELETE)
3. **Close connections** when done (or use context manager)
4. **Error handling** with try/except

**Reflection:** Database advantages: (1) Data persists after program ends, (2) Multiple programs can access concurrently, (3) ACID transactions, (4) Query optimization, (5) Large datasets exceed RAM

</details>
