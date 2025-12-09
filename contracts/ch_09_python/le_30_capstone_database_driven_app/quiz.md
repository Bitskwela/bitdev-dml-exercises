# Lesson 30 Quiz: Capstone Project

---
# Quiz 1
## Scenario: Final Integration
Tian builds full-stack app.

**Question 1:** Capstone stack:
A. Flask + SQLite + HTML
B. Only Python scripts
C. No database
D. Java + Oracle

**Answer:** A. Flask + SQLite + HTML  
**Explanation:** Flask + SQLite + HTML/CSS (full-stack).

---

**Question 2:** 3NF schema benefit:
A. More redundancy
B. Reduced redundancy, integrity
C. Slower queries always
D. No foreign keys

**Answer:** B. Reduced redundancy, integrity  
**Explanation:** 3NF reduces redundancy, enforces integrity.

---

**Question 3:** Validation: age >= 18 enforced where?
A. HTML only
B. Python backend (before INSERT)
C. No validation
D. Database triggers only

**Answer:** B. Python backend (before INSERT)  
**Explanation:** Backend validation before INSERT (age check).

---

**Question 4:** JOIN residents + barangays:
A. Separate queries
B. Single query with JOIN ON barangay_id
C. No JOIN possible
D. Manual merge

**Answer:** B. Single query with JOIN ON barangay_id  
**Explanation:** JOIN residents ON barangay_id single query.

---

**Question 5:** Unique constraint on email:
A. Allows duplicates
B. Prevents duplicate emails
C. Optional
D. No effect

**Answer:** B. Prevents duplicate emails  
**Explanation:** UNIQUE constraint prevents duplicate emails.

---
# Quiz 2
## Scenario: Reports & Error Handling
Rhea Joy ensures robustness.

**Question 6:** Aggregation report (COUNT by barangay):
A. No GROUP BY
B. GROUP BY barangay_id, COUNT(*)
C. Single COUNT
D. No aggregate functions

**Answer:** B. GROUP BY barangay_id, COUNT(*)  
**Explanation:** GROUP BY barangay_id, COUNT(*) aggregation.

---

**Question 7:** IntegrityError catch:
A. Ignore errors
B. Rollback transaction, return 400
C. Commit anyway
D. No error handling

**Answer:** B. Rollback transaction, return 400  
**Explanation:** Catch IntegrityError; rollback; return 400.

---

**Question 8:** Dashboard template:
A. JSON only
B. HTML with Jinja2 (render_template)
C. Plain text
D. No UI

**Answer:** B. HTML with Jinja2 (render_template)  
**Explanation:** render_template() Jinja2 HTML dashboard.

---

**Question 9:** RESTful DELETE returns:
A. 200 OK
B. 204 No Content
C. 500 Error
D. 201 Created

**Answer:** B. 204 No Content  
**Explanation:** DELETE returns 204 No Content.

---

**Question 10:** Capstone demonstrates:
A. Single concept
B. Integration: Python, DB, web, validation
C. No database
D. Only front-end

**Answer:** B. Integration: Python, DB, web, validation  
**Explanation:** Capstone integrates all concepts (Python, DB, web).

---
**Next:** Proceed to Lesson 30 capstone exercises.