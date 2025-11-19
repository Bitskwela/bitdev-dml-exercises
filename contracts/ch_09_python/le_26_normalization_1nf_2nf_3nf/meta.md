## Lesson 26 Exercises: Normalization Practice

---
### 1. Identify 1NF Violation (7 minutes)
Table: Resident(id, name, hobbies="Reading, Coding"). Convert to 1NF.

---
### 2. 1NF Conversion (8 minutes)
Split multi-valued column into separate Hobbies table (resident_id, hobby).

---
### 3. Identify Partial Dependency (8 minutes)
Enrollments(student_id, course_id, student_name, course_name). Identify partial dependencies.

---
### 4. 2NF Conversion (10 minutes)
Split Enrollments into Students, Courses, Enrollments (junction).

---
### 5. Identify Transitive Dependency (8 minutes)
Resident(id, name, barangay_id, barangay_captain). Identify transitive dependency.

---
### 6. 3NF Conversion (10 minutes)
Split into Resident and Barangay tables.

---
### 7. Verify Normal Forms (7 minutes)
Check: Resident(id, name, age), Barangay(id, captain), Resident.barangay_id FK. Confirm 3NF.

---
### 8. Stretch: Denormalization Scenario (Optional)
Design read-optimized table for report: ResidentSummary(id, name, barangay_name, captain). Justify trade-off.

---
### 9. Reflection (3 minutes)
Two update anomalies prevented by 3NF.

---
**Next:** Lesson 27 (Indexing Strategies).