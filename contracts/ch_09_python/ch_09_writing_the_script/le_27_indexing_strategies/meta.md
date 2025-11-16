## Lesson 27 Exercises: Indexing Practice

---
### 1. Create Single-Column Index (7 minutes)
Table Residents; frequent WHERE barangay_id. Create index.

---
### 2. Create Composite Index (8 minutes)
Queries filter barangay_id AND age. Create composite index.

---
### 3. Unique Index (7 minutes)
Resident email must be unique. Create unique index.

---
### 4. Explain Query Plan (10 minutes)
Run EXPLAIN SELECT * FROM residents WHERE barangay_id=3. Verify index used.

---
### 5. Benchmark Improvement (10 minutes)
Time query before and after index creation. Compare results.

---
### 6. Identify Index Candidates (8 minutes)
Given query: SELECT * FROM applications WHERE status='Approved' ORDER BY submission_date. Which columns to index?

---
### 7. Avoid Over-Indexing (7 minutes)
Discuss: Small table (100 rows), rarely queried column. Should you index?

---
### 8. Stretch: Full-Text Index (Optional)
Text column for descriptions. Research and create full-text index (if database supports).

---
### 9. Reflection (3 minutes)
Two queries benefiting from indexing; two where indexing wasteful.

---
**Next:** Chapter 9 complete; move to Chapter 10 (Python + Database Integration, Capstone).