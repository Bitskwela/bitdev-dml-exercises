# Indexing Strategies Activity

Practice optimizing database queries with indexes.

### Task 1: Single-Column Index
```sql
-- Frequent query: SELECT * FROM applicants WHERE age >= 18;

-- Your code: create index

```

### Task 2: Composite Index
```sql
-- Query: SELECT * FROM applications 
--        WHERE status = 'pending' AND submission_date > '2024-01-01';

-- Your code: create composite index

```

### Task 3: Verify Index Usage
```sql
-- Your code: use EXPLAIN QUERY PLAN

```

### Task 4: High-Write Trade-off
**Scenario:** Applications table receives 1000 inserts/day, queried 10 times/day

**Should you index submission_date?**
**Justification:**

## Reflection
**Indexing is critical when:**
1. _[Large tables with frequent WHERE/JOIN]_
2. _[Sorting on specific columns]_

**Indexing is unnecessary when:**
1. _[Small tables (< 1000 rows)]_
2. _[High write ratio vs reads]_

<details>
<summary><strong>Answer Key</strong></summary>

```sql
-- Task 1: Single-column index
CREATE INDEX idx_applicants_age ON applicants(age);

-- Benefits: Fast filtering by age range
-- Cost: ~10% storage overhead, slower inserts

-- Task 2: Composite index
CREATE INDEX idx_applications_status_date 
ON applications(status, submission_date);

-- Note: Order matters! Put equality (status) before range (date)

-- Task 3: Verify index usage
EXPLAIN QUERY PLAN
SELECT * FROM applications 
WHERE status = 'pending' AND submission_date > '2024-01-01';

-- Look for: "USING INDEX idx_applications_status_date"

-- Task 4: High-write trade-off
-- **Decision:** NO index on submission_date alone
-- **Reasoning:** 
--   - 1000 inserts vs 10 queries = 100:1 write ratio
--   - Index would slow down 1000 inserts for benefit of only 10 queries
--   - If queries are fast enough without index, skip it
--   - Alternative: Index if queries become critical (reporting, analytics)

-- Example: Compare query times
-- Without index: 50ms for 10,000 rows → acceptable
-- With index: 5ms query, but +1000ms total daily from insert overhead → not worth it
```

**When to Index:**
1. **Critical:** Large tables (100K+ rows) with frequent searches/joins
2. **Critical:** Foreign keys in JOIN queries
3. **Critical:** Columns in ORDER BY for pagination
4. **Critical:** Unique constraints (email, username)

**When to Skip:**
1. **Unnecessary:** Small lookup tables (< 1K rows)
2. **Unnecessary:** High write:read ratio (logs, audit trails)
3. **Unnecessary:** Low-cardinality columns (boolean, small enums)
4. **Unnecessary:** Columns rarely in WHERE/JOIN

**Reflection:** Index strategy depends on workload. Measure before optimizing. Use EXPLAIN to validate index usage. Monitor query performance with real data volumes.

</details>
