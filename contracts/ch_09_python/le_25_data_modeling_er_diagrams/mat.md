## Lesson 25: Data Modeling and ER Diagrams

Story: Database design chaos. Tian learns Entity-Relationship diagrams: "Blueprint before coding."

### 1. What Is Data Modeling?
Structure and relationships of data before implementation.

### 2. Entity-Relationship (ER) Diagram
Visual representation: entities (tables), attributes (columns), relationships.

### 3. Entity
Object or concept (e.g., Resident, Scholarship, Barangay).

### 4. Attributes
Properties of entity:
- Resident: id, name, age, barangay

### 5. Primary Key
Unique identifier (e.g., resident_id).

### 6. Relationships
- One-to-One: Resident ↔ Profile
- One-to-Many: Barangay → Residents (one barangay, many residents)
- Many-to-Many: Students ↔ Courses (junction table)

### 7. Cardinality Notation
- 1:1, 1:N, N:M
- Crow's foot notation common.

### 8. Foreign Key
Attribute linking to primary key of another table.

### 9. Junction Table (Many-to-Many)
Example: Students ↔ Courses requires Enrollments(student_id, course_id).

### 10. ER Diagram Example
```
Resident (id PK, name, barangay_id FK)
Barangay (id PK, name)
Relationship: Barangay 1 → N Residents
```

### 11. Tools
- Draw.io, Lucidchart, dbdiagram.io
- Or pen and paper.

### 12. Story Thread
Tian maps Scholarship System: Resident, Application, ScholarshipProgram, Approval.

### 13. Practice Prompts
1. Identify entities in library system.
2. Draw 1:N relationship (Author → Books).
3. Design junction table for Students ↔ Clubs.
4. Label primary and foreign keys.

### 14. Reflection
Two benefits of ER diagrams before coding schema.

**Next:** Quiz then exercises.