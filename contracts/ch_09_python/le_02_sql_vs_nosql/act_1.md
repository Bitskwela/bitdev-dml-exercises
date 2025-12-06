# SQL vs NoSQL Activity

Now that you understand the differences between SQL and NoSQL databases, let's practice choosing the right database type for real scenarios and understanding trade-offs.

## Database Selection Challenge

Making the right database choice impacts your system's scalability, maintainability, and performance.

### Task 1: Choose Your Database

Pick **one dataset** you currently handle (or would like to handle) - this could be from school, work, personal projects, or community activities.

**Describe your dataset:**
- What type of data? (student records, event logs, inventory, etc.)
- How much data? (tens, hundreds, thousands of records?)
- What operations? (mostly reading, mostly writing, both?)

_[Your dataset description here]_

**Would you choose SQL or NoSQL? Why?**

Consider:
- Is the schema fixed or evolving?
- Do you need complex joins and relationships?
- Is horizontal scaling important?
- What are your consistency requirements?

_[Your choice and reasoning here]_

---

### Task 2: Denormalization Trade-offs

Identify **one place** where denormalization (duplicating data) could help improve query performance.

**Scenario Example:**
In a scholarship system, instead of joining `applicants` and `schools` tables every time, you could store the school name directly in each applicant record.

**Your Scenario:**

What data would you denormalize? _[Describe the duplication]_

**What's the benefit?**
_[e.g., faster queries, fewer joins]_

**What's the trade-off?**
_[e.g., update complexity, storage overhead, potential inconsistency]_

**Is it worth it for your use case?**
_[Yes/No and explain why]_

---

### Task 3: Hybrid Architecture Design

Describe **one hybrid design** for a future barangay portal that combines both SQL and NoSQL.

**Example Hybrid Design:**
- PostgreSQL for core transactional data (residents, applications)
- Redis for caching frequently accessed queries
- MongoDB for flexible event logs

**Your Hybrid Design:**

**Component 1:** _[Database type]_ for _[what purpose]_
Why this choice? _[reasoning]_

**Component 2:** _[Database type]_ for _[what purpose]_  
Why this choice? _[reasoning]_

**Component 3 (optional):** _[Database type]_ for _[what purpose]_
Why this choice? _[reasoning]_

**How do they work together?**
_[Explain the data flow and integration]_

---

## Reflection Questions

1. **What's the most important factor when choosing between SQL and NoSQL?**
   
   _[Your answer here]_

2. **Can you think of a situation where the "wrong" database choice would cause serious problems?**
   
   _[Your answer here]_

3. **Why might a hybrid approach be better than picking just one database type?**
   
   _[Your answer here]_

---

## What You've Learned

Through this activity, you've practiced:
- Evaluating database choices for specific use cases
- Understanding denormalization trade-offs
- Designing hybrid database architectures

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: Database Type Selection

**Scenario A: Scholarship Applications**
**Choice: SQL (PostgreSQL)**
- Structured relationships (applicant → applications → scholarships)
- ACID compliance for financial data
- Complex JOINs for reports

**Scenario B: Activity Logs**
**Choice: NoSQL (MongoDB)**
- High write volume
- Semi-structured data
- Time-series queries

### Task 2: Denormalization Example
```json
{
  "_id": "app_001",
  "applicant": {
    "name": "Ana Cruz",
    "age": 20,
    "barangay": "San Jose"
  },
  "scholarship": {
    "name": "Academic Excellence",
    "amount": 10000
  },
  "status": "approved"
}
```
**Trade-off:** Fast reads (no JOINs), but updating scholarship amount requires updating all documents

### Task 3: Hybrid Architecture
**Component 1:** PostgreSQL for core transactional data (applicants, scholarships, awards)
- ACID guarantees
- Relational integrity

**Component 2:** MongoDB for document storage (application essays, recommendation letters)
- Flexible schema
- File metadata

**Component 3:** Redis for session caching
- Fast in-memory access
- Reduces database load

**Data flow:** PostgreSQL holds master data → MongoDB stores documents with reference IDs → Redis caches frequent queries

### Reflection Answers
1. **Most important factor:** Data structure and query patterns (structured+relationships=SQL, flexible+high-write=NoSQL)
2. **Wrong choice problems:** Using NoSQL for financial transactions could lose ACID guarantees; using SQL for logs could bottleneck writes
3. **Hybrid benefits:** Leverage strengths of each database type for appropriate use cases

</details>
- Thinking strategically about data storage

Next, you'll dive deep into tables, rows, columns, and keys - the building blocks of relational databases!
