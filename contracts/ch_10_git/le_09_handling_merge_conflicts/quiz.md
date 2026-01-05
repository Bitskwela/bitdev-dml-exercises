# Quiz: Handling Merge Conflicts

Answer the following questions to check your understanding of this lesson.

## Question 1

What causes a merge conflict?

A) When two branches modify the same lines in a file differently

B) When you try to merge too quickly

C) When Git runs out of memory

D) When the internet connection is lost

**Correct Answer: A**

**Explanation:** Merge conflicts occur when Git cannot automatically determine which changes to keep because the same lines were modified differently in both branches.

---

## Question 2

What do the conflict markers `<<<<<<<`, `=======`, and `>>>>>>>` represent?

A) Error messages that need to be fixed by reinstalling Git
B) Separators showing your changes vs. incoming changes
C) Comments that Git adds automatically

**Correct Answer: B**

**Explanation:** These markers show conflicting sections: content between `<<<<<<<` and `=======` is from your current branch; content between `=======` and `>>>>>>>` is from the branch being merged.

---

## Question 3

After resolving conflicts, what commands do you run to complete the merge?

A) `git resolve` then `git done`
B) `git add <files>` then `git commit`
C) `git merge --finish`

**Correct Answer: B**

**Explanation:** After manually editing files to resolve conflicts, you stage them with `git add` and then complete the merge with `git commit`.

---

## Question 4

True or False: You can abort a merge if you want to start over.

**Correct Answer: True**

**Explanation:** Running `git merge --abort` will cancel the merge and return your repository to the state before you started merging.

---

## Question 5

What is a good practice to minimize merge conflicts?

A) Never create branches
B) Pull changes frequently and communicate with your team
C) Delete all branches after each commit

**Correct Answer: B**

**Explanation:** Regularly pulling changes and staying in sync with your team reduces the chance of large, complex conflicts.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
