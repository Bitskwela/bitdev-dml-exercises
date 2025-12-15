# Le 03: Staging & Committing

![Staging Area](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-staging.png)

## Background Story

_Maria has three new features ready: a discount calculator, a transaction logger, and a payment confirmation email. She's made changes to five files. But she doesn't want to commit everything at once—the discount calculator is ready, but the email feature still has bugs._

_"I can only commit the discount features?" she asks._

_"Exactly," Marco explains. "With Git staging, you choose which changes to include in each commit. It's like selecting which vegetables to add to your dish."_

**Time Allotment**: 35 minutes

**Topics Covered**: Staging area, commits, commit messages, snapshots, history

---

## The Staging Area: Git's Gatekeeper

Before every commit, Git has a **staging area** (also called the "index"). Think of it as a waiting room:

1. You modify files in your **working directory**
2. You select which changes to **stage** (add to staging area)
3. You **commit** the staged changes

### Why Staging?

Real-world development is messy:

- You fix a bug in `auth.js`
- You add a new feature in `ui.js`
- You optimize database queries in `db.js`
- But only the bug fix is ready to ship

With staging, you can:

- Commit the bug fix immediately
- Continue working on features in separate commits
- Keep your commit history clean and logical

## The Commit Command

```bash
git add <file>           # Stage specific file
git add .                # Stage all changes
git commit -m "message"  # Create a commit
```

### Commit Messages Matter

A good commit message:

- Starts with a verb: "Add", "Fix", "Update", "Remove"
- Is clear and specific
- Explains WHY, not just WHAT

#### Good Messages

```
Add discount calculation to payment processor
Fix null pointer exception in user authentication
Update database schema for international payments
```

#### Bad Messages

```
Fixed stuff
Update
Work in progress
```

## The Three-Step Workflow

```
1. MODIFY (Working Directory)
   └─→ Edit your files freely

2. STAGE (Staging Area)
   └─→ git add file.js
   └─→ Select what goes in the commit

3. COMMIT (Repository)
   └─→ git commit -m "message"
   └─→ Create permanent record
```

## Viewing Changes Before Committing

```bash
git status              # See what's modified
git diff                # See exact changes
git diff --staged       # See staged changes
```

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
