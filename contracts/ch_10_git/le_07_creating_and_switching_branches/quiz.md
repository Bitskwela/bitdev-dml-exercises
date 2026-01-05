# Quiz: Creating and Switching Branches

Answer the following questions to check your understanding of this lesson.

## Question 1

Which command creates a new branch called "feature-login"?

A) `git new branch feature-login`
B) `git branch feature-login`
C) `git create feature-login`
D) `git add branch feature-login`

**Correct Answer: B**

**Explanation:** The `git branch <name>` command creates a new branch but doesn't switch to it. It creates a new pointer at your current commit.

---

## Question 2

Which command switches to an existing branch?

A) `git switch <branch-name>` or `git checkout <branch-name>`
B) `git move <branch-name>`
C) `git go <branch-name>`

**Correct Answer: A**

**Explanation:** Both `git switch` (newer, recommended) and `git checkout` can be used to switch between branches. `git switch` was introduced to make the command clearer.

---

## Question 3

Which command creates a new branch AND switches to it immediately?

A) `git branch -s new-branch`
B) `git switch -c new-branch` or `git checkout -b new-branch`
C) `git create-and-switch new-branch`

**Correct Answer: B**

**Explanation:** The `-c` flag with `git switch` or `-b` flag with `git checkout` creates a new branch and switches to it in one command.

---

## Question 4

True or False: You must commit all changes before switching branches.

**Correct Answer: False**

**Explanation:** You don't have to commit, but uncommitted changes will come with you to the new branch. If there are conflicts, Git will warn you. It's good practice to commit or stash changes first.

---

## Question 5

What does HEAD point to in Git?

A) The first commit ever made
B) The currently checked-out branch or commit
C) The remote repository

**Correct Answer: B**

**Explanation:** HEAD is a special pointer that indicates your current position in the repository—usually the branch you're currently on.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
