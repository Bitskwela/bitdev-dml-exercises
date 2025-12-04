## Background Story

After creating their ER diagrams, Tian and Rhea Joy started implementing the new database schema. But something felt wrong. The students table still had weird redundancies: every time a student from Barangay San Roque appeared, the barangay captain's name was repeated. When they updated the captain's name in one place, they had to remember to update it everywhere else. "Why does student information include barangay leadership details?" Rhea Joy questioned. "These are different things."

Tian defended his design. "But we need to show the captain's name on student reports. If it's not in the students table, how do we get it?" Rhea Joy sensed they were missing something fundamental about database design. "There must be a better way than copying the same information everywhere."

Kuya Miguel introduced them to normalization—a systematic process for organizing data to reduce redundancy and improve integrity. "First Normal Form: eliminate repeating groups and ensure atomic values. Second Normal Form: remove partial dependencies. Third Normal Form: remove transitive dependencies. These aren't just academic exercises; they're battle-tested rules that prevent data anomalies and inconsistencies."

They normalized the database step by step: broke multi-valued fields into separate rows (1NF), moved barangay-specific information to a barangays table with foreign key relationships (2NF), and separated derived data like age calculations that depended on birthdate rather than storing both (3NF). The final schema was elegant: no redundancy, clear relationships, easy updates. Changing a barangay captain's name now required updating exactly one row, not hundreds. The scholarship system was becoming data-integrity-focused, one normal form at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

Tian's first database design was a mess. One massive table with everything:

```
ApplicantData:
id | name | age | barangay | programs_applied | program_amounts | contact_email, contact_phone
1  | Ana  | 18  | Brgy1    | Prog1,Prog2      | 5000,3000       | ana@ex.com, 09171234567
```

"This violates every normal form," Kuya Miguel winced. "Multiple values in cells. Repeated groups. Transitive dependencies. Let's fix this."

**Step 1: First Normal Form (1NF) - Atomic Values**

No multi-valued cells. Each cell contains only one value.

```
# Before (violates 1NF)
programs_applied: "Prog1,Prog2"

# After (1NF compliant)
Applications:
applicant_id | program_id
1            | 1
1            | 2
```

"Each piece of data now lives in its own cell," Rhea Joy noted.

**Step 2: Second Normal Form (2NF) - No Partial Dependencies**

If composite key exists, non-key attributes must depend on the *entire* key, not part of it.

```
# Before (violates 2NF)
Enrollments:
student_id | course_id | student_name | course_name
1          | 101       | Ana          | Math

# student_name depends only on student_id (partial dependency)

# After (2NF compliant)
Students:
id | name
1  | Ana

Courses:
id  | name
101 | Math

Enrollments:
student_id | course_id
1          | 101
```

"Now student_name lives with students, where it belongs," Tian realized.

**Step 3: Third Normal Form (3NF) - No Transitive Dependencies**

Non-key attributes must depend directly on the primary key, not on other non-key attributes.

```
# Before (violates 3NF)
Residents:
id | name | barangay_id | barangay_captain
1  | Ana  | 5           | Captain Cruz

# barangay_captain depends on barangay_id, not directly on resident id (transitive)

# After (3NF compliant)
Residents:
id | name | barangay_id
1  | Ana  | 5

Barangays:
id | captain
5  | Captain Cruz
```

Tian refactored the entire schema:

**Before: One bloated table**
```sql
CREATE TABLE ApplicantData (
    id INTEGER,
    name TEXT,
    programs TEXT,  -- Comma-separated
    barangay TEXT,
    captain TEXT
);
```

**After: Normalized (3NF)**
```sql
CREATE TABLE Residents (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    barangay_id INTEGER,
    FOREIGN KEY (barangay_id) REFERENCES Barangays(id)
);

CREATE TABLE Barangays (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    captain TEXT
);

CREATE TABLE ScholarshipPrograms (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    amount REAL
);

CREATE TABLE Applications (
    id INTEGER PRIMARY KEY,
    resident_id INTEGER,
    program_id INTEGER,
    status TEXT,
    FOREIGN KEY (resident_id) REFERENCES Residents(id),
    FOREIGN KEY (program_id) REFERENCES ScholarshipPrograms(id)
);
```

Rhea Joy tested the benefits:

```sql
-- Update barangay captain once - affects all residents automatically
UPDATE Barangays SET captain = 'New Captain' WHERE id = 5;

-- No redundancy - captain stored once, not repeated for each resident
```

"This is why normalization matters," Kuya Miguel explained. "1NF makes data atomic. 2NF eliminates partial dependencies. 3NF removes transitive dependencies. The result? Clean, maintainable, consistent data."

"But what about joins?" Tian asked. "Now I need multiple queries."

"That's the trade-off," Kuya Miguel acknowledged. "Normalized data requires joins. For read-heavy systems with complex queries, sometimes controlled denormalization makes sense. But start normalized. Denormalize only when performance demands it."

The scholarship database was now properly structured:
- No duplicate data
- Easy updates (single source of truth)
- Data integrity enforced by foreign keys
- Clear relationships between entities

From chaos to clarity, one normal form at a time.

_Next up: Indexing and Performance Optimization!_ ⚡

**Next:** Quiz then exercises.