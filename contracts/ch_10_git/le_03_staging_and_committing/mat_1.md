# Staging and Committing

![1.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_10_git/le_03_staging_and_committing/1.0%20-%20COVER.png)

## Scene: Selective Commitment

**Three days into the Barangay Blockchain project. Maria's been coding since 6 AM.**

She's made changes across five different files:

- Fixed a bug in the discount calculator ✓ (tested, working)
- Added transaction logging logic ✓ (complete, reviewed mentally)
- Started email notification feature ✗ (has bugs, incomplete)
- Updated database schema ✓ (ready, careful work)
- Refactored payment processing ✗ (halfway done, needs thought)

She saves all the files. Now she looks at her working directory, feeling overwhelmed.

She messages Marco on Slack: "Do I have to commit everything at once? Some of these are finished and working. Others aren't ready yet. If I push now, I'll deploy broken code."

Marco replies instantly: "That's exactly what the staging area is for. You get to choose which changes go into each commit. You're not locked into 'all or nothing.'"

**This moment—realizing you can be selective—is when developers begin to understand Git's true power: precision. Not all changes are equal. Some are ready, others need more work. Git lets you control exactly what gets committed.**

## The Staging Area: Your Gatekeeper

![1.1 - STAGING WORKFLOW](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_10_git/le_03_staging_and_committing/1.1.png)

### Three Spaces, Three States

Git divides your work into three locations:

1. **Working Directory**: Your actual files on disk (where you edit code)
2. **Staging Area**: Files you've marked for the next commit (your selection)
3. **Repository**: Permanent snapshots stored in `.git` (immutable history)

### The Staging Area Workflow

```
Modified Files (Working Directory)
    ↓
    └→ git add <file>  (Stage specific file)
    └→ git add .       (Stage all changes)
    ↓
Staging Area (Ready for commit)
    ↓
    └→ git commit -m "message"
    ↓
Repository (Permanent history)
```

This middle step—staging—gives you control. You can make changes to 5 files but only commit 2 of them.

### Why Staging Matters

Real development is messy:

- Maria fixes a payment bug in one file
- She adds a feature in another file
- She starts a refactor in a third file
- Only the bug fix is tested and ready

Without staging, she'd have to choose: commit everything (risky—untested code) or commit nothing (loses work).

With staging, she commits the bug fix alone. The other changes stay in her working directory, ready for more work.

## Meaningful Commits: The Art

> A **commit** is a snapshot of your project at one moment in time, with a message explaining the "why."

### Good Commit Messages

A good message tells the _story_ of what changed and _why_:

```bash
Add discount calculation to payment processor
```

Why is this better than "Fix bugs" or "Work in progress"?

- **Specific**: You know exactly what changed
- **Actionable**: Future developers understand the intent
- **Searchable**: You can find it in history
- **Reviewable**: Team members know what to check

### The Commit Message Formula

```
<verb> <what> <why/detail>

Examples:
Add discount calculation to marketplace payment processor
Fix null pointer exception in user authentication
Update database schema to support international transactions
Remove deprecated payment API from legacy code
```

### Real-World Example from Maria's Work

**Bad**:

```bash
git commit -m "updated stuff"
git commit -m "fix"
git commit -m "changes"
```

**Good**:

```bash
git commit -m "Add transaction logging for audit trail"
git commit -m "Fix discount calculation rounding error"
git commit -m "Update database schema for multi-currency support"
```

The good version tells the _story_. Six months later, when there's a bug in discount logic, developers can read the message and understand the original thinking.

## The Three-Step Workflow

Every time you commit, you follow three steps:

### Step 1: Modify (Working Directory)

You edit files freely. No Git restrictions. Just code.

### Step 2: Stage (Staging Area)

You decide which files go into this commit:

```bash
git add discount-calculator.py    # Add this file
git add payment-processor.py      # Add this file
# transaction-logger.py stays unstaged—not ready yet
```

### Step 3: Commit (Repository)

You create a permanent snapshot with a message:

```bash
git commit -m "Add discount calculator to marketplace"
```

This is now permanent history. Forever in your repository.

## Why Granular Commits Matter

When you make small, focused commits:

- **Easy to review**: Each commit is one logical change
- **Easy to debug**: If something breaks, you know which commit caused it
- **Easy to revert**: If a feature doesn't work out, revert that one commit
- **Easy to understand**: History becomes a story, not a mystery

---

**Ready to practice staging and committing? Let's create meaningful snapshots!**
└─→ git add file.js
└─→ Select what goes in the commit

3. COMMIT (Repository)
   └─→ git commit -m "message"
   └─→ Create permanent record

````

## Viewing Changes Before Committing

```bash
git status              # See what's modified
git diff                # See exact changes
git diff --staged       # See staged changes
````

## The Power of Granular Commits

Instead of one giant commit:

```
"Fixed auth, added payments, updated UI, optimized DB"
```

Use focused commits:

```
1. "Fix authentication token expiration"
2. "Add payment processing with discount support"
3. "Update UI for payment confirmation"
4. "Optimize database queries for user lookup"
```

Each commit tells a story. Each commit can be reviewed, rolled back, or deployed independently.

## Beyond the Islands

When you deploy your app globally:

- Your team in Manila can review your commits
- Your team in Singapore can understand your changes
- When bugs appear, you can pinpoint exactly which commit caused them
- You can deploy individual commits to different regions
