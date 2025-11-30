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

**Answer:** B. execute("WHERE age=?", (age,))  
**Explanation:** Parameterized: execute("WHERE age=?", (age,)).

---

**Question 2:** Multiple parameters:
A. (val1, val2) tuple
B. val1, val2 separate
C. [val1, val2] list (not standard)
D. No parameters

**Answer:** A. (val1, val2) tuple  
**Explanation:** Tuple (val1, val2) for multiple params.

---

**Question 3:** JOIN syntax:
A. SELECT * FROM a, b WHERE a.id=b.id
B. SELECT * FROM a JOIN b ON a.id=b.id
C. SELECT * JOIN a, b
D. No JOIN in Python

**Answer:** B. SELECT * FROM a JOIN b ON a.id=b.id  
**Explanation:** JOIN ... ON syntax standard.

---

**Question 4:** COUNT(*) returns:
A. All rows
B. Single integer (row count)
C. Column names
D. Nothing

**Answer:** B. Single integer (row count)  
**Explanation:** COUNT(*) returns integer count.

---

**Question 5:** ORDER BY DESC:
A. Ascending
B. Descending
C. Random
D. No effect

**Answer:** B. Descending  
**Explanation:** DESC = descending order.

---
# Quiz 2
## Scenario: Advanced Operations
Rhea Joy optimizes queries.

**Question 6:** executemany() purpose:
A. Single insert
B. Bulk insert (multiple rows)
C. Delete all
D. Fetch many

**Answer:** B. Bulk insert (multiple rows)  
**Explanation:** executemany() bulk insert list of tuples.

---

**Question 7:** SQL injection risk:
A. Parameterized queries
B. String formatting (f"{var}")
C. fetchall()
D. commit()

**Answer:** B. String formatting (f"{var}")  
**Explanation:** String formatting (f"{var}") enables SQL injection.

---

**Question 8:** lastrowid returns:
A. All IDs
B. ID of last inserted row
C. Row count
D. Nothing

**Answer:** B. ID of last inserted row  
**Explanation:** lastrowid returns ID of last INSERT.

---

**Question 9:** Rollback purpose:
A. Save changes
B. Undo uncommitted changes
C. Fetch data
D. Close connection

**Answer:** B. Undo uncommitted changes  
**Explanation:** Rollback reverts uncommitted changes.

---

**Question 10:** IS NULL syntax:
A. WHERE col = NULL
B. WHERE col IS NULL
C. WHERE col == NULL
D. WHERE NULL(col)

**Answer:** B. WHERE col IS NULL  
**Explanation:** IS NULL checks for NULL values.

---
**Next:** Proceed to Lesson 29 exercises.