## Background Story

The scholarship system had grown organically over months, adding features as needs arose. Now it was becoming unwieldy: students table had 47 columns, some information was duplicated across tables, relationships between entities were unclear, and adding new features required complex workarounds. "Our database is a mess," Rhea Joy admitted. "We need to redesign it properly before it becomes unmaintainable."

Captain Cruz wanted to expand the system to handle not just scholarships, but also health records, census data, and business permits. "Can your database do that?" Tian looked at his tangled table structures and honestly replied, "Not without a complete redesign. Right now, everything assumes scholarship data. We never planned for expansion." They needed a systematic approach to data design.

Kuya Miguel introduced them to Entity-Relationship modeling. "Before you write any SQL, you need to understand your domain conceptually. What are the entities—residents, applications, barangays? What are their attributes—names, dates, amounts? What are the relationships—one resident submits many applications, one barangay has many residents? ER diagrams visualize all this before you commit to implementation."

They spent a week doing proper data modeling: identified all entities in the expanded system, listed attributes for each entity with correct data types, mapped relationships with cardinality (one-to-many, many-to-many), normalized to eliminate redundancy, drew ER diagrams that everyone—technical and non-technical—could understand. When they finally rebuilt the database following this blueprint, it was clean, scalable, and ready for expansion. The scholarship system was becoming well-architected, one entity-relationship at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

The scholarship system was growing complex. Applicants. Scholarship programs. Schools. Disbursements. Tian's code was getting tangled—where does each piece of data live? How do they relate?

"Before writing more code, design your data model," Kuya Miguel advised. "Draw an ER diagram."

They opened a whiteboard and started sketching:

```
┌─────────────┐
│  Resident   │
├─────────────┤
│ id (PK)     │
│ name        │
│ barangay    │
│ birthdate   │
└─────────────┘
       │
       │ 1:N (one resident, many applications)
       ↓
┌──────────────┐
│ Application  │
├──────────────┤
│ id (PK)      │
│ resident_id (FK) │
│ program_id (FK)  │
│ status       │
│ date_applied │
└──────────────┘
       │
       │ N:1 (many applications, one program)
       ↓
┌────────────────────┐
│ ScholarshipProgram │
├────────────────────┤
│ id (PK)            │
│ name               │
│ amount             │
│ requirements       │
└────────────────────┘
```

"See the relationships?" Rhea Joy traced the arrows. "One resident can submit many applications. Each application links to one scholarship program."

They added more entities:

```
Resident ──1:N── Application ──N:1── ScholarshipProgram
    │
    │ 1:1
    ↓
ContactInfo

Application ──1:N── Disbursement

ScholarshipProgram ──N:M── RequiredDocument
                    (many-to-many via junction table)
```

Kuya Miguel explained the notation:
- **Rectangle** = Entity (table)
- **Oval** = Attribute (column)
- **Diamond** = Relationship
- **1:1** = One-to-one
- **1:N** = One-to-many
- **N:M** = Many-to-many

Tian drew the cardinality rules:

"One resident **must have** one ContactInfo (1:1 mandatory)"
"One application **may have** multiple Disbursements (1:N optional)"
"Many programs **require** many documents (N:M with junction table)"

Rhea Joy identified the keys:

**Primary Keys (PK):**
- Resident.id
- Application.id
- ScholarshipProgram.id

**Foreign Keys (FK):**
- Application.resident_id → Resident.id
- Application.program_id → ScholarshipProgram.id
- Disbursement.application_id → Application.id

The diagram revealed design issues:

"Wait," Tian noticed. "If we store the resident's age in Application, and they apply multiple times, the age will be outdated."

"Exactly," Kuya Miguel pointed. "Store birthdate in Resident. Calculate age when needed. That's normalization—avoiding redundancy."

They refined the model:
- Moved static data to Resident
- Made Application reference Resident
- Added audit fields (created_at, updated_at)
- Designed junction table for Program_Documents

After an hour, the ER diagram was complete. Before writing a single SQL statement, they had:
- Clear entity definitions
- Proper relationships
- Identified keys
- Normalization applied
- Constraints documented

"Now translate this to SQL," Kuya Miguel said. "Each entity becomes a CREATE TABLE. Each relationship becomes a foreign key."

Tian took a photo of the whiteboard. This diagram would guide the entire database schema. No more confusion about where data lives or how tables connect.

"Data modeling is thinking before coding," Rhea Joy summarized. "Ten minutes drawing saves ten hours debugging."

_Next up: Normalization (1NF, 2NF, 3NF)!_ 🔄

**Next:** Quiz then exercises.