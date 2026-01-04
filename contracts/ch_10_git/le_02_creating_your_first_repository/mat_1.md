# Creating Your First Repository

![1.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_10_git/le_02_creating_your_first_repository/1.0%20-%20COVER.png)

## Scene: The First Commit

**Monday morning. Marco gathers Maria, Dev Sam (in Cebu), and Alexis (in Mexico City) on Zoom.**

"It's time," he announces. "We're creating the Barangay Blockchain. The actual repository. Everything starts here."

"But Marco," Maria asks from her Manila desk, "where does all this history get stored? I have Git installed. I have my editor. But how does Git actually remember what I do?"

Marco smiles. "That's what the `.git` folder is for. It's like a hidden librarian inside your project folder. Every change, every snapshot, every decision—it's all stored there. It's how we'll stay synchronized across three countries."

He opens his terminal on camera. "When you initialize a Git repository, you're saying to Git: 'Start paying attention. This folder matters. Track every change that happens here from now on.'"

Dev Sam asks: "And the other developers see this?"

"Exactly," Marco replies. "Once we push to GitHub, you'll both be able to pull this repository. You'll have the same `.git` folder. The same history. The same timeline. It's how we work together despite being 5,000 kilometers apart."

**This is how distributed teams become synchronized: Git's `.git` folder is their shared memory.**

## What is a Repository?

![1.1 - REPOSITORY STRUCTURE](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_10_git/le_02_creating_your_first_repository/1.1.png)

### The Repository: Your Project's Home

> A **Git repository** is a project folder containing your actual files plus a special `.git` directory. Everything Git needs to track your work lives in that `.git` folder.

Think of it like a barangay hall:

- **Your actual files**: The marketplace stalls, voting system code, payment logic
- **The .git folder**: The barangay's filing cabinet where every transaction, every decision is recorded

### How to Create a Repository

```bash
# Create a project directory
mkdir barangay-marketplace
cd barangay-marketplace

# Initialize Git
git init
```

**What Git shows you**:

```
Initialized empty Git repository in /Users/marco/barangay-marketplace/.git/
```

That's it. You now have a Git repository. Git created a hidden `.git` folder with everything it needs.

## Understanding the .git Directory

### What's Inside?

When you run `git init`, Git creates this structure:

```
.git/
├── HEAD              # Points to current branch
├── config            # Repository settings
├── objects/          # Stores commits and file contents
├── refs/             # Branch and tag references
├── hooks/            # Automation scripts
└── description       # Repository description
```

### Key Components

**HEAD**: A pointer saying "I'm currently working on this branch." It's how Git remembers which timeline you're on.

**config**: Your repository's specific settings. Different from global config. This is where you can set email just for this project if needed.

**objects/**: The heart of Git. Every commit, every file version, every snapshot of your code is stored here as compressed "objects." This is why Git is so powerful—it never loses data.

**refs/**: Stores references to branches and tags. As you create branches, they're recorded here.

## Configuring Your Repository

### Global vs. Local Configuration

You can configure Git at two levels:

**Global (`--global`)**: Applies to ALL repositories on your computer

- Set once, used everywhere
- Good for: your name and email (set in Lesson 1)

**Local**: Applies ONLY to this specific repository

- Can override global settings
- Good for: repository-specific preferences

### Example

```bash
# Set local email (only for this repository)
git config user.name "Marco Santos"
git config user.email "marco.marketplace@barangaydev.ph"

# View local configuration
git config --list --local
```

If you omit `--global`, Git assumes you mean the local configuration for the current repository.

## The Repository is Ready

At this point, you have:

✓ A `.git` directory tracking your project
✓ Git configuration set up
✓ A repository ready to start recording changes

Next, you'll start adding files and making your first commits—the actual snapshots that Git will preserve forever.

---

**Ready to add files and make your first commits? Let's start tracking changes!**
git config --list

````

## Checking Repository Status

```bash
git status
````

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
