# Quiz: Fetching Updates

Answer the following questions to check your understanding of this lesson.

## Question 1

What does `git fetch` do?

A) Downloads remote changes AND automatically merges them
B) Downloads remote changes WITHOUT merging them
C) Uploads your changes to the remote
D) Deletes remote branches

**Correct Answer: B**

**Explanation:** `git fetch` downloads commits, files, and refs from a remote repository but doesn't merge them—you can review before integrating.

---

## Question 2

What is the difference between `git fetch` and `git pull`?

A) They are the same thing
B) `fetch` downloads without merging; `pull` downloads AND merges
C) `fetch` only works on GitHub
D) `pull` is faster

**Correct Answer: B**

**Explanation:** `git fetch` is safer—it lets you review remote changes before merging. `git pull` automatically merges, which can cause unexpected conflicts.

---

## Question 3

After fetching, how do you view the fetched commits?

A) `git log origin/main` or `git log FETCH_HEAD`
B) `git show fetch`
C) `git view remote`

**Correct Answer: A**

**Explanation:** After fetching, you can compare with `git log origin/main` to see what commits are on the remote that you don't have locally.

---

## Question 4

True or False: `git fetch` modifies your working directory.

**Correct Answer: False**

**Explanation:** `git fetch` only updates your remote-tracking branches. Your working directory and local branches remain unchanged until you explicitly merge or rebase.

---

## Question 5

When is it better to use `git fetch` instead of `git pull`?

A) When you want to review changes before integrating them
B) When you're offline
C) Never—always use pull

**Correct Answer: A**

**Explanation:** Use `git fetch` when you want to see what's changed on the remote and decide how to integrate (merge vs. rebase) or if you want to review changes first.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
