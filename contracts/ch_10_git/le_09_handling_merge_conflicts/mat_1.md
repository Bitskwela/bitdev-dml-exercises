# Le 09: Handling Merge Conflicts

![Merge Conflict Resolution](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-conflict.png)

## Background Story

Thursday. Maria and Marco decided to work on the same feature simultaneously for speed. Bad decision.

Maria created `feature/voting-refactor` and changed how votes are counted.
Marco created `feature/voting-display` and changed how votes are counted too.

When Maria merged first, main updated. When Marco tried to merge, Git stopped: "I can't merge this. You both changed the same lines in voting.js. I don't know which version is right."

"This is a merge conflict," Marco says calmly. "It happens. The important thing is not to panic. Git is asking us to make a decision."

Maria and Marco look at both versions. They discuss. They decide to take Maria's approach but with Marco's safety check. They manually edit the file, remove the conflict markers, and complete the merge.

"This is why we communicate," Neri observes. "Code isn't just code—it's decisions. When two decisions conflict, humans must decide."

What they learn today is that merge conflicts are manageable and reveal when teams need better communication.

**Time Allotment**: 40 minutes

**Topics Covered**:

- What causes merge conflicts
- Conflict markers and what they mean
- Resolving conflicts manually
- Using merge tools
- Aborting merges
- Preventing conflicts through communication

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
