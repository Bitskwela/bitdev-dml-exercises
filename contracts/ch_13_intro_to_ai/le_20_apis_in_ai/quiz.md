# Lesson 20 Quiz: APIs in AI

---
# Quiz 1
## Scenario: The Restaurant Analogy
Dan learned APIs from Kuya JM over coffee.

**Question 1:** An API is best understood as:
A. A type of AI
B. The "waiter" between your code and a remote service
C. A Python library
D. A database

**Answer:** B
**Explanation:** API = Application Programming Interface — a defined way for programs to talk to each other. The restaurant analogy: customer (your code) → waiter (API) → kitchen (server).

---

**Question 2:** Which HTTP method creates new data?
A. GET
B. POST
C. DELETE
D. HEAD

**Answer:** B
**Explanation:** POST sends data to create new resources. GET fetches, PUT updates, DELETE removes.

---

**Question 3:** Status code 200 means:
A. The server exploded
B. Success — OK
C. Unauthorized
D. Rate limited

**Answer:** B
**Explanation:** 2xx = success, 3xx = redirect, 4xx = your mistake, 5xx = server's mistake. 200 is the classic "OK".

---

**Question 4:** What should you NEVER do with an API key?
A. Store it in an environment variable
B. Commit it to a git repository
C. Load it from a `.env` file
D. Rotate it when exposed

**Answer:** B
**Explanation:** Committing keys to git is the #1 way to leak them. Use env vars and `.env` (gitignored) instead.

---

**Question 5:** JSON is:
A. A type of Python code
B. A text-based data format that APIs commonly use
C. A Python library
D. A new AI model

**Answer:** B
**Explanation:** JSON (JavaScript Object Notation) is the de facto standard for API data exchange. `json.dumps()` and `json.loads()` convert between Python dicts and JSON strings.

---
# Quiz 2
## Scenario: Status Codes
Dan got a 429 response and needed to understand why.

**Question 6:** Status code 429 means:
A. Success
B. Server down
C. Too many requests — you're being rate limited
D. Not found

**Answer:** C
**Explanation:** 429 = Too Many Requests. The API is throttling you. Wait, then retry with exponential backoff.

---

**Question 7:** What's the best Python library for API calls?
A. pandas
B. requests
C. matplotlib
D. random

**Answer:** B
**Explanation:** `requests` is the standard for HTTP in Python. Clean API: `requests.get(url)`, `requests.post(url, json=...)`.

---
**Next:** Proceed to Lesson 20 exercises.
