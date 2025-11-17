## Lesson 28 Exercises: Python DB Practice

---
### 1. Connect and Create Table (10 minutes)
SQLite: connect to test.db; create residents table (id, name, age).

---
### 2. Insert Data (7 minutes)
Insert 3 residents; commit.

---
### 3. Query All (7 minutes)
SELECT * FROM residents; fetchall(); print each row.

---
### 4. Parameterized Query (8 minutes)
SELECT by name using ? placeholder; print result.

---
### 5. Update Row (7 minutes)
Update age for resident id=1; verify with SELECT.

---
### 6. Delete Row (7 minutes)
Delete resident id=2; verify with SELECT.

---
### 7. Context Manager (8 minutes)
Rewrite connection using `with` statement; verify auto-close.

---
### 8. Stretch: Row Factory (Optional)
Enable row_factory = sqlite3.Row; access columns by name.

---
### 9. Reflection (3 minutes)
Two reasons database persistence superior to in-memory lists.

---
**Next:** Lesson 29 (Executing Queries from Python).