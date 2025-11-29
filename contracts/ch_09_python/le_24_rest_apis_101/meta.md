## Lesson 24 Exercises: REST API Practice

---
### 1. GET All Endpoint (8 minutes)
List books=[{"id":1,"title":"Book A"},...]. /api/books returns JSON.

---
### 2. GET One by ID (8 minutes)
/api/books/<int:id> returns single book or 404.

---
### 3. POST Create (10 minutes)
POST /api/books with JSON {"title":"New"}. Generate ID; append to list; return 201.

---
### 4. PUT Update (10 minutes)
PUT /api/books/<int:id> with JSON {"title":"Updated"}. Modify existing; return 200 or 404.

---
### 5. DELETE Endpoint (8 minutes)
DELETE /api/books/<int:id> removes from list; return 204.

---
### 6. Status Code Handling (7 minutes)
Ensure correct codes: 200 (OK), 201 (Created), 204 (No Content), 404 (Not Found).

---
### 7. Test with curl/Postman (8 minutes)
Manually test all five endpoints; verify responses.

---
### 8. Stretch: Pagination (Optional)
GET /api/books?page=1&limit=10 returns subset.

---
### 9. Reflection (3 minutes)
Two reasons REST APIs preferred for mobile/SPA frontends.

---
**Next:** Chapter 8 complete; move to Chapter 9 (Data Modeling & Normalization).