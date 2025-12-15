# Quiz: Merging Branches (Fast-Forward)

Answer the following questions to check your understanding of this lesson.

## Question 1

What is a fast-forward merge?

A) A merge that happens very quickly
B) A merge where Git simply moves the branch pointer forward because there's no divergent history
C) A merge that skips conflict resolution
D) A merge between two remote repositories

**Correct Answer: B**

**Explanation:** A fast-forward merge occurs when the target branch hasn't diverged from the source branch. Git just moves the pointer forward—no new merge commit is created.

---

## Question 2

Which command merges the "feature" branch into your current branch?

A) `git combine feature`
B) `git merge feature`
C) `git join feature`

**Correct Answer: B**

**Explanation:** The `git merge <branch>` command integrates changes from the specified branch into your current branch.

---

## Question 3

When does a fast-forward merge occur?

A) When both branches have new commits
B) When the current branch has no new commits since the branching point
C) When there are merge conflicts

**Correct Answer: B**

**Explanation:** Fast-forward merges happen when the current branch hasn't moved forward since the feature branch was created—there's a linear path to follow.

---

## Question 4

True or False: A fast-forward merge creates a new merge commit.

**Correct Answer: False**

**Explanation:** Fast-forward merges don't create a merge commit—they simply move the branch pointer forward. You can use `--no-ff` to force a merge commit if you want to preserve branch history.

---

## Question 5

What is the purpose of `git merge --no-ff`?

A) To prevent any merge from happening
B) To force a merge commit even when fast-forward is possible
C) To merge faster

**Correct Answer: B**

**Explanation:** The `--no-ff` flag creates a merge commit even when Git could do a fast-forward. This preserves the history of a feature branch.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
