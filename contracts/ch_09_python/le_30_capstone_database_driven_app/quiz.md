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

**Question 2:** 3NF schema benefit:
A. More redundancy
B. Reduced redundancy, integrity
C. Slower queries always
D. No foreign keys

**Question 3:** Validation: age >= 18 enforced where?
A. HTML only
B. Python backend (before INSERT)
C. No validation
D. Database triggers only

**Question 4:** JOIN residents + barangays:
A. Separate queries
B. Single query with JOIN ON barangay_id
C. No JOIN possible
D. Manual merge

**Question 5:** Unique constraint on email:
A. Allows duplicates
B. Prevents duplicate emails
C. Optional
D. No effect

---
# Quiz 2
## Scenario: Reports & Error Handling
Rhea Joy ensures robustness.

**Question 6:** Aggregation report (COUNT by barangay):
A. No GROUP BY
B. GROUP BY barangay_id, COUNT(*)
C. Single COUNT
D. No aggregate functions

**Question 7:** IntegrityError catch:
A. Ignore errors
B. Rollback transaction, return 400
C. Commit anyway
D. No error handling

**Question 8:** Dashboard template:
A. JSON only
B. HTML with Jinja2 (render_template)
C. Plain text
D. No UI

**Question 9:** RESTful DELETE returns:
A. 200 OK
B. 204 No Content
C. 500 Error
D. 201 Created

**Question 10:** Capstone demonstrates:
A. Single concept
B. Integration: Python, DB, web, validation
C. No database
D. Only front-end

---
## Answers
1: A  
2: B  
3: B  
4: B  
5: B  
6: B  
7: B  
8: B  
9: B  
10: B  

---
## Detailed Explanations
Q1 Flask + SQLite + HTML/CSS (full-stack).  
Q2 3NF reduces redundancy, enforces integrity.  
Q3 Backend validation before INSERT (age check).  
Q4 JOIN residents ON barangay_id single query.  
Q5 UNIQUE constraint prevents duplicate emails.  
Q6 GROUP BY barangay_id, COUNT(*) aggregation.  
Q7 Catch IntegrityError; rollback; return 400.  
Q8 render_template() Jinja2 HTML dashboard.  
Q9 DELETE returns 204 No Content.  
Q10 Capstone integrates all concepts (Python, DB, web).  

---
**Next:** Proceed to Lesson 30 capstone exercises.