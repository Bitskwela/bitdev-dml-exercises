# Quiz: Handling Remote Rejections

Answer the following questions to check your understanding of this lesson.

## Question 1

Why might Git reject your push?

A) Your internet is too slow
B) Your local branch is behind the remote branch
C) Git doesn't like your code
D) The remote server is always busy

**Correct Answer: B**

**Explanation:** Git rejects pushes when your local branch doesn't include commits that exist on the remote—you need to fetch and integrate those changes first.

---

## Question 2

What should you do when your push is rejected?

A) Use `git push --force` immediately
B) Pull or fetch and merge/rebase, then push again
C) Delete the remote repository
D) Create a new repository

**Correct Answer: B**

**Explanation:** The safe approach is to `git pull` (or `git fetch` + merge/rebase) to integrate remote changes, then push again.

---

## Question 3

When might `git push --force` be appropriate?

A) Every time you push
B) When you've rebased a branch that only you are working on
C) Never, it should always be avoided

**Correct Answer: B**

**Explanation:** Force push can be used on personal branches after rebasing, but never on shared branches as it rewrites history others may have.

---

## Question 4

True or False: `git push --force-with-lease` is safer than `git push --force`.

**Correct Answer: True**

**Explanation:** `--force-with-lease` checks that the remote hasn't been updated by someone else before overwriting, preventing accidental loss of others' work.

---

## Question 5

What is the purpose of pulling before pushing?

A) To delete your local changes
B) To ensure your branch is up-to-date and can be fast-forwarded or merged properly
C) To make Git faster

**Correct Answer: B**

**Explanation:** Pulling first ensures you have the latest changes, reducing conflicts and allowing a smooth push.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
