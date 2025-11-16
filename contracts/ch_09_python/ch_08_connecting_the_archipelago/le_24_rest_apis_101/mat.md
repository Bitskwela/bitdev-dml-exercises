## Lesson 24: REST APIs 101

Story: Mobile app needs data. Tian builds JSON API: "RESTful endpoints—GET lists, POST creates, PUT updates, DELETE removes."

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

**Next:** Quiz then exercises.