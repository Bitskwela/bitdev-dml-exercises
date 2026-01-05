# What is Git? Activity

## Scenario

The Manila Digital Collective is ready to start their marketplace project. Marco asks you to help set up Git for the team. Before the whole team can coordinate their work, you need to verify Git is installed and configure your identity—so every change you make is properly tracked.

**Time Allotment: 20 minutes**

---

## Tasks for Learners

### Task 1: Check if Git is Installed

Just like Marco needs to verify the team's tools work before starting, verify that Git is installed on your system. Open your terminal or command prompt and run:

```bash
git --version
```

**Expected Output** (your version may differ):

```
git version 2.40.0
```

**Why**: If you see a version number, Git is ready. If you get "command not found," Git needs to be installed from [git-scm.com](https://git-scm.com). You're confirming your system is prepared.

---

### Task 2: Configure Your Identity

Before you make any commits to the marketplace project, tell Git who you are. This signature will be attached to every change you make—creating accountability and allowing teammates to know who did what.

Run these commands (replace with your actual name and email):

```bash
git config --global user.name "Maria Santos"
git config --global user.email "maria.santos@manilacollective.ph"
```

**Note**: The `--global` flag means this configuration applies to all repositories on your computer. If you want different identity information for a specific project, you can omit `--global` and run the same commands inside that project's folder.

**Why**: Every commit needs a signature. This builds accountability in the team. When Marco reviews code, he knows who to ask: "Why did Maria make this change?"

---

### Task 3: Verify Your Configuration

Check that your settings were saved correctly:

```bash
git config user.name
git config user.email
```

**Expected Output**:

```
Maria Santos
maria.santos@manilacollective.ph
```

You can also see all your Git configuration:

```bash
git config --list | grep user
```

This shows your name and email (and other settings) Git has stored.

**Why**: Verification ensures your identity is set correctly for all future repositories you create.

---

## What the Code Does

**git --version**: Checks if Git is installed and accessible from your command line. This is the first troubleshooting step when Git doesn't work—it answers "Is Git even on this computer?" It's like Marco checking "Do we have the right tools?"

**git config --global user.name**: Stores your identity globally so Git knows who you are. The `--global` flag saves this to your home directory, applying it to all repositories on this computer. Without `--global`, the setting would only affect the current project.

**Identity and Accountability**: This is crucial for teamwork. When a bug appears in the voting system months from now, the team can use `git blame` to see exactly which line was changed by whom. Accountability drives better code quality and helps teammates learn from each other's changes.

**git config --list**: Shows all your Git configuration. It reveals not just your name and email, but also other system settings Git uses. This helps you understand what Git "knows" about you.

---

## Closing

Excellent! You've completed the first step: Git is installed and your identity is configured.

You're now ready to:
✓ Create repositories with your personal signature
✓ Make commits that identify you as the author
✓ Collaborate with Marco, Maria, and the team

In the next lesson, we'll create the actual marketplace repository and explore what that mysterious `.git` folder contains. You'll understand the fundamental structure Git uses to track every change.

**Next Lesson Preview**: Creating Your First Repository – Initialize a Git project, explore the `.git` directory structure, and set up the foundation for the team's voting system code.
