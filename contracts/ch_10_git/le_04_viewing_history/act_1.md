# Viewing History Activity

## Initial Scenario

A critical bug has appeared in the barangay voting system—votes are displaying incorrectly for mayor candidates. Marco, the technical lead, needs to trace when this bug was introduced and what changed. Git's history tools will help him investigate and understand the project's evolution.

**Time Allotment: 25 minutes**

---

## Tasks for Learners

### Task 1: Create a Realistic Commit History

Set up a project with multiple commits to explore:

```bash
# Create initial project files
echo "# Barangay Voting System" > README.md
echo "def display_results(): print('Loading...')" > voting.py

# Make first commit
git add .
git commit -m "Initialize voting system project"

# Modify and commit
echo "def display_results(): return {'mayor': 100}" > voting.py
git add voting.py
git commit -m "Add basic vote counting"

# Another modification
echo "def display_results(): return {'mayor': 102, 'governor': 98}" > voting.py
git add voting.py
git commit -m "Add governor vote tracking"

# One more change
echo "def display_results(): return {'mayor': 102, 'governor': 98, 'vice': 97}" > voting.py
git add voting.py
git commit -m "Add vice governor results"

# Finally, introduce the bug
echo "def display_results(): return {'mayor': 102, 'governor': 98, 'vice': 97}  # BUG: wrong order" > voting.py
git add voting.py
git commit -m "Refactor display logic"
```

---

### Task 2: View the Commit Log

Now explore your project's history:

```bash
# View the full commit log
git log

# View commits in one-line format
git log --oneline

# View with more details
git log --oneline --graph
```

**Expected Output**:

```
5f6e7d8 Refactor display logic
4e5d6c7 Add vice governor results
3d4c5b6 Add governor vote tracking
2c3b4a5 Add basic vote counting
1b2a3a4 Initialize voting system project
```

**Key Information**:

- Each line shows the commit hash, message, and author
- The order is newest first (most recent at top)
- The hash (e.g., `5f6e7d8`) is how Git uniquely identifies each commit

---

### Task 3: Inspect a Specific Commit

Use `git show` to examine what changed in the bug-introducing commit:

```bash
# Show the commit that introduced the bug (the most recent one)
git show HEAD

# Or show a specific commit by its hash
git show 5f6e7d8

# Show just the commit message
git show --pretty=short HEAD
```

**Expected Output**:

```
commit 5f6e7d8... (HEAD -> main)
Author: Maria <maria@barangay.ph>
Date:   Fri Jan 3 15:00:00 2025

    Refactor display logic

diff --git a/voting.py b/voting.py
index 4e5d6c7..5f6e7d8 100644
--- a/voting.py
+++ b/voting.py
@@ -1 +1 @@
-def display_results(): return {'mayor': 102, 'governor': 98, 'vice': 97}
+def display_results(): return {'mayor': 102, 'governor': 98, 'vice': 97}  # BUG: wrong order
```

---

### Task 4: Compare Versions Using git diff

Compare the working version (before the bug) with the broken version (after):

```bash
# Compare the last two commits
git diff HEAD~1 HEAD

# Compare any two commits
git diff 2c3b4a5 5f6e7d8

# Show the changes made in a specific commit
git show 5f6e7d8:voting.py
```

**Expected Output**:

```
diff --git a/voting.py b/voting.py
index 4e5d6c7..5f6e7d8 100644 100644
--- a/voting.py
+++ b/voting.py
@@ -1 +1 @@
-def display_results(): return {'mayor': 102, 'governor': 98, 'vice': 97}
+def display_results(): return {'mayor': 102, 'governor': 98, 'vice': 97}  # BUG: wrong order
```

This shows exactly what changed between the two commits.

---

### Task 5: Use git blame to Find Who Changed What

Identify which commit changed each line:

```bash
# Show the commit that last modified each line
git blame voting.py

# Also shows the author
git blame -L 1,1 voting.py
```

**Expected Output**:

```
5f6e7d8 (Maria Santos 2025-01-03 15:00:00) def display_results(): return {'mayor': 102, 'governor': 98, 'vice': 97}  # BUG: wrong order
```

This tells you:

- Commit `5f6e7d8` modified this line
- Maria Santos made that commit
- When it was committed
- The exact code on that line

---

## Breakdown of the Activity

### The Three Main History Tools

1. **`git log`**: View commit history

   - Shows all commits in reverse chronological order
   - Useful for understanding the project's story
   - Use `--oneline` for quick overview

2. **`git show`**: Inspect a specific commit

   - Shows what changed in that commit
   - Includes the message, author, date, and diff
   - `HEAD` refers to the most recent commit

3. **`git diff`**: Compare versions

   - `git diff` shows unstaged changes
   - `git diff --staged` shows staged changes
   - `git diff commit1 commit2` compares two commits
   - `git diff HEAD~1 HEAD` compares last two commits

4. **`git blame`**: Find the source of a change
   - Shows which commit last modified each line
   - Useful for understanding code origins
   - Helps trace bugs to their source

### Understanding git notation

- **HEAD**: The current commit you're on
- **HEAD~1**: One commit before HEAD (the parent)
- **HEAD~2**: Two commits before HEAD
- **Commit hash**: The unique 40-character identifier for a commit

### Real-World Debugging Workflow

When a bug appears:

1. Use `git log --oneline` to see recent commits
2. Use `git diff` to compare working vs broken versions
3. Use `git blame` to find exactly which commit introduced the bug
4. Use `git show` to understand what that commit was trying to do
5. Contact the author to understand the intent

### Key Concepts

- **Commit History**: The complete record of all changes
- **Revision**: A specific point in your project's history (a commit)
- **Diff**: The difference between two versions
- **Blame**: Finding the source commit for a change

---

## Closing

You've gained powerful tools for understanding your project:

✓ Viewed commit history with `git log`
✓ Inspected specific commits with `git show`
✓ Compared versions with `git diff`
✓ Traced changes to their source with `git blame`
✓ Learned to debug using Git history

These tools are essential for team collaboration. When code breaks, Git history helps you understand not just WHAT changed, but also WHY and WHO made the change. In the next lesson, you'll learn to FIX mistakes by undoing changes safely.

**Next Lesson Preview**: Undoing Changes – Learn the three ways to undo changes (`git restore`, `git reset`, `git revert`) and when to use each one.
