# Activity Answer: Creating Your First Repository

## Solution

### Part 1: Initialize a Repository

```bash
mkdir my-first-repo
cd my-first-repo
git init
# Output: Initialized empty Git repository in /path/to/my-first-repo/.git/

ls -la
# You should see:
# drwxr-xr-x  10 user  staff   320 Dec 14 10:00 .git
```

### Part 2: Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify
git config --list | grep user
# Output should show:
# user.name=Your Name
# user.email=your.email@example.com
```

### Part 3: Check Repository Status

```bash
git status
# Output: On branch main (or master)
# No commits yet
# nothing to commit

echo "# My First Repository" > README.md

git status
# Output: On branch main
# No commits yet
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#         README.md
#
# nothing added to commit but untracked files present (use "git add" to track)
```

## Explanation

1. **`git init`** - Creates the `.git` directory with all necessary Git internals
2. **`git config`** - Sets user information needed for commits
3. **`git status`** - Shows the current state of your repository
4. Untracked files are files Git knows about but isn't yet tracking

## Key Concepts

- A repository is a directory with a `.git` folder
- Configuration must happen before making meaningful commits
- `git status` is your window into the repository state
