# Activity: Creating Your First Repository

## Your Task

Initialize a Git repository, configure your user information, and explore the repository structure.

### Question 1: Repository Initialization

**Create a new directory called `my-payment-app` and initialize a Git repository inside it. Then, describe what you found in the `.git` directory. What do you think the purpose of each file/folder is?**

(Provide the commands you ran and your observations)

---

### Question 2: Configuration

**Configure Git with your name and email (local configuration). Then use `git config` to verify that your settings were saved. Show the commands you used and the output.**

(Your answer here - include the exact commands and their results)

---

### Question 3: Initial Status

**Create three test files in your repository:**

- `app.py`
- `requirements.txt`
- `README.md`

**Then run `git status`. Explain what Git is telling you about these files. Why are they "untracked"?**

(Your answer here - include the git status output and your explanation)

---

### Question 4: Understanding .git

**The `.git` folder is hidden on most systems. Why do you think Git hides this folder? What would happen if you accidentally deleted the `.git` folder?**

(Your answer here - explain the design choice and consequences)

---

### Question 5: Real-World Scenario

**You're starting a new project with your team. Before writing any code, you initialize a Git repository. What are you communicating to your team by doing this? What benefits does this provide?**

(Your answer here - think about collaboration, history, and accountability)

---

### Question 6: Configuration Levels

**Why does Git allow both global and local configuration? Give a practical example of when you'd use local configuration instead of global.**

(Your answer here - describe a real-world scenario)

---

## What You've Accomplished

✓ Created your first repository
✓ Configured Git with your identity
✓ Explored the internal structure of Git
✓ Understood the concept of untracked files

**You're now ready to add files and make your first commit!**

1. Set your global Git name (do this once):

   ```bash
   git config --global user.name "Your Name"
   ```

2. Set your global Git email:

   ```bash
   git config --global user.email "your.email@example.com"
   ```

3. Verify your configuration:
   ```bash
   git config --list | grep user
   ```

### Part 3: Check Repository Status

1. Check the status of your new repository:

   ```bash
   git status
   ```

2. Create a test file:

   ```bash
   echo "# My First Repository" > README.md
   ```

3. Check the status again:
   ```bash
   git status
   ```

## Verification

You'll know you've completed this correctly when:

- [ ] The `.git` directory exists in your project folder
- [ ] `git config --list` shows your name and email
- [ ] `git status` displays "nothing to commit" or "Untracked files"
- [ ] You created a test file that appears as "untracked" in `git status`

---

**Check the answer file (`act_1.answer.md`) if you get stuck!**
