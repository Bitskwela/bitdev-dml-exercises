# Quiz: Lesson 43 - Authentication with JS + Flask

---

# Quiz 1

### Question 1
**What is the main difference between authentication and authorization?**
- A) Authentication is for admins, authorization is for users
- B) Authentication verifies identity, authorization determines permissions
- C) They are the same thing
- D) Authentication uses passwords, authorization uses tokens

**Answer:** B) Authentication verifies identity, authorization determines permissions

---

### Question 2
**Why should you NEVER store passwords in plain text?**
- A) It takes up too much database space
- B) It's slower to query
- C) If the database is compromised, all passwords are exposed
- D) Users won't remember them

**Answer:** C) If the database is compromised, all passwords are exposed

---

### Question 3
**What is password hashing?**
- A) Encrypting passwords so they can be decrypted later
- B) One-way transformation that can't be reversed
- C) Compressing passwords to save space
- D) Storing passwords in a hash table

**Answer:** B) One-way transformation that can't be reversed

---

### Question 4
**Which Flask function is used to hash passwords?**
- A) `hash_password()`
- B) `encrypt_password()`
- C) `generate_password_hash()`
- D) `secure_password()`

**Answer:** C) `generate_password_hash()`

---

### Question 5
**What is a session in web development?**
- A) The time a user spends on a website
- B) Server-side storage of user state
- C) A meeting between developers
- D) Client-side storage like localStorage

**Answer:** B) Server-side storage of user state

---

### Question 6
**What does the `@login_required` decorator do?**
- A) Forces users to create strong passwords
- B) Encrypts all data in the route
- C) Protects routes by requiring authentication
- D) Logs all user activity

**Answer:** C) Protects routes by requiring authentication

---

### Question 7
**What should you include when making fetch requests that need cookies/sessions?**
- A) `credentials: 'include'`
- B) `session: true`
- C) `cookies: 'enabled'`
- D) `auth: 'required'`

**Answer:** A) `credentials: 'include'`

---

# Quiz 2

### Question 8
**What is SQL injection?**
- A) A way to optimize database queries
- B) A security vulnerability where attackers inject malicious SQL code
- C) A method to backup databases
- D) A type of database transaction

**Answer:** B) A security vulnerability where attackers inject malicious SQL code

---

### Question 9
**What is a good minimum password length?**
- A) 4 characters
- B) 6 characters
- C) 8 characters
- D) 20 characters

**Answer:** C) 8 characters

---

### Question 10
**What does CSRF stand for?**
- A) Client-Side Request Forgery
- B) Cross-Site Request Forgery
- C) Cached Session Request Format
- D) Controlled Security Response Framework

**Answer:** B) Cross-Site Request Forgery

---

### Question 11
**What is rate limiting used for?**
- A) To make the website faster
- B) To prevent too many requests from one user (brute force attacks)
- C) To limit database size
- D) To reduce server costs

**Answer:** B) To prevent too many requests from one user (brute force attacks)

---

### Question 12
**In the Philippines, which law governs data privacy?**
- A) RA 9165
- B) RA 10173 (Data Privacy Act of 2012)
- C) RA 8293
- D) RA 7610

**Answer:** B) RA 10173 (Data Privacy Act of 2012)

---

### Question 13
**What happens when you call `session.clear()` in Flask?**
- A) Deletes the database
- B) Logs out the user by removing session data
- C) Clears the browser cache
- D) Resets the password

**Answer:** B) Logs out the user by removing session data

---

### Question 14
**What should you check before allowing a user to access protected content?**
- A) Their IP address
- B) Their browser type
- C) If they have an active session with valid user_id
- D) Their screen resolution

**Answer:** C) If they have an active session with valid user_id

---

### Question 15
**Why is `SESSION_COOKIE_HTTPONLY` set to True?**
- A) To make sessions faster
- B) To prevent JavaScript from accessing the session cookie (XSS protection)
- C) To enable HTTP/2
- D) To compress cookie data

**Answer:** B) To prevent JavaScript from accessing the session cookie (XSS protection)
