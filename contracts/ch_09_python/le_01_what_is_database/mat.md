# Lesson 1: What is a Database?

## Story: Tian, Rhea Joy, and the Missing Scholarship Records

The afternoon sun hit the barangay hall windows. Tian and Rhea Joy were helping organize the youth scholarship applications. Papers were everywhere—folders half‑open, yellowing logbooks, screenshots printed from old emails.

"Kuya, bakit ganito kalat?" Rhea Joy whispered.

Tian sighed: "We keep losing track of who submitted requirements. Every time we need totals, we manually count again. It's slow, error‑prone, and exhausting. There must be a better way."

Kuya Miguel entered carrying a laptop. "There is. You need a *database*. Think of it like a secure, organized data treasure chest. Instead of scattered papers, everything becomes structured, searchable, and reliable."

## 1. Definition

**A database is an organized collection of data stored so it can be easily accessed, managed, updated, and queried.** It is more than files on a disk—it enforces structure and offers powerful retrieval.

| Concept | Analogy | Example |
|---------|---------|---------|
| Database | Barangay filing cabinet | `scholarship_db` |
| Table | Drawer with specific record type | `applicants` |
| Row (Record) | Single folder | One applicant's info |
| Column (Field) | Label inside folder | `name`, `age`, `status` |
| Query | Asking the secretary | "List all approved applicants" |

## 2. Why Not Just Spreadsheets or Plain Files?

Spreadsheets are fine *initially*, but:
- Harder concurrency (multiple people editing safely)
- No enforced constraints (e.g., duplicate IDs)
- Slower searching at scale
- Difficult relational connections (linking applicants to payment records)

Plain text / CSV files are lightweight, but they lack:
- Built‑in indexing for fast retrieval
- Transaction safety (atomic updates)
- Rich query language (SQL)
- Access control and backups tooling

## 3. Core Benefits

1. **Consistency** – Rules (constraints) keep data clean.
2. **Integrity** – Transactions prevent partial updates (either all changes succeed or none).  
3. **Performance** – Indexes accelerate lookups (`WHERE last_name='Dela Cruz'`).
4. **Security** – Permissions restrict who can read/write.
5. **Scalability** – Databases handle thousands to millions of records.

> Barangay context: Instead of manually counting applicants, a single query: `SELECT COUNT(*) FROM applicants WHERE status='Approved';` gives instant results.

## 4. Common Database Types

| Type | Usage | Example Systems |
|------|-------|-----------------|
| Relational (SQL) | Structured tabular data, relationships | MySQL, PostgreSQL, MariaDB |
| Document (NoSQL) | Flexible JSON‑like objects | MongoDB, CouchDB |
| Key‑Value | Simple lookups by key | Redis, DynamoDB |
| Columnar | Analytics / large aggregations | Apache Cassandra, BigQuery |
| Graph | Relationship‑heavy data | Neo4j |

We will dive deeper into SQL vs NoSQL next lesson—but for now, know **relational databases** store data in tables with defined schemas (structure), while **NoSQL** options trade some structure for flexibility or speed in specific use cases.

## 5. Structured vs Unstructured Data

| Structured | Semi‑Structured | Unstructured |
|------------|-----------------|-------------|
| Fixed schema | JSON / XML with loose pattern | Free text, images |
| Fast querying | Flexible evolution | Requires parsing / ML to analyze |
| Example: `applicants` table | Example: API returns JSON profile | Example: scanned PDF of birth cert |

Barangay scenario: Storing birth certificates as PDFs is *unstructured*. Applicant names + ages + school year is *structured*.

## 6. CRUD Operations

CRUD = **Create, Read, Update, Delete** – the four fundamental actions on persistent data.

| Operation | SQL Example | Meaning in Barangay |
|-----------|------------|----------------------|
| Create | `INSERT INTO applicants (...) VALUES (...);` | Add new applicant |
| Read | `SELECT * FROM applicants WHERE status='Pending';` | View pending submissions |
| Update | `UPDATE applicants SET status='Approved' WHERE id=15;` | Mark as approved |
| Delete | `DELETE FROM applicants WHERE id=32;` | Remove withdrawn case |

## 7. Queries and Filtering

Databases shine when you ask questions:
- "How many applicants are under 18?"
- "List those missing requirements."
- "Count approved per school."

SQL makes this direct:
```sql
SELECT school, COUNT(*) AS total
FROM applicants
WHERE status='Approved'
GROUP BY school
ORDER BY total DESC;
```

## 8. Indexes (Preview)

Searching a table without indexes is like scanning *every* folder manually. An **index** is a fast lookup map. We will explore deeper when performance tuning (later chapters), but remember: Indexes accelerate reads; too many can slow writes.

## 9. Transactions (Preview)

Suppose two social workers update the same applicant simultaneously. Transactions ensure data remains consistent. If one step fails (e.g., network glitch), the whole operation can roll back, preventing half‑saved records.

## 10. Real Example Sketch (Python + SQLite)

Below is a tiny prototype Tian eventually builds:
```python
import sqlite3

conn = sqlite3.connect("scholarship.db")
cur = conn.cursor()

cur.execute("""
CREATE TABLE IF NOT EXISTS applicants (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	full_name TEXT NOT NULL,
	age INTEGER NOT NULL,
	school TEXT NOT NULL,
	status TEXT DEFAULT 'Pending'
);
""")

cur.execute("INSERT INTO applicants (full_name, age, school) VALUES (?,?,?)",
			("Rhea Joy Santos", 17, "Iloilo National High"))

cur.execute("SELECT full_name, status FROM applicants")
for row in cur.fetchall():
	print(row)

conn.commit()
conn.close()
```

## 11. When Do You Need a Database?

Use a proper database when:
- Multiple users need synchronized access
- Data volume or queries grow
- You require relationships (applicants ↔ disbursements)
- Auditing / security matters
- Reliability and backups are required

Plain files are acceptable when:
- Very small data (under ~100 records)
- Single user scripts / prototypes
- One‑off exports (e.g., generating a report)

## 12. Mini Summary

| Need | Best Approach |
|------|---------------|
| Structured records w/ relationships | Relational DB (SQL) |
| High‑speed caching / ephemeral | Key‑Value store |
| Flexible evolving schema | Document store |
| Complex connections (people/resources) | Graph DB |

## 13. Reflection – Tian & Rhea Joy

"So, a database is like leveling up from a messy bodega to a labeled, searchable vault?" Tian asked.

"Exactly," Kuya Miguel smiled. "Data Bahandi—your treasure—is safer, faster, and clearer. Tomorrow we’ll compare SQL and NoSQL so you can choose the right chest for the right treasure." Rhea Joy grinned: "Goodbye manual counting!"

## 14. Your Turn (Quick Practice)

1. List 3 pain points in your own school / community that a database could solve.
2. Categorize these needs: relational, document, or key‑value?
3. Write one SQL query you *think* would answer a real question.

---
**Next Lesson:** [SQL vs NoSQL](../le_02_sql_vs_nosql/)

