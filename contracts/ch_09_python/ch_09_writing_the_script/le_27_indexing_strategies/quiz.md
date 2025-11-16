# Lesson 27 Quiz: Indexing

---
# Quiz 1
## Scenario: Query Optimization
Tian accelerates searches.

**Question 1:** Index purpose:
A. Store data
B. Speed up data retrieval
C. Delete rows
D. Normalize schema

**Question 2:** B-tree complexity:
A. O(n)
B. O(log n)
C. O(n^2)
D. O(1) always

**Question 3:** Primary key index:
A. Manual creation required
B. Auto-created, unique
C. Not allowed
D. Slows queries

**Question 4:** Create index syntax:
A. ADD INDEX col
B. CREATE INDEX idx_name ON table(col)
C. INDEX table.col
D. SET INDEX col

**Question 5:** Composite index use:
A. Single column only
B. Multiple columns (e.g., WHERE a AND b)
C. No benefit
D. Slower always

---
# Quiz 2
## Scenario: Index Trade-offs
Rhea Joy balances performance.

**Question 6:** Index on high-write column:
A. Always best
B. Slower writes (index maintenance)
C. No effect
D. Required

**Question 7:** When to index:
A. All columns always
B. WHERE, JOIN, ORDER BY columns
C. Only primary key
D. Never

**Question 8:** Unique index enforces:
A. Null values
B. No duplicate values
C. Foreign key
D. Sorting

**Question 9:** EXPLAIN command shows:
A. Data values
B. Query execution plan (index usage)
C. Schema design
D. Deletes rows

**Question 10:** Index trade-off:
A. Faster reads, slower writes
B. Faster writes, slower reads
C. No trade-off
D. Always slower

---
## Answers
1: B  
2: B  
3: B  
4: B  
5: B  
6: B  
7: B  
8: B  
9: B  
10: A  

---
## Detailed Explanations
Q1 Index speeds up retrieval (fast lookup).  
Q2 B-tree O(log n) balanced tree.  
Q3 Primary key auto-indexed, unique.  
Q4 CREATE INDEX idx_name ON table(col).  
Q5 Composite index for multi-column WHERE/ORDER BY.  
Q6 Index maintenance slows inserts/updates.  
Q7 Index columns in WHERE, JOIN, ORDER BY.  
Q8 Unique index prevents duplicates.  
Q9 EXPLAIN shows query plan (index usage).  
Q10 Faster reads, slower writes (index maintenance).  

---
**Next:** Proceed to Lesson 27 exercises.