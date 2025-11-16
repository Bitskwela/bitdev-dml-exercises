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

**Question 2:** Connect to SQLite:
A. sqlite3.connect("file.db")
B. sqlite3.open("file.db")
C. db.connect("file.db")
D. connect("file.db")

**Question 3:** Cursor object purpose:
A. Delete database
B. Execute queries, fetch results
C. Connect to server
D. Close connection

**Question 4:** Commit purpose:
A. Fetch data
B. Save changes (INSERT, UPDATE, DELETE)
C. Close connection
D. No effect

**Question 5:** Parameterized query prevents:
A. Typos
B. SQL injection
C. Null values
D. Faster queries

---
# Quiz 2
## Scenario: CRUD Operations
Rhea Joy executes queries.

**Question 6:** fetchall() returns:
A. Single row
B. All rows as list
C. Column names
D. Nothing

**Question 7:** fetchone() returns:
A. All rows
B. Single row (or None)
C. Column count
D. Last row

**Question 8:** Parameterized INSERT syntax:
A. execute("INSERT ... VALUES (?, ?)", (val1, val2))
B. execute("INSERT ... VALUES val1, val2")
C. execute("INSERT ... VALUES", val1, val2)
D. execute("INSERT ...", list)

**Question 9:** Context manager benefit:
A. Faster queries
B. Auto-closes connection
C. Prevents commits
D. No benefit

**Question 10:** MySQL connector:
A. Built-in Python
B. Third-party (pip install mysql-connector-python)
C. Not available
D. Same as sqlite3

---
## Answers
1: B  
2: A  
3: B  
4: B  
5: B  
6: B  
7: B  
8: A  
9: B  
10: B  

---
## Detailed Explanations
Q1 SQLite file-based, no server setup.  
Q2 sqlite3.connect("file.db") opens/creates DB.  
Q3 Cursor executes queries, fetches results.  
Q4 commit() saves changes.  
Q5 Parameterized queries prevent SQL injection.  
Q6 fetchall() returns list of all rows.  
Q7 fetchone() returns single row or None.  
Q8 ? placeholders with tuple values.  
Q9 Context manager auto-closes connection.  
Q10 MySQL connector third-party library.  

---
**Next:** Proceed to Lesson 28 exercises.