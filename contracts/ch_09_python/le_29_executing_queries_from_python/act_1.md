# Executing Queries from Python Activity

Practice advanced SQL operations from Python.

### Task 1: Filter with Range
```python
import sqlite3

conn = sqlite3.connect('scholarship.db')
cursor = conn.cursor()

# Your code: SELECT applicants WHERE age BETWEEN min_age and max_age
min_age = 18
max_age = 25

```

### Task 2: JOIN Query
```python
# Your code: JOIN applicants and barangays
# Print: applicant name, barangay name

```

### Task 3: GROUP BY Aggregation
```python
# Your code: COUNT applicants per barangay

```

### Task 4: Bulk Insert
```python
new_applicants = [
    ('David Lee', 21, 1),
    ('Eva Garcia', 20, 2),
    ('Frank Torres', 23, 1),
    ('Grace Ramos', 19, 3),
    ('Henry Diaz', 22, 2)
]

# Your code: executemany

```

## Reflection
**Two risks of string formatting in SQL:**
1. _[SQL injection attacks]_
2. _[Type conversion errors]_

**How parameterization prevents:**

<details>
<summary><strong>Answer Key</strong></summary>

```python
import sqlite3

conn = sqlite3.connect('scholarship.db')
cursor = conn.cursor()

# Task 1: Filter with range (parameterized)
min_age = 18
max_age = 25

cursor.execute('''
    SELECT * FROM applicants 
    WHERE age BETWEEN ? AND ?
''', (min_age, max_age))

for row in cursor.fetchall():
    print(f"{row[1]}: {row[2]} years old")

# Task 2: JOIN query
cursor.execute('''
    SELECT a.name AS applicant, b.name AS barangay
    FROM applicants a
    JOIN barangays b ON a.barangay_id = b.id
''')

for row in cursor.fetchall():
    print(f"{row[0]} from {row[1]}")

# Task 3: GROUP BY aggregation
cursor.execute('''
    SELECT b.name, COUNT(a.id) AS applicant_count
    FROM barangays b
    LEFT JOIN applicants a ON b.id = a.barangay_id
    GROUP BY b.id, b.name
    ORDER BY applicant_count DESC
''')

print("\nApplicants per Barangay:")
for row in cursor.fetchall():
    print(f"{row[0]}: {row[1]} applicants")

# Task 4: Bulk insert
new_applicants = [
    ('David Lee', 21, 1),
    ('Eva Garcia', 20, 2),
    ('Frank Torres', 23, 1),
    ('Grace Ramos', 19, 3),
    ('Henry Diaz', 22, 2)
]

cursor.executemany('''
    INSERT INTO applicants (name, age, barangay_id) 
    VALUES (?, ?, ?)
''', new_applicants)

conn.commit()
print(f"\nInserted {cursor.rowcount} rows")

conn.close()
```

**SQL Injection Example:**
```python
# VULNERABLE (DON'T DO THIS)
name = input("Enter name: ")  # User enters: " OR 1=1 --"
query = f"SELECT * FROM applicants WHERE name = '{name}'"
# Result: SELECT * FROM applicants WHERE name = '' OR 1=1 --'
# Returns ALL applicants!

# SAFE (parameterized)
cursor.execute('SELECT * FROM applicants WHERE name = ?', (name,))
# Database treats entire input as literal string, no code execution
```

**Reflection:**
1. **SQL Injection:** Malicious input becomes executable code. Example: `name = "'; DROP TABLE applicants; --"` would delete table!
2. **Type Errors:** String formatting doesn't handle None, dates, quotes properly
3. **Prevention:** Parameterization separates code from data. Database driver escapes special characters and validates types.

</details>
