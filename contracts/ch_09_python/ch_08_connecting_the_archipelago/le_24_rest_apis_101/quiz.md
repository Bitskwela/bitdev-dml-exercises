# Lesson 24 Quiz: REST APIs

---
# Quiz 1
## Scenario: API Design
Tian architects endpoints.

**Question 1:** REST stands for:
A. Remote Execution Service Tool
B. Representational State Transfer
C. Rapid Endpoint System
D. Resource Execution Standard

**Question 2:** GET method purpose:
A. Create resource
B. Read/retrieve resource
C. Update resource
D. Delete resource

**Question 3:** POST method purpose:
A. Retrieve
B. Create new resource
C. Delete
D. No operation

**Question 4:** 201 status code meaning:
A. OK
B. Created
C. Not Found
D. Bad Request

**Question 5:** 404 status code:
A. Success
B. Not Found
C. Server Error
D. Created

---
# Quiz 2
## Scenario: CRUD Operations
Rhea Joy implements full API.

**Question 6:** PUT/PATCH method:
A. Create
B. Update existing resource
C. Delete
D. List all

**Question 7:** DELETE method:
A. Reads data
B. Removes resource
C. Updates data
D. Creates copy

**Question 8:** Access JSON body in Flask POST:
A. request.body
B. request.get_json()
C. request.data
D. request.json_data()

**Question 9:** RESTful URL pattern:
A. /api/action?id=1
B. /api/resources/1
C. /api/resource_1
D. /api/get/1

**Question 10:** REST stateless means:
A. No database
B. Each request independent (contains all needed info)
C. No sessions ever
D. Faster always

---
## Answers
1: B  
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
Q1 REST = Representational State Transfer.  
Q2 GET retrieves data (read operation).  
Q3 POST creates new resources.  
Q4 201 Created status for successful creation.  
Q5 404 Not Found when resource missing.  
Q6 PUT/PATCH updates existing resource.  
Q7 DELETE removes resource.  
Q8 request.get_json() parses JSON body.  
Q9 /api/resources/id RESTful pattern.  
Q10 Stateless: each request self-contained (auth, params included).  

---
**Next:** Proceed to Lesson 24 exercises.