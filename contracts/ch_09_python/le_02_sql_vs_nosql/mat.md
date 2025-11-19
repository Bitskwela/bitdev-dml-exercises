# Lesson 2: SQL vs NoSQL

## Story: Picking the Right Treasure Chest

Tian and Rhea Joy are now encoding the barangay's scholarship applicant data. "Kuya Miguel," Tian asks, "should we just use any database? Ano ba difference ng SQL at NoSQL?"

Kuya Miguel smiles: "Choosing a database is like choosing the right treasure chest. Some are rigid and compartmentalized; others are flexible and let the shape of the treasure vary. Let's compare."

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

## 15. Reflection Dialogue

"So if I need strict relationships, SQL; if flexibility, NoSQL?" Rhea Joy clarifies.
"Yes," Kuya Miguel nods. "Start with relational unless a clear flexibility or scale reason pushes you toward NoSQL."

## 16. Quick Practice Prompts

1. Pick one dataset you handle—would you choose SQL or NoSQL? Why?
2. Identify a place where denormalization could help—what's the trade-off?
3. Describe one hybrid design for a future barangay portal.

---
**Next Lesson:** [Tables, Rows, Columns, and Keys](../le_03_tables_rows_columns_keys/)

