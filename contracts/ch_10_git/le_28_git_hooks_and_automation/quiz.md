# Quiz: Git Hooks and Automation

Answer the following questions to check your understanding of this lesson.

## Question 1

What are Git hooks?

A) Hardware devices for Git servers
B) Scripts that run automatically at specific Git events (commit, push, etc.)
C) A way to connect to remote repositories
D) Backup mechanisms

**Correct Answer: B**

**Explanation:** Git hooks are customizable scripts in the `.git/hooks` directory that Git executes before or after events like commit, push, receive, etc.

---

## Question 2

Where are Git hooks stored?

A) In the remote repository
B) In the `.git/hooks` directory
C) In a cloud server
D) In the package.json file

**Correct Answer: B**

**Explanation:** Local hooks are stored in `.git/hooks/`. Each hook is a script file named after the event (e.g., `pre-commit`, `post-merge`).

---

## Question 3

What is a common use for the pre-commit hook?

A) To send emails after commits
B) To run linters or tests before allowing a commit
C) To push code automatically

**Correct Answer: B**

**Explanation:** Pre-commit hooks are commonly used to run code formatting, linting, or quick tests to ensure code quality before committing.

---

## Question 4

True or False: Git hooks in the .git/hooks directory are automatically shared with team members when they clone.

**Correct Answer: False**

**Explanation:** The `.git` directory is not tracked. Teams often use tools like Husky or store hooks in a shared directory and set up scripts to install them.

---

## Question 5

What is Husky commonly used for?

A) Compressing Git repositories
B) Managing and sharing Git hooks easily across a team
C) Creating new repositories

**Correct Answer: B**

**Explanation:** Husky is a popular npm package that makes it easy to set up and share Git hooks through package.json, ensuring all team members use the same hooks.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
