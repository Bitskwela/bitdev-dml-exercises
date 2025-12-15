# Le 04: Viewing History

![Git History Visualization](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-history.png)

## Background Story

Maria Santos has been developing the Barangay Blockchain Ledger for two weeks. She's made 23 commits so far—adding features for village voting, transaction logging, and safety measures. Today, a bug appeared: the voting system no longer displays results correctly.

"I don't remember which commit broke it," Maria says to Marco during their morning sync call from Manila. "Was it when I added the multi-vote protection? Or the permission check? We need to see what changed in each commit."

Marco nods. "This is where Git history becomes your greatest tool. Every commit is like a snapshot in time. We can look at exactly what changed, who changed it, and when. For our distributed team—with Dev Sam in Cebu and you here in Manila—this is our shared memory."

What Maria learns today will help her debug production issues, understand code changes her teammates made, and trace exactly when features were introduced into the system. For a global team deploying the same codebase to multiple regions, viewing history is the foundation of collaboration.

**Time Allotment**: 35 minutes

**Topics Covered**:

- Viewing commit history with `git log`
- Understanding commit metadata (author, date, message)
- Viewing changes per commit with `git diff`
- Using `git blame` to find who changed what
- Searching commit history effectively
- Global team benefits of good history

---

## Understanding Commit History

Every commit Git makes is a permanent record. It contains:

- **What changed** (the actual code modifications)
- **Who changed it** (author information)
- **When it changed** (timestamp)
- **Why it changed** (commit message)
- **Where it came from** (parent commit)

Think of it as a detailed ledger—like the village records Neri maintains in San Juan Digital Payment System, but for code. Each entry links to the previous one, creating an unbreakable chain of custody.

## The git log Command

The most basic way to see history:

```bash
# View simple commit list (newest first)
git log

# Exit the log viewer: press 'q'
```

This shows:

- Commit hash (the unique ID)
- Author and email
- Date
- Commit message

### More Useful Formats

```bash
# One line per commit (perfect for getting overview)
git log --oneline

# Shows what files changed in each commit
git log --name-status

# Graph view showing branches (useful for branching work)
git log --graph --oneline --all

# Last 10 commits only
git log -10

# Since a certain date
git log --since="2 weeks ago"
```

### Example Output (git log --oneline):

```
a3b5c92 Add voting results display feature
f8d2e14 Fix permission check in vote modifier
c2e91f3 Add multi-vote protection
b1a8f27 Initialize Barangay Blockchain Ledger
```

Maria can see her entire project history at a glance. The most recent commit is always at the top.

## Understanding What Changed: git diff

Commit hashes alone don't show what actually changed. Use `git diff` to see the differences:

```bash
# See changes in latest commit
git show HEAD

# Compare a specific commit to its parent
git show a3b5c92

# See diff between two commits
git diff a3b5c92 f8d2e14

# See what will be in next commit
git diff --staged
```

The output shows:

- Lines with `+` (added)
- Lines with `-` (removed)
- Lines with no marker (context)

**For Debugging:** This is how Maria can find when the voting display broke. She looks at commits after the feature was added, sees the exact lines that changed, and identifies the problematic change.

## Using git blame

Sometimes you need to know **who** changed a specific line and **why**.

```bash
# See author of each line
git blame filename.js

# See which commit introduced each line
git blame -L 10,20 filename.js    # Lines 10-20
```

Output example:

```
a3b5c92 (Maria Santos 2024-12-12) function displayResults() {
f8d2e14 (Dev Sam      2024-12-10)   const votes = this.votes;
```

This tells you:

- Line 1: Maria added the function on Dec 12
- Line 2: Dev Sam modified it on Dec 10

For global teams, `git blame` is the conversation starter: "Sam, I see you changed this line. What was the issue you were solving?" It's not blame in the accusatory sense—it's accountability and documentation.

## Searching History

With 100+ commits, finding the right one matters:

```bash
# Find commits with keyword in message
git log --grep="voting"

# Find commits that touched specific file
git log -- voting.js

# Find commits by specific author
git log --author="Maria"

# Find when a line was added (more advanced)
git log -S "voteCount++" -- voting.js
```

### Real-World Scenario

Dev Sam from Cebu deployed to production yesterday and voting results disappeared. Maria searches:

```bash
git log --since="yesterday" --oneline
```

She finds 4 commits from the last 24 hours. Then:

```bash
git log -S "displayResults" --oneline
```

This shows only commits that added or removed the `displayResults` function. Aha! One commit modified it. She digs deeper:

```bash
git show a3b5c92
```

She sees the exact change. Three lines were deleted. That's the bug.

## Why This Matters for Global Deployment

**Manila → Cebu → Davao → Singapore → London**

When the Barangay Blockchain Ledger deployed to Singapore servers, something broke. The Singapore developer who wasn't on the original team can run:

```bash
git log --oneline
git show [commit-hash]
git blame critical-feature.js
```

Without leaving their desk in Singapore, they can understand the entire history of any file, see exactly what changed when, and contact Maria in Manila for context.

This is the magic of Git for distributed teams: **the code carries its own story**. Every change is documented, searchable, and traceable. Whether you're debugging a production issue at 3 AM or onboarding a new developer to the team, history is your reliable guide.

---

## Key Takeaways

✓ `git log` shows your commit history
✓ `git show` and `git diff` reveal what changed
✓ `git blame` answers "who changed this and why"
✓ History searches help you find specific changes quickly
✓ Good history is a team asset, not just a technical feature

**Next Lesson:** We'll learn how to **undo changes** safely when we discover bugs in our history. Maria's debugging investigation will teach us three powerful undo strategies.

```bash
# Example Git commands
```

### Summary

This lesson covers Viewing History in detail.

---

**Ready for the activity? Let's get started!**
