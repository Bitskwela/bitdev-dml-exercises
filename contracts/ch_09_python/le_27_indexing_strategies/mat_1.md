## Background Story

The scholarship portal had become popular across multiple barangays. What started as 287 applications had grown to over 10,000 records spanning three years. Success brought a new problem: the system was getting slower. Simple searches that once returned instantly now took 5-10 seconds. During peak hours when dozens of students checked their status simultaneously, the database crawled to a near halt.

Rhea Joy noticed the pattern: "Every time someone searches by last name, the system scans through all 10,000 records looking for matches. That's inefficient." Tian tried to optimize by caching results, but it only helped for repeated searches. New searches still required scanning the entire table. "How do real databases handle millions of records and still return results instantly?"

Kuya Miguel had seen this problem countless times in production systems. "Indexes. Think of them like the index at the back of a textbook. Instead of reading every page to find a topic, you check the index, which tells you exactly which page to jump to. Database indexes work similarly—B-tree structures that let you find records in logarithmic time instead of linear scanning. But there's a trade-off: indexes take storage space and slow down writes because they need updating."

They analyzed their query patterns and added strategic indexes: one on student last names for search queries, one on application status for filtering, a composite index on (barangay_id, submission_date) for common reports. Search times dropped from 8 seconds to 20 milliseconds. The system felt responsive again even with growing data. They learned to balance indexes—too few meant slow reads, too many meant slow writes. The scholarship system was becoming performant, one index at a time.

---

## Theory & Lecture Content

### 1. What Is an Index?
Data structure (often B-tree) enabling fast lookup without scanning entire table.

### 2. Without Index
Full table scan: O(n) search.

### 3. With Index
Balanced tree: O(log n) search.

### 4. Primary Key Index
Auto-created on primary key; unique.

### 5. Creating Index (SQL)
```sql
CREATE INDEX idx_name ON residents(name);
```

### 6. Composite Index
Multiple columns:
```sql
CREATE INDEX idx_barangay_age ON residents(barangay_id, age);
```
Use for queries filtering/sorting on both.

### 7. Unique Index
Enforces uniqueness (e.g., email):
```sql
CREATE UNIQUE INDEX idx_email ON residents(email);
```

### 8. When to Index
- Columns in WHERE clauses.
- Foreign keys.
- Columns in ORDER BY, JOIN.

### 9. When NOT to Index
- Small tables (overhead > benefit).
- Columns rarely queried.
- High-write columns (index maintenance cost).

### 10. Index Types
- B-tree: general-purpose (default).
- Hash: exact match (=) only.
- Full-text: text search.

### 11. Trade-offs
- Pros: Faster reads.
- Cons: Slower writes (inserts/updates maintain index), storage overhead.

### 12. Explain/Analyze (Query Plan)
SQL:
```sql
EXPLAIN SELECT * FROM residents WHERE barangay_id=3;
```
Shows index usage.

### 13. Story Thread
Tian indexes barangay_id; query time drops from 800ms to 15ms.

---

## Closing Story

The scholarship portal was slow. Filtering by barangay took 800ms for 2,000 applicants. Users complained.

"We need indexing," Kuya Miguel diagnosed. "The database scans every row. Let's add smart indexes."

Tian checked the slow query:

```python
# Flask endpoint - SLOW
@app.route("/api/applicants/search")
def search_applicants():
    barangay_id = request.args.get("barangay_id")
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute(
        "SELECT * FROM applicants WHERE barangay_id = ?",
        (barangay_id,)
    )
    results = cursor.fetchall()
    conn.close()
    return jsonify(results)
```

**Without index:** Database scans all 2,000 rows sequentially.

Kuya Miguel created an index:

```sql
CREATE INDEX idx_barangay_id ON applicants(barangay_id);
```

**With index:** Database uses B-tree structure to jump directly to matching rows.

Tian tested the improvement:

```python
import time
import sqlite3

conn = sqlite3.connect("scholarship.db")
cursor = conn.cursor()

# Before index
start = time.time()
cursor.execute("SELECT * FROM applicants WHERE barangay_id = 3")
results = cursor.fetchall()
print(f"Query time: {(time.time() - start) * 1000:.2f}ms")  # 800ms

# Create index
cursor.execute("CREATE INDEX idx_barangay_id ON applicants(barangay_id)")
conn.commit()

# After index
start = time.time()
cursor.execute("SELECT * FROM applicants WHERE barangay_id = 3")
results = cursor.fetchall()
print(f"Query time: {(time.time() - start) * 1000:.2f}ms")  # 15ms
```

**Result:** 53x faster. 800ms → 15ms.

Rhea Joy explored different index types:

**1. Single-Column Index**
```sql
CREATE INDEX idx_status ON applications(status);
-- Speeds up: WHERE status = 'Approved'
```

**2. Composite Index**
```sql
CREATE INDEX idx_barangay_status ON applicants(barangay_id, status);
-- Speeds up: WHERE barangay_id = 3 AND status = 'Pending'
```

**3. Unique Index**
```sql
CREATE UNIQUE INDEX idx_email ON applicants(email);
-- Enforces uniqueness + speeds up lookups
```

Tian used `EXPLAIN` to verify index usage:

```sql
EXPLAIN QUERY PLAN SELECT * FROM applicants WHERE barangay_id = 3;
-- Output: SEARCH applicants USING INDEX idx_barangay_id (barangay_id=?)
```

The keyword "USING INDEX" confirmed the database was using the index.

Kuya Miguel warned about trade-offs:

```python
# Indexes speed up reads
cursor.execute("SELECT * FROM applicants WHERE barangay_id = 3")  # Fast

# But slow down writes
cursor.execute(
    "INSERT INTO applicants (name, age, barangay_id) VALUES (?, ?, ?)",
    ("New Applicant", 20, 3)
)
conn.commit()  # Slightly slower - must update index
```

"Index on every column?" Tian asked.

"No," Kuya Miguel cautioned. "Only index columns you frequently filter, join, or sort by. Each index:
- Takes storage space
- Slows down inserts/updates/deletes
- Requires maintenance

Index strategically, not blindly."

**When to Index:**
- Columns in WHERE clauses: `WHERE barangay_id = ?`
- Foreign keys: `JOIN barangays ON applicants.barangay_id = barangays.id`
- Columns in ORDER BY: `ORDER BY created_at DESC`
- Large tables with frequent queries

**When NOT to Index:**
- Small tables (< 1000 rows) - scanning is already fast
- Columns rarely queried
- Tables with heavy writes and few reads
- Every column (index bloat)

Rhea Joy analyzed their scholarship database:

```sql
-- Index these (frequently queried)
CREATE INDEX idx_barangay_id ON applicants(barangay_id);
CREATE INDEX idx_status ON applications(status);
CREATE INDEX idx_created_at ON applications(created_at);

-- Don't index these (rarely used in WHERE)
-- applicants.name (full-text search would be better)
-- applicants.age (low cardinality)
```

They tested the optimized database:

```python
# Dashboard query - now lightning fast
cursor.execute("""
    SELECT 
        b.name AS barangay,
        COUNT(CASE WHEN a.status = 'Approved' THEN 1 END) AS approved,
        COUNT(CASE WHEN a.status = 'Pending' THEN 1 END) AS pending
    FROM barangays b
    LEFT JOIN applicants ap ON ap.barangay_id = b.id
    LEFT JOIN applications a ON a.applicant_id = ap.id
    GROUP BY b.id
""")
# 1.2 seconds → 80ms (with proper indexes)
```

The portal was now responsive. Users noticed the difference immediately.

"Indexing is invisible performance magic," Rhea Joy marveled. "Users don't see it, but they feel it."

From sluggish to snappy, one index at a time.

_Next up: Executing Queries from Python!_ 🚀

**Next:** Quiz then exercises.