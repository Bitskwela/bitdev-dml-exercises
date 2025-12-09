# Lesson 22 Quiz: Flask Basics

---
# Quiz 1
## Scenario: First Web App
Tian launches Flask.

**Question 1:** Flask classification:
A. Heavy full-stack framework
B. Micro web framework
C. Database system
D. Front-end library

**Answer: B**  
**Explanation:** Flask micro framework (lightweight core).

---

**Question 2:** @app.route("/") decorator purpose:
A. Defines function
B. Maps URL to function
C. Starts server
D. Closes connection

**Answer: B**  
**Explanation:** @app.route decorator maps URL to function.

---

**Question 3:** app.run(debug=True) enables:
A. Production mode
B. Auto-reload, detailed errors
C. Faster execution
D. Database debug

**Answer: B**  
**Explanation:** debug=True auto-reloads, shows traceback.

---

**Question 4:** Dynamic route syntax:
A. /user/<name>
B. /user/:name
C. /user/{name}
D. /user/$name

**Answer: A**  
**Explanation:** <name> syntax captures dynamic URL segment.

---

**Question 5:** Default Flask port:
A. 80
B. 5000
C. 8080
D. 3000

**Answer: B**  
**Explanation:** Default port 5000 (development).

---
# Quiz 2
## Scenario: Request Handling
Rhea Joy processes submissions.

**Question 6:** Access query param ?q=test:
A. request.params["q"]
B. request.args.get("q")
C. request.query["q"]
D. request.param("q")

**Answer: B**  
**Explanation:** request.args.get("q") for query params.

---

**Question 7:** Return JSON response:
A. return {"key":"val"}
B. jsonify({"key":"val"})
C. json.return({"key":"val"})
D. response.json({"key":"val"})

**Answer: B**  
**Explanation:** jsonify() returns JSON response with correct headers.

---

**Question 8:** Route accepting POST:
A. @app.route("/path")
B. @app.route("/path", methods=["POST"])
C. @app.post("/path")
D. @app.method("/path","POST")

**Answer: B**  
**Explanation:** methods=["POST"] in route decorator.

---

**Question 9:** Check request method:
A. request.method == "POST"
B. request.type == "POST"
C. request.is_post()
D. request.mode == "POST"

**Answer: A**  
**Explanation:** request.method property.

---

**Question 10:** Flask advantage:
A. Only Python 2
B. Lightweight, flexible
C. No routing support
D. Requires Java

**Answer: B**  
**Explanation:** Flask flexible, minimal boilerplate.

---
**Next:** Proceed to Lesson 22 exercises.