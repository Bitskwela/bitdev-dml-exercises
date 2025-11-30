# Lesson 28 Quiz: Python + Database

---
# Quiz 1
## Scenario: Database Connection
Tian integrates persistence.

**Question 1:** SQLite characteristic:
A. Requires server
B. File-based, zero-config
C. Cloud-only
D. Paid license

**Answer:** B. File-based, zero-config  
**Explanation:** SQLite file-based, no server setup.

---

**Question 2:** Connect to SQLite:
A. sqlite3.connect("file.db")
B. sqlite3.open("file.db")
C. db.connect("file.db")
D. connect("file.db")

**Answer:** A. sqlite3.connect("file.db")  
**Explanation:** sqlite3.connect("file.db") opens/creates DB.

---

**Question 3:** Cursor object purpose:
A. Delete database
B. Execute queries, fetch results
C. Connect to server
D. Close connection

**Answer:** B. Execute queries, fetch results  
**Explanation:** Cursor executes queries, fetches results.

---

**Question 4:** Commit purpose:
A. Fetch data
B. Save changes (INSERT, UPDATE, DELETE)
C. Close connection
D. No effect

**Answer:** B. Save changes (INSERT, UPDATE, DELETE)  
**Explanation:** commit() saves changes.

---

**Question 5:** Parameterized query prevents:
A. Typos
B. SQL injection
C. Null values
D. Faster queries

**Answer:** B. SQL injection  
**Explanation:** Parameterized queries prevent SQL injection.

---
# Quiz 2
## Scenario: CRUD Operations
Rhea Joy executes queries.

**Question 6:** fetchall() returns:
A. Single row
B. All rows as list
C. Column names
D. Nothing

**Answer:** B. All rows as list  
**Explanation:** fetchall() returns list of all rows.

---

**Question 7:** fetchone() returns:
A. All rows
B. Single row (or None)
C. Column count
D. Last row

**Answer:** B. Single row (or None)  
**Explanation:** fetchone() returns single row or None.

---

**Question 8:** Parameterized INSERT syntax:
A. execute("INSERT ... VALUES (?, ?)", (val1, val2))
B. execute("INSERT ... VALUES val1, val2")
C. execute("INSERT ... VALUES", val1, val2)
D. execute("INSERT ...", list)

**Answer:** A. execute("INSERT ... VALUES (?, ?)", (val1, val2))  
**Explanation:** ? placeholders with tuple values.

---

**Question 9:** Context manager benefit:
A. Faster queries
B. Auto-closes connection
C. Prevents commits
D. No benefit

**Answer:** B. Auto-closes connection  
**Explanation:** Context manager auto-closes connection.

---

**Question 10:** MySQL connector:
A. Built-in Python
B. Third-party (pip install mysql-connector-python)
C. Not available
D. Same as sqlite3

**Answer:** B. Third-party (pip install mysql-connector-python)  
**Explanation:** MySQL connector third-party library.

---
**Next:** Proceed to Lesson 28 exercises.