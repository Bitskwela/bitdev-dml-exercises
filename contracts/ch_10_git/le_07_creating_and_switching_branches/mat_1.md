# Le 07: Creating and Switching Branches – Your First Independent Workspace

![Branch Commands](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-branch-commands.png)

## Scene: Maria's First Branch

**Monday 9 AM, Manila. Maria is ready to start her four-day refactor.**

She opens her terminal. Her hands hover over the keyboard.

"What do I do?" she asks Marco, who's in the seat next to her.

"Create a branch," he says. "A separate workspace, just for your refactor. The main branch stays untouched. When you're done and tested, we merge."

"How?"

"One command."

Maria types:

```bash
git branch feature/permission-refactor
```

It completes instantly. Nothing visible happens. No files changed. No folders created.

"That's it?" Maria asks.

"That's it," Marco confirms. "You just created a pointer. Now switch to it."

She types:

```bash
git switch feature/permission-refactor
```

She's now on her own branch. The files look identical to main because they started at the same place. But now, anything she changes is isolated to this branch.

**This moment—creating and switching to a branch—is where individual developers become a coordinated team.**

For the next four days, Maria can refactor without fear. Marco can work on voting display without conflicts. Sam in Cebu can start payment integration without waiting. Three developers, three branches, full parallelization.

**Time Allotment**: 30 minutes

**Topics Covered**:

- Creating branches with `git branch` (the foundation command)
- Switching branches with `git switch` (move between workspaces)
- Creating and switching in one command (the shortcut professionals use)
- Understanding branch independence (how files change when switching)
- Seeing branches exist independently (each with their own state)

---

## Creating Branches

Create a branch pointing to your current commit:

```bash
git branch feature/voting
```

This creates a new pointer. The branch exists locally until you push it (lesson 14).

### More Options

```bash
# Create branch from a specific commit
git branch feature/voting abc123

# List all branches
git branch

# List with details
git branch -v

# Delete a branch
git branch -d feature/voting     # Safe delete (won't delete unmerged work)
git branch -D feature/voting     # Force delete
```

## Switching Branches

Once you create a branch, you need to switch to it (change HEAD):

```bash
# Old way (still works, but being phased out)
git checkout feature/voting

# New way (recommended)
git switch feature/voting
```

When you switch branches, Git updates your working directory to match that branch's current commit. Files change.

### The Magic of Switching

Maria's scenario:

```bash
# She's on main, voting.js is the original version
cat voting.js
# Output: original code

# Create and switch to her branch
git switch -c feature/voting

# She modifies voting.js heavily
echo "new voting code" > voting.js
git add voting.js
git commit -m "Add voting protection"

# Her branch is ahead
feature/voting → [commit with new voting.js]
main           → [commit with original voting.js]

# She switches back to main
git switch main

# Watch the magic
cat voting.js
# Output: original code (voting.js reverted!)

# Back to feature branch
git switch feature/voting
cat voting.js
# Output: new voting code (returns!)
```

This is the power: each branch has its own state. When you switch, Git changes your files to match that branch's state.

## Create and Switch in One Command

The `-c` flag (or `-b` in old `git checkout`) does both:

```bash
# This creates the branch AND switches to it
git switch -c feature/voting

# Or the old syntax
git checkout -b feature/voting
```

Most developers use this shortcut.

## Real-World Scenario

Three developers, three features, one morning:

```bash
# Maria in Manila
git switch -c feature/voting-protection
# Now she's on her branch, main is untouched

# Marco (in the same office)
git switch -c feature/permission-refactor
# Now he's on his branch, main is still untouched

# Dev Sam in Cebu (different computer, same repository)
git switch -c feature/payment-integration
# Now he's on his branch

# All three branches exist
git branch -a
# Output:
#   feature/voting-protection
#   feature/permission-refactor
#   feature/payment-integration
#   main

# Each developer works on their branch
# None interfere with each other
# None interfere with main
```

## Understanding Branch Independence

When Maria is on `feature/voting-protection`:

- Her commits don't go to `main`
- Her commits don't go to Marco's `feature/permission-refactor`
- Marco's work is invisible to her until he merges

This independence is crucial. Maria can experiment, add 10 commits, delete them all, and `main` is unaffected. Marco never sees those experiments. Only when Maria is satisfied and merges does `main` change.

## Why This Matters for Global Deployment

**Scenario: Barangay Blockchain update needed across 4 regions**

1. **Manila (Maria)** - `git switch -c feature/voting-results`

   - Works all day Monday in her branch
   - Commits 5 times
   - main untouched

2. **Singapore (Dev A)** - `git switch -c feature/audit-logging`

   - Pulls `main` (which is still unchanged)
   - Works in parallel
   - Commits 3 times
   - main untouched

3. **Cebu (Dev Sam)** - `git switch -c feature/payment-sync`

   - Pulls `main` (which is still unchanged)
   - Works simultaneously
   - Commits 7 times
   - main untouched

4. **By Wednesday**
   - All three are done
   - All three merge to `main`
   - `main` is deployed worldwide
   - Three features deployed simultaneously

Without branches, they'd work sequentially. With branches, they work in parallel. For global teams spanning time zones, this is the difference between weeks and days.

## Key Takeaways

✓ `git switch -c branch-name` creates and switches to a branch
✓ `git switch branch-name` switches to existing branch
✓ Each branch has its own state; files change when switching
✓ Work on one branch doesn't affect main until you merge
✓ Branch independence enables parallel development
✓ Three developers can work simultaneously on different branches

**Next Lesson:** The branches are created and work is happening. Now we merge—combining branches back together when the work is done.

```bash
# Example Git commands
```

### Summary

This lesson covers Creating and Switching Branches in detail.

---

**Ready for the activity? Let's get started!**
