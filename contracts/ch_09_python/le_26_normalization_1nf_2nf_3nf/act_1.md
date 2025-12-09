# Normalization (1NF, 2NF, 3NF) Activity

Practice normalizing database schemas.

### Task 1: Convert to 1NF
**Unnormalized table:**
```
Applicant
---------
id | name    | skills
1  | Ana     | Python, SQL, Flask
2  | Ben     | JavaScript, React
```

**Your solution:**
```
Applicant table:


ApplicantSkills table:

```

### Task 2: Identify Partial Dependency (2NF)
**Table with composite key:**
```
Application (applicant_id, scholarship_id, applicant_name, scholarship_amount, submission_date)
```

**Problem:** 
**Solution (split into tables):**

### Task 3: Identify Transitive Dependency (3NF)
```
Applicant (id, name, barangay_id, barangay_name, barangay_captain)
```

**Problem:** 
**Solution:**

### Task 4: Denormalization Trade-off
**Scenario:** Dashboard shows applicant count per scholarship (frequent query)

**Option A:** JOIN Application + Scholarship each time
**Option B:** Store count in Scholarship table

**Your choice and justification:**

## Reflection
**Two real-world problems solved by 3NF:**
1. _[Update anomalies eliminated]_
2. _[Data redundancy reduced]_

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: 1NF (Atomic Values)
```sql
-- Normalized tables
CREATE TABLE Applicant (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE ApplicantSkills (
    applicant_id INTEGER,
    skill TEXT,
    PRIMARY KEY (applicant_id, skill),
    FOREIGN KEY (applicant_id) REFERENCES Applicant(id)
);

-- Data
Applicant: (1, 'Ana'), (2, 'Ben')
ApplicantSkills: (1, 'Python'), (1, 'SQL'), (1, 'Flask'), (2, 'JavaScript'), (2, 'React')
```

### Task 2: 2NF (No Partial Dependencies)
**Problem:** applicant_name depends only on applicant_id, scholarship_amount only on scholarship_id

```sql
CREATE TABLE Applicant (
    applicant_id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE Scholarship (
    scholarship_id INTEGER PRIMARY KEY,
    amount INTEGER
);

CREATE TABLE Application (
    applicant_id INTEGER,
    scholarship_id INTEGER,
    submission_date DATE,
    PRIMARY KEY (applicant_id, scholarship_id),
    FOREIGN KEY (applicant_id) REFERENCES Applicant(applicant_id),
    FOREIGN KEY (scholarship_id) REFERENCES Scholarship(scholarship_id)
);
```

### Task 3: 3NF (No Transitive Dependencies)
**Problem:** barangay_name and barangay_captain depend on barangay_id, not directly on applicant id

```sql
CREATE TABLE Barangay (
    barangay_id INTEGER PRIMARY KEY,
    name TEXT,
    captain TEXT
);

CREATE TABLE Applicant (
    id INTEGER PRIMARY KEY,
    name TEXT,
    barangay_id INTEGER,
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id)
);
```

### Task 4: Denormalization Trade-off
**Recommendation:** Store computed count for read-heavy dashboards

```sql
-- Add computed column
ALTER TABLE Scholarship ADD COLUMN applicant_count INTEGER DEFAULT 0;

-- Update with trigger
CREATE TRIGGER update_count AFTER INSERT ON Application
BEGIN
    UPDATE Scholarship 
    SET applicant_count = applicant_count + 1
    WHERE scholarship_id = NEW.scholarship_id;
END;
```

**Trade-off:** Faster reads (no JOIN), but writes slower (trigger) and risk of inconsistency. Worth it if reads >> writes.

**Reflection:** 3NF solves: (1) Update anomalies (change captain once in Barangay table), (2) Deletion anomalies (delete applicant doesn't lose barangay info), (3) Insertion anomalies (add barangay before any applicant), (4) Storage efficiency (no repeated data)

</details>
