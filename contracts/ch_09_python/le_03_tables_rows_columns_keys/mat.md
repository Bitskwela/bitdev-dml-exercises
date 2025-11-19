## Lesson 3: Tables, Rows, Columns, and Keys

Story: The barangay information system blueprint grows. Tian sketches boxes and lines; Rhea Joy asks, “Why not just one giant sheet?” Today they formalize relational building blocks.

### 1. Core Definitions
- Table: Structured set of rows (entities of one type).
- Row (Record): One instance (e.g., a single resident).
- Column (Field): Attribute with a defined data type.
- Schema: The design (tables + columns + constraints).

### 2. Data Types (Brief)
Common PostgreSQL examples:
| Type | Example | Use |
|------|---------|-----|
| INTEGER | 42 | counts, IDs |
| TEXT | 'Sto. Niño' | names, descriptions |
| DATE | '2025-11-16' | birth, event dates |
| BOOLEAN | TRUE | flags |
| DECIMAL(10,2) | 1234.56 | money |

### 3. Primary Keys
Uniquely identify each row. Prefer surrogate (AUTO INCREMENT) when natural key is unstable.
```sql
CREATE TABLE residents (
	id SERIAL PRIMARY KEY,
	full_name TEXT NOT NULL,
	birth_date DATE,
	barangay TEXT NOT NULL
);
```

### 4. Foreign Keys
Relate rows across tables.
```sql
CREATE TABLE scholarships (
	scholarship_id SERIAL PRIMARY KEY,
	resident_id INT REFERENCES residents(id),
	program_code TEXT NOT NULL,
	status TEXT NOT NULL
);
```
Ensures referenced resident exists (referential integrity).

### 5. Composite Keys
When uniqueness depends on multiple columns.
```sql
CREATE TABLE attendance (
	resident_id INT REFERENCES residents(id),
	event_date DATE NOT NULL,
	PRIMARY KEY (resident_id, event_date)
);
```

### 6. Unique & Not Null Constraints
```sql
ALTER TABLE residents ADD CONSTRAINT uq_resident_name_barangay UNIQUE(full_name, barangay);
```
Prevents duplicate names per barangay (illustrative only—might not use in real life).

### 7. Index (Preview)
Accelerates lookups; detailed treatment in a later lesson.
```sql
CREATE INDEX idx_scholarship_status ON scholarships(status);
```

### 8. Normalization (Preview)
- 1NF: Atomic column values.
- 2NF: No partial dependency on part of a composite key.
- 3NF: No transitive dependency (non-key depends only on key).
Goal: Reduce redundancy; maintain integrity.

### 9. Bad Design Smell Example
Single table mixing unrelated repeating groups:
```text
Residents(id, full_name, barangay, scholarship1_code, scholarship1_status, scholarship2_code, ...)
```
Issues: Hard to scale; duplicates; update anomalies.

### 10. Refactored Structure
Split scholarships to its own table with FK; eliminates repeated columns.

### 11. Designing a Minimal Schema
Draw (on paper) three tables: residents, scholarships, committees.
Note: Where do relationships form? Which keys? Which columns might need constraints?

### 12. Story Thread
Rhea Joy drafts an ER diagram; Tian labels keys with stars. They debate natural vs generated IDs—generated wins for simplicity.

### 13. Practice Prompts
1. Pick natural key candidate for residents (why it fails).  
2. Convert a repeating attribute set into a new table.  
3. Add a composite key somewhere meaningful.  
4. Suggest one index to support a frequent query.  

### 14. Reflection
List two integrity protections offered by foreign keys; one trade‑off (write overhead).

**Next:** Quiz + exercises to reinforce relational fundamentals.
