## Lesson 27: Indexing Strategies

Story: Queries slow with 10,000 residents. Tian learns indexes: "B-tree speeds lookups—trade-off: write overhead."

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

### 14. Practice Prompts
1. Create index on frequently filtered column.
2. Composite index for two-column WHERE.
3. Explain query; verify index used.
4. Discuss trade-off for high-write table.

### 15. Reflection
Two scenarios where indexing critical; two where unnecessary.

**Next:** Quiz then exercises.