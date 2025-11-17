## Lesson 3 Exercises: Relational Building Blocks

---
### 1. Natural vs Surrogate Key (5 minutes)
List one candidate natural key for residents. Give two failure scenarios (changes, duplicates). Conclude why surrogate chosen.

| Candidate | Failure Scenario 1 | Failure Scenario 2 | Decision |
|-----------|--------------------|--------------------|----------|
| full_name | | | |

---
### 2. Unnormalized Dataset Refactor (8 minutes)
Given a CSV-like row:
```
id, full_name, barangay, scholarship1_code, scholarship1_status, scholarship2_code, scholarship2_status
```
Task: Produce two normalized tables (residents, scholarships). Write CREATE statements + one INSERT example for a resident with two scholarships.

---
### 3. Composite Key Design (6 minutes)
Propose a table using a composite key in the barangay system (other than attendance). Define columns + PRIMARY KEY clause. Justify why single surrogate insufficient.

---
### 4. Foreign Key Integrity (6 minutes)
Write 2 SQL statements: (a) Attempt to insert scholarship referencing missing resident (expect failure). (b) Insert resident then scholarship (success). Explain difference.

---
### 5. Constraint Brainstorm (5 minutes)
Suggest 3 constraints (NOT NULL, UNIQUE, CHECK) for residents and why each supports data quality.

| Constraint | Column | Purpose |
|------------|--------|---------|
| NOT NULL | full_name | |
| UNIQUE | (full_name, barangay) | |
| CHECK | birth_date | |

---
### 6. Index Idea (4 minutes)
Pick one frequent query (describe). Propose an index. Explain expected performance gain.

---
### 7. Normalization Reflection (5 minutes)
Describe an update anomaly you avoid after splitting scholarships. Provide before vs after depiction (2–3 sentences).

---
### 8. Stretch: Mini ER Diagram (Optional)
Sketch (paper or tool) entities: residents, scholarships, committees, committee_members(resident_id, committee_id, role). Label all primary and foreign keys.

---
### 9. Personal Reflection (3 minutes)
Three bullets: (a) Most confusing concept today, (b) Integrity feature you now value, (c) One question for deeper study (e.g., indexing internals).

---
**Next:** Chapter recap then move forward after reinforcing foundations.
