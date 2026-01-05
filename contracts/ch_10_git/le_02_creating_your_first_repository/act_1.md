# Creating Your First Repository Activity

## Scenario

Marco is setting up the marketplace repository for the team. You're helping him initialize the project structure and understand how Git's `.git` folder works. This is the foundation everything else will build on.

**Time Allotment: 25 minutes**

---

## Tasks for Learners

### Task 1: Initialize Your First Repository

Create the marketplace project directory and turn it into a Git repository:

```bash
# Create and navigate to the project directory
mkdir barangay-marketplace-system
cd barangay-marketplace-system

# Initialize Git
git init
```

**Expected Output**:

```
Initialized empty Git repository in /Users/yourname/barangay-marketplace-system/.git/
```

**Why**: This creates the hidden `.git` folder—Git's filing cabinet that will store every change, every decision, every snapshot of this project.

---

### Task 2: Explore the .git Directory

Marco asks: "Want to see what Git just created?" Let's look inside:

```bash
# See all files, including hidden ones
ls -la

# Explore the .git directory structure
ls -la .git/
```

**Expected Output**:

```
total 24
drwxr-xr-x    9 marco  staff   288 Jan  3 14:22 .
drwxr-xr-x    3 marco  staff    96 Jan  3 14:22 ..
drwxr-xr-x   13 marco  staff   416 Jan  3 14:22 .git
-rw-r--r--    1 marco  staff     0 Jan  3 14:22 .gitkeep

Inside .git/:
-rw-r--r--  HEAD
-rw-r--r--  config
-rw-r--r--  description
drwxr-xr-x  hooks
drwxr-xr-x  objects
drwxr-xr-x  refs
```

**Understanding What You See**:

- **HEAD**: Git's bookmark—it remembers which branch you're on
- **config**: Settings specific to this repository (can differ from global)
- **objects/**: The heart of Git—stores every commit, every version of every file
- **refs/**: Records all branches and tags you create
- **hooks/**: Scripts that run automatically when Git events happen (more advanced)

**Why**: Marco explains: "This `.git` folder is what makes this a Git repository. Everything Git needs is inside here. Protect it!"

---

### Task 3: Configure This Repository

Set up your identity for this specific project:

```bash
# Set local repository configuration
git config user.name "Maria Santos"
git config user.email "maria@barangaymarket.ph"

# Verify your settings
git config --list --local
```

**Expected Output**:

```
user.name=Maria Santos
user.email=maria@barangaymarket.ph
```

**Why**: While your global identity (set in Lesson 1) applies everywhere, you can override it for specific projects. Some teams use different email formats for different projects.

---

### Task 4: Create Project Files and See Git's Response

Now create files that represent the marketplace project:

```bash
# Create files for the project
echo "# Barangay Marketplace Payment System" > README.md
echo "*.pyc" > .gitignore
echo "password = 'secret123'" > config.py
echo "print('Processing marketplace payments')" > payment_processor.py

# Check what Git sees
git status
```

**Expected Output**:

```
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        .gitignore
        README.md
        config.py
        payment_processor.py

nothing added to commit but untracked files exist (use "git add" to track)
```

**What This Tells You**:

- **"No commits yet"**: This is a brand-new repository with no history
- **"Untracked files"**: Git sees these files but hasn't been told to track them yet
- **"nothing added to commit"**: None of these files have been staged (next lesson!)

---

## What the Code Does

**git init**: Creates a Git repository by adding a `.git` directory. This single command transforms any folder into a Git-controlled project.

**git config user.name/email**: Stores your identity in this repository's local configuration. Every commit will be signed with this name and email, creating accountability.

**.git directory**: The complete history of your project lives here. It contains every commit, every branch, every decision. Deleting `.git` would erase all version control history.

**git status**: Shows Git's current understanding of your project. It tells you which files are untracked (new), modified, or staged for committing. This is your constant companion throughout Git work.

---

## Closing

Perfect! You've now set up the foundation:

✓ Created a Git repository from scratch
✓ Explored what Git actually created (the `.git` directory)
✓ Configured your identity for this project
✓ Understood that new files start as "untracked"

The repository is ready. In the next lesson, you'll learn the **staging area**—where you decide which changes go into each commit. Marco is about to show you how to create meaningful snapshots of your work.

**Next Lesson Preview**: Staging and Committing – Discover how to selectively choose which files go into each commit, write messages that explain _why_ you made changes, and understand why careful commits matter for team collaboration.
