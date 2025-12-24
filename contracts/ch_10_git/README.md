# Chapter 10: Git – Version Control Mastery

## Setup & Prerequisites

Welcome to Chapter 10! Before you dive into the lessons, let's ensure you're ready with the right tools and knowledge.

---

## Prerequisites

### Required:

- **A computer** (Windows, macOS, or Linux) with internet access
- **Basic command-line skills** (opening terminals, navigating directories)
- **A text editor** (VS Code, Sublime Text, Notepad++, or any editor you prefer)

### Recommended:

- **Completion of Ch 1-5** (helpful but not strictly required)
- **Basic understanding of folder structures** (from previous courses)

---

## Step 1: Install Git

### Windows

1. Download Git from https://git-scm.com/download/win
2. Run the installer
3. Accept default options (or customize if you prefer)
4. Complete the installation

**Verify installation**:

```bash
git --version
```

You should see: `git version 2.x.x` (version number may vary)

### macOS

**Using Homebrew** (recommended):

```bash
brew install git
```

**Or download directly** from https://git-scm.com/download/mac

**Verify installation**:

```bash
git --version
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install git
```

**Other distributions**: Visit https://git-scm.com/download/linux

**Verify installation**:

```bash
git --version
```

---

## Step 2: Configure Git

After installation, configure your identity (required for commits):

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

**Verify configuration**:

```bash
git config --list
```

You should see your name and email in the output.

---

## Step 3: Create a GitHub Account (for lessons 13+)

While not required for lessons 1-12, you'll need a GitHub account for the collaboration chapters.

1. Go to https://github.com
2. Click "Sign up"
3. Create a free account
4. Verify your email
5. Set up your profile with a username

**GitHub is free** and provides unlimited public repositories.

---

## Step 4: Create Your First Test Repository

Before lesson 1, let's verify everything works:

```bash
# Create a test folder
mkdir ~/git-test
cd ~/git-test

# Initialize a Git repository
git init

# Verify success
ls -la
```

You should see a `.git` folder. Congratulations—you've created your first repository!

---

## How to Use This Chapter

### Lesson Structure

Each lesson folder contains:

- **`meta.md`** – Lesson metadata (don't edit, just for reference)
- **`mat_1.md`** – Lesson material (read this carefully)
- **`mat_1.pdf`** – PDF version of the material
- **`act_1.md`** – Activity instructions (what to do)
- **`act_1.answer.sh`** – Sample answer (shell script with commands)
- **`quiz.md`** – Quiz questions (test your understanding)

### Daily Routine

1. **Read** the material (`mat_1.md`)
2. **Do** the activity (`act_1.md`)
   - Try it yourself first
   - Then check `act_1.answer.sh` if stuck
3. **Take** the quiz (`quiz.md`)
   - Answer the questions
   - Verify your understanding

---

## Helpful Tips

### Terminal Navigation

If you're new to the command line:

```bash
# Show current folder
pwd

# List files
ls

# Create a folder
mkdir folder-name

# Go into a folder
cd folder-name

# Go back one folder
cd ..

# Go home
cd ~
```

### When You Get Stuck

1. **Review the lesson material** – Re-read the explanation
2. **Check the answer** – Look at `act_1.answer.sh`
3. **Ask for help** – Use Git's help system:
   ```bash
   git help <command>
   git commit --help
   ```

### Common Commands Cheat Sheet

```bash
# Setup
git config --global user.name "Name"
git config --global user.email "email@example.com"

# Create & commit
git init                    # Create new repo
git add <file>             # Stage changes
git commit -m "message"    # Commit changes
git log                    # View history

# Branches
git branch                 # List branches
git branch <name>          # Create branch
git checkout <name>        # Switch branch
git merge <name>           # Merge branch

# Remote
git remote add origin <url> # Add remote
git push origin main       # Push to remote
git pull origin main       # Pull from remote
```

---

## Chapter Resources

- **Ch10_AnswersKeys.md** – Consolidated answers and explanations for all lessons
- **Git Official Documentation** – https://git-scm.com/doc
- **GitHub Docs** – https://docs.github.com
- **Atlassian Git Tutorials** – https://www.atlassian.com/git/tutorials

---

## FAQ

**Q: I installed Git but can't find it in my terminal**

- Try restarting your terminal or computer
- On Windows, ensure Git was added to PATH during installation

**Q: What if I make a mistake?**

- That's the whole point of Git! One of the first things you'll learn is how to undo changes

**Q: Do I need GitHub for lessons 1-12?**

- No, lessons 1-12 are all local. GitHub becomes relevant in lesson 13

**Q: Can I skip lessons?**

- You can try, but each lesson builds on previous ones. Recommended to go in order

**Q: How long should each lesson take?**

- Typically 45-90 minutes for material, activity, and quiz combined

---

## You're Ready!

✅ Git is installed
✅ You're configured
✅ You have a GitHub account (or know where to make one)
✅ You understand the lesson structure

**Let's start learning Git!** Head to `le_01_what_is_git/` for your first lesson.

Happy coding! 🚀
