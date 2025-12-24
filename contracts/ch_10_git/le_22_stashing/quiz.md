# Quiz: Stashing

Answer the following questions to check your understanding of this lesson.

## Question 1

What does `git stash` do?

A) Permanently deletes uncommitted changes
B) Temporarily saves uncommitted changes so you can switch branches
C) Commits your changes automatically
D) Pushes changes to the remote

**Correct Answer: B**

**Explanation:** Stashing saves your modified tracked files and staged changes, letting you work on something else. You can reapply them later.

---

## Question 2

Which command shows your list of stashes?

A) `git stash show`
B) `git stash list`
C) `git stash all`
D) `git list stash`

**Correct Answer: B**

**Explanation:** `git stash list` displays all stashed changes with their stash reference (stash@{0}, stash@{1}, etc.).

---

## Question 3

How do you apply the most recent stash and keep it in the stash list?

A) `git stash pop`
B) `git stash apply`
C) `git stash restore`

**Correct Answer: B**

**Explanation:** `git stash apply` applies the stash but keeps it in your stash list. Use `git stash pop` to apply AND remove it.

---

## Question 4

True or False: `git stash pop` applies the stash and removes it from the stash list.

**Correct Answer: True**

**Explanation:** `pop` applies the most recent stash and automatically removes it from the stash list. If there's a conflict, the stash is kept.

---

## Question 5

What is the purpose of `git stash drop`?

A) To apply a stash
B) To delete a specific stash without applying it
C) To create a new stash

**Correct Answer: B**

**Explanation:** `git stash drop` removes a stash from the list without applying it. Use this to clean up old stashes you no longer need.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
