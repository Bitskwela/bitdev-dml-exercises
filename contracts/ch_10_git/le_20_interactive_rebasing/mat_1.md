# Le 20: Interactive Rebase

![Interactive Rebase](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-interactive-rebase.png)

## Scene: Cleaning House

**Three days later. Maria is ready to open her Pull Request for voter analytics.**

She checks her commit history one last time:

```bash
$ git log --oneline -7
a1b2c3d WIP
c4d5e6f fix
g7h8i9j typo
k1l2m3n Add chart.js
o4p5q6r Work on charts
s7t8u9v Started analytics feature
w1x2y3z Initial commit
```

She sighs heavily. "I can't submit this. It's seven commits. Half of them say 'WIP' or 'fix'. It tells the story of my mistakes, not my accomplishment."

Marco shows her something powerful: "Interactive rebase. You can combine those seven commits into one. Or two. You can reorder them. You can rewrite commit messages. You have complete control over your history _before_ you submit to the team."

"I can erase my mistakes?"

"Not erase—refactor. You keep the code. You just rewrite the story of how you got there."

Thirty minutes later, Maria's history is transformed:

```bash
$ git log --oneline -1
a1b2c3d Add voter analytics with Chart.js visualization
```

One commit. Clear message. Professional history. The story of her work—not the story of her struggling to get it right.

"Now submit the PR," Marco says. "When Dev Sam and London review your code, they won't be distracted by 'WIP' and 'typo' commits. They'll see one clean feature."

**This lesson teaches that history is a communication tool. Interactive rebase lets developers tell the right story about their work.**

**Time Allotment**: 50 minutes

**Topics Covered**:

- What interactive rebase is
- The rebase editor and commands
- Squashing commits
- Reordering commits
- Editing commit messages
- When to use interactive rebase

---

## What is Interactive Rebase?

Interactive rebase (`git rebase -i`) opens an editor where you control what happens to each commit. You can:

- **pick**: Keep the commit as-is
- **squash**: Combine with previous commit
- **fixup**: Like squash, but discard commit message
- **reword**: Change the commit message
- **edit**: Pause to amend the commit
- **drop**: Delete the commit entirely

## Starting Interactive Rebase

```bash
# Rebase the last 5 commits
git rebase -i HEAD~5

# Or rebase from a specific commit
git rebase -i abc1234

# Or rebase onto main
git rebase -i main
```

## The Rebase Editor

When you run `git rebase -i HEAD~5`, an editor opens:

```
pick s7t8u9v Started analytics feature
pick o4p5q6r Work on charts
pick k1l2m3n Add chart.js
pick g7h8i9j typo
pick c4d5e6f fix
pick a1b2c3d WIP

# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# d, drop = remove commit
```

## Squashing Commits

Maria wants to combine all her commits into one:

```
pick s7t8u9v Started analytics feature
squash o4p5q6r Work on charts
squash k1l2m3n Add chart.js
squash g7h8i9j typo
squash c4d5e6f fix
squash a1b2c3d WIP
```

Save and close. Another editor opens to write the combined commit message:

```
Add voter analytics with Chart.js visualization

- Set up analytics module structure
- Integrated Chart.js for visualizations
- Added real-time vote tracking charts
- Added voter participation statistics
```

Result: One clean commit instead of seven messy ones.

## Practical Example: Cleaning Up Before PR

```bash
# Maria's workflow
git log --oneline -7
# See the messy commits

git rebase -i HEAD~7
# Editor opens

# Change to:
pick s7t8u9v Started analytics feature
fixup o4p5q6r Work on charts
fixup k1l2m3n Add chart.js
fixup g7h8i9j typo
fixup c4d5e6f fix
fixup a1b2c3d WIP

# Save and close
# All commits squashed, original message kept

# Force push (history changed)
git push --force-with-lease origin feature/voter-analytics
```

## Reordering Commits

You can change the order of commits by moving lines:

**Before:**

```
pick a1b2c3d Add feature A
pick b2c3d4e Add feature B
pick c3d4e5f Fix feature A bug
```

**After reordering:**

```
pick a1b2c3d Add feature A
pick c3d4e5f Fix feature A bug
pick b2c3d4e Add feature B
```

Now the bug fix is right after the feature it fixes.

## Rewording Commit Messages

To change a commit message without changing content:

```
reword s7t8u9v bad message
pick o4p5q6r Keep this
pick k1l2m3n Keep this
```

When Git reaches the `reword` commit, it opens an editor for the new message.

## Editing Commits

To pause and modify a commit:

```
edit s7t8u9v Need to add a file here
pick o4p5q6r Continue
```

Git stops at that commit. You can:

```bash
# Add a forgotten file
git add forgotten-file.js
git commit --amend

# Continue rebasing
git rebase --continue
```

## Dropping Commits

To delete a commit entirely:

```
pick s7t8u9v Keep this
drop o4p5q6r Delete this completely
pick k1l2m3n Keep this
```

Be careful—the commit's changes will be lost.

## Real-World Scenario: Dev Sam's PR Cleanup

Dev Sam has been working on payment processing for a week:

```bash
$ git log --oneline -10
a1 debug logging
b2 remove debug
c3 fix tests
d4 tests broken again
e5 finally fixed tests
f6 Add payment validation
g7 WIP
h8 Add payment module
i9 Setup
j0 Initial payment work
```

Nobody wants to review this. Dev Sam uses interactive rebase:

```bash
git rebase -i HEAD~10
```

```
pick j0 Initial payment work
squash i9 Setup
squash h8 Add payment module
squash g7 WIP
pick f6 Add payment validation
fixup c3 fix tests
fixup d4 tests broken again
fixup e5 finally fixed tests
drop a1 debug logging
drop b2 remove debug
```

Result:

```
$ git log --oneline -2
f6' Add payment validation with tests
j0' Implement payment module
```

Clean, professional, reviewable.

## Why This Matters for Global Deployment

When London reviews Maria's PR at 9 AM London time (5 PM Manila), they see:

**Messy history:**

```
"WIP", "fix", "typo", "work"...
What changed? I have to read every file diff.
```

**Clean history:**

```
"Add voter analytics with Chart.js visualization"
One commit, clear description, easy to review.
```

Clean history = faster reviews = faster deployments = happy global team.

## Safety Rules

1. **Only rebase unpushed commits** (or your own feature branch)
2. **Never rebase shared branches** (main, develop)
3. **Communicate with team** if rebasing pushed feature branch
4. **Use `--force-with-lease`** instead of `--force` for safety

```bash
# Safer than --force
git push --force-with-lease origin feature/my-branch
```

## Key Takeaways

✓ Interactive rebase gives complete control over commit history
✓ Squash combines multiple commits into one
✓ Fixup squashes but keeps first commit's message
✓ Reword changes commit messages
✓ Edit pauses to modify commits
✓ Drop deletes commits
✓ Clean history helps code reviews
✓ Only rebase your own unpushed/feature branches

**Next Lesson:** Cherry-pick—apply specific commits from one branch to another.
