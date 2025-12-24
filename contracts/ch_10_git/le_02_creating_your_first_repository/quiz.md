# Quiz: Creating Your First Repository

Answer the following questions to check your understanding of this lesson.

## Question 1

What command initializes a new Git repository?

A) `git start`
B) `git init`
C) `git create`
D) `git new`

**Correct Answer: B**

**Explanation:** `git init` is the command that initializes a new Git repository in the current directory. It creates the `.git` directory with all necessary Git configuration files.

---

## Question 2

What is stored in the `.git` directory?

A) Your project source code
B) Backup copies of your files
C) All version control information including commits, branches, and configuration
D) Only branch information

**Correct Answer: C**

**Explanation:** The `.git` directory contains all the metadata and history for your repository, including commit objects, branch references, configuration files, and more.

---

## Question 3

Which command sets your name for Git commits?

A) `git set-name`
B) `git config user.name`
C) `git name --global`
D) `git user --name`

**Correct Answer: B**

**Explanation:** The command `git config user.name "Your Name"` sets the name that will appear in commit history.

---

## Question 4

What is the difference between global and local Git configuration?

A) There is no difference
B) Global applies to all repositories, local applies only to the current repository
C) Local is faster than global
D) Global is only for administrators

**Correct Answer: B**

**Explanation:** Global configuration (with `--global` flag) applies to all repositories on your computer, while local configuration (without the flag) applies only to the current repository.

---

## Question 5

What does `git status` display?

A) Only committed files
B) Only new files
C) The current branch, staged changes, unstaged changes, and untracked files
D) Files that have been deleted

**Correct Answer: C**

**Explanation:** `git status` provides a comprehensive overview of your repository's current state, showing which branch you're on and the status of all your files.

---

## Question 6

True or False: You can have multiple repositories on your computer, each with its own `.git` directory.

**Correct Answer: True**

**Explanation:** Each directory can be its own independent Git repository with its own `.git` folder. They don't interfere with each other.

---

**Reflection:** How does Git differ from just saving multiple versions of a file manually? What advantages do you see?
