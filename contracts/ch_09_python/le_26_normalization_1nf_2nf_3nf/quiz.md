# Lesson 26 Quiz: Normalization

---
# Quiz 1
## Scenario: Database Refinement
Tian eliminates redundancy.

**Question 1:** Normalization purpose:
A. Increase redundancy
B. Reduce redundancy, improve integrity
C. Slow queries
D. Merge tables

**Answer:** B. Reduce redundancy, improve integrity  
**Explanation:** Normalization reduces redundancy, improves integrity.

---

**Question 2:** 1NF requirement:
A. Multi-valued columns
B. Atomic values, unique rows
C. No primary key
D. Composite keys required

**Answer:** B. Atomic values, unique rows  
**Explanation:** 1NF: atomic values, unique rows (primary key).

---

**Question 3:** Example violating 1NF:
A. Column: id (integer)
B. Column: tags ("Python, SQL")
C. Column: age (integer)
D. Column: name (string)

**Answer:** B. Column: tags ("Python, SQL")  
**Explanation:** Multi-valued "Python, SQL" violates 1NF.

---

**Question 4:** 2NF eliminates:
A. Transitive dependency
B. Partial dependency (non-key depends on part of composite key)
C. Multi-valued columns
D. Foreign keys

**Answer:** B. Partial dependency (non-key depends on part of composite key)  
**Explanation:** 2NF removes partial dependency (composite key issue).

---

**Question 5:** Composite key scenario for 2NF:
A. Single-column primary key
B. Primary key with two+ columns (student_id, course_id)
C. No primary key
D. Foreign key only

**Answer:** B. Primary key with two+ columns (student_id, course_id)  
**Explanation:** Composite key (student_id, course_id) relevant to 2NF.

---
# Quiz 2
## Scenario: Advanced Normalization
Rhea Joy enforces 3NF.

**Question 6:** 3NF eliminates:
A. Partial dependency
B. Transitive dependency (non-key depends on non-key)
C. Primary key
D. Foreign key

**Answer:** B. Transitive dependency (non-key depends on non-key)  
**Explanation:** 3NF removes transitive dependency.

---

**Question 7:** Transitive dependency example:
A. name depends on id
B. barangay_captain depends on barangay_id (non-key)
C. id unique
D. age integer

**Answer:** B. barangay_captain depends on barangay_id (non-key)  
**Explanation:** barangay_captain depends on barangay_id (non-key).

---

**Question 8:** Normalization benefit:
A. More redundancy
B. Single source of truth, easier updates
C. Slower always
D. No foreign keys

**Answer:** B. Single source of truth, easier updates  
**Explanation:** Single source of truth simplifies updates.

---

**Question 9:** Trade-off of normalization:
A. Less redundancy
B. More joins (potential performance cost)
C. Simpler queries
D. No drawbacks

**Answer:** B. More joins (potential performance cost)  
**Explanation:** More joins can slow complex queries.

---

**Question 10:** Denormalization reason:
A. Always better
B. Optimize read-heavy queries (fewer joins)
C. Required by 3NF
D. Eliminates redundancy

**Answer:** B. Optimize read-heavy queries (fewer joins)  
**Explanation:** Denormalization optimizes reads (e.g., caching common joins).

---
**Next:** Proceed to Lesson 26 exercises.