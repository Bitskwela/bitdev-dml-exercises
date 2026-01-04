# Staging and Committing Activity

## Initial Scenario

Maria has been working on the barangay payment system and has made three improvements:

1. Fixed a critical bug in the discount calculation
2. Added new transaction logging
3. Started work on email notifications (still buggy)

She's modified 5 files total. She wants to commit only the bug fix and logging—not the incomplete email feature. This is where the staging area becomes powerful.

**Time Allotment: 25 minutes**

---

## Tasks for Learners

### Task 1: Create Multiple Files and Make Changes

Set up a realistic scenario with multiple modified files:

```bash
# Create test files representing different features
echo "def calculate_discount(amount):\n    return amount * 0.1" > discount.py
echo "import logging\nlogging.basicConfig(level=logging.INFO)" > logger.py
echo "# Email placeholder - incomplete" > email.py
echo "def process_payment(amount):\n    pass" > payment.py

# Initialize git if not already done
git init
git config user.name "Maria"
git config user.email "maria@barangay.ph"

# Check the status
git status
```

**Expected Output**:

```
On branch main
No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        discount.py
        email.py
        logger.py
        payment.py

nothing added to commit but untracked files exist (use "git add" to track)
```

---

### Task 2: Stage Only the Ready Files

Now stage only the files you want to commit (discount.py and logger.py):

```bash
# Stage only specific files
git add discount.py logger.py

# Check the status to see what's staged
git status
```

**Expected Output**:

```
On branch main
No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   discount.py
        new file:   logger.py

Untracked files:
  (use "git add ..." to include in what will be committed)
        email.py
        payment.py
```

**Notice**: Only discount.py and logger.py are in the "Changes to be committed" section. The email.py and payment.py remain untracked because we haven't staged them.

---

### Task 3: View Staged vs Unstaged Changes

Understand what `git diff` shows:

```bash
# Show unstaged changes (untracked files)
git diff

# Show staged changes (what will be committed)
git diff --staged

# See everything
git status
```

**Key Understanding**:

- `git diff`: Shows changes NOT yet staged
- `git diff --staged`: Shows changes that ARE staged and ready to commit
- `git status`: Shows overview of everything

---

### Task 4: Make Your First Meaningful Commit

Commit the staged files with a descriptive message:

```bash
# Commit the staged changes
git commit -m "Fix discount calculation and add transaction logging"

# Check the result
git status
```

**Expected Output**:

```
[main (root-commit) a1b2c3d] Fix discount calculation and add transaction logging
 2 files changed, 2 insertions(+)
 create mode 100644 discount.py
 create mode 100644 logger.py

On branch main
Untracked files:
  (use "git add ..." to include in what will be committed)
        email.py
        payment.py

nothing added to commit but untracked files exist (use "git add" to track)
```

---

### Task 5: Verify Your Commit and View History

Check that your commit was recorded:

```bash
# View the commit history
git log

# View just the commit messages in one line format
git log --oneline

# View details of the last commit
git show HEAD
```

**Expected Output**:

```
commit a1b2c3d1234567890abcdef1234567890abcdef (HEAD -> main)
Author: Maria <maria@barangay.ph>
Date:   Fri Jan 3 14:30:00 2025 +0000

    Fix discount calculation and add transaction logging
```

---

## Breakdown of the Activity

### The Three-Step Workflow

1. **Modify Files** (Working Directory)

   - You edit files freely
   - These changes are not yet tracked by Git

2. **Stage Changes** (Staging Area / Index)

   - Use `git add` to select which changes to prepare for commit
   - You can stage some files while leaving others modified
   - This creates a "preparation area" for your snapshot

3. **Commit** (Repository History)
   - Use `git commit` to save the staged snapshot
   - Every commit includes a message explaining the changes
   - The commit gets a unique ID (hash) that never changes

### Why Staging Matters

In real development, you make many changes but want to organize them into logical commits:

- **Bug fixes**: Should be separate from feature additions
- **Refactoring**: Should be separate from functionality changes
- **Testing**: Only commit changes you've verified work

The staging area lets you organize your work into meaningful commits that tell a story of your development.

### Good Commit Messages

A good commit message should:

- Start with a verb (Fix, Add, Update, Remove, Refactor)
- Be specific about what changed and why
- Be clear enough that someone could understand the change 6 months later

**Examples**:

- ✅ "Fix null pointer exception in discount calculator"
- ✅ "Add transaction logging for payment tracking"
- ✅ "Update payment processing to use new API endpoint"
- ❌ "Fixed stuff"
- ❌ "Update"
- ❌ "Work in progress"

### Key Concepts

- **Staging Area**: The preparation zone between your working directory and commits
- **Staged Changes**: Modifications ready to be committed
- **Unstaged Changes**: Modifications not yet prepared for commit
- **Commit Hash**: Unique 40-character identifier for each commit (e.g., `a1b2c3d`)
- **Working Directory**: The actual files you see and edit on disk

---

## Closing

You've mastered a critical Git skill:

✓ Created and modified multiple files
✓ Selectively staged files using the staging area
✓ Created meaningful commits with clear messages
✓ Viewed your commit history
✓ Understood why granular commits matter

This staging workflow is essential for collaborative development. In the next lesson, you'll learn how to view your entire commit history and understand how Git records the evolution of your project.

**Next Lesson Preview**: Viewing History – Use `git log`, `git show`, and `git diff` to understand how your project has evolved and navigate your commit history.
