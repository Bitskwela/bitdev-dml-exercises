# Lesson 3 Quiz: Tables, Rows, Columns, Keys

---
# Quiz 1
## Scenario: Schema Draft Review
Tian proposes a single table with many repeating scholarship columns. Evaluate alternatives.

**Question 1:** A PRIMARY KEY guarantees:
A. Fastest possible read speed
B. Column cannot be NULL
C. Row-level uniqueness
D. Automatic encryption

**Answer:** C  
**Explanation:** PRIMARY KEY ensures uniqueness of each row.

---

**Question 2:** Best reason to split scholarship data into a separate table:
A. Fewer tables look cleaner
B. Avoid update anomalies on repeating columns
C. Improve binary storage
D. Enable auto-encryption of values

**Answer:** B  
**Explanation:** Separate table avoids redundancy/update anomalies.

---

**Question 3:** Which is a foreign key?
A. An indexed text column
B. A column referencing a primary key in another table
C. Any non-null column
D. A composite of two numeric fields

**Answer:** B  
**Explanation:** Foreign key references a primary key elsewhere.

---

**Question 4:** Composite key appropriate when:
A. Single column already unique
B. Uniqueness requires combined columns
C. You want faster writes
D. You need encryption

**Answer:** B  
**Explanation:** Composite key used when combination defines uniqueness.

---

**Question 5:** Normalization mainly aims to:
A. Increase redundancy
B. Reduce redundancy and anomalies
C. Disable constraints
D. Remove all joins

**Answer:** B  
**Explanation:** Normalization reduces redundancy, avoids anomalies.

---
# Quiz 2
## Scenario: Barangay Integrity Audit
Rhea Joy inspects the schema for integrity and performance.

**Question 6:** Which anomaly arises from storing multiple scholarship columns in residents table?
A. Insert anomaly for new scholarship type
B. Encryption anomaly
C. Transaction anomaly
D. Atomicity anomaly

**Answer:** A  
**Explanation:** New scholarship requires schema change → insert anomaly.

---

**Question 7:** A good surrogate key choice:
A. Resident full name
B. Auto-increment integer
C. Barangay name
D. Concatenated address string

**Answer:** B  
**Explanation:** Surrogate auto-increment is stable and simple.

---

**Question 8:** Foreign keys mainly enforce:
A. Performance tuning
B. Referential integrity
C. Automatic indexing of all columns
D. Encryption at rest

**Answer:** B  
**Explanation:** Foreign keys protect referential integrity.

---

**Question 9:** Which table design violates 1NF?
A. attendance(resident_id, event_date)
B. residents(id, tags ARRAY)
C. scholarships(scholarship_id, status)
D. committees(committee_id, name)

**Answer:** B  
**Explanation:** ARRAY tags violate atomic (1NF) if multiple values stored in one column.

---

**Question 10:** Index creation early helps:
A. Always speed every write
B. Speed targeted read filters
C. Remove need for primary keys
D. Eliminate foreign key checks

**Answer:** B  
**Explanation:** Index speeds selective read queries.  

---
**Next:** Proceed to Lesson 3 exercises.
