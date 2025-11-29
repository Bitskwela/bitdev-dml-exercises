## Background Story

It was a humid Saturday morning when Tian spread out a large sheet of paper across the barangay hall's meeting table. He'd been sketching the database design for their scholarship system, drawing boxes connected by lines. Rhea Joy arrived with breakfast—pandesal and instant coffee—and immediately questioned his elaborate diagram. "Kuya Tian, bakit ang complicated? Why can't we just put everything in one big Excel sheet like before?"

Tian paused, marker in hand, suddenly unsure. That's when Kuya Miguel walked in, fresh from his morning jog. He glanced at Tian's sketch and grinned. "Good question, Rhea Joy. Look at it this way: if you put all resident info, scholarship details, and barangay data in one massive sheet, you'd be repeating the barangay name hundreds of times. Imagine updating 'Barangay San Roque' if they change the spelling—you'd have to find and replace hundreds of cells!"

Rhea Joy's eyes lit up with understanding. "Ah! So we separate them into different tables?" Miguel nodded enthusiastically. "Exactly! One table for residents, one for barangays, one for scholarship applications. Connect them using keys—like ID numbers. Each row is one person, each column is one piece of information about them."

Tian quickly added labels to his diagram: "Primary Key," "Foreign Key," "Residents Table." As tricycles honked outside and neighbors chatted by the sari-sari store, the three of them refined the blueprint. By noon, they had a solid schema design—tables with clear purposes, rows representing real people, columns capturing specific attributes, and keys linking everything together. The scholarship database was becoming real, one table at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

Tian and Rhea Joy sat at the barangay hall's long table, surrounded by whiteboards covered in table diagrams. Stars marked primary keys. Arrows showed foreign key relationships. It looked like a treasure map—and in a way, it was.

"So every table needs a primary key," Rhea Joy confirmed, tapping her pen on the `applicants` table diagram. "That's how we uniquely identify each row."

"And foreign keys connect the tables," Tian added, drawing another arrow from `scholarships.applicant_id` to `applicants.id`. "That's how we know which scholarship belongs to which student."

Kuya Miguel leaned over their work, nodding with approval. "You've got it. These relationships—this structure—this is what makes relational databases powerful. Every piece of data has its place, and everything connects logically."

"What about composite keys?" Rhea Joy asked, pointing to their notes.

"Use them when a single column isn't enough to be unique," Kuya Miguel explained. "Like a class schedule—you need both `day` and `time_slot` to uniquely identify a period."

Tian saved their diagram as a photo. Tomorrow, they'd start translating these boxes and arrows into actual SQL CREATE TABLE statements. But tonight, they understood something fundamental: **data isn't just stored—it's organized with purpose, connected with meaning, and protected with keys.**

"Next lesson, we dive into Python data structures," Kuya Miguel said. "Lists, tuples, dictionaries—the building blocks before we connect Python to our database."

Rhea Joy closed her notebook with satisfaction. "From theory to code. Let's do this."

_Next up: Lists, Tuples, and Dictionaries—Python's data structures!_ 🐍

**Next:** Quiz + exercises to reinforce relational fundamentals.
