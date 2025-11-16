# Lesson 29 Quiz: Executing Queries

---
# Quiz 1
## Scenario: Dynamic Queries
Tian builds flexible filters.

**Question 1:** Parameterized WHERE:
A. f"WHERE age={age}"
B. execute("WHERE age=?", (age,))
C. WHERE age=$age
D. WHERE age=age

**Question 2:** Multiple parameters:
A. (val1, val2) tuple
B. val1, val2 separate
C. [val1, val2] list (not standard)
D. No parameters

**Question 3:** JOIN syntax:
A. SELECT * FROM a, b WHERE a.id=b.id
B. SELECT * FROM a JOIN b ON a.id=b.id
C. SELECT * JOIN a, b
D. No JOIN in Python

**Question 4:** COUNT(*) returns:
A. All rows
B. Single integer (row count)
C. Column names
D. Nothing

**Question 5:** ORDER BY DESC:
A. Ascending
B. Descending
C. Random
D. No effect

---
# Quiz 2
## Scenario: Advanced Operations
Rhea Joy optimizes queries.

**Question 6:** executemany() purpose:
A. Single insert
B. Bulk insert (multiple rows)
C. Delete all
D. Fetch many

**Question 7:** SQL injection risk:
A. Parameterized queries
B. String formatting (f"{var}")
C. fetchall()
D. commit()

**Question 8:** lastrowid returns:
A. All IDs
B. ID of last inserted row
C. Row count
D. Nothing

**Question 9:** Rollback purpose:
A. Save changes
B. Undo uncommitted changes
C. Fetch data
D. Close connection

**Question 10:** IS NULL syntax:
A. WHERE col = NULL
B. WHERE col IS NULL
C. WHERE col == NULL
D. WHERE NULL(col)

---
## Answers
1: B  
2: A  
3: B  
4: B  
5: B  
6: B  
7: B  
8: B  
9: B  
10: B  

---
## Detailed Explanations
Q1 Parameterized: execute("WHERE age=?", (age,)).  
Q2 Tuple (val1, val2) for multiple params.  
Q3 JOIN ... ON syntax standard.  
Q4 COUNT(*) returns integer count.  
Q5 DESC = descending order.  
Q6 executemany() bulk insert list of tuples.  
Q7 String formatting (f"{var}") enables SQL injection.  
Q8 lastrowid returns ID of last INSERT.  
Q9 Rollback reverts uncommitted changes.  
Q10 IS NULL checks for NULL values.  

---
**Next:** Proceed to Lesson 29 exercises.