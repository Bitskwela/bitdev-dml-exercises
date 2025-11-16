## Lesson 22 Exercises: Flask Basics

---
### 1. Minimal Flask App (8 minutes)
Create app.py: home route returning "Barangay Portal". Run; visit localhost.

---
### 2. Dynamic Route (7 minutes)
/greet/<name> returning f"Hello {name}". Test with /greet/Ana.

---
### 3. Multiple Routes (7 minutes)
Add /about and /contact routes. Verify all three work.

---
### 4. Query Parameters (8 minutes)
/add route: get a, b from query params; return sum as text.

---
### 5. JSON Endpoint (7 minutes)
/api/info route returning jsonify({"barangay":"Sto. Niño","population":5000}).

---
### 6. POST Route (10 minutes)
/submit accepting POST; return "Received" if POST, "Form" if GET.

---
### 7. Dynamic Path with Type (8 minutes)
/applicant/<int:id> returning f"Applicant {id}".

---
### 8. Stretch: Simple Status API (Optional)
List residents = [{"name":"Ana","status":"Approved"},...]. /api/residents returns JSON.

---
### 9. Reflection (3 minutes)
Two reasons Flask suits small-to-medium projects.

---
**Next:** Lesson 23 (Templates & Forms).