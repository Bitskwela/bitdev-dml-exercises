# Lesson 25 Quiz: ER Diagrams

---
# Quiz 1
## Scenario: Schema Design
Tian visualizes database.

**Question 1:** ER diagram purpose:
A. Write code
B. Visualize entities and relationships
C. Execute queries
D. Deploy database

**Answer: B**  
**Explanation:** ER diagrams visualize entities (tables) and relationships.

---

**Question 2:** Entity in ER:
A. Function
B. Object/concept (table)
C. Query
D. User

**Answer: B**  
**Explanation:** Entity represents object/concept (becomes table).

---

**Question 3:** Attribute definition:
A. Relationship
B. Property/column of entity
C. Primary key only
D. Foreign table

**Answer: B**  
**Explanation:** Attribute is property/column.

---

**Question 4:** Primary key:
A. Optional field
B. Unique identifier for row
C. Foreign reference
D. Non-unique value

**Answer: B**  
**Explanation:** Primary key uniquely identifies each row.

---

**Question 5:** One-to-Many example:
A. Student ↔ Courses
B. Barangay → Residents (one barangay, many residents)
C. User ↔ Profile (1:1)
D. No relationship

**Answer: B**  
**Explanation:** One barangay has many residents (1:N).

---
# Quiz 2
## Scenario: Relationship Types
Rhea Joy designs complex schema.

**Question 6:** Foreign key purpose:
A. Unique ID
B. Links to primary key of another table
C. Optional field
D. No function

**Answer: B**  
**Explanation:** Foreign key references primary key of related table.

---

**Question 7:** Many-to-Many requires:
A. No extra table
B. Junction/association table
C. Single foreign key
D. Duplicate rows

**Answer: B**  
**Explanation:** Many-to-Many needs junction table (e.g., Enrollments).

---

**Question 8:** Junction table Students ↔ Courses:
A. Students(id, course_id)
B. Enrollments(student_id, course_id)
C. Courses(student_id)
D. No table needed

**Answer: B**  
**Explanation:** Enrollments(student_id, course_id) junction.

---

**Question 9:** Cardinality notation 1:N means:
A. One-to-One
B. One-to-Many
C. Many-to-Many
D. None

**Answer: B**  
**Explanation:** 1:N = One-to-Many.

---

**Question 10:** ER diagram benefit:
A. Slower design
B. Clarifies structure before coding
C. More bugs
D. Unnecessary step

**Answer: B**  
**Explanation:** ER diagrams prevent design errors, clarify structure.

---
**Next:** Proceed to Lesson 25 exercises.