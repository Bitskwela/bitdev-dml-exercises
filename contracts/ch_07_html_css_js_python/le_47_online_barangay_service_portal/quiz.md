# Quiz: Lesson 47 - Online Barangay Service Portal (Final Project)

---

# Quiz 1

### Question 1
**What is the main purpose of this final project?**
- A) To learn a new programming language
- B) To integrate all concepts learned from Lesson 1 to Lesson 46
- C) To copy code from the internet
- D) To only practice HTML

**Answer:** B) To integrate all concepts learned from Lesson 1 to Lesson 46

---

### Question 2
**Which authentication feature is required in the project?**
- A) OAuth with Google
- B) Password hashing with werkzeug
- C) Fingerprint scanning
- D) Face recognition

**Answer:** B) Password hashing with werkzeug

---

### Question 3
**How many core modules must the Barangay Portal have?**
- A) 2
- B) 3
- C) 5
- D) 10

**Answer:** C) 5 (Authentication, Complaints, Announcements, Documents, Profile)

---

### Question 4
**What are the three user roles in the system?**
- A) Guest, Member, Owner
- B) Admin, Staff, Resident
- C) User, Moderator, Administrator
- D) Basic, Premium, Enterprise

**Answer:** B) Admin, Staff, Resident

---

### Question 5
**Which database should be used in production?**
- A) SQLite
- B) MongoDB
- C) PostgreSQL
- D) Excel

**Answer:** C) PostgreSQL

---

### Question 6
**What file specifies how to run your Flask app in production?**
- A) app.py
- B) Procfile
- C) config.py
- D) run.py

**Answer:** B) Procfile

---

### Question 7
**What is the command in the Procfile for a Flask app?**
- A) `python app.py`
- B) `flask run`
- C) `web: gunicorn app:app`
- D) `start app`

**Answer:** C) `web: gunicorn app:app`

---

# Quiz 2

### Question 8
**What decorator protects routes that require login?**
- A) `@protected`
- B) `@login_required`
- C) `@authenticated`
- D) `@secure`

**Answer:** B) `@login_required`

---

### Question 9
**Which Flask extension manages user sessions and authentication?**
- A) Flask-Auth
- B) Flask-Session
- C) Flask-Login
- D) Flask-User

**Answer:** C) Flask-Login

---

### Question 10
**What should DEBUG be set to in production?**
- A) True
- B) False
- C) 1
- D) "production"

**Answer:** B) False

---

### Question 11
**How do you create a relationship between User and Complaint models?**
- A) Using foreign keys with `db.ForeignKey()`
- B) Using arrays
- C) Using strings
- D) They don't need relationships

**Answer:** A) Using foreign keys with `db.ForeignKey()`

---

### Question 12
**What is the purpose of `db.session.commit()`?**
- A) To read data from database
- B) To save changes to the database
- C) To delete the database
- D) To create a new database

**Answer:** B) To save changes to the database

---

### Question 13
**Which status values are valid for complaints?**
- A) open, closed
- B) pending, in_progress, resolved
- C) new, old
- D) active, inactive

**Answer:** B) pending, in_progress, resolved

---

### Question 14
**What is the main benefit of role-based access control?**
- A) Makes the app slower
- B) Different users see different features based on their role
- C) Everyone can do everything
- D) Only admins can use the app

**Answer:** B) Different users see different features based on their role

---

### Question 15
**What is the final deliverable for this project?**
- A) Just the code
- B) GitHub repo + deployed URL + README
- C) Only a video
- D) A printed document

**Answer:** B) GitHub repo + deployed URL + README
