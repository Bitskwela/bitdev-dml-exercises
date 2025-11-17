## Lesson 26: Normalization (1NF, 2NF, 3NF)

Story: Duplicate data everywhere. Rhea Joy teaches normalization: "Eliminate redundancy, enforce integrity."

### 1. What Is Normalization?
Process of organizing data to reduce redundancy and improve integrity.

### 2. Anomalies Without Normalization
- Insert: Can't add data without unrelated data.
- Update: Changing one copy leaves others stale.
- Delete: Removing row loses unrelated data.

### 3. First Normal Form (1NF)
- Atomic values (no lists in cells).
- Each column single-valued.
- Unique rows (primary key).

Before 1NF:
```
Resident: id | name | skills
1 | Ana | Python, SQL
```
After 1NF:
```
Resident: id | name
Skills: resident_id | skill
```

### 4. Second Normal Form (2NF)
- Must be 1NF.
- No partial dependency (all non-key attributes depend on entire primary key).
- Applies to composite keys.

Before 2NF (composite key: student_id, course_id):
```
Enrollments: student_id | course_id | student_name | course_name
```
student_name depends only on student_id (partial dependency).

After 2NF:
```
Students: id | name
Courses: id | name
Enrollments: student_id | course_id
```

### 5. Third Normal Form (3NF)
- Must be 2NF.
- No transitive dependency (non-key attributes depend only on primary key, not on other non-key).

Before 3NF:
```
Resident: id | name | barangay_id | barangay_captain
```
barangay_captain depends on barangay_id (transitive).

After 3NF:
```
Resident: id | name | barangay_id
Barangay: id | captain
```

### 6. Benefits
- Less redundancy.
- Easier updates (single source of truth).
- Data integrity.

### 7. Trade-offs
- More joins (potential performance cost).
- Denormalization sometimes used for read-heavy systems.

### 8. Story Thread
Tian refactors flat ApplicantData table into Residents, Applications, Programs (3NF).

### 9. Practice Prompts
1. Convert multi-valued column to 1NF.
2. Identify partial dependency; split to 2NF.
3. Identify transitive dependency; split to 3NF.
4. Justify trade-off for denormalization scenario.

### 10. Reflection
Two real-world problems solved by 3NF.

**Next:** Quiz then exercises.