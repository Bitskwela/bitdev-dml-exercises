# Quiz: Tags and Releases

Answer the following questions to check your understanding of this lesson.

## Question 1

What is a Git tag?

A) A label that points to a specific commit, typically used for releases
B) A type of branch
C) A commit message
D) A remote repository

**Correct Answer: A**

**Explanation:** Tags are references that point to specific commits, commonly used to mark release versions like v1.0.0.

---

## Question 2

What is the difference between lightweight and annotated tags?

A) There is no difference
B) Lightweight is just a pointer; annotated includes metadata (tagger, date, message)
C) Annotated tags are smaller
D) Lightweight tags can't be pushed

**Correct Answer: B**

**Explanation:** Lightweight tags are simple pointers. Annotated tags are full Git objects with tagger name, email, date, and message—recommended for releases.

---

## Question 3

Which command creates an annotated tag?

A) `git tag v1.0.0`
B) `git tag -a v1.0.0 -m "Release version 1.0.0"`
C) `git tag --light v1.0.0`

**Correct Answer: B**

**Explanation:** The `-a` flag creates an annotated tag, and `-m` adds a message. Without `-a`, you get a lightweight tag.

---

## Question 4

True or False: By default, `git push` also pushes tags.

**Correct Answer: False**

**Explanation:** Tags must be pushed explicitly with `git push origin <tagname>` or `git push --tags` to push all tags.

---

## Question 5

What is semantic versioning (SemVer)?

A) A random numbering system
B) A versioning scheme: MAJOR.MINOR.PATCH (e.g., 2.1.3)
C) A Git command

**Correct Answer: B**

**Explanation:** SemVer uses three numbers: MAJOR (breaking changes), MINOR (new features, backward compatible), PATCH (bug fixes). Example: v1.2.3.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
