# Le 18: Collaboration Mini-Project

![Team Collaboration](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-collaboration.png)

## Background Story

It's demo day. Neri from the Barangay Council has scheduled a presentation for Friday. The team has one week to deliver three features for the Barangay Blockchain:

1. **Voter Registration** (Maria, Manila)
2. **Vote Casting** (Dev Sam, Cebu)
3. **Vote Counting** (London Developer)

Marco coordinates from Cebu: "This is our first real collaboration sprint. Everyone works on separate features simultaneously. We merge on Thursday. Demo on Friday."

Monday morning, all three developers fork the same starting point and begin working. By Wednesday, they have three feature branches with dozens of commits. On Thursday, the merge begins.

Conflicts appear. Pull requests need review. A critical bug surfaces. Someone's commit message is unclear. The CI pipeline fails.

This is real team collaboration—messy, challenging, and ultimately successful because the team knows Git.

**Time Allotment**: 90-120 minutes (Mini-project)

**Topics Covered**:

- End-to-end collaboration workflow
- Parallel feature development
- Merge coordination
- Conflict resolution under pressure
- Code review in practice
- Release preparation

---

## Project Setup: The Scenario

You'll simulate a week of team collaboration, compressing it into one practice session.

### The Repository Structure

```
barangay-blockchain/
├── contracts/
│   └── Voting.sol
├── src/
│   ├── voter.js
│   ├── ballot.js
│   └── counter.js
├── tests/
│   └── voting.test.js
├── README.md
└── package.json
```

### The Team

| Developer  | Location | Feature            | Branch                       |
| ---------- | -------- | ------------------ | ---------------------------- |
| Maria      | Manila   | Voter Registration | `feature/voter-registration` |
| Dev Sam    | Cebu     | Vote Casting       | `feature/vote-casting`       |
| London Dev | London   | Vote Counting      | `feature/vote-counting`      |
| Marco      | Cebu     | Coordination       | Reviews PRs, manages main    |

### The Timeline

```
Day 1 (Monday):    Create branches, start development
Day 2 (Tuesday):   Continue development, first pushes
Day 3 (Wednesday): Complete features, open PRs
Day 4 (Thursday):  Code review, resolve conflicts, merge
Day 5 (Friday):    Final testing, demo to Neri
```

---

## Phase 1: Setup (Day 1)

### Everyone Clones the Repository

```bash
# Each developer clones
git clone https://github.com/bitskwela/barangay-blockchain.git
cd barangay-blockchain
```

### Create Feature Branches

```bash
# Maria creates her branch
git checkout -b feature/voter-registration
git push -u origin feature/voter-registration

# Dev Sam creates his branch
git checkout -b feature/vote-casting
git push -u origin feature/vote-casting

# London creates their branch
git checkout -b feature/vote-counting
git push -u origin feature/vote-counting
```

### Establish Baseline

```bash
# Everyone syncs and confirms starting point
git fetch origin
git log --oneline -5
# All see same starting commits
```

---

## Phase 2: Parallel Development (Days 1-2)

### Maria Develops Voter Registration

```bash
# Maria's work
git checkout feature/voter-registration

# Day 1: Initial structure
echo "// Voter Registration Module" > src/voter.js
git add src/voter.js
git commit -m "feat(voter): add registration module structure"

# Add registration logic
# ... writes code ...
git add -A
git commit -m "feat(voter): implement registerVoter function"

# Add validation
git commit -m "feat(voter): add voter validation rules"

# Push end of day
git push origin feature/voter-registration
```

### Dev Sam Develops Vote Casting

```bash
# Dev Sam's work
git checkout feature/vote-casting

# Day 1: Ballot structure
git commit -m "feat(ballot): add ballot casting module"

# Day 2: Core logic
git commit -m "feat(ballot): implement castVote function"
git commit -m "feat(ballot): add vote validation"
git commit -m "test(ballot): add casting tests"

# Push
git push origin feature/vote-casting
```

### London Develops Vote Counting

```bash
# London's work
git checkout feature/vote-counting

git commit -m "feat(counter): add vote counting module"
git commit -m "feat(counter): implement tallyVotes function"
git commit -m "feat(counter): add winner determination"

git push origin feature/vote-counting
```

---

## Phase 3: Pull Requests (Day 3)

### Maria Opens First PR

```markdown
# Pull Request: Voter Registration

## Summary

Implements voter registration for the Barangay Blockchain.

## Changes

- Add `src/voter.js` with registration logic
- Add validation for voter eligibility
- Add duplicate detection
- Add 5 unit tests

## Testing

- All tests pass locally
- Manual testing complete

## Ready for review: @marco @devsam
```

### Review Comments

```
Marco: Looking good! One concern - line 45 doesn't handle
       the case where the voter is already registered.

Dev Sam: Nice work Maria! Can you add a comment explaining
         the age validation logic?

Maria: Fixed in new commits. Please re-review.

Marco: ✅ Approved
Dev Sam: ✅ Approved
```

---

## Phase 4: The Merge Challenge (Day 4)

### First Merge: Voter Registration

```bash
# Marco merges Maria's PR (clean merge)
# Click "Merge Pull Request" on GitHub
# main now has voter registration
```

### Second Merge: Vote Casting (Conflict!)

When Dev Sam's PR tries to merge, a conflict appears:

```bash
CONFLICT (content): Merge conflict in src/index.js
```

Both Maria and Dev Sam modified `src/index.js` to add their imports.

**Maria's version:**

```javascript
import { registerVoter } from "./voter.js";
```

**Dev Sam's version:**

```javascript
import { castVote } from "./ballot.js";
```

**Resolution:**

```javascript
import { registerVoter } from "./voter.js";
import { castVote } from "./ballot.js";
```

```bash
# Dev Sam resolves locally
git checkout feature/vote-casting
git fetch origin
git merge origin/main
# CONFLICT appears

# Fix the conflict
nano src/index.js  # Keep both imports

git add src/index.js
git commit -m "Merge main, resolve import conflict"
git push origin feature/vote-casting

# PR updates, Marco re-reviews, approves, merges
```

### Third Merge: Vote Counting (Another Conflict!)

London's branch also conflicts on `index.js`:

```bash
# London updates branch
git checkout feature/vote-counting
git fetch origin
git merge origin/main
# CONFLICT!

# This time there are two existing imports, add third
nano src/index.js
```

**Final index.js:**

```javascript
import { registerVoter } from "./voter.js";
import { castVote } from "./ballot.js";
import { tallyVotes } from "./counter.js";
```

```bash
git add src/index.js
git commit -m "Merge main, add counting import"
git push origin feature/vote-counting

# PR merges successfully
```

---

## Phase 5: Integration Testing (Day 4-5)

### Verify All Features Work Together

```bash
# Everyone pulls final main
git checkout main
git pull origin main

# Run full test suite
npm test

# Output:
# ✅ voter.test.js - 5 passed
# ✅ ballot.test.js - 4 passed
# ✅ counter.test.js - 3 passed
# All 12 tests passing!
```

### Bug Discovery!

Dev Sam finds a bug: when voting is cast before registration completes, the system crashes.

```bash
# Create hotfix branch
git checkout -b hotfix/vote-before-register

# Fix the bug
nano src/ballot.js
git add src/ballot.js
git commit -m "fix(ballot): check registration before casting"

# PR, quick review, merge
git push origin hotfix/vote-before-register
# Marco fast-tracks the review
```

---

## Phase 6: Release Preparation (Day 5)

### Create Release Tag

```bash
git checkout main
git pull origin main

# Tag the release
git tag -a v1.0.0 -m "Release 1.0.0: Voting system MVP"
git push origin v1.0.0
```

### Final Verification

```bash
# Verify clean state
git log --oneline -10
# See all merged features

git status
# Clean working directory

npm test
# All tests pass
```

---

## The Demo (Friday)

Maria presents to Neri:

"We built three features this week: voter registration, vote casting, and vote counting. Three developers worked simultaneously across Manila, Cebu, and London. We used branches to isolate our work, pull requests for code review, and resolved conflicts when our code overlapped."

Neri asks: "What if something goes wrong after you deploy?"

Marco explains: "Every change is tracked. We can see exactly what changed, who changed it, and why. If something breaks, we can revert to the previous working version in seconds."

Neri nods: "This is what professional software development looks like. Good work, team."

---

## What You Learned

This mini-project practiced:

1. **Branch Creation**: Each developer on their own branch
2. **Parallel Development**: Working simultaneously without interference
3. **Regular Pushing**: Backing up work to remote
4. **Pull Requests**: Formal review before merging
5. **Conflict Resolution**: When branches modify same files
6. **Integration**: Merging multiple features to main
7. **Hotfixes**: Quick fixes after integration
8. **Tagging**: Marking releases for deployment

## Key Takeaways

✓ Real collaboration involves parallel work and merges
✓ Conflicts are normal—resolve them, don't fear them
✓ Pull requests catch bugs before they reach main
✓ Communication matters: know what others are working on
✓ Tag releases to mark deployable versions
✓ Hotfixes follow the same workflow (branch, PR, merge)
✓ Global teams do this daily—you can too

**Next Lesson:** Advanced Git techniques begin. First up: Rebasing—rewriting history for cleaner commits.
