# Quiz: Reflog and Recovery

Answer the following questions to check your understanding of this lesson.

## Question 1

What is the Git reflog?

A) A file that stores remote URLs
B) A log of all reference (HEAD, branches) updates in your local repository
C) A backup of your repository on GitHub
D) A list of all merge conflicts

**Correct Answer: B**

**Explanation:** The reflog records every time HEAD or branch references change, even when commits seem "lost" after reset or rebase.

---

## Question 2

Which command displays the reflog?

A) `git log --reflog`
B) `git reflog`
C) `git history --all`
D) `git show-refs`

**Correct Answer: B**

**Explanation:** `git reflog` (or `git reflog show`) displays the reference log, showing where HEAD has been.

---

## Question 3

How can you recover a commit after an accidental `git reset --hard`?

A) It's impossible to recover
B) Find the commit in reflog and use `git reset` or `git checkout` to that commit
C) Reinstall Git

**Correct Answer: B**

**Explanation:** Reflog keeps track of commits for about 90 days. Find the lost commit with `git reflog` and reset or checkout to recover.

---

## Question 4

True or False: The reflog is shared with the remote repository.

**Correct Answer: False**

**Explanation:** Reflog is local only—it's not pushed to remotes. Each developer's reflog is unique to their local repository.

---

## Question 5

What is the purpose of `git reflog expire`?

A) To view expired commits
B) To clean up old reflog entries
C) To extend reflog history

**Correct Answer: B**

**Explanation:** `git reflog expire` removes old reflog entries. By default, unreachable entries expire after 30 days and reachable ones after 90 days.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
