# Le 09: Handling Merge Conflicts – When Teams Disagree

![Merge Conflict Resolution](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-conflict.png)

## Scene: Two Developers, One Problem

**Thursday morning, Manila. Maria and Marco are racing.**

Neri called an emergency meeting. Voting system is experiencing occasional incorrect counts. The bug must be fixed today. Deploy tonight to all four regions.

Maria and Marco decide to work in parallel for speed. A risky move, but necessary.

Maria creates `feature/voting-count-fix` and modifies the vote counting logic. She uses a simple `length` approach.

Marco creates `feature/voting-validation` and modifies the same vote counting logic. He uses an iterative counting approach.

By 2 PM, Maria is confident. She merges to main:
```bash
git switch main
git merge feature/voting-count-fix
# Success: Fast-forward 3 commits
```

Marco is confident. He merges to main:
```bash
git switch main  
git merge feature/voting-validation
# ERROR: CONFLICT in voting.js
```

Git stops. It can't automatically decide whose approach is correct. Both versions modify the same lines. Human judgment required.

Marco stares at the error. His stomach drops.

Maria sees him freeze. "What happened?"

"Merge conflict," Marco says quietly.

"That's... bad?"

"Not bad. Just requires decisions."

**This lesson teaches that merge conflicts aren't failures—they're decisions. And decisions require conversation.**

**Time Allotment**: 40 minutes

**Topics Covered**:

- What causes merge conflicts (two branches modifying the same location)
- Conflict markers and what they mean (Git showing both versions)
- Resolving conflicts manually (reading both solutions, choosing carefully)
- Using merge tools (when visual resolution helps)
- Aborting merges (backing out without committing)
- Preventing conflicts through communication (why teamwork prevents merge hell)

---

## What Causes Merge Conflicts?

A merge conflict happens when:

1. Two branches modify the same file
2. In the same location (overlapping lines)
3. In different ways

Git can't automatically decide which version is right. It needs human judgment.

## Conflict Markers

When Git encounters a conflict:

```javascript
function countVotes() {
<<<<<<< HEAD
  return this.votes.length;  // Your version
=======
  let count = 0;             // Their version
  for (let vote of this.votes) count++;
  return count;
>>>>>>> feature/voting-display
}
```

## Resolving Conflicts

### Option 1: Keep Your Version

```javascript
function countVotes() {
  return this.votes.length;
}
```

### Option 2: Keep Incoming Version

```javascript
function countVotes() {
  let count = 0;
  for (let vote of this.votes) count++;
  return count;
}
```

### Option 3: Combine Both

```javascript
function countVotes() {
  const approach1 = this.votes.length;
  const approach2 = this.votes.filter((v) => v).length;
  return Math.max(approach1, approach2);
}
```

## The Resolution Process

```bash
# Try to merge
git merge feature/voting-display
# Output: CONFLICT in voting.js

# Git stops and waits
git status

# Open and edit the file, remove conflict markers
nano voting.js

# Mark as resolved
git add voting.js

# Complete the merge
git commit -m "Merge feature/voting-display, resolve voting.js conflict"
```

## Why This Matters for Global Deployment

Singapore developer (6 hours ahead) merges to main at 9 AM Singapore time.
Manila developer (sleeping) tries to merge next morning, hits conflict.

With time zones, conflicts are inevitable. The solution isn't to avoid them—it's to resolve them professionally:

1. Stay calm
2. Communicate with the other developer
3. Make a joint decision
4. Document the decision
5. Move forward

Global teams that handle conflicts well deploy faster than teams that avoid them.

## Key Takeaways

✓ Conflicts happen when two branches modify same location
✓ Conflict markers show both versions
✓ Resolution requires human judgment
✓ Conflicts aren't disasters; they're decisions
✓ Communicate with teammates when resolving
✓ Document decisions in commit messages
✓ Global teams expect conflicts; good process handles them

**Next Lesson:** Now you understand branches and merging. Let's talk about team workflows—how professional teams organize branching to prevent conflicts and move fast.

```bash
# Example Git commands
```

### Summary

This lesson covers Handling Merge Conflicts in detail.

---

**Ready for the activity? Let's get started!**
