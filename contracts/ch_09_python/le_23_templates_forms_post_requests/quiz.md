# Lesson 23 Quiz: Templates & Forms

---
# Quiz 1
## Scenario: HTML Generation
Tian adopts templates.

**Question 1:** Flask template engine:
A. Django
B. Jinja2
C. Pug
D. Handlebars

**Question 2:** Render template function:
A. app.template("file.html")
B. render_template("file.html")
C. flask.render("file.html")
D. template.load("file.html")

**Question 3:** Variable in Jinja2 template:
A. {name}
B. {{name}}
C. <name>
D. $name

**Question 4:** Loop syntax:
A. {% for x in y %}
B. {{ for x in y }}
C. <for x in y>
D. loop(x in y)

**Question 5:** Templates directory default:
A. views/
B. templates/
C. html/
D. pages/

---
# Quiz 2
## Scenario: Form Processing
Rhea Joy handles submissions.

**Question 6:** Access form field "name":
A. request.form.name
B. request.form["name"]
C. request.data["name"]
D. request.get("name")

**Question 7:** POST vs GET in forms:
A. No difference
B. POST for data submission, GET for retrieval
C. POST slower always
D. GET more secure

**Question 8:** Redirect function:
A. return redirect(url_for("route_name"))
B. return move_to("route_name")
C. return forward("route_name")
D. return goto("route_name")

**Question 9:** Flash message purpose:
A. Error only
B. Temporary one-time message to user
C. Permanent storage
D. Debugging tool

**Question 10:** Template benefit:
A. Slower rendering
B. Separation of concerns (HTML vs logic)
C. More bugs
D. Harder maintenance

---
## Answers
1: B  
2: B  
3: B  
4: A  
5: B  
6: B  
7: B  
8: A  
9: B  
10: B  

---
## Detailed Explanations
Q1 Jinja2 built-in Flask template engine.  
Q2 render_template() renders Jinja2 templates.  
Q3 {{ }} interpolates variables.  
Q4 {% for %} syntax for loops.  
Q5 Default templates/ directory.  
Q6 request.form["field"] accesses form data.  
Q7 POST for data submission; GET for fetching.  
Q8 redirect(url_for("route")) redirects to route.  
Q9 Flash displays one-time message (e.g., success).  
Q10 Templates separate presentation from logic.  

---
**Next:** Proceed to Lesson 23 exercises.