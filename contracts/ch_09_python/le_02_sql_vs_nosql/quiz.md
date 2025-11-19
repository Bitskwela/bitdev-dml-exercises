# Lesson 2 Quiz: SQL vs NoSQL

---
# Quiz 1
## Scenario: Barangay System Design
Tian proposes using a single database type for every feature in their future portal. Help him evaluate choices.

**Question 1:** Which is MOST characteristic of a relational (SQL) database?
A. Schema-less storage of arbitrary nested JSON
B. Built-in joins and foreign key relationships
C. Direct key-only access without data modeling
D. Graph edges are first-class primitives

**Question 2:** Which application scenario fits a document store better than pure relational?
A. Highly structured payroll ledger
B. Rapidly evolving resident profile with optional fields
C. Fixed attendance records with uniform columns
D. Heavily relational school fee settlement

**Question 3:** Which statement about ACID is TRUE?
A. Atomicity means partial commits are allowed
B. Consistency ensures data rules remain valid after transactions
C. Isolation allows dirty reads by default
D. Durability means changes disappear after a restart

**Question 4:** BASE systems emphasize:
A. Guaranteed immediate global consistency
B. Eventual consistency with availability focus
C. Preventing any stale reads ever
D. Eliminating the need for replication

**Question 5:** Which pairing is MOST appropriate?
A. Redis → complex multi table joins
B. PostgreSQL → normalized scholarship + school schema
C. MongoDB → simple ephemeral counter storage only
D. Neo4j → flat, single column numeric logs

---
# Quiz 2
## Scenario: Multi-Database Architecture
Barangay tech committee plans a stack. Match components to rationale.

**Question 6:** Why add Redis beside PostgreSQL?
A. For strict relational integrity
B. For denormalizing all tables automatically
C. For fast caching of frequently requested counts
D. To store large binary PDFs

**Question 7:** Denormalization usually:
A. Removes need for all indexes
B. Duplicates data to reduce read-time joins
C. Guarantees stronger foreign key enforcement
D. Eliminates update complexity

**Question 8:** Best choice for modeling relationships like residents ↔ committees ↔ projects?
A. Key-value store
B. Graph database
C. Columnar analytics DB
D. Flat CSV file

**Question 9:** Primary drawback of excessive denormalization?
A. Harder writes when shared data changes
B. Slower reads for single document fetches
C. Loss of all referential integrity in SQL automatically
D. Impossible to shard horizontally

**Question 10:** Which is a valid reason to start with SQL first?
A. Guarantees infinite horizontal scale without planning
B. Lower operational complexity with structured predictable schema
C. Automatically converts images to tables
D. Eliminates need to plan indexes

---
## Answers
1: B  
2: B  
3: B  
4: B  
5: B  
6: C  
7: B  
8: B  
9: A  
10: B  

---
## Detailed Explanations
**Q1:** Relational DBs excel at joins + foreign keys.  
**Q2:** Document store handles variable optional fields gracefully.  
**Q3:** Consistency keeps constraints valid post-transaction.  
**Q4:** BASE emphasizes eventual consistency.  
**Q5:** PostgreSQL well-suited for normalized structures.  
**Q6:** Redis caches computed values to improve response time.  
**Q7:** Denormalization duplicates related data for faster reads.  
**Q8:** Graph DBs model complex relationships efficiently.  
**Q9:** Changing shared data means updating many copies.  
**Q10:** Structured schema lowers ambiguity + simplifies early design.  

---
**Next:** Proceed to Lesson 3 on tables, rows, columns, and keys.

