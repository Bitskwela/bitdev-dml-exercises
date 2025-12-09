# Lesson 1 Quiz: What is a Database?

---
# Quiz 1
## Scenario: Barangay Scholarship Chaos
Tian and Rhea Joy are converting a manual scholarship tracking process into a digital system. Answer the following to guide their decisions.

**Question 1:** Which statement BEST defines a database?
A. A plain text file storing lines of information
B. An organized collection of structured data enabling efficient queries and updates
C. A Python list containing dictionaries
D. A folder full of spreadsheets

**Answer:** B  
**Explanation:** Databases enforce structure + efficient access; files do not.

---

**Question 2:** Which problem is solved MOST directly by using a relational database instead of a shared spreadsheet?
A. Making the interface look prettier
B. Preventing duplicate applicant IDs via constraints
C. Rendering animated charts automatically
D. Eliminating the need for user training

**Answer:** B  
**Explanation:** Constraints (PRIMARY KEY) block duplicates—spreadsheets lack enforced rules.

---

**Question 3:** Which operation corresponds to updating the status of one applicant from 'Pending' to 'Approved'?
A. CREATE
B. READ
C. UPDATE
D. DELETE

**Answer:** C  
**Explanation:** UPDATE modifies existing rows.

---

**Question 4:** Which situation does NOT yet justify using a full database system?
A. 10 records, single user, no concurrent edits
B. Need transaction safety for multi‑step updates
C. Multiple staff editing at same time
D. Thousands of records with complex filtering

**Answer:** A  
**Explanation:** Small one‑user prototypes can stay in simple files.

---

**Question 5:** What does an index primarily improve?
A. Write speed only
B. Data encryption strength
C. Read/query performance on filtered searches
D. Ability to store images

**Answer:** C  
**Explanation:** Indexes accelerate filtered lookups.

---
# Quiz 2
## Scenario: Choosing Tools
Tian lists possible technologies. Match the tool or concept to the correct need.

**Question 6:** A key‑value store like Redis is BEST for:
A. Large relational joins
B. Fast caching of session tokens
C. Complex graph traversal
D. Long‑term archival of PDFs

**Answer:** B  
**Explanation:** Key‑value stores excel at rapid simple lookups (caching).

---

**Question 7:** Which query counts all approved applicants grouped by school?
A. `SELECT * FROM applicants WHERE status='Approved';`
B. `SELECT school, COUNT(*) FROM applicants WHERE status='Approved' GROUP BY school;`
C. `UPDATE applicants SET status='Approved';`
D. `DELETE FROM applicants WHERE status='Approved';`

**Answer:** B  
**Explanation:** Aggregation + grouping query pattern.

---

**Question 8:** Which feature ensures that either all steps of a multi‑update succeed or none do?
A. Index
B. Foreign key
C. Transaction
D. View

**Answer:** C  
**Explanation:** Transactions guarantee atomicity.

---

**Question 9:** Which database type fits data whose structure evolves frequently (fields appear/disappear)?
A. Graph DB
B. Relational SQL
C. Document store (e.g., MongoDB)
D. Columnar analytics DB

**Answer:** C  
**Explanation:** Document databases allow flexible schemas.

---

**Question 10:** In the barangay analogy, a single folder with an applicant's info maps to what?
A. Column
B. Record (row)
C. Table
D. Index

**Answer:** B  
**Explanation:** A row stores one entity instance.

---
**Next:** Proceed to Lesson 2 to compare SQL vs NoSQL.

