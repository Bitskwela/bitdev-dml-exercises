# Database Fundamentals Activity

Now that you understand what databases are and why they matter for organizing data, let's practice identifying database needs and designing basic queries for real-world scenarios.

## Your Community Database Analysis

Think about the data challenges in your own school, barangay, or community. Databases can solve many organizational problems when properly applied.

### Task 1: Identify Database Opportunities

List **3 pain points** in your own school or community that a database could solve.

Examples to inspire you:
- Student enrollment records scattered across paper forms
- Barangay resident information stored in Excel sheets
- Event attendance tracked manually
- Library book lending recorded in notebooks
- Health records filed in cabinets

**Your Answer:**
1. _[Write your first pain point here]_
2. _[Write your second pain point here]_
3. _[Write your third pain point here]_

---

### Task 2: Choose the Right Database Type

For each of the 3 pain points you identified above, categorize what type of database would work best:

- **Relational (SQL):** Structured data with clear relationships (students ↔ courses, residents ↔ barangays)
- **Document (NoSQL):** Flexible JSON-like data that may evolve over time
- **Key-Value:** Simple fast lookups (session data, caching)

**Your Analysis:**
1. Pain point #1 needs: _[relational / document / key-value]_ because _[explain why]_
2. Pain point #2 needs: _[relational / document / key-value]_ because _[explain why]_
3. Pain point #3 needs: _[relational / document / key-value]_ because _[explain why]_

---

### Task 3: Design a Basic Query

Write **one SQL query** that you *think* would answer a real question for one of your identified scenarios.

Example: "How many approved scholarship applicants are from Barangay San Roque?"

```sql
SELECT COUNT(*) 
FROM applicants 
WHERE status='Approved' AND barangay='San Roque';
```

**Your Query:**

Question you want to answer: _[Write your question here]_

```sql
-- Write your SQL query here
-- Don't worry about perfect syntax - focus on the logic!


```

---

## Reflection Questions

Answer these to deepen your understanding:

1. **What's the biggest advantage of using a database instead of spreadsheets for your identified scenarios?**
   
   _[Your answer here]_

2. **What challenges might you face when transitioning from manual/paper systems to a database?**
   
   _[Your answer here]_

3. **Why is structure important when organizing data?**
   
   _[Your answer here]_

---

## What You've Learned

Through this activity, you've practiced:
- Identifying real-world problems that databases solve
- Matching database types to use cases
- Thinking about data queries conceptually

<details>
<summary><strong> Answer Key</strong></summary>

### Task 1: Pain Points
**Example scenarios:**
1. **Scholarship tracking** - Excel sheets with duplicate applicant data, no way to prevent multiple submissions
2. **Resident records** - Paper forms lost or damaged, no search capability
3. **Event attendance** - Manual counting, errors in tallies

**Pain points:**
- Data duplication and inconsistency
- No concurrent access (only one person can edit at a time)
- Difficult to query/analyze ("How many residents aged 18-25?")
- No data validation (typos, invalid ages)
- Risk of data loss

### Task 2: Database Type Selection
**Recommendation: SQL (Relational Database)**

**Reasons:**
- Structured data with clear relationships (applicants ↔ scholarships)
- Need ACID transactions (awards must be accurate)
- Complex queries needed (JOINs, aggregations)
- Data integrity critical (foreign keys, constraints)

**When to use NoSQL:** Unstructured documents (PDFs), high write volume (logs), flexible schema needs

### Task 3: SQL Queries
```sql
-- All applicants from Barangay San Jose
SELECT * FROM applicants 
WHERE barangay = 'San Jose';

-- Count approved by barangay
SELECT barangay, COUNT(*) AS approved_count
FROM applicants
WHERE status = 'Approved'
GROUP BY barangay;

-- Average age of applicants
SELECT AVG(age) AS avg_age
FROM applicants;
```

### Reflection Answers
1. **Biggest advantage:** Database enforces data integrity (no duplicate entries, consistent format) and enables powerful queries
2. **Challenges:** Training staff, data migration from old system, initial setup time
3. **Why structure matters:** Structured data can be validated, queried efficiently, and relationships maintained automatically

</details>
- Understanding the value of structured data

Next, you'll learn the differences between SQL and NoSQL databases in detail!
