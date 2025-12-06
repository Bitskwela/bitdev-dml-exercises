## Background Story

The afternoon sun filtered through the dusty windows of the barangay hall as Tian and Rhea Joy sat surrounded by manila folders they'd successfully organized into neat stacks. Kuya Miguel leaned back in his chair, sipping on his third cup of barako coffee. "Now that you understand what a database is," he began, "we need to choose the right kind for your scholarship system."

Rhea Joy looked up from her notes. "Kuya, aren't all databases the same? They all just store data, right?" Miguel smiled and pulled out two different containers from his bag—a rigid compartmentalized bento box and a flexible ziplock bag. "Think of it this way: SQL databases are like this bento box. Everything has its place, structured and organized. NoSQL is like this bag—flexible, can hold different shapes, adapts to what you put in it."

Tian's eyes widened as he grasped the implication. "So for our scholarship program with fixed fields like name, age, and barangay... we'd want the structured one?" Miguel nodded approvingly. "Exactly! But what if you later wanted to store varied documents—some applications with photos, others with certificates, some with both? That's where flexibility helps."

They spent the next hour discussing trade-offs while the barangay's CCTV monitor flickered in the background. Captain Cruz peeked in, curious about their animated discussion about "ACID properties" and "horizontal scaling." By the time the sun began to set, Tian realized that choosing a database was less about right or wrong and more about matching the tool to the task. The scholarship system was taking shape, one decision at a time.

---

## Theory & Lecture Content

## 1. Overview

| Aspect | SQL (Relational) | NoSQL (Non-Relational) |
|--------|------------------|------------------------|
| Data Model | Tables (rows & columns) | Documents, key-value, wide-column, graph |
| Schema | Predefined & enforced | Flexible / dynamic (varies by type) |
| Relationships | First-class (joins, foreign keys) | Often manual or denormalized |
| Query Language | SQL standard | Varies (JSON queries, key lookups, Gremlin, etc.) |
| Transactions | Strong ACID support | Some offer ACID (e.g., MongoDB), others eventual consistency |
| Scaling | Vertical + read replicas + sharding | Horizontal, built with partitioning in mind |
| Use Cases | Structured, relational data | High-scale, flexible or specialized access patterns |

## 2. ACID vs BASE (Consistency Models)

**ACID** (Typical in SQL)
1. Atomicity – All or nothing
2. Consistency – Constraints preserved
3. Isolation – Concurrent transactions don't corrupt each other
4. Durability – Once committed, data persists

**BASE** (Some NoSQL systems)
1. Basically Available – System remains responsive
2. Soft state – State may change over time without input
3. Eventual consistency – Replicas converge eventually

Barangay analogy: ACID is like a strict cashier log—never half-updated. BASE is like a community bulletin board that syncs copies after a short delay.

## 3. Main NoSQL Categories

| Type | Structure | Example | Barangay Use |
|------|-----------|---------|--------------|
| Document | JSON-like docs | MongoDB | Citizen profiles w/ variable fields |
| Key-Value | Simple key → value | Redis | Session tokens / quick counters |
| Wide-Column | Sparse columns per row | Cassandra | Large time-series sensor logs |
| Graph | Nodes + edges | Neo4j | Relationships (residents ↔ projects) |

## 4. When SQL Shines

Use a relational database when:
1. Data is **highly structured** and predictable.
2. You need **complex joins** (e.g., applicants ↔ disbursements ↔ schools).
3. Strong **transaction guarantees** are essential (financial aid updates).
4. **Reporting & aggregations** rely on a powerful query language.

## 5. When NoSQL Shines

Prefer NoSQL when:
1. Schema evolves rapidly (e.g., optional scholarship metadata).
2. You require **massive horizontal scaling** early.
3. Access patterns are **simple key lookups / caching**.
4. You handle **heterogeneous data** (mixed nested documents).
5. You store **network relationships** (graph queries).

## 6. Example: Applicant in SQL vs Document DB

### Relational (SQL)
Tables:
- `applicants(id, full_name, age, school_id, status)`
- `schools(id, name, district)`

Retrieve applicant + school:
```sql
SELECT a.full_name, s.name AS school
FROM applicants a
JOIN schools s ON s.id = a.school_id
WHERE a.status='Approved';
```

### Document (MongoDB-style)
Single document:
```json
{
	"full_name": "Rhea Joy Santos",
	"age": 17,
	"school": { "name": "Iloilo National High", "district": "West" },
	"status": "Pending",
	"extra": { "siblings": 2, "preferred_course": "IT" }
}
```
Pros: Fewer joins. Cons: Duplication if many applicants share same school.

## 7. Denormalization (Trade-off)

In NoSQL, you often **duplicate** related data into documents for speed (denormalization). This reduces queries but increases update complexity (change school name → update many documents). In SQL, normalization avoids duplicates but requires joins.

## 8. Query Styles

### SQL Example (Aggregate):
```sql
SELECT district, COUNT(*) AS total
FROM schools s
JOIN applicants a ON a.school_id = s.id
WHERE a.status='Approved'
GROUP BY district
ORDER BY total DESC;
```

### MongoDB Aggregation Example:
```javascript
db.applicants.aggregate([
	{ $match: { status: "Approved" } },
	{ $group: { _id: "$school.district", total: { $sum: 1 } } },
	{ $sort: { total: -1 } }
]);
```

## 9. Performance Considerations

| Concern | SQL | NoSQL |
|---------|-----|-------|
| Joins | Built-in | Emulated / manual |
| Scaling | Harder horizontal (needs sharding) | Often built-in sharding |
| Consistency | Strong by default | Configurable (eventual/strong) |
| Flexibility | Stricter schema migrations | Dynamic structure |

## 10. Choosing Strategy (Decision Flow)

1. Do you need complex relational queries? → **SQL**
2. Is schema changing rapidly? → **Document NoSQL**
3. Do you need fast ephemeral caching? → **Key-Value**
4. Are relationships graph-like? → **Graph DB**
5. Are you handling analytics at scale? → **Columnar / Wide-Column**

## 11. Hybrid Reality

Most real systems combine both: SQL for core transactional data, Redis for caching, Elasticsearch for search, maybe a document store for flexible logs. Tian learns: "Hindi kailangan one-size-fits-all." Use the right tool per sub-problem.

## 12. Pitfalls & Anti-Patterns

| Mistake | Why It's Bad |
|---------|--------------|
| Forcing SQL schema onto unpredictable data | Leads to constant migrations |
| Using NoSQL for heavy multi-document joins | Manual complexity & bugs |
| Premature sharding | Adds operational overhead |
| Ignoring indexes | Slow queries |
| Over-denormalization | Painful bulk updates |

## 13. Security & Validation

Relational DBs enforce constraints (NOT NULL, UNIQUE, FOREIGN KEY). Document stores rely more on application logic or optional schema validation (e.g., MongoDB's JSON schema). Always validate at the boundary—never assume client input is clean.

## 14. Example: Mixed Stack Sketch

Barangay could use:
- PostgreSQL for applicants & schools
- Redis for caching counts (`approved_count`)
- MongoDB for flexible event logs (application status changes)

---

## Closing Story

The next morning, Tian and Rhea Joy met at the barangay hall's computer lab. Kuya Miguel had left them homework: design the database architecture for the scholarship system.

"I think we should use SQL," Tian said, drawing boxes on the whiteboard. "The scholarship data has clear relationships—applicants belong to schools, disbursements link to applicants."

Rhea Joy added another box. "But what about the event logs? Every time someone updates an application status, we want to track it flexibly. Maybe MongoDB for that part?"

Kuya Miguel walked in, coffee in hand, and smiled at the whiteboard. "Hybrid approach. Smart. SQL for your core structured data—applicants, schools, payments. NoSQL for flexible, high-volume logs."

"So we're not locked into one choice?" Rhea Joy asked.

"Never," Kuya Miguel replied. "Real systems often mix both. Use the right tool for each job."

Tian stepped back, looking at the design. Tables with foreign keys. JSON documents for logs. Redis for caching counts. It was coming together—a system that balanced structure with flexibility.

"Next, we dive deep into tables, rows, columns, and keys," Kuya Miguel said. "The foundation of relational databases."

Rhea Joy grinned. "Let's build something that actually works."

_Next up: Tables, Rows, Columns, and Keys—the building blocks of SQL!_ 🗂️

---
**Next Lesson:** [Tables, Rows, Columns, and Keys](../le_03_tables_rows_columns_keys/)

