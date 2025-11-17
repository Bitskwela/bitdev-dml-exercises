## Lesson 30 Exercises: Capstone Build

---
### 1. Database Setup (15 minutes)
Create barangays, residents, applications tables. Insert seed data (3 barangays, 5 residents).

---
### 2. CRUD Endpoints (30 minutes)
Implement:
- GET /api/residents (list all)
- POST /api/residents (create with validation)
- GET /api/residents/<id>
- PUT /api/residents/<id>
- DELETE /api/residents/<id>

---
### 3. Validation (15 minutes)
Reject age < 18; enforce unique email; return 400 with error message.

---
### 4. JOIN Dashboard (20 minutes)
Route /dashboard: SELECT residents JOIN barangays; render HTML template listing name, age, barangay.

---
### 5. Applications CRUD (20 minutes)
Similar CRUD for applications: create, list, update status (Pending → Approved).

---
### 6. Aggregation Report (15 minutes)
Route /reports/approvals: COUNT approved applications GROUP BY barangay; return JSON.

---
### 7. Error Handling (15 minutes)
Wrap INSERT/UPDATE in try/except; catch IntegrityError; rollback; return 400.

---
### 8. Testing (20 minutes)
Manually test all endpoints (curl or Postman); verify validation, JOIN, aggregation.

---
### 9. Stretch: Search Filter (Optional)
GET /api/residents?name=Ana: dynamic WHERE clause.

---
### 10. Stretch: CSV Export (Optional)
Route /reports/export: generate CSV of all residents.

---
### 11. Reflection (10 minutes)
Write summary:
- Three challenges faced and solutions
- Two design decisions (trade-offs)
- One feature you'd add next

---
**Congratulations!** You've completed the Python + Database curriculum. From data structures to web APIs to database integration—Tian's journey mirrors yours. Ready to build the future.

**Next Steps:**
- Deploy to cloud (Heroku, PythonAnywhere)
- Add authentication (Flask-Login)
- Integrate front-end framework (React, Vue)
- Explore ORM (SQLAlchemy)
- Contribute to open-source projects