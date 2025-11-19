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

**Question 2:** Best reason to split scholarship data into a separate table:
A. Fewer tables look cleaner
B. Avoid update anomalies on repeating columns
C. Improve binary storage
D. Enable auto-encryption of values

**Question 3:** Which is a foreign key?
A. An indexed text column
B. A column referencing a primary key in another table
C. Any non-null column
D. A composite of two numeric fields

**Question 4:** Composite key appropriate when:
A. Single column already unique
B. Uniqueness requires combined columns
C. You want faster writes
D. You need encryption

**Question 5:** Normalization mainly aims to:
A. Increase redundancy
B. Reduce redundancy and anomalies
C. Disable constraints
D. Remove all joins

---
# Quiz 2
## Scenario: Barangay Integrity Audit
Rhea Joy inspects the schema for integrity and performance.

**Question 6:** Which anomaly arises from storing multiple scholarship columns in residents table?
A. Insert anomaly for new scholarship type
B. Encryption anomaly
C. Transaction anomaly
D. Atomicity anomaly

**Question 7:** A good surrogate key choice:
A. Resident full name
B. Auto-increment integer
C. Barangay name
D. Concatenated address string

**Question 8:** Foreign keys mainly enforce:
A. Performance tuning
B. Referential integrity
C. Automatic indexing of all columns
D. Encryption at rest

**Question 9:** Which table design violates 1NF?
A. attendance(resident_id, event_date)
B. residents(id, tags ARRAY)
C. scholarships(scholarship_id, status)
D. committees(committee_id, name)

**Question 10:** Index creation early helps:
A. Always speed every write
B. Speed targeted read filters
C. Remove need for primary keys
D. Eliminate foreign key checks

---
## Answers
1: C  
2: B  
3: B  
4: B  
5: B  
6: A  
7: B  
8: B  
9: B  
10: B  

---
## Detailed Explanations
**Q1:** PRIMARY KEY ensures uniqueness of each row.  
**Q2:** Separate table avoids redundancy/update anomalies.  
**Q3:** Foreign key references a primary key elsewhere.  
**Q4:** Composite key used when combination defines uniqueness.  
**Q5:** Normalization reduces redundancy, avoids anomalies.  
**Q6:** New scholarship requires schema change → insert anomaly.  
**Q7:** Surrogate auto-increment is stable and simple.  
**Q8:** Foreign keys protect referential integrity.  
**Q9:** ARRAY tags violate atomic (1NF) if multiple values stored in one column.  
**Q10:** Index speeds selective read queries.  

---
**Next:** Proceed to Lesson 3 exercises.
