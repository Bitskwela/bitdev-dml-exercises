# Quiz: Staging and Committing

Answer the following questions to check your understanding of this lesson.

## Question 1

What is the staging area in Git?

A) A folder where Git stores backup files
B) An intermediate area where changes are prepared before committing
C) The remote server where code is uploaded
D) A log file that tracks all errors

**Correct Answer: B**

**Explanation:** The staging area (also called the index) is where you prepare and review changes before making a permanent commit to the repository.

---

## Question 2

Which command adds a specific file to the staging area?

A) `git commit file.txt`
B) `git push file.txt`
C) `git add file.txt`
D) `git stage file.txt`

**Correct Answer: C**

**Explanation:** The `git add` command moves changes from your working directory to the staging area, preparing them for the next commit.

---

## Question 3

What does `git add .` do?

A) Adds only the current file to staging
B) Adds all modified and new files in the current directory and subdirectories to staging
C) Creates a new branch
D) Deletes all files from staging

**Correct Answer: B**

**Explanation:** The `.` (dot) represents the current directory, so `git add .` stages all changes including new, modified, and deleted files recursively.

---

## Question 4

Which command creates a commit with a message?

A) `git save -m "message"`
B) `git commit -m "message"`
C) `git push -m "message"`
D) `git add -m "message"`

**Correct Answer: B**

**Explanation:** The `git commit -m "message"` command creates a new commit with the staged changes and attaches your descriptive message to it.

---

## Question 5

True or False: You can commit changes directly without staging them first.

**Correct Answer: True**

**Explanation:** Using `git commit -a -m "message"` or `git commit -am "message"` will automatically stage all tracked modified files and commit them. However, new untracked files still need to be added first with `git add`.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
