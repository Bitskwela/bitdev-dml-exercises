# Quiz: Interactive Rebasing

Answer the following questions to check your understanding of this lesson.

## Question 1

What command starts an interactive rebase for the last 3 commits?

A) `git rebase -i 3`
B) `git rebase -i HEAD~3`
C) `git rebase --interactive 3`
D) `git edit-commits 3`

**Correct Answer: B**

**Explanation:** `git rebase -i HEAD~3` opens an interactive editor where you can modify the last 3 commits.

---

## Question 2

Which action in interactive rebase allows you to edit a commit message?

A) `pick`
B) `squash`
C) `reword`
D) `drop`

**Correct Answer: C**

**Explanation:** The `reword` (or `r`) action lets you change a commit's message without modifying its content.

---

## Question 3

What does "squash" do in interactive rebase?

A) Deletes the commit
B) Combines the commit with the previous one
C) Splits the commit into multiple commits

**Correct Answer: B**

**Explanation:** Squashing merges a commit into the one before it, combining their changes and letting you write a new combined message.

---

## Question 4

True or False: Interactive rebase can reorder commits.

**Correct Answer: True**

**Explanation:** You can change the order of lines in the interactive rebase editor to reorder commits (though be careful of dependencies between commits).

---

## Question 5

What is the purpose of the "drop" action in interactive rebase?

A) To save the commit for later
B) To completely remove a commit from history
C) To pause the rebase

**Correct Answer: B**

**Explanation:** The `drop` action removes a commit entirely from the branch history.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
