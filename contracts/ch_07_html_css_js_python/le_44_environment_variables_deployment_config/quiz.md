# Quiz: Lesson 44 - Environment Variables + Deployment Config

---

# Quiz 1

### Question 1
**What are environment variables?**
- A) Variables that change based on weather
- B) Values stored outside your code, in the system environment
- C) JavaScript variables
- D) CSS custom properties

**Answer:** B) Values stored outside your code, in the system environment

---

### Question 2
**Why should you NEVER hardcode secrets in your code?**
- A) It makes the code run slower
- B) It uses more memory
- C) Secrets become visible if code is shared or pushed to GitHub
- D) It's bad for SEO

**Answer:** C) Secrets become visible if code is shared or pushed to GitHub

---

### Question 3
**What file stores environment variables in a Flask project?**
- A) `config.py`
- B) `.env`
- C) `secrets.txt`
- D) `environment.json`

**Answer:** B) `.env`

---

### Question 4
**Which file should you NEVER commit to Git?**
- A) `.gitignore`
- B) `.env.example`
- C) `.env`
- D) `requirements.txt`

**Answer:** C) `.env`

---

### Question 5
**What is the purpose of `.env.example`?**
- A) To store backup secrets
- B) To show other developers what variables they need to set
- C) To test the application
- D) To deploy to production

**Answer:** B) To show other developers what variables they need to set

---

### Question 6
**Which Python library is used to load `.env` files?**
- A) `flask-env`
- B) `python-dotenv`
- C) `env-loader`
- D) `configparser`

**Answer:** B) `python-dotenv`

---

### Question 7
**How do you access an environment variable in Python?**
- A) `env.get('KEY')`
- B) `os.getenv('KEY')`
- C) `config['KEY']`
- D) `environment.KEY`

**Answer:** B) `os.getenv('KEY')`

---

# Quiz 2

### Question 8
**What should DEBUG be set to in production?**
- A) True
- B) False
- C) 1
- D) "production"

**Answer:** B) False

---

### Question 9
**How do you generate a secure SECRET_KEY?**
- A) Use "password123"
- B) Use your name
- C) Use `secrets.token_urlsafe(32)`
- D) Use "secret"

**Answer:** C) Use `secrets.token_urlsafe(32)`

---

### Question 10
**What is the purpose of a Procfile?**
- A) To list project requirements
- B) To tell deployment platforms how to run your app
- C) To store environment variables
- D) To configure the database

**Answer:** B) To tell deployment platforms how to run your app

---

### Question 11
**Which file lists all Python dependencies?**
- A) `dependencies.txt`
- B) `packages.txt`
- C) `requirements.txt`
- D) `libs.txt`

**Answer:** C) `requirements.txt`

---

### Question 12
**What command generates requirements.txt?**
- A) `pip list > requirements.txt`
- B) `pip freeze > requirements.txt`
- C) `pip install > requirements.txt`
- D) `pip export > requirements.txt`

**Answer:** B) `pip freeze > requirements.txt`

---

### Question 13
**What does SQLALCHEMY_TRACK_MODIFICATIONS do?**
- A) Tracks database changes
- B) When False, disables unnecessary overhead
- C) Enables debugging
- D) Creates database backups

**Answer:** B) When False, disables unnecessary overhead

---

### Question 14
**Which free platform can host Flask apps?**
- A) Microsoft Word
- B) Render
- C) Facebook
- D) Gmail

**Answer:** B) Render

---

### Question 15
**What does SESSION_COOKIE_SECURE = True do?**
- A) Makes cookies taste better
- B) Only sends cookies over HTTPS
- C) Encrypts all data
- D) Disables sessions

**Answer:** B) Only sends cookies over HTTPS
