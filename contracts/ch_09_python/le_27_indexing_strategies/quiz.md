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

**Answer:** B. Speed up data retrieval  
**Explanation:** Index speeds up retrieval (fast lookup).

---

**Question 2:** B-tree complexity:
A. O(n)
B. O(log n)
C. O(n^2)
D. O(1) always

**Answer:** B. O(log n)  
**Explanation:** B-tree O(log n) balanced tree.

---

**Question 3:** Primary key index:
A. Manual creation required
B. Auto-created, unique
C. Not allowed
D. Slows queries

**Answer:** B. Auto-created, unique  
**Explanation:** Primary key auto-indexed, unique.

---

**Question 4:** Create index syntax:
A. ADD INDEX col
B. CREATE INDEX idx_name ON table(col)
C. INDEX table.col
D. SET INDEX col

**Answer:** B. CREATE INDEX idx_name ON table(col)  
**Explanation:** CREATE INDEX idx_name ON table(col).

---

**Question 5:** Composite index use:
A. Single column only
B. Multiple columns (e.g., WHERE a AND b)
C. No benefit
D. Slower always

**Answer:** B. Multiple columns (e.g., WHERE a AND b)  
**Explanation:** Composite index for multi-column WHERE/ORDER BY.

---
# Quiz 2
## Scenario: Index Trade-offs
Rhea Joy balances performance.

**Question 6:** Index on high-write column:
A. Always best
B. Slower writes (index maintenance)
C. No effect
D. Required

**Answer:** B. Slower writes (index maintenance)  
**Explanation:** Index maintenance slows inserts/updates.

---

**Question 7:** When to index:
A. All columns always
B. WHERE, JOIN, ORDER BY columns
C. Only primary key
D. Never

**Answer:** B. WHERE, JOIN, ORDER BY columns  
**Explanation:** Index columns in WHERE, JOIN, ORDER BY.

---

**Question 8:** Unique index enforces:
A. Null values
B. No duplicate values
C. Foreign key
D. Sorting

**Answer:** B. No duplicate values  
**Explanation:** Unique index prevents duplicates.

---

**Question 9:** EXPLAIN command shows:
A. Data values
B. Query execution plan (index usage)
C. Schema design
D. Deletes rows

**Answer:** B. Query execution plan (index usage)  
**Explanation:** EXPLAIN shows query plan (index usage).

---

**Question 10:** Index trade-off:
A. Faster reads, slower writes
B. Faster writes, slower reads
C. No trade-off
D. Always slower

**Answer:** A. Faster reads, slower writes  
**Explanation:** Faster reads, slower writes (index maintenance).

---
**Next:** Proceed to Lesson 27 exercises.