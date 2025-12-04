# Data Modeling and ER Diagrams Activity

Practice designing database schemas.

### Task 1: Identify Entities
**Scenario:** Library System

```
Your answer:
1. 
2. 
3. 
```

### Task 2: 1:N Relationship
```
Author ---[?]--- Books

Cardinality: 
Explanation: 
```

### Task 3: Junction Table for M:M
```
Students ↔ Clubs

Junction table name: 
Columns:
- 
- 
```

### Task 4: Label Keys
```
Author:
- author_id (___)
- name

Books:
- book_id (___)
- title
- author_id (___)
```

## Reflection
**Two benefits of ER diagrams:**
1. _[Visualize structure before coding]_
2. _[Identify missing relationships early]_

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: Entities
1. **Author**
2. **Book**
3. **Member** (library users)
4. **Loan** (borrowing records)

### Task 2: 1:N Relationship
```
Author ---[writes]--- Books

Cardinality: 1:N (one author, many books)
Explanation: Each author can write multiple books, but each book has one primary author
```

### Task 3: Junction Table
```
Students ↔ Clubs (M:M relationship)

Junction table name: student_clubs
Columns:
- student_id (FK → students.id)
- club_id (FK → clubs.id)
- join_date
- (student_id, club_id) = composite PK
```

### Task 4: Keys
```
Author:
- author_id (PK)
- name

Books:
- book_id (PK)
- title
- author_id (FK)
```

**Complete ER Diagram:**
```
Author (1) ---< writes >--- (N) Book
  |                           |
  PK: author_id              PK: book_id
                              FK: author_id

Student (M) ---< enrolls >--- (N) Club
                |
         student_clubs junction table
         - student_id (FK, part of composite PK)
         - club_id (FK, part of composite PK)
```

**Reflection:** ER diagrams: (1) Catch design flaws before implementation, (2) Communication tool for stakeholders, (3) Foundation for normalization, (4) Documentation for future developers

</details>
