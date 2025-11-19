## Lesson 29: Executing Queries from Python

Story: Complex filters, joins needed. Tian masters SQL from Python: "Dynamic queries, safe parameters."

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

### 12. Practice Prompts
1. Filter by age range; parameterize min/max.
2. JOIN residents and barangays; print names.
3. COUNT residents per barangay (GROUP BY).
4. Bulk insert 5 rows with executemany.

### 13. Reflection
Two risks of string formatting in SQL; how parameterization prevents.

**Next:** Quiz then exercises.