# Tables, Rows, Columns, and Keys Activity

Now that you understand the structure of relational databases, let's practice designing tables with proper keys and relationships.

## Database Design Challenge

Good database design starts with understanding how to organize data into tables and link them with appropriate keys.

### Task 1: Natural Key Analysis

Pick a **natural key candidate** for a `residents` table (e.g., full name, email, phone number).

**Your candidate natural key:** _[e.g., full_name, email, etc.]_

**Why does it fail as a primary key?**

Consider:
- Is it truly unique?
- Can it change over time?
- Is it always present?
- Is it too complex?

_[Your explanation here]_

**Better alternative:** _[e.g., auto-incrementing ID]_ because _[reasoning]_

---

### Task 2: Normalization Exercise

Convert a **repeating attribute set** into a proper separate table with foreign key relationship.

**Before (Bad Design):**
```sql
Applicant: id | name | skill_1 | skill_2 | skill_3 | ...
```

**After (Good Design):**
Draw or describe the normalized structure:

```
Table 1: Applicants
- Fields: _[list the columns]_
- Primary Key: _[which column?]_

Table 2: _[Table name]_
- Fields: _[list the columns]_
- Primary Key: _[which column?]_
- Foreign Key: _[references which table?]_
```

**Why is this better?**
_[Your explanation]_

---

### Task 3: Composite Key Design

Add a **composite key** somewhere meaningful in a barangay-related system.

**Scenario Example:**
An attendance table where uniqueness requires both `resident_id` AND `event_date` (a resident can only attend an event once, but can attend multiple events).

**Your Scenario:**

**Table Name:** _[Your table name]_

**Composite Primary Key:** `(_[column1]_, _[column2]_)`

**Why does uniqueness require both columns?**
_[Your explanation]_

**Example data** showing why single column wouldn't work:
```
Row 1: _[sample data]_
Row 2: _[sample data showing need for composite]_
```

---

### Task 4: Index Recommendation

Suggest **one index** to support a frequent query.

**Common Query:**
Describe a query that would run frequently:
_[e.g., "Find all residents from a specific barangay"]_

**Recommended Index:**
```sql
CREATE INDEX _[index_name]_ ON _[table]_(_[column]_);
```

**Why this helps:**
_[Explain how it improves query performance]_

**What's the trade-off?**
_[e.g., slower inserts/updates, storage overhead]_

---

## Reflection Questions

1. **List two integrity protections offered by foreign keys:**
   
   Protection 1: _[e.g., prevents orphaned records]_
   
   Protection 2: _[e.g., ensures referential integrity]_

2. **What's one trade-off of using foreign keys?**
   
   _[e.g., write overhead, cascade complexity]_

3. **Why use surrogate keys (auto-incrementing IDs) instead of natural keys?**
   
   _[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Evaluating natural vs surrogate keys
- Normalizing repeating attributes into separate tables
- Designing composite keys for uniqueness
- Understanding indexes and their trade-offs
- Recognizing foreign key constraints

Next, you'll learn Python data structures: lists, tuples, and dictionaries!

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: Natural vs Surrogate Key

**Natural key (email):**
```sql
CREATE TABLE applicants (
    email TEXT PRIMARY KEY,
    name TEXT,
    age INTEGER
);
```
**Pros:** Meaningful, already unique
**Cons:** Can't change email, longer key for JOINs, privacy concerns

**Surrogate key (ID):**
```sql
CREATE TABLE applicants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE NOT NULL,
    name TEXT,
    age INTEGER
);
```
**Pros:** Immutable, short/fast, abstracted from business logic
**Cons:** Extra column, meaningless number

**Recommendation:** **Surrogate key** - More flexible, better performance

### Task 2: Normalize Barangay Data

**Before (denormalized):**
```sql
applicants (id, name, age, barangay_name, barangay_captain, barangay_contact)
```
**Problem:** Barangay info duplicated for each applicant

**After (normalized):**
```sql
CREATE TABLE barangays (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE,
    captain TEXT,
    contact TEXT
);

CREATE TABLE applicants (
    id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER,
    barangay_id INTEGER,
    FOREIGN KEY (barangay_id) REFERENCES barangays(id)
);
```
**Benefits:** Update captain once, no duplication, data integrity

### Task 3: Composite Key

**Table:** application_documents
```sql
CREATE TABLE application_documents (
    application_id INTEGER,
    document_type TEXT,
    file_path TEXT,
    PRIMARY KEY (application_id, document_type),
    FOREIGN KEY (application_id) REFERENCES applications(id)
);
```
**Why composite:** Each application can have multiple document types, but only ONE of each type

**Example data:**
```
application_id | document_type | file_path
1             | transcript    | /docs/1_trans.pdf
1             | id_copy      | /docs/1_id.pdf
```

### Task 4: Index Strategy

**Query:** "Find all pending applications"
```sql
CREATE INDEX idx_applications_status ON applications(status);
```
**Why:** Status is frequently filtered, index speeds up WHERE clause
**Trade-off:** Faster reads, slower writes, storage overhead

### Reflection Answers
1. **Foreign key protections:**
   - Prevents orphaned records (can't delete barangay with existing applicants)
   - Ensures valid references (can't insert invalid barangay_id)
2. **Trade-off:** Foreign keys add overhead on INSERT/DELETE operations

</details>
