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

**Question 2:** 1NF requirement:
A. Multi-valued columns
B. Atomic values, unique rows
C. No primary key
D. Composite keys required

**Question 3:** Example violating 1NF:
A. Column: id (integer)
B. Column: tags ("Python, SQL")
C. Column: age (integer)
D. Column: name (string)

**Question 4:** 2NF eliminates:
A. Transitive dependency
B. Partial dependency (non-key depends on part of composite key)
C. Multi-valued columns
D. Foreign keys

**Question 5:** Composite key scenario for 2NF:
A. Single-column primary key
B. Primary key with two+ columns (student_id, course_id)
C. No primary key
D. Foreign key only

---
# Quiz 2
## Scenario: Advanced Normalization
Rhea Joy enforces 3NF.

**Question 6:** 3NF eliminates:
A. Partial dependency
B. Transitive dependency (non-key depends on non-key)
C. Primary key
D. Foreign key

**Question 7:** Transitive dependency example:
A. name depends on id
B. barangay_captain depends on barangay_id (non-key)
C. id unique
D. age integer

**Question 8:** Normalization benefit:
A. More redundancy
B. Single source of truth, easier updates
C. Slower always
D. No foreign keys

**Question 9:** Trade-off of normalization:
A. Less redundancy
B. More joins (potential performance cost)
C. Simpler queries
D. No drawbacks

**Question 10:** Denormalization reason:
A. Always better
B. Optimize read-heavy queries (fewer joins)
C. Required by 3NF
D. Eliminates redundancy

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
10: B  

---
## Detailed Explanations
Q1 Normalization reduces redundancy, improves integrity.  
Q2 1NF: atomic values, unique rows (primary key).  
Q3 Multi-valued "Python, SQL" violates 1NF.  
Q4 2NF removes partial dependency (composite key issue).  
Q5 Composite key (student_id, course_id) relevant to 2NF.  
Q6 3NF removes transitive dependency.  
Q7 barangay_captain depends on barangay_id (non-key).  
Q8 Single source of truth simplifies updates.  
Q9 More joins can slow complex queries.  
Q10 Denormalization optimizes reads (e.g., caching common joins).  

---
**Next:** Proceed to Lesson 26 exercises.