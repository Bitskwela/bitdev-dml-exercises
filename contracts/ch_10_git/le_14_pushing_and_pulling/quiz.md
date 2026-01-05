# Quiz: Pushing and Pulling

Answer the following questions to check your understanding of this lesson.

## Question 1

What does `git push` do?

A) Downloads changes from the remote repository
B) Uploads your local commits to the remote repository
C) Creates a new branch
D) Deletes files from your repository

**Correct Answer: B**

**Explanation:** The `git push` command sends your local commits to the remote repository, sharing your work with others.

---

## Question 2

What does `git pull` do?

A) Only downloads changes without merging
B) Fetches changes from remote AND merges them into your current branch
C) Pushes your changes to remote
D) Creates a pull request

**Correct Answer: B**

**Explanation:** `git pull` is essentially `git fetch` + `git merge`—it downloads remote changes and immediately merges them into your current branch.

---

## Question 3

What does `git push -u origin main` do?

A) Deletes the main branch
B) Pushes to main and sets up tracking between local and remote branches
C) Only works the first time

**Correct Answer: B**

**Explanation:** The `-u` (or `--set-upstream`) flag creates a tracking relationship, so future `git push` and `git pull` commands work without specifying the remote and branch.

---

## Question 4

True or False: You can push to a remote branch even if your local branch is behind.

**Correct Answer: False**

**Explanation:** Git will reject pushes if your local branch is behind the remote. You need to pull (or fetch and merge/rebase) first to incorporate the remote changes.

---

## Question 5

What is the purpose of setting an upstream branch?

A) To delete the branch faster
B) To establish a tracking connection for easier push/pull operations
C) To rename the branch

**Correct Answer: B**

**Explanation:** Once upstream is set, you can simply run `git push` or `git pull` without specifying the remote and branch each time.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
