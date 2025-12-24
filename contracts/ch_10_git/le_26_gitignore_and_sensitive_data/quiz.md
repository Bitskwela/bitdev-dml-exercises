# Quiz: Gitignore and Sensitive Data

Answer the following questions to check your understanding of this lesson.

## Question 1

What is the purpose of a .gitignore file?

A) To delete files from your computer
B) To specify files and patterns that Git should not track
C) To hide files from your file explorer
D) To encrypt sensitive files

**Correct Answer: B**

**Explanation:** `.gitignore` tells Git which files or directories to ignore and not include in version control (like build outputs, dependencies, secrets).

---

## Question 2

Which pattern in .gitignore ignores all .log files?

A) `log.*`
B) `*.log`
C) `all.log`
D) `logs/`

**Correct Answer: B**

**Explanation:** The `*.log` pattern uses wildcard `*` to match any filename ending with `.log`.

---

## Question 3

What should you do if you accidentally committed a file with sensitive data (like API keys)?

A) Just delete the file and commit again
B) Remove it from history using tools like `git filter-branch` or BFG, and rotate the exposed credentials
C) Ignore it and hope no one notices

**Correct Answer: B**

**Explanation:** Simply deleting a file doesn't remove it from history. You must rewrite history AND consider the secret compromised—rotate it immediately.

---

## Question 4

True or False: Adding a file to .gitignore removes it from existing commits.

**Correct Answer: False**

**Explanation:** `.gitignore` only affects untracked files. If a file was already committed, you need to remove it with `git rm --cached` and then commit.

---

## Question 5

What is a good practice for handling environment-specific configuration?

A) Commit all secrets to the repository
B) Use .env files (ignored by Git) and .env.example templates
C) Share passwords via email

**Correct Answer: B**

**Explanation:** Use `.env` files for secrets (add to .gitignore), and provide a `.env.example` template with placeholder values so team members know what variables to set.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
