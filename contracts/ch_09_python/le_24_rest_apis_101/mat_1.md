## Background Story

The scholarship web portal was a success, but a new opportunity emerged: a local software company offered to build a mobile app for barangay services—including scholarship management—for free as their community service project. "We'll handle the mobile interface," their lead developer explained, "but we need your scholarship system to provide data through a proper API. Can you expose REST endpoints?"

Tian had heard the term "API" but never really understood what it meant practically. "Can't they just scrape data from our web pages?" The developer cringed. "No, please don't make us do that. We need structured JSON responses from standardized endpoints. RESTful architecture: GET for reading, POST for creating, PUT for updating, DELETE for removing. Industry standard."

Rhea Joy was both excited and nervous. "This means our scholarship system could power multiple interfaces—the web portal, their mobile app, maybe even integrations with other government systems. But we need to design the API properly." Kuya Miguel confirmed the importance: "APIs are how modern applications communicate. REST is the standard pattern: resources have URLs, HTTP methods indicate actions, responses use JSON. Get this right and your system becomes a platform, not just an application."

They designed and implemented RESTful endpoints: `GET /api/students` returned all students, `GET /api/students/123` returned one specific student, `POST /api/applications` created new applications, `PUT /api/applications/456` updated existing ones, `DELETE /api/applications/789` removed applications. Each endpoint returned clean JSON. The mobile team integrated successfully within days. The scholarship system was becoming a platform, one API endpoint at a time.

---

## Theory & Lecture Content

### 1. What Is REST?
Representational State Transfer: architectural style for APIs.

### 2. Core Principles
- Stateless: each request self-contained
- Resource-based: URLs represent resources
- HTTP methods: GET (read), POST (create), PUT/PATCH (update), DELETE (remove)

### 3. Resource URL Pattern
```
GET    /api/residents       # list all
GET    /api/residents/123   # get one
POST   /api/residents       # create
PUT    /api/residents/123   # update
DELETE /api/residents/123   # delete
```

### 4. Flask Example: GET All
```python
residents = [{"id":1,"name":"Ana"},{"id":2,"name":"Ben"}]

@app.route("/api/residents", methods=["GET"])
def get_residents():
    return jsonify(residents)
```

### 5. GET One
```python
@app.route("/api/residents/<int:id>", methods=["GET"])
def get_resident(id):
    res = next((r for r in residents if r["id"] == id), None)
    if res:
        return jsonify(res)
    return jsonify({"error":"Not found"}), 404
```

### 6. POST Create
```python
@app.route("/api/residents", methods=["POST"])
def create_resident():
    data = request.get_json()
    new_id = max(r["id"] for r in residents) + 1
    new_res = {"id": new_id, "name": data["name"]}
    residents.append(new_res)
    return jsonify(new_res), 201
```

### 7. PUT Update
```python
@app.route("/api/residents/<int:id>", methods=["PUT"])
def update_resident(id):
    data = request.get_json()
    res = next((r for r in residents if r["id"] == id), None)
    if res:
        res["name"] = data["name"]
        return jsonify(res)
    return jsonify({"error":"Not found"}), 404
```

### 8. DELETE
```python
@app.route("/api/residents/<int:id>", methods=["DELETE"])
def delete_resident(id):
    global residents
    residents = [r for r in residents if r["id"] != id]
    return "", 204
```

### 9. Status Codes
- 200 OK: success
- 201 Created: resource created
- 204 No Content: deleted
- 400 Bad Request: invalid input
- 404 Not Found: resource missing
- 500 Internal Server Error

### 10. Testing APIs (curl or Postman)
```bash
curl http://localhost:5000/api/residents
curl -X POST -H "Content-Type: application/json" -d '{"name":"Clara"}' http://localhost:5000/api/residents
```

### 11. Story Thread
Full CRUD API for scholarship applicants: list, create, update, delete.

### 12. Practice Prompts
1. GET endpoint returning JSON list.
2. POST endpoint accepting JSON, adding to list.
3. DELETE endpoint removing by ID.
4. Return appropriate status codes.

### 13. Reflection
Two benefits of REST API over HTML pages for data exchange.

---

## Closing Story

The scholarship system had a web interface, but the municipal IT team wanted to integrate it with their centralized dashboard. They needed machine-readable data, not HTML pages.

"Build a REST API," they requested. "We'll consume it from our system."

Tian refactored the Flask app:

```python
from flask import Flask, jsonify, request

app = Flask(__name__)

applicants = [
    {"id": 1, "name": "Rhea Joy", "status": "Approved"},
    {"id": 2, "name": "Juan", "status": "Pending"}
]

# GET all applicants
@app.route("/api/applicants", methods=["GET"])
def get_applicants():
    return jsonify(applicants)

# GET single applicant
@app.route("/api/applicants/<int:id>", methods=["GET"])
def get_applicant(id):
    applicant = next((a for a in applicants if a["id"] == id), None)
    if applicant:
        return jsonify(applicant)
    return jsonify({"error": "Not found"}), 404

# POST create new
@app.route("/api/applicants", methods=["POST"])
def create_applicant():
    data = request.get_json()
    new_id = max(a["id"] for a in applicants) + 1
    new_applicant = {
        "id": new_id,
        "name": data["name"],
        "status": "Pending"
    }
    applicants.append(new_applicant)
    return jsonify(new_applicant), 201

# PUT update
@app.route("/api/applicants/<int:id>", methods=["PUT"])
def update_applicant(id):
    applicant = next((a for a in applicants if a["id"] == id), None)
    if not applicant:
        return jsonify({"error": "Not found"}), 404
    
    data = request.get_json()
    applicant["name"] = data.get("name", applicant["name"])
    applicant["status"] = data.get("status", applicant["status"])
    return jsonify(applicant)

# DELETE
@app.route("/api/applicants/<int:id>", methods=["DELETE"])
def delete_applicant(id):
    global applicants
    applicants = [a for a in applicants if a["id"] != id]
    return "", 204
```

Rhea Joy tested with curl:

```bash
# GET all
curl http://localhost:5000/api/applicants
# [{"id":1,"name":"Rhea Joy","status":"Approved"}, ...]

# GET one
curl http://localhost:5000/api/applicants/1
# {"id":1,"name":"Rhea Joy","status":"Approved"}

# POST create
curl -X POST -H "Content-Type: application/json" \
     -d '{"name":"Maria"}' \
     http://localhost:5000/api/applicants
# {"id":3,"name":"Maria","status":"Pending"}

# PUT update
curl -X PUT -H "Content-Type: application/json" \
     -d '{"status":"Approved"}' \
     http://localhost:5000/api/applicants/3

# DELETE
curl -X DELETE http://localhost:5000/api/applicants/3
```

"Full CRUD operations," Kuya Miguel noted. "Create, Read, Update, Delete. The four fundamental data operations, now accessible via HTTP."

The municipal IT team integrated successfully:

```javascript
// Their dashboard code
fetch('http://barangay-system:5000/api/applicants')
    .then(res => res.json())
    .then(data => {
        console.log(`Total applicants: ${data.length}`);
        displayInDashboard(data);
    });
```

Tian documented the API:

```
## Scholarship API Documentation

### Endpoints

GET    /api/applicants       - List all applicants
GET    /api/applicants/:id   - Get single applicant
POST   /api/applicants       - Create new applicant
PUT    /api/applicants/:id   - Update applicant
DELETE /api/applicants/:id   - Delete applicant

### Response Codes

200 - Success
201 - Created
204 - Deleted (no content)
404 - Not Found
400 - Bad Request
```

"REST APIs are the universal language of web services," Kuya Miguel explained. "Your Python backend can serve JavaScript frontends, mobile apps, other servers—anything that speaks HTTP."

The scholarship system now had two interfaces:
1. HTML templates for human users
2. JSON API for machines

"One backend, multiple frontends," Rhea Joy realized. "This is how modern systems scale."

_Next up: Data Modeling and ER Diagrams!_ 📊

**Next:** Quiz then exercises.