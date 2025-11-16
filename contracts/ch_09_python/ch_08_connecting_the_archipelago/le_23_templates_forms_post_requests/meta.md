## Lesson 23 Exercises: Templates & Forms

---
### 1. Basic Template (8 minutes)
Create templates/index.html with {{title}}. Route / renders it with title="Portal".

---
### 2. Loop in Template (8 minutes)
Pass list items=["Ana","Ben","Clara"]; template loops and displays <li>.

---
### 3. Conditional Template (7 minutes)
Pass approved=True; template shows "Approved" or "Pending".

---
### 4. HTML Form (10 minutes)
Form with name, age fields. GET shows form; POST prints form data.

---
### 5. Form Validation (8 minutes)
Check age >= 18; if not, render error message in template.

---
### 6. Redirect After POST (7 minutes)
Successful submission redirects to /success route.

---
### 7. Flash Message (8 minutes)
Use flash("Submitted"); display in template using get_flashed_messages().

---
### 8. Stretch: Multi-Step Form (Optional)
/step1 (name), /step2 (age), /confirm (show summary). Use session to store data.

---
### 9. Reflection (3 minutes)
Two advantages of template-based HTML over f-strings.

---
**Next:** Lesson 24 (REST APIs).