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

**Answer: B**  
**Explanation:** Jinja2 built-in Flask template engine.

---

**Question 2:** Render template function:
A. app.template("file.html")
B. render_template("file.html")
C. flask.render("file.html")
D. template.load("file.html")

**Answer: B**  
**Explanation:** render_template() renders Jinja2 templates.

---

**Question 3:** Variable in Jinja2 template:
A. {name}
B. {{name}}
C. <name>
D. $name

**Answer: B**  
**Explanation:** {{ }} interpolates variables.

---

**Question 4:** Loop syntax:
A. {% for x in y %}
B. {{ for x in y }}
C. <for x in y>
D. loop(x in y)

**Answer: A**  
**Explanation:** {% for %} syntax for loops.

---

**Question 5:** Templates directory default:
A. views/
B. templates/
C. html/
D. pages/

**Answer: B**  
**Explanation:** Default templates/ directory.

---
# Quiz 2
## Scenario: Form Processing
Rhea Joy handles submissions.

**Question 6:** Access form field "name":
A. request.form.name
B. request.form["name"]
C. request.data["name"]
D. request.get("name")

**Answer: B**  
**Explanation:** request.form["field"] accesses form data.

---

**Question 7:** POST vs GET in forms:
A. No difference
B. POST for data submission, GET for retrieval
C. POST slower always
D. GET more secure

**Answer: B**  
**Explanation:** POST for data submission; GET for fetching.

---

**Question 8:** Redirect function:
A. return redirect(url_for("route_name"))
B. return move_to("route_name")
C. return forward("route_name")
D. return goto("route_name")

**Answer: A**  
**Explanation:** redirect(url_for("route")) redirects to route.

---

**Question 9:** Flash message purpose:
A. Error only
B. Temporary one-time message to user
C. Permanent storage
D. Debugging tool

**Answer: B**  
**Explanation:** Flash displays one-time message (e.g., success).

---

**Question 10:** Template benefit:
A. Slower rendering
B. Separation of concerns (HTML vs logic)
C. More bugs
D. Harder maintenance

**Answer: B**  
**Explanation:** Templates separate presentation from logic.

---
**Next:** Proceed to Lesson 23 exercises.