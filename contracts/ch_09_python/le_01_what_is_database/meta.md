# Lesson 1 Exercises: What is a Database?

## Goal
Reinforce understanding of database fundamentals through practical reflection and a tiny prototype.

## Section A: Concept Drill
1. Define in your own words: database, table, row, column, query. (Write 1–2 sentences each.)
2. List 3 real data collections in your community that would benefit from a database (e.g., relief goods, scholarship applications, health records). State why.
3. Categorize each: relational, document, key‑value, or graph—and justify choice.

## Section B: Classification
For each scenario choose the best storage approach and explain in one sentence:
| Scenario | Your Choice | Why |
|----------|-------------|-----|
| Barangay census (name, age, address) | | |
| Fast login sessions (token, expiry) | | |
| Archive of scanned announcements (PDF) | | |
| Students and the clubs they joined (many‑to‑many) | | |
| Flexible survey results (questions change monthly) | | |

## Section C: Mini Prototype (SQLite)
Create a new SQLite database `community.db` with a table `applicants`:
```sql
CREATE TABLE applicants (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	full_name TEXT NOT NULL,
	age INTEGER NOT NULL,
	status TEXT DEFAULT 'Pending'
);
```
Insert at least 3 sample rows. Then write queries:
1. List all applicants older than 16.
2. Count pending vs approved applicants.
3. Update one applicant to `Approved` then re‑run the count.
4. Delete one applicant and show remaining rows.

## Section D: Query Writing
Write an SQL query (no need to execute) for each:
1. Get all applicants whose name starts with 'R'.
2. Count applicants per status.
3. Return only `full_name` and `age` ordered by age descending.
4. Hypothetical: If there were a `schools` table linked by `school_id`, write a join to list applicant name + school name.

## Section E: Reflection
Answer briefly:
1. What risks remain if you keep data in spreadsheets?
2. How do transactions protect integrity?
3. When would a document store be preferable?
4. What performance warning comes with adding too many indexes (future topic)?

## Section F: Stretch (Optional)
Use Python + `sqlite3` to implement the CRUD cycle and print a summary:
```python
import sqlite3

conn = sqlite3.connect("community.db")
cur = conn.cursor()
cur.execute("SELECT status, COUNT(*) FROM applicants GROUP BY status")
for status, total in cur.fetchall():
		print(f"{status}: {total}")
conn.close()
```

## Completion Checklist
- [ ] Definitions written
- [ ] Scenarios classified
- [ ] SQLite DB created (optional but recommended)
- [ ] Queries drafted
- [ ] Reflection answered

---
**Next:** Proceed to Lesson 2 once comfortable with fundamentals.

