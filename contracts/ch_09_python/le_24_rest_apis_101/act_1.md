# REST APIs Activity

Practice building RESTful endpoints.

### Task 1: GET Endpoint
```python
from flask import Flask, jsonify

app = Flask(__name__)

applicants = [{"id": 1, "name": "Ana"}, {"id": 2, "name": "Ben"}]

# Your code: GET /applicants returning JSON

```

### Task 2: POST Endpoint
```python
from flask import request

# Your code: POST /applicants accepting JSON, adding to list

```

### Task 3: DELETE Endpoint
```python
# Your code: DELETE /applicants/<id> removing from list

```

### Task 4: Status Codes
```python
# Your code: return 404 if ID not found, 201 for created

```

## Reflection
**Two benefits of REST API:**
1. _[Language-agnostic, any client can consume]_
2. _[Stateless, easier to scale]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
from flask import Flask, jsonify, request

app = Flask(__name__)

applicants = [{"id": 1, "name": "Ana"}, {"id": 2, "name": "Ben"}]

# Task 1
@app.route('/applicants', methods=['GET'])
def get_applicants():
    return jsonify(applicants)

# Task 2
@app.route('/applicants', methods=['POST'])
def create_applicant():
    data = request.get_json()
    new_id = max(a['id'] for a in applicants) + 1
    new_applicant = {"id": new_id, **data}
    applicants.append(new_applicant)
    return jsonify(new_applicant), 201  # Created

# Task 3
@app.route('/applicants/<int:id>', methods=['DELETE'])
def delete_applicant(id):
    global applicants
    applicants = [a for a in applicants if a['id'] != id]
    return '', 204  # No Content

# Task 4 (integrated above)
@app.route('/applicants/<int:id>', methods=['GET'])
def get_applicant(id):
    applicant = next((a for a in applicants if a['id'] == id), None)
    if applicant is None:
        return jsonify({"error": "Not found"}), 404
    return jsonify(applicant)

if __name__ == '__main__':
    app.run(debug=True)
```

**Test with curl:**
```bash
# GET all
curl http://localhost:5000/applicants

# POST new
curl -X POST http://localhost:5000/applicants \
  -H "Content-Type: application/json" \
  -d '{"name":"Carla"}'

# DELETE
curl -X DELETE http://localhost:5000/applicants/1
```

**Reflection:** REST APIs: (1) Any client (mobile, web, IoT), (2) Stateless scales horizontally, (3) Cacheable responses, (4) Standard HTTP methods

</details>
