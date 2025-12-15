# Quiz: Understanding Branches

Answer the following questions to check your understanding of this lesson.

## Question 1

What is a branch in Git?

A) A copy of your repository stored on a remote server
B) A lightweight movable pointer to a specific commit
C) A backup file created automatically by Git
D) A folder where deleted files are stored

**Correct Answer: B**

**Explanation:** A branch in Git is essentially a lightweight pointer to a specific commit. Creating a new branch just creates a new pointer—it doesn't copy any files.

---

## Question 2

What is the default branch name in most Git repositories?

A) `master` or `main`
B) `default`
C) `primary`

**Correct Answer: A**

**Explanation:** Historically, `master` was the default branch name. Many repositories now use `main` as the default, following a more inclusive naming convention.

---

## Question 3

Which command shows all branches in your repository?

A) `git branch`
B) `git list-branches`
C) `git show branches`

**Correct Answer: A**

**Explanation:** The `git branch` command without any arguments lists all local branches. Add `-a` to see remote branches too.

---

## Question 4

True or False: Creating a new branch creates a complete copy of all your project files.

**Correct Answer: False**

**Explanation:** Branches are just pointers to commits—they don't duplicate files. This makes creating branches in Git extremely fast and storage-efficient.

---

## Question 5

What is the purpose of using branches?

A) To work on features or fixes in isolation without affecting the main codebase
B) To permanently delete old code
C) To speed up the computer

**Correct Answer: A**

**Explanation:** Branches allow you to develop features, fix bugs, or experiment in isolation. Once complete, changes can be merged back into the main branch.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
