# Quiz: Cleaning Up Branches

Answer the following questions to check your understanding of this lesson.

## Question 1

Which command deletes a local branch?

A) `git remove branch-name`
B) `git branch -d branch-name`
C) `git delete branch-name`
D) `git branch --remove branch-name`

**Correct Answer: B**

**Explanation:** The `git branch -d` command safely deletes a local branch. Use `-D` (uppercase) to force delete an unmerged branch.

---

## Question 2

What's the difference between `git branch -d` and `git branch -D`?

A) They are identical
B) `-d` is safe delete (checks if merged), `-D` force deletes
C) `-D` is slower
D) `-d` only works on remote branches

**Correct Answer: B**

**Explanation:** The lowercase `-d` refuses to delete branches that haven't been merged. Uppercase `-D` forces deletion regardless of merge status.

---

## Question 3

Which command deletes a remote branch?

A) `git push origin --delete branch-name`
B) `git remote delete branch-name`
C) `git branch -d origin/branch-name`

**Correct Answer: A**

**Explanation:** To delete a branch from the remote, use `git push origin --delete branch-name` or the shorthand `git push origin :branch-name`.

---

## Question 4

True or False: Deleting a branch also deletes all the commits on that branch.

**Correct Answer: False**

**Explanation:** If the branch has been merged, the commits are preserved in the target branch. Only if the branch is unmerged and force-deleted will those commits become orphaned (but still recoverable via reflog temporarily).

---

## Question 5

What is the purpose of cleaning up old branches?

A) To save disk space only
B) To keep the repository organized and reduce confusion
C) To make Git faster

**Correct Answer: B**

**Explanation:** Removing merged or stale branches keeps your branch list clean and helps team members focus on active work.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
