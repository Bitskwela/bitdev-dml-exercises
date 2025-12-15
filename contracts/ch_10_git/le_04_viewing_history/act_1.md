# Activity: Viewing History

## Your Task

Imagine you're Maria investigating the voting system bug. Answer the following questions based on what you've learned about Git history tools.

---

### Question 1: Understanding git log

**You run `git log --oneline` and see 15 commits. One of them mentions "Fix voting display" but you need to see the actual changes made in that commit. What two commands would you use to investigate further?**

(Your answer here - explain the commands and what they show)

---

### Question 2: Comparing Versions

**A feature that worked last week is now broken. You have commit hashes: `abc1234` (last week) and `xyz9999` (today). How would you use git diff to see exactly what code changed between these two points? Write the command.**

(Your answer here - provide the exact command and explain what the output means)

---

### Question 3: Using git blame for Teamwork

**Your team member in Cebu changed a critical line of code, but there's no explanation in the commit message. How would you use `git blame` to find this specific change, and what information would you get? Write the command and explain what you'd ask your teammate.**

(Your answer here - show the command and describe how you'd approach the conversation)

---

### Question 4: Searching Commit History

**The Barangay Blockchain had 50 commits in the last month. You think the bug was introduced when someone modified the `displayVotes()` function, but you don't know which commit. How would you search the history to find this specific change? Write two different approaches.**

(Your answer here - provide two search strategies and explain why each is useful)

---

### Question 5: Debugging a Production Bug

**It's 2 AM. Your Davao deployment is down. You can see errors in the voting system but not which recent change caused it. Walk through the steps you'd take using Git history tools to (a) find the commit, (b) understand what changed, (c) prepare to explain it to your team in Manila.**

(Your answer here - create a debugging timeline/process)

---

### Question 6: Global Team Communication

**You're onboarding a new developer from Singapore who will maintain the voting feature. They ask, "How can I understand the history of this code?" Based on what you've learned, write a brief explanation of how Git history tools enable knowledge transfer across your global team.**

(Your answer here - explain how history serves as documentation)

---

## What You've Accomplished

✓ Learned to view project history with `git log`
✓ Understood how to inspect specific commits with `git show` and `git diff`
✓ Practiced using `git blame` to understand code changes
✓ Discovered how history searching helps debugging
✓ Connected Git history to real-world team collaboration

**Next:** Learn how to **undo changes** when history reveals mistakes. Sometimes the best commit is knowing how to fix bad ones.
