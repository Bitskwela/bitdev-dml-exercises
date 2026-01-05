# Quiz: Rebasing

Answer the following questions to check your understanding of this lesson.

## Question 1

What does `git rebase` do?

A) Deletes all commits
B) Moves or "replays" your commits onto a different base commit
C) Creates a backup of your repository
D) Merges two repositories together

**Correct Answer: B**

**Explanation:** Rebasing takes commits from your branch and replays them on top of another branch, creating a linear history.

---

## Question 2

What is the difference between merge and rebase?

A) They are exactly the same
B) Merge creates a merge commit; rebase creates a linear history without merge commits
C) Rebase only works on GitHub
D) Merge deletes commits

**Correct Answer: B**

**Explanation:** Merge preserves branch history with a merge commit. Rebase rewrites history to be linear as if you branched from the latest commit.

---

## Question 3

Which command rebases your current branch onto main?

A) `git rebase main`
B) `git merge --rebase main`
C) `git base main`

**Correct Answer: A**

**Explanation:** While on your feature branch, `git rebase main` replays your commits on top of the latest main.

---

## Question 4

True or False: You should never rebase commits that have been pushed to a shared branch.

**Correct Answer: True**

**Explanation:** Rebasing rewrites commit history. If others have based work on those commits, their history will conflict with yours, causing problems.

---

## Question 5

What is the main advantage of rebasing?

A) It's faster than merge
B) It creates a cleaner, linear commit history
C) It automatically fixes bugs

**Correct Answer: B**

**Explanation:** Rebasing produces a straight-line history that's easier to read and understand, without merge commits cluttering the log.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
