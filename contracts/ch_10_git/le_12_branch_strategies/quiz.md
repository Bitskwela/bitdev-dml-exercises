# Quiz: Branch Strategies

Answer the following questions to check your understanding of this lesson.

## Question 1

What is Git Flow?

A) A command to speed up Git operations
B) A branching model with specific branch types (main, develop, feature, release, hotfix)
C) A tool for visualizing commits
D) An alternative to Git

**Correct Answer: B**

**Explanation:** Git Flow is a branching strategy that defines specific branch types and their purposes, ideal for projects with scheduled releases.

---

## Question 2

What is GitHub Flow?

A) A complex branching strategy with many branch types
B) A simpler workflow: branch from main, work, open PR, merge
C) A tool only available on GitHub
D) A way to download code

**Correct Answer: B**

**Explanation:** GitHub Flow is simpler than Git Flow—create a branch from main, make changes, open a pull request, and merge after review.

---

## Question 3

When might you choose Git Flow over GitHub Flow?

A) When you need continuous deployment
B) When you have scheduled releases and need to maintain multiple versions
C) When working solo

**Correct Answer: B**

**Explanation:** Git Flow works well for projects with versioned releases where you need to maintain hotfixes for older versions while developing new features.

---

## Question 4

True or False: Trunk-based development encourages long-lived feature branches.

**Correct Answer: False**

**Explanation:** Trunk-based development focuses on short-lived branches (or no branches) with developers integrating to main/trunk frequently—often multiple times a day.

---

## Question 5

What is the purpose of a "develop" branch in Git Flow?

A) To store deleted files
B) To serve as the integration branch for features before release
C) To replace the main branch

**Correct Answer: B**

**Explanation:** In Git Flow, the develop branch is where features are integrated and tested before being merged into a release branch and eventually main.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
