## Lesson 2 Exercises: SQL vs NoSQL Decision Crafting

---
### 1. Classification Drill (5 minutes)
Label each scenario as MOST suitable for (SQL) or (NoSQL) and give a 1‑sentence justification:
1. Barangay birth records (official, strict format)
2. Rapidly changing community event announcements (fields appear/disappear)
3. Financial aid disbursement ledger (double entry constraints)
4. Resident preference tags (variable optional attributes)
5. Daily sensor readings from air-quality monitors (append-only time series)

| Scenario | Pick (SQL / NoSQL) | Justification |
|----------|--------------------|---------------|
| Birth Records | | |
| Event Announcements | | |
| Aid Ledger | | |
| Preference Tags | | |
| Sensor Readings | | |

---
### 2. Dual Modeling Exercise (10 minutes)
Design a resident profile in BOTH paradigms.

Relational (table definitions – minimal):
```sql
CREATE TABLE residents (
	resident_id SERIAL PRIMARY KEY,
	full_name TEXT NOT NULL,
	birth_date DATE,
	barangay TEXT NOT NULL,
	phone TEXT,
	email TEXT
);

CREATE TABLE resident_tags (
	resident_id INT REFERENCES residents(resident_id),
	tag TEXT NOT NULL,
	PRIMARY KEY (resident_id, tag)
);
```

Document (one JSON document):
```json
{
	"resident_id": "R-10293",
	"full_name": "Juan Dela Cruz",
	"birth_date": "1998-02-11",
	"barangay": "Sto. Niño",
	"contacts": {"phone": "+63-912-111-2222", "email": "juan@example.com"},
	"tags": ["PWD", "ScholarshipCandidate"],
	"optionalProfile": {"preferredLanguage": "Filipino", "allergies": ["seafood"]}
}
```
Reflection: Note one benefit and one cost for each approach regarding evolving fields.

---
### 3. Query Translation (8 minutes)
Goal: Retrieve all residents in barangay 'Sto. Niño' who have tag 'ScholarshipCandidate'.

Write the SQL version (JOIN + filter) and a MongoDB style query (assume tags array).

SQL:
```sql
SELECT r.resident_id, r.full_name
FROM residents r
JOIN resident_tags t ON r.resident_id = t.resident_id
WHERE r.barangay = 'Sto. Niño' AND t.tag = 'ScholarshipCandidate';
```

MongoDB (pseudo):
```javascript
db.residents.find({
	barangay: 'Sto. Niño',
	tags: 'ScholarshipCandidate'
}, { resident_id: 1, full_name: 1 });
```
Question: Which is simpler to express? Which is easier to enforce uniqueness of (resident_id, tag) and why?

---
### 4. Consistency Simulation (7 minutes)
Scenario: You add a new tag "EmergencyVolunteer" to 100 resident profiles.

Task A (SQL): Write one transaction outline ensuring either all 100 tag inserts succeed or none.
```sql
BEGIN;
-- 100 INSERT statements here
COMMIT; -- or ROLLBACK on error
```
Task B (NoSQL): Describe how eventual consistency might briefly show only part of the new tags across replicas.
Answer (2–3 sentences):

Mitigation ideas (list 2):
1.
2.

---
### 5. Decision Flow Justification (5 minutes)
Using the decision flow from the lesson, justify a hybrid approach for a barangay portal (2 paragraphs):
Paragraph 1: Components best handled by SQL.
Paragraph 2: Components optionally delegated to NoSQL (and why).

---
### 6. Stretch Code (Optional, 10–15 minutes)
Create a small Python snippet: store 3 resident records in an in‑memory list of dicts (document style) and the same in a temporary SQLite database. Query both for residents with tag "PWD".

Starter outline:
```python
import sqlite3

# Document style
residents_docs = [
		{"id": 1, "name": "Ana", "tags": ["PWD", "Senior"]},
		{"id": 2, "name": "Ben", "tags": ["ScholarshipCandidate"]},
		{"id": 3, "name": "Carla", "tags": ["PWD"]}
]
filtered_docs = [r for r in residents_docs if "PWD" in r["tags"]]
print("Docs PWD:", [r["name"] for r in filtered_docs])

# Relational style
conn = sqlite3.connect(":memory:")
c = conn.cursor()
c.execute("CREATE TABLE residents(id INTEGER PRIMARY KEY, name TEXT)")
c.execute("CREATE TABLE resident_tags(id INTEGER, tag TEXT)")

c.executemany("INSERT INTO residents VALUES (?, ?)", [(1, "Ana"), (2, "Ben"), (3, "Carla")])
c.executemany("INSERT INTO resident_tags VALUES (?, ?)", [(1, "PWD"), (1, "Senior"), (2, "ScholarshipCandidate"), (3, "PWD")])

c.execute("""
SELECT r.name FROM residents r
JOIN resident_tags t ON r.id = t.id
WHERE t.tag = 'PWD'
""")
print("SQL PWD:", [row[0] for row in c.fetchall()])
```
Reflection: Which style was faster to prototype? Which scales better for enforcing tag uniqueness?

---
### 7. Personal Reflection (3 minutes)
Write 3 bullet points: (a) one surprise learning, (b) one strength of SQL for your future project, (c) one justified use-case for NoSQL you might explore.

---
**Next:** Begin Lesson 3 foundational relational structures.
