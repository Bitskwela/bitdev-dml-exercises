## Lesson 29 Exercises: Query Execution

---
### 1. Filter by Age Range (8 minutes)
SELECT residents WHERE age BETWEEN ? AND ?. Parameterize min=18, max=30.

---
### 2. JOIN Query (10 minutes)
Tables: residents, barangays. JOIN on barangay_id; print name + barangay.

---
### 3. COUNT Aggregation (8 minutes)
COUNT residents per barangay (GROUP BY barangay_id).

---
### 4. ORDER BY + LIMIT (7 minutes)
Top 5 oldest residents (ORDER BY age DESC LIMIT 5).

---
### 5. Bulk Insert (8 minutes)
List of 5 tuples; executemany() insert.

---
### 6. Transaction Rollback (10 minutes)
Try UPDATE + INSERT; raise exception; rollback; verify no changes.

---
### 7. lastrowid (7 minutes)
Insert resident; print lastrowid.

---
### 8. Stretch: Dynamic Filters (Optional)
Function build_query(min_age=None, barangay_id=None): conditionally adds WHERE clauses.

---
### 9. Reflection (3 minutes)
Two scenarios requiring transactions with rollback.

---
**Next:** Lesson 30 (Capstone Project).