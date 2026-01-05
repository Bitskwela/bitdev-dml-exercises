# Quiz: Undoing Changes

Answer the following questions to check your understanding of this lesson.

## Question 1

Which command discards changes in a file and restores it to the last committed version?

A) `git undo file.txt`
B) `git restore file.txt`
C) `git revert file.txt`
D) `git delete file.txt`

**Correct Answer: B**

**Explanation:** The `git restore` command discards changes in the working directory, restoring the file to match the last commit or staged version.

---

## Question 2

What is the difference between `git reset` and `git revert`?

A) They are exactly the same
B) `reset` rewrites history, `revert` creates a new commit that undoes changes
C) `revert` deletes commits permanently

**Correct Answer: B**

**Explanation:** `git reset` moves the branch pointer backward (rewriting history), while `git revert` creates a new commit that undoes the changes of a previous commit, preserving history.

---

## Question 3

Which command unstages a file without discarding changes?

A) `git restore --staged file.txt`
B) `git delete --staged file.txt`
C) `git remove file.txt`

**Correct Answer: A**

**Explanation:** The `git restore --staged` command removes a file from the staging area but keeps the changes in your working directory.

---

## Question 4

True or False: `git reset --hard` permanently discards uncommitted changes.

**Correct Answer: True**

**Explanation:** `git reset --hard` discards all changes in both the staging area and working directory. Uncommitted work will be lost permanently, so use it with caution!

---

## Question 5

What is the purpose of `git reset HEAD~1`?

A) To move HEAD back one commit (keeping changes based on flags used)
B) To permanently delete the repository
C) To push changes to remote

**Correct Answer: A**

**Explanation:** `git reset HEAD~1` moves HEAD back one commit. With `--soft`, changes stay staged; with `--mixed` (default), changes are unstaged; with `--hard`, changes are discarded.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
