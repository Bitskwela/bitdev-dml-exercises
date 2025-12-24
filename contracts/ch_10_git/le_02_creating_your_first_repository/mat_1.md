# Le 02: Creating Your First Repository

## Learning Objectives

By the end of this lesson, you'll understand:

- What a Git repository is
- How to initialize a new repository with `git init`
- The structure and purpose of the `.git` directory
- How to configure Git with user information
- The basic status of a repository

## What is a Repository?

A **Git repository** is a directory that contains:

1. Your project files (source code, documents, etc.)
2. A special `.git` folder that stores all version control information

Think of it like a project folder with an invisible librarian inside who records every change.

## Initializing a Repository

### The Command

```bash
git init
```

This single command transforms any folder into a Git repository.

### What Happens

When you run `git init`, Git creates a `.git` directory containing:

```
.git/
├── config          # Repository configuration
├── HEAD            # Pointer to current branch
├── hooks/          # Automation scripts
├── objects/        # Stored file data
├── refs/           # Branch and tag references
└── ...other files
```

### A Real-World Example

Imagine you're starting a new feature for the barangay market app:

```bash
# Navigate to your project folder
cd ~/barangay-market

# Initialize Git
git init

# Git responds with:
# Initialized empty Git repository in /Users/you/barangay-market/.git/
```

## Configuring Git

Before making commits, tell Git who you are:

```bash
# Set your name
git config --global user.name "Your Name"

# Set your email
git config --global user.email "your.email@example.com"
```

### Global vs Local Configuration

- **Global** (`--global`): Applies to all repositories on your computer
- **Local**: Applies only to the current repository (omit `--global`)

### Viewing Configuration

```bash
git config --list
```

## Checking Repository Status

```bash
git status
```

This command shows:

- Current branch
- Staged changes (ready to commit)
- Unstaged changes (modified but not staged)
- Untracked files (not yet added to Git)

### Example Output

```
On branch main

No commits yet

nothing to commit
```

## Summary

By running `git init`, you've:

- ✅ Created a Git repository
- ✅ Enabled version control in your project
- ✅ Set up the foundation for tracking changes

Ready to make your first commit? Let's go to the next lesson!

---

**Next:** [Staging & Committing](/lessons/le_03_staging_and_committing/)
