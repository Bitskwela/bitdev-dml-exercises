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

**Question 2:** @app.route("/") decorator purpose:
A. Defines function
B. Maps URL to function
C. Starts server
D. Closes connection

**Question 3:** app.run(debug=True) enables:
A. Production mode
B. Auto-reload, detailed errors
C. Faster execution
D. Database debug

**Question 4:** Dynamic route syntax:
A. /user/<name>
B. /user/:name
C. /user/{name}
D. /user/$name

**Question 5:** Default Flask port:
A. 80
B. 5000
C. 8080
D. 3000

---
# Quiz 2
## Scenario: Request Handling
Rhea Joy processes submissions.

**Question 6:** Access query param ?q=test:
A. request.params["q"]
B. request.args.get("q")
C. request.query["q"]
D. request.param("q")

**Question 7:** Return JSON response:
A. return {"key":"val"}
B. jsonify({"key":"val"})
C. json.return({"key":"val"})
D. response.json({"key":"val"})

**Question 8:** Route accepting POST:
A. @app.route("/path")
B. @app.route("/path", methods=["POST"])
C. @app.post("/path")
D. @app.method("/path","POST")

**Question 9:** Check request method:
A. request.method == "POST"
B. request.type == "POST"
C. request.is_post()
D. request.mode == "POST"

**Question 10:** Flask advantage:
A. Only Python 2
B. Lightweight, flexible
C. No routing support
D. Requires Java

---
## Answers
1: B  
2: B  
3: B  
4: A  
5: B  
6: B  
7: B  
8: B  
9: A  
10: B  

---
## Detailed Explanations
Q1 Flask micro framework (lightweight core).  
Q2 @app.route decorator maps URL to function.  
Q3 debug=True auto-reloads, shows traceback.  
Q4 <name> syntax captures dynamic URL segment.  
Q5 Default port 5000 (development).  
Q6 request.args.get("q") for query params.  
Q7 jsonify() returns JSON response with correct headers.  
Q8 methods=["POST"] in route decorator.  
Q9 request.method property.  
Q10 Flask flexible, minimal boilerplate.  

---
**Next:** Proceed to Lesson 22 exercises.