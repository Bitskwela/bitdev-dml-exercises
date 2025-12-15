# Activity: Undoing Changes

## Your Task

You're now part of Maria's team. These scenarios will help you practice deciding which undo strategy to use in different situations.

---

### Question 1: Working Directory Disaster

**You modified permission.js significantly but haven't staged it. You run `git diff` and realize every change is wrong. Using what you've learned, explain the command you'd use and why this is the safest undo situation.**

(Your answer here - show the command and explain why this requires no caution)

---

### Question 2: Staged Too Much

**You've staged both voting.js AND permission.js for a commit, but you only want to commit voting.js. The permission.js changes should be refined more. What command unstages permission.js while keeping your changes? Write it and explain what you'd do next.**

(Your answer here - provide the command and your next steps)

---

### Question 3: Local Commit Undo

**You're working locally (haven't pushed yet) and realize you committed the wrong changes 2 commits ago. Your current commit is good, but the one before that is broken. Should you use `git revert` or `git reset`? Explain your choice and show which command you'd use.**

(Your answer here - justify your choice and provide the command with options)

---

### Question 4: Production Crisis (Undo Already Pushed)

**This is Maria's 2 AM scenario: commit abc1234 was pushed to the main branch (shared with the team), and it broke production. The Singapore team is already affected. Which undo strategy MUST you use and why? Write the command Maria should run.**

(Your answer here - explain why reset is dangerous here and why revert is mandatory)

---

### Question 5: Recovery with Reflog

**You panic and run `git reset --hard HEAD~5` on a commit that was already pushed (a mistake!). Your team is angry. Show how you'd use `git reflog` to find your commits and recover them. Write out what you'd see and how you'd recover.**

(Your answer here - explain the reflog output and recovery command)

---

### Question 6: Decision Tree for Your Team

**You're creating a Git best practices guide for your international team (Manila, Cebu, Singapore, London). Write a simple decision tree for undoing changes: When should they use restore, reset, revert, or reflog? Why does it matter for a global team?**

(Your answer here - create a practical decision guide with real scenarios)

---

## What You've Accomplished

✓ Learned three safe undo strategies (restore, reset, revert)
✓ Understood when each strategy is appropriate
✓ Discovered why revert is mandatory for shared repos
✓ Practiced thinking about global team impacts
✓ Learned recovery with reflog as a safety net

**Next:** Now that you can work safely with commits, it's time to explore **branches**—the feature that lets multiple teammates work on different features at the same time without stepping on each other's toes.

- [ ] You can explain the concept

---

**Check the answer file (`act_1.answer.sh`) if you get stuck!**
