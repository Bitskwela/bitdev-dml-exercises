# Quiz: Cherry-Picking

Answer the following questions to check your understanding of this lesson.

## Question 1

What does `git cherry-pick` do?

A) Deletes selected commits
B) Applies a specific commit from one branch to another
C) Creates a new branch automatically
D) Merges all commits at once

**Correct Answer: B**

**Explanation:** Cherry-picking copies a specific commit and applies it to your current branch, without merging the entire branch.

---

## Question 2

Which command cherry-picks a commit with hash abc123?

A) `git pick abc123`
B) `git cherry-pick abc123`
C) `git copy abc123`
D) `git apply abc123`

**Correct Answer: B**

**Explanation:** The `git cherry-pick <commit-hash>` command applies that specific commit to your current branch.

---

## Question 3

When is cherry-picking useful?

A) When you want to apply a bug fix from one branch to another without full merge
B) When you want to delete a branch
C) When you want to rename commits

**Correct Answer: A**

**Explanation:** Cherry-picking is perfect for applying specific fixes or features to other branches (like backporting a hotfix to a release branch).

---

## Question 4

True or False: Cherry-picking creates a new commit with a different hash than the original.

**Correct Answer: True**

**Explanation:** The cherry-picked commit is a new commit with a new hash, even though the changes are the same. This is because the parent commit is different.

---

## Question 5

What happens if there's a conflict during cherry-pick?

A) The cherry-pick automatically succeeds
B) Git pauses and asks you to resolve the conflict manually
C) The original commit is deleted

**Correct Answer: B**

**Explanation:** Like merge conflicts, you must resolve cherry-pick conflicts manually, then run `git cherry-pick --continue` to proceed.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
